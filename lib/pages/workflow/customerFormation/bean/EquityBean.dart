import 'package:eco_mfi/db/TablesColumnFile.dart';

class EquityBean {
  int tequityrefno;
  int trefno;
  int mequityrefno;
  int mrefno;
  int mcustno;
  int mequity;
  double mpresentamt;
  double mnextmonthamount;


  @override
  String toString() {
    return 'EquityBean{tequityrefno: $tequityrefno, trefno: $trefno, mequityrefno: $mequityrefno, mrefno: $mrefno, mcustno: $mcustno, mequity: $mequity, mpresentamt: $mpresentamt, mnextmonthamount: $mnextmonthamount}';
  }

  EquityBean(
      {
        this.tequityrefno,
        this.mrefno,
        this.trefno,
        this.mequityrefno,
        this.mcustno,
        this.mequity,
        this.mpresentamt,
        this.mnextmonthamount
      });



  factory EquityBean.fromMap(Map<String, dynamic> map) {
    return EquityBean(
        mrefno : map[TablesColumnFile.mrefno] as int,
        trefno : map[TablesColumnFile.trefno] as int,
        tequityrefno : map[TablesColumnFile.tequityrefno] as int,
        mequityrefno : map[TablesColumnFile.mequityrefno] as int,
        mcustno : map[TablesColumnFile.mcustno]as int,
        mequity : map[TablesColumnFile.mequity]as int,
        mpresentamt : map[TablesColumnFile.mpresentamt] as double,
        mnextmonthamount : map[TablesColumnFile.mnextmonthamount] as double
    );
  }
  factory EquityBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware) {
    print("fromMap");
    return EquityBean(
        mrefno : map[TablesColumnFile.mrefno] as int,
        trefno : map[TablesColumnFile.trefno] as int,
        tequityrefno : map[TablesColumnFile.tequityrefno] as int,
        mequityrefno : map[TablesColumnFile.mequityrefno] as int,
        mcustno : map[TablesColumnFile.mcustno]as int,
        mequity : map[TablesColumnFile.mequity]as int,
        mpresentamt : map[TablesColumnFile.mpresentamt] as double,
        mnextmonthamount : map[TablesColumnFile.mnextmonthamount] as double
    );}

}
