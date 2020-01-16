import 'package:eco_mfi/db/TablesColumnFile.dart';

class CollectionMasterBean {
  //numeric(8)
  int trefno;
  //numeric(8)
  int mrefno;
  int mcustno;
  DateTime masondate;
  int mlbrcode;
  String mprdacctid;
  int macctstat;
  int mcenterid;
  int mgroupid;
  String mfocode;
  String mleadsid;
  int mloancycle;
  DateTime midealbaldate;
  double modamt;
  double memiamt;
  double mcurrentdue;
  double midealbal;
  int memino;
  DateTime mexpdate;
  double mexpprnpaid;
  double mexpintpaid;
  double mpaidprn;
  double mpaidint;
  double mprnos;
  double mintos;
  double mclosint;
  String mprdcd;
  String mfrequency;
  String mappliedasind;
  DateTime malmeffdate;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  int missynctocoresys;
  DateTime mlastsynsdate;
  String mlongname;
  String mremarks;
  double mcollAmt;
  //double mmainballcy;
  int madjFrmSD;
  int madjfrmexcss;
  int mpaidByGrp;
  int mattendence;
  double unsyncedAmount;
  int isSubmit;
  DateTime mlastopendate;
  double msdbal;
  double mexcesspaid;
  String mbatchcd;

  CollectionMasterBean(  //numeric(8)
          {
        this.trefno,
      //numeric(8)
      this.mrefno,
      this.mcustno,
      this.masondate,
      this.mlbrcode,
      this.mprdacctid,
      this.macctstat,
      this.mcenterid,
      this.mgroupid,
      this.mfocode,
      this.mleadsid,
      this.mloancycle,
      this.midealbaldate,
      this.modamt,
      this.memiamt,
      this.mcurrentdue,
      this.midealbal,
      this.memino,
      this.mexpdate,
      this.mexpprnpaid,
      this.mexpintpaid,
      this.mpaidprn,
      this.mpaidint,
      this.mprnos,
      this.mintos,
      this.mclosint,
      this.mprdcd,
      this.mfrequency,
      this.mappliedasind,
      this.malmeffdate,
      this.mcreateddt,
      this.mcreatedby,
      this.mlastupdatedt,
      this.mlastupdateby,
      this.mgeolocation,
      this.mgeolatd,
      this.mgeologd,
      this.missynctocoresys,
      this.mlastsynsdate,
        this.mlongname,
        this.mremarks,
        this.mcollAmt,
        this.madjFrmSD,
        this.madjfrmexcss,
        this.mpaidByGrp,
        this.mattendence,
        //this.mmainballcy,
        this.unsyncedAmount,
        this.mlastopendate,
        this.mexcesspaid,
        this.msdbal,
        this.mbatchcd
});

