import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:permission/permission.dart';


class OpenCamera extends StatefulWidget {


  OpenCamera();

  String filePath = "";

  @override
  _OpenCameraState createState() => new _OpenCameraState();
}

/*
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw ArgumentError('Unknown lens direction');
}*/

class _OpenCameraState extends State<OpenCamera> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
  /*
 CameraController controller;
  String imagePath;

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    controller =
        new CameraController(widget.cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      */
/*  if (!controller.value.isInitialized) {
      body: new Container();
    }*//*

      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: new AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: new CameraPreview(
                    controller,
                  )),
            ),
          ),
          _captureControlRowWidget(),
        ],
      ),
    );
  }

  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[

        IconButton(
          padding: EdgeInsets.only(bottom: 100.0),
          icon: const Icon(
            Icons.camera_alt,
            size: 50.0,
          ),
          color: Colors.black,
          onPressed: controller != null && controller.value.isInitialized
              ? onTakePictureButtonPressed
              : null,
        ),
      ],
    );
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });
        if (filePath != null) showInSnackBar('$filePath');
      }
    });
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/microfinance';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';
    print("filepath here is " + filePath);
    widget.filePath = filePath;
    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
    //globals._mockService();
    Navigator.pop(context, message);
  }

  void _showCameraException(CameraException e) {
    // logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
*/
}
