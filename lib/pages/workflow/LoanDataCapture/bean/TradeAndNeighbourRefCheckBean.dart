import 'package:eco_mfi/db/TablesColumnFile.dart';

class TradeAndNeighbourRefCheckBean {

  String mleadsid;
  String msupname	   ;
  String msupaddress;
  String msupcontact  ;
  String msupcredit  ;
  String msuponcredit  ;
  int mclientdelay	;
  String mdefpayment   ;
  String mproductsup   ;
  int msalcycles       ;
  String mvalsalcycles ;
  String mloanlender   ;
  String mfacility     ;
  int mturnover        ;
  String mremarks;
  String mbuyersname   ;
  String mbuyersaddress;
  String mcontactno    ;
  int mbuyingperiod    ;
  String mcreditbuying ;
  String mdays         ;
  String mproducts     ;
  String mmonthlypur   ;
  int mquality         ;
  String mreliableper  ;
  String mcusremarks   ;
  String mneigname     ;
  String mneigadd      ;
  int mknownclient     ;
  int mimprovement     ;
  String mrelperson    ;
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

  TradeAndNeighbourRefCheckBean({this.mleadsid, this.msupname, this.msupaddress,
      this.msupcontact, this.msupcredit, this.msuponcredit, this.mclientdelay,
      this.mdefpayment, this.mproductsup, this.msalcycles, this.mvalsalcycles,
      this.mloanlender, this.mfacility, this.mturnover, this.mremarks,
      this.mbuyersname, this.mbuyersaddress, this.mcontactno,
      this.mbuyingperiod, this.mcreditbuying, this.mdays, this.mproducts,
      this.mmonthlypur, this.mquality, this.mreliableper, this.mcusremarks,
      this.mneigname, this.mneigadd, this.mknownclient, this.mimprovement,
      this.mrelperson, this.trefno, this.mrefno, this.mloantrefno,
      this.mloanmrefno, this.mcreateddt, this.mcreatedby, this.mlastupdatedt,
      this.mlastupdateby, this.mgeolocation, this.mgeolatd, this.mgeologd,
      this.mlastsynsdate, this.missynctocoresys, this.mleadstatus,
      this.mcusttrefno, this.mcustmrefno});




  factory TradeAndNeighbourRefCheckBean.fromMap(Map<String, dynamic> map) {
    print(map);
    return TradeAndNeighbourRefCheckBean(
      trefno : map[TablesColumnFile.trefno] as int,
      mrefno : map[TablesColumnFile.mrefno] as int,
      mloantrefno : map[TablesColumnFile.mloantrefno] as int,
      mloanmrefno : map[TablesColumnFile.mloanmrefno] as int,
      mleadsid:map[TablesColumnFile.mleadsid] as String,
      msupname: map[TablesColumnFile.msupname] as String,
      msupaddress: map[TablesColumnFile.msupaddress] as String,
      msupcontact: map[TablesColumnFile.msupcontact] as String,
      msupcredit : map[TablesColumnFile.msupcredit] as String,
      msuponcredit : map[TablesColumnFile.msuponcredit] as String,
      mclientdelay: map[TablesColumnFile.mclientdelay] as int,
      mdefpayment : map[TablesColumnFile.mdefpayment] as String,
      mproductsup : map[TablesColumnFile.mproductsup] as String,
      msalcycles : map[TablesColumnFile.msalcycles] as int,
      mvalsalcycles : map[TablesColumnFile.mvalsalcycles] as String,
      mloanlender: map[TablesColumnFile.mloanlender] as String,
      mfacility : map[TablesColumnFile.mfacility] as String,
      mturnover: map[TablesColumnFile.mturnover] as int,
      mremarks: map[TablesColumnFile.mremarks] as String,
      mbuyersname: map[TablesColumnFile.mbuyersname] as String,
      mbuyersaddress: map[TablesColumnFile.mbuyersaddress] as String,
      mcontactno : map[TablesColumnFile.mcontactno] as String,
      mbuyingperiod : map[TablesColumnFile.mbuyingperiod] as int,
      mcreditbuying : map[TablesColumnFile.mcreditbuying] as String,
      mdays: map[TablesColumnFile.mdays] as String,
      mproducts: map[TablesColumnFile.mproducts] as String,
      mmonthlypur : map[TablesColumnFile.mmonthlypur] as String,
      mquality : map[TablesColumnFile.mquality] as int,
      mreliableper: map[TablesColumnFile.mreliableper] as String,
      mcusremarks : map[TablesColumnFile.mcusremarks] as String,
      mneigname: map[TablesColumnFile.mneigname] as String,
      mneigadd : map[TablesColumnFile.mneigadd] as String,
      mknownclient: map[TablesColumnFile.mknownclient] as int,
      mimprovement: map[TablesColumnFile.mimprovement] as int,
      mrelperson : map[TablesColumnFile.mrelperson] as String,
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

  factory TradeAndNeighbourRefCheckBean.fromMapMiddleware(Map<String, dynamic> map){
    print("fromMapMiddleware");
    print("Receiver String is $map");
    return TradeAndNeighbourRefCheckBean(
        trefno : map[TablesColumnFile.trefno] as int,
        mrefno : map[TablesColumnFile.mrefno] as int,
        mloantrefno : map[TablesColumnFile.mloantrefno] as int,
        mloanmrefno : map[TablesColumnFile.mloanmrefno] as int,
        mleadsid:map[TablesColumnFile.mleadsid] as String,
        msupname: map[TablesColumnFile.msupname] as String,
        msupaddress: map[TablesColumnFile.msupaddress] as String,
        msupcontact: map[TablesColumnFile.msupcontact] as String,
        msupcredit : map[TablesColumnFile.msupcredit] as String,
        msuponcredit : map[TablesColumnFile.msuponcredit] as String,
        mclientdelay: map[TablesColumnFile.mclientdelay] as int,
        mdefpayment : map[TablesColumnFile.mdefpayment] as String,
        mproductsup : map[TablesColumnFile.mproductsup] as String,
        msalcycles : map[TablesColumnFile.msalcycles] as int,
        mvalsalcycles : map[TablesColumnFile.mvalsalcycles] as String,
        mloanlender: map[TablesColumnFile.mloanlender] as String,
        mfacility : map[TablesColumnFile.mfacility] as String,
        mturnover: map[TablesColumnFile.mturnover] as int,
        mremarks: map[TablesColumnFile.mremarks] as String,
        mbuyersname: map[TablesColumnFile.mbuyersname] as String,
        mbuyersaddress: map[TablesColumnFile.mbuyersaddress] as String,
        mcontactno : map[TablesColumnFile.mcontactno] as String,
        mbuyingperiod : map[TablesColumnFile.mbuyingperiod] as int,
        mcreditbuying : map[TablesColumnFile.mcreditbuying] as String,
        mdays: map[TablesColumnFile.mdays] as String,
        mproducts: map[TablesColumnFile.mproducts] as String,
        mmonthlypur : map[TablesColumnFile.mmonthlypur] as String,
        mquality : map[TablesColumnFile.mquality] as int,
        mreliableper: map[TablesColumnFile.mreliableper] as String,
        mcusremarks : map[TablesColumnFile.mcusremarks] as String,
        mneigname: map[TablesColumnFile.mneigname] as String,
        mneigadd : map[TablesColumnFile.mneigadd] as String,
        mknownclient: map[TablesColumnFile.mknownclient] as int,
        mimprovement: map[TablesColumnFile.mimprovement] as int,
        mrelperson : map[TablesColumnFile.mrelperson] as String,
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
