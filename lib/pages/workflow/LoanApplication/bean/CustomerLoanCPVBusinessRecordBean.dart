import 'package:eco_mfi/db/TablesColumnFile.dart';

class CustomerLoanCPVBusinessRecordBean {
  String mleadsid;
  String mhblocated;
  String mbusinessname;
  String mbusinessaddress;
  String maddresschanged;
  String mbusinesslicense;
  DateTime mstartedym;
  int mpropertystatus;
  int mshopcondition;
  String mbuslocation;
  String mpremisesphoto;
  String mnoofcustomers;
  int mcuslocation;
  int mcusdealing;
  String mcreditsales;
  String mperiodsale;
  int mapplicantsrole;
  String mbuspartner;
  int mkeyperson;
  int mcusbehaviour;
  String mtransrecord;
  int mrecpurandsal;
  int mbooksupdated;
  int mivlandrecord;
  int mivsalesregister;
  int mivcreditregister;
  int mivinventoryregister;
  int mivsalaryslip;
  int mivpassbook;
  int mbuscategories;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  int missynctocoresys;
  DateTime mlastsynsdate;
  int trefno;
  int mrefno;
  int mloantrefno;
  int mloanmrefno;
  int mleadstatus;
  int mcustmrefno;
  int mcusttrefno;
  String mpremisesphotosec;
  String mpremisesphotothird;

  CustomerLoanCPVBusinessRecordBean({this.mleadsid, this.mhblocated,
    this.mbusinessname, this.mbusinessaddress, this.maddresschanged,
    this.mbusinesslicense, this.mstartedym, this.mpropertystatus,
    this.mshopcondition, this.mbuslocation, this.mpremisesphoto,
    this.mnoofcustomers, this.mcuslocation, this.mcusdealing,
    this.mcreditsales, this.mperiodsale, this.mapplicantsrole,
    this.mbuspartner, this.mkeyperson, this.mcusbehaviour, this.mtransrecord,
    this.mrecpurandsal, this.mbooksupdated, this.mivlandrecord,
    this.mivsalesregister, this.mivcreditregister, this.mivinventoryregister,
    this.mivsalaryslip, this.mivpassbook, this.mbuscategories,
    this.mcreateddt, this.mcreatedby, this.mlastupdatedt, this.mlastupdateby,
    this.mgeolocation, this.mgeolatd, this.mgeologd, this.missynctocoresys,
    this.mlastsynsdate, this.trefno, this.mrefno, this.mloantrefno,
    this.mloanmrefno, this.mleadstatus,this.mcustmrefno, this.mcusttrefno,
    this.mpremisesphotosec,this.mpremisesphotothird});

  factory CustomerLoanCPVBusinessRecordBean.fromMap(Map<String, dynamic> map) {
    print(map);
    return CustomerLoanCPVBusinessRecordBean(
      trefno : map[TablesColumnFile.trefno] as int,
      mrefno : map[TablesColumnFile.mrefno] as int,
      mloantrefno : map[TablesColumnFile.mloantrefno] as int,
      mloanmrefno : map[TablesColumnFile.mloanmrefno] as int,
      mleadsid:map[TablesColumnFile.mleadsid] as String,
      mhblocated:map[TablesColumnFile.mhblocated] as String,
      mbusinessname:map[TablesColumnFile.mbusinessname] as String,
      mbusinessaddress:map[TablesColumnFile.mbusinessaddress] as String,
      maddresschanged:map[TablesColumnFile.maddresschanged] as String,
      mbusinesslicense:map[TablesColumnFile.mbusinesslicense] as String,
      mstartedym:(map[TablesColumnFile.mstartedym]=="null"||map[TablesColumnFile.
      mstartedym]==null) ? null : DateTime.parse(
          map[TablesColumnFile.mstartedym]) as DateTime,

      mpropertystatus:map[TablesColumnFile.mpropertystatus] as int,
      mshopcondition:map[TablesColumnFile.mshopcondition] as int,
      mbuslocation:map[TablesColumnFile.mbuslocation] as String,
      mpremisesphoto:map[TablesColumnFile.mpremisesphoto] as String,
      mnoofcustomers:map[TablesColumnFile.mnoofcustomers] as String,
      mcuslocation:map[TablesColumnFile.mcuslocation] as int,
      mcusdealing:map[TablesColumnFile.mcusdealing] as int,
      mcreditsales:map[TablesColumnFile.mcreditsales] as String,
      mperiodsale:map[TablesColumnFile.mperiodsale] as String,
      mapplicantsrole:map[TablesColumnFile.mapplicantsrole] as int,
      mbuspartner:map[TablesColumnFile.mbuspartner] as String,
      mkeyperson:map[TablesColumnFile.mkeyperson] as int,
      mcusbehaviour:map[TablesColumnFile.mcusbehaviour] as int,
      mtransrecord:map[TablesColumnFile.mtransrecord] as String,
      mrecpurandsal:map[TablesColumnFile.mrecpurandsal] as int,
      mbooksupdated:map[TablesColumnFile.mbooksupdated] as int,
      mivlandrecord:map[TablesColumnFile.mivlandrecord] as int,
      mivsalesregister:map[TablesColumnFile.mivsalesregister] as int,
      mivcreditregister:map[TablesColumnFile.mivcreditregister] as int,
      mivinventoryregister:map[TablesColumnFile.mivinventoryregister] as int,
      mivsalaryslip:map[TablesColumnFile.mivsalaryslip] as int,
      mivpassbook:map[TablesColumnFile.mivpassbook] as int,
      mbuscategories:map[TablesColumnFile.mbuscategories] as int,
      mleadstatus :map[TablesColumnFile.mleadstatus] as int,
      mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby : map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby : map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation : map[TablesColumnFile.mgeolocation] as String,
      mgeolatd : map[TablesColumnFile.mgeolatd] as String,
      mgeologd : map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||
          map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      missynctocoresys: map[TablesColumnFile.missynctocoresys] as int,
      mcustmrefno:	  map[TablesColumnFile.mcustmrefno] as int,
      mcusttrefno:	  map[TablesColumnFile.mcusttrefno] as int,
      mpremisesphotosec:map[TablesColumnFile.mpremisesphotosec] as String,
      mpremisesphotothird:map[TablesColumnFile.mpremisesphotothird] as String,
    );
  }

