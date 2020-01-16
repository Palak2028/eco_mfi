

import 'package:eco_mfi/db/TablesColumnFile.dart';

class InterestOffsetBean {
  final int mlbrcode;
  final String mprdcd;
  final int mloantype;
  final int mloancycle;
  final DateTime meffdate;
  final int msrno;
  final int mmonths;
  final double mamount;
  final double mintrestrate;
  final DateTime mlastsynsdate;
  InterestOffsetComposite interestOffsetComposite;

  InterestOffsetBean(
      {
        this.mlbrcode,
        this.mprdcd,
        this.mloantype,
        this.mloancycle,
        this.meffdate,
        this.msrno,
        this.mmonths,
        this.mamount,
        this.mintrestrate,
        this.mlastsynsdate,
        this.interestOffsetComposite

      });
  factory InterestOffsetBean.fromMap(Map<String, dynamic> map) {
    return InterestOffsetBean(
        mlbrcode:map[TablesColumnFile.mlbrcode] as int,
        mprdcd:map[TablesColumnFile.mprdcd] as String,
        mloantype:map[TablesColumnFile.mloantype] as int,
        mloancycle:map[TablesColumnFile.mloancycle] as int,
        meffdate:(map[TablesColumnFile.meffdate]=="null"||map[TablesColumnFile.meffdate]==null)?null:DateTime.parse(map[TablesColumnFile.meffdate]) as DateTime,
        msrno:map[TablesColumnFile.msrno] as int,
        mmonths:map[TablesColumnFile.mmonths] as int,
        mamount:map[TablesColumnFile.mamount] as double,
        mintrestrate:map[TablesColumnFile.mintrestrate] as double,
        mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
        interestOffsetComposite: InterestOffsetComposite.fromJson(map[TablesColumnFile.interestOffsetComposite])

    );
  }

  factory InterestOffsetBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware) {
    print("fromMap");
    return InterestOffsetBean(
        mlbrcode:map[TablesColumnFile.mlbrcode] as int,
        mprdcd:map[TablesColumnFile.mprdcd] as String,
        mloantype:map[TablesColumnFile.mloantype] as int,
        mloancycle:map[TablesColumnFile.mloancycle] as int,
        meffdate:(map[TablesColumnFile.meffdate]=="null"||map[TablesColumnFile.meffdate]==null)?null:DateTime.parse(map[TablesColumnFile.meffdate]) as DateTime,
        msrno:map[TablesColumnFile.msrno] as int,
        mmonths:map[TablesColumnFile.mmonths] as int,
        mamount:map[TablesColumnFile.mamount] as double,
        mintrestrate:map[TablesColumnFile.mintrestrate] as double,
        mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
        interestOffsetComposite: InterestOffsetComposite.fromJson(map[TablesColumnFile.interestOffsetComposite])

    );}

  static fromJson(list) {}
}

class InterestOffsetComposite{
  final int mlbrcode;
  final String mprdcd;
  final int mloantype;
  final int mloancycle;
  final DateTime meffdate;
  final int msrno;
  InterestOffsetComposite({  this.mlbrcode,
    this.mprdcd,
    this.mloantype,
    this.mloancycle,
    this.meffdate,
    this.msrno,});

  factory InterestOffsetComposite.fromJson(Map<String, dynamic> map) {
    return InterestOffsetComposite(
      mlbrcode:map[TablesColumnFile.mlbrcode] as int,
      mprdcd:map[TablesColumnFile.mprdcd] as String,
      mloantype:map[TablesColumnFile.mloantype] as int,
      mloancycle:map[TablesColumnFile.mloancycle] as int,
      meffdate:(map[TablesColumnFile.meffdate]=="null"||map[TablesColumnFile.meffdate]==null)?null:DateTime.parse(map[TablesColumnFile.meffdate]) as DateTime,
      msrno:map[TablesColumnFile.msrno] as int

    );
  }
}

