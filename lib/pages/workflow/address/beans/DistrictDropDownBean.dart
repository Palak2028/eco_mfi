import 'package:eco_mfi/db/TablesColumnFile.dart';

class DistrictDropDownList {
  int distCd;
  String distDesc;
  String stateCd;
  DateTime createdAt;

  DistrictDropDownList({this.distCd, this.distDesc, this.stateCd, this.createdAt});

  factory DistrictDropDownList.fromMap(Map<String, dynamic> map) {
    return DistrictDropDownList(
      distCd: map[TablesColumnFile.distCd] as int,
      distDesc: map[TablesColumnFile.distDesc] as String,
      stateCd: map[TablesColumnFile.stateCd] as String,
      createdAt: map[TablesColumnFile.createdAt]=="null"||map[TablesColumnFile.createdAt]==null?null:DateTime.parse(map[TablesColumnFile.createdAt]) as DateTime,
    );
  }

  factory DistrictDropDownList.mapFromMiddleware(Map<String, dynamic> map) {


    return DistrictDropDownList(
        distCd: map[TablesColumnFile.mdistcd] as int,
        distDesc: map[TablesColumnFile.mdistdesc] as String,
        stateCd: map[TablesColumnFile.mstatecd].toString().trim() as String,
        createdAt: map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime);

  }

}
