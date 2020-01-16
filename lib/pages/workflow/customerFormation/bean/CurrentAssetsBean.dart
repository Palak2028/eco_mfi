import 'package:eco_mfi/db/TablesColumnFile.dart';

class CurrentAssetsBean {
  int tcurrentassetrefno;
  int trefno;
  int mcurrentassetrefno;
  int mrefno;
  int mcustno;
  int mcurrentassets;
  double mpresentamt;
  double mnextmonthamount;


  @override
  String toString() {
    return 'CurrentAssetsBean{tcurrentassetrefno: $tcurrentassetrefno, trefno: $trefno, mcurrentassetrefno: $mcurrentassetrefno, mrefno: $mrefno, mcustno: $mcustno, mcurrentassets: $mcurrentassets, mpresentamt: $mpresentamt, mnextmonthamount: $mnextmonthamount}';
  }

  CurrentAssetsBean(
      {
        this.tcurrentassetrefno,
        this.mrefno,
        this.trefno,
        this.mcurrentassetrefno,
        this.mcustno,
        this.mcurrentassets,
        this.mpresentamt,
        this.mnextmonthamount
      });



  factory CurrentAssetsBean.fromMap(Map<String, dynamic> map) {
    return CurrentAssetsBean(
      mrefno : map[TablesColumnFile.mrefno] as int,
      trefno : map[TablesColumnFile.trefno] as int,
      tcurrentassetrefno : map[TablesColumnFile.tcurrentassetrefno] as int,
      mcurrentassetrefno : map[TablesColumnFile.mcurrentassetrefno] as int,
      mcustno : map[TablesColumnFile.mcustno]as int,
      mcurrentassets : map[TablesColumnFile.mcurrentassets]as int,
      mpresentamt : map[TablesColumnFile.mpresentamt] as double,
      mnextmonthamount : map[TablesColumnFile.mnextmonthamount] as double
    );
  }
  factory CurrentAssetsBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware) {
    print("fromMap");
    return CurrentAssetsBean(
        mrefno : map[TablesColumnFile.mrefno] as int,
        trefno : map[TablesColumnFile.trefno] as int,
        tcurrentassetrefno : map[TablesColumnFile.tcurrentassetrefno] as int,
        mcurrentassetrefno : map[TablesColumnFile.mcurrentassetrefno] as int,
        mcustno : map[TablesColumnFile.mcustno]as int,
        mcurrentassets : map[TablesColumnFile.mcurrentassets]as int,
        mpresentamt : map[TablesColumnFile.mpresentamt] as double,
        mnextmonthamount : map[TablesColumnFile.mnextmonthamount] as double
    );}

}
