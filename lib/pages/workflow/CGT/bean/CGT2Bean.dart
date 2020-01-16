import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CheckListCGT2Bean.dart';

class CGT2Bean{
  /*int id;
  String loanNumber;
  String routeTo;
  String routeFrom;
  DateTime startTime;
  DateTime endTime;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  String updatedBy;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;*/

  int trefno;
  int mrefno;
  int loantrefno;
  int loanmrefno;
  String mleadsid;
  String mcgt2doneby;
  DateTime mstarttime;
  DateTime mendtime;
  String mroutefrom;
  String mrouteto;
  String mremark;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  int missynctocoresys;
  DateTime mlastsynsdate;
  String mremarks;
  List<CheckListCGT2Bean> checkListCGT2Bean;

  CGT2Bean({this.trefno, this.mrefno, this.mleadsid, this.mcgt2doneby, this.mstarttime,
    this.mendtime,this.mroutefrom, this.mrouteto, this.mcreateddt,
    this.mcreatedby,this.mlastupdatedt,this.mlastupdateby,this.mgeolocation,
    this.mgeolatd,this.mgeologd,this.missynctocoresys,this.mlastsynsdate,this.mremarks,this.loantrefno,this.loanmrefno,this.checkListCGT2Bean});

/*  @override
  String toString() {
    return 'CheckListBean{id: $id, question: $questionId, questionDesc: $questionDesc, loanId: $loanNumber, remarks: $remarks, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy}';
  }*/

  factory CGT2Bean.fromMap(
      Map<String, dynamic> map) {
    return CGT2Bean(
        trefno: map[TablesColumnFile.trefno] as int,
        mrefno: map[TablesColumnFile.mrefno] as int,
        loanmrefno: map[TablesColumnFile.loanmrefno] as int,
      loantrefno: map[TablesColumnFile.loantrefno] as int,
        mleadsid: map[TablesColumnFile.mleadsid] as String,
        mcgt2doneby: map[TablesColumnFile.mcgt2doneby] as String,
        mstarttime:(map[TablesColumnFile.mstarttime]=="null"||map[TablesColumnFile.mstarttime]==null)?null:DateTime.parse(map[TablesColumnFile.mstarttime]) as DateTime,
        mendtime:(map[TablesColumnFile.mendtime]=="null"||map[TablesColumnFile.mendtime]==null)?null:DateTime.parse(map[TablesColumnFile.mendtime]) as DateTime,
        mroutefrom: map[TablesColumnFile.mroutefrom] as String,
        mrouteto: map[TablesColumnFile.mrouteto] as String,
        //mremark: map[TablesColumnFile.mremark] as String,
        mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
        mcreatedby: map[TablesColumnFile.mcreatedby] as String,
        mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
        mlastupdateby: map[TablesColumnFile.mlastupdateby] as String,
        mgeolocation: map[TablesColumnFile.mgeolocation] as String,
        mgeolatd: map[TablesColumnFile.mgeolatd] as String,
        mgeologd: map[TablesColumnFile.mgeologd] as String,
        missynctocoresys: map[TablesColumnFile.missynctocoresys] as int,
        mlastsynsdate: (map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
        mremarks: map[TablesColumnFile.mremark] as String,
    );
  }



  factory CGT2Bean.fromMiddleware(Map<String, dynamic> map) {
    return CGT2Bean(
      trefno: map[TablesColumnFile.trefno] as int,
      mrefno: map[TablesColumnFile.mrefno]!=null?map[TablesColumnFile.mrefno] as int:0,
      loanmrefno: map[TablesColumnFile.loanmrefno] as int,
      loantrefno: map[TablesColumnFile.loantrefno] as int,
      mleadsid: map[TablesColumnFile.mleadsid] as String,
      mcgt2doneby: map[TablesColumnFile.mcgt1doneby] as String,
      mstarttime:(map[TablesColumnFile.mstarttime]=="null"||map[TablesColumnFile.mstarttime]==null)?null:DateTime.parse(map[TablesColumnFile.mstarttime]) as DateTime,
      mendtime:(map[TablesColumnFile.mendtime]=="null"||map[TablesColumnFile.mendtime]==null)?null:DateTime.parse(map[TablesColumnFile.mendtime]) as DateTime,
      mroutefrom: map[TablesColumnFile.mroutefrom] as String,
      mrouteto: map[TablesColumnFile.mrouteto] as String,
      // mremark: map[TablesColumnFile.mremark] as String,
      mcreateddt: (map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby: map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt: (map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby: map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation: map[TablesColumnFile.mgeolocation] as String,
      mgeolatd: map[TablesColumnFile.mgeolatd] as String,
      mgeologd: map[TablesColumnFile.mgeologd] as String,
      missynctocoresys: map[TablesColumnFile.missynctocoresys] as int,
      mlastsynsdate: (map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      mremarks: map[TablesColumnFile.mremark],
        checkListCGT2Bean: map[TablesColumnFile.checkListCgt2Details]==null?null:map[TablesColumnFile.checkListCgt2Details].map<CheckListCGT2Bean>((i) => CheckListCGT2Bean.frommiddleware(i)).toList(),
    );
  }



}