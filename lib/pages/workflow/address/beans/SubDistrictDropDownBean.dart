import 'package:eco_mfi/db/TablesColumnFile.dart';

class SubDistrictDropDownList {
  String placeCd;
  String placeCdDesc;
  int distCd;
  DateTime createdAt;

  SubDistrictDropDownList({this.placeCd, this.placeCdDesc, this.distCd, this.createdAt});

  factory SubDistrictDropDownList.fromMap(Map<String, dynamic> map) {
    return SubDistrictDropDownList(
      placeCd: map[TablesColumnFile.placeCd] as String,
      placeCdDesc: map[TablesColumnFile.placeCdDesc] as String,
      distCd: map[TablesColumnFile.distCd] as int,
      createdAt: map[TablesColumnFile.createdAt]=="null"||map[TablesColumnFile.createdAt]==null?null:DateTime.parse(map[TablesColumnFile.createdAt]) as DateTime,
    );
  }

  factory SubDistrictDropDownList.mapFromMiddleware(Map<String, dynamic> map) {

    return SubDistrictDropDownList(
        placeCd: map[TablesColumnFile.mplacecd] as String,
        placeCdDesc: map[TablesColumnFile.mplacecddesc].toString().trim() as String,
        distCd: map[TablesColumnFile.mdistcd] as int,
        createdAt: map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime);

  }
}
