
import 'package:eco_mfi/db/TablesColumnFile.dart';

class FamilyDetailsBean {
  int tfamilyrefno;
  //numeric(8)
  int trefno;
  //numeric(8)
  int mfamilyrefno;
  int mrefno;
  //numeric(8)
  int mcustno;
  //NVarChar(50)
  String mname;
  //NVarChar(25)
  String mnicno;
  DateTime mdob;
  //numeric(2)
  int mage;
  //NVarChar(15)
  String meducation;
  //NVarChar(30)
  String mmemberno;
  //numeric(4)
  int moccuptype;
  double mincome;
  //numeric(1)
  int mhealthstatus;
  //NVarChar(3)
  String mrelationwithcust;
  //numeric(2)
  int maritalstatus;
  double mcontrforhouseexp;
  //NVarChar(1)
    String macidntlinsurance;
  //NVarChar(1)
  String mnomineeyn;
  FamilyDetailsBean(
      {
        this.mrefno,
        this.trefno,
        this.tfamilyrefno,
        this.mfamilyrefno,
        this.mcustno,
        this.mname,
        this.mnicno,
        this.mdob,
        this.mage,
        this.meducation,
        this.mmemberno,
        this.moccuptype,
        this.mincome,
        this.mhealthstatus,
        this.mrelationwithcust,
        this.maritalstatus,
        this.mcontrforhouseexp,
        this.macidntlinsurance,
        this.mnomineeyn

      });



  factory FamilyDetailsBean.fromMap(Map<String, dynamic> map) {
    return FamilyDetailsBean(
      mrefno : map[TablesColumnFile.mrefno] as int,
      trefno : map[TablesColumnFile.trefno] as int,
      tfamilyrefno : map[TablesColumnFile.tfamilyrefno] as int,
      mfamilyrefno:map[TablesColumnFile.mfamilyrefno] as int,
      mcustno: map[TablesColumnFile.mcustno]as int,
      mname: map[TablesColumnFile.mname]as String,
      mnicno: map[TablesColumnFile.mnicno]as String,
      mdob:(map[TablesColumnFile.mdob]=="null"||map[TablesColumnFile.mdob]==null)?null:DateTime.parse(map[TablesColumnFile.mdob]) as DateTime,
      mage: map[TablesColumnFile.mage]as int,
      meducation: map[TablesColumnFile.meducation]as String,
      mmemberno: map[TablesColumnFile.mmemberno]as String,
      moccuptype: map[TablesColumnFile.moccuptype]as int,
      mincome: map[TablesColumnFile.mincome]as double,
      mhealthstatus: map[TablesColumnFile.mhealthstatus]as int,
      mrelationwithcust: map[TablesColumnFile.mrelationwithcust]as String,
      maritalstatus: map[TablesColumnFile.maritalstatus]as int,
      mcontrforhouseexp: map[TablesColumnFile.mcontrforhouseexp]as double,
      macidntlinsurance: map[TablesColumnFile.macidntlinsurance]as String,
      mnomineeyn: map[TablesColumnFile.mnomineeyn]as String,




    );
  }
  factory FamilyDetailsBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware) {
    print("fromMap");
    return FamilyDetailsBean(
      mfamilyrefno: map[TablesColumnFile.mfamilyrefno]as int,
      trefno: map[TablesColumnFile.trefno]as int,
      mcustno: map[TablesColumnFile.mcustno]as int,
      mname: map[TablesColumnFile.mname]as String,
      mnicno: map[TablesColumnFile.mnicno]as String,
      mdob:(map[TablesColumnFile.mdob]=="null"||map[TablesColumnFile.mdob]==null)?null:DateTime.parse(map[TablesColumnFile.mdob]) as DateTime,
      mage: map[TablesColumnFile.mage]as int,
      meducation: map[TablesColumnFile.meducation]as String,
      mmemberno: map[TablesColumnFile.mmemberno]as String,
      moccuptype: map[TablesColumnFile.moccuptype]as int,
      mincome: map[TablesColumnFile.mincome]as double,
      mhealthstatus: map[TablesColumnFile.mhealthstatus]as int,
      mrelationwithcust: map[TablesColumnFile.mrelationwithcust]as String,
      maritalstatus: map[TablesColumnFile.maritalstatus]as int,
      mcontrforhouseexp: map[TablesColumnFile.mcontrforhouseexp]as double,
      macidntlinsurance: map[TablesColumnFile.macidntlinsurance]as String,
      mnomineeyn: map[TablesColumnFile.mnomineeyn]as String,
    );}

}
