import 'package:eco_mfi/db/TablesColumnFile.dart';

class CustomerLoanImageBean{

  int mloanmrefno;
  int mloantrefno;
  int mrefno;
  int trefno;
  int mcusttrefno;
  int mcustmrefno;
  String mimagestring;
  String mimagebyteorfolder;
  String mimagetype;
  int timgrefno;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  int missynctocoresys;
  DateTime mlastsynsdate;

  @override
  String toString() {
    return 'CustomerLoanImageBean{mloanmrefno: $mloanmrefno, mloantrefno: $mloantrefno, mrefno: $mrefno, trefno: $trefno, mcusttrefno: $mcusttrefno, mcustmrefno: $mcustmrefno, mimagestring: $mimagestring, mimagebyteorfolder: $mimagebyteorfolder, mimagetype: $mimagetype}';
  }

  CustomerLoanImageBean({this.mloanmrefno, this.mloantrefno, this.mrefno,
      this.trefno, this.mcusttrefno, this.mcustmrefno, this.mimagestring,
      this.mimagebyteorfolder, this.mimagetype,this.timgrefno,
    this.mcreateddt,
    this.mcreatedby,
    this.mlastupdatedt,
    this. mlastupdateby,
    this.missynctocoresys,
    this.mlastsynsdate,

  });




  factory CustomerLoanImageBean.fromMap(Map<String, dynamic> map) {
    print("Inside map");
    print(map);
    return CustomerLoanImageBean(


      mloanmrefno: 	 map[TablesColumnFile.mloanmrefno] as int,
      mloantrefno: 	 map[TablesColumnFile.mloantrefno] as int,
      mrefno: 	 map[TablesColumnFile.mrefno] as int,
      trefno: 	 map[TablesColumnFile.trefno] as int,
    mcusttrefno: 	 map[TablesColumnFile.mcusttrefno] as int,
     mcustmrefno: 	 map[TablesColumnFile.mcustmrefno] as int,
     mimagestring: 	 map[TablesColumnFile.mimagestring] as String,
     mimagebyteorfolder: 	 "",
     mimagetype: 	 map[TablesColumnFile.mimagetype] as String,
        timgrefno: map[TablesColumnFile.timgrefno] as int,
      mcreateddt: (map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby],
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby] as String,
      missynctocoresys:(map[TablesColumnFile.missynctocoresys]=="null"||map[TablesColumnFile.missynctocoresys]==null)?0:map[TablesColumnFile.missynctocoresys] as int,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,


    );
  }

  factory CustomerLoanImageBean.fromMapFromMiddleWare(Map<String, dynamic> map) {
    return CustomerLoanImageBean(
      mloanmrefno: 	 map[TablesColumnFile.mloanmrefno] as int,
      mloantrefno: 	 map[TablesColumnFile.mloantrefno] as int,
      mrefno: 	 map[TablesColumnFile.mrefno] as int,
      trefno: 	 map[TablesColumnFile.trefno] as int,
      mcusttrefno: 	 map[TablesColumnFile.mcusttrefno] as int,
      mcustmrefno: 	 map[TablesColumnFile.mcustmrefno] as int,
      mimagestring: 	 map[TablesColumnFile.mimagestring] as String,
      mimagebyteorfolder: 	"",
      mimagetype: 	 map[TablesColumnFile.mimagetype] as String,
        timgrefno: map[TablesColumnFile.timgrefno] as int,
      mcreateddt: (map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby],
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby] as String,
      missynctocoresys:(map[TablesColumnFile.missynctocoresys]=="null"||map[TablesColumnFile.missynctocoresys]==null)?0:map[TablesColumnFile.missynctocoresys] as int,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,


    );
  }





}