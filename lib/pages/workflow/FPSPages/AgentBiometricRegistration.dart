import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationCenterAndGroupDetails.dart';
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/FPSPages/AgentLeftHandFingureCapture.dart';
import 'package:eco_mfi/pages/workflow/FPSPages/AgentRightHandFingureCapture.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/Utilities/app_constant.dart' as constant;

import '../../../LoginBean.dart';
import '../../../translations.dart';
import 'AgentFingureCapture.dart';

class AgentBiometricRegistration extends StatefulWidget {
  @override
  _AgentBiometricRegistration createState() => _AgentBiometricRegistration();
}

class _AgentBiometricRegistration extends State<AgentBiometricRegistration> {

  LoginBean beanObj = new LoginBean();

  @override
  void initState() {
    getSessionVariables();
  }

  void getSessionVariables() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      beanObj.musrcode = prefs.get(TablesColumnFile.musrcode);
    });

  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return   new Card(

      //color Color(0xff2f1f4),
      /* shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.black,style: BorderStyle.solid)
                        ),*/
      elevation: 25.0,

      child: new Padding(
        padding: new EdgeInsets.only(
          left: 3.0,
          right: 3.0,
        ),
        child: Column(
          children: <Widget>[
            new Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Flexible(
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: <Widget>[
                              /* new Flexible(child: LeftHandImageAsset(), flex: 1,),
                  new Flexible(child: RightHandImageAsset(), flex: 1,)*/
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text(
                                      'Agent Biometric Registration',
                                      style: TextStyle(fontStyle: FontStyle.italic, fontSize: 17.0)),
                                ),
                              ),
                              Expanded(
                                child: new TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: constant.userCode,
                                    labelText: constant.userCode,
                                    hintStyle: TextStyle(color: Colors.grey),
                                    enabled: false,
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        )),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        )),
                                    contentPadding: EdgeInsets.all(20.0),
                                  ),
                                  enabled: false,
                                  controller: new TextEditingController(text: beanObj.musrcode),

                                ),
                              ),
                              Expanded(
                                child: new Container(
                                    child: ConstrainedBox(
                                        constraints:
                                        BoxConstraints
                                            .tightFor(
                                            height: 100.0,
                                            width:
                                            100.00),
                                        // for positioning of icon of scanner
                                        child: FlatButton(
                                            onPressed: ()async {
                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                              prefs.setString(TablesColumnFile.userType, "AGENT");
                                              Navigator.push(context, SlideRightRoute(page: new AgentFingureCapture())).then((onVal) {
                                                print("AgentFinger>>> $onVal");

                                              });

                                            },
                                            child: Image.asset(
                                                "assets/fpsImages/agent_biometric_img.png")))),
                              ),
                            ],
                          ),
                          flex: 3,
                        ),

                      ],
                    ),
                  /*  Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Flexible(
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: <Widget>[
                              *//* new Flexible(child: LeftHandImageAsset(), flex: 1,),
                  new Flexible(child: RightHandImageAsset(), flex: 1,)*//*
                              new Container(
                                  padding: const EdgeInsets.only( top: 20.0),
                                  child: new RaisedButton(
                                      child: Text(
                                        Translations.of(context).text('Register'),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {

                                      }))
                            ],
                          ),
                          flex: 3,
                        ),

                      ],
                    ),*/
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

