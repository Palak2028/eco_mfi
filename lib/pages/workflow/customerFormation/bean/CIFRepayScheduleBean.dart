import 'package:eco_mfi/db/TablesColumnFile.dart';

class CIFRepayScheduleBean {


  String mprdacctid;
  int msrno;
  String mwsenddate;
  double mwseffcontractamt;
  double mwsintamount;
  double mwsidealbal;
  double mwsopenbal;

  CIFRepayScheduleBean({
    this.mprdacctid, this.msrno, this.mwsenddate,this.mwseffcontractamt, this.mwsintamount, this.mwsidealbal, this.mwsopenbal
  }  );


  @override
  String toString() {
    return 'CIFRepayScheduleBean{mprdacctid: $mprdacctid, msrno: $msrno, mwsenddate: $mwsenddate, mwseffcontractamt: $mwseffcontractamt, mwsintamount: $mwsintamount, mwsidealbal: $mwsidealbal, mwsopenbal: $mwsopenbal}';
  }

  factory CIFRepayScheduleBean.fromMap(Map<String, dynamic> map) {
    print(map);
    return CIFRepayScheduleBean(
        mprdacctid: map[TablesColumnFile.mprdacctid] as String,
        msrno:map[TablesColumnFile.msrno] as int,
        mwsenddate:map[TablesColumnFile.mwsenddate] as String,
        mwseffcontractamt: map[TablesColumnFile.mwseffcontractamt] as double,
        mwsintamount: map[TablesColumnFile.mwsintamount] as double,
        mwsidealbal: map[TablesColumnFile.mwsidealbal] as double,
        mwsopenbal: map[TablesColumnFile.mwsopenbal] as double,

    );
  }

  factory CIFRepayScheduleBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware){
    return CIFRepayScheduleBean(
      mprdacctid: map[TablesColumnFile.mprdacctid] as String,
      msrno:map[TablesColumnFile.msrno] as int,
      mwsenddate:map[TablesColumnFile.mwsenddate] as String,
      mwseffcontractamt: map[TablesColumnFile.mwseffcontractamt] as double,
      mwsintamount: map[TablesColumnFile.mwsintamount] as double,
      mwsidealbal: map[TablesColumnFile.mwsidealbal] as double,
      mwsopenbal: map[TablesColumnFile.mwsopenbal] as double,

    );}
}
