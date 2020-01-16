import 'package:eco_mfi/db/TablesColumnFile.dart';
class   MiniStatementBean {





  int mlbrcode;
  String mprdacctid;
  String mlongname;
  String mbramchname;
  String mparticulars;
  double mlcytrnamt;
  double macttotballcy;
  double mtotallienfcy;
  String mentrydate;
  String mdrcr;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;




  MiniStatementBean(
      {

        this.mlbrcode,
        this.mprdacctid,
        this.mlongname,
        this.mbramchname,
        this.mparticulars,
        this.macttotballcy,
        this.mtotallienfcy,
        this.mlcytrnamt,
        this.mentrydate,
        this.mdrcr,
        this.mgeolocation,
        this.mgeolatd,
        this.mgeologd,
      });


  @override
  String toString() {
    return 'MiniStatementBean{mlbrcode: $mlbrcode, mprdacctid: $mprdacctid, mlongname: $mlongname, mbramchname: $mbramchname, mparticulars: $mparticulars, mlcytrnamt: $mlcytrnamt, macttotballcy: $macttotballcy, mtotallienfcy: $mtotallienfcy, mentrydate: $mentrydate, mdrcr: $mdrcr, mgeolocation: $mgeolocation, mgeolatd: $mgeolatd, mgeologd: $mgeologd}';
  }

  factory MiniStatementBean.fromMap(Map<String, dynamic> map) {
    print(map);
    return MiniStatementBean(

      mlbrcode:map[TablesColumnFile.mlbrcode] as int,
      mprdacctid:map[TablesColumnFile.mprdacctid] as String,
      mlongname:map[TablesColumnFile.mlongname] as String,
      mbramchname:map[TablesColumnFile.mbramchname] as String,
      mparticulars:map[TablesColumnFile.mparticulars] as String,
      macttotballcy:map[TablesColumnFile.macttotballcy] as double,
      mtotallienfcy:map[TablesColumnFile.mtotallienfcy] as double,
      mlcytrnamt:map[TablesColumnFile.mlcytrnamt] as double,
      mentrydate:map[TablesColumnFile.mentrydate] as String,
      mdrcr:map[TablesColumnFile.mdrcr] as String,
      mgeolocation:map[TablesColumnFile.mgeolocation] as String,
      mgeolatd:map[TablesColumnFile.mgeolatd] as String,
      mgeologd:map[TablesColumnFile.mgeologd] as String,



    );
  }
  factory MiniStatementBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware){
    print("fromMap");

    return MiniStatementBean(

      mlbrcode:map[TablesColumnFile.mlbrcode] as int,
      mprdacctid:map[TablesColumnFile.mprdacctid] as String,
      mlongname:map[TablesColumnFile.mlongname] as String,
      mbramchname:map[TablesColumnFile.mbramchname] as String,
      mparticulars:map[TablesColumnFile.mparticulars] as String,
      macttotballcy:map[TablesColumnFile.macttotballcy] as double,
      mtotallienfcy:map[TablesColumnFile.mtotallienfcy] as double,
      mlcytrnamt:map[TablesColumnFile.mlcytrnamt] as double,
      mentrydate:map[TablesColumnFile.mentrydate] as String,
      mdrcr:map[TablesColumnFile.mdrcr] as String,
      mgeolocation:map[TablesColumnFile.mgeolocation] as String,
      mgeolatd:map[TablesColumnFile.mgeolatd] as String,
      mgeologd:map[TablesColumnFile.mgeologd] as String,

    );}

}
