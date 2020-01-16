import 'package:eco_mfi/db/TablesColumnFile.dart';

class KycMasterBean {
  int trefno;
  int mrefno;
  String mleadsid;
  int mloantrefno;
  int mloanmrefno;
  int mcusttrefno;
  int mcustmrefno;

  int mbackground;
  int mjob;
  int mlifestyle;
  int mloanrepay;
  int mnetworth;
  String mcomments;
  int mverifiedinfo;

  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  int missynctocoresys;
  DateTime mlastsynsdate;

  KycMasterBean({
      this.trefno,
      this.mrefno,
      this.mleadsid,
      this.mloantrefno,
      this.mloanmrefno,
      this.mcusttrefno,
      this.mcustmrefno,
      this.mbackground,
      this.mjob,
      this.mlifestyle,
      this.mloanrepay,
      this.mnetworth,
      this.mcomments,
      this.mverifiedinfo,
      this.mcreateddt,
      this.mcreatedby,
      this.mlastupdatedt,
      this.mlastupdateby,
      this.mgeolocation,
      this.mgeolatd,
      this.mgeologd,
      this.missynctocoresys,
      this.mlastsynsdate});

  factory KycMasterBean.fromMap(Map<String, dynamic> map) {
    return KycMasterBean(
        trefno : map[TablesColumnFile.trefno] as int,
        mrefno : map[TablesColumnFile.mrefno] as int,
        mleadsid : map[TablesColumnFile.mleadsid] as String,
        mloantrefno : map[TablesColumnFile.mloantrefno] as int,
        mloanmrefno: map[TablesColumnFile.mloanmrefno] as int,
        mcusttrefno: map[TablesColumnFile.mcusttrefno] as int,
        mcustmrefno: map[TablesColumnFile.mcustmrefno] as int,

        mbackground : map[TablesColumnFile.mbackground] as int,
        mjob : map[TablesColumnFile.mjob] as int,
        mlifestyle : map[TablesColumnFile.mlifestyle] as int,
        mloanrepay : map[TablesColumnFile.mloanrepay] as int,
        mnetworth : map[TablesColumnFile.mnetworth] as int,
        mcomments : map[TablesColumnFile.mcomments] as String,
        mverifiedinfo : map[TablesColumnFile.mverifiedinfo] as int,

        mcreateddt:(map[TablesColumnFile.mcreateddt]=="null" || map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
        mcreatedby : map[TablesColumnFile.mcreatedby] as String,
        mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
        mlastupdateby : map[TablesColumnFile.mlastupdateby] as String,
        mgeolocation : map[TablesColumnFile.mgeolocation] as String,
        mgeolatd : map[TablesColumnFile.mgeolatd] as String,
        mgeologd : map[TablesColumnFile.mgeologd] as String,
        missynctocoresys : map[TablesColumnFile.missynctocoresys] as int,
        mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime

    );

  }

  factory KycMasterBean.fromMapMiddleware(Map<String, dynamic> map,) {
    print("fromMap");
    return KycMasterBean(
        trefno : map[TablesColumnFile.trefno] as int,
        mrefno : map[TablesColumnFile.mrefno] as int,
        mleadsid : map[TablesColumnFile.mleadsid] as String,
        mloantrefno : map[TablesColumnFile.mloantrefno] as int,
        mloanmrefno: map[TablesColumnFile.mloanmrefno] as int,
        mcusttrefno: map[TablesColumnFile.mcusttrefno] as int,
        mcustmrefno: map[TablesColumnFile.mcustmrefno] as int,

        mbackground : map[TablesColumnFile.mbackground] as int,
        mjob : map[TablesColumnFile.mjob] as int,
        mlifestyle : map[TablesColumnFile.mlifestyle] as int,
        mloanrepay : map[TablesColumnFile.mloanrepay] as int,
        mnetworth : map[TablesColumnFile.mnetworth] as int,
        mcomments : map[TablesColumnFile.mcomments] as String,
        mverifiedinfo : map[TablesColumnFile.mverifiedinfo] as int,

        mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
        mcreatedby : map[TablesColumnFile.mcreatedby] as String,
        mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
        mlastupdateby : map[TablesColumnFile.mlastupdateby] as String,
        mgeolocation : map[TablesColumnFile.mgeolocation] as String,
        mgeolatd : map[TablesColumnFile.mgeolatd] as String,
        mgeologd : map[TablesColumnFile.mgeologd] as String,
        missynctocoresys : map[TablesColumnFile.missynctocoresys] as int,
        mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime
    );
  }

  @override
  String toString() {
    return 'KycMasterBean{trefno: $trefno, mrefno: $mrefno, mleadsid: $mleadsid, mloantrefno: $mloantrefno, mloanmrefno: $mloanmrefno, mcusttrefno: $mcusttrefno, mcustmrefno: $mcustmrefno, mbackground: $mbackground, mjob: $mjob, mlifestyle: $mlifestyle, mloanrepay: $mloanrepay, mnetworth: $mnetworth, mcomments: $mcomments, mverifiedinfo: $mverifiedinfo, mcreateddt: $mcreateddt, mcreatedby: $mcreatedby, mlastupdatedt: $mlastupdatedt, mlastupdateby: $mlastupdateby, mgeolocation: $mgeolocation, mgeolatd: $mgeolatd, mgeologd: $mgeologd, missynctocoresys: $missynctocoresys, mlastsynsdate: $mlastsynsdate}';
  }

}
