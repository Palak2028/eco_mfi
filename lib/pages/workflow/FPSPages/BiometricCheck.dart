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

class BiometricCheck extends StatefulWidget {
  // BiometricCheck({this.mIsCustomerSelected});

  @override
  _BiometricCheck createState() => _BiometricCheck();
}

class _BiometricCheck extends State<BiometricCheck> {
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

class FingerScannerImageAsset extends StatefulWidget {
  int trefno;
  int mrefno;
  final String mIsCustomerSelected;
  final bool isButtonDisabled;
  final bool isOnline;
  final int custno;
  final String routeType;

  FingerScannerImageAsset({this.mIsCustomerSelected, this.mrefno, this.trefno, this.isButtonDisabled,this.isOnline,this.custno,this.routeType});

  _FingerScannerImageAsset createState() => _FingerScannerImageAsset();
}

class _FingerScannerImageAsset extends State<FingerScannerImageAsset> {
  List<ImageBean> bean = new List<ImageBean>();
  String _myImage = 'assets/fpsImages/finger_scan_logo_grey.png';

  AssetImage assetImage =
      AssetImage('assets/fpsImages/finger_scan_logo_grey.png');

  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  SharedPreferences prefs;

  String LhThumbValue ="" ;
  String LhIndexFingerValue ="" ;
  String LhMiddleFingerValue ="" ;
  String LhRingFingerValue ="" ;
  String LhPinkyFingerValue ="" ;

  String RhThumbValue ="" ;
  String RhIndexFingerValue ="" ;
  String RhMiddleFingerValue ="" ;
  String RhRingFingerValue ="" ;
  String RhPinkyFingerValue ="" ;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var assetImage = new AssetImage(_myImage);

    Image image = Image(
      image: assetImage,
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
      width: 100.0,
      height: 100.0,
    );
    return GestureDetector(
      onTap: () {
        if (widget.mIsCustomerSelected == "Y") {
          getFingure();
        } else {
          Toast.show("Please Select Customer First", context);
        }
      },
      child: image,
    );
  }

  Future<Null> getFingure() async {
    prefs = await SharedPreferences.getInstance();

    if (widget.mIsCustomerSelected == "Y") {
      //get finger print
       LhThumbValue ="" ;
       LhIndexFingerValue ="" ;
       LhMiddleFingerValue ="" ;
       LhRingFingerValue ="" ;
       LhPinkyFingerValue ="" ;
       RhThumbValue ="" ;
       RhIndexFingerValue ="" ;
       RhMiddleFingerValue ="" ;
       RhRingFingerValue ="" ;
       RhPinkyFingerValue ="" ;


      if(widget.isOnline==true){
        await AppDatabase.get()
            .getFingerListByCustNo(widget.custno)
            .then((List<ImageBean> imageBean) async  {
          bean = imageBean;
          if (bean.isNotEmpty) {
            print(" Found in Appdatabase");
            setImage(bean);

          }else {

            print("Not Found in Appdatabase Trying online");
            GetCustomerFromMiddleware getBiometricData = GetCustomerFromMiddleware();
            await getBiometricData.getImageFromMiddleware(widget.custno).then((List<ImageBean> imageBean){
              bean = imageBean;
              if (bean.isNotEmpty) {
                print("Returning Bean ${bean}");
                setImage(bean);
              }else {
                Toast.show("Fingure Prints Not Matched!!", context);
                return;

              }

            });







          }
        });


      }else{
        await AppDatabase.get()
            .getFingerList(widget.trefno, widget.mrefno)
            .then((List<ImageBean> imageBean) {
          bean = imageBean;
          if (bean.isNotEmpty) {
            for ( int i = 0; i < bean.length; i++ ) {
              print ("bean" + bean.toString ());
              if (bean[i].imgSubType == "LhThumb") {
                // prefs.setString("LhThumb", bean[0].imgString);
                LhThumbValue = bean[i].imgString;
              }
              if (bean[i].imgSubType == "LhIndexFinger") {
                // prefs.setString("LhIndexFinger", bean[0].imgString);
                LhIndexFingerValue = bean[i].imgString;
              }
              if (bean[i].imgSubType == "LhMiddleFinger") {
                // prefs.setString("LhMiddleFinger", bean[0].imgString);
                LhMiddleFingerValue = bean[i].imgString;
              }
              if (bean[i].imgSubType == "LhRingFinger") {
                // prefs.setString("LhRingFinger", bean[i].imgString);
                LhRingFingerValue = bean[i].imgString;
              }
              if (bean[i].imgSubType == "LhPinkyFinger") {
                //  prefs.setString("LhPinkyFinger", bean[i].imgString);
                LhPinkyFingerValue = bean[i].imgString;
              }

              if (bean[i].imgSubType == "RhThumb") {
                print("Setting RH THUMb");
//            prefs.setString("RhThumb", bean[i].imgString);
                RhThumbValue = bean[i].imgString;
              }
              if (bean[i].imgSubType == "RhIndexFinger") {
                print("Setting RH Index Fingure");
                // prefs.setString("RhIndexFinger", bean[i].imgString);
                RhIndexFingerValue = bean[i].imgString;
              }
              if (bean[i].imgSubType == "RhMiddleFinger") {
                print("Setting RH Middle Fingure");
                // prefs.setString("RhMiddleFinger", bean[i].imgString);
                RhMiddleFingerValue = bean[i].imgString;
              }
              if (bean[i].imgSubType == "RhRingFinger") {
                //  prefs.setString("RhRingFinger", bean[i].imgString);
                RhRingFingerValue = bean[i].imgString;
              }
              if (bean[i].imgSubType == "RhPinkyFinger") {
                // prefs.setString("RhPinkyFinger", bean[i].imgString);
                RhPinkyFingerValue = bean[i].imgString;
              }
            }
          }else {
            Toast.show("Fingure Prints Not Found!!", context);
            return;
          }
        });

      }

    }

    await _callChannelFPSMatch();
  }

