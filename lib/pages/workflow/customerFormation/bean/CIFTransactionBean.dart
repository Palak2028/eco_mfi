import 'package:eco_mfi/db/TablesColumnFile.dart';

class CIFTransactionBean {

  int mcustno;
  String mnid;
  int mlbrcode;
  String mprdacctid;
  int mmoduletype;
  String mremark;
  String mcrdr;
  double mamt;

  CIFTransactionBean({
    this.mcustno, this.mnid, this.mlbrcode, this.mprdacctid,
    this.mmoduletype, this.mremark, this.mcrdr, this.mamt
  }  );




  factory CIFTransactionBean.fromMap(Map<String, dynamic> map) {
    print(map);
    return CIFTransactionBean(
        mcustno: map[TablesColumnFile.mcustno] as int,
        mnid: map[TablesColumnFile.mnid] as String,
        mlbrcode: map[TablesColumnFile.mlbrcode] as int,
        mprdacctid: map[TablesColumnFile.mprdacctid] as String,
        mmoduletype: map[TablesColumnFile.mmoduletype] as int,
        mremark: map[TablesColumnFile.mremark] as String,

    );
  }

  factory CIFTransactionBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware){
    print("fromMapMiddleware");
    return CIFTransactionBean(
        mcustno: map[TablesColumnFile.mcustno] as int,
        mnid: map[TablesColumnFile.mnid] as String,
        mlbrcode: map[TablesColumnFile.mlbrcode] as int,
        mprdacctid: map[TablesColumnFile.mprdacctid] as String,
        mmoduletype: map[TablesColumnFile.mmoduletype] as int,
        mremark: map[TablesColumnFile.mremark] as String,

    );}
}
