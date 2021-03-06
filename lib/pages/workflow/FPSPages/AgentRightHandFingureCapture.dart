import 'dart:convert';

import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../../../LoginBean.dart';
import '../../../translations.dart';

class AgentRightHandFingureCapture extends StatefulWidget {
  @override
  _AgentRightHandFingureCapture createState() =>
      _AgentRightHandFingureCapture();
}

class _AgentRightHandFingureCapture
    extends State<AgentRightHandFingureCapture> {
  static int counterRightHandFinger = 0;
  static int counterAgentRHRegist = 0;
  static String agentbioRegRHDATA = "";
  int isCalledfrmAgent = null;
  SharedPreferences prefs;
  LoginBean beanObj = new LoginBean();

  @override
<<<<<<< .mine
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionVariables();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      String userType = prefs.get(TablesColumnFile.userType);
      beanObj.musrcode = prefs.get(TablesColumnFile.musrcode);
      if (userType == "CUSTOMER") {
        isCalledfrmAgent = 0;

      } else if (userType == "AGENT") {
        isCalledfrmAgent = 1;
      }
    });
  }

  @override
=======
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionVariables();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      String userType = prefs.get(TablesColumnFile.userType);
      beanObj.musrcode = prefs.get(TablesColumnFile.musrcode);
      if (userType == "CUSTOMER") {
        isCalledfrmAgent = 0;
      } else if (userType == "AGENT") {
        isCalledfrmAgent = 1;
      }
    });
  }

  @override
>>>>>>> .r1143
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(
      onWillPop: () {
        counterRightHandFinger = 0;
        counterAgentRHRegist = 0;
        agentbioRegRHDATA = "";
        Navigator.pop(context);
      },
      child: Center(
        child: Container(
            padding: EdgeInsets.only(
                left: 10.0, top: 20.0, right: 10.0, bottom: 10.0),
            alignment: Alignment.center,
            // color: Colors.white70,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/background_finger_capture.png"),
                fit: BoxFit.fill,
              ),
            ),

//        width: 200.0,
//        height: 100.0,
//      margin: EdgeInsets.only(left: 35.0,top:50.0),
            child: Column(
              children: <Widget>[
                new Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          Constant.label_biometric_scan,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 20.0,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              color: Colors.black87
                              //          fontStyle: FontStyle.italic
                              ),
                        ),
                      ),
                    ],
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Text(
                    Constant.label_please_select_rt_hand_fngr,
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 18.0,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w700,
                        color: Colors.black38
                        //          fontStyle: FontStyle.italic
                        ),
                  ),
                ),
                new Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: RightHandThumb(),
                      ),
                      Expanded(
                        child: RightHandIndexFinger(),
                      ),
                      Expanded(
                        child: RightHandMiddleFinger(),
                      ),
                    ],
                  ),
                  flex: 3,
                ),
                new Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          Constant.label_thumb_finger,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              color: Colors.black38
                              //          fontStyle: FontStyle.italic
                              ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Constant.label_index_finger,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              color: Colors.black38
                              //          fontStyle: FontStyle.italic
                              ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Constant.label_middle_finger,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              color: Colors.black38
                              //          fontStyle: FontStyle.italic
                              ),
                        ),
                      ),
                    ],
                  ),
                  flex: 3,
                ),
                new Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: RightHandRingFinger(),
                      ),
                      Expanded(
                        child: RightHandPinkyFinger(),
                      ),
                      /* Expanded(
                        child: RightHandThumb(),
                      ),*/
                    ],
                  ),
                  flex: 3,
                ),
                new Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          Constant.label_ring_finger,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              color: Colors.black38
                              //          fontStyle: FontStyle.italic
                              ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Constant.label_pinky_finger,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              color: Colors.black38
                              //          fontStyle: FontStyle.italic
                              ),
                        ),
                      ),
                    ],
                  ),
                  flex: 3,
<<<<<<< .mine
                ),
                isCalledfrmAgent == 0
                    ? new Container()
                    : new Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: new RaisedButton(
                            child: Text(
                              Translations.of(context).text('Register'),
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                             await  AppDatabase.get().updateAgentBiometric(beanObj.musrcode, "RH", "", _AgentRightHandFingureCapture.agentbioRegRHDATA)
                                 .then((int val){

                               if (val  == 0){

                               }else {

                               }


                             });
                              print( "RHDATAAA"+_AgentRightHandFingureCapture.agentbioRegRHDATA.toString());
                            }),
                      ),
                    ],
                  ),
=======
                ),
                isCalledfrmAgent == 0
                    ? new Container()
                    : new Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: new RaisedButton(
                                  child: Text(
                                    Translations.of(context).text('Register'),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    await AppDatabase.get()
                                        .updateAgentBiometric(
                                            beanObj.musrcode,
                                            "RH",
                                            "",
                                            _AgentRightHandFingureCapture
                                                .agentbioRegRHDATA)
                                        .then((int val) {
                                      print("RHDATAAA" +
                                          _AgentRightHandFingureCapture
                                              .agentbioRegRHDATA
                                              .toString());
                                      if (val == 0) {
                                        Toast.show(
                                            "Something went wrong!!", context);
                                      } else {
                                        Navigator.of(context).pop();
                                      }
                                    });
                                  }),
                            ),
                          ],
                        ),
                        flex: 3,
                      )
