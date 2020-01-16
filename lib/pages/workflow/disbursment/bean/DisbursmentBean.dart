import 'package:eco_mfi/db/TablesColumnFile.dart';

class DisbursmentBean {
  int trefno;
  int mrefno;
  int	mlbrcode;
  int mcustno;
  String mprdacctid;
  String mlongname;
  int mgroupcd;
  DateTime mefffromdate;
  DateTime mdisburseddate;
  DateTime minstlstartdate;
  double minstlamt;
  double minstlintcomp;
  String mleadsid;
  String mappliedasindvyn;
  int	mnewtopupflag;
  DateTime msancdate;
  double mdisbursedamt;
  double msdamt;
  double mrebateamt;
  double mchargesamt;
  double mdisbursedamtcoltd;
  double msdamtcoltd;
  double mrebateamtcoltd;
  double mchargesamtcoltd;
  int	mdisbursedamtflag;
  int	msdamtflag;
  int	mrebateamtflag;
  int	mchargesamtflag;
  String mreason;
  int	msetno;
  int	mscrollno;
  DateTime mentrydate;
  String mbatchcd;
  int	mmainscrollno;
  String mbatchnumber;
  String mnarration;
  int mcenterid;
  String mcrs;
  String msuspbatchcd;
  int msuspsetno;
  int	msuspscrollno;
  int	msspmainscrollno;
  double mpartcashamount;
  String mpartcashbatchcd;
  int	mpartcashsetno;
  int	mpartcashscrollno;
  int	mpartcashmainscrollno;
  String mneftclsrBatchCd;
  int	mneftclsrsetno;
  int	mneftclsrscrollno;
  int	mneftclsrmainscrollno;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  DateTime mlastsynsdate;
  String merrormessage;
  double mdisbamount;
  double mchargesamt0;
  double mchargesamt1;
  double mchargesamt2;
  double mchargesamt3;
  double mchargesamt4;
  double mchargesamt5;
  double mchargesamt6;
  double mchargesamt7;
  double mchargesamt8;
  double mchargesamt9;


  int mcheckbiometric;
  int mdisbstatus;
  String mrouteto;
  String mremarks;
  int misdisbursed;
  int misauthorized;




  DisbursmentBean(  //numeric(8)
          {
        this.trefno,
        this.mrefno,
        this.mlbrcode,
        this.mcustno,
        this.mprdacctid,
        this.mlongname,
        this.mgroupcd,
        this.mefffromdate,
        this.mdisburseddate,
        this.minstlstartdate,
        this.minstlamt,
        this.minstlintcomp,
        this.mleadsid,
        this.mappliedasindvyn,
        this.mnewtopupflag,
        this.msancdate,
        this.mdisbursedamt,
        this.msdamt,
        this.mrebateamt,
        this.mchargesamt,
        this.mdisbursedamtcoltd,
        this.msdamtcoltd,
        this.mrebateamtcoltd,
        this.mchargesamtcoltd,
        this.mdisbursedamtflag,
        this.msdamtflag,
        this.mrebateamtflag,
        this.mchargesamtflag,
        this.mreason,
        this.msetno,
        this.mscrollno,
        this.mentrydate,
        this.mbatchcd,
        this.mmainscrollno,
        this.mbatchnumber,
        this.mnarration,
        this.mcenterid,
        this.mcrs,
        this.msuspbatchcd,
        this.msuspsetno,
        this.msuspscrollno,
        this.msspmainscrollno,
        this.mpartcashamount,
        this.mpartcashbatchcd,
        this.mpartcashsetno,
        this.mpartcashscrollno,
        this.mpartcashmainscrollno,
        this.mneftclsrBatchCd,
        this.mneftclsrsetno,
        this.mneftclsrscrollno,
        this.mneftclsrmainscrollno,
        this.mcreateddt,
        this.mcreatedby,
        this.mlastupdatedt,
        this.mlastupdateby,
        this.mgeolocation,
        this.mgeolatd,
        this.mgeologd,
        this.mlastsynsdate,
        this.merrormessage,
        this.mdisbamount,
        this.mchargesamt1,
        this.mchargesamt2,
        this.mchargesamt0,
        this.mchargesamt3,
        this.mchargesamt4,
        this.mchargesamt5,
        this.mchargesamt6,
        this.mchargesamt7,
        this.mchargesamt8,
        this.mchargesamt9,
        this.mcheckbiometric,
        this.mdisbstatus,
        this.mrouteto,
        this.mremarks,
        this.misauthorized
});


