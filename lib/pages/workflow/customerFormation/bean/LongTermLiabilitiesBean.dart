import 'package:eco_mfi/db/TablesColumnFile.dart';

class LongTermLiabilitiesBean {
  int tlngtrmliabiltyrefno;
  int trefno;
  int mlngtrmliabiltyrefno;
  int mrefno;
  int mcustno;
  int mlngtrmliabilty;
  double mpresentamt;
  double mnextmonthamount;


  @override
  String toString() {
    return 'LongTermLiabilitiesBean{tlngtrmliabiltyrefno: $tlngtrmliabiltyrefno, trefno: $trefno, mlngtrmliabiltyrefno: $mlngtrmliabiltyrefno, mrefno: $mrefno, mcustno: $mcustno, mlngtrmliabilty: $mlngtrmliabilty, mpresentamt: $mpresentamt, mnextmonthamount: $mnextmonthamount}';
  }

  LongTermLiabilitiesBean(
      {
        this.tlngtrmliabiltyrefno,
        this.mrefno,
        this.trefno,
        this.mlngtrmliabiltyrefno,
        this.mcustno,
        this.mlngtrmliabilty,
        this.mpresentamt,
        this.mnextmonthamount
      });



  factory LongTermLiabilitiesBean.fromMap(Map<String, dynamic> map) {
    return LongTermLiabilitiesBean(
      mrefno : map[TablesColumnFile.mrefno] as int,
      trefno : map[TablesColumnFile.trefno] as int,
      tlngtrmliabiltyrefno : map[TablesColumnFile.tlngtrmliabiltyrefno] as int,
      mlngtrmliabiltyrefno : map[TablesColumnFile.mlngtrmliabiltyrefno] as int,
      mcustno : map[TablesColumnFile.mcustno]as int,
      mlngtrmliabilty : map[TablesColumnFile.mlngtrmliabilty]as int,
      mpresentamt : map[TablesColumnFile.mpresentamt] as double,
      mnextmonthamount : map[TablesColumnFile.mnextmonthamount] as double
    );
  }
  factory LongTermLiabilitiesBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware) {
    print("fromMap");
    return LongTermLiabilitiesBean(
        mrefno : map[TablesColumnFile.mrefno] as int,
        trefno : map[TablesColumnFile.trefno] as int,
        tlngtrmliabiltyrefno : map[TablesColumnFile.tlngtrmliabiltyrefno] as int,
        mlngtrmliabiltyrefno : map[TablesColumnFile.mlngtrmliabiltyrefno] as int,
        mcustno : map[TablesColumnFile.mcustno]as int,
        mlngtrmliabilty : map[TablesColumnFile.mlngtrmliabilty]as int,
        mpresentamt : map[TablesColumnFile.mpresentamt] as double,
        mnextmonthamount : map[TablesColumnFile.mnextmonthamount] as double
    );}

}