  factory CollectionMasterBean.fromMap(Map<String, dynamic> map) {
   // print("map[TablesColumnFile.masondate]"+map[TablesColumnFile.masondate].toString());
    return CollectionMasterBean(
      trefno: map[TablesColumnFile.trefno] as int,
      mrefno: map[TablesColumnFile.mrefno] as int,
      mcustno: map[TablesColumnFile.mcustno] as int,
      masondate:	      (map[TablesColumnFile.masondate]=="null"||map[TablesColumnFile.masondate]==null)?null:DateTime.parse(map[TablesColumnFile.masondate].trim()),
      mlbrcode:	       map[TablesColumnFile.mlbrcode] as int,
      mprdacctid:	       map[TablesColumnFile.mprdacctid] as String,
      macctstat:	       map[TablesColumnFile.macctstat] as int,
      mcenterid:	       map[TablesColumnFile.mcenterid] as int,
      mgroupid:	       map[TablesColumnFile.mgroupid] as int,
      mfocode:	       map[TablesColumnFile.mfocode] as String,
      mleadsid:	       map[TablesColumnFile.mleadsid] as String,
      mloancycle:	       map[TablesColumnFile.mloancycle] as int,
      midealbaldate:	       (map[TablesColumnFile.midealbaldate]=="null"||map[TablesColumnFile.midealbaldate]==null)?null:DateTime.parse(map[TablesColumnFile.midealbaldate.trim()]) as DateTime,
      modamt:	       map[TablesColumnFile.modamt] as double,
      memiamt:	       map[TablesColumnFile.memiamt] as double,
      mcurrentdue:	       map[TablesColumnFile.mcurrentdue] as double,
      midealbal:	       map[TablesColumnFile.midealbal] as double,
      memino:	       map[TablesColumnFile.memino] as int,
      mexpdate:	     (map[TablesColumnFile.mexpdate]=="null"||map[TablesColumnFile.mexpdate]==null)?null:DateTime.parse(map[TablesColumnFile.mexpdate].trim()),
      mexpprnpaid:	       map[TablesColumnFile.mexpprnpaid] as double,
      mexpintpaid:	       map[TablesColumnFile.mexpintpaid] as double,
      mpaidprn:	       map[TablesColumnFile.mpaidprn] as double,
      mpaidint:	       map[TablesColumnFile.mpaidint] as double,
      mprnos:	       map[TablesColumnFile.mprnos] as double,
      mintos:	       map[TablesColumnFile.mintos] as double,
      mclosint:	       map[TablesColumnFile.mclosint] as double,
      mprdcd:	       map[TablesColumnFile.mprdcd] as String,
      mfrequency:	       map[TablesColumnFile.mfrequency] as String,
      mcreateddt: (map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt].trim()),
      mcreatedby:map[TablesColumnFile.mcreatedby],
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt].trim()),
      mlastupdateby:map[TablesColumnFile.mlastupdateby],
      mgeolocation:map[TablesColumnFile.mgeolocation],
      mgeolatd:map[TablesColumnFile.mgeolatd],
      mgeologd:map[TablesColumnFile.mgeologd],
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate].trim()),
      mlongname:map[TablesColumnFile.mlongname],
        mremarks:map[TablesColumnFile.mremarks],
        mcollAmt:map[TablesColumnFile.mcollamt],
        madjFrmSD:map[TablesColumnFile.madjfrmsd],
        madjfrmexcss:map[TablesColumnFile.madjfrmexcss],
        mpaidByGrp:map[TablesColumnFile.mpaidbygrp],
        mattendence:map[TablesColumnFile.mattndnc],
        malmeffdate: (map[TablesColumnFile.malmeffdate]=="null"||map[TablesColumnFile.malmeffdate]==null)?null:DateTime.parse(map[TablesColumnFile.malmeffdate].trim()),
      mlastopendate:(map[TablesColumnFile.mlastopendate]=="null"||map[TablesColumnFile.mlastopendate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastopendate].trim()),
      msdbal:map[TablesColumnFile.msdbal],
      mexcesspaid:map[TablesColumnFile.mexcesspaid],
      mbatchcd:map[TablesColumnFile.mbatchcd],
        mappliedasind :map[TablesColumnFile.mappliedasind],
    );
  }


  factory CollectionMasterBean.fromMapMiddleware(Map<String, dynamic> map) {
    return CollectionMasterBean(
      trefno: map[TablesColumnFile.trefno] as int,
      mrefno: map[TablesColumnFile.mrefno] as int,
      mcustno: map[TablesColumnFile.mcustno] as int,
      masondate:	      (map[TablesColumnFile.masondate]=="null"||map[TablesColumnFile.masondate]==null)?null:DateTime.parse(map[TablesColumnFile.masondate]) as DateTime,
      mlbrcode:	       map[TablesColumnFile.mlbrcode] as int,
      mprdacctid:	       map[TablesColumnFile.mprdacctid] as String,
      macctstat:	       map[TablesColumnFile.macctstat] as int,
      mcenterid:	       map[TablesColumnFile.mcenterid] as int,
      mgroupid:	       map[TablesColumnFile.mgroupid] as int,
      mfocode:	       map[TablesColumnFile.mfocode] as String,
      mleadsid:	       map[TablesColumnFile.mleadsid] as String,
      mloancycle:	       map[TablesColumnFile.mloancycle] as int,
      midealbaldate:	       (map[TablesColumnFile.midealbaldate]=="null"||map[TablesColumnFile.midealbaldate]==null)?null:DateTime.parse(map[TablesColumnFile.midealbaldate]) as DateTime,
      modamt:	       map[TablesColumnFile.modamt] as double,
      memiamt:	       map[TablesColumnFile.memiamt] as double,
      mcurrentdue:	       map[TablesColumnFile.mcurrentdue] as double,
      midealbal:	       map[TablesColumnFile.midealbal] as double,
      memino:	       map[TablesColumnFile.memino] as int,
      mexpdate:	     (map[TablesColumnFile.mexpdate]=="null"||map[TablesColumnFile.mexpdate]==null)?null:DateTime.parse(map[TablesColumnFile.mexpdate]) as DateTime,
      mexpprnpaid:	       map[TablesColumnFile.mexpprnpaid] as double,
      mexpintpaid:	       map[TablesColumnFile.mexpintpaid] as double,
      mpaidprn:	       map[TablesColumnFile.mpaidprn] as double,
      mpaidint:	       map[TablesColumnFile.mpaidint] as double,
      mprnos:	       map[TablesColumnFile.mprnos] as double,
      mintos:	       map[TablesColumnFile.mintos] as double,
      mclosint:	       map[TablesColumnFile.mclosint] as double,
      mprdcd:	       map[TablesColumnFile.mprdcd] as String,
      mfrequency:	       map[TablesColumnFile.mfrequency] as String,
      mcreateddt: (map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby],
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby],
      mgeolocation:map[TablesColumnFile.mgeolocation],
      mgeolatd:map[TablesColumnFile.mgeolatd],
      mgeologd:map[TablesColumnFile.mgeologd],
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      mlongname:map[TablesColumnFile.mlongname],
      mlastopendate:(map[TablesColumnFile.mlastopendate]=="null"||map[TablesColumnFile.mlastopendate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastopendate].trim()),
      msdbal:map[TablesColumnFile.msdbal],
      mexcesspaid:map[TablesColumnFile.mexcesspaid],
      mbatchcd:map[TablesColumnFile.mbatchcd],
      mappliedasind :map[TablesColumnFile.mappliedasind],
    );
  }
// static fromMap(json) {}
}
