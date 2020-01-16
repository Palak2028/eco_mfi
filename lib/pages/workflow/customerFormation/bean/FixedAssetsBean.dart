import 'package:eco_mfi/db/TablesColumnFile.dart';

class FixedAssetsBean {
  int tfixedassetrefno;
  int trefno;
  int mfixedassetrefno;
  int mrefno;
  int mcustno;
  int mfixedassets;
  double mpresentamt;
  double mnextmonthamount;


  @override
  String toString() {
    return 'FixedAssetsBean{tfixedassetrefno: $tfixedassetrefno, trefno: $trefno, mfixedassetrefno: $mfixedassetrefno, mrefno: $mrefno, mcustno: $mcustno, mfixedassets: $mfixedassets, mpresentamt: $mpresentamt, mnextmonthamount: $mnextmonthamount}';
  }

  FixedAssetsBean(
      {
        this.tfixedassetrefno,
        this.mrefno,
        this.trefno,
        this.mfixedassetrefno,
        this.mcustno,
        this.mfixedassets,
        this.mpresentamt,
        this.mnextmonthamount
      });



  factory FixedAssetsBean.fromMap(Map<String, dynamic> map) {
    return FixedAssetsBean(
        mrefno : map[TablesColumnFile.mrefno] as int,
        trefno : map[TablesColumnFile.trefno] as int,
        tfixedassetrefno : map[TablesColumnFile.tfixedassetrefno] as int,
        mfixedassetrefno : map[TablesColumnFile.mfixedassetrefno] as int,
        mcustno : map[TablesColumnFile.mcustno]as int,
        mfixedassets : map[TablesColumnFile.mfixedassets]as int,
        mpresentamt : map[TablesColumnFile.mpresentamt] as double,
        mnextmonthamount : map[TablesColumnFile.mnextmonthamount] as double
    );
  }
  factory FixedAssetsBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware) {
    print("fromMap");
    return FixedAssetsBean(
        mrefno : map[TablesColumnFile.mrefno] as int,
        trefno : map[TablesColumnFile.trefno] as int,
        tfixedassetrefno : map[TablesColumnFile.tfixedassetrefno] as int,
        mfixedassetrefno : map[TablesColumnFile.mfixedassetrefno] as int,
        mcustno : map[TablesColumnFile.mcustno]as int,
        mfixedassets : map[TablesColumnFile.mfixedassets]as int,
        mpresentamt : map[TablesColumnFile.mpresentamt] as double,
        mnextmonthamount : map[TablesColumnFile.mnextmonthamount] as double
    );}

}
