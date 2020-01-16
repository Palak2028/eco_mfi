import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/OpenCamera.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/SpeedoMeter/bean/SpeedoMeterBean.dart';
import 'package:eco_mfi/pages/workflow/SpeedoMeter/list/SpeedoMeterList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;

class SpeedoMeter extends StatefulWidget {
  final SpeedoMeterBean SpeedoMeterPassedObject;
  var cameras;

  SpeedoMeter({Key key, @required this.SpeedoMeterPassedObject})
      : super(key: key);

  @override
  _SpeedoMeterState createState() => new _SpeedoMeterState();
}

class _SpeedoMeterState extends State<SpeedoMeter> {

 bool isStartingFrom = false;
  bool isEndingTo = false;
  bool circIndicatorIsDatSynced = false;
 final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
 final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  int branch = 0;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;

  SpeedoMeterBean speedoMeterObj = new SpeedoMeterBean();

  @override
  void initState() {
    super.initState();

    getSessionVariables();

    if (widget.SpeedoMeterPassedObject != null) {
      speedoMeterObj = widget.SpeedoMeterPassedObject;
      print("obj is ${speedoMeterObj}");
    }

    if (speedoMeterObj.effDate =="null" ||speedoMeterObj.effDate ==null) {
        speedoMeterObj.effDate = DateTime.now();
    }
  }

  _changed(String filePath, String str) {

if(str == 'from'){
  isStartingFrom = true;
  speedoMeterObj.startingFromImg = filePath;
}
else if(str == 'to'){
  isEndingTo = true;
  speedoMeterObj.endingFromImg = filePath;
}

  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.getInt(TablesColumnFile.musrbrcode);
      username = prefs.getString(TablesColumnFile.usrCode);
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.geoLocation);
      geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: new Text("SpeedoMeter"),
        backgroundColor: Color(0xff07426A),
      ),
      body:  new Form(
        key: _formKey,
        autovalidate: false,
        onWillPop: () {
          return Future(() => true);
        },
        onChanged: () async{
          final FormState form = _formKey.currentState;
          form.save();
          setState(() {});
        },
        child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
    new Card(
    elevation: 5.0,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        new Card(
        elevation: 5.0,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                padding: new EdgeInsets.all(8.0),
              ),

              new Container(
                padding: new EdgeInsets.all(8.0),
                child: Text(
                  'Click Below for picture',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              new Row(
                children: <Widget>[
                  new Flexible(
                    child: new Column(
                      children: <Widget>[
                        new ListTile(
                          title: speedoMeterObj.startingFromImg!=null&&speedoMeterObj.startingFromImg!="null"
              ? new Image.file(
                  File(speedoMeterObj.startingFromImg),
          height: 150.0,
          width: 150.0,
        )
                              : new Icon(
                            Icons.camera_alt,
                            size: 40.0,
                            color: Color(0xff07426A),
                          ),
                          onTap: () {
                            _navigateAndDisplaySelection(context, "from");
                          },
                        )
                      ],
                    ),
                  ),
                  new Flexible(
                    child: new Column(
                      children: <Widget>[
                        new ListTile(
                          title: speedoMeterObj.endingFromImg!=null&&speedoMeterObj.endingFromImg!="null"
                              ? new Image.file(
                            File(speedoMeterObj.endingFromImg),
                            height: 150.0,
                            width: 150.0,

                          )
                              : new Icon(
                            Icons.camera_alt,
                            size: 40.0,
                            color: Color(0xff07426A),
                          ),
                          onTap: () {
                            _navigateAndDisplaySelection(context, "to");
                          },
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
          ],
              ),
      ),

    Card(
        child:
        new TextFormField(

            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter Meter Reading',
              labelText: 'Initial Meter Reading',
              hintStyle: TextStyle(color: Colors.grey),
              labelStyle: TextStyle(color: Colors.grey),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  )),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  )),
              contentPadding: EdgeInsets.all(20.0),
            ),
            initialValue: speedoMeterObj.startingPoint == null
                ? ""
                : "${speedoMeterObj.startingPoint}",
            onSaved: (String value) {
              if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                speedoMeterObj.startingPoint = int.parse(value);
              }

            }

        )
    ),
    Card(
        child:
        new TextFormField(

            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter Meter Reading',
              labelText: 'Final Meter Reading',
              hintStyle: TextStyle(color: Colors.grey),
              labelStyle: TextStyle(color: Colors.grey),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  )),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  )),
              contentPadding: EdgeInsets.all(20.0),
            ),
            initialValue: speedoMeterObj.endingPoint == null
                ? ""
                : "${speedoMeterObj.endingPoint}",
            onSaved: (String value) {
              if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                speedoMeterObj.endingPoint = int.parse(value);
              }
              if (speedoMeterObj.endingPoint != "" && (speedoMeterObj.endingPoint > speedoMeterObj.startingPoint)) {
                speedoMeterObj.totMeterReading =
                (speedoMeterObj.endingPoint - speedoMeterObj.startingPoint);
              }
              if (speedoMeterObj.endingPoint < speedoMeterObj.startingPoint){
                speedoMeterObj.totMeterReading = 0;
              }
            },
        )
    ),
    new Card(
      child: new ListTile(
        title: new Text("Total Distance (kms)"),
        subtitle: speedoMeterObj.totMeterReading == null
            ? new Text("")
            : new Text("${speedoMeterObj.totMeterReading}"),
      ),
    ),
    new Container(
      height: 20.0,
    ),
    FloatingActionButton.extended(
      icon: Icon(Icons.assignment_turned_in),
      backgroundColor: Color(0xff07426A),
      label: Text("Submit"),
      onPressed: proceed,
    ),
    new Container(
      height: 20.0,
    )
        ],
    ),
    ),
    );

  }
  Future<void> _showAlert(arg, error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$arg'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$error'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  proceed()  async{
    if (speedoMeterObj.startingPoint == "" || speedoMeterObj.startingPoint == null){
      _showAlert("Intial Meter Reading", "It is Mandatory");
      return false;
    }
    speedoMeterObj.usrName = username;
    speedoMeterObj.createdBy = username;
    speedoMeterObj.updatedBy = null;
    speedoMeterObj.createdAt = DateTime.now();
    speedoMeterObj.updatedAt = DateTime.now();
    speedoMeterObj.geoLocation = geoLocation;
    speedoMeterObj.geoLongitude = geoLongitude;
    speedoMeterObj.geoLatitude = geoLatitude;
    print("geoLocation : ${geoLocation}");
    print("geoLongitude : ${geoLongitude}");
    print("geoLatitude : ${geoLatitude}");
    await AppDatabase.get()
        .updateSpeedoMeterDetailsMaster(speedoMeterObj)
        .then((val) {
    });
    _successfulSubmit();
  }

  Future<void> _successfulSubmit() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 40.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Readings Recorded '),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                        new SpeedoMeterList()),
                  );
                },
              ),
            ],
          );
        });
  }

  _navigateAndDisplaySelection(BuildContext context, String str) async {
    print(widget.cameras);
    if (widget.cameras == null) {
     // widget.cameras = await availableCameras();
    }
    final result = !(widget.cameras == null)
        ? Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) => new OpenCamera(),
              fullscreenDialog: true,
            )).then((onValue) {
              if (onValue != null){
                setState(() {
                  _changed(onValue, str);
                });
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("$onValue")));
              }
          })
        : globals.Utility.showAlertPopup(
            context, "Info", "Permission required ! \n");
  }


  }
