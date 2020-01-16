import 'package:eco_mfi/db/TablesColumnFile.dart';

class GuarantorDetailsBean {
  int trefno;
  int mrefno;
  int mloantrefno;
  int mloanmrefno;
  String mleadsid;
  String mprdacctid;
  int	msrno ;
  int	mapplicanttype ;
  String	mexistingcustyn ;
  int	mcustno ;
  String	mnameofguar ;
    String	mgender ;
  String	mrelationwithcust ;
  int	mrelationsince ;
  int	mage ;
  String	mphone ;
  String	mmobile ;
  String	maddress ;
  double	mmonthlyincome ;
  DateTime mdob ;
  int	moccupationtype ;
  int	mmainoccupation ;
  int	mworkexpinyrs ;
  double	mincomeothsources ;
  double	mtotalincome ;
  int	mhousetype ;
  String	mworkingaddress ;
  String	mworkphoneno ;
  String	mmothermaidenname ;
  String	mpromissorynote ;
  int	mnationalidtype ;
  int	mnationalid ;
  String	mnationaliddesc ;
  String	maddress2 ;
  String	maddress3 ;
  String	maddress4 ;
  int	mmaritalstatus ;
  int	mreligioncd ;
  String	meducationalqual ;
  String	memailaddr ;
  String	memployername ;
  String	mbusinessname ;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  DateTime mlastsynsdate;
  String merrormessage;

  String mspousename;
  String mstatecd;
  String mtownship;
  int mvillage;
  String mwardno;
  int mbuspropownership;
  int mbusownership;
  double mbustoaassetval;
  String mbusleninyears;
  double mbusmonexpense;
  double mbusmonhlynetprof;
  String msamevillageorward;
  String mfacecapture;
  String mnrcphoto;
  String mnrcsecphoto;
  String mhouseholdphoto;
  String mhouseholdsecphoto;
  String maddressphoto;
  String msignature;
  int missynctocoresys;
  String mstatecddesc;
  String mtownshipdesc;
  String mvillagedesc;
  String mwardnodesc;


  GuarantorDetailsBean({this.trefno, this.mrefno, this.mloantrefno,
      this.mloanmrefno, this.mleadsid, this.mprdacctid, this.msrno,
      this.mapplicanttype, this.mexistingcustyn, this.mcustno, this.mnameofguar,
      this.mgender, this.mrelationwithcust, this.mrelationsince, this.mage,
      this.mphone, this.mmobile, this.maddress, this.mmonthlyincome, this.mdob,
      this.moccupationtype, this.mmainoccupation, this.mworkexpinyrs,
      this.mincomeothsources, this.mtotalincome, this.mhousetype,
      this.mworkingaddress, this.mworkphoneno, this.mmothermaidenname,
      this.mpromissorynote, this.mnationalidtype, this.mnationalid,
      this.mnationaliddesc, this.maddress2, this.maddress3, this.maddress4,
      this.mmaritalstatus, this.mreligioncd, this.meducationalqual,
      this.memailaddr, this.memployername, this.mbusinessname, this.mcreateddt,
      this.mcreatedby, this.mlastupdatedt, this.mlastupdateby,
      this.mgeolocation, this.mgeolatd, this.mgeologd, this.mlastsynsdate,
      this.merrormessage, this.mspousename, this.mstatecd, this.mtownship,
      this.mvillage, this.mwardno, this.mbuspropownership, this.mbusownership,
      this.mbustoaassetval, this.mbusleninyears, this.mbusmonexpense,
      this.mbusmonhlynetprof, this.msamevillageorward, this.mfacecapture,
      this.mnrcphoto, this.mnrcsecphoto, this.mhouseholdphoto,
      this.mhouseholdsecphoto, this.maddressphoto, this.msignature,
      this.missynctocoresys, this.mstatecddesc, this.mtownshipdesc,
      this.mvillagedesc, this.mwardnodesc});


