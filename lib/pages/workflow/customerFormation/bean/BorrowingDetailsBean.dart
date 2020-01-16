
import 'package:eco_mfi/db/TablesColumnFile.dart';

class BorrowingDetailsBean {

  int tborrowingrefno;
  //numeric(8)
  int trefno;
  //numeric(8)
  int mborrowingrefno;
  int mrefno;
  //numeric(8)
  int mcustno;
  //numeric(6)
  int  msrno;
  //NVarChar(50)
  String mnameofborrower;
  //NVarChar(50)
  String msource;
  //NVarChar(50)
  String mpurpose;
  double mamount;
  double mintrate;
  double memiamt;
  double moutstandingamt;
  //NVarChar(30)
  String mmemberno;
  //numeric(2)
  int mloancycle;
  DateTime mloanDate;
  DateTime mrepaymentDate;
  String mloanwthUs;

  BorrowingDetailsBean(
      {  this.tborrowingrefno,
        this.trefno,
        this.mborrowingrefno,
        this.mrefno,
        this.mcustno,
        this. msrno,
        this.mnameofborrower,
        this.msource,
        this.mpurpose,
        this.mamount,
        this.mintrate,
        this.memiamt,
        this.moutstandingamt,
        this.mmemberno,
        this.mloancycle,
      this.mloanDate,
      this.mloanwthUs,
      this.mrepaymentDate});


  factory BorrowingDetailsBean.fromMap(Map<String, dynamic> map) {
    print("inside Borrowing Details map");
    print(map);
    return BorrowingDetailsBean(
        trefno: 	 map[TablesColumnFile.trefno] as int,
        mrefno: 	 map[TablesColumnFile.mrefno]!=null&&map[TablesColumnFile.mrefno]!='null'?map[TablesColumnFile.mrefno] as int:null,
        tborrowingrefno: 	 map[TablesColumnFile.tborrowingrefno] as int,
        mborrowingrefno: 	 map[TablesColumnFile.mborrowingrefno] as int,
        mcustno:	 map[TablesColumnFile.mcustno] as int,
        mnameofborrower:	 map[TablesColumnFile.mnameofborrower] as String,
        msource:	 map[TablesColumnFile.msource] as String,
        mpurpose:	 map[TablesColumnFile.mpurpose] as String,
        mamount:	 map[TablesColumnFile.mamount] as double,
        mintrate:	 map[TablesColumnFile.mintrate] as double,
        memiamt:	 map[TablesColumnFile.memiamt] as double,
        moutstandingamt:	 map[TablesColumnFile.moutstandingamt] as double,
        mmemberno:	 map[TablesColumnFile.mmemberno] as String,
        mloancycle:	 map[TablesColumnFile.mloancycle] as int,
        mloanDate:(map[TablesColumnFile.mloanDate]=="null"||map[TablesColumnFile.mloanDate]==null)?null:DateTime.parse(map[TablesColumnFile.mloanDate]) as DateTime,
        mrepaymentDate:(map[TablesColumnFile.mrepaymentDate]=="null"||map[TablesColumnFile.mrepaymentDate]==null)?null:DateTime.parse(map[TablesColumnFile.mrepaymentDate]) as DateTime,
        mloanwthUs:	 map[TablesColumnFile.mloanwthUs] as String,

    );
  }
}
