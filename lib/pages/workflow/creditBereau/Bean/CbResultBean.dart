import 'package:eco_mfi/db/TablesColumnFile.dart';

class CbResultBean {

  int trefno;
  int mrefno;
  int trefsrno;
  int mrefsrno;
  int trefresultsrno;
  int mrefresultsrno;

  String mcbcheckstatus;
  String mdateofissue;
  String mdateofrequest;
  String miscustomercreated;
  String mpreparedfor;
  String mreportid;

  int mothrmficnt;
  int mloancycle;
  double mothrmficurbal;
  double mothrmfiovrdueamt;
  double mothrmfidisbamt;
  int mtotovrdueaccno;
  double mmfitotdisbamt;
  double mmfitotcurrentbal;
  double mmfitotovrdueamt;
  double mtotovrdueamt;
  double mtotcurrentbal;
  double mtotdisbamt;
  double mexpsramt;


  String mcbresultblob;













/*  String mprimarycurrentbal;
  String mprimarynoofaccounts;
  String mprimaryoverdueamount;
  String mprimarynoofactiveacs;
  String mprimarynoofodaccs;*/

/*  String msecondarycurrentbalance;
  String msecondarynoofaccs;
  String msecondaryoverdueamount;
  String msecondarynoofactiveaccs;
  String msecondarynoofodacs;
  String msecondarysanctionedamt;*/
  DateTime mcreateddt;
  /*String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  int missynctocoresys;
  DateTime mlastsynsdate;*/
  String maccounttype;
  double mcurrentbalance;
  String mcustbankacnum;
  String mdatereported;
  double mdisbursedamount;
  String mnameofmfi;
  String mnocimagestring;
  double moverdueamount;
  double mwriteoffamount;
  String magentusername;
  String maccountNumber;
  String mmfiid;








  CbResultBean({this.trefno, this.mrefno, this.trefsrno, this.mrefsrno,
      this.trefresultsrno, this.mrefresultsrno, this.mcbcheckstatus,
      this.mdateofissue, this.mdateofrequest, this.miscustomercreated,
      this.mpreparedfor, this.mreportid, this.mcreateddt, this.maccounttype,
      this.mcurrentbalance, this.mcustbankacnum, this.mdatereported,
      this.mdisbursedamount, this.mnameofmfi, this.mnocimagestring,
      this.moverdueamount, this.mwriteoffamount, this.magentusername,
      this.maccountNumber, this.mothrmficnt, this.mloancycle,
      this.mothrmficurbal, this.mothrmfiovrdueamt, this.mothrmfidisbamt,
      this.mtotovrdueaccno, this.mmfitotdisbamt, this.mmfitotcurrentbal,
      this.mmfitotovrdueamt, this.mtotovrdueamt, this.mtotcurrentbal,
      this.mtotdisbamt, this.mexpsramt,this.mcbresultblob,this.mmfiid,

  });


  @override
  String toString() {
    return 'CbResultBean{trefno: $trefno, mrefno: $mrefno, trefsrno: $trefsrno, mrefsrno: $mrefsrno,'
        ' trefresultsrno: $trefresultsrno, mrefresultsrno: $mrefresultsrno, mcbcheckstatus: $mcbcheckstatus, '
        'mdateofissue: $mdateofissue, mdateofrequest: $mdateofrequest, miscustomercreated: $miscustomercreated, '
        'mpreparedfor: $mpreparedfor, mothrmficnt: $mothrmficnt, mloancycle: $mloancycle, '
        'mothrmficurbal: $mothrmficurbal, mothrmfiovrdueamt: $mothrmfiovrdueamt, mothrmfidisbamt: $mothrmfidisbamt, '
        'mtotovrdueaccno: $mtotovrdueaccno, mmfitotdisbamt: $mmfitotdisbamt, mmfitotcurrentbal: $mmfitotcurrentbal, '
        'mmfitotovrdueamt: $mmfitotovrdueamt, mtotovrdueamt: $mtotovrdueamt, mtotcurrentbal: $mtotcurrentbal,'
        ' mtotdisbamt: $mtotdisbamt, mexpsramt: $mexpsramt, mreportid: $mreportid, mcreateddt: $mcreateddt, '
        'maccounttype: $maccounttype, mcurrentbalance: $mcurrentbalance, mcustbankacnum: $mcustbankacnum, '
        'mdatereported: $mdatereported, mdisbursedamount: $mdisbursedamount, mnameofmfi: $mnameofmfi, '
        'mnocimagestring: $mnocimagestring, moverdueamount: $moverdueamount, mwriteoffamount: $mwriteoffamount, '
        'magentusername: $magentusername, maccountNumber: $maccountNumber}';
  }

