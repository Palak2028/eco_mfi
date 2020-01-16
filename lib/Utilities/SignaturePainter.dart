import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:simple_permissions/simple_permissions.dart';
import 'package:permission/permission.dart';

const directoryName = 'Signature';


class SignApp extends StatefulWidget {
  ByteData _imgPassOn = ByteData(0);

  @override
  State<StatefulWidget> createState() {
    return SignAppState();
  }
}

class SignAppState extends State<SignApp> {
  GlobalKey<SignatureState> signatureKey = GlobalKey();
  var image;
 // String _platformVersion = 'Unknown';

//  var permissions =  Permission.getPermissionsStatus([PermissionName.Storage]);

 // var permissionNames =  Permission.requestPermissions([PermissionName.Storage, PermissionName.Camera]);

  //Permission _permission = Permission.WriteExternalStorage;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  initPlatformState() async {
    String platformVersion;
    try {
     // platformVersion = await SimplePermissions.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
    //  _platformVersion = platformVersion;
    });
    //print(_platformVersion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Signature(
          key: signatureKey),
      bottomNavigationBar: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
        MaterialButton(
          color: Colors.green,
          child: Text('Clear'),
          onPressed: () {
            signatureKey.currentState.clearPoints();
          },
        ),
        MaterialButton(
          color: Colors.grey,
          child: Text('Save'),
          onPressed: () async{
             await  signatureKey.currentState.rendered.then((onValue)async{
               setState(() {
                 image = onValue;
               });
               if(image!=null)
                 await showImage(context);
             });

          },
        ),
  ],

      ),

    );
  }

  Future<Null> showImage(BuildContext context) async {
    var pngBytes = await image.toByteData(format: ui.ImageByteFormat.png);
    widget._imgPassOn = pngBytes;
    Navigator.pop(context, widget._imgPassOn );

  }




}

class Signature extends StatefulWidget {
  Signature({Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SignatureState();
  }
}

class SignatureState extends State<Signature> {
  List<Offset> _points = <Offset>[];

  Future<ui.Image> get rendered async{
    ui.PictureRecorder recorder = await ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    SignaturePainter painter = SignaturePainter(points: _points);
    var size = context.size;
    painter.paint(canvas, size);
    return  recorder.endRecording()
        .toImage(size.width.floor(), size.height.floor());
  }


/*  ui.Image get rendered {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    SignaturePainter painter = SignaturePainter(points: _points);
    var size = context.size;
    painter.paint(canvas, size);
    return  recorder.endRecording()
        .toImage(size.width.floor(), size.height.floor());
  }*/

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            RenderBox _object = context.findRenderObject();
            Offset _locationPoints = _object.localToGlobal(details.globalPosition);
            _points = new List.from(_points)..add(_locationPoints);
          });
        },
        onPanEnd: (DragEndDetails details) {
          setState(() {
            _points.add(null);
          });
        },
        child: CustomPaint(
          painter: SignaturePainter(points: _points),
          size: Size.infinite,
        ),
      ),

    );
  }

  void clearPoints() {
    setState(() {
      _points.clear();
    });
  }
}


class SignaturePainter extends CustomPainter {
  List<Offset> points = <Offset>[];

  SignaturePainter({this.points});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 5.0;

    for(int i=0; i < points.length - 1; i++) {
      if(points[i] != null && points[i+1] != null) {
        canvas.drawLine(points[i], points[i+1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) {
    return oldDelegate.points != points;
  }

}