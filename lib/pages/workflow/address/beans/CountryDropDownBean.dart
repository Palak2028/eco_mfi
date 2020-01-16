import 'package:eco_mfi/db/TablesColumnFile.dart';

class CountryDropDownBean {
  //static final CountryDropDownList _singleton = new CountryDropDownList._internal();
  String cntryCd;
  String countryName;
  DateTime createdAt;
  //DateTime updatedAt;
  //String createdBy;
  //String updatedBy;
  //int isDataSynced;

  CountryDropDownBean(
      {this.cntryCd,
       this.countryName,
       this.createdAt});
       //this.updatedAt,
       //this.createdBy,
       //this.updatedBy,
       //this.isDataSynced});

  factory CountryDropDownBean.fromMap(Map<String, dynamic> map) {
    return CountryDropDownBean(
      cntryCd: map[TablesColumnFile.cntryCd] as String,
      countryName: map[TablesColumnFile.countryName] as String,
      createdAt: map[TablesColumnFile.createdAt]=="null"||map[TablesColumnFile.createdAt]==null?null:DateTime.parse(map[TablesColumnFile.createdAt]) as DateTime,
      //updatedAt: map[TablesColumnFile.updatedAt]=="null"||map[TablesColumnFile.updatedAt]==null?null:DateTime.parse(map[TablesColumnFile.updatedAt]) as DateTime,
      //createdBy: map[TablesColumnFile.createdBy] as String,
      //updatedBy: map[TablesColumnFile.updatedBy] as String,
      //isDataSynced: map[TablesColumnFile.isDataSynced] as int,
    );
  }



  factory CountryDropDownBean.mapFromMiddleware(Map<String, dynamic> map) {

    return CountryDropDownBean(
        cntryCd: map[TablesColumnFile.mcountryid] as String,
        countryName: map[TablesColumnFile.mcountryname].toString().trim() as String,
        createdAt: map[TablesColumnFile.createdAt]=="null"||map[TablesColumnFile.createdAt]==null?null:DateTime.parse(map[TablesColumnFile.createdAt]) as DateTime,/*,
        isDataSynced: map[TablesColumnFile.isDataSynced] as int,
        createdAt: map[TablesColumnFile.createdAt]=="null"||map[TablesColumnFile.createdAt]==null?null:DateTime.parse(map[TablesColumnFile.createdAt]) as DateTime,
        updatedAt: map[TablesColumnFile.updatedAt]=="null"||map[TablesColumnFile.updatedAt]==null?null:DateTime.parse(map[TablesColumnFile.updatedAt]) as DateTime,
        createdBy: map[TablesColumnFile.createdBy] as String,
        updatedBy: map[TablesColumnFile.updatedBy] as String*/);

  }





  //List<StateDropDownList> stateDropDownList = new List();

  /*CountryDropDownList({this.countryName, this.stateDropDownList});

  factory CountryDropDownList.fromJson(Map<String, dynamic> json) {
    return CountryDropDownList(
      countryName: json['countryName'] as String,
      // stateDropDownList: json['states'].cast<StateDropDownList>(),
      stateDropDownList: json['states']
          .map<StateDropDownList>((i) => StateDropDownList.fromJson(i))
          .toList(),
    );
  }*/
}
