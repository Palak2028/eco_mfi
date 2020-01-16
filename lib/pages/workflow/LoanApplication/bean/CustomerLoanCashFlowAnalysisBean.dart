import 'package:eco_mfi/db/TablesColumnFile.dart';

class CustomerLoanCashFlowAnalysisBean{


  int mrefno;
  int trefno;
  String mleadsid;
  double mfimainbsinc;
  double mfisubbusinc;
  double mfirentalinc;
  double mfiotherinc;
  double mfitotalInc;
  double mbepurequipments;
  double mbepetrolcost;
  double mbewages;
  double mberent;
  double mbeeemi;
  double mbetotalbusexp;
  double mfefoodexp;
  double mfemobileexp;
  double mfemedicalexp;
  double mfeschoolfees;
  double mfecollegefees;
  double mfemiscellaneous;
  double mfeelectricity;
  double mfesocialcharity;
  double mfetotalfaminc;
  double mfetotalexp;
  double msurpluscash;
  double mdbr;

  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  int missynctocoresys;
  DateTime mlastsynsdate;

  int mloanmrefno;
  int mloantrefno;
  int mcustmrefno;
  int mcusttrefno;





  CustomerLoanCashFlowAnalysisBean({this.mrefno,this.trefno,this.mleadsid, this.mfimainbsinc,
      this.mfisubbusinc, this.mfirentalinc, this.mfiotherinc, this.mfitotalInc,
      this.mbepurequipments, this.mbepetrolcost, this.mbewages, this.mberent,
      this.mbeeemi, this.mbetotalbusexp, this.mfefoodexp, this.mfemobileexp,
      this.mfemedicalexp, this.mfeschoolfees, this.mfecollegefees,
      this.mfemiscellaneous, this.mfeelectricity, this.mfesocialcharity,
      this.mfetotalfaminc, this.mfetotalexp, this.msurpluscash, this.mdbr,
      this.mcreateddt, this.mcreatedby, this.mlastupdatedt, this.mlastupdateby,
      this.mgeolocation, this.mgeolatd, this.mgeologd, this.missynctocoresys,
      this.mlastsynsdate, this.mloanmrefno, this.mloantrefno, this.mcustmrefno,
      this.mcusttrefno});


  @override
  String toString() {
    return 'CustomerLoanCashFlowAnalysisBean{mrefno: $mrefno, trefno: $trefno, mleadsid: $mleadsid, mfimainbsinc: $mfimainbsinc, mfisubbusinc: $mfisubbusinc, mfirentalinc: $mfirentalinc, mfiotherinc: $mfiotherinc, mfitotalInc: $mfitotalInc, mbepurequipments: $mbepurequipments, mbepetrolcost: $mbepetrolcost, mbewages: $mbewages, mberent: $mberent, mbeeemi: $mbeeemi, mbetotalbusexp: $mbetotalbusexp, mfefoodexp: $mfefoodexp, mfemobileexp: $mfemobileexp, mfemedicalexp: $mfemedicalexp, mfeschoolfees: $mfeschoolfees, mfecollegefees: $mfecollegefees, mfemiscellaneous: $mfemiscellaneous, mfeelectricity: $mfeelectricity, mfesocialcharity: $mfesocialcharity, mfetotalfaminc: $mfetotalfaminc, mfetotalexp: $mfetotalexp, msurpluscash: $msurpluscash, mdbr: $mdbr, mcreateddt: $mcreateddt, mcreatedby: $mcreatedby, mlastupdatedt: $mlastupdatedt, mlastupdateby: $mlastupdateby, mgeolocation: $mgeolocation, mgeolatd: $mgeolatd, mgeologd: $mgeologd, missynctocoresys: $missynctocoresys, mlastsynsdate: $mlastsynsdate, mloanmrefno: $mloanmrefno, mloantrefno: $mloantrefno, mcustmrefno: $mcustmrefno, mcusttrefno: $mcusttrefno}';
  }

  factory CustomerLoanCashFlowAnalysisBean.fromMap(Map<String, dynamic> map) {
    return CustomerLoanCashFlowAnalysisBean(

      mrefno:	  map[TablesColumnFile.mrefno] as int,
      trefno:	  map[TablesColumnFile.trefno] as int,
      mleadsid:	  map[TablesColumnFile.mleadsid] as String,
      mfimainbsinc:	  map[TablesColumnFile.mfimainbsinc] as double,
      mfisubbusinc:	  map[TablesColumnFile.mfisubbusinc] as double,
      mfirentalinc:	  map[TablesColumnFile.mfirentalinc] as double,
      mfiotherinc:	  map[TablesColumnFile.mfiotherinc] as double,
      mfitotalInc:	  map[TablesColumnFile.mfitotalInc] as double,
      mbepurequipments:	  map[TablesColumnFile.mbepurequipments] as double,
      mbepetrolcost:	  map[TablesColumnFile.mbepetrolcost] as double,
      mbewages:	  map[TablesColumnFile.mbewages] as double,
      mberent:	  map[TablesColumnFile.mberent] as double,
      mbeeemi:	  map[TablesColumnFile.mbeeemi] as double,
      mbetotalbusexp:	  map[TablesColumnFile.mbetotalbusexp] as double,
      mfefoodexp:	  map[TablesColumnFile.mfefoodexp] as double,
      mfemobileexp:	  map[TablesColumnFile.mfemobileexp] as double,
      mfemedicalexp:	  map[TablesColumnFile.mfemedicalexp] as double,
      mfeschoolfees:	  map[TablesColumnFile.mfeschoolfees] as double,
      mfecollegefees:	  map[TablesColumnFile.mfecollegefees] as double,
      mfemiscellaneous:	  map[TablesColumnFile.mfemiscellaneous] as double,
      mfeelectricity:	  map[TablesColumnFile.mfeelectricity] as double,
      mfesocialcharity:	  map[TablesColumnFile.mfesocialcharity] as double,
      mfetotalfaminc:	  map[TablesColumnFile.mfetotalfaminc] as double,
      mfetotalexp:	  map[TablesColumnFile.mfetotalexp] as double,
      msurpluscash:	  map[TablesColumnFile.msurpluscash] as double,
      mdbr:	  map[TablesColumnFile.mdbr] as double,

      mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null) ? null : DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,

      mcreatedby : map[TablesColumnFile.mcreatedby] as String,

      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,

      mlastupdateby : map[TablesColumnFile.mlastupdateby] as String,

      mgeolocation : map[TablesColumnFile.mgeolocation] as String,

      mgeolatd : map[TablesColumnFile.mgeolatd] as String,

      mgeologd : map[TablesColumnFile.mgeologd] as String,

      missynctocoresys : map[TablesColumnFile.missynctocoresys] as int,

      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]),


      mloanmrefno:	  map[TablesColumnFile.mloanmrefno] as int,
      mloantrefno:	  map[TablesColumnFile.mloantrefno] as int,
      mcustmrefno:	  map[TablesColumnFile.mcustmrefno] as int,
      mcusttrefno:	  map[TablesColumnFile.mcusttrefno] as int,



    );
  }










}