>>>>>>> .r1143
                  flex: 3,
                )
              ],
            )),
      ),
    );
  }
}

//  class for right hand thumb
class RightHandThumb extends StatefulWidget {
  @override
  _RightHandThumb createState() => new _RightHandThumb();
}

class _RightHandThumb extends State<RightHandThumb> {
  String _myImage = 'assets/fpsImages/rt_hand_thumb.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  SharedPreferences prefs;
  static const JsonCodec JSON = const JsonCodec();
  String userType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionVariables();
  }

<<<<<<< .mine
  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
       userType = prefs.get(TablesColumnFile.userType);
      if (userType == "CUSTOMER") {
        if (CustomerFormationMasterTabsState
                    .custListBean.imageMaster[18].imgSubType !=
                null &&
            CustomerFormationMasterTabsState
                    .custListBean.imageMaster[18].imgSubType !=
                "") {
          _myImage = 'assets/fpsImages/rt_hand_thumb_selected.png';
          _AgentRightHandFingureCapture.counterRightHandFinger++;
        } else {
          _myImage == 'assets/fpsImages/rt_hand_thumb.png';
        }
      } else if (userType == "AGENT") {}
    });
=======
  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userType = prefs.get(TablesColumnFile.userType);
      if (userType == "CUSTOMER") {
        if (CustomerFormationMasterTabsState
                    .custListBean.imageMaster[18].imgSubType !=
                null &&
            CustomerFormationMasterTabsState
                    .custListBean.imageMaster[18].imgSubType !=
                "") {
          _myImage = 'assets/fpsImages/rt_hand_thumb_selected.png';
          _AgentRightHandFingureCapture.counterRightHandFinger++;
        } else {
          _myImage == 'assets/fpsImages/rt_hand_thumb.png';
        }
      } else if (userType == "AGENT") {}
    });
>>>>>>> .r1143
  }

