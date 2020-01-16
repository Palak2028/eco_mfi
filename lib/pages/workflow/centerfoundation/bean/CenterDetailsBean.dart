
import 'package:eco_mfi/db/TablesColumnFile.dart';

class CenterDetailsBean {

  int trefno;
  int mrefno;
  int mCenterId;
  DateTime mEffectiveDt;
  int mlbrcode;
  String mcentername;
  String mcrs;
  int marea;
  int mareatype;
  DateTime mformatndt;
  String mmeetingfreq;
  String mmeetinglocn;
  int mmeetingday;
  String mcentermthhmm;
  int mcentermtampm;
  DateTime mfirstmeetngdt;
  DateTime mnextmeetngdt;
  DateTime mlastmeetngdt;
  int mrepayfrom;
  int mrepayto;
  int mcurrnoOfmembers;
  int mcenterstatus;
  DateTime mdropoutdate;
  DateTime mlastmonitoringdate;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  int missynctocoresys;
  DateTime mlastsynsdate;


  CenterDetailsBean(
      {
        this.trefno,
        this.mrefno,
        this.mCenterId,
        this.mEffectiveDt,
        this.mlbrcode,
        this.mcentername,
        this.mcrs,
        this.marea,
        this.mformatndt,
        this.mmeetingfreq,
        this.mmeetinglocn,
        this.mmeetingday,
        this.mcentermthhmm,
        this.mcentermtampm,
        this.mfirstmeetngdt,
        this.mnextmeetngdt,
        this.mlastmeetngdt,
        this.mrepayfrom,
        this.mrepayto,
        this.mcurrnoOfmembers,
        this.mcenterstatus,
        this.mdropoutdate,
        this.mlastmonitoringdate,
        this.mcreateddt,
        this.mcreatedby,
        this.mlastupdatedt,
        this.mlastupdateby,
        this.mgeolocation,
        this.mgeolatd,
        this.mgeologd,
        this.missynctocoresys,
        this.mlastsynsdate, this.mareatype
      });