  factory CbResultBean.fromMap(Map<String, dynamic> map) {
    print("inside  CbResultBean map");
    print(map);
    return CbResultBean(
      trefno:map[TablesColumnFile.trefno] as int,
      mrefno:map[TablesColumnFile.mrefno] as int,
      trefsrno:map[TablesColumnFile.trefsrno] as int,
      mrefsrno:map[TablesColumnFile.mrefsrno] as int,
      trefresultsrno:map[TablesColumnFile.trefresultsrno] as int,
      mrefresultsrno:map[TablesColumnFile.mrefresultsrno] as int,

      mcbcheckstatus:map[TablesColumnFile.mcbcheckstatus] as String,
      mdateofissue:map[TablesColumnFile.mdateofissue] as String,
      mdateofrequest:map[TablesColumnFile.mdateofrequest] as String,
      miscustomercreated:map[TablesColumnFile.miscustomercreated] as String,
      mpreparedfor:map[TablesColumnFile.mpreparedfor] as String,


      mreportid:map[TablesColumnFile.mreportid] as String,
      mothrmficnt:			map[TablesColumnFile.mothrmficnt] as int,
      mloancycle:			  map[TablesColumnFile.mloancycle] as int,
      mothrmficurbal:			  map[TablesColumnFile.mothrmficurbal] as double,
      mothrmfiovrdueamt:			  map[TablesColumnFile.mothrmfiovrdueamt] as double,
      mothrmfidisbamt:			  map[TablesColumnFile.mothrmfidisbamt] as double,
      mtotovrdueaccno:			  map[TablesColumnFile.mtotovrdueaccno] as int,
      mmfitotdisbamt:			  map[TablesColumnFile.mmfitotdisbamt] as double,
      mmfitotcurrentbal:			  map[TablesColumnFile.mmfitotcurrentbal] as double,
      mmfitotovrdueamt:			  map[TablesColumnFile.mmfitotovrdueamt] as double,
      mtotovrdueamt:			  map[TablesColumnFile.mtotovrdueamt] as double,
      mtotcurrentbal:			  map[TablesColumnFile.mtotcurrentbal] as double,
      mtotdisbamt:			  map[TablesColumnFile.mtotdisbamt] as double,
      mexpsramt:			  map[TablesColumnFile.mexpsramt] as double,
      mcbresultblob:map[TablesColumnFile.mcbresultblob] as String,





      /*mprimarycurrentbal:map[TablesColumnFile.mprimarycurrentbal] as String,
      mprimarynoofaccounts:map[TablesColumnFile.mprimarynoofaccounts] as String,
      mprimaryoverdueamount:map[TablesColumnFile.mprimaryoverdueamount] as String,
      mprimarynoofactiveacs:map[TablesColumnFile.mprimarynoofactiveacs] as String,
      mprimarynoofodaccs:map[TablesColumnFile.mprimarynoofodaccs] as String,
      msecondarycurrentbalance:map[TablesColumnFile.msecondarycurrentbalance] as String,
      msecondarynoofaccs:map[TablesColumnFile.msecondarynoofaccs] as String,
      msecondaryoverdueamount:map[TablesColumnFile.msecondaryoverdueamount] as String,
      msecondarynoofactiveaccs:map[TablesColumnFile.msecondarynoofactiveaccs] as String,

      msecondarynoofodacs:map[TablesColumnFile.msecondarynoofodacs] as String,
      msecondarysanctionedamt:map[TablesColumnFile.msecondarysanctionedamt] as String,*/

      mcreateddt:map[TablesColumnFile.mcreateddt]=="null"|| map[TablesColumnFile.mcreateddt]== null ?null:DateTime.parse(map[TablesColumnFile.mcreateddt])	 as DateTime,

      maccounttype:map[TablesColumnFile.maccounttype] as String,
      mcurrentbalance:map[TablesColumnFile.mcurrentbalance] as double,
      mcustbankacnum:map[TablesColumnFile.mcustbankacnum] as String,
      mdatereported:map[TablesColumnFile.mdatereported] as String,
      mdisbursedamount:map[TablesColumnFile.mdisbursedamount] as double,
      mnameofmfi:map[TablesColumnFile.mnameofmfi] as String,
      mnocimagestring :map[/*TablesColumnFile.mnocimagestring*/"mnocimagestring" ] as String,
      moverdueamount:map[TablesColumnFile.moverdueamount] as double,
      mwriteoffamount:map[TablesColumnFile.mwriteoffamount] as double,
      magentusername:map[TablesColumnFile.magentusername] as String,
      maccountNumber: map[TablesColumnFile.maccountNumber] as String,
      mmfiid : map[TablesColumnFile.mmfiid] as String,

    );
  }