  @override
  String toString() {
    return 'GuarantorDetailsBean{trefno: $trefno, mrefno: $mrefno, mloantrefno: $mloantrefno, mloanmrefno: $mloanmrefno, mleadsid: $mleadsid, mprdacctid: $mprdacctid, msrno: $msrno, mapplicanttype: $mapplicanttype, mexistingcustyn: $mexistingcustyn, mcustno: $mcustno, mnameofguar: $mnameofguar, mgender: $mgender, mrelationwithcust: $mrelationwithcust, mrelationsince: $mrelationsince, mage: $mage, mphone: $mphone, mmobile: $mmobile, maddress: $maddress, mmonthlyincome: $mmonthlyincome, mdob: $mdob, moccupationtype: $moccupationtype, mmainoccupation: $mmainoccupation, mworkexpinyrs: $mworkexpinyrs, mincomeothsources: $mincomeothsources, mtotalincome: $mtotalincome, mhousetype: $mhousetype, mworkingaddress: $mworkingaddress, mworkphoneno: $mworkphoneno, mmothermaidenname: $mmothermaidenname, mpromissorynote: $mpromissorynote, mnationalidtype: $mnationalidtype, mnationalid: $mnationalid, mnationaliddesc: $mnationaliddesc, maddress2: $maddress2, maddress3: $maddress3, maddress4: $maddress4, mmaritalstatus: $mmaritalstatus, mreligioncd: $mreligioncd, meducationalqual: $meducationalqual, memailaddr: $memailaddr, memployername: $memployername, mbusinessname: $mbusinessname, mcreateddt: $mcreateddt, mcreatedby: $mcreatedby, mlastupdatedt: $mlastupdatedt, mlastupdateby: $mlastupdateby, mgeolocation: $mgeolocation, mgeolatd: $mgeolatd, mgeologd: $mgeologd, mlastsynsdate: $mlastsynsdate, merrormessage: $merrormessage, mspousename: $mspousename, mstatecd: $mstatecd, mtownship: $mtownship, mvillage: $mvillage, mwardno: $mwardno, mbuspropownership: $mbuspropownership, mbusownership: $mbusownership, mbustoaassetval: $mbustoaassetval, mbusleninyears: $mbusleninyears, mbusmonexpense: $mbusmonexpense, mbusmonhlynetprof: $mbusmonhlynetprof, msamevillageorward: $msamevillageorward, mfacecapture: $mfacecapture, mnrcphoto: $mnrcphoto, mnrcsecphoto: $mnrcsecphoto, mhouseholdphoto: $mhouseholdphoto, mhouseholdsecphoto: $mhouseholdsecphoto, maddressphoto: $maddressphoto, msignature: $msignature, missynctocoresys: $missynctocoresys, mstatecddesc: $mstatecddesc, mtownshipdesc: $mtownshipdesc, mvillagedesc: $mvillagedesc, mwardnodesc: $mwardnodesc}';
  }

