

import 'package:eco_mfi/db/TablesColumnFile.dart';

class SpeedoMeterBean {

  String geoLatitude;
  String geoLongitude;
  String geoLocation;
  String startingFromImg;
  String endingFromImg;
  int startingPoint;
  int endingPoint;
  int totMeterReading;
  DateTime effDate;
  String usrName;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  String updatedBy;
  int isDataSynced;

  SpeedoMeterBean(
      {this.geoLatitude,
        this.geoLongitude,
        this.geoLocation,
        this.startingFromImg,
        this.endingFromImg,
        this.startingPoint,
        this.endingPoint,
        this.totMeterReading,
        this.effDate,
        this.usrName,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.isDataSynced});


  @override
  String toString() {
    return 'SpeedoMeterBean{geoLatitude: $geoLatitude, geoLongitude: $geoLongitude, geoLocation: $geoLocation, startingFromImg: $startingFromImg, endingFromImg: $endingFromImg, startingPoint: $startingPoint, endingPoint: $endingPoint, totMeterReading: $totMeterReading, effDate: $effDate, usrName: $usrName, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy , isDataSynced: $isDataSynced}';
  }

  factory SpeedoMeterBean.fromMap(Map<String, dynamic> map) {
    return SpeedoMeterBean(
        geoLocation: map[TablesColumnFile.geoLocation] as String,
        geoLatitude: map[TablesColumnFile.geoLatitude] as String,
        geoLongitude: map[TablesColumnFile.geoLongitude] as String,
        startingFromImg:map[TablesColumnFile.startingFromImg] as String,
        endingFromImg:map[TablesColumnFile.endingFromImg] as String,
        startingPoint:map[TablesColumnFile.startingPoint] as int,
        endingPoint:map[TablesColumnFile.endingPoint] as int,
        totMeterReading:map[TablesColumnFile.totMeterReading] as int,
        effDate: map[TablesColumnFile.effDate]=="null"||map[TablesColumnFile.effDate]==null?null:DateTime.parse(map[TablesColumnFile.effDate]) as DateTime,
       // effDate:DateTime.parse(map[TablesColumnFile.effDate]) as DateTime,
        usrName:map[TablesColumnFile.usrName] as String,
        createdAt: map[TablesColumnFile.createdAt]=="null"||map[TablesColumnFile.createdAt]==null?null:DateTime.parse(map[TablesColumnFile.createdAt]) as DateTime,
        updatedAt: map[TablesColumnFile.updatedAt]=="null"||map[TablesColumnFile.updatedAt]==null?null:DateTime.parse(map[TablesColumnFile.updatedAt]) as DateTime,
        createdBy: map[TablesColumnFile.createdBy] as String,
        updatedBy: map[TablesColumnFile.updatedBy] as String,
        isDataSynced: map[TablesColumnFile.isDataSynced] as int,
    );
  }
}