<<<<<<< .mine
  void _onClicked () {

=======
>>>>>>> .r1143
<<<<<<< .mine

    if (userType == "CUSTOMER") {
      print("rhcv" +
          _AgentRightHandFingureCapture.counterRightHandFinger.toString());
      if (_AgentRightHandFingureCapture.counterRightHandFinger < 6) {
        _callChannelRHThumb("RhThumb");
      } else {
        Toast.show("you have already captured 3 fingers", context);
      }


    } else if (userType == "AGENT") {
      print(
          "rhcv" + _AgentRightHandFingureCapture.counterAgentRHRegist.toString());
      if (_AgentRightHandFingureCapture.counterAgentRHRegist < 1) {
        _callChannelRHThumb("RhThumb");
      } else {
        Toast.show("you have already captured Right hand fingers", context);
      }

=======
    if (userType == "CUSTOMER") {
      print("rhcv" +
          _AgentRightHandFingureCapture.counterRightHandFinger.toString());
      if (_AgentRightHandFingureCapture.counterRightHandFinger < 6) {
        _callChannelRHThumb("RhThumb");
      } else {
        Toast.show("you have already captured 3 fingers", context);
      }
    } else if (userType == "AGENT") {
      print("rhcv" +
          _AgentRightHandFingureCapture.counterAgentRHRegist.toString());
      if (_AgentRightHandFingureCapture.counterAgentRHRegist < 1) {
        _callChannelRHThumb("RhThumb");
      } else {
        Toast.show("you have already captured Right hand fingers", context);
      }
>>>>>>> .r1143
    }
  }




  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage(_myImage);
    var image = new Image(
      image: assetImage,
      fit: BoxFit.fitHeight,
    );
    return new Container(
      child: new FlatButton(
        onPressed: _onClicked,
        child: image,
      ),
    );
  }

  _callChannelRHThumb(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
<<<<<<< .mine
    String userType = prefs.getString(TablesColumnFile.userType);
    try {
      final String result = await platform.invokeMethod("callingForFPS", {
        "callValue": 0,
        "BluetoothADD": bluetootthAdd,
        "TYPEofFINGER": fingerType,
        "UserType": userType
      });
      //String geTest = '$result';
      var json = JSON.decode(result);
      var RHThumbdata = json['FINGERDATA'];
      var RHThumbimagedata = json['IMAGEDATA'];

      // print("rightthumbvalue!! : " + geTest);
      if (RHThumbdata != null && RHThumbdata != 'null') {
        setState(() {
=======
    String userType = prefs.getString(TablesColumnFile.userType);
    if(bluetootthAdd.toString() !=null&& bluetootthAdd.toString().length >7 ){
      try {
        final String result = await platform.invokeMethod("callingForFPS", {
          "callValue": 0,
          "BluetoothADD": bluetootthAdd,
          "TYPEofFINGER": fingerType,
          "UserType": userType
        });
        //String geTest = '$result';
        var json = JSON.decode(result);
        var RHThumbdata = json['FINGERDATA'];
        var RHThumbimagedata = json['IMAGEDATA'];
>>>>>>> .r1143
          if (userType == "CUSTOMER") {
            CustomerFormationMasterTabsState
                .custListBean.imageMaster[18].imgSubType = fingerType;
            CustomerFormationMasterTabsState
                .custListBean.imageMaster[18].imgString = RHThumbdata;
            CustomerFormationMasterTabsState
                .custListBean.imageMaster[18].imgType = "FingerPrint";

<<<<<<< .mine
            _myImage = 'assets/fpsImages/rt_hand_thumb_selected.png';
            _AgentRightHandFingureCapture.counterRightHandFinger++;
          } else if (userType == "AGENT") {
            _AgentRightHandFingureCapture.counterAgentRHRegist++;
            _AgentRightHandFingureCapture.agentbioRegRHDATA = RHThumbdata ;
            _myImage = 'assets/fpsImages/rt_hand_thumb_selected.png';
          }
=======
        // print("rightthumbvalue!! : " + geTest);
        if (RHThumbdata != null && RHThumbdata != 'null') {
          setState(() {
            if (userType == "CUSTOMER") {
              CustomerFormationMasterTabsState
                  .custListBean.imageMaster[18].imgSubType = fingerType;
              CustomerFormationMasterTabsState
                  .custListBean.imageMaster[18].imgString = RHThumbdata;
              CustomerFormationMasterTabsState
                  .custListBean.imageMaster[18].imgType = "FingerPrint";
>>>>>>> .r1143

<<<<<<< .mine
=======
              _myImage = 'assets/fpsImages/rt_hand_thumb_selected.png';
              _AgentRightHandFingureCapture.counterRightHandFinger++;
            } else if (userType == "AGENT") {
              _AgentRightHandFingureCapture.counterAgentRHRegist++;
              _AgentRightHandFingureCapture.agentbioRegRHDATA = RHThumbdata;
              _myImage = 'assets/fpsImages/rt_hand_thumb_selected.png';
            }

>>>>>>> .r1143
<<<<<<< .mine
          //Navigator.pop(context,fingerType+"#"+geTest );
        });
      } else {
        _myImage = 'assets/fpsImages/rt_hand_thumb.png';
=======
            //Navigator.pop(context,fingerType+"#"+geTest );
          });
        } else {
          _myImage = 'assets/fpsImages/rt_hand_thumb.png';
        }

        print("RHThumbdata : " + RHThumbdata.toString());
        print("RHThumbimagedata : " + RHThumbimagedata.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
>>>>>>> .r1143
      }
    }else{
      Toast.show("Please select a bluetooth device!", context);
    }

<<<<<<< .mine
      print("RHThumbdata : " + RHThumbdata.toString());
      print("RHThumbimagedata : " + RHThumbimagedata.toString());
    } on PlatformException catch (e) {
      print("FLutter : " + e.message.toString());
    }
=======
>>>>>>> .r1143
  }
}

// class for Index finger
class RightHandIndexFinger extends StatefulWidget {
  @override
  _RightHandIndexFinger createState() => new _RightHandIndexFinger();
}

class _RightHandIndexFinger extends State<RightHandIndexFinger> {
  String _myImage = 'assets/fpsImages/rt_hand_index.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  SharedPreferences prefs;
  static const JsonCodec JSON = const JsonCodec();
  String userType;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionVariables();
  }

<<<<<<< .mine
  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
       userType = prefs.get(TablesColumnFile.userType);
      if (userType == "CUSTOMER") {
        if (CustomerFormationMasterTabsState
                    .custListBean.imageMaster[19].imgSubType !=
                null &&
            CustomerFormationMasterTabsState
                    .custListBean.imageMaster[19].imgSubType !=
                "") {
          _myImage = 'assets/fpsImages/rt_hand_index_selected.png';
          _AgentRightHandFingureCapture.counterRightHandFinger++;
        } else {
          _myImage == 'assets/fpsImages/rt_hand_index.png';
        }
      } else if (userType == "AGENT") {}
    });
=======
  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userType = prefs.get(TablesColumnFile.userType);
      if (userType == "CUSTOMER") {
        if (CustomerFormationMasterTabsState
                    .custListBean.imageMaster[19].imgSubType !=
                null &&
            CustomerFormationMasterTabsState
                    .custListBean.imageMaster[19].imgSubType !=
                "") {
          _myImage = 'assets/fpsImages/rt_hand_index_selected.png';
          _AgentRightHandFingureCapture.counterRightHandFinger++;
        } else {
          _myImage == 'assets/fpsImages/rt_hand_index.png';
        }
      } else if (userType == "AGENT") {}
    });
