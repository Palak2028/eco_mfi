import 'package:flutter/material.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/models/Label.dart';
import 'package:eco_mfi/models/Project.dart';
import 'package:eco_mfi/models/Tasks.dart';
import 'package:eco_mfi/pages/todo/home/side_drawer.dart';
import 'package:eco_mfi/pages/todo/tasks/add_task.dart';
import 'package:eco_mfi/pages/todo/tasks/row_task.dart';
import 'package:eco_mfi/pages/todo/tasks/task_complted.dart';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/app_util.dart';

class HomeScreenTodo extends StatefulWidget {
  @override
  _HomeScreenTodoState createState() => new _HomeScreenTodoState();
}

class _HomeScreenTodoState extends State<HomeScreenTodo> {
  final List<Tasks> taskList = new List();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  String homeTitle = "Today";
  int taskStartTime, taskEndTime;

  @override
  void initState() {
    var dateTime = new DateTime.now();
    taskStartTime = new DateTime(dateTime.year, dateTime.month, dateTime.day)
        .millisecondsSinceEpoch;
    taskEndTime =
        new DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59)
            .millisecondsSinceEpoch;
    updateTasks(taskStartTime, taskEndTime);
    super.initState();
  }

  void updateTasks(int taskStartTime, int taskEndTime) {
    AppDatabase.get()
        .getTasks(
            startDate: taskStartTime,
            endDate: taskEndTime,
            taskStatus: TaskStatus.PENDING)
        .then((tasks) {
      if (tasks == null) return;
      setState(() {
        taskList.clear();
        taskList.addAll(tasks);
      });
    });
  }

  void updateTasksByProject(Project project) {
    AppDatabase.get().getTasksByProject(project.id).then((tasks) {
      if (tasks == null) return;
      setState(() {
        homeTitle = project.name;
        taskList.clear();
        taskList.addAll(tasks);
      });
    });
  }

  void updateTasksByLabel(Label label) {
    AppDatabase.get().getTasksByLabel(label.name).then((tasks) {
      if (tasks == null) return;
      setState(() {
        homeTitle = label.name;
        taskList.clear();
        taskList.addAll(tasks);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldHomeState,
      floatingActionButton: new FloatingActionButton(
        child: new Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        onPressed: () async {
          bool isDataChanged = await Navigator.push(
            context,
            new MaterialPageRoute<bool>(
                builder: (context) => new AddTaskScreen()),
          );

          if (isDataChanged) {
            updateTasks(taskStartTime, taskEndTime);
          }
        },
      ),
      body: new Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: taskList.length == 0
            ? emptyView("No Task Added")
            : new Container(
                child: new ListView.builder(
                    itemCount: taskList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new Dismissible(
                          key: new ObjectKey(taskList[index]),
                          onDismissed: (DismissDirection direction) {
                            var taskID = taskList[index].id;
                            setState(() {
                              taskList.removeAt(index);
                            });
                            if (direction == DismissDirection.endToStart) {
                              AppDatabase.get()
                                  .updateTaskStatus(taskID, TaskStatus.COMPLETE)
                                  .then((value) {
                                showSnackbar(_scaffoldHomeState,
                                    "Task mark as completed",
                                    materialColor: Colors.green);
                              });
                            } else {
                              AppDatabase.get()
                                  .deleteTask(taskID)
                                  .then((value) {
                                showSnackbar(_scaffoldHomeState, "Task Deleted",
                                    materialColor: Colors.red);
                              });
                            }
                          },
                          background: new Container(
                            color: Colors.red,
                            child: new ListTile(
                              leading:
                                  new Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                          secondaryBackground: new Container(
                            color: Colors.green,
                            child: new ListTile(
                              trailing:
                                  new Icon(Icons.check, color: Colors.white),
                            ),
                          ),
                          child: new TaskRow(taskList[index]));
                    }),
              ),
      ),
    );
  }

// This menu button widget updates a _selection field (of type WhyFarther,
// not shown here).
  Widget buildPopupMenu() {
    return new PopupMenuButton<MenuItem>(
      onSelected: (MenuItem result) async {
        switch (result) {
          case MenuItem.taskCompleted:
            bool isDataChanged = await Navigator.push(
              context,
              new MaterialPageRoute<bool>(
                  builder: (context) => new TaskCompletedScreen()),
            );
            updateTasks(taskStartTime, taskEndTime);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
            const PopupMenuItem<MenuItem>(
              value: MenuItem.taskCompleted,
              child: const Text('Complted Task'),
            )
          ],
    );
  }
}

// This is the type used by the popup menu below.
enum MenuItem { taskCompleted }
