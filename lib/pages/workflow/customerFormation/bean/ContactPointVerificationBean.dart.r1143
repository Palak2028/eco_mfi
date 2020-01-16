import 'package:eco_mfi/db/TablesColumnFile.dart';

class ContactPointVerificationBean{



  int tcpvrefno;
  int mcpvrefno;
  int trefno;
  int mrefno;
  String maddmatch;
  String massetvissibledesc;
  String massetvissiblecode;
  String myrsmovdin;
  String mhouseprptystatus;
  String mhousestructure;
  String mhousewall;
  String mhouseroof;


  ContactPointVerificationBean(
      {
        this.tcpvrefno,
        this.mcpvrefno,
        this.trefno,
        this.mrefno,
        this.maddmatch,
        this.massetvissibledesc,
        this.myrsmovdin,
        this.mhouseprptystatus,
        this.mhousestructure,
        this.mhousewall,
        this.mhouseroof,
        this.massetvissiblecode
        });




  factory ContactPointVerificationBean.fromMapMiddlewareFroMrefNoOnly(Map<String, dynamic> map) {
    return ContactPointVerificationBean(
      mcpvrefno : map[TablesColumnFile.mcpvrefno] as int,
    );
  }

  factory ContactPointVerificationBean.fromMap(Map<String, dynamic> map) {
    return ContactPointVerificationBean(
      tcpvrefno:  map[TablesColumnFile.tcpvrefno] as int,
      mcpvrefno:  map[TablesColumnFile.mcpvrefno] as int,
      trefno:  map[TablesColumnFile.trefno] as int,
      mrefno:  map[TablesColumnFile.mrefno] as int,
      maddmatch: map[TablesColumnFile.maddmatch] as String,
      massetvissibledesc: map[TablesColumnFile.massetvissibledesc] as String,
      massetvissiblecode: map[TablesColumnFile.massetvissiblecode] as String,
      myrsmovdin: map[TablesColumnFile.myrsmovdin] as String,
      mhouseprptystatus:  map[TablesColumnFile.mhouseprptystatus] as String,
      mhousestructure: map[TablesColumnFile.mhousestructure] as String,
      mhousewall:  map[TablesColumnFile.mhousewall] as String,
      mhouseroof: map[TablesColumnFile.mhouseroof] as String,

    );
  }
  factory ContactPointVerificationBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap");
    return ContactPointVerificationBean(
      tcpvrefno:  map[TablesColumnFile.tcpvrefno] as int,
      mcpvrefno:  map[TablesColumnFile.mcpvrefno] as int,
      trefno:  map[TablesColumnFile.trefno] as int,
      mrefno:  map[TablesColumnFile.mrefno] as int,
      maddmatch: map[TablesColumnFile.maddmatch] as String,
      massetvissibledesc: map[TablesColumnFile.massetvissibledesc] as String,
      myrsmovdin: map[TablesColumnFile.myrsmovdin] as String,
      mhouseprptystatus:  map[TablesColumnFile.mhouseprptystatus] as String,
      mhousestructure: map[TablesColumnFile.mhousestructure] as String,
      mhousewall:  map[TablesColumnFile.mhousewall] as String,
      mhouseroof: map[TablesColumnFile.mhouseroof] as String,
      massetvissiblecode: map[TablesColumnFile.massetvissiblecode] as String,
     );}

}