>>>>>>> .r1143
  }

  void _onClicked() {
<<<<<<< .mine


    if (userType == "CUSTOMER") {
      print("rhcv" +
          _AgentRightHandFingureCapture.counterRightHandFinger.toString());
      if (_AgentRightHandFingureCapture.counterRightHandFinger < 6) {
        _callChannelRHIndexFinger("RhIndexFinger");
      } else {
        Toast.show("you have already captured 3 fingers", context);
      }


    } else if (userType == "AGENT") {
      print(
          "rhcv" + _AgentRightHandFingureCapture.counterAgentRHRegist.toString());
      if (_AgentRightHandFingureCapture.counterAgentRHRegist < 1) {
        _callChannelRHIndexFinger("RhIndexFinger");
      } else {
        Toast.show("you have already captured Right hand fingers", context);
      }

=======
    if (userType == "CUSTOMER") {
      print("rhcv" +
          _AgentRightHandFingureCapture.counterRightHandFinger.toString());
      if (_AgentRightHandFingureCapture.counterRightHandFinger < 6) {
        _callChannelRHIndexFinger("RhIndexFinger");
      } else {
        Toast.show("you have already captured 3 fingers", context);
      }
    } else if (userType == "AGENT") {
      print("rhcv" +
          _AgentRightHandFingureCapture.counterAgentRHRegist.toString());
      if (_AgentRightHandFingureCapture.counterAgentRHRegist < 1) {
        _callChannelRHIndexFinger("RhIndexFinger");
      } else {
        Toast.show("you have already captured Right hand fingers", context);
      }
>>>>>>> .r1143
    }
  }

  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage(_myImage);
    var image = new Image(
      image: assetImage,
      fit: BoxFit.fitHeight,
    );
    return new Container(
      child: new FlatButton(
        onPressed: _onClicked,
        child: image,
      ),
    );
  }

  _callChannelRHIndexFinger(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
<<<<<<< .mine
    String userType = prefs.getString(TablesColumnFile.userType);
    try {
      final String result = await platform.invokeMethod("callingForFPS", {
        "callValue": 0,
        "BluetoothADD": bluetootthAdd,
        "TYPEofFINGER": fingerType,
        "UserType": userType
      });
      // String geTest = '$result';
      var json = JSON.decode(result);
      var RHIndexdata = json['FINGERDATA'];
      var RHIndeximagedata = json['IMAGEDATA'];

      if (RHIndexdata != null && RHIndexdata != 'null') {
        setState(() {
=======
    String userType = prefs.getString(TablesColumnFile.userType);
>>>>>>> .r1143
          if (userType == "CUSTOMER") {
            CustomerFormationMasterTabsState
                .custListBean.imageMaster[19].imgSubType = fingerType;
            CustomerFormationMasterTabsState
                .custListBean.imageMaster[19].imgString = RHIndexdata;
            CustomerFormationMasterTabsState
                .custListBean.imageMaster[19].imgType = "FingerPrint";

<<<<<<< .mine
            _myImage = 'assets/fpsImages/rt_hand_index_selected.png';
            _AgentRightHandFingureCapture.counterRightHandFinger++;
=======
    if(bluetootthAdd.toString() !=null&& bluetootthAdd.toString().length >7 ){
      try {
        final String result = await platform.invokeMethod("callingForFPS", {
          "callValue": 0,
          "BluetoothADD": bluetootthAdd,
          "TYPEofFINGER": fingerType,
          "UserType": userType
        });
        // String geTest = '$result';
        var json = JSON.decode(result);
        var RHIndexdata = json['FINGERDATA'];
        var RHIndeximagedata = json['IMAGEDATA'];
>>>>>>> .r1143

<<<<<<< .mine
            //Navigator.pop(context,fingerType+"#"+geTest );
=======
        if (RHIndexdata != null && RHIndexdata != 'null') {
          setState(() {
            if (userType == "CUSTOMER") {
              CustomerFormationMasterTabsState
                  .custListBean.imageMaster[19].imgSubType = fingerType;
              CustomerFormationMasterTabsState
                  .custListBean.imageMaster[19].imgString = RHIndexdata;
              CustomerFormationMasterTabsState
                  .custListBean.imageMaster[19].imgType = "FingerPrint";
>>>>>>> .r1143

<<<<<<< .mine
          } else if (userType == "AGENT") {
            _myImage = 'assets/fpsImages/rt_hand_index_selected.png';
          }
        });
      } else {
        _myImage = 'assets/fpsImages/rt_hand_index.png';
=======
              _myImage = 'assets/fpsImages/rt_hand_index_selected.png';
              _AgentRightHandFingureCapture.counterRightHandFinger++;

              //Navigator.pop(context,fingerType+"#"+geTest );

            } else if (userType == "AGENT") {
              _myImage = 'assets/fpsImages/rt_hand_index_selected.png';
            }
          });
        } else {
          _myImage = 'assets/fpsImages/rt_hand_index.png';
        }

        print("RHIndexdata : " + RHIndexdata.toString());
        print("RHIndeximagedata : " + RHIndeximagedata.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
>>>>>>> .r1143
      }
    }else{
      Toast.show("Please select a bluetooth device!", context);
    }

<<<<<<< .mine
      print("RHIndexdata : " + RHIndexdata.toString());
      print("RHIndeximagedata : " + RHIndeximagedata.toString());
    } on PlatformException catch (e) {
      print("FLutter : " + e.message.toString());
    }
=======
>>>>>>> .r1143
  }
}

// class for middle finger
class RightHandMiddleFinger extends StatefulWidget {
  @override
  _RightHandMiddleFinger createState() => new _RightHandMiddleFinger();
}

class _RightHandMiddleFinger extends State<RightHandMiddleFinger> {
  String _myImage = 'assets/fpsImages/rt_hand_middle.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  SharedPreferences prefs;
  static const JsonCodec JSON = const JsonCodec();
  String userType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionVariables();
  }

<<<<<<< .mine
  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
       userType = prefs.get(TablesColumnFile.userType);
      if (userType == "CUSTOMER") {
        if (CustomerFormationMasterTabsState
                    .custListBean.imageMaster[20].imgSubType !=
                null &&
            CustomerFormationMasterTabsState
                    .custListBean.imageMaster[20].imgSubType !=
                "") {
          _myImage = 'assets/fpsImages/rt_hand_middle_selected.png';
          _AgentRightHandFingureCapture.counterRightHandFinger++;
        } else {
          _myImage == 'assets/fpsImages/rt_hand_middle.png';
        }
      } else if (userType == "AGENT") {}
    });
