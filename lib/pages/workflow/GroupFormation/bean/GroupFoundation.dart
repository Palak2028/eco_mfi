import 'package:eco_mfi/db/TablesColumnFile.dart';

class GroupFoundationBean {
  int trefno;
  int mrefno;
  int mgroupid;
  String mgroupname;
  int mlbrcode;
  String magentcd;
  int mcenterid;
  DateTime mGrprecogTestDate;
  int mMaxGroupMembers;
  int mMinGroupMembers;
  String mgrouptype;
  String mgrtapprovedby;
  double mloanlimit ;
  int meetingday;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  DateTime mlastsynsdate;
  String mgroupprdcode;
  String mgroupgender;
  int mrefcenterid;
  int trefcenterid;
  int missynctocoresys;



  GroupFoundationBean(
      {
        this.trefno,
        this.mrefno,
        this.mgroupid,
        this.mgroupname,
        this.mlbrcode,
        this.magentcd,
        this.mcenterid,
        this.mGrprecogTestDate,
        this.mMaxGroupMembers,
        this.mMinGroupMembers,
        this.mgrouptype,
        this.mgrtapprovedby,
        this.mloanlimit,
        this.meetingday,
        this.mcreateddt,
        this.mcreatedby,
        this.mlastupdatedt,
        this.mlastupdateby,
        this.mgeolocation,
        this.mgeolatd,
        this.mgeologd,
        this.mlastsynsdate,
        this.mgroupprdcode,
        this.mgroupgender,
        this.mrefcenterid,
        this.trefcenterid,
        this.missynctocoresys
      });



  factory GroupFoundationBean.fromMap(Map<String, dynamic> map) {
    return GroupFoundationBean(
        trefno : map[TablesColumnFile.trefno] as int,
        mrefno : map[TablesColumnFile.mrefno] as int,
        mgroupid : map[TablesColumnFile.mgroupid] as int,
        mgroupname  : map[TablesColumnFile.mgroupname] as String,
        mlbrcode    : map[TablesColumnFile.mlbrcode] as int,
        magentcd    : map[TablesColumnFile.magentcd] as String,
        mcenterid   : map[TablesColumnFile.mcenterid] as int,
        mGrprecogTestDate:(map[TablesColumnFile.mGrprecogTestDate]=="null"||map[TablesColumnFile.mGrprecogTestDate]==null)?null:DateTime.parse(map[TablesColumnFile.mGrprecogTestDate]) as DateTime,
        mMaxGroupMembers  : map[TablesColumnFile.mMaxGroupMembers] as int,
        mMinGroupMembers : map[TablesColumnFile.mMinGroupMembers] as int,
        mgrouptype : map[TablesColumnFile.mgrouptype] as String,
        mgrtapprovedby    : map[TablesColumnFile.mgrtapprovedby] as String,
        mloanlimit     : map[TablesColumnFile.mloanlimit]as double,
        meetingday  : map[TablesColumnFile.meetingday] as int,
        mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
        mcreatedby : map[TablesColumnFile.mcreatedby] as String, mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
        mlastupdateby : map[TablesColumnFile.mlastupdateby] as String,
        mgeolocation : map[TablesColumnFile.mgeolocation] as String,
        mgeolatd : map[TablesColumnFile.mgeolatd] as String,
        mgeologd : map[TablesColumnFile.mgeologd] as String,
        mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||
            map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,

        mgroupprdcode: map[TablesColumnFile.mgroupprdcode] as String,
        mgroupgender: map[TablesColumnFile.mgroupgender] as String,
        mrefcenterid: map[TablesColumnFile.mrefcenterid] as int,
        trefcenterid: map[TablesColumnFile.trefcenterid] as int,
        missynctocoresys: map[TablesColumnFile.missynctocoresys] as int
    );
  }

