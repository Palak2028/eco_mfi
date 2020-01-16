import 'dart:async';

import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/CenterFormationMasterSubmission.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterFormationMasterListViewBean.dart';
import 'package:eco_mfi/translations.dart';

class CenterFormationMasterListView extends StatefulWidget {
  @override
  _CenterFormationMasterListViewState createState() =>
      new _CenterFormationMasterListViewState();
}

class _CenterFormationMasterListViewState
    extends State<CenterFormationMasterListView> {
  List<CenterFormationMasterListViewBean> items = new List();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();

  NetworkUtil _netUtil = new NetworkUtil();

  // var url = "http://14.141.253.236:8090/createCentersFoundations/getlistOfData/";
  var url =
      "http://14.141.164.239:8090//createCentersFoundations//getlistOfData//";

  @override
  void initState() {
    super.initState();
    setState(() {
      _netUtil.getCenterFoundationList(url).then(
          (List<CenterFormationMasterListViewBean> response) =>
              items = response);
    });
  }

  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 20.0),
      );
    }
  }

  Widget _getItemUI(BuildContext context, int index) {
    return new SizedBox(
      child: new Card(
          child: new Column(
        children: <Widget>[
          new ListTile(
            leading: new Text(
              '${items[index].id}',
              //textScaleFactor: 1.2,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.black,
              ),
            ),

            title: new Text(
              '${items[index].id}',
              //textScaleFactor: 0.9,
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
                    '${items[index].id}',
                    //textScaleFactor: 0.9,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.blueAccent,
                    ),
                  ),
                  new Text(
                    '${items[index].id}',
                    //textScaleFactor: 0.8,
                    textAlign: TextAlign.right,
                    style: new TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                    ),
                  ),
                  ListTile(
                    subtitle: Text(
                      '${items[index].branch}',
                      //textScaleFactor: 2.0,
                      textAlign: TextAlign.right,
                      style: new TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey),
                    ),
                    leading: Column(
                      children: <Widget>[
                        new Text(
                          '${items[index].centerName}',
                          // textScaleFactor: 2.0,
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
      )),
    );
  }

  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
        future: _netUtil.getCenterFoundationList(url).then(
            (List<CenterFormationMasterListViewBean> response) =>
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
          Translations.of(context).text('Center_Foundation_List')
          ,
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
                builder: (context) => new CenterFormationMasterSubmission()),
          );
        },
      ),
      body: Center(
        child: futureBuilder,
      ),
    );
  }

  void _onTapItem(BuildContext context,
      CenterFormationMasterListViewBean listOfCenterFoundationData) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(listOfCenterFoundationData.id.toString() +
            ' - ' +
            listOfCenterFoundationData.centerName)));
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new CenterFormationMasterSubmission(
              listOfCenterFoundationData:
                  listOfCenterFoundationData)), //When Authorized Navigate to the next screen
    );
  }
}
