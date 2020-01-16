import 'package:eco_mfi/db/TablesColumnFile.dart';

class LoanUtilizationBean {
  int mcustno;
  String mcustname;
  int mgroupcd;
  int mcenterid;
  String mpurposeofloan;
  String mprdacctid;
  String mactualutilization;
  DateTime mcreateddt;
  DateTime mlastupdatedt;
  String musrname;
  String mremarks;

  LoanUtilizationBean(
      {this.mcustno,
        this.mcustname,
        this.mgroupcd,
        this.mcenterid,
        this.mpurposeofloan,
        this.mprdacctid,
        this.mactualutilization,
        this.mcreateddt,
        this.mlastupdatedt,
        this.musrname,
        this.mremarks
        });

  factory LoanUtilizationBean.fromMap(Map<String, dynamic> map) {
    print("inside for map");
    return LoanUtilizationBean(
        mcustno:	map[TablesColumnFile.mcustno] as int,
      mcustname:	map[TablesColumnFile.mcustname] as String,
      mgroupcd:	map[TablesColumnFile.mgroupcd] as int,
      mcenterid:	map[TablesColumnFile.mcenterid] as int,
      mpurposeofloan:	map[TablesColumnFile.mpurposeofLoan] as String,
        mprdacctid:	map[TablesColumnFile.mprdacctid] as String,
      mactualutilization:	map[TablesColumnFile.mactualutilization] as String,
      mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      musrname:	map[TablesColumnFile.musrname] as String,
      mremarks:	map[TablesColumnFile.mremarks] as String


    );

  }
  factory LoanUtilizationBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap");
    return LoanUtilizationBean(
        mcustno:	map[TablesColumnFile.mcustno] as int,
      mcustname:	map[TablesColumnFile.mcustname] as String,
      mgroupcd:	map[TablesColumnFile.mgroupcd] as int,
      mcenterid:	map[TablesColumnFile.mcenterid] as int,
      mpurposeofloan:	map[TablesColumnFile.mpurposeofLoan] as String,
        mprdacctid:	map[TablesColumnFile.mprdacctid] as String,
      mactualutilization:	map[TablesColumnFile.mactualutilization] as String,
      mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      musrname:	map[TablesColumnFile.musrname] as String,
      mremarks:	map[TablesColumnFile.mremarks] as String
        
    );
  }

}

