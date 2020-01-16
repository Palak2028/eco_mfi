import 'package:eco_mfi/db/TablesColumnFile.dart';

class TDParameterBean {
  String mdefbatchcd;
  String mintfreq;
  double mmindepamt;
  double mmaxdepamt;
  String mperiodtype;
  int mmaxperiod;
  int mminperiod;
  int mnodaysinyear;
  String mtaxprojection;
  int mclintcalctype;


  TDParameterComposite tdParameterCompositeEntity;


  TDParameterBean(
      {this.mdefbatchcd,
        this.mintfreq,
        this.mmindepamt,
        this.mmaxdepamt,
        this.mperiodtype,
        this.mmaxperiod,
        this.mminperiod,
        this.mnodaysinyear,
        this.mtaxprojection,
        this.tdParameterCompositeEntity,
      this.mclintcalctype,
      });

  factory TDParameterBean.fromMap(Map<String, dynamic> map) {
    return TDParameterBean(
        tdParameterCompositeEntity: TDParameterComposite.fromMap(
            map[TablesColumnFile.tdParameterCompositeEntity]),
        // msrno: map[TablesColumnFile.msrno] as int,
        mintfreq: map[TablesColumnFile.mintfreq] as String,
        mmindepamt: map[TablesColumnFile.mmindepamt] as double,
        mmaxdepamt: map[TablesColumnFile.mmaxdepamt] as double,
        mmaxperiod: map[TablesColumnFile.mmaxperiod] as int ,
        mminperiod: map[TablesColumnFile.mminperiod] as int,
        mnodaysinyear: map[TablesColumnFile.mnodaysinyear] as int,
        mtaxprojection: map[TablesColumnFile.mtaxprojection] as String,
        mclintcalctype:map[TablesColumnFile.mclintcalctype] as int
    );
  }

  factory TDParameterBean.fromMapWitoutComposite(
      Map<String, dynamic> map) {
    print("fromMap");
    print(map[TablesColumnFile.mtoamt].toString());
    print(map[TablesColumnFile.minteffdt].toString());

    return TDParameterBean(
    mintfreq: map[TablesColumnFile.mintfreq] as String,
    mmindepamt: map[TablesColumnFile.mmindepamt] as double,
    mmaxdepamt: map[TablesColumnFile.mmaxdepamt] as double,
    mmaxperiod: map[TablesColumnFile.mmaxperiod] as int ,
    mminperiod: map[TablesColumnFile.mminperiod] as int,
    mnodaysinyear: map[TablesColumnFile.mnodaysinyear] as int,
    mtaxprojection: map[TablesColumnFile.mtaxprojection] as String,
    mclintcalctype:map[TablesColumnFile.mclintcalctype] as int)

    ;}


}

class TDParameterComposite {
  int mlbrcode;
  String mprdcd;

  TDParameterComposite(
      {this.mlbrcode, this.mprdcd});

  factory TDParameterComposite.fromMap(Map<String, dynamic> map) {
    print("MAp here is "+map.toString());
    return TDParameterComposite(
      mlbrcode: map[TablesColumnFile.mlbrcode] as int ,
        mprdcd: (map[TablesColumnFile.mprdcd] == "null" ||
            map[TablesColumnFile.mprdcd] == null)
            ? "0"
            : map[TablesColumnFile.mprdcd] as String);

  }

}



