

import 'package:eco_mfi/db/TablesColumnFile.dart';

class SystemParameterBean {
  int mlbrcode;
  String mcode;
  int mrefno;
  int trefno;
  String mcodedesc;
  //String mcodekey;
  String mcodevalue;
  DateTime mcreateddt;
  SystemParameterComposite systemParameterCompositeEntity;

  SystemParameterBean(
      {
        this.mlbrcode,
        this.mcode,
        this.mrefno,
        this.trefno,
        this.mcodedesc,
        //this.mcodekey,
        this.mcodevalue,
        this.mcreateddt,
        this.systemParameterCompositeEntity
      });
  factory SystemParameterBean.fromMap(Map<String, dynamic> map) {

    return SystemParameterBean(
        mlbrcode:map[TablesColumnFile.mlbrcode] as int,
        mcode:map[TablesColumnFile.mcode] as String,
        mcodedesc:map[TablesColumnFile.mcodedesc] as String,
        mcodevalue:map[TablesColumnFile.mcodevalue] as String,
        //mcreateddt:(map[TablesColumnFile.mcreateddt]==null || map[TablesColumnFile.mcreateddt].toString().trim()=="null" ||  map[TablesColumnFile.mcreateddt.trim()]=='')?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,

    );
  }
  factory SystemParameterBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap");
    return SystemParameterBean(

        mcodedesc:map[TablesColumnFile.mcodedesc] as String,
        mcodevalue:map[TablesColumnFile.mcodevalue] as String,
        //mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
        systemParameterCompositeEntity: SystemParameterComposite.fromJson(map[TablesColumnFile.systemParameterCompositeEntity])
    );}

}


class SystemParameterComposite{
  int mlbrcode;
  String mcode;
  SystemParameterComposite({this.mlbrcode, this.mcode});

  factory SystemParameterComposite.fromJson(Map<String, dynamic> json) {
    return SystemParameterComposite(
      mlbrcode : json[TablesColumnFile.mlbrcode]!=null && json[TablesColumnFile.mlbrcode]!='null'?json[TablesColumnFile.mlbrcode] as int:0,
      mcode : json[TablesColumnFile.mcode] as String,

    );
  }
}





