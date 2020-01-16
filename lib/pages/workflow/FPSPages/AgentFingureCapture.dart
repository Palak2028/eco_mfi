import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/FPSPages/AgentLeftHandFingureCapture.dart';
import 'package:eco_mfi/pages/workflow/FPSPages/AgentRightHandFingureCapture.dart';

class AgentFingureCapture extends StatefulWidget {
  @override
  _AgentFingureCapture createState() => _AgentFingureCapture();
}

class _AgentFingureCapture extends State<AgentFingureCapture> {
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
          padding:
              EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0, bottom: 10.0),
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
                        "Please Pick One",
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 20.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w700,
                            color: Colors.indigo
//          fontStyle: FontStyle.italic
                            ),
                      ),
                    )
                  ],
                ),
                flex: 1,
              ),
              new Flexible(
                child: Row(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[

                    /* new Flexible(child: LeftHandImageAsset(), flex: 1,),
                  new Flexible(child: RightHandImageAsset(), flex: 1,)*/
                    Expanded(

                      child: LeftHandImageAsset(),
                    ),
                    Expanded(
                      child: RightHandImageAsset(),
                    ),
                  ],
                ),
                flex: 3,
              ),

              // FlightBookButton()
            ],
          )),
    );
  }
}

class LeftHandImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('assets/fpsImages/LTHAND.jpg');
    Image image = Image(
      image: assetImage,
      fit: BoxFit.fitHeight,

      /* width: 300.0,
      height: 300.0,*/
    );
    return GestureDetector(
      onTap: () async {
      /*  print("onTap called.");
        globals.Dialog.alertPopup(context, "Left Hand",
            "you just clicked on Left hand image", "Dashboard");*/
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
              new AgentLeftHandFingureCapture()), //When Authorized Navigate to the next screen
        ).then((onVal){
          print("rtturbed $onVal");
          Navigator.pop(context,onVal);
        });
      },
      child: image,
    );
  }
}

class RightHandImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('assets/fpsImages/RTHAND.jpg');
    Image image = Image(
      image: assetImage,
      fit: BoxFit.contain,

      // width: 300.0,
      //  height: 300.0,
    );
    return GestureDetector(
      onTap: ()  async {
       /* print("onTap called.");
        globals.Dialog.alertPopup(context, "Right Hand",
            "you just clicked on Right hand image", "Dashboard");*/
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
              new AgentRightHandFingureCapture()), //When Authorized Navigate to the next screen
        ).then((onVal){
          print("rtturbed $onVal");
          Navigator.pop(context,onVal);
        });
      },
      child: image,
    );
  }
}
