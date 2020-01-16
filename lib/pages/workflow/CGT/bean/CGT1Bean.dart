import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CheckListCGT1Bean.dart';

class CGT1Bean{

  int trefno;
  int mrefno;
  int loantrefno;
  int loanmrefno;
  String mleadsid;
  String mcgt1doneby;
  DateTime mstarttime;
  DateTime mendtime;
  String mroutefrom;
  String mrouteto;
 // String mremark;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  int missynctocoresys;
  String mremarks;
  DateTime mlastsynsdate;
  List<CheckListCGT1Bean> checkListCGT1Bean;

  CGT1Bean({this.trefno, this.mrefno, this.mleadsid, this.mcgt1doneby, this.mstarttime,
    this.mendtime,this.mroutefrom, this.mrouteto,  this.mcreateddt,
    this.mcreatedby,this.mlastupdatedt,this.mlastupdateby,this.mgeolocation,
    this.mgeolatd,this.mgeologd,this.missynctocoresys,this.mlastsynsdate,this.mremarks,this.loanmrefno,this.loantrefno,this.checkListCGT1Bean});

  factory CGT1Bean.fromMap(
      Map<String, dynamic> map) {
    return CGT1Bean(
        trefno: map[TablesColumnFile.trefno] as int,
        mrefno: map[TablesColumnFile.mrefno]!=null?map[TablesColumnFile.mrefno] as int:0,
        loanmrefno: map[TablesColumnFile.loanmrefno] as int,
        loantrefno: map[TablesColumnFile.loantrefno] as int,
        mleadsid: map[TablesColumnFile.mleadsid] as String,
        mcgt1doneby: map[TablesColumnFile.mcgt1doneby] as String,
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
        mremarks: map[TablesColumnFile.mremark]
    );
  }


  factory CGT1Bean.fromMiddleware(Map<String, dynamic> map) {

    print("inside cgt1 ");
    return CGT1Bean(
        trefno: map[TablesColumnFile.trefno] as int,
        mrefno: map[TablesColumnFile.mrefno]!=null?map[TablesColumnFile.mrefno] as int:0,
        loanmrefno: map[TablesColumnFile.loanmrefno] as int,
        loantrefno: map[TablesColumnFile.loantrefno] as int,
        mleadsid: map[TablesColumnFile.mleadsid] as String,
        mcgt1doneby: map[TablesColumnFile.mcgt1doneby] as String,
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
      checkListCGT1Bean:map[TablesColumnFile.checkListCgt1Details]==null?null:map[TablesColumnFile.checkListCgt1Details].map<CheckListCGT1Bean>((i) => CheckListCGT1Bean.frommiddleware(i))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'CGT1Bean{trefno: $trefno, mrefno: $mrefno, loantrefno: $loantrefno, loanmrefno: $loanmrefno, mleadsid: $mleadsid, mcgt1doneby: $mcgt1doneby, mstarttime: $mstarttime, mendtime: $mendtime, mroutefrom: $mroutefrom, mrouteto: $mrouteto, mcreateddt: $mcreateddt, mcreatedby: $mcreatedby, mlastupdatedt: $mlastupdatedt, mlastupdateby: $mlastupdateby, mgeolocation: $mgeolocation, mgeolatd: $mgeolatd, mgeologd: $mgeologd, missynctocoresys: $missynctocoresys, mremarks: $mremarks, mlastsynsdate: $mlastsynsdate, checkListCGT1Bean: $checkListCGT1Bean}';
  }


}