  factory CustomerLoanCPVBusinessRecordBean.fromMapMiddleware(Map<String, dynamic> map){
    print("fromMapMiddleware");
    print("Receiver String is $map");
    return CustomerLoanCPVBusinessRecordBean(
      trefno : map[TablesColumnFile.trefno] as int,
      mrefno : map[TablesColumnFile.mrefno] as int,
      mloantrefno : map[TablesColumnFile.mloantrefno] as int,
      mloanmrefno : map[TablesColumnFile.mloanmrefno] as int,
      mleadsid:map[TablesColumnFile.mleadsid] as String,
      mhblocated:map[TablesColumnFile.mhblocated] as String,
      mbusinessname:map[TablesColumnFile.mbusinessname] as String,
      mbusinessaddress:map[TablesColumnFile.mbusinessaddress] as String,
      maddresschanged:map[TablesColumnFile.maddresschanged] as String,
      mbusinesslicense:map[TablesColumnFile.mbusinesslicense] as String,
      mstartedym:(map[TablesColumnFile.mstartedym]=="null"||map[TablesColumnFile.
      mstartedym]==null) ? null : DateTime.parse(
          map[TablesColumnFile.mstartedym]) as DateTime,

      mpropertystatus:map[TablesColumnFile.mpropertystatus] as int,
      mshopcondition:map[TablesColumnFile.mshopcondition] as int,
      mbuslocation:map[TablesColumnFile.mbuslocation] as String,
      mpremisesphoto:map[TablesColumnFile.mpremisesphoto] as String,
      mnoofcustomers:map[TablesColumnFile.mnoofcustomers] as String,
      mcuslocation:map[TablesColumnFile.mcuslocation] as int,
      mcusdealing:map[TablesColumnFile.mcusdealing] as int,
      mcreditsales:map[TablesColumnFile.mcreditsales] as String,
      mperiodsale:map[TablesColumnFile.mperiodsale] as String,
      mapplicantsrole:map[TablesColumnFile.mapplicantsrole] as int,
      mbuspartner:map[TablesColumnFile.mbuspartner] as String,
      mkeyperson:map[TablesColumnFile.mkeyperson] as int,
      mcusbehaviour:map[TablesColumnFile.mcusbehaviour] as int,
      mtransrecord:map[TablesColumnFile.mtransrecord] as String,
      mrecpurandsal:map[TablesColumnFile.mrecpurandsal] as int,
      mbooksupdated:map[TablesColumnFile.mbooksupdated] as int,
      mivlandrecord:map[TablesColumnFile.mivlandrecord] as int,
      mivsalesregister:map[TablesColumnFile.mivsalesregister] as int,
      mivcreditregister:map[TablesColumnFile.mivcreditregister] as int,
      mivinventoryregister:map[TablesColumnFile.mivinventoryregister] as int,
      mivsalaryslip:map[TablesColumnFile.mivsalaryslip] as int,
      mivpassbook:map[TablesColumnFile.mivpassbook] as int,
      mbuscategories:map[TablesColumnFile.mbuscategories] as int,
      mleadstatus :map[TablesColumnFile.mleadstatus] as int,
      mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby : map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby : map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation : map[TablesColumnFile.mgeolocation] as String,
      mgeolatd : map[TablesColumnFile.mgeolatd] as String,
      mgeologd : map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||
          map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      missynctocoresys: map[TablesColumnFile.missynctocoresys] as int,
      mcustmrefno:	  map[TablesColumnFile.mcustmrefno] as int,
      mcusttrefno:	  map[TablesColumnFile.mcusttrefno] as int,
      mpremisesphotosec:map[TablesColumnFile.mpremisesphotosec] as String,
      mpremisesphotothird:map[TablesColumnFile.mpremisesphotothird] as String,

    );}
}