  @override
  String toString() {
    return 'DisbursmentBean{trefno: $trefno, mrefno: $mrefno, mlbrcode: $mlbrcode, mcustno: $mcustno, mprdacctid: $mprdacctid, mlongname: $mlongname, mgroupcd: $mgroupcd, mefffromdate: $mefffromdate, mdisburseddate: $mdisburseddate, minstlstartdate: $minstlstartdate, minstlamt: $minstlamt, minstlintcomp: $minstlintcomp, mleadsid: $mleadsid, mappliedasindvyn: $mappliedasindvyn, mnewtopupflag: $mnewtopupflag, msancdate: $msancdate, mdisbursedamt: $mdisbursedamt, msdamt: $msdamt, mrebateamt: $mrebateamt, mchargesamt: $mchargesamt, mdisbursedamtcoltd: $mdisbursedamtcoltd, msdamtcoltd: $msdamtcoltd, mrebateamtcoltd: $mrebateamtcoltd, mchargesamtcoltd: $mchargesamtcoltd, mdisbursedamtflag: $mdisbursedamtflag, msdamtflag: $msdamtflag, mrebateamtflag: $mrebateamtflag, mchargesamtflag: $mchargesamtflag, mreason: $mreason, msetno: $msetno, mscrollno: $mscrollno, mentrydate: $mentrydate, mbatchcd: $mbatchcd, mmainscrollno: $mmainscrollno, mbatchnumber: $mbatchnumber, mnarration: $mnarration, mcenterid: $mcenterid, mcrs: $mcrs, msuspbatchcd: $msuspbatchcd, msuspsetno: $msuspsetno, msuspscrollno: $msuspscrollno, msspmainscrollno: $msspmainscrollno, mpartcashamount: $mpartcashamount, mpartcashbatchcd: $mpartcashbatchcd, mpartcashsetno: $mpartcashsetno, mpartcashscrollno: $mpartcashscrollno, mpartcashmainscrollno: $mpartcashmainscrollno, mneftclsrBatchCd: $mneftclsrBatchCd, mneftclsrsetno: $mneftclsrsetno, mneftclsrscrollno: $mneftclsrscrollno, mneftclsrmainscrollno: $mneftclsrmainscrollno, mcreateddt: $mcreateddt, mcreatedby: $mcreatedby, mlastupdatedt: $mlastupdatedt, mlastupdateby: $mlastupdateby, mgeolocation: $mgeolocation, mgeolatd: $mgeolatd, mgeologd: $mgeologd, mlastsynsdate: $mlastsynsdate, merrormessage: $merrormessage, mdisbamount: $mdisbamount, mchargesamt0: $mchargesamt0, mchargesamt1: $mchargesamt1, mchargesamt2: $mchargesamt2, mchargesamt3: $mchargesamt3, mchargesamt4: $mchargesamt4, mchargesamt5: $mchargesamt5, mchargesamt6: $mchargesamt6, mchargesamt7: $mchargesamt7, mchargesamt8: $mchargesamt8, mchargesamt9: $mchargesamt9, mcheckbiometric: $mcheckbiometric,'
        ' mdisbstatus: $mdisbstatus, mauthorizedby: $mrouteto, mremarks: $mremarks, misdisbursed: $misdisbursed}';
  }

