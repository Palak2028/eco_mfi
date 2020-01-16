import 'package:eco_mfi/db/TablesColumnFile.dart';

class DeviationFormBean {

  String mleadsid;
  String mdevloanapp;
  int mdrnrc;
  int mdrmni;
  int mdrdbr;
  int mdrmfi;
  int mdrbl;
  String mdevapproval;
  int trefno;
  int mrefno;
  int mloantrefno;
  int mloanmrefno;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  DateTime mlastsynsdate;
  int missynctocoresys;
  int mleadstatus;
  int mcustmrefno;
  int mcusttrefno;


  DeviationFormBean({this.mleadsid, this.mdevloanapp, this.mdrnrc, this.mdrmni,
      this.mdrdbr, this.mdrmfi, this.mdrbl, this.mdevapproval, this.trefno,
      this.mrefno, this.mloantrefno, this.mloanmrefno, this.mcreateddt,
      this.mcreatedby, this.mlastupdatedt, this.mlastupdateby,
      this.mgeolocation, this.mgeolatd, this.mgeologd, this.mlastsynsdate,
      this.missynctocoresys, this.mleadstatus,this.mcustmrefno,this.mcusttrefno});


  @override
  String toString() {
    return 'DeviationFormBean{mleadsid: $mleadsid, mdevloanapp: $mdevloanapp, mdrnrc: $mdrnrc, mdrmni: $mdrmni, mdrdbr: $mdrdbr, mdrmfi: $mdrmfi, mdrbl: $mdrbl, mdevapproval: $mdevapproval, trefno: $trefno, mrefno: $mrefno, mloantrefno: $mloantrefno, mloanmrefno: $mloanmrefno, mcreateddt: $mcreateddt, mcreatedby: $mcreatedby, mlastupdatedt: $mlastupdatedt, mlastupdateby: $mlastupdateby, mgeolocation: $mgeolocation, mgeolatd: $mgeolatd, mgeologd: $mgeologd, mlastsynsdate: $mlastsynsdate, missynctocoresys: $missynctocoresys, mleadstatus: $mleadstatus}';
  }

  factory DeviationFormBean.fromMap(Map<String, dynamic> map) {
    print(map);
    return DeviationFormBean(
      trefno : map[TablesColumnFile.trefno] as int,
      mrefno : map[TablesColumnFile.mrefno] as int,
      mloantrefno : map[TablesColumnFile.mloantrefno] as int,
      mloanmrefno : map[TablesColumnFile.mloanmrefno] as int,
      mleadsid:map[TablesColumnFile.mleadsid] as String,
      mdevloanapp: map[TablesColumnFile.mdevloanapp] as String,
      mdrnrc: map[TablesColumnFile.mdrnrc] as int,
      mdrmni: map[TablesColumnFile.mdrmni] as int,
      mdrdbr: map[TablesColumnFile.mdrdbr] as int,
      mdrmfi: map[TablesColumnFile.mdrmfi] as int,
      mdrbl: map[TablesColumnFile.mdrbl] as int,
      mdevapproval: map[TablesColumnFile.mdevapproval] as String,
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
    );
  }

  factory DeviationFormBean.fromMapMiddleware(Map<String, dynamic> map){
    print("fromMapMiddleware");
    print("Receiver String is $map");
    return DeviationFormBean(
        trefno : map[TablesColumnFile.trefno] as int,
        mrefno : map[TablesColumnFile.mrefno] as int,
        mloantrefno : map[TablesColumnFile.mloantrefno] as int,
        mloanmrefno : map[TablesColumnFile.mloanmrefno] as int,
        mleadsid:map[TablesColumnFile.mleadsid] as String,
        mdevloanapp: map[TablesColumnFile.mdevloanapp] as String,
        mdrnrc: map[TablesColumnFile.mdrnrc] as int,
        mdrmni: map[TablesColumnFile.mdrmni] as int,
        mdrdbr: map[TablesColumnFile.mdrdbr] as int,
        mdrmfi: map[TablesColumnFile.mdrmfi] as int,
        mdrbl: map[TablesColumnFile.mdrbl] as int,
        mdevapproval: map[TablesColumnFile.mdevapproval] as String,
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

    );}
}
