import 'package:eco_mfi/db/TablesColumnFile.dart';
class   SavingsListBean {
  int trefno;
  int mrefno;
  int msvngacctrefno;
  int msvngaccmrefno;
  int mlbrcode;
  int mcusttrefno;
  int mcustmrefno;
  String mprdacctid;
  String mlongname;
  String mmobno;
  String mprdcd;
  String mcurcd;
  DateTime mdateopen;
  DateTime mdateclosed;
  int mfreezetype;
  int macctstat;
  int mcustno;
  double macttotbalfcy;
  double mtotallienfcy;
  int mmoduletype;
  int mcenterid;
  int mgroupcd;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  DateTime mlastsynsdate;
  String mcrs;
  DateTime mcollectiondate;
  double mcollectedamount;
  String mremark;
  String mcashflow;
  DateTime mentrydate;
  String mbatchcd;
  String merrormessage;
  int msetno;
  int mscrollno;

  SavingsListBean(
      {
        this.trefno,
        this.mrefno,
        this.msvngacctrefno,
        this.msvngaccmrefno,
        this.mlbrcode,
        this.mcusttrefno,
        this.mcustmrefno,
        this.mprdacctid,
        this.mlongname,
        this.mmobno,
        this.mprdcd,
        this.mcurcd,
        this.mdateopen,
        this.mdateclosed,
        this.mfreezetype,
        this.macctstat,
        this.mcustno,
        this.macttotbalfcy,
        this.mtotallienfcy,
        this.mmoduletype,
        this.mcenterid,
        this.mgroupcd,
        this.mcreateddt,
        this.mcreatedby,
        this.mlastupdatedt,
        this.mlastupdateby,
        this.mgeolocation,
        this.mgeolatd,
        this.mgeologd,
        this.mlastsynsdate,
        this.mcrs,
        this.mcollectiondate,
        this.mcollectedamount,
        this.mremark,
        this.mcashflow,
        this.mentrydate,
        this.mbatchcd,
        this.merrormessage,
        this.msetno,
        this.mscrollno,

      });


  @override
  String toString() {
    return 'SavingsListBean{trefno: $trefno, mrefno: $mrefno, msvngacctrefno: $msvngacctrefno, msvngaccmrefno: $msvngaccmrefno, mlbrcode: $mlbrcode, mcusttrefno: $mcusttrefno, mcustmrefno: $mcustmrefno, mprdacctid: $mprdacctid, mlongname: $mlongname, mmobno: $mmobno, mprdcd: $mprdcd, mcurcd: $mcurcd, mdateopen: $mdateopen, mdateclosed: $mdateclosed, mfreezetype: $mfreezetype, macctstat: $macctstat, mcustno: $mcustno, macttotbalfcy: $macttotbalfcy, mtotallienfcy: $mtotallienfcy, mmoduletype: $mmoduletype, mcenterid: $mcenterid, mgroupcd: $mgroupcd, mcreateddt: $mcreateddt, mcreatedby: $mcreatedby, mlastupdatedt: $mlastupdatedt, mlastupdateby: $mlastupdateby, mgeolocation: $mgeolocation, mgeolatd: $mgeolatd, mgeologd: $mgeologd, mlastsynsdate: $mlastsynsdate, mcrs: $mcrs, mcollectiondate: $mcollectiondate, mcollectedamount: $mcollectedamount, mremark: $mremark, mcashflow: $mcashflow, mbatchcd: $mbatchcd, merrormessage: $merrormessage, msetno: $msetno, mscrollno: $mscrollno}';
  }

