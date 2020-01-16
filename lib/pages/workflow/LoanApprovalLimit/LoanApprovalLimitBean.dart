

import 'package:eco_mfi/db/TablesColumnFile.dart';

class LoanApprovalLimitBean {


  final int mlbrcode;
  final int mgrpcd;
  final String musercode;
  final int msrno;
  final String mprdcd;

  final double mlimitamt;
  final int moverduedays;
  final double mloanacmindrbal;
  final double mloanacmincrbal;
  final double mwriteoffamat;
  final String mremarks;
  final double mcheqlimitamt;
  final double mminintrate;
  final double mmaxintrate;
  LoanApprovalLimitComposite loanApprovalLimitComposite;

  LoanApprovalLimitBean(
      {
        this.mlbrcode,
        this.mgrpcd,
        this.musercode,
        this.msrno,
        this.mprdcd,
        this.mlimitamt,
        this.moverduedays,
        this.mloanacmindrbal,
        this.mloanacmincrbal,
        this.mwriteoffamat,
        this.mremarks,
        this.mcheqlimitamt,
        this.mminintrate,
        this.mmaxintrate,
        this.loanApprovalLimitComposite


      });
  factory LoanApprovalLimitBean.fromMap(Map<String, dynamic> map) {
    return LoanApprovalLimitBean(
        mlbrcode:map[TablesColumnFile.mlbrcode] as int,
        mgrpcd:map[TablesColumnFile.mgrpcd] as int,
        musercode:map[TablesColumnFile.musercode] as String,
        msrno:map[TablesColumnFile.msrno] as int,
        mprdcd:map[TablesColumnFile.mprdcd] as String,
        mlimitamt:map[TablesColumnFile.mlimitamt] as double,
        moverduedays:map[TablesColumnFile.moverduedays] as int,
        mloanacmindrbal:map[TablesColumnFile.mloanacmindrbal] as double,
        mloanacmincrbal:map[TablesColumnFile.mlimitamt] as double,
        mwriteoffamat:map[TablesColumnFile.mwriteoffamat] as double,
        mremarks:map[TablesColumnFile.mruletype] as String,
        mcheqlimitamt:map[TablesColumnFile.msrno] as double,
        mminintrate:map[TablesColumnFile.muptoamount] as double,
        mmaxintrate:map[TablesColumnFile.mminamount] as double,
        loanApprovalLimitComposite: LoanApprovalLimitComposite.fromJson(map[TablesColumnFile.loanApprovalLimitComposite])


    );
  }

  factory LoanApprovalLimitBean.fromLocalDb(Map<String, dynamic> map) {
    print("map of seconfdary amt "+ map.toString());
    return LoanApprovalLimitBean(
      mlbrcode:map[TablesColumnFile.mlbrcode] as int,
      mgrpcd:map[TablesColumnFile.mgrpcd] as int,
      musercode:map[TablesColumnFile.musercode] as String,
      msrno:map[TablesColumnFile.msrno] as int,
      mprdcd:map[TablesColumnFile.mprdcd] as String,
      mlimitamt:map[TablesColumnFile.mlimitamt] as double,
      moverduedays:map[TablesColumnFile.moverduedays] as int,
      mloanacmindrbal:map[TablesColumnFile.mloanacmindrbal] as double,
      mloanacmincrbal:map[TablesColumnFile.mlimitamt] as double,
      mwriteoffamat:map[TablesColumnFile.mwriteoffamat] as double,
      mremarks:map[TablesColumnFile.mruletype] as String,
      mcheqlimitamt:map[TablesColumnFile.mcheqlimitamt] as double,
      mminintrate:map[TablesColumnFile.mminintrate] as double,
      mmaxintrate:map[TablesColumnFile.mmaxintrate] as double,
    );}

  static fromJson(list) {}
}


class LoanApprovalLimitComposite {
  final int mlbrcode;
  final int mgrpcd;
  final String musercode;
  final int msrno;

  LoanApprovalLimitComposite({
    this.mlbrcode,
    this.mgrpcd,
    this.musercode,
    this.msrno,

  });

  factory LoanApprovalLimitComposite.fromJson(
      Map<String, dynamic> map) {

    return LoanApprovalLimitComposite(
        mlbrcode: map[TablesColumnFile.mlbrcode] as int,
        mgrpcd: map[TablesColumnFile.mgrpcd] as int,
        musercode: map[TablesColumnFile.musercode] as String,
        msrno: map[TablesColumnFile.msrno] as int,

    );
  }




}