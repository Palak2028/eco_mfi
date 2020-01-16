import 'package:eco_mfi/db/TablesColumnFile.dart';

class StateDropDownList {
  String stateCd;
  String stateDesc;
  String cntryCd;
  DateTime createdAt;

  StateDropDownList(
      {this.stateCd, this.stateDesc, this.cntryCd , this.createdAt});


  factory StateDropDownList.fromMap(Map<String, dynamic> map) {
    return StateDropDownList(
      stateCd: map[TablesColumnFile.stateCd] as String,
      stateDesc: map[TablesColumnFile.stateDesc] as String,
      cntryCd: map[TablesColumnFile.cntryCd] as String,
      createdAt: map[TablesColumnFile.createdAt]=="null"||map[TablesColumnFile.createdAt]==null?null:DateTime.parse(map[TablesColumnFile.createdAt]) as DateTime,
    );
  }

  factory StateDropDownList.mapFromMiddleware(Map<String, dynamic> map) {


    return StateDropDownList(
      stateCd: map[TablesColumnFile.mstatecd].toString().trim() as String,
      stateDesc: map[TablesColumnFile.mstatedesc].toString().trim() as String,
      cntryCd: map[TablesColumnFile.mcountryid] as String,
      createdAt: map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime);

  }


/*// {this.statesID, this.statesName});
  factory StateDropDownList.fromJson(Map<String, dynamic> json) {
    return StateDropDownList(
      statesID: json['statesID'] as int,
      statesName: json['statesName'] as String,
      //districtDropDownList: json['districts'].cast<DistrictDropDownList>(),
      districtDropDownList: json['districts']
          .map<DistrictDropDownList>((i) => DistrictDropDownList.fromJson(i))
          .toList(),
    );
  }*/
}