=======
  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userType = prefs.get(TablesColumnFile.userType);
      if (userType == "CUSTOMER") {
        if (CustomerFormationMasterTabsState
                    .custListBean.imageMaster[20].imgSubType !=
                null &&
            CustomerFormationMasterTabsState
                    .custListBean.imageMaster[20].imgSubType !=
                "") {
          _myImage = 'assets/fpsImages/rt_hand_middle_selected.png';
          _AgentRightHandFingureCapture.counterRightHandFinger++;
        } else {
          _myImage == 'assets/fpsImages/rt_hand_middle.png';
        }
      } else if (userType == "AGENT") {}
    });
>>>>>>> .r1143
  }

  void _onClicked() {
<<<<<<< .mine


    if (userType == "CUSTOMER") {
      print("rhcv" +
          _AgentRightHandFingureCapture.counterRightHandFinger.toString());
      if (_AgentRightHandFingureCapture.counterRightHandFinger < 3) {
        _callChannelRHMiddleFinger("RhMiddleFinger");
      } else {
        Toast.show("you have already captured 3 fingers", context);
      }


    } else if (userType == "AGENT") {
      print(
          "rhcv" + _AgentRightHandFingureCapture.counterAgentRHRegist.toString());
      if (_AgentRightHandFingureCapture.counterAgentRHRegist < 1) {
        _callChannelRHMiddleFinger("RhMiddleFinger");
      } else {
        Toast.show("you have already captured Right hand fingers", context);
      }

=======
    if (userType == "CUSTOMER") {
      print("rhcv" +
          _AgentRightHandFingureCapture.counterRightHandFinger.toString());
      if (_AgentRightHandFingureCapture.counterRightHandFinger < 3) {
        _callChannelRHMiddleFinger("RhMiddleFinger");
      } else {
        Toast.show("you have already captured 3 fingers", context);
      }
    } else if (userType == "AGENT") {
      print("rhcv" +
          _AgentRightHandFingureCapture.counterAgentRHRegist.toString());
      if (_AgentRightHandFingureCapture.counterAgentRHRegist < 1) {
        _callChannelRHMiddleFinger("RhMiddleFinger");
      } else {
        Toast.show("you have already captured Right hand fingers", context);
      }
>>>>>>> .r1143
    }
  }

  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage(_myImage);
    var image = new Image(
      image: assetImage,
      fit: BoxFit.fitHeight,
    );
    return new Container(
      child: new FlatButton(
        onPressed: _onClicked,
        child: image,
      ),
    );
  }

  _callChannelRHMiddleFinger(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
<<<<<<< .mine
    String userType = prefs.getString(TablesColumnFile.userType);
    try {
      final String result = await platform.invokeMethod("callingForFPS", {
        "callValue": 0,
        "BluetoothADD": bluetootthAdd,
        "TYPEofFINGER": fingerType,
        "UserType": userType
      });
      // String geTest = '$result';
      var json = JSON.decode(result);
      var RHMiddledata = json['FINGERDATA'];
      var RHMiddleimagedata = json['IMAGEDATA'];

      if (RHMiddledata != null && RHMiddledata != 'null') {
        setState(() {
=======
    String userType = prefs.getString(TablesColumnFile.userType);
    if(bluetootthAdd.toString() !=null&& bluetootthAdd.toString().length >7 ){
      try {
        final String result = await platform.invokeMethod("callingForFPS", {
          "callValue": 0,
          "BluetoothADD": bluetootthAdd,
          "TYPEofFINGER": fingerType,
          "UserType": userType
        });
        // String geTest = '$result';
        var json = JSON.decode(result);
        var RHMiddledata = json['FINGERDATA'];
        var RHMiddleimagedata = json['IMAGEDATA'];
>>>>>>> .r1143
          if (userType == "CUSTOMER") {
            CustomerFormationMasterTabsState
                .custListBean.imageMaster[20].imgSubType = fingerType;
            CustomerFormationMasterTabsState
                .custListBean.imageMaster[20].imgString = RHMiddledata;
            CustomerFormationMasterTabsState
                .custListBean.imageMaster[20].imgType = "FingerPrint";

<<<<<<< .mine
            _myImage = 'assets/fpsImages/rt_hand_middle_selected.png';
            _AgentRightHandFingureCapture.counterRightHandFinger++;
          } else if (userType == "AGENT") {
            _myImage = 'assets/fpsImages/rt_hand_middle_selected.png';
          }
=======
        if (RHMiddledata != null && RHMiddledata != 'null') {
          setState(() {
            if (userType == "CUSTOMER") {
              CustomerFormationMasterTabsState
                  .custListBean.imageMaster[20].imgSubType = fingerType;
              CustomerFormationMasterTabsState
                  .custListBean.imageMaster[20].imgString = RHMiddledata;
              CustomerFormationMasterTabsState
                  .custListBean.imageMaster[20].imgType = "FingerPrint";
>>>>>>> .r1143

<<<<<<< .mine
          // Navigator.pop(context,fingerType+"#"+geTest );
        });
      } else {
        _myImage = 'assets/fpsImages/rt_hand_middle.png';
=======
              _myImage = 'assets/fpsImages/rt_hand_middle_selected.png';
              _AgentRightHandFingureCapture.counterRightHandFinger++;
            } else if (userType == "AGENT") {
              _myImage = 'assets/fpsImages/rt_hand_middle_selected.png';
            }

            // Navigator.pop(context,fingerType+"#"+geTest );
          });
        } else {
          _myImage = 'assets/fpsImages/rt_hand_middle.png';
        }

        print("RHMiddledata : " + RHMiddledata.toString());
        print("RHMiddleimagedata : " + RHMiddleimagedata.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
>>>>>>> .r1143
      }
    }else{
      Toast.show("Please select a bluetooth device!", context);
    }

<<<<<<< .mine
      print("RHMiddledata : " + RHMiddledata.toString());
      print("RHMiddleimagedata : " + RHMiddleimagedata.toString());
    } on PlatformException catch (e) {
      print("FLutter : " + e.message.toString());
    }
=======
>>>>>>> .r1143
  }
}

// class for Ring finger
class RightHandRingFinger extends StatefulWidget {
  @override
  _RightHandRingFinger createState() => new _RightHandRingFinger();
}

class _RightHandRingFinger extends State<RightHandRingFinger> {
  String _myImage = 'assets/fpsImages/rt_hand_ring.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  SharedPreferences prefs;
  static const JsonCodec JSON = const JsonCodec();
  String userType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionVariables();
  }

<<<<<<< .mine
  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
       userType = prefs.get(TablesColumnFile.userType);
      if (userType == "CUSTOMER") {
        if (CustomerFormationMasterTabsState
                    .custListBean.imageMaster[21].imgSubType !=
                null &&
            CustomerFormationMasterTabsState
                    .custListBean.imageMaster[21].imgSubType !=
                "") {
          _myImage = 'assets/fpsImages/rt_hand_ring_selected.png';
          _AgentRightHandFingureCapture.counterRightHandFinger++;
        } else {
          _myImage == 'assets/fpsImages/rt_hand_ring.png';
        }
      } else if (userType == "AGENT") {}
    });
