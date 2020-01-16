import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';

import 'package:eco_mfi/pages/workflow/centerfoundation/bean/GetCentersSelectionList.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FullScreenDialogForProductSelection extends StatefulWidget {
  final int moduleType;
  final int isInd;
  FullScreenDialogForProductSelection(this.moduleType,this.isInd);
  @override
  _FullScreenDialogForProductSelectionState createState() =>
      new _FullScreenDialogForProductSelectionState();
}

class _FullScreenDialogForProductSelectionState
    extends State<FullScreenDialogForProductSelection> {
  List<ProductBean> items = new List();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  static const JsonCodec JSON = const JsonCodec();
  //String url = 'http://14.141.164.239:8090/createProducts/getlistOfData/';
  int branch = 0;
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;

  @override
  void initState() {
    super.initState();
    setState(() {});
    getSessionVariables();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode);
      username = prefs.getString(TablesColumnFile.usrCode);
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.geoLocation);
      geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
      reportingUser = prefs.getString(TablesColumnFile.reportingUser);
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
            '${items[index].mname}',
            //textScaleFactor: 1.2,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
            ),
          ),
          trailing: new Text(
            '${items[index].mprdCd}',
            //textScaleFactor: 0.9,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.blueAccent,
            ),
          ),

          //trailing: ,
          onTap: () {
            _onTapItem(context, items[index]);
          },
        )
      ],
    )));
  }

  Widget build(BuildContext context) {
    print("branch " + branch.toString());
    var futureBuilder = new FutureBuilder(
        future: AppDatabase.get()
            .getProductList(widget.moduleType, branch,widget.isInd)
            .then((List<ProductBean> response) => items = response),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text(Translations.of(context).text('Press_Button_To_Start'));
            case ConnectionState.waiting:
              return new Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  child:
                      new CircularProgressIndicator()); // new Text('Awaiting result...');
            default:
              if (snapshot.hasError)
                return new Text(Translations.of(context).text('error')+"${snapshot.error}");
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
          Translations.of(context).text('Product_Selection_List'),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      /*  floatingActionButton: new FloatingActionButton(
        child: new Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        onPressed: () async {
          bool isDataChanged = await Navigator.push(
            context,
            new MaterialPageRoute<bool>(
                builder: (context) => new CustomerFormationBasicDetails()),
          );

        },
      ),*/
      body: Center(
        child: futureBuilder,
      ),
    );
  }

  void _onTapItem(BuildContext context, ProductBean getProductList) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(getProductList.mprdCd.toString() +
            ' - ' +
            getProductList.mname)));

    Navigator.of(context).pop(getProductList);
    globals.productName = getProductList.mname;
    globals.productId = getProductList.mprdCd.toString();
  }
}
