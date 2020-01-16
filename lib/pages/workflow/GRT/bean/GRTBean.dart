import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/GRT/bean/CheckListGRTBean.dart';

class GRTBean{

  int trefno;
  int mrefno;
  int loantrefno;
  int loanmrefno;
  String mremarks;
  String mleadsid;
  String mgrtdoneby;
  DateTime mstarttime;
  DateTime mendtime;
  String mroutefrom;
  String mrouteto;
  //String mremark;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  int missynctocoresys;
  DateTime mlastsynsdate;
  String midtype1status;
  String midtype2status;
  String midtype3status;
  String mhouseVerifiImg;
  List<CheckListGRTBean> checkListGRTBean;

  GRTBean({this.trefno, this.mrefno, this.mleadsid, this.mgrtdoneby, this.mstarttime,
    this.mendtime,this.mroutefrom, this.mrouteto, this.mcreateddt,
    this.mcreatedby,this.mlastupdatedt,this.mlastupdateby,this.mgeolocation,
    this.mgeolatd,this.mgeologd,this.missynctocoresys,this.mlastsynsdate, this.midtype1status,
    this.midtype2status, this.midtype3status,this.mremarks,this.mhouseVerifiImg,this.loantrefno,this.loanmrefno,this.checkListGRTBean});


/*  @override
  String toString() {
    return 'CheckListBean{id: $id, question: $questionId, questionDesc: $questionDesc, loanId: $loanNumber, remarks: $remarks, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy}';
  }*/

  factory GRTBean.fromMap(
      Map<String, dynamic> map) {
    return GRTBean(
        trefno: map[TablesColumnFile.trefno] as int,
        mrefno: map[TablesColumnFile.mrefno] as int,
        loanmrefno: map[TablesColumnFile.loanmrefno] as int,
        loantrefno: map[TablesColumnFile.loantrefno] as int,
        mleadsid: map[TablesColumnFile.mleadsid] as String,
        mgrtdoneby: map[TablesColumnFile.mgrtdoneby] as String,
        mstarttime:map[TablesColumnFile.mstarttime]=="null"||map[TablesColumnFile.mstarttime]==null?null:DateTime.parse(map[TablesColumnFile.mstarttime]) as DateTime  ,
        mendtime:map[TablesColumnFile.mendtime]=="null"||map[TablesColumnFile.mendtime]==null?null:DateTime.parse(map[TablesColumnFile.mendtime]) as DateTime  ,
        mroutefrom: map[TablesColumnFile.mroutefrom] as String,
        mrouteto: map[TablesColumnFile.mrouteto] as String,
        //mremark: map[TablesColumnFile.mremark] as String,
        midtype1status: map[TablesColumnFile.midtype1status] as String,
        midtype2status: map[TablesColumnFile.midtype2status] as String,
        midtype3status: map[TablesColumnFile.midtype3status] as String,
        mcreateddt:map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime  ,
        mcreatedby: map[TablesColumnFile.mcreatedby] as String,
        mlastupdatedt:  map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime  ,
        mlastupdateby: map[TablesColumnFile.mlastupdateby] as String,
        mgeolocation: map[TablesColumnFile.mgeolocation] as String,
        mgeolatd: map[TablesColumnFile.mgeolatd] as String,
        mgeologd: map[TablesColumnFile.mgeologd] as String,
        missynctocoresys: map[TablesColumnFile.missynctocoresys] as int,
        mlastsynsdate: map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime  ,
       mremarks: map[TablesColumnFile.mremark] as String,
      mhouseVerifiImg:  map[TablesColumnFile.mhouseVerifiImg] as String
    );
  }


  factory GRTBean.fromMiddleware(
      Map<String, dynamic> map) {
    return GRTBean(
        trefno: map[TablesColumnFile.trefno] as int,
        mrefno: map[TablesColumnFile.mrefno] as int,
        loanmrefno: map[TablesColumnFile.loanmrefno] as int,
        loantrefno: map[TablesColumnFile.loantrefno] as int,
        mleadsid: map[TablesColumnFile.mleadsid] as String,
        mgrtdoneby: map[TablesColumnFile.mgrtdoneby] as String,
        mstarttime:map[TablesColumnFile.mstarttime]=="null"||map[TablesColumnFile.mstarttime]==null?null:DateTime.parse(map[TablesColumnFile.mstarttime]) as DateTime  ,
        mendtime:map[TablesColumnFile.mendtime]=="null"||map[TablesColumnFile.mendtime]==null?null:DateTime.parse(map[TablesColumnFile.mendtime]) as DateTime  ,
        mroutefrom: map[TablesColumnFile.mroutefrom] as String,
        mrouteto: map[TablesColumnFile.mrouteto] as String,
        //mremark: map[TablesColumnFile.mremark] as String,
        midtype1status: map[TablesColumnFile.midtype1status] as String,
        midtype2status: map[TablesColumnFile.midtype2status] as String,
        midtype3status: map[TablesColumnFile.midtype3status] as String,
        mcreateddt:map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime  ,
        mcreatedby: map[TablesColumnFile.mcreatedby] as String,
        mlastupdatedt: map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime  ,
        mlastupdateby: map[TablesColumnFile.mlastupdateby] as String,
        mgeolocation: map[TablesColumnFile.mgeolocation] as String,
        mgeolatd: map[TablesColumnFile.mgeolatd] as String,
        mgeologd: map[TablesColumnFile.mgeologd] as String,
        missynctocoresys: map[TablesColumnFile.missynctocoresys] as int,
        mlastsynsdate: map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime  ,
        mremarks: map[TablesColumnFile.mremark] as String,
        mhouseVerifiImg:  map[TablesColumnFile.mhouseVerifiImg] as String,
      checkListGRTBean:map[TablesColumnFile.checkListGrtDetails]==null?null:map[TablesColumnFile.checkListGrtDetails].map<CheckListGRTBean>((i) => CheckListGRTBean.fromMiddleware(i))
          .toList(),
    );
  }


}