=======
  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userType = prefs.get(TablesColumnFile.userType);
      if (userType == "CUSTOMER") {
        if (CustomerFormationMasterTabsState
                    .custListBean.imageMaster[21].imgSubType !=
                null &&
            CustomerFormationMasterTabsState
                    .custListBean.imageMaster[21].imgSubType !=
                "") {
          _myImage = 'assets/fpsImages/rt_hand_ring_selected.png';
          _AgentRightHandFingureCapture.counterRightHandFinger++;
        } else {
          _myImage == 'assets/fpsImages/rt_hand_ring.png';
        }
      } else if (userType == "AGENT") {}
    });
>>>>>>> .r1143
  }

  void _onClicked() {
<<<<<<< .mine


    if (userType == "CUSTOMER") {
      print("rhcv" +
          _AgentRightHandFingureCapture.counterRightHandFinger.toString());
      if (_AgentRightHandFingureCapture.counterRightHandFinger < 3) {
        _callChannelRHRingFinger("RhRingFinger");
      } else {
        Toast.show("you have already captured 3 fingers", context);
      }

    } else if (userType == "AGENT") {
      print(
          "rhcv" + _AgentRightHandFingureCapture.counterAgentRHRegist.toString());
      if (_AgentRightHandFingureCapture.counterAgentRHRegist < 1) {
        _callChannelRHRingFinger("RhRingFinger");
      } else {
        Toast.show("you have already captured Right hand fingers", context);
      }

=======
    if (userType == "CUSTOMER") {
      print("rhcv" +
          _AgentRightHandFingureCapture.counterRightHandFinger.toString());
      if (_AgentRightHandFingureCapture.counterRightHandFinger < 3) {
        _callChannelRHRingFinger("RhRingFinger");
      } else {
        Toast.show("you have already captured 3 fingers", context);
      }
    } else if (userType == "AGENT") {
      print("rhcv" +
          _AgentRightHandFingureCapture.counterAgentRHRegist.toString());
      if (_AgentRightHandFingureCapture.counterAgentRHRegist < 1) {
        _callChannelRHRingFinger("RhRingFinger");
      } else {
        Toast.show("you have already captured Right hand fingers", context);
      }
>>>>>>> .r1143
    }
  }

  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage(_myImage);
    var image = new Image(
      image: assetImage,
      fit: BoxFit.fitHeight,
    );
    return new Container(
      child: new FlatButton(
        onPressed: _onClicked,
        child: image,
      ),
    );
  }

  _callChannelRHRingFinger(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
<<<<<<< .mine
    String userType = prefs.getString(TablesColumnFile.userType);
    try {
      final String result = await platform.invokeMethod("callingForFPS", {
        "callValue": 0,
        "BluetoothADD": bluetootthAdd,
        "TYPEofFINGER": fingerType,
        "UserType": userType
      });
      //String geTest = '$result';
      var json = JSON.decode(result);
      var RHRingdata = json['FINGERDATA'];
      var RHRingimagedata = json['IMAGEDATA'];

      print("rightringvalue!! : " + RHRingdata);
      if (RHRingdata != null && RHRingdata != 'null') {
        setState(() {
=======
    String userType = prefs.getString(TablesColumnFile.userType);
    if(bluetootthAdd.toString() !=null&& bluetootthAdd.toString().length >7 ){
      try {
        final String result = await platform.invokeMethod("callingForFPS", {
          "callValue": 0,
          "BluetoothADD": bluetootthAdd,
          "TYPEofFINGER": fingerType,
          "UserType": userType
        });
        //String geTest = '$result';
        var json = JSON.decode(result);
        var RHRingdata = json['FINGERDATA'];
        var RHRingimagedata = json['IMAGEDATA'];
>>>>>>> .r1143
          if (userType == "CUSTOMER") {
            CustomerFormationMasterTabsState
                .custListBean.imageMaster[21].imgSubType = fingerType;
            CustomerFormationMasterTabsState
                .custListBean.imageMaster[21].imgString = RHRingdata;
            CustomerFormationMasterTabsState
                .custListBean.imageMaster[21].imgType = "FingerPrint";

<<<<<<< .mine
            _myImage = 'assets/fpsImages/rt_hand_ring_selected.png';
            _AgentRightHandFingureCapture.counterRightHandFinger++;
          } else if (userType == "AGENT") {
            _myImage = 'assets/fpsImages/rt_hand_ring_selected.png';
          }
=======
        print("rightringvalue!! : " + RHRingdata);
        if (RHRingdata != null && RHRingdata != 'null') {
          setState(() {
            if (userType == "CUSTOMER") {
              CustomerFormationMasterTabsState
                  .custListBean.imageMaster[21].imgSubType = fingerType;
              CustomerFormationMasterTabsState
                  .custListBean.imageMaster[21].imgString = RHRingdata;
              CustomerFormationMasterTabsState
                  .custListBean.imageMaster[21].imgType = "FingerPrint";
>>>>>>> .r1143

<<<<<<< .mine
          // Navigator.pop(context,fingerType+"#"+geTest );
        });
      } else {
        _myImage = 'assets/fpsImages/rt_hand_ring.png';
=======
              _myImage = 'assets/fpsImages/rt_hand_ring_selected.png';
              _AgentRightHandFingureCapture.counterRightHandFinger++;
            } else if (userType == "AGENT") {
              _myImage = 'assets/fpsImages/rt_hand_ring_selected.png';
            }

            // Navigator.pop(context,fingerType+"#"+geTest );
          });
        } else {
          _myImage = 'assets/fpsImages/rt_hand_ring.png';
        }

        print("RHRingdata : " + RHRingdata.toString());
        print("RHRingimagedata : " + RHRingimagedata.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
>>>>>>> .r1143
      }
    }else{
      Toast.show("Please select a bluetooth device!", context);
    }

<<<<<<< .mine
      print("RHRingdata : " + RHRingdata.toString());
      print("RHRingimagedata : " + RHRingimagedata.toString());
    } on PlatformException catch (e) {
      print("FLutter : " + e.message.toString());
    }
=======
>>>>>>> .r1143
  }
}

// class for pinky finger
class RightHandPinkyFinger extends StatefulWidget {
  @override
  _RightHandPinkyFinger createState() => new _RightHandPinkyFinger();
}

class _RightHandPinkyFinger extends State<RightHandPinkyFinger> {
  String _myImage = 'assets/fpsImages/rt_hand_pinky.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  SharedPreferences prefs;
  static const JsonCodec JSON = const JsonCodec();
  String userType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionVariables();
  }

<<<<<<< .mine
  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
       userType = prefs.get(TablesColumnFile.userType);
      if (userType == "CUSTOMER") {
        if (CustomerFormationMasterTabsState
                    .custListBean.imageMaster[22].imgSubType !=
                null &&
            CustomerFormationMasterTabsState
                    .custListBean.imageMaster[22].imgSubType !=
                "") {
          _myImage = 'assets/fpsImages/rt_hand_pinky_selected.png';
          _AgentRightHandFingureCapture.counterRightHandFinger++;
        } else {
          _myImage == 'assets/fpsImages/rt_hand_pinky.png';
        }
      } else if (userType == "AGENT") {}
    });
