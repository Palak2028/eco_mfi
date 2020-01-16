import 'package:eco_mfi/db/TablesColumnFile.dart';

class AreaDropDownList {
  int areaCd;
  String placeCd;
  String areaDesc;
  DateTime createdAt;
  CompositeAreaId compositeAreaId;

  AreaDropDownList({this.areaCd, this.placeCd, this.areaDesc, this.createdAt, this.compositeAreaId});

  @override
  String toString() {
    return 'AreaDropDownList{areaCd: $areaCd, placeCd: $placeCd, areaDesc: $areaDesc, createdAt: $createdAt, compositeAreaId: $compositeAreaId}';
  }


  factory AreaDropDownList.fromMap(Map<String, dynamic> map) {
    return AreaDropDownList(
      areaCd: map[TablesColumnFile.areaCd] as int,
      placeCd: map[TablesColumnFile.placeCd] as String,
      areaDesc: map[TablesColumnFile.areaDesc] as String,
      createdAt: map[TablesColumnFile.createdAt]=="null"||map[TablesColumnFile.createdAt]==null?null:DateTime.parse(map[TablesColumnFile.createdAt]) as DateTime,
    );
  }

  factory AreaDropDownList.mapFromMiddleware(Map<String, dynamic> map) {

    return AreaDropDownList(
        compositeAreaId:CompositeAreaId.mapFromMiddleware(map["compositeAreaId"]),
        areaDesc: map[TablesColumnFile.mareadesc].toString().trim() as String,
        createdAt: map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime);

  }
}

class CompositeAreaId {

  int areaCd;
  String placeCd;

  CompositeAreaId({this.areaCd,this.placeCd});

  factory CompositeAreaId.mapFromMiddleware(Map<String, dynamic> map){
    print(map);
    print("inside CompositeAreaId map");
    return CompositeAreaId(
        areaCd: map["mareacd"] as int,
        placeCd : map["mplacecd"] as String
    );

  }
}