  factory DisbursmentBean.fromMap(Map<String, dynamic> map) {
   // print("map[TablesColumnFile.masondate]"+map[TablesColumnFile.masondate].toString());
    return DisbursmentBean(
      trefno:	map[TablesColumnFile.trefno] as int,
      mrefno:	map[TablesColumnFile.mrefno] as int,
      mlbrcode:	map[TablesColumnFile.mlbrcode] as int,
        mcustno:	map[TablesColumnFile.mcustno] as int,
        mprdacctid:	map[TablesColumnFile.mprdacctid] as String,
        mlongname: map[TablesColumnFile.mlongname] as String,
        mgroupcd: map[TablesColumnFile.mgroupcd] as int,
      mefffromdate:(map[TablesColumnFile.mefffromdate]=="null"||map[TablesColumnFile.mefffromdate]==null)?null:DateTime.parse(map[TablesColumnFile.mefffromdate]) as DateTime,
      mdisburseddate:(map[TablesColumnFile.mdisburseddate]=="null"||map[TablesColumnFile.mdisburseddate]==null)?null:DateTime.parse(map[TablesColumnFile.mdisburseddate]) as DateTime,
      minstlstartdate:(map[TablesColumnFile.minstlstartdate]=="null"||map[TablesColumnFile.minstlstartdate]==null)?null:DateTime.parse(map[TablesColumnFile.minstlstartdate]) as DateTime,
      minstlamt:	map[TablesColumnFile.minstlamt] as double,
      minstlintcomp:	map[TablesColumnFile.minstlintcomp] as double,
      mleadsid:	map[TablesColumnFile.mleadsid] as String,
      mappliedasindvyn:	map[TablesColumnFile.mappliedasindvyn] as String,
      mnewtopupflag:	map[TablesColumnFile.mnewtopupflag] as int,
      msancdate:(map[TablesColumnFile.msancdate]=="null"||map[TablesColumnFile.msancdate]==null)?null:DateTime.parse(map[TablesColumnFile.msancdate]) as DateTime,
      mdisbursedamt:	map[TablesColumnFile.mdisbursedamt] as double,
      msdamt:	map[TablesColumnFile.msdamt] as double,
      mrebateamt:	map[TablesColumnFile.mrebateamt] as double,
      mchargesamt:	map[TablesColumnFile.mchargesamt] as double,
      mdisbursedamtcoltd:	map[TablesColumnFile.mdisbursedamtcoltd] as double,
      msdamtcoltd:	map[TablesColumnFile.msdamtcoltd] as double,
      mrebateamtcoltd:	map[TablesColumnFile.mrebateamtcoltd] as double,
      mchargesamtcoltd:	map[TablesColumnFile.mchargesamtcoltd] as double,
      mdisbursedamtflag:	map[TablesColumnFile.mdisbursedamtflag] as int,
      msdamtflag:	map[TablesColumnFile.msdamtflag] as int,
      mrebateamtflag:	map[TablesColumnFile.mrebateamtflag] as int,
      mchargesamtflag:	map[TablesColumnFile.mchargesamtflag] as int,
      mreason:	map[TablesColumnFile.mreason] as String,
      msetno:	map[TablesColumnFile.msetno] as int,
      mscrollno:	map[TablesColumnFile.mscrollno] as int,
      mentrydate:(map[TablesColumnFile.mentrydate]=="null"||map[TablesColumnFile.mentrydate]==null)?null:DateTime.parse(map[TablesColumnFile.mentrydate]) as DateTime,
      mbatchcd:	map[TablesColumnFile.mbatchcd] as String,
      mmainscrollno:	map[TablesColumnFile.mmainscrollno] as int,
      mbatchnumber:	map[TablesColumnFile.mbatchnumber] as String,
      mnarration:	map[TablesColumnFile.mnarration] as String,
      mcenterid:	map[TablesColumnFile.mcenterid] as int,
      mcrs:	map[TablesColumnFile.mcrs] as String,
      msuspbatchcd:	map[TablesColumnFile.msuspbatchcd] as String,
      msuspsetno:	map[TablesColumnFile.msuspsetno] as int,
      msuspscrollno:	map[TablesColumnFile.msuspscrollno] as int,
      msspmainscrollno:	map[TablesColumnFile.msspmainscrollno] as int,
      mpartcashamount:	map[TablesColumnFile.mpartcashamount] as double,
      mpartcashbatchcd:	map[TablesColumnFile.mpartcashbatchcd] as String,
      mpartcashsetno:	map[TablesColumnFile.mpartcashsetno] as int,
      mpartcashscrollno:	map[TablesColumnFile.mpartcashscrollno] as int,
      mneftclsrmainscrollno:	map[TablesColumnFile.mneftclsrmainscrollno] as int,
      mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:	map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation:	map[TablesColumnFile.mgeolocation] as String,
      mgeolatd:	map[TablesColumnFile.mgeolatd] as String,
      mgeologd:	map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      merrormessage:	map[TablesColumnFile.merrormessage] as String,
      mdisbamount 	:map[TablesColumnFile.mdisbamount] as double,
      mchargesamt1	:map[TablesColumnFile.mchargesamt1] as double,
      mchargesamt2	:map[TablesColumnFile.mchargesamt2] as double,
      mchargesamt0	:map[TablesColumnFile.mchargesamt0] as double,
      mchargesamt3	:map[TablesColumnFile.mchargesamt3] as double,
      mchargesamt4	:map[TablesColumnFile.mchargesamt4] as double,
      mchargesamt5	:map[TablesColumnFile.mchargesamt5] as double,
      mchargesamt6	:map[TablesColumnFile.mchargesamt6] as double,
      mchargesamt7	:map[TablesColumnFile.mchargesamt7] as double,
      mchargesamt8	:map[TablesColumnFile.mchargesamt8] as double,
      mchargesamt9	:map[TablesColumnFile.mchargesamt9] as double,
        mcheckbiometric:map[TablesColumnFile.mcheckbiometric] as int,
      mdisbstatus  : map[TablesColumnFile.mdisbstatus] as int,
        mrouteto: map[TablesColumnFile.mrouteto] as String,
      mremarks: map[TablesColumnFile.mremarks] as String,
      misauthorized: map[TablesColumnFile.misauthorized] as int,
    );
  }