=======
  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userType = prefs.get(TablesColumnFile.userType);
      if (userType == "CUSTOMER") {
        if (CustomerFormationMasterTabsState
                    .custListBean.imageMaster[22].imgSubType !=
                null &&
            CustomerFormationMasterTabsState
                    .custListBean.imageMaster[22].imgSubType !=
                "") {
          _myImage = 'assets/fpsImages/rt_hand_pinky_selected.png';
          _AgentRightHandFingureCapture.counterRightHandFinger++;
        } else {
          _myImage == 'assets/fpsImages/rt_hand_pinky.png';
        }
      } else if (userType == "AGENT") {}
    });
>>>>>>> .r1143
  }

  void _onClicked() {
<<<<<<< .mine


    if (userType == "CUSTOMER") {
      print("rhcv" +
          _AgentRightHandFingureCapture.counterRightHandFinger.toString());
      if (_AgentRightHandFingureCapture.counterRightHandFinger < 3) {
        _callChannelRHPinkyFinger("RhPinkyFinger");
      } else {
        Toast.show("you have already captured 3 fingers", context);
      }


    } else if (userType == "AGENT") {
      print(
          "rhcv" + _AgentRightHandFingureCapture.counterAgentRHRegist.toString());
      if (_AgentRightHandFingureCapture.counterAgentRHRegist < 1) {
        _callChannelRHPinkyFinger("RhPinkyFinger");
      } else {
        Toast.show("you have already captured Right hand fingers", context);
      }

=======
    if (userType == "CUSTOMER") {
      print("rhcv" +
          _AgentRightHandFingureCapture.counterRightHandFinger.toString());
      if (_AgentRightHandFingureCapture.counterRightHandFinger < 3) {
        _callChannelRHPinkyFinger("RhPinkyFinger");
      } else {
        Toast.show("you have already captured 3 fingers", context);
      }
    } else if (userType == "AGENT") {
      print("rhcv" +
          _AgentRightHandFingureCapture.counterAgentRHRegist.toString());
      if (_AgentRightHandFingureCapture.counterAgentRHRegist < 1) {
        _callChannelRHPinkyFinger("RhPinkyFinger");
      } else {
        Toast.show("you have already captured Right hand fingers", context);
      }
>>>>>>> .r1143
    }
  }

  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage(_myImage);
    var image = new Image(
      image: assetImage,
      fit: BoxFit.fitHeight,
    );
    return new Container(
      child: new FlatButton(
        onPressed: _onClicked,
        child: image,
      ),
    );
  }

  _callChannelRHPinkyFinger(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
<<<<<<< .mine
    String userType = prefs.getString(TablesColumnFile.userType);
    try {
      final String result = await platform.invokeMethod("callingForFPS", {
        "callValue": 0,
        "BluetoothADD": bluetootthAdd,
        "TYPEofFINGER": fingerType,
        "UserType": userType
      });
      // String geTest = '$result';
      var json = JSON.decode(result);
      var RHPinkydata = json['FINGERDATA'];
      var RHPinkyimagedata = json['IMAGEDATA'];

      if (RHPinkydata != null && RHPinkydata != 'null') {
        setState(() {
=======
    String userType = prefs.getString(TablesColumnFile.userType);
    if(bluetootthAdd.toString() !=null&& bluetootthAdd.toString().length >7 ){
      try {
        final String result = await platform.invokeMethod("callingForFPS", {
          "callValue": 0,
          "BluetoothADD": bluetootthAdd,
          "TYPEofFINGER": fingerType,
          "UserType": userType
        });
        // String geTest = '$result';
        var json = JSON.decode(result);
        var RHPinkydata = json['FINGERDATA'];
        var RHPinkyimagedata = json['IMAGEDATA'];
>>>>>>> .r1143
          if (userType == "CUSTOMER") {
            CustomerFormationMasterTabsState
                .custListBean.imageMaster[22].imgSubType = fingerType;
            CustomerFormationMasterTabsState
                .custListBean.imageMaster[22].imgString = RHPinkydata;
            CustomerFormationMasterTabsState
                .custListBean.imageMaster[22].imgType = "FingerPrint";

<<<<<<< .mine
            _myImage = 'assets/fpsImages/rt_hand_pinky_selected.png';
            _AgentRightHandFingureCapture.counterRightHandFinger++;
          } else if (userType == "AGENT") {
            _myImage = 'assets/fpsImages/rt_hand_pinky_selected.png';
          }
        });
      } else {
        _myImage = 'assets/fpsImages/rt_hand_pinky.png';
=======
        if (RHPinkydata != null && RHPinkydata != 'null') {
          setState(() {
            if (userType == "CUSTOMER") {
              CustomerFormationMasterTabsState
                  .custListBean.imageMaster[22].imgSubType = fingerType;
              CustomerFormationMasterTabsState
                  .custListBean.imageMaster[22].imgString = RHPinkydata;
              CustomerFormationMasterTabsState
                  .custListBean.imageMaster[22].imgType = "FingerPrint";

              _myImage = 'assets/fpsImages/rt_hand_pinky_selected.png';
              _AgentRightHandFingureCapture.counterRightHandFinger++;
            } else if (userType == "AGENT") {
              _myImage = 'assets/fpsImages/rt_hand_pinky_selected.png';
            }
          });
        } else {
          _myImage = 'assets/fpsImages/rt_hand_pinky.png';
        }

        print("RHPinkydata : " + RHPinkydata.toString());
        print("RHPinkyimagedata : " + RHPinkyimagedata.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
>>>>>>> .r1143
      }
    }else{
      Toast.show("Please select a bluetooth device!", context);
    }

<<<<<<< .mine
      print("RHPinkydata : " + RHPinkydata.toString());
      print("RHPinkyimagedata : " + RHPinkyimagedata.toString());
    } on PlatformException catch (e) {
      print("FLutter : " + e.message.toString());
    }
=======
>>>>>>> .r1143
  }
}
