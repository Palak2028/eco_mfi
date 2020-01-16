import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter/rendering.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/statusDetails/CGT1Details.dart';
import 'package:eco_mfi/pages/workflow/statusDetails/CGT2Details.dart';
import 'package:eco_mfi/pages/workflow/statusDetails/GRTDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CCGTab extends StatefulWidget {
  final routeType;
  final int loanNum;

  CCGTab(this.routeType, this.loanNum);
  @override
  _CCGTab createState() => new _CCGTab();
}

class _CCGTab extends State<CCGTab>
  with SingleTickerProviderStateMixin {
  TabController _tabController;
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrCode;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String branch = "";
  DateTime startTime = DateTime.now();
  final dateFormat = DateFormat("yyyy, mm, dd");
  DateTime date;
  TimeOfDay time;

  int tabState = 3;
  static const List<String> tabNames = const <String>[
    'CGT1',
    'CGT2',
    'GRT'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("LoanNumber is ${widget.loanNum}");
    _tabController = new TabController(vsync: this, initialIndex: 0, length: 3);
    getSessionVariables();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString(TablesColumnFile.usrCode);
      usrCode = prefs.getString(TablesColumnFile.usrCode);
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      branch = prefs.get(TablesColumnFile.musrbrcode).toString();
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.geoLocation);
      geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
    });
  }

  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
      onWillPop: () {
        //callDialog();
        Navigator.of(context).pop();
      },
      child: new Scaffold(
        //key: _scaffoldKeyMaster,
        appBar: new AppBar(
          title: new Text(
            "Customer Details",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 3.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // callDialog();
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          bottom: new TabBar(
            controller: _tabController,
            indicatorColor: Colors.black,
            isScrollable: true,
            tabs: new List.generate(tabNames.length, (index) {
              return new Tab(text: tabNames[index].toUpperCase());
            }),
          ),
        ),
        body: new TabBarView(
          controller: _tabController,

          children: <Widget>[

            new CGT1Details(widget.routeType,widget.loanNum),
            new CGT2Details(widget.routeType,widget.loanNum),
            new GRTDetails(widget.routeType,widget.loanNum)
          ],
        ),
      ),
    );
  }
}
