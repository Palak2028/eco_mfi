import 'package:eco_mfi/db/TablesColumnFile.dart';

class CIFSavingAcctClosureBean {

  String mprdacctid;
  double mshadowclearbal;
  double mshadowtotalbal;
  double mactualclearbal;
  double mactualtotalbal;
  String mopendate;
  double mlcybal;
  double mtotallien;
  double mintapplied;
  String mremark;
  String merror;
  String momnimsg;
  int mlbrcode;
  int macctstat;
  String macctstatdesc;

  CIFSavingAcctClosureBean({this.mprdacctid, this.mshadowclearbal,
      this.mshadowtotalbal, this.mactualclearbal, this.mactualtotalbal,
      this.mopendate, this.mlcybal, this.mtotallien, this.mintapplied,
      this.mremark, this.merror, this.momnimsg, this.mlbrcode,this.macctstat,
      this.macctstatdesc});


  @override
  String toString() {
    return 'CIFSavingAcctClosureBean{mprdacctid: $mprdacctid, mshadowclearbal: $mshadowclearbal, mshadowtotalbal: $mshadowtotalbal, mactualclearbal: $mactualclearbal, mactualtotalbal: $mactualtotalbal, mopendate: $mopendate, mlcybal: $mlcybal, mtotallien: $mtotallien, mintapplied: $mintapplied, mremark: $mremark, merror: $merror, momnimsg: $momnimsg, mlbrcode: $mlbrcode}';
  }

  factory CIFSavingAcctClosureBean.fromMap(Map<String, dynamic> map) {
    print(map);
    return CIFSavingAcctClosureBean(
      mprdacctid: map[TablesColumnFile.mprdacctid] as String,
      mshadowclearbal: map[TablesColumnFile.mshadowclearbal] as double,
      mshadowtotalbal: map[TablesColumnFile.mshadowtotalbal] as double,
      mactualclearbal: map[TablesColumnFile.mactualclearbal] as double,
      mactualtotalbal: map[TablesColumnFile.mactualtotalbal] as double,
      mopendate: map[TablesColumnFile.mopendate] as String,
      mlcybal: map[TablesColumnFile.mlcybal] as double,
      mtotallien: map[TablesColumnFile.mtotallien] as double,
      mintapplied: map[TablesColumnFile.mintapplied] as double,
      mremark: map[TablesColumnFile.mremark] as String,
      merror: map[TablesColumnFile.merror] as String,
      momnimsg : map[TablesColumnFile.momnimsg] as String,
      mlbrcode: map[TablesColumnFile.mlbrcode] as int,
      macctstat: map[TablesColumnFile.macctstat] as int,
      macctstatdesc:map[TablesColumnFile.macctstatdesc] as String,
    );
  }

  factory CIFSavingAcctClosureBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware){
    return CIFSavingAcctClosureBean(
      mprdacctid: map[TablesColumnFile.mprdacctid] as String,
      mshadowclearbal: map[TablesColumnFile.mshadowclearbal] as double,
      mshadowtotalbal: map[TablesColumnFile.mshadowtotalbal] as double,
      mactualclearbal: map[TablesColumnFile.mactualclearbal] as double,
      mactualtotalbal: map[TablesColumnFile.mactualtotalbal] as double,
      mopendate: map[TablesColumnFile.mopendate] as String,
      mlcybal: map[TablesColumnFile.mlcybal] as double,
      mtotallien: map[TablesColumnFile.mtotallien] as double,
      mintapplied: map[TablesColumnFile.mintapplied] as double,
      mremark: map[TablesColumnFile.mremark] as String,
      merror: map[TablesColumnFile.merror] as String,
      momnimsg : map[TablesColumnFile.momnimsg] as String,
      mlbrcode: map[TablesColumnFile.mlbrcode] as int,
      macctstat: map[TablesColumnFile.macctstat] as int,
      macctstatdesc:map[TablesColumnFile.macctstatdesc] as String,
    );}
}
