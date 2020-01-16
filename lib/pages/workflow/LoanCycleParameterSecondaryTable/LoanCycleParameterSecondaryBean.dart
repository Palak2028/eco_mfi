

import 'package:eco_mfi/db/TablesColumnFile.dart';

class LoanCycleParameterSecondaryBean {
  final int mlbrcode;
  final String mprdcd;
  final int mloancycle;
  final int mcusttype;
  final int mgrtype;
  final DateTime meffdate;
  final String mfrequency;
  final int mruletype;
  final int msrno;
  final double muptoamount;
  final double mminamount;
  final double mmaxamount;
  final DateTime mlastsynsdate;
  LoanCycleParameterSecondaryComposite loanCycleParameterSecondaryComposite;

  LoanCycleParameterSecondaryBean(
      {
        this.mlbrcode,
        this.mprdcd,
        this.mloancycle,
        this.mcusttype,
        this.mgrtype,
        this.meffdate,
        this.mfrequency,
        this.mruletype,
        this.msrno,
        this.muptoamount,
        this.mminamount,
        this.mmaxamount,
        this.mlastsynsdate,	
        this.loanCycleParameterSecondaryComposite


      });
  factory LoanCycleParameterSecondaryBean.fromMap(Map<String, dynamic> map) {
    return LoanCycleParameterSecondaryBean(
        mlbrcode:map[TablesColumnFile.mlbrcode] as int,
        mprdcd:map[TablesColumnFile.mprdcd] as String,
        mloancycle:map[TablesColumnFile.mloancycle] as int,
        mcusttype:map[TablesColumnFile.mcusttype] as int,
        mgrtype:map[TablesColumnFile.mgrtype] as int,
        meffdate:(map[TablesColumnFile.meffdate]=="null"||map[TablesColumnFile.meffdate]==null)?null:DateTime.parse(map[TablesColumnFile.meffdate]) as DateTime,
        mfrequency:map[TablesColumnFile.mfrequency] as String,
        mruletype:map[TablesColumnFile.mruletype] as int,
        msrno:map[TablesColumnFile.msrno] as int,
        muptoamount:map[TablesColumnFile.muptoamount] as double,
        mminamount:map[TablesColumnFile.mminamount] as double,
        mmaxamount:map[TablesColumnFile.mmaxamount] as double,
        mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
  loanCycleParameterSecondaryComposite: LoanCycleParameterSecondaryComposite.fromJson(map[TablesColumnFile.loanCycleParameterSecondaryComposite])


    );
  }

  factory LoanCycleParameterSecondaryBean.fromLocalDb(Map<String, dynamic> map) {
    print("map of seconfdary amt "+ map.toString());
    return LoanCycleParameterSecondaryBean(
        mlbrcode:map[TablesColumnFile.mlbrcode] as int,
        mprdcd:map[TablesColumnFile.mprdcd] as String,
        mloancycle:map[TablesColumnFile.mloancycle] as int,
        mcusttype:map[TablesColumnFile.mcusttype] as int,
        mgrtype:map[TablesColumnFile.mgrtype] as int,
        meffdate:(map[TablesColumnFile.meffdate]=="null"||map[TablesColumnFile.meffdate]==null)?null:DateTime.parse(map[TablesColumnFile.meffdate]) as DateTime,
        mfrequency:map[TablesColumnFile.mfrequency] as String,
        mruletype:map[TablesColumnFile.mruletype] as int,
        msrno:map[TablesColumnFile.msrno] as int,
        muptoamount:map[TablesColumnFile.muptoamount] as double,
        mminamount:map[TablesColumnFile.mminamount] as double,
        mmaxamount:map[TablesColumnFile.mmaxamount] as double,
        mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime



    );}

  static fromJson(list) {}
}


class LoanCycleParameterSecondaryComposite {
  final int mlbrcode;
  final String mprdcd;
  final int mloancycle;
  final int mcusttype;
  final int mgrtype;
  final DateTime meffdate;
  final String mfrequency;
  final int mruletype;
  final int msrno;

  LoanCycleParameterSecondaryComposite({ this.mlbrcode,
    this.mprdcd,
    this.mloancycle,
    this.mcusttype,
    this.mgrtype,
    this.meffdate,
    this.mfrequency,
    this.mruletype,
    this.msrno
  });

  factory LoanCycleParameterSecondaryComposite.fromJson(
      Map<String, dynamic> map) {

    return LoanCycleParameterSecondaryComposite(
        mlbrcode: map[TablesColumnFile.mlbrcode] as int,
        mprdcd: map[TablesColumnFile.mprdcd] as String,
        mloancycle: map[TablesColumnFile.mloancycle] as int,
        mcusttype: map[TablesColumnFile.mcusttype] as int,
        mgrtype: map[TablesColumnFile.mgrtype] as int,
        meffdate: (map[TablesColumnFile.meffdate] == "null" ||
            map[TablesColumnFile.meffdate] == null) ? null : DateTime.parse(
            map[TablesColumnFile.meffdate]) as DateTime,
        mfrequency: map[TablesColumnFile.mfrequency] as String,
        mruletype: map[TablesColumnFile.mruletype] as int,
        msrno: map[TablesColumnFile.msrno] as int
    );
  }




}