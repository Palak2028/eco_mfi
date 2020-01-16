import 'dart:async';

import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/GroupFormationMasterSubmission.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFormationMasterListViewBean.dart';

class GroupFormationMasterSubmissionListView extends StatefulWidget {
  @override
  _GroupFormationMasterSubmissionListViewState createState() =>
      new _GroupFormationMasterSubmissionListViewState();
}

class _GroupFormationMasterSubmissionListViewState
    extends State<GroupFormationMasterSubmissionListView> {
  List<GroupFormationMasterListViewBean> items = new List();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();

  NetworkUtil _netUtil = new NetworkUtil();

  // var url = "http://14.141.253.236:8090/createCentersFoundations/getlistOfData/";
  var url =
      "http://14.141.164.239:8090//createGroupsFoundations//getlistOfData//";

// var url = "http://172.25.3.66:8090//createGroupsFoundations//getlistOfData//";

  @override
  void initState() {
    super.initState();
    setState(() {
      _netUtil.getGroupFormationList(url).then(
          (List<GroupFormationMasterListViewBean> response) =>
              items = response);
    });
  }

  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.all(0.0),
      );
    }
  }

  Widget _getItemUI(BuildContext context, int index) {
    return new Card(
        child: new Column(
      children: <Widget>[
        new ListTile(
          leading: new Text(
            '${items[index].groupNumber}',
            textScaleFactor: 1.2,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.black,
            ),
          ),

          title: new Text(
            '${items[index].centerCode}',
            textScaleFactor: 0.9,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.blueAccent,
            ),
          ),
          subtitle: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  '${items[index].groupName}',
                  textScaleFactor: 0.9,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.blueAccent,
                  ),
                ),
                new Text(
                  '${items[index].branchGroupID}',
                  textScaleFactor: 0.8,
                  textAlign: TextAlign.right,
                  style: new TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                  ),
                ),
                ListTile(
                  subtitle: Text(
                    '${items[index].groupRecognitionTestDate}',
                    textScaleFactor: 2.0,
                    textAlign: TextAlign.right,
                    style: new TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey),
                  ),
                  leading: Column(
                    children: <Widget>[
                      new Text(
                        '${items[index].meetingDay}',
                        textScaleFactor: 2.0,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 22.0, color: Colors.grey),
                      ),
                    ],
                  ),
                  onTap: () => _onTapItem(context, items[index]),
                ),
              ]),
          //trailing: ,
          onTap: () {
            _onTapItem(context, items[index]);
          },
        )
      ],
    ));
  }

  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
        future: _netUtil.getGroupFormationList(url).then(
            (List<GroupFormationMasterListViewBean> response) =>
                items = response),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text('Press button to start');
            case ConnectionState.waiting:
              return new Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  child:
                      new CircularProgressIndicator()); // new Text('Awaiting result...');
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return getHomePageBody(context, snapshot);
          }
        });
    return Scaffold(
      key: _scaffoldHomeState,
      appBar: new AppBar(
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: new Text(
          'Group foundation List',
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
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
                builder: (context) => new GroupFormationMasterSubmission()),
          );
        },
      ),
      body: Center(
        child: futureBuilder,
      ),
    );
  }

  void _onTapItem(BuildContext context,
      GroupFormationMasterListViewBean listOfGroupFormationData) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(listOfGroupFormationData.groupNumber.toString() +
            ' - ' +
            listOfGroupFormationData.groupName)));
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new GroupFormationMasterSubmission(
              listOfGroupFormationData:
                  listOfGroupFormationData)), //When Authorized Navigate to the next screen
    );
  }
}
