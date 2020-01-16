import 'package:eco_mfi/db/TablesColumnFile.dart';

class SocialAndEnvironmentalBean {

  String mleadsid;
  int mbrwexclist	        ;
  int mbrwnontargetlist	 	;
  int mbrwairemission	 	;
  int mbrwwastewater  	 	;
  int mbrwsolidhazardous	;
  int mbrwchemicalfuels		;
  int mbrwnoisefumes        ;
  int mbrwresconsuption     ;
  int mcinodesignation      ;
  int mcinci                ;
  int msilar                ;
  int msidrofls             ;
  int msiils                ;
  int msiiip                ;
  int msicnc				;
  int msiasc                ;
  int msinsi                ;
  int mlinpp                ;
  int mliieh                ;
  int mliiwc                ;
  int mliite                ;
  int mliueo                ;
  int mlipmw                ;
  int mliema                ;
  int mlicfl                ;
  int mlipevc               ;
  int mlireou               ;
  int mlinli                ;
  int mbrwcat               ;
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


  SocialAndEnvironmentalBean({this.mleadsid, this.mbrwexclist,
      this.mbrwnontargetlist, this.mbrwairemission, this.mbrwwastewater,
      this.mbrwsolidhazardous, this.mbrwchemicalfuels, this.mbrwnoisefumes,
      this.mbrwresconsuption, this.mcinodesignation, this.mcinci, this.msilar,
      this.msidrofls, this.msiils, this.msiiip, this.msicnc, this.msiasc,
      this.msinsi, this.mlinpp, this.mliieh, this.mliiwc, this.mliite,
      this.mliueo, this.mlipmw, this.mliema, this.mlicfl, this.mlipevc,
      this.mlireou, this.mlinli, this.mbrwcat, this.trefno, this.mrefno,
      this.mloantrefno, this.mloanmrefno, this.mcreateddt, this.mcreatedby,
      this.mlastupdatedt, this.mlastupdateby, this.mgeolocation, this.mgeolatd,
      this.mgeologd, this.mlastsynsdate, this.missynctocoresys, this.mleadstatus,
      this.mcustmrefno, this.mcusttrefno});


  @override
  String toString() {
    return 'SocialAndEnvironmentalBean{mleadsid: $mleadsid, mbrwexclist: $mbrwexclist, mbrwnontargetlist: $mbrwnontargetlist, mbrwairemission: $mbrwairemission, mbrwwastewater: $mbrwwastewater, mbrwsolidhazardous: $mbrwsolidhazardous, mbrwchemicalfuels: $mbrwchemicalfuels, mbrwnoisefumes: $mbrwnoisefumes, mbrwresconsuption: $mbrwresconsuption, mcinodesignation: $mcinodesignation, mcinci: $mcinci, msilar: $msilar, msidrofls: $msidrofls, msiils: $msiils, msiiip: $msiiip, msicnc: $msicnc, msiasc: $msiasc, msinsi: $msinsi, mlinpp: $mlinpp, mliieh: $mliieh, mliiwc: $mliiwc, mliite: $mliite, mliueo: $mliueo, mlipmw: $mlipmw, mliema: $mliema, mlicfl: $mlicfl, mlipevc: $mlipevc, mlireou: $mlireou, mlinli: $mlinli, mbrwcat: $mbrwcat, trefno: $trefno, mrefno: $mrefno, mloanterfno: $mloantrefno, mloanmrefno: $mloanmrefno, mcreateddt: $mcreateddt, mcreatedby: $mcreatedby, mlastupdatedt: $mlastupdatedt, mlastupdateby: $mlastupdateby, mgeolocation: $mgeolocation, mgeolatd: $mgeolatd, mgeologd: $mgeologd, mlastsynsdate: $mlastsynsdate, missynctocoresys: $missynctocoresys}';
  }

