import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetCustomerFromMiddleware.dart';
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/FPSPages/AgentLeftHandFingureCapture.dart';
import 'package:eco_mfi/pages/workflow/FPSPages/AgentRightHandFingureCapture.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../../../translations.dart';

class AgentBiometricCheck extends StatefulWidget {
  // BiometricCheck({this.mIsCustomerSelected});

  @override
  _AgentBiometricCheck createState() => _AgentBiometricCheck();
}

class _AgentBiometricCheck extends State<AgentBiometricCheck> {
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(10.0),
            children: <Widget>[
              new Text(
                "Biometric Check",
                textAlign: TextAlign.center,
              ),
            ]));
  }
}


