import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/NewTermDeposit.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/BluetoothPair.dart';
import 'package:eco_mfi/pages/workflow/FPSPages/AgentFingureCapture.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/TermDepositList.dart';
import 'package:toast/toast.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/TDClosure.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/DeviceSetting.dart';


class TermDepositDashboard extends StatefulWidget {
  @override
  _TermDepositDashboard createState() => _TermDepositDashboard();
}

class _TermDepositDashboard extends State<TermDepositDashboard> {
  GestureDetector gestureDetector(name, image) {
    return new GestureDetector(
      child: new RaisedButton(
          elevation: 2.0,
          highlightColor: Colors.black,
          splashColor: Colors.white70,
          colorBrightness: Brightness.dark,
          color: Colors.white,
          onPressed: () {
            if (name == "TD calculator") {
              print("TD calculator");
//              Toast.show("Coming soon", context,duration: Toast.LENGTH_LONG);
              Navigator.push(
                context,
                new MaterialPageRoute(
                 // builder: (context) => new BluetoothPair(),
                  builder: (context) => new AgentFingureCapture(),
                ), //When Authorized Navigate to the next screen
              );
              /*   globals.Dialog.alertPopup(context, "This module is locked",
                  "Please ask support team To open this", "Dashboard");*/
            } else if (name == "Open TD") {
              print("Open TD");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new TermDepositList()
                   // new NewTermDeposit()
                        ), //When Authorized Navigate to the next screen
              );
            } else if (name == "ClousureTD") {
              // AppDatabase.get().getProductList(30,1);
              print("ClousureTD");
               Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                new TDClosure()), //When Authorized Navigate to the next screen
          );
              /*globals.Dialog.alertPopup(context, "This module is locked",
                  "Please ask support team To open this", "Dashboard");*/
            } else if (name == "Printing") {
              print("Printing");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        new DeviceSetting()), //When Authorized Navigate to the next screen
              );
            }
          },
          child: new FittedBox(
            alignment: Alignment.center,
            fit: BoxFit.none,
            child: new Column(
              children: <Widget>[
                new Image(
                  image: new AssetImage(image),
                ),
                SizedBox.fromSize(),
                new Center(
                  child: new Text(
                    name,
                    style: new TextStyle(
                      color: Color(0xff07426A),
                      fontSize: 20.0,
                    ),
                  ),
                  heightFactor: 2.0,
                )
              ],
            ),
          )),
    );

    /*return new Card(
        elevation: 1.5,
        color: Colors.white,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            new Image(image: new AssetImage(image)),
            new Center(
              child: new Text(name),
              heightFactor: 0.00,
            )
          ],
        ));*/
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Term Deposit Dashboard",
          style: TextStyle(color: Colors.white),
          ),
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
          ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,


        ),


      body:new GridView.count(
        primary: true,
        padding: const EdgeInsets.all(1.0),
        crossAxisCount: 2,
        shrinkWrap: true,
        childAspectRatio: 0.80,
        mainAxisSpacing: 3.5,
        crossAxisSpacing: 3.5,
        children: <Widget>[
         // gestureDetector("TD calculator", "assets/create_centers.png"),
          gestureDetector("Open TD", "assets/group_foundation.png"),
          gestureDetector("ClousureTD", "assets/prospect_creation.png"),
          gestureDetector("Printing", "assets/CIF_COLORFUL.png"),
          //gestureDetector("Login Biometric", "assets/CIF_COLORFUL.png"),
        ],
        ),
      );
  }

 
}