  factory SocialAndEnvironmentalBean.fromMap(Map<String, dynamic> map) {
    print(map);
    return SocialAndEnvironmentalBean(
      trefno : map[TablesColumnFile.trefno] as int,
      mrefno : map[TablesColumnFile.mrefno] as int,
      mloantrefno : map[TablesColumnFile.mloantrefno] as int,
      mloanmrefno : map[TablesColumnFile.mloanmrefno] as int,
      mleadsid:map[TablesColumnFile.mleadsid] as String,
      mbrwexclist:map[TablesColumnFile.mbrwexclist] as int,
      mbrwnontargetlist:map[TablesColumnFile.mbrwnontargetlist] as int,
      mbrwairemission:map[TablesColumnFile.mbrwairemission] as int,
      mbrwwastewater:map[TablesColumnFile.mbrwwastewater] as int,
      mbrwsolidhazardous:map[TablesColumnFile.mbrwsolidhazardous] as int,
      mbrwchemicalfuels:map[TablesColumnFile.mbrwchemicalfuels] as int,
      mbrwnoisefumes:map[TablesColumnFile.mbrwnoisefumes] as int,
      mbrwresconsuption:map[TablesColumnFile.mbrwresconsuption] as int,
      mcinodesignation:map[TablesColumnFile.mcinodesignation] as int,
      mcinci:map[TablesColumnFile.mcinci] as int,
      msilar:map[TablesColumnFile.msilar] as int,
      msidrofls :map[TablesColumnFile.msidrofls] as int,
      msiils:map[TablesColumnFile.msiils] as int,
      msiiip:map[TablesColumnFile.msiiip] as int,
      msicnc:map[TablesColumnFile.msicnc] as int,
      msiasc :map[TablesColumnFile.msiasc] as int,
      msinsi :map[TablesColumnFile.msinsi] as int,
      mlinpp :map[TablesColumnFile.mlinpp] as int,
      mliieh:map[TablesColumnFile.mliieh] as int,
      mliiwc:map[TablesColumnFile.mliiwc] as int,
      mliite:map[TablesColumnFile.mliite] as int,
      mliueo:map[TablesColumnFile.mliueo] as int,
      mlipmw :map[TablesColumnFile.mlipmw] as int,
      mliema :map[TablesColumnFile.mliema] as int,
      mlicfl :map[TablesColumnFile.mlicfl] as int,
      mlipevc :map[TablesColumnFile.mlipevc] as int,
      mlireou :map[TablesColumnFile.mlireou] as int,
      mlinli :map[TablesColumnFile.mlinli] as int,
      mbrwcat :map[TablesColumnFile.mbrwcat] as int,
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

  factory SocialAndEnvironmentalBean.fromMapMiddleware(Map<String, dynamic> map){
    print("fromMapMiddleware");
    print("Receiver String is $map");
    return SocialAndEnvironmentalBean(
      trefno : map[TablesColumnFile.trefno] as int,
      mrefno : map[TablesColumnFile.mrefno] as int,
      mloantrefno : map[TablesColumnFile.mloantrefno] as int,
      mloanmrefno : map[TablesColumnFile.mloanmrefno] as int,
      mleadsid:map[TablesColumnFile.mleadsid] as String,
      mbrwexclist:map[TablesColumnFile.mbrwexclist] as int,
      mbrwnontargetlist:map[TablesColumnFile.mbrwnontargetlist] as int,
      mbrwairemission:map[TablesColumnFile.mbrwairemission] as int,
      mbrwwastewater:map[TablesColumnFile.mbrwwastewater] as int,
      mbrwsolidhazardous:map[TablesColumnFile.mbrwsolidhazardous] as int,
      mbrwchemicalfuels:map[TablesColumnFile.mbrwchemicalfuels] as int,
      mbrwnoisefumes:map[TablesColumnFile.mbrwnoisefumes] as int,
      mbrwresconsuption:map[TablesColumnFile.mbrwresconsuption] as int,
      mcinodesignation:map[TablesColumnFile.mcinodesignation] as int,
      mcinci:map[TablesColumnFile.mcinci] as int,
      msilar:map[TablesColumnFile.msilar] as int,
      msidrofls :map[TablesColumnFile.msidrofls] as int,
      msiils:map[TablesColumnFile.msiils] as int,
      msiiip:map[TablesColumnFile.msiiip] as int,
      msicnc:map[TablesColumnFile.msicnc] as int,
      msiasc :map[TablesColumnFile.msiasc] as int,
      msinsi :map[TablesColumnFile.msinsi] as int,
      mlinpp :map[TablesColumnFile.mlinpp] as int,
      mliieh:map[TablesColumnFile.mliieh] as int,
      mliiwc:map[TablesColumnFile.mliiwc] as int,
      mliite:map[TablesColumnFile.mliite] as int,
      mliueo:map[TablesColumnFile.mliueo] as int,
      mlipmw :map[TablesColumnFile.mlipmw] as int,
      mliema :map[TablesColumnFile.mliema] as int,
      mlicfl :map[TablesColumnFile.mlicfl] as int,
      mlipevc :map[TablesColumnFile.mlipevc] as int,
      mlireou :map[TablesColumnFile.mlireou] as int,
      mlinli :map[TablesColumnFile.mlinli] as int,
      mbrwcat :map[TablesColumnFile.mbrwcat] as int,
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
