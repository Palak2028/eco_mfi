import 'package:eco_mfi/db/TablesColumnFile.dart';

class ProductwiseInterestTableBean {
  String mprdcd;
  String mcurcd;
  DateTime minteffdt;
  //int msrno;
  int mdays;
  int mmonths;
  double mintrate;
  double mpenalintrate;
  double mlowertollimit;
  double muppertollimit;
  double mminrate;
  double mmaxrate;
  int mfrommonths;
  int mtomonths;
  DateTime mmlastsynsdate;
  int msrno;

  TDIntrestSlabComposite tdIntrestSlabComposite;


  @override
  String toString() {
    return 'ProductwiseInterestTableBean{mprdcd: $mprdcd, mcurcd:'
        ' $mcurcd, minteffdt: $minteffdt, mdays: $mdays,'
        ' mmonths: $mmonths, mintrate: $mintrate, mpenalintrate: $mpenalintrate,'
        ' mlowertollimit: $mlowertollimit, muppertollimit: $muppertollimit,'
        ' mminrate: $mminrate, mmaxrate: $mmaxrate, mfrommonths: $mfrommonths, '
        'mtomonths: $mtomonths, mmlastsynsdate: $mmlastsynsdate, msrno: $msrno,'
        ' tdIntrestSlabComposite: $tdIntrestSlabComposite}';
  }

  ProductwiseInterestTableBean(
      {this.msrno,
        this.mprdcd,
        this.mcurcd,
        this.minteffdt,
        this.mdays,
        this.mmonths,
        this.mintrate,
        this.mpenalintrate,
        this.mlowertollimit,
        this.muppertollimit,
        this.mminrate,
        this.mmaxrate,
        this.mfrommonths,
        this.mtomonths,
        this.mmlastsynsdate,
        this.tdIntrestSlabComposite});

  factory ProductwiseInterestTableBean.fromMap(Map<String, dynamic> map) {
    return ProductwiseInterestTableBean(
        tdIntrestSlabComposite: TDIntrestSlabComposite.fromMap(
            map[TablesColumnFile.tdInterestSlabCompositeEntity]),
        // msrno: map[TablesColumnFile.msrno] as int,
        mdays: map[TablesColumnFile.mdays] as int,
        mmonths: map[TablesColumnFile.mmonths] as int,
        mintrate: map[TablesColumnFile.mintrate] as double,
        mpenalintrate: map[TablesColumnFile.mpenalintrate] as double,
        mlowertollimit: map[TablesColumnFile.mlowertollimit] as double,
        muppertollimit: map[TablesColumnFile.muppertollimit] as double,
        mminrate: map[TablesColumnFile.mminrate] as double,
        mmaxrate: map[TablesColumnFile.mmaxrate] as double,
        mfrommonths: map[TablesColumnFile.mfrommonths] as int,
        mtomonths: map[TablesColumnFile.mtomonths] as int,
        mmlastsynsdate: (map[TablesColumnFile.mmlastsynsdate] == "null" ||
            map[TablesColumnFile.mmlastsynsdate] == null)
            ? null
            : DateTime.parse(map[TablesColumnFile.mmlastsynsdate]) as DateTime);
  }

  factory ProductwiseInterestTableBean.fromMapWitoutComposite(
      Map<String, dynamic> map) {
    print("fromMap");
    print(map[TablesColumnFile.mtoamt].toString());
    print(map[TablesColumnFile.minteffdt].toString());

    return ProductwiseInterestTableBean(
        mprdcd: (map[TablesColumnFile.mprdcd] == "null" ||
            map[TablesColumnFile.mprdcd] == null)
            ? "0"
            : map[TablesColumnFile.mprdcd] as String,
        mcurcd: map[TablesColumnFile.mcurcd] as String,
        minteffdt: (map[TablesColumnFile.minteffdt] == "null" ||
            map[TablesColumnFile.minteffdt] == null)
            ? null
            : DateTime.parse(map[TablesColumnFile.minteffdt]) as DateTime,
        msrno: map[TablesColumnFile.msrno] as int,
        mdays: map[TablesColumnFile.mdays] as int,
        mmonths: map[TablesColumnFile.mmonths] as int,
        mintrate: map[TablesColumnFile.mintrate] as double,
        mpenalintrate: map[TablesColumnFile.mpenalintrate] as double,
        mlowertollimit: map[TablesColumnFile.mlowertollimit] as double,
        muppertollimit: map[TablesColumnFile.muppertollimit] as double,
        mminrate: map[TablesColumnFile.mminrate] as double,
        mmaxrate: map[TablesColumnFile.mmaxrate] as double,
        mfrommonths: map[TablesColumnFile.mfrommonths] as int,
        mtomonths: map[TablesColumnFile.mtomonths] as int,
        mmlastsynsdate: (map[TablesColumnFile.mmlastsynsdate] == "null" ||
            map[TablesColumnFile.mmlastsynsdate] == null)
            ? null
            : DateTime.parse(map[TablesColumnFile.mmlastsynsdate]) as DateTime);
  }


}

class TDIntrestSlabComposite {
  String mprdcd;
  String mcurcd;
  DateTime minteffdt;
  int msrno;

  TDIntrestSlabComposite(
      {this.mprdcd, this.mcurcd, this.minteffdt, this.msrno});

  factory TDIntrestSlabComposite.fromMap(Map<String, dynamic> map) {
    print("MAp here is "+map.toString());
    return TDIntrestSlabComposite(
        mprdcd: (map[TablesColumnFile.mprdcd] == "null" ||
            map[TablesColumnFile.mprdcd] == null)
            ? "0"
            : map[TablesColumnFile.mprdcd] as String,
        mcurcd: map[TablesColumnFile.mcurcd] as String,
        minteffdt: (map[TablesColumnFile.minteffdt] == "null" ||
            map[TablesColumnFile.minteffdt] == null)
            ? null
            : DateTime.parse(map[TablesColumnFile.minteffdt]) as DateTime,
        msrno: map[TablesColumnFile.msrno] as int);
  }

}



