import 'package:eco_mfi/db/TablesColumnFile.dart';

class TermDepositClosureBean {

  int mlbrcode;
  String mprdacctid;
  DateTime maccountopenningdt;
  DateTime mmatdt;
  double mmatamt;
  double mintrate;
  double mdepositamt;
  double mmainbal;



  double mmatintamt;


  double mclosintamt;
  DateTime mclosdt;
  double mclosmatamt;
  double mclosintrate;
  double mclostds;






  double mintprovided;
  String merrormessage;
  int mstatus;
  String mcreatedby;
  String mlongname;
  DateTime mbranchoperdt;
  int mcshorsav;
  double mtds;
  List<SavingAccounts> attachedSavAccts;
  String mselectedsavingacc;







  TermDepositClosureBean({this.mlbrcode, this.mprdacctid,
      this.maccountopenningdt, this.mmatdt, this.mmatamt, this.mintrate,
      this.mdepositamt, this.mmainbal, this.mintprovided, this.merrormessage,
      this.mstatus, this.mcreatedby,
      this.mlongname,this.mbranchoperdt,this.mcshorsav,this.mtds,
    this.attachedSavAccts,this.mselectedsavingacc,

    this.mmatintamt,


    this.mclosintamt,
    this.mclosdt,
    this.mclosmatamt,
    this.mclosintrate,
    this.mclostds

  });




  factory TermDepositClosureBean.fromMapMiddleware(Map<String, dynamic> map) {
    return TermDepositClosureBean(
      mlbrcode:  map[TablesColumnFile.mlbrcode] as int,
      mprdacctid:  map[TablesColumnFile.mprdacctid] as String,
      maccountopenningdt: (map[TablesColumnFile.maccountopenningdt]=="null"||map[TablesColumnFile.maccountopenningdt]==null)?null:DateTime.parse(map[TablesColumnFile.maccountopenningdt]) as DateTime,
      mmatdt: (map[TablesColumnFile.mmatdt]=="null"||
          map[TablesColumnFile.mmatdt]==null)?null:DateTime.parse(map[TablesColumnFile.mmatdt]) as DateTime,

      mmatamt:  map[TablesColumnFile.mmatamt] as double,
      mintrate:  map[TablesColumnFile.mintrate] as double,
      mdepositamt:  map[TablesColumnFile.mdepositamt] as double,
      mintprovided:  map[TablesColumnFile.mintprovided] as double,
      merrormessage:  map[TablesColumnFile.merrormessage] as String,
      mstatus:  map[TablesColumnFile.mstatus] as int,
      mcreatedby:  map[TablesColumnFile.mcreatedby] as String,
      mlongname:  map[TablesColumnFile.mlongname] as String,
      mbranchoperdt: (map[TablesColumnFile.mbranchoperdt]=="null"||
          map[TablesColumnFile.mbranchoperdt]==null)?null:DateTime.parse(map[TablesColumnFile.mbranchoperdt]) as DateTime,
        mcshorsav:map[TablesColumnFile.mcshorsav] as int,
      mtds:  map[TablesColumnFile.mtds] as double,
      mselectedsavingacc : map[TablesColumnFile.mselectedsavingacc] as String,


        mmatintamt:  map[TablesColumnFile.mmatintamt] as double,


        mclosintamt:  map[TablesColumnFile.mdepositamt] as double,
        mclosdt:  (map[TablesColumnFile.mclosdt]=="null"||
            map[TablesColumnFile.mclosdt]==null)?null:DateTime.parse(map[TablesColumnFile.mclosdt]) as DateTime,
        mclosmatamt:  map[TablesColumnFile.mclosmatamt] as double,
        mclosintrate:  map[TablesColumnFile.mclosintrate] as double,
        mclostds:  map[TablesColumnFile.mclostds] as double,




    );
  }



}



class SavingAccounts{

  String mlongname;
  String  macctno;
  String mifsc;

  SavingAccounts({this.mlongname, this.macctno, this.mifsc});


}