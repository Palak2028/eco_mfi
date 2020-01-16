import 'package:eco_mfi/db/TablesColumnFile.dart';

class BulkLoanPreClosureBean {

  String mcentername;
  int mcenterid;
  String mgroupname;
  int mgroupcd;
  int mcustno;
  String mcustname;
  String mprdacctid;
  String minststartdt;
  double mexcessamt;
  double minstlamt;
  double mamttocollect;
  double mprincipleos;
  double minterestos;
  int issubmit;
  String mremarks;
  double mcollamt;
  String momnimsg;
  int mlbrcode;


  BulkLoanPreClosureBean({this.mcentername, this.mcenterid, this.mgroupname,
      this.mgroupcd, this.mcustno, this.mcustname, this.mprdacctid,
      this.minststartdt, this.mexcessamt, this.minstlamt, this.mamttocollect,
      this.mprincipleos, this.minterestos, this.issubmit, this.mremarks,this.mcollamt,this.momnimsg});


  @override
  String toString() {
    return 'BulkLoanPreClosureBean{mcentername: $mcentername, mcenterid: $mcenterid, mgroupname: $mgroupname, mgroupcd: $mgroupcd, mcustno: $mcustno, mcustname: $mcustname, mprdacctid: $mprdacctid, minststartdt: $minststartdt, mexcessamt: $mexcessamt, minstlamt: $minstlamt, mamttocollect: $mamttocollect, mprincipleos: $mprincipleos, minterestos: $minterestos, issubmit: $issubmit, mremarks: $mremarks, mcollamt: $mcollamt, momnimsg: $momnimsg}';
  }

  factory BulkLoanPreClosureBean.fromMap(Map<String, dynamic> map) {
    print(map);
    return BulkLoanPreClosureBean(
      mcentername: map[TablesColumnFile.mcentername] as String,
      mcenterid: map[TablesColumnFile.mcenterid] as int,
      mgroupname: map[TablesColumnFile.mgroupname] as String,
      mgroupcd: map[TablesColumnFile.mgroupcd] as int,
      mcustno: map[TablesColumnFile.mcustno] as int,
      mcustname:map[TablesColumnFile.mcustname] as String,
      mprdacctid: map[TablesColumnFile.mprdacctid] as String,
      minststartdt:map[TablesColumnFile.minststartdt] as String,
      mexcessamt:map[TablesColumnFile.mexcessamt] as double,
      minstlamt:map[TablesColumnFile.minstlamt] as double,
      mamttocollect: map[TablesColumnFile.mamttocollect] as double,
      mprincipleos: map[TablesColumnFile.mprincipleos] as double,
      minterestos: map[TablesColumnFile.minterestos] as double,
      issubmit: map[TablesColumnFile.issubmit] as int,
      mremarks:map[TablesColumnFile.mremarks] as String,
      mcollamt: map[TablesColumnFile.mcollamt] as double,
      momnimsg:map[TablesColumnFile.momnimsg] as String,
    );
  }

  factory BulkLoanPreClosureBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware){
    print("fromMapMiddleware");
    return BulkLoanPreClosureBean(
      mcentername: map[TablesColumnFile.mcentername] as String,
      mcenterid: map[TablesColumnFile.mcenterid] as int,
      mgroupname: map[TablesColumnFile.mgroupname] as String,
      mgroupcd: map[TablesColumnFile.mgroupcd] as int,
      mcustno: map[TablesColumnFile.mcustno] as int,
      mcustname:map[TablesColumnFile.mcustname] as String,
      mprdacctid: map[TablesColumnFile.mprdacctid] as String,
      minststartdt:map[TablesColumnFile.minststartdt] as String,
      mexcessamt:map[TablesColumnFile.mexcessamt] as double,
      minstlamt:map[TablesColumnFile.minstlamt] as double,
      mamttocollect: map[TablesColumnFile.mamttocollect] as double,
      mprincipleos: map[TablesColumnFile.mprincipleos] as double,
      minterestos: map[TablesColumnFile.minterestos] as double,
      issubmit: map[TablesColumnFile.issubmit] as int,
      mremarks:map[TablesColumnFile.mremarks] as String,
      mcollamt: map[TablesColumnFile.mcollamt] as double,
      momnimsg:map[TablesColumnFile.momnimsg] as String,
    );}
}
