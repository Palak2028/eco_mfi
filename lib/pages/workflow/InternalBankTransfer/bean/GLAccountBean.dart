import 'package:eco_mfi/db/TablesColumnFile.dart';

class GLAccountBean {

  int trefno;
  int mrefno;
  int mlbrcode;
  String mprdacctid;
  String mlongname;


  @override
  String toString() {
    return 'GLAccountBean{trefno: $trefno, mrefno: $mrefno, mlbrcode: $mlbrcode, mprdacctid: $mprdacctid, mlongname: $mlongname}';
  }

  GLAccountBean(
      {
        this.mrefno,
        this.trefno,
        this.mlbrcode,
        this.mprdacctid,
        this.mlongname
      });

  factory GLAccountBean.fromMap(Map<String, dynamic> map) {
    return GLAccountBean(
      mrefno : map[TablesColumnFile.mrefno] as int,
      trefno : map[TablesColumnFile.trefno] as int,
      mlbrcode:map[TablesColumnFile.mlbrcode] as int,
      mprdacctid:map[TablesColumnFile.mprdacctid] as String,
      mlongname:map[TablesColumnFile.mlongname] as String,
    );
  }
  factory GLAccountBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware) {
    print("fromMapMiddleware");
    return GLAccountBean(
        mrefno : map[TablesColumnFile.mrefno] as int,
        trefno : map[TablesColumnFile.trefno] as int,
        mlbrcode:map[TablesColumnFile.mlbrcode] as int,
        mprdacctid:map[TablesColumnFile.mprdacctid] as String,
        mlongname:map[TablesColumnFile.mlongname] as String,
    );}

}