  factory SavingsListBean.fromMap(Map<String, dynamic> map) {
    print(map);
    return SavingsListBean(
      trefno:map[TablesColumnFile.trefno] as int,
      mrefno:map[TablesColumnFile.mrefno] as int,
      msvngacctrefno:map[TablesColumnFile.msvngacctrefno] as int,
      msvngaccmrefno:map[TablesColumnFile.msvngaccmrefno] as int,
      mlbrcode:map[TablesColumnFile.mlbrcode] as int,
      mcusttrefno:map[TablesColumnFile.mcusttrefno] as int,
      mcustmrefno:map[TablesColumnFile.mcustmrefno] as int,
      mprdacctid:map[TablesColumnFile.mprdacctid] as String,
      mlongname:map[TablesColumnFile.mlongname] as String,
      mmobno:map[TablesColumnFile.mmobno] as String,
      mprdcd:map[TablesColumnFile.mprdcd] as String,
      mcurcd:map[TablesColumnFile.mcurcd] as String,
      mdateopen:(map[TablesColumnFile.mdateopen]=="null"||map[TablesColumnFile.mdateopen]==null)?null:DateTime.parse(map[TablesColumnFile.mdateopen]) as DateTime,
      mdateclosed:(map[TablesColumnFile.mdateclosed]=="null"||map[TablesColumnFile.mdateclosed]==null)?null:DateTime.parse(map[TablesColumnFile.mdateclosed]) as DateTime,
      mfreezetype:map[TablesColumnFile.mfreezetype] as int,
      macctstat:map[TablesColumnFile.macctstat] as int,
      mcustno:map[TablesColumnFile.mcustno] as int,
      macttotbalfcy:map[TablesColumnFile.mactTotbalfcy] as double,
      mtotallienfcy:map[TablesColumnFile.mtotallienfcy] as double,
      mmoduletype:map[TablesColumnFile.mmoduletype] as int,
      mcenterid:map[TablesColumnFile.mcenterid] as int,
      mgroupcd:map[TablesColumnFile.mgroupcd] as int,
      mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation:map[TablesColumnFile.mgeolocation] as String,
      mgeolatd:map[TablesColumnFile.mgeolatd] as String,
      mgeologd:map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      mcrs:map[TablesColumnFile.mcrs] as String,
      mcollectiondate:(map[TablesColumnFile.mcollectiondate]=="null"||map[TablesColumnFile.mcollectiondate]==null)?null:DateTime.parse(map[TablesColumnFile.mcollectiondate]) as DateTime,
      mcollectedamount:	map[TablesColumnFile.mcollectedamount] as double,
      mremark:map[TablesColumnFile.mremark] as String,
      mcashflow:map[TablesColumnFile.mcashflow] as String,
      mentrydate:map[TablesColumnFile.mentrydate]=="null" || map[TablesColumnFile.mentrydate]==null?null:DateTime.parse(map[TablesColumnFile.mentrydate]) as DateTime,
      mbatchcd:map[TablesColumnFile.mbatchcd] as String,
      merrormessage:map[TablesColumnFile.merrormessage] as String,
      msetno:map[TablesColumnFile.msetno] as int,
      mscrollno:map[TablesColumnFile.mscrollno] as int,



    );
  }
  factory SavingsListBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware){
    print("fromMap");
    return SavingsListBean(
      trefno:map[TablesColumnFile.trefno] as int,
      mrefno:map[TablesColumnFile.mrefno] as int,
      mlbrcode:map[TablesColumnFile.mlbrcode] as int,
      mcusttrefno:map[TablesColumnFile.mcusttrefno] as int,
      mcustmrefno:map[TablesColumnFile.mcustmrefno] as int,
      mprdacctid:map[TablesColumnFile.mprdacctid] as String,
      mlongname:map[TablesColumnFile.mlongname] as String,
      mmobno:map[TablesColumnFile.mmobno] as String,
      mprdcd:map[TablesColumnFile.mprdcd] as String,
      mcurcd:map[TablesColumnFile.mcurcd] as String,
      mdateopen:(map[TablesColumnFile.mdateopen]=="null"||map[TablesColumnFile.mdateopen]==null)?null:DateTime.parse(map[TablesColumnFile.mdateopen]) as DateTime,
      mdateclosed:(map[TablesColumnFile.mdateclosed]=="null"||map[TablesColumnFile.mdateclosed]==null)?null:DateTime.parse(map[TablesColumnFile.mdateclosed]) as DateTime,
      mfreezetype:map[TablesColumnFile.mfreezetype] as int,
      macctstat:map[TablesColumnFile.macctstat] as int,
      mcustno:map[TablesColumnFile.mcustno] as int,
      macttotbalfcy:map[TablesColumnFile.mactTotbalfcy] as double,
      mtotallienfcy:map[TablesColumnFile.mtotallienfcy] as double,
      mmoduletype:map[TablesColumnFile.mmoduletype] as int,
      mcenterid:map[TablesColumnFile.mcenterid] as int,
      mgroupcd:map[TablesColumnFile.mgroupcd] as int,
      mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation:map[TablesColumnFile.mgeolocation] as String,
      mgeolatd:map[TablesColumnFile.mgeolatd] as String,
      mgeologd:map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      mcrs:map[TablesColumnFile.mcrs] as String,
      mcollectiondate:(map[TablesColumnFile.mcollectiondate]=="null"||map[TablesColumnFile.mcollectiondate]==null)?null:DateTime.parse(map[TablesColumnFile.mcollectiondate]) as DateTime,
      mcollectedamount:	map[TablesColumnFile.mcollectedamount] as double,
      mremark:    	map[TablesColumnFile.mremark] as String,
      mcashflow:map[TablesColumnFile.mcashflow] as String,
      mentrydate:(map[TablesColumnFile.mentrydate]=="null"||map[TablesColumnFile.mentrydate]==null)?null:DateTime.parse(map[TablesColumnFile.mentrydate]) as DateTime,
      mbatchcd:map[TablesColumnFile.mbatchcd] as String,
      merrormessage:map[TablesColumnFile.merrormessage] as String,
      msetno:map[TablesColumnFile.msetno] as int,
      mscrollno:map[TablesColumnFile.mscrollno] as int,

    );}

}