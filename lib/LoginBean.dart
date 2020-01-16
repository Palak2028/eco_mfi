import 'package:eco_mfi/db/TablesColumnFile.dart';

class LoginBean {
  String musrcode;
  int mcustaccesslvl;
  int mextnno;
  String mactiveinstn;
  int mautologoutperiod;
  String mautologoutyn;
  DateTime mbadloginsdt;
  String memailid;
  int merror;
  String merrormessage;
  int mgrpcd;
  int misloggedinyn;
  DateTime mlastpwdchgdt;
  DateTime mlastsyslidt;
  int mmaxbadlginperday;
  int mmaxbadlginperinst;
  String mmobile;
  DateTime mnextpwdchgdt;
  DateTime mnextsyslgindt;
  int mnoofbadlogins;
  String mpwdchgforcedyn;
  int mpwdchgperioddays;
  String mregdevicemacid;
  String mreportinguser;
  int mstatus;
  int musrbrcode;
  String musrdesignation;
  String musrname;
  String musrpass;
  String musrshortname;
  String mReason;
  DateTime mSusDate;
  DateTime mJoinDate;
  String mgender;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  DateTime mlastsynsdate;
  String newpass;
  String agentleftfinger;
  String agentrightfinger;

  LoginBean(
      {this.musrcode,
      this.mcustaccesslvl,
      this.mextnno,
      this.mactiveinstn,
      this.mautologoutperiod,
      this.mautologoutyn,
      this.mbadloginsdt,
      this.memailid,
      this.merror,
      this.merrormessage,
      this.mgrpcd,
      this.misloggedinyn,
      this.mlastpwdchgdt,
      this.mlastsyslidt,
      this.mmaxbadlginperday,
      this.mmaxbadlginperinst,
      this.mmobile,
      this.mnextpwdchgdt,
      this.mnextsyslgindt,
      this.mnoofbadlogins,
      this.mpwdchgforcedyn,
      this.mpwdchgperioddays,
      this.mregdevicemacid,
      this.mreportinguser,
      this.mstatus,
      this.musrbrcode,
      this.musrdesignation,
      this.musrname,
      this.musrpass,
      this.musrshortname,
      this.mReason,
      this.mSusDate,
      this.mJoinDate,
      this.mgender,
      this.mcreateddt,
      this.mcreatedby,
      this.mlastupdatedt,
      this.mlastupdateby,
      this.mgeolocation,
      this.mgeolatd,
      this.mgeologd,
      this.mlastsynsdate,
      this.agentleftfinger,
      this.agentrightfinger});