  factory CbResultBean.mapFromMiddleware(Map<String, dynamic> map) {
    print("inside CbResultBean map");
    print(map);
    return CbResultBean(
      trefno:map[TablesColumnFile.trefno] as int,
      mrefno:map[TablesColumnFile.mrefno] as int,
      trefsrno:map[TablesColumnFile.trefsrno] as int,
      mrefsrno:map[TablesColumnFile.mrefsrno] as int,
      trefresultsrno:map[TablesColumnFile.trefresultsrno] as int,
      mrefresultsrno:map[TablesColumnFile.mrefresultsrno] as int,
      mcbcheckstatus:map[TablesColumnFile.mcbcheckstatus] as String,
      mdateofissue:map[TablesColumnFile.mdateofissue] as String,
      mdateofrequest:map[TablesColumnFile.mdateofrequest] as String,
      miscustomercreated:map[TablesColumnFile.miscustomercreated] as String,
      mpreparedfor:map[TablesColumnFile.mpreparedfor] as String,
      mreportid:map[TablesColumnFile.mreportid] as String,

      mothrmficnt:			map[TablesColumnFile.mothrmficnt] as int,
      mloancycle:			  map[TablesColumnFile.mloancycle] as int,
      mothrmficurbal:			  map[TablesColumnFile.mothrmficurbal] as double,
      mothrmfiovrdueamt:			  map[TablesColumnFile.mothrmfiovrdueamt] as double,
      mothrmfidisbamt:			  map[TablesColumnFile.mothrmfidisbamt] as double,
      mtotovrdueaccno:			  map[TablesColumnFile.mtotovrdueaccno] as int,
      mmfitotdisbamt:			  map[TablesColumnFile.mmfitotdisbamt] as double,
      mmfitotcurrentbal:			  map[TablesColumnFile.mmfitotcurrentbal] as double,
      mmfitotovrdueamt:			  map[TablesColumnFile.mmfitotovrdueamt] as double,
      mtotovrdueamt:			  map[TablesColumnFile.mtotovrdueamt] as double,
      mtotcurrentbal:			  map[TablesColumnFile.mtotcurrentbal] as double,
      mtotdisbamt:			  map[TablesColumnFile.mtotdisbamt] as double,
      mexpsramt:			  map[TablesColumnFile.mexpsramt] as double,
        mcbresultblob:map[TablesColumnFile.mcbresultblob] as String,
      /*mprimarycurrentbal:map[TablesColumnFile.mprimarycurrentbal] as String,
      mprimarynoofaccounts:map[TablesColumnFile.mprimarynoofaccounts] as String,
      mprimaryoverdueamount:map[TablesColumnFile.mprimaryoverdueamount] as String,
      mprimarynoofactiveacs:map[TablesColumnFile.mprimarynoofactiveacs] as String,
      mprimarynoofodaccs:map[TablesColumnFile.mprimarynoofodaccs] as String,
      msecondarycurrentbalance:map[TablesColumnFile.msecondarycurrentbalance] as String,
      msecondarynoofaccs:map[TablesColumnFile.msecondarynoofaccs] as String,
      msecondaryoverdueamount:map[TablesColumnFile.msecondaryoverdueamount] as String,
      msecondarynoofactiveaccs:map[TablesColumnFile.msecondarynoofactiveaccs] as String,
      msecondarynoofodacs:map[TablesColumnFile.msecondarynoofodacs] as String,
      msecondarysanctionedamt:map[TablesColumnFile.msecondarysanctionedamt] as String,*/
      mcreateddt:map[TablesColumnFile.mcreateddt]=="null"|| map[TablesColumnFile.mcreateddt]== null ?null:DateTime.parse(map[TablesColumnFile.mcreateddt])	 as DateTime,
      maccounttype:map[TablesColumnFile.maccounttype] as String,
      mcurrentbalance:map[TablesColumnFile.mcurrentbalance] as double,
      mcustbankacnum:map[TablesColumnFile.mcustbankacnum] as String,
      mdatereported:map[TablesColumnFile.mdatereported] as String,
      mdisbursedamount:map[TablesColumnFile.mdisbursedamount] as double,
      mnameofmfi:map[TablesColumnFile.mnameofmfi] as String,
      mnocimagestring :map[/*TablesColumnFile.mnocimagestring*/"mnocimagestring" ] as String,
      moverdueamount:map[TablesColumnFile.moverdueamount] as double,
      mwriteoffamount:map[TablesColumnFile.mwriteoffamount] as double,
      magentusername:map[TablesColumnFile.magentusername] as String,
      maccountNumber: map[TablesColumnFile.maccountNumber] as String,
      mmfiid : map[TablesColumnFile.mmfiid] as String,

    );
  }

}