  factory DisbursmentBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware) {
    return DisbursmentBean(
      trefno:	map[TablesColumnFile.trefno] as int,
      mrefno:	map[TablesColumnFile.mrefno] as int,
      mlbrcode:	map[TablesColumnFile.mlbrcode] as int,
        mcustno:	map[TablesColumnFile.mcustno] as int,
        mprdacctid:	map[TablesColumnFile.mprdacctid] as String,
        mlongname: map[TablesColumnFile.mlongname] as String,
        mgroupcd: map[TablesColumnFile.mgroupcd] as int,
      mefffromdate:(map[TablesColumnFile.mefffromdate]=="null"||map[TablesColumnFile.mefffromdate]==null)?null:DateTime.parse(map[TablesColumnFile.mefffromdate]) as DateTime,
      mdisburseddate:(map[TablesColumnFile.mdisburseddate]=="null"||map[TablesColumnFile.mdisburseddate]==null)?null:DateTime.parse(map[TablesColumnFile.mdisburseddate]) as DateTime,
      minstlstartdate:(map[TablesColumnFile.minstlstartdate]=="null"||map[TablesColumnFile.minstlstartdate]==null)?null:DateTime.parse(map[TablesColumnFile.minstlstartdate]) as DateTime,
      minstlamt:	map[TablesColumnFile.minstlamt] as double,
      minstlintcomp:	map[TablesColumnFile.minstlintcomp] as double,
      mleadsid:	map[TablesColumnFile.mleadsid] as String,
      mappliedasindvyn:	map[TablesColumnFile.mappliedasindvyn] as String,
      mnewtopupflag:	map[TablesColumnFile.mnewtopupflag] as int,
      msancdate:(map[TablesColumnFile.msancdate]=="null"||map[TablesColumnFile.msancdate]==null)?null:DateTime.parse(map[TablesColumnFile.msancdate]) as DateTime,
      mdisbursedamt:	map[TablesColumnFile.mdisbursedamt] as double,
      msdamt:	map[TablesColumnFile.msdamt] as double,
      mrebateamt:	map[TablesColumnFile.mrebateamt] as double,
      mchargesamt:	map[TablesColumnFile.mchargesamt] as double,
      mdisbursedamtcoltd:	map[TablesColumnFile.mdisbursedamtcoltd] as double,
      msdamtcoltd:	map[TablesColumnFile.msdamtcoltd] as double,
      mrebateamtcoltd:	map[TablesColumnFile.mrebateamtcoltd] as double,
      mchargesamtcoltd:	map[TablesColumnFile.mchargesamtcoltd] as double,
      mdisbursedamtflag:	map[TablesColumnFile.mdisbursedamtflag] as int,
      msdamtflag:	map[TablesColumnFile.msdamtflag] as int,
      mrebateamtflag:	map[TablesColumnFile.mrebateamtflag] as int,
      mchargesamtflag:	map[TablesColumnFile.mchargesamtflag] as int,
      mreason:	map[TablesColumnFile.mreason] as String,
      msetno:	map[TablesColumnFile.msetno] as int,
      mscrollno:	map[TablesColumnFile.mscrollno] as int,
      mentrydate:(map[TablesColumnFile.mentrydate]=="null"||map[TablesColumnFile.mentrydate]==null)?null:DateTime.parse(map[TablesColumnFile.mentrydate]) as DateTime,
      mbatchcd:	map[TablesColumnFile.mbatchcd] as String,
      mmainscrollno:	map[TablesColumnFile.mmainscrollno] as int,
      mbatchnumber:	map[TablesColumnFile.mbatchnumber] as String,
      mnarration:	map[TablesColumnFile.mnarration] as String,
      mcenterid:	map[TablesColumnFile.mcenterid] as int,
      mcrs:	map[TablesColumnFile.mcrs] as String,
      msuspbatchcd:	map[TablesColumnFile.msuspbatchcd] as String,
      msuspsetno:	map[TablesColumnFile.msuspsetno] as int,
      msuspscrollno:	map[TablesColumnFile.msuspscrollno] as int,
      msspmainscrollno:	map[TablesColumnFile.msspmainscrollno] as int,
      mpartcashamount:	map[TablesColumnFile.mpartcashamount] as double,
      mpartcashbatchcd:	map[TablesColumnFile.mpartcashbatchcd] as String,
      mpartcashsetno:	map[TablesColumnFile.mpartcashsetno] as int,
      mpartcashscrollno:	map[TablesColumnFile.mpartcashscrollno] as int,
      mneftclsrmainscrollno:	map[TablesColumnFile.mneftclsrmainscrollno] as int,
      mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:	map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation:	map[TablesColumnFile.mgeolocation] as String,
      mgeolatd:	map[TablesColumnFile.mgeolatd] as String,
      mgeologd:	map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      merrormessage:	map[TablesColumnFile.merrormessage] as String,
      mdisbamount 	:map[TablesColumnFile.mdisbamount] as double,
      mchargesamt1	:map[TablesColumnFile.mchargesamt1] as double,
      mchargesamt2	:map[TablesColumnFile.mchargesamt2] as double,
      mchargesamt0	:map[TablesColumnFile.mchargesamt0] as double,
      mchargesamt3	:map[TablesColumnFile.mchargesamt3] as double,
      mchargesamt4	:map[TablesColumnFile.mchargesamt4] as double,
      mchargesamt5	:map[TablesColumnFile.mchargesamt5] as double,
      mchargesamt6	:map[TablesColumnFile.mchargesamt6] as double,
      mchargesamt7	:map[TablesColumnFile.mchargesamt7] as double,
      mchargesamt8	:map[TablesColumnFile.mchargesamt8] as double,
      mchargesamt9	:map[TablesColumnFile.mchargesamt9] as double,

        mcheckbiometric:map[TablesColumnFile.mcheckbiometric] as int,
        mdisbstatus  : map[TablesColumnFile.mdisbstatus] as int,
        mrouteto: map[TablesColumnFile.mrouteto] as String,
      mremarks: map[TablesColumnFile.mremarks] as String,
      misauthorized: map[TablesColumnFile.misauthorized] as int,

    );
  }
}