  factory GroupFoundationBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap");
    return GroupFoundationBean(
        trefno : map[TablesColumnFile.trefno] as int,
        mrefno : map[TablesColumnFile.mrefno] as int,
        mgroupid : map[TablesColumnFile.mgroupid] as int,
        mgroupname  : map[TablesColumnFile.mgroupname] as String,
        mlbrcode    : map[TablesColumnFile.mlbrcode] as int,
        magentcd    : map[TablesColumnFile.magentcd] as String,
        mcenterid   : map[TablesColumnFile.mcenterid] as int,
        mGrprecogTestDate:(map[TablesColumnFile.mGrprecogTestDate]=="null"||map[TablesColumnFile.mGrprecogTestDate]==null)?null:DateTime.parse(map[TablesColumnFile.mGrprecogTestDate]) as DateTime,
        mMaxGroupMembers  : map[TablesColumnFile.mMaxGroupMembers] as int,
        mMinGroupMembers : map[TablesColumnFile.mMinGroupMembers] as int,
        mgrouptype : map[TablesColumnFile.mgrouptype] as String,
        mgrtapprovedby    : map[TablesColumnFile.mgrtapprovedby] as String,
        mloanlimit     : map[TablesColumnFile.mloanlimit]as double,
        meetingday  : map[TablesColumnFile.meetingday] as int,
        mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
        mcreatedby : map[TablesColumnFile.mcreatedby] as String, mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
        mlastupdateby : map[TablesColumnFile.mlastupdateby] as String,
        mgeolocation : map[TablesColumnFile.mgeolocation] as String,
        mgeolatd : map[TablesColumnFile.mgeolatd] as String,
        mgeologd : map[TablesColumnFile.mgeologd] as String,

        mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||
            map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,

      mgroupprdcode: map[TablesColumnFile.mgroupprdcode] as String,
      mgroupgender: map[TablesColumnFile.mgroupgender] as String,
      mrefcenterid   : map[TablesColumnFile.mrefcenterid] as int,
      trefcenterid   : map[TablesColumnFile.trefcenterid] as int,
      missynctocoresys: map[TablesColumnFile.missynctocoresys] as int
    );}
  factory GroupFoundationBean.fromJson(Map<String, dynamic> map) {
   /* return GroupFoundationBean(
        trefno : map[TablesColumnFile.trefno] as int,
        mrefno : map[TablesColumnFile.mrefno] as int,
        mgroupid : map[TablesColumnFile.mgroupid] as int,
        mgroupname  : map[TablesColumnFile.mgroupname] as String,
        mlbrcode    : map[TablesColumnFile.mlbrcode] as int,
   z     magentcd    : map[TablesColumnFile.magentcd] as String,
        mcenterid   : map[TablesColumnFile.mcenterid] as int,
        mGrprecogTestDate:(map[TablesColumnFile.mGrprecogTestDate]=="null"||map[TablesColumnFile.mGrprecogTestDate]==null)?null:DateTime.parse(map[TablesColumnFile.mGrprecogTestDate]) as DateTime,
        mMaxGroupMembers  : map[TablesColumnFile.mMaxGroupMembers] as int,
        mMinGroupMembers : map[TablesColumnFile.mMinGroupMembers] as int,
        mgrouptype : map[TablesColumnFile.mgrouptype] as String,
        mgrtapprovedby    : map[TablesColumnFile.mgrtapprovedby] as String,
        mloanlimit     : map[TablesColumnFile.mloanlimit]as double,
        meetingday  : map[TablesColumnFile.meetingday] as int,
        mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
        mcreatedby : map[TablesColumnFile.mcreatedby] as String, mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
        mlastupdateby : map[TablesColumnFile.mlastupdateby] as String,
        mgeolocation : map[TablesColumnFile.mgeolocation] as String,
        mgeolatd : map[TablesColumnFile.mgeolatd] as String,
        mgeologd : map[TablesColumnFile.mgeologd] as String,
        mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime

    );*/
  }
}