  factory LoginBean.fromMap(Map<String, dynamic> map) {
    return LoginBean(
      musrcode: map[TablesColumnFile.musrcode] as String,
      mcustaccesslvl: map[TablesColumnFile.mcustaccesslvl] as int,
      mextnno: map[TablesColumnFile.mextnno] as int,
      mactiveinstn: map[TablesColumnFile.mactiveinstn] as String,
      mautologoutperiod: map[TablesColumnFile.mautologoutperiod] as int,
      mautologoutyn: map[TablesColumnFile.mautologoutyn] as String,
      mbadloginsdt: (map[TablesColumnFile.mbadloginsdt] == "null" ||
              map[TablesColumnFile.mbadloginsdt] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mbadloginsdt]) as DateTime,
      memailid: map[TablesColumnFile.memailid] as String,
      merror: map[TablesColumnFile.merror] as int,
      merrormessage: map[TablesColumnFile.merrormessage] as String,
      mgrpcd: map[TablesColumnFile.mgrpcd] as int,
      misloggedinyn: map[TablesColumnFile.misloggedinyn] as int,
      mlastpwdchgdt: (map[TablesColumnFile.mlastpwdchgdt] == "null" ||
              map[TablesColumnFile.mlastpwdchgdt] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mlastpwdchgdt]) as DateTime,
      mlastsyslidt: (map[TablesColumnFile.mlastsyslidt] == "null" ||
              map[TablesColumnFile.mlastsyslidt] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mlastsyslidt]) as DateTime,
      mmaxbadlginperday: map[TablesColumnFile.mmaxbadlginperday] as int,
      mmaxbadlginperinst: map[TablesColumnFile.mmaxbadlginperinst] as int,
      mmobile: map[TablesColumnFile.mmobile] as String,
      mnextpwdchgdt: (map[TablesColumnFile.mnextpwdchgdt] == "null" ||
              map[TablesColumnFile.mnextpwdchgdt] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mnextpwdchgdt]) as DateTime,
      mnextsyslgindt: (map[TablesColumnFile.mnextsyslgindt] == "null" ||
              map[TablesColumnFile.mnextsyslgindt] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mnextsyslgindt]) as DateTime,
      mnoofbadlogins: map[TablesColumnFile.mnoofbadlogins] as int,
      mpwdchgforcedyn: map[TablesColumnFile.mpwdchgforcedyn] as String,
      mpwdchgperioddays: map[TablesColumnFile.mpwdchgperioddays] as int,
      mregdevicemacid: map[TablesColumnFile.mregdevicemacid] as String,
      mreportinguser: map[TablesColumnFile.mreportinguser] as String,
      mstatus: map[TablesColumnFile.mstatus] as int,
      musrbrcode: map[TablesColumnFile.musrbrcode] as int,
      musrdesignation: map[TablesColumnFile.musrdesignation] as String,
      musrname: map[TablesColumnFile.musrname] as String,
      musrpass: map[TablesColumnFile.musrpass] as String,
      musrshortname: map[TablesColumnFile.musrshortname] as String,
      mReason: map[TablesColumnFile.mReason] as String,
      mSusDate: (map[TablesColumnFile.mSusDate] == "null" ||
              map[TablesColumnFile.mSusDate] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mSusDate]) as DateTime,
      mJoinDate: (map[TablesColumnFile.mJoinDate] == "null" ||
              map[TablesColumnFile.mJoinDate] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mJoinDate]) as DateTime,
      mgender: map[TablesColumnFile.mgender] as String,
      mcreateddt: (map[TablesColumnFile.mcreateddt] == "null" ||
              map[TablesColumnFile.mcreateddt] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby: map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt: (map[TablesColumnFile.mlastupdatedt] == "null" ||
              map[TablesColumnFile.mlastupdatedt] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby: map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation: map[TablesColumnFile.mgeolocation] as String,
      mgeolatd: map[TablesColumnFile.mgeolatd] as String,
      mgeologd: map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate: (map[TablesColumnFile.mlastsynsdate] == "null" ||
              map[TablesColumnFile.mlastsynsdate] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      agentleftfinger: map[TablesColumnFile.agentleftfinger] as String,
      agentrightfinger: map[TablesColumnFile.agentrightfinger] as String,
    );
  }

  factory LoginBean.fromMapMiddleware(
      Map<String, dynamic> map, bool isFromMiddleware) {
    print("fromMap");
    return LoginBean(
      musrcode: map[TablesColumnFile.musrcode] as String,
      musrpass: map[TablesColumnFile.musrpass] as String,
      mstatus: map[TablesColumnFile.mstatus] as int,
      mregdevicemacid: map[TablesColumnFile.mregdevicemacid] as String,
      merror: map[TablesColumnFile.merror] as int,
      merrormessage: map[TablesColumnFile.merrormessage] as String,
      agentleftfinger: map[TablesColumnFile.agentleftfinger] as String,
      agentrightfinger: map[TablesColumnFile.agentrightfinger] as String,
    );
  }

  @override
  String toString() {
    return 'LoginBean{musrcode: $musrcode,agentleftfinger: $agentleftfinger,agentrightfinger: $agentrightfinger, mcustaccesslvl: $mcustaccesslvl, mextnno: $mextnno, mactiveinstn: $mactiveinstn, mautologoutperiod: $mautologoutperiod, mautologoutyn: $mautologoutyn, mbadloginsdt: $mbadloginsdt, memailid: $memailid, merror: $merror, merrormessage: $merrormessage, mgrpcd: $mgrpcd, misloggedinyn: $misloggedinyn, mlastpwdchgdt: $mlastpwdchgdt, mlastsyslidt: $mlastsyslidt, mmaxbadlginperday: $mmaxbadlginperday, mmaxbadlginperinst: $mmaxbadlginperinst, mmobile: $mmobile, mnextpwdchgdt: $mnextpwdchgdt, mnextsyslgindt: $mnextsyslgindt, mnoofbadlogins: $mnoofbadlogins, mpwdchgforcedyn: $mpwdchgforcedyn, mpwdchgperioddays: $mpwdchgperioddays, mregdevicemacid: $mregdevicemacid, mreportinguser: $mreportinguser, mstatus: $mstatus, musrbrcode: $musrbrcode, musrdesignation: $musrdesignation, musrname: $musrname, musrpass: $musrpass, musrshortname: $musrshortname, mReason: $mReason, mSusDate: $mSusDate, mJoinDate: $mJoinDate, mgender: $mgender, mcreateddt: $mcreateddt, mcreatedby: $mcreatedby, mlastupdatedt: $mlastupdatedt, mlastupdateby: $mlastupdateby, mgeolocation: $mgeolocation, mgeolatd: $mgeolatd, mgeologd: $mgeologd, mlastsynsdate: $mlastsynsdate, newpass: $newpass}';
  }
}
