

import 'package:eco_mfi/db/TablesColumnFile.dart';

class NOCImageBean {

  int adhaarNo;
  int serialNo;
  String NOCImageString;
  DateTime createdAt;
  DateTime updatedAt;
  String nameOfMFI;
  int isDataSynced;


  NOCImageBean(
      {
        this.adhaarNo,
        this.serialNo,
        this.NOCImageString,
        this.nameOfMFI,
        this.createdAt,
        this.updatedAt,
        this.isDataSynced

      });

  factory NOCImageBean.fromMap(Map<String, dynamic> map) {
    print("inside map");
    return NOCImageBean(
        adhaarNo: map[TablesColumnFile.trefno] as int,
        NOCImageString: map[TablesColumnFile.NOCImageString] as String,
        createdAt: DateTime.parse(map[TablesColumnFile.createdAt]) as DateTime,
        updatedAt: DateTime.parse(map[TablesColumnFile.updatedAt]) as DateTime,
        isDataSynced: map[TablesColumnFile.isDataSynced] as int,
        nameOfMFI: map[TablesColumnFile.mnameofmfi] as String,
        serialNo: map[TablesColumnFile.serialNo] as int);

  }
}
