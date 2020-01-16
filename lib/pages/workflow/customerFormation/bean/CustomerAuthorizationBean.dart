import 'package:eco_mfi/db/TablesColumnFile.dart';

class CustomerAuthorizationBean {

  int mcustno;
  int mlbrcode;
  String mnametitle;
  String mlongname;
  String mpannodesc;
  int mcuststatus;
  String msexcode;
  String mdob;
  String madd1;
  String madd2;
  String madd3;
  String merror;
  String mnid;
  String mcountrycd;
  String mcitycd;
  String mstate;
  int mdistcd;
  int marea;
  String mcountrycddesc;
  String mcitycddesc;
  String mstatedesc;
  String mdistcddesc;
  String mareadesc;


  CustomerAuthorizationBean({this.mcustno, this.mlbrcode, this.mnametitle,
      this.mlongname, this.mpannodesc, this.mcuststatus, this.msexcode,
      this.mdob, this.madd1, this.madd2, this.madd3, this.merror, this.mnid,
      this.mcountrycd, this.mcitycd, this.mstate, this.mdistcd, this.marea});


  @override
  String toString() {
    return 'CustomerAuthorizationBean{mcustno: $mcustno, mlbrcode: $mlbrcode, mnametitle: $mnametitle, mlongname: $mlongname, mpannodesc: $mpannodesc, mcuststatus: $mcuststatus, msexcode: $msexcode, mdob: $mdob, madd1: $madd1, madd2: $madd2, madd3: $madd3, merror: $merror, mnid: $mnid, mcountrycd: $mcountrycd, mcitycd: $mcitycd, mstate: $mstate, mdistcd: $mdistcd, marea: $marea}';
  }

  factory CustomerAuthorizationBean.fromMap(Map<String, dynamic> map) {
    print(map);
    return CustomerAuthorizationBean(
        mcustno: map[TablesColumnFile.mcustno] as int,
        mlbrcode: map[TablesColumnFile.mlbrcode] as int,
        mnametitle:map[TablesColumnFile.mnametitle] as String,
        mlongname:map[TablesColumnFile.mlongname] as String,
        mdob:map[TablesColumnFile.mdob] as String,
        mpannodesc:map[TablesColumnFile.mpannodesc] as String,
        msexcode:map[TablesColumnFile.msexcode] as String,
        merror: map[TablesColumnFile.merror] as String,
        mcuststatus: map[TablesColumnFile.mcuststatus] as int,
        madd1:map[TablesColumnFile.madd1] as String,
        madd2:map[TablesColumnFile.madd2] as String,
        madd3:map[TablesColumnFile.madd3] as String,
        mnid:map[TablesColumnFile.mnid] as String,
        mcountrycd:map[TablesColumnFile.mcountrycd] as String,
        mcitycd:map[TablesColumnFile.mcitycd] as String,
        mstate:map[TablesColumnFile.mstate] as String,
        mdistcd: map[TablesColumnFile.mdistcd] as int,
        marea: map[TablesColumnFile.marea] as int,
    );
  }

  factory CustomerAuthorizationBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware){
    print("fromMapMiddleware");
    return CustomerAuthorizationBean(
        mcustno: map[TablesColumnFile.mcustno] as int,
        mlbrcode: map[TablesColumnFile.mlbrcode] as int,
        mnametitle:map[TablesColumnFile.mnametitle] as String,
        mlongname:map[TablesColumnFile.mlongname] as String,
        mdob:map[TablesColumnFile.mdob] as String,
        mpannodesc:map[TablesColumnFile.mpannodesc] as String,
        msexcode:map[TablesColumnFile.msexcode] as String,
        merror: map[TablesColumnFile.merror] as String,
        mcuststatus: map[TablesColumnFile.mcuststatus] as int,
        madd1:map[TablesColumnFile.madd1] as String,
        madd2:map[TablesColumnFile.madd2] as String,
        madd3:map[TablesColumnFile.madd3] as String,
        mnid:map[TablesColumnFile.mnid] as String,
        mcountrycd:map[TablesColumnFile.mcountrycd] as String,
        mcitycd:map[TablesColumnFile.mcitycd] as String,
        mstate:map[TablesColumnFile.mstate] as String,
        mdistcd: map[TablesColumnFile.mdistcd] as int,
        marea: map[TablesColumnFile.marea] as int,
    );}
}