  _callChannelFPSMatch() async {
    //  prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    print("Sending Value is $RhMiddleFingerValue");
    print("Sending Value is $RhIndexFingerValue");
    print("Sending Value is  for LH Index $LhIndexFingerValue");
    print("Sending Value is  LH MIDDle $LhMiddleFingerValue");
    print("Sending Value is  LH Thumb $LhThumbValue");
    try {
        final String result = await platform.invokeMethod("callingForFPSMatch", {
        "callValue": 0,
        "BluetoothADD": bluetootthAdd,
        "LhThumbValue": LhThumbValue,
        "LhIndexFingerValue": LhIndexFingerValue,
        "LhMiddleFingerValue": LhMiddleFingerValue,
        "LhRingFingerValue": LhRingFingerValue,
        "LhPinkyFingerValue": LhPinkyFingerValue,

        "RhThumbValue": RhThumbValue,
        "RhIndexFingerValue": RhIndexFingerValue,
        "RhMiddleFingerValue": RhMiddleFingerValue,
        "RhRingFingerValue": RhRingFingerValue,
        "RhPinkyFingerValue": RhPinkyFingerValue,
          // TODO pass dynamic blutooth address
      });
      String geTest = '$result';



      if (result == '-5') {
        setState(() {
          _myImage = 'assets/fpsImages/finger_scan_logo_green.png';
          globals.fingerPrintAuthForTDDone=true;

          if(widget.routeType=="Loan Application"){
            globals.fingerPrintAuthForLoanApplicationDone=true;

          }
          // Navigator.pop(context, true);
        });
      } else if (result == '-1') {
        setState(() {
          _myImage = 'assets/fpsImages/finger_scan_logo_black.png';
          //  Navigator.pop(context, false);
          globals.fingerPrintAuthForTDDone=false;
          if(widget.routeType=="Loan Application"){
            globals.fingerPrintAuthForLoanApplicationDone=false;

          }
          _showAlertForFPSMismatch();
        });
      }else if (result == '0') {
        setState(() {
          _myImage = 'assets/fpsImages/finger_scan_logo_black.png';
          //  Navigator.pop(context, false);
          globals.fingerPrintAuthForTDDone=false;
          if(widget.routeType=="Loan Application"){
            globals.fingerPrintAuthForLoanApplicationDone=false;

          }
         _showAlertForFPSMismatch();
        });
      }
      print("FLutter : " + geTest.toString());
    } on PlatformException catch (e) {
      print("FLutter : " + e.message.toString());
    }
  }

  Future<void> _showAlertForFPSMismatch() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text("Finger Print not Found!! For continuing further Please Accept the Declaration"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
<<<<<<< .mine
                Text('$error'),
=======
               // Text('$error'),
>>>>>>> .r1143
              ],
            ),
          ),
          actions: <Widget>[
           /* FlatButton(
              child: Text(Translations.of(context).text('Yes')),
              onPressed: () {
                //saveData();
                Navigator.of(context).pop();
                setState(() {

                });
              },
            ),*/
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((val)
        {
          setState(() {

          });
        });
  }
//Your code here




    void setImage(List<ImageBean> imageBean){

      for ( int i = 0; i < bean.length; i++ ) {
        print ("bean" + bean.toString ());
        if (bean[i].imgSubType == "LhThumb") {
          print("Setting fro LHTHUMB");
          // prefs.setString("LhThumb", bean[0].imgString);
          LhThumbValue = bean[i].imgString;
        }
        if (bean[i].imgSubType == "LhIndexFinger") {
          print("Setting fro Lh Index Fingure");
          // prefs.setString("LhIndexFinger", bean[0].imgString);
          LhIndexFingerValue = bean[i].imgString;
        }
        if (bean[i].imgSubType == "LhMiddleFinger") {
          // prefs.setString("LhMiddleFinger", bean[0].imgString);
          LhMiddleFingerValue = bean[i].imgString;
        }
        if (bean[i].imgSubType == "LhRingFinger") {
          // prefs.setString("LhRingFinger", bean[i].imgString);
          LhRingFingerValue = bean[i].imgString;
        }
        if (bean[i].imgSubType == "LhPinkyFinger") {
          //  prefs.setString("LhPinkyFinger", bean[i].imgString);
          LhPinkyFingerValue = bean[i].imgString;
        }

        if (bean[i].imgSubType == "RhThumb") {
          print("Setting For Rh Thumb");
//            prefs.setString("RhThumb", bean[i].imgString);
          RhThumbValue = bean[i].imgString;
        }
        if (bean[i].imgSubType == "RhIndexFinger") {
          // prefs.setString("RhIndexFinger", bean[i].imgString);
          print("Settinh For index Finger");
          print(bean[i].imgString);
          RhIndexFingerValue = bean[i].imgString;
        }
        if (bean[i].imgSubType == "RhMiddleFinger") {
          print("Settinh For middle Finger");
          print(bean[i].imgString);
          // prefs.setString("RhMiddleFinger", bean[i].imgString);
          RhMiddleFingerValue = bean[i].imgString;
        }
        if (bean[i].imgSubType == "RhRingFinger") {
          //  prefs.setString("RhRingFinger", bean[i].imgString);
          RhRingFingerValue = bean[i].imgString;
        }
        if (bean[i].imgSubType == "RhPinkyFinger") {
          // prefs.setString("RhPinkyFinger", bean[i].imgString);
          RhPinkyFingerValue = bean[i].imgString;
        }
      }





    }


}
