import 'package:eco_mfi/db/TablesColumnFile.dart';

class ShortTermLiabilitiesBean {
  int tshrttrmliabiltyrefno;
  int trefno;
  int mshrttrmliabiltyrefno;
  int mrefno;
  int mcustno;
  int mshrttrmliabilty;
  double mpresentamt;
  double mnextmonthamount;


  @override
  String toString() {
    return 'ShortTermLiabilitiesBean{tshrttrmliabiltyrefno: $tshrttrmliabiltyrefno, trefno: $trefno, mshrttrmliabiltyrefno: $mshrttrmliabiltyrefno, mrefno: $mrefno, mcustno: $mcustno, mshrttrmliabilty: $mshrttrmliabilty, mpresentamt: $mpresentamt, mnextmonthamount: $mnextmonthamount}';
  }

  ShortTermLiabilitiesBean(
      {
        this.tshrttrmliabiltyrefno,
        this.mrefno,
        this.trefno,
        this.mshrttrmliabiltyrefno,
        this.mcustno,
        this.mshrttrmliabilty,
        this.mpresentamt,
        this.mnextmonthamount
      });



  factory ShortTermLiabilitiesBean.fromMap(Map<String, dynamic> map) {
    return ShortTermLiabilitiesBean(
      mrefno : map[TablesColumnFile.mrefno] as int,
      trefno : map[TablesColumnFile.trefno] as int,
      tshrttrmliabiltyrefno : map[TablesColumnFile.tshrttrmliabiltyrefno] as int,
      mshrttrmliabiltyrefno : map[TablesColumnFile.mshrttrmliabiltyrefno] as int,
      mcustno : map[TablesColumnFile.mcustno]as int,
      mshrttrmliabilty : map[TablesColumnFile.mshrttrmliabilty]as int,
      mpresentamt : map[TablesColumnFile.mpresentamt] as double,
      mnextmonthamount : map[TablesColumnFile.mnextmonthamount] as double
    );
  }
  factory ShortTermLiabilitiesBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware) {
    print("fromMap");
    return ShortTermLiabilitiesBean(
        mrefno : map[TablesColumnFile.mrefno] as int,
        trefno : map[TablesColumnFile.trefno] as int,
        tshrttrmliabiltyrefno : map[TablesColumnFile.tshrttrmliabiltyrefno] as int,
        mshrttrmliabiltyrefno : map[TablesColumnFile.mshrttrmliabiltyrefno] as int,
        mcustno : map[TablesColumnFile.mcustno]as int,
        mshrttrmliabilty : map[TablesColumnFile.mshrttrmliabilty]as int,
        mpresentamt : map[TablesColumnFile.mpresentamt] as double,
        mnextmonthamount : map[TablesColumnFile.mnextmonthamount] as double
    );}

}
