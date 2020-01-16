import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/timelines/Timelines_Dashboard.dart';
import 'package:eco_mfi/pages/workflow/Workflow_Grid_Dashboard.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:eco_mfi/pages/todo/home/HomeScreenTodo.dart';
import 'package:eco_mfi/pages/todo/home/side_drawer.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/models/Label.dart';
import 'package:eco_mfi/models/Project.dart';
import 'package:eco_mfi/models/Tasks.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDashboard extends StatefulWidget {


  HomeDashboard();

  @override
  HomeDashboardState createState() => new HomeDashboardState();
}

class HomeDashboardState extends State<HomeDashboard>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tasks> taskList = new List();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  String homeTitle = "Today";
  int taskStartTime, taskEndTime;
  Utility obj = new Utility();
  bool isNetworkAvailable=false;
  String companyName = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   checkIfNetwrkAval();
    _tabController = new TabController(vsync: this, initialIndex: 1, length: 3);
    var dateTime = new DateTime.now();
    taskStartTime = new DateTime(dateTime.year, dateTime.month, dateTime.day)
        .millisecondsSinceEpoch;
    taskEndTime =
        new DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59)
            .millisecondsSinceEpoch;
    updateTasks(taskStartTime, taskEndTime);
    getsharedPreferences();
  }


getsharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
  if (prefs.getString(TablesColumnFile.mCompanyName) != null &&
      prefs.getString(TablesColumnFile.mCompanyName).trim() != "")
    companyName = prefs.getString(TablesColumnFile.mCompanyName);
  });

}

  checkIfNetwrkAval()async{
    //isNetworkAvailable = await obj.checkIntCon();
    isNetworkAvailable = await Utility.checkIntCon();
    print("isNetworkAvailable "+isNetworkAvailable.toString());
    setState(() {

    });
  }

  void updateTasks(int taskStartTime, int taskEndTime) {
    AppDatabase.get()
        .getTasks(
            startDate: taskStartTime,
            endDate: taskEndTime,
            taskStatus: TaskStatus.PENDING)
        .then((tasks) {
      if (tasks == null) return;
      taskList.clear();
      taskList.addAll(tasks);
     /* setState(() {
        taskList.clear();
        taskList.addAll(tasks);
      });*/
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

  Future<bool> callDialog() {
    globals.Dialog.onWillPop(
        context, 'Are you sure?', 'Do you want to exit an App', 'Login');
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: callDialog,
      child: new Scaffold(
        key: _scaffoldHomeState,
        appBar: new AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.view_headline, color: Colors.white),
            onPressed: () => _scaffoldHomeState.currentState.openDrawer(),
          ),
          title: new Text(
            companyName,
            //'Saija Finance',
            style: new TextStyle(color: Colors.white,fontSize: 22.0),
          ),
          backgroundColor:  Color(0xff07426A),
          brightness: Brightness.light,
          elevation: 1.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: new Container(
              //color: Colors.white,
              child: new TabBar(
                controller: _tabController,
                indicatorColor: Colors.black,
                tabs: <Widget>[
                  new Tab(
                      //text: "Stat TimeLine",
                      icon: new Icon(
                    Icons.timeline,
                    color: Colors.white,
                    size: 22.0,
                  )),
                  new Tab(
                    icon: new Icon(
                      Icons.work,
                      color: Colors.white,
                      size: 22.0,
                    ),
                    //text: "Workflow",
                  ),
                  new Tab(
                    icon: new Icon(
                      Icons.access_alarm,
                      color: Colors.white,
                      size: 22.0,
                    ),
                    //text: "To-Do",
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            isNetworkAvailable?new Icon(
              Icons.network_cell,
              color: Colors.green,
            ):new Icon(
              Icons.network_locked,
              color: Colors.red,
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
            ),
            new Icon(
              Icons.notifications_none,
              color: Colors.white,
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
            ),
          ],
        ),
        body: new TabBarView(
          controller: _tabController,
          children: <Widget>[
        //    new SimpleLineChart.withSampleData(),
            new SimpleLineChart(),
            new WorkFlowGrid(),
            new HomeScreenTodo(),
          ],
        ),
        backgroundColor: Color(0xffeeeeee),
        drawer: new SideDrawer(
          projectSelection: (project) {
            updateTasksByProject(project);
          },
          labelSelection: (label) {
            updateTasksByLabel(label);
          },
          dateSelection: (startTime, endTime) {
            var dayInMillis = 86340000;
            homeTitle =
                endTime - startTime > dayInMillis ? "Next 7 Days" : "Today";
            taskStartTime = startTime;
            taskEndTime = endTime;
            updateTasks(startTime, endTime);
          },
        ),
      ),
    );
  }
}