  factory GuarantorDetailsBean.fromMap(Map<String, dynamic> map) {
    print("inside for map");
    return GuarantorDetailsBean(
      trefno:	map[TablesColumnFile.trefno] as int,
      mrefno:	map[TablesColumnFile.mrefno] as int,
      mloanmrefno:	map[TablesColumnFile.mloanmrefno] as int,
      mloantrefno:	map[TablesColumnFile.mloantrefno] as int,
      mleadsid:	map[TablesColumnFile.mleadsid] as String,
      mprdacctid:	map[TablesColumnFile.mprdacctid] as String,
      msrno:	map[TablesColumnFile.msrno] as int,
      mapplicanttype:	map[TablesColumnFile.mapplicanttype] as int,
      mexistingcustyn:	map[TablesColumnFile.mexistingcustyn] as String,
      mcustno:	map[TablesColumnFile.mcustno] as int,
      mnameofguar:	map[TablesColumnFile.mnameofguar] as String,
      mgender:	map[TablesColumnFile.mgender] as String,
      mrelationwithcust:	map[TablesColumnFile.mrelationwithcust] as String,
      mrelationsince:	map[TablesColumnFile.mrelationsince] as int,
      mage:	map[TablesColumnFile.mage] as int,
      mphone:	map[TablesColumnFile.mphone] as String,
      mmobile:	map[TablesColumnFile.mmobile] as String,
      maddress:	map[TablesColumnFile.maddress] as String,
      mmonthlyincome:	map[TablesColumnFile.mmonthlyincome] as double,
      mdob:	(map[TablesColumnFile.mdob]=="null"||map[TablesColumnFile.mdob]==null)?null:DateTime.parse(map[TablesColumnFile.mdob]) as DateTime,
      moccupationtype:	map[TablesColumnFile.moccupationtype] as int,
      mmainoccupation:	map[TablesColumnFile.mmainoccupation] as int,
      mworkexpinyrs:	map[TablesColumnFile.mworkexpinyrs] as int,
      mincomeothsources:	map[TablesColumnFile.mincomeothsources] as double,
      mtotalincome:	map[TablesColumnFile.mtotalincome] as double,
      mhousetype:	map[TablesColumnFile.mhousetype] as int,
      mworkingaddress:	map[TablesColumnFile.mworkingaddress] as String,
      mworkphoneno:	map[TablesColumnFile.mworkphoneno] as String,
      mmothermaidenname:	map[TablesColumnFile.mmothermaidenname] as String,
      mpromissorynote:	map[TablesColumnFile.mpromissorynote] as String,
      mnationalidtype:	map[TablesColumnFile.mnationalidtype] as int,
      mnationalid:	map[TablesColumnFile.mnationalid] as int,
      mnationaliddesc:	map[TablesColumnFile.mnationaliddesc] as String,
      maddress2:	map[TablesColumnFile.maddress2] as String,
      maddress3:	map[TablesColumnFile.maddress3] as String,
      maddress4:	map[TablesColumnFile.maddress4] as String,
      mmaritalstatus:	map[TablesColumnFile.mmaritalstatus] as int,
      mreligioncd:	map[TablesColumnFile.mreligioncd] as int,
      meducationalqual:	map[TablesColumnFile.meducationalqual] as String,
      memailaddr:	map[TablesColumnFile.memailaddr] as String,
      memployername:	map[TablesColumnFile.memployername] as String,
      mbusinessname:	map[TablesColumnFile.mbusinessname] as String,
      mcreateddt:	(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation:map[TablesColumnFile.mgeolocation] as String,
      mgeolatd:map[TablesColumnFile.mgeolatd] as String,
      mgeologd:map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      mspousename        : map[TablesColumnFile.mspousename] as  String,
      mstatecd           : map[TablesColumnFile.mstatecd] as  String,
      mtownship          : map[TablesColumnFile.mtownship] as  String,
      mvillage           : map[TablesColumnFile.mvillage] as  int,
      mwardno            : map[TablesColumnFile.mwardno] as  String,
      mbuspropownership  : map[TablesColumnFile.mbuspropownership] as  int,
      mbusownership      : map[TablesColumnFile.mbusownership] as  int,
      mbustoaassetval    : map[TablesColumnFile.mbustoaassetval] as  double,
      mbusleninyears     : map[TablesColumnFile.mbusleninyears] as  String,
      mbusmonexpense     : map[TablesColumnFile.mbusmonexpense] as  double,
      mbusmonhlynetprof  : map[TablesColumnFile.mbusmonhlynetprof] as  double,
      msamevillageorward : map[TablesColumnFile.msamevillageorward] as  String,
      mfacecapture       : map[TablesColumnFile.mfacecapture] as  String,
      mnrcphoto          : map[TablesColumnFile.mnrcphoto] as  String,
      mnrcsecphoto       : map[TablesColumnFile.mnrcsecphoto] as  String,
      mhouseholdphoto    : map[TablesColumnFile.mhouseholdphoto] as  String,
      mhouseholdsecphoto : map[TablesColumnFile.mhouseholdsecphoto] as  String,
      maddressphoto      : map[TablesColumnFile.maddressphoto] as  String,
      msignature         : map[TablesColumnFile.msignature] as  String,
      missynctocoresys   : map[TablesColumnFile.missynctocoresys] as int,
      mstatecddesc       : map[TablesColumnFile.mstatecddesc] as  String,
      mtownshipdesc      : map[TablesColumnFile.mtownshipdesc] as  String,
      mvillagedesc       : map[TablesColumnFile.mvillagedesc] as  String,
      mwardnodesc        : map[TablesColumnFile.mwardnodesc] as  String,

    );

  }
  factory GuarantorDetailsBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap");
    return GuarantorDetailsBean(
      trefno:	map[TablesColumnFile.trefno] as int,
      mrefno:	map[TablesColumnFile.mrefno] as int,
      mloanmrefno:	map[TablesColumnFile.mloanmrefno] as int,
      mloantrefno:	map[TablesColumnFile.mloantrefno] as int,
      mleadsid:	map[TablesColumnFile.mleadsid] as String,
      mprdacctid:	map[TablesColumnFile.mprdacctid] as String,
      msrno:	map[TablesColumnFile.msrno] as int,
      mapplicanttype:	map[TablesColumnFile.mapplicanttype] as int,
      mexistingcustyn:	map[TablesColumnFile.mexistingcustyn] as String,
      mcustno:	map[TablesColumnFile.mcustno] as int,
      mnameofguar:	map[TablesColumnFile.mnameofguar] as String,
      mgender:	map[TablesColumnFile.mgender] as String,
      mrelationwithcust:	map[TablesColumnFile.mrelationwithcust] as String,
      mrelationsince:	map[TablesColumnFile.mrelationsince] as int,
      mage:	map[TablesColumnFile.mage] as int,
      mphone:	map[TablesColumnFile.mphone] as String,
      mmobile:	map[TablesColumnFile.mmobile] as String,
      maddress:	map[TablesColumnFile.maddress] as String,
      mmonthlyincome:	map[TablesColumnFile.mmonthlyincome] as double,
      mdob:	(map[TablesColumnFile.mdob]=="null"||map[TablesColumnFile.mdob]==null)?null:DateTime.parse(map[TablesColumnFile.mdob]) as DateTime,
      moccupationtype:	map[TablesColumnFile.moccupationtype] as int,
      mmainoccupation:	map[TablesColumnFile.mmainoccupation] as int,
      mworkexpinyrs:	map[TablesColumnFile.mworkexpinyrs] as int,
      mincomeothsources:	map[TablesColumnFile.mincomeothsources] as double,
      mtotalincome:	map[TablesColumnFile.mtotalincome] as double,
      mhousetype:	map[TablesColumnFile.mhousetype] as int,
      mworkingaddress:	map[TablesColumnFile.mworkingaddress] as String,
      mworkphoneno:	map[TablesColumnFile.mworkphoneno] as String,
      mmothermaidenname:	map[TablesColumnFile.mmothermaidenname] as String,
      mpromissorynote:	map[TablesColumnFile.mpromissorynote] as String,
      mnationalidtype:	map[TablesColumnFile.mnationalidtype] as int,
      mnationalid:	map[TablesColumnFile.mnationalid] as int,
      mnationaliddesc:	map[TablesColumnFile.mnationaliddesc] as String,
      maddress2:	map[TablesColumnFile.maddress2] as String,
      maddress3:	map[TablesColumnFile.maddress3] as String,
      maddress4:	map[TablesColumnFile.maddress4] as String,
      mmaritalstatus:	map[TablesColumnFile.mmaritalstatus] as int,
      mreligioncd:	map[TablesColumnFile.mreligioncd] as int,
      meducationalqual:	map[TablesColumnFile.meducationalqual] as String,
      memailaddr:	map[TablesColumnFile.memailaddr] as String,
      memployername:	map[TablesColumnFile.memployername] as String,
      mbusinessname:	map[TablesColumnFile.mbusinessname] as String,
      mcreateddt:	(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation:map[TablesColumnFile.mgeolocation] as String,
      mgeolatd:map[TablesColumnFile.mgeolatd] as String,
      mgeologd:map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      merrormessage:map[TablesColumnFile.merrormessage] as String,
      mspousename        : map[TablesColumnFile.mspousename] as  String,
      mstatecd           : map[TablesColumnFile.mstatecd] as  String,
      mtownship          : map[TablesColumnFile.mtownship] as  String,
      mvillage           : map[TablesColumnFile.mvillage] as  int,
      mwardno            : map[TablesColumnFile.mwardno] as  String,
      mbuspropownership  : map[TablesColumnFile.mbuspropownership] as  int,
      mbusownership      : map[TablesColumnFile.mbusownership] as  int,
      mbustoaassetval    : map[TablesColumnFile.mbustoaassetval] as  double,
      mbusleninyears     : map[TablesColumnFile.mbusleninyears] as  String,
      mbusmonexpense     : map[TablesColumnFile.mbusmonexpense] as  double,
      mbusmonhlynetprof  : map[TablesColumnFile.mbusmonhlynetprof] as  double,
      msamevillageorward : map[TablesColumnFile.msamevillageorward] as  String,
      mfacecapture       : map[TablesColumnFile.mfacecapture] as  String,
      mnrcphoto          : map[TablesColumnFile.mnrcphoto] as  String,
      mnrcsecphoto       : map[TablesColumnFile.mnrcsecphoto] as  String,
      mhouseholdphoto    : map[TablesColumnFile.mhouseholdphoto] as  String,
      mhouseholdsecphoto : map[TablesColumnFile.mhouseholdsecphoto] as  String,
      maddressphoto      : map[TablesColumnFile.maddressphoto] as  String,
      msignature         : map[TablesColumnFile.msignature] as  String,
      missynctocoresys   : map[TablesColumnFile.missynctocoresys] as int,
      mstatecddesc       : map[TablesColumnFile.mstatecddesc] as  String,
      mtownshipdesc      : map[TablesColumnFile.mtownshipdesc] as  String,
      mvillagedesc       : map[TablesColumnFile.mvillagedesc] as  String,
      mwardnodesc        : map[TablesColumnFile.mwardnodesc] as  String,
    );
  }

}

