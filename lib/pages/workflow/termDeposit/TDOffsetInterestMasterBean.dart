import 'package:eco_mfi/db/TablesColumnFile.dart';

class TDOffsetInterestMasterBean {
  int lBrCode;
  String prdCd;
  String CurCd;
  int acctType;
  DateTime effDate;

  int days;
  int months;
  double InvAmtFrm;
  double UptoAmt;
  double offSetIntRate;
  double LowerTolLimit;
  double UpperTolLimit;
  DateTime mmlastsynsdate;
  int srNo;

  TDOffsetIntrestSlabComposite tdOffsetintrestSlabComposite;


  TDOffsetInterestMasterBean({
    this.lBrCode,
    this.prdCd,
    this.CurCd,
    this.acctType,
    this.effDate,
    this.days,
    this.months,
    this.InvAmtFrm,
    this.UptoAmt,
    this.offSetIntRate,
    this.LowerTolLimit,
    this.UpperTolLimit,
    this.mmlastsynsdate,
    this.tdOffsetintrestSlabComposite,
    this.srNo
  });

  factory TDOffsetInterestMasterBean.fromMap(Map<String, dynamic> map) {
    return TDOffsetInterestMasterBean(
        tdOffsetintrestSlabComposite: TDOffsetIntrestSlabComposite.fromMap(map[TablesColumnFile.tdOffsetInterestSlabCompositeEntity]),
        CurCd: map[TablesColumnFile.mcurCd] as String,
        // srNo: map[TablesColumnFile.msrno] as int,
        days: map[TablesColumnFile.mdays] as int,
        months: map[TablesColumnFile.mmonths] as int,
        InvAmtFrm: map[TablesColumnFile.minvamtfrm] as double,
        UptoAmt: map[TablesColumnFile.muptoamt] as double,
        offSetIntRate: map[TablesColumnFile.moffsetintrate] as double,
        LowerTolLimit: map[TablesColumnFile.mlowertollimit] as double,
        UpperTolLimit: map[TablesColumnFile.muppertollimit] as double,
        mmlastsynsdate:(map[TablesColumnFile.mmlastsynsdate]==
            "null"||map[TablesColumnFile.mmlastsynsdate]==null) ? null : DateTime.parse(map[TablesColumnFile.mmlastsynsdate]) as DateTime);

  }

  factory TDOffsetInterestMasterBean.fromMapWitoutComposite(
      Map<String, dynamic> map) {
    print("fromMap");
    /* print(map[TablesColumnFile.mtoamt].toString());
    print(map[TablesColumnFile.minteffdt].toString());*/

    return TDOffsetInterestMasterBean(
        lBrCode: map[TablesColumnFile.mlbrcode] as int,
        prdCd: (map[TablesColumnFile.mprdcd] == "null" || map[TablesColumnFile.mprdcd] == null) ? "0" : map[TablesColumnFile.mprdcd] as String,
        CurCd: map[TablesColumnFile.mcurCd] as String,
        acctType: map[TablesColumnFile.maccttype] as int,
        effDate: (map[TablesColumnFile.meffdate] == "null" || map[TablesColumnFile.meffdate] == null) ? null : DateTime.parse(map[TablesColumnFile.meffdate]) as DateTime,
        srNo: map[TablesColumnFile.srNo] as int,
        days: map[TablesColumnFile.mdays] as int,
        months: map[TablesColumnFile.mmonths] as int,
        InvAmtFrm: map[TablesColumnFile.minvamtfrm] as double,
        UptoAmt: map[TablesColumnFile.muptoamt] as double,
        offSetIntRate: map[TablesColumnFile.moffsetintrate] as double,
        LowerTolLimit: map[TablesColumnFile.mlowertollimit] as double,
        UpperTolLimit: map[TablesColumnFile.muppertollimit] as double,
        mmlastsynsdate:(map[TablesColumnFile.mmlastsynsdate]==
            "null"||map[TablesColumnFile.mmlastsynsdate]==null) ? null : DateTime.parse(map[TablesColumnFile.mmlastsynsdate]) as DateTime);

  }


}

class TDOffsetIntrestSlabComposite {
  int lBrCode;
  String prdCd;
  String CurCd;
  int acctType;
  DateTime effDate;
  int srNo;


  TDOffsetIntrestSlabComposite({
    this.srNo,
    this.lBrCode,
    this.prdCd,
    this.CurCd,
    this.acctType,
    this.effDate,

  });

  factory TDOffsetIntrestSlabComposite.fromMap(Map<String, dynamic> map) {
    return TDOffsetIntrestSlabComposite(
        lBrCode: map[TablesColumnFile.mlbrcode] as int,
        srNo: map[TablesColumnFile.msrno] as int,
        prdCd: (map[TablesColumnFile.mprdcd] == "null" || map[TablesColumnFile.mprdcd] == null) ? "0" : map[TablesColumnFile.mprdcd] as String,
        CurCd: map[TablesColumnFile.maccttype] as String,
        effDate: (map[TablesColumnFile.meffdate] == "null" || map[TablesColumnFile.meffdate] == null) ? null : DateTime.parse(map[TablesColumnFile.meffdate]) as DateTime);
  }

}