  factory CenterDetailsBean.fromMap(Map<String, dynamic> map) {
    return CenterDetailsBean(
        trefno : map[TablesColumnFile.trefno] as int,
        mrefno : map[TablesColumnFile.mrefno] as int,
        mCenterId : map[TablesColumnFile.mCenterId] as int,
        mEffectiveDt:(map[TablesColumnFile.mEffectiveDt]=="null"||map[TablesColumnFile.mEffectiveDt]==null)?null:DateTime.parse(map[TablesColumnFile.mEffectiveDt]) as DateTime,
        mlbrcode : map[TablesColumnFile.mlbrcode] as int,
        mcentername : map[TablesColumnFile.mcentername] as String,
        mcrs : map[TablesColumnFile.mcrs] as String,
        marea : map[TablesColumnFile.marea] as int,
        mareatype : map[TablesColumnFile.mareatype] as int,
        mformatndt:(map[TablesColumnFile.mformatndt]=="null"||map[TablesColumnFile.mformatndt]==null)?null:DateTime.parse(map[TablesColumnFile.mformatndt]) as DateTime,
        mmeetingfreq : map[TablesColumnFile.mmeetingfreq] as String,
        mmeetinglocn : map[TablesColumnFile.mmeetinglocn] as String,
        mmeetingday : map[TablesColumnFile.mmeetingday] as int,
        mcentermthhmm : map[TablesColumnFile.mcentermthhmm] as String,
        mcentermtampm : map[TablesColumnFile.mcentermtampm] as int,
        mfirstmeetngdt:(map[TablesColumnFile.mfirstmeetngdt]=="null"||map[TablesColumnFile.mfirstmeetngdt]==null)?null:DateTime.parse(map[TablesColumnFile.mfirstmeetngdt]) as DateTime,
        mnextmeetngdt:(map[TablesColumnFile.mnextmeetngdt]=="null"||map[TablesColumnFile.mnextmeetngdt]==null)?null:DateTime.parse(map[TablesColumnFile.mnextmeetngdt]) as DateTime,
        mlastmeetngdt:(map[TablesColumnFile.mlastmeetngdt]=="null"||map[TablesColumnFile.mlastmeetngdt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastmeetngdt]) as DateTime,
        mrepayfrom : map[TablesColumnFile.mrepayfrom] as int,
        mrepayto : map[TablesColumnFile.mrepayto] as int,
        mcurrnoOfmembers : map[TablesColumnFile.mcurrnoOfmembers] as int,
        mcenterstatus : map[TablesColumnFile.mcenterstatus] as int,
        mdropoutdate:(map[TablesColumnFile.mdropoutdate]=="null"||map[TablesColumnFile.mdropoutdate]==null)?null:DateTime.parse(map[TablesColumnFile.mdropoutdate]) as DateTime,
        mlastmonitoringdate:(map[TablesColumnFile.mlastmonitoringdate]=="null"||map[TablesColumnFile.mlastmonitoringdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastmonitoringdate]) as DateTime,
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

  factory CenterDetailsBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap");
    return CenterDetailsBean(
        trefno : map[TablesColumnFile.trefno] as int,
        mrefno : map[TablesColumnFile.mrefno] as int,
        mCenterId : map[TablesColumnFile.mCenterId] as int,
        mEffectiveDt:(map[TablesColumnFile.mEffectiveDt]=="null"||map[TablesColumnFile.mEffectiveDt]==null)?null:DateTime.parse(map[TablesColumnFile.mEffectiveDt]) as DateTime,
        mlbrcode : map[TablesColumnFile.mlbrcode] as int,
        mcentername : map[TablesColumnFile.mcentername] as String,
        mcrs : map[TablesColumnFile.mcrs] as String,
        marea : map[TablesColumnFile.marea] as int,
        mareatype : map[TablesColumnFile.mareatype] as int,
        mformatndt:(map[TablesColumnFile.mformatndt]=="null"||map[TablesColumnFile.mformatndt]==null)?null:DateTime.parse(map[TablesColumnFile.mformatndt]) as DateTime,
        mmeetingfreq : map[TablesColumnFile.mmeetingfreq] as String,
        mmeetinglocn : map[TablesColumnFile.mmeetinglocn] as String,
        mmeetingday : map[TablesColumnFile.mmeetingday] as int,
        mcentermthhmm : map[TablesColumnFile.mcentermthhmm] as String,
        mcentermtampm : map[TablesColumnFile.mcentermtampm] as int,
        mfirstmeetngdt:(map[TablesColumnFile.mfirstmeetngdt]=="null"||map[TablesColumnFile.mfirstmeetngdt]==null)?null:DateTime.parse(map[TablesColumnFile.mfirstmeetngdt]) as DateTime,
        mnextmeetngdt:(map[TablesColumnFile.mnextmeetngdt]=="null"||map[TablesColumnFile.mnextmeetngdt]==null)?null:DateTime.parse(map[TablesColumnFile.mnextmeetngdt]) as DateTime,
        mlastmeetngdt:(map[TablesColumnFile.mlastmeetngdt]=="null"||map[TablesColumnFile.mlastmeetngdt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastmeetngdt]) as DateTime,
        mrepayfrom : map[TablesColumnFile.mrepayfrom] as int,
        mrepayto : map[TablesColumnFile.mrepayto] as int,
        mcurrnoOfmembers : map[TablesColumnFile.mcurrnoOfmembers] as int,
        mcenterstatus : map[TablesColumnFile.mcenterstatus] as int,
        mdropoutdate:(map[TablesColumnFile.mdropoutdate]=="null"||map[TablesColumnFile.mdropoutdate]==null)?null:DateTime.parse(map[TablesColumnFile.mdropoutdate]) as DateTime,
        mlastmonitoringdate:(map[TablesColumnFile.mlastmonitoringdate]=="null"||map[TablesColumnFile.mlastmonitoringdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastmonitoringdate]) as DateTime,
        mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
        mcreatedby : map[TablesColumnFile.mcreatedby] as String,
        mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
        mlastupdateby : map[TablesColumnFile.mlastupdateby] as String,
        mgeolocation : map[TablesColumnFile.mgeolocation] as String,
        mgeolatd : map[TablesColumnFile.mgeolatd] as String,
        mgeologd : map[TablesColumnFile.mgeologd] as String,
        missynctocoresys : map[TablesColumnFile.missynctocoresys] as int,
        mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime

    );}
}




