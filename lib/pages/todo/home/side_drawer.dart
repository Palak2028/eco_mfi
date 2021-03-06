import 'dart:async';
import 'dart:convert';
import 'package:eco_mfi/pages/workflow/FPSPages/AgentBiometricRegistration.dart';
import 'package:eco_mfi/pages/workflow/PassChangeModule/ChangePassword.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/DeviceSetting.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/models/Label.dart';
import 'package:eco_mfi/models/Project.dart';
import 'package:eco_mfi/pages/todo/about/about_us.dart';
import 'package:eco_mfi/pages/todo/labels/add_label.dart';
import 'package:eco_mfi/pages/todo/projects/add_project.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;

class SideDrawer extends StatefulWidget {
  ProjectSelection projectSelection;
  LabelSelection labelSelection;
  DateSelection dateSelection;

  SideDrawer({this.projectSelection, this.labelSelection, this.dateSelection});

  @override
  _SideDrawerState createState() =>
      new _SideDrawerState(projectSelection, labelSelection, dateSelection);
}

class _SideDrawerState extends State<SideDrawer> {
  final List<Project> projectList = new List();
  final List<Label> labelList = new List();
  ProjectSelection projectSelectionListener;
  LabelSelection labelSelectionListener;
  DateSelection dateSelectionListener;
  String userName = "";
  String role = "";
  String loginTime = "";
  _SideDrawerState(this.projectSelectionListener, this.labelSelectionListener,
      this.dateSelectionListener);

  @override
  void initState() {
    super.initState();
    updateProjects();
    updateLabels();
    getSessionVariables();
  }

  void updateProjects() {
    AppDatabase.get().getProjects(isInboxVisible: false).then((projects) {
      if (projects != null) {
        setState(() {
          projectList.clear();
          projectList.addAll(projects);
        });
      }
    });
  }

