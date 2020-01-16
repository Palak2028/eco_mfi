import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/SpeedoMeter/bean/SpeedoMeterBean.dart';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class SpeedoMeterServices {
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();
  String _serviceUrl;

  /*Future<Null> syncSpeedoMeter(List listValue) async {

  }*/

  Future<String> _toJson(SpeedoMeterBean bean) async{
    var mapData = new Map();
    var mapIdData = new Map();
    mapIdData["usrname"] = bean.usrName;
    mapIdData["effdate"] = bean.effDate.toIso8601String();

    mapData['compositeSpeedoMeterId'] = mapIdData;
    if (bean.startingFromImg != null && bean.startingFromImg != "null") {
      File imageFile = new File(bean.startingFromImg);
      final Directory extDir = await getApplicationDocumentsDirectory();
      var targetPath = extDir.absolute.path + "/temp.png";
      var imgFile = await compressAndGetFile(imageFile, targetPath);
      List<int> imageBytes = imgFile.readAsBytesSync();
      String base64Image = base64.encode(imageBytes);
      /*
  String base64Image = base64.encode(imageBytes);
  File imageFile = new File(prospect.NOCImageString);
  List<int> imageBytes = imageFile.readAsBytesSync();
  String base64Image = base64.encode(imageBytes);*/

      mapData["startingfromimg"] = base64Image;
    } else
      mapData["startingfromimg"] = null;
   // mapIdData["startingfromimg"] = bean.startingFromImg;
    if (bean.endingFromImg != null && bean.endingFromImg != "null") {
      File imageFile = new File(bean.endingFromImg);
      final Directory extDir = await getApplicationDocumentsDirectory();
      var targetPath = extDir.absolute.path + "/temp.png";
      var imgFile = await compressAndGetFile(imageFile, targetPath);
      List<int> imageBytes = imgFile.readAsBytesSync();
      String base64Image1 = base64.encode(imageBytes);
      /*
  String base64Image = base64.encode(imageBytes);
  File imageFile = new File(prospect.NOCImageString);
  List<int> imageBytes = imageFile.readAsBytesSync();
  String base64Image = base64.encode(imageBytes);*/

      mapData["endingFromImg"] = base64Image1;
    } else
      mapData["endingFromImg"] = null;
    //mapData["endingfromimg"] = bean.endingFromImg;
    mapData["startingpoint"] = bean.startingPoint;
    mapData["endingpoint"] = bean.endingPoint;
    mapData["totmeterreading"] = bean.totMeterReading;
    mapData["createdAt"] = bean.createdAt.toIso8601String();
    mapData["updatedAt"] = bean.updatedAt.toIso8601String();
    mapData["createdBy"] = bean.createdBy;
    mapData["updatedBy"] = bean.updatedBy;
    mapData["geoLocation"] = bean.geoLocation;
    mapData["geoLatitude"] = bean.geoLatitude;
    mapData["geoLongitude"] = bean.geoLongitude;
    mapData["isDataSynced"] = 1;
    String json = JSON.encode(mapData);
    return json;
  }
  Future<File> compressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: 88,
      //rotate: 180,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  Future<Null> getAndSync() async {
    List _speedoMeterList = new List();
    //try {
      await AppDatabase.get().getSpeedoMeterDetailsNotSynced().then((spmeterList) async{
        for (int i = 0; i < spmeterList.length; i++) {
          await _toJson(spmeterList[i]).then((onValue) async {
            _speedoMeterList.add(onValue.toString());
          });
        }
        print(_speedoMeterList);
        _serviceUrl = "/speedoMeterData/add/";

        //try {

          final bodyValue = await http.post(Constant.myPublicURL.toString()+_serviceUrl.toString(), headers: _headers, body: _speedoMeterList.toString());
          if(bodyValue.statusCode==200){
            for(var items in spmeterList){
              AppDatabase.get().updateSpeedometerIsDataSynced(items.usrName, items.effDate);
            }

          }
          if(bodyValue == "404" ){
            return null;
          }

//        } catch (e) {
//          print('Server Exception!!!');
//          print(e);
//        }

      });



    }

    /*catch (e) {
      print('Server Exception!!!');

    }
  }*/

}