  void updateLabels() {
    AppDatabase.get().getLabels().then((projects) {
      if (projects != null) {
        setState(() {
          labelList.clear();
          labelList.addAll(projects);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            decoration: new BoxDecoration(
              color: Color(0xff07426A),
            ),
            accountName: new Text("User ID ".toString() + userName.toString() + "  And role ".toString() + role.toString()),
            accountEmail: new Text(
              "Login Time : ".toString() + loginTime.toString(),
              overflow: TextOverflow.fade,
            ),
            otherAccountsPictures: <Widget>[
              new IconButton(
                  icon: new Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 36.0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute<bool>(
                          builder: (context) => new AboutUsScreen()),
                    );
                  })
            ],
            currentAccountPicture: new CircleAvatar(
              backgroundColor: Colors.white,
              //backgroundImage: new AssetImage("assets/profile_pic.jpg"),
            ),
          ),
          new ListTile(
              leading: new Icon(Icons.inbox),
              title: new Text("Inbox"),
              onTap: () {
                if (projectSelectionListener != null) {
                  var project = Project.getInbox();
                  projectSelectionListener(project);
                  Navigator.pop(context);
                }
              }),

          new ListTile(
              onTap: () {
                var dateTime = new DateTime.now();
                var taskStartTime =
                    new DateTime(dateTime.year, dateTime.month, dateTime.day)
                        .millisecondsSinceEpoch;
                var taskEndTime = new DateTime(
                    dateTime.year, dateTime.month, dateTime.day, 23, 59)
                    .millisecondsSinceEpoch;

                if (dateSelectionListener != null) {
                  dateSelectionListener(taskStartTime, taskEndTime);
                }
                Navigator.pop(context);
              },
              leading: new Icon(Icons.calendar_today),
              title: new Text("Today")),
          new ListTile(
            onTap: () {
              var dateTime = new DateTime.now();
              var taskStartTime =
                  new DateTime(dateTime.year, dateTime.month, dateTime.day)
                      .millisecondsSinceEpoch;
              var taskEndTime = new DateTime(
                  dateTime.year, dateTime.month, dateTime.day + 7, 23, 59)
                  .millisecondsSinceEpoch;

              if (dateSelectionListener != null) {
                dateSelectionListener(taskStartTime, taskEndTime);
              }
              Navigator.pop(context);
            },
            leading: new Icon(Icons.calendar_today),
            title: new Text("Next 7 Days"),
          ),
          buildExpansionTile(Icons.book, "Projects"),
          buildExpansionTile(Icons.label, "Labels"),
          new ListTile(
              leading: new Icon(Icons.settings_bluetooth),
              title: new Text("Bluetooth Settings"),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                      new DeviceSetting()), //When Authorized Navigate to the next screen
                );
              }),
          new ListTile(
              leading: new Icon(Icons.verified_user),
              title: new Text("Change Password & Agent Biometric"),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                      new ChangePassword("login")), //When Authorized Navigate to the next screen
                );
              })
        ],
      ),
    );
  }

  ExpansionTile buildExpansionTile(IconData icon, String projectName) {
    return new ExpansionTile(
      leading: new Icon(icon),
      title: new Text(projectName,
          style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      children: projectName == "Projects" ? buildProjects() : buildLabels(),
    );
  }

  List<Widget> buildProjects() {
    List<Widget> projectWidgetList = new List();
    projectList.forEach((project) =>
        projectWidgetList.add(new ProjectRow(
          project,
          projectSelection: (selectedProject) {
            projectSelectionListener(selectedProject);
            Navigator.pop(context);
          },
        )));
    projectWidgetList.add(new ListTile(
      leading: new Icon(Icons.add),
      title: new Text("Add Project"),
      onTap: () async {
        Navigator.pop(context);
        bool isDataChanged = await Navigator.push(
            context,
            new MaterialPageRoute<bool>(
                builder: (context) => new AddProject()));

        if (isDataChanged) {
          updateProjects();
        }
      },
    ));
    return projectWidgetList;
  }

  List<Widget> buildLabels() {
    List<Widget> projectWidgetList = new List();
    labelList.forEach((label) =>
        projectWidgetList.add(new LabelRow(label, labelSelection: (label) {
          labelSelectionListener(label);
          Navigator.pop(context);
        })));
    projectWidgetList.add(new ListTile(
        leading: new Icon(Icons.add),
        title: new Text("Add Label"),
        onTap: () async {
          Navigator.pop(context);
          bool isDataChanged = await Navigator.push(
              context,
              new MaterialPageRoute<bool>(
                  builder: (context) => new AddLabel()));

          if (isDataChanged) {
            updateLabels();
          }
        }));
    return projectWidgetList;
  }

  void getSessionVariables() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.get(TablesColumnFile.musrcode);
    role = prefs.get(TablesColumnFile.musrdesignation);
    loginTime = prefs.get(TablesColumnFile.LoginTime);
  }


}

class ProjectRow extends StatelessWidget {
  final Project project;
  final ProjectSelection projectSelection;

  ProjectRow(this.project, {this.projectSelection});

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () {
        if (projectSelection != null) {
          projectSelection(project);
        }
      },
      leading: new Container(
        width: 24.0,
        height: 24.0,
      ),
      title: new Text(project.name),
      trailing: new Container(
        height: 10.0,
        width: 10.0,
        child: new CircleAvatar(
          backgroundColor: new Color(project.colorValue),
        ),
      ),
    );
  }
}

class LabelRow extends StatelessWidget {
  final Label label;
  final LabelSelection labelSelection;

  LabelRow(this.label, {this.labelSelection});

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () {
        if (labelSelection != null) {
          labelSelection(label);
        }
      },
      leading: new Container(
        width: 24.0,
        height: 24.0,
      ),
      title: new Text("@ ${label.name}"),
      trailing: new Container(
        height: 10.0,
        width: 10.0,
        child: new Icon(
          Icons.label,
          size: 16.0,
          color: new Color(label.colorValue),
        ),
      ),
    );
  }
}

typedef void ProjectSelection(Project project);
typedef void LabelSelection(Label label);
typedef void DateSelection(int startDate, int endDate);
