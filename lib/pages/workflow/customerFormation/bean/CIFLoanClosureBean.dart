import 'package:eco_mfi/db/TablesColumnFile.dart';

class CIFLoanClosureBean {

  String mprdacctid;
  String mentrydate;
  String mloandetailsgrid;
  String mapplicationdt;
  String mappliedamt;
  String mapproveddt;
  String mapprovedamt;
  String mstartdt;
  String mdisbursementdt;
  String mdisbursementamt;
  String minstallmentstartdt;
  String minstallmentamt;
  String minstallmentfrequency;
  String mnoofinstallments;
  String mrateofinterest;
  String menddt;
  String minsurancepremiumamt;
  String msecuritydetailsgrid;
  String msecuritydepositdt;
  String mamtondepositcreation;
  String mcurrentbal;
  String mexcessbal;
  String mclosuredetailsgrid;
  String minterestaccruedtilldt;
  String mclosurecharges;
  String mclosureamtasondate;
  String mwaiveoffamt;
  String mamttobepaidforclosure;
  String mtotaloutstandinggrid;
  String mprincipalos;
  String minterestos;
  String mpenalos;
  String motherchargesos;
  String mtotaloutstanding;
  String mtotalpaymentgrid;
  String mprincipalpaid;
  String minterestpaid;
  String mpenalpaid;
  String motherchargespaid;
  String mnoofinslpaid;
  String mnoofdefaults;
  String mtotalpaid;
  String mduebutnotpaidgrid;
  String mprincipalosdue;
  String minterestosdue;
  String mpenalosdue;
  String motherchargesosdue;
  String mtotaldue;
  String mremark;
  int mpaymntmode;
  String merror;
  String momnimsg;
  int mlbrcode;


  CIFLoanClosureBean({this.mprdacctid, this.mentrydate, this.mloandetailsgrid,
    this.mapplicationdt, this.mappliedamt, this.mapproveddt,
    this.mapprovedamt, this.mstartdt, this.mdisbursementdt,
    this.mdisbursementamt, this.minstallmentstartdt, this.minstallmentamt,
    this.minstallmentfrequency, this.mnoofinstallments, this.mrateofinterest,
    this.menddt, this.minsurancepremiumamt, this.msecuritydetailsgrid,
    this.msecuritydepositdt, this.mamtondepositcreation, this.mcurrentbal,
    this.mexcessbal, this.mclosuredetailsgrid, this.minterestaccruedtilldt,
    this.mclosurecharges, this.mclosureamtasondate, this.mwaiveoffamt,
    this.mamttobepaidforclosure, this.mtotaloutstandinggrid,
    this.mprincipalos, this.minterestos, this.mpenalos, this.motherchargesos,
    this.mtotaloutstanding, this.mtotalpaymentgrid, this.mprincipalpaid,
    this.minterestpaid, this.mpenalpaid, this.motherchargespaid,
    this.mnoofinslpaid, this.mnoofdefaults, this.mtotalpaid,
    this.mduebutnotpaidgrid, this.mprincipalosdue, this.minterestosdue,
    this.mpenalosdue, this.motherchargesosdue, this.mtotaldue, this.mremark,
    this.mpaymntmode,this.merror,this.momnimsg,this.mlbrcode});


  @override
  String toString() {
    return 'CIFLoanClosureBean{mprdacctid: $mprdacctid, mentrydate: $mentrydate, mloandetailsgrid: $mloandetailsgrid, mapplicationdt: $mapplicationdt, mappliedamt: $mappliedamt, mapproveddt: $mapproveddt, mapprovedamt: $mapprovedamt, mstartdt: $mstartdt, mdisbursementdt: $mdisbursementdt, mdisbursementamt: $mdisbursementamt, minstallmentstartdt: $minstallmentstartdt, minstallmentamt: $minstallmentamt, minstallmentfrequency: $minstallmentfrequency, mnoofinstallments: $mnoofinstallments, mrateofinterest: $mrateofinterest, menddt: $menddt, minsurancepremiumamt: $minsurancepremiumamt, msecuritydetailsgrid: $msecuritydetailsgrid, msecuritydepositdt: $msecuritydepositdt, mamtondepositcreation: $mamtondepositcreation, mcurrentbal: $mcurrentbal, mexcessbal: $mexcessbal, mclosuredetailsgrid: $mclosuredetailsgrid, minterestaccruedtilldt: $minterestaccruedtilldt, mclosurecharges: $mclosurecharges, mclosureamtasondate: $mclosureamtasondate, mwaiveoffamt: $mwaiveoffamt, mamttobepaidforclosure: $mamttobepaidforclosure, mtotaloutstandinggrid: $mtotaloutstandinggrid, mprincipalos: $mprincipalos, minterestos: $minterestos, mpenalos: $mpenalos, motherchargesos: $motherchargesos, mtotaloutstanding: $mtotaloutstanding, mtotalpaymentgrid: $mtotalpaymentgrid, mprincipalpaid: $mprincipalpaid, minterestpaid: $minterestpaid, mpenalpaid: $mpenalpaid, motherchargespaid: $motherchargespaid, mnoofinslpaid: $mnoofinslpaid, mnoofdefaults: $mnoofdefaults, mtotalpaid: $mtotalpaid, mduebutnotpaidgrid: $mduebutnotpaidgrid, mprincipalosdue: $mprincipalosdue, minterestosdue: $minterestosdue, mpenalosdue: $mpenalosdue, motherchargesosdue: $motherchargesosdue, mtotaldue: $mtotaldue, mremark: $mremark, mpaymntmode: $mpaymntmode, merror: $merror, momnimsg: $momnimsg, mlbrcode: $mlbrcode}';
  }

  factory CIFLoanClosureBean.fromMap(Map<String, dynamic> map) {
    print(map);
    return CIFLoanClosureBean(
      mprdacctid: map[TablesColumnFile.mprdacctid] as String,
      mentrydate: map[TablesColumnFile.mentrydate] as String,
      mloandetailsgrid: map[TablesColumnFile.mloandetailsgrid] as String,
      mapplicationdt: map[TablesColumnFile.mapplicationdt] as String,
      mappliedamt: map[TablesColumnFile.mappliedamt] as String,
      mapproveddt: map[TablesColumnFile.mapproveddt] as String,
      mapprovedamt: map[TablesColumnFile.mapprovedamt] as String,
      mstartdt: map[TablesColumnFile.mstartdt] as String,
      mdisbursementdt: map[TablesColumnFile.mdisbursementdt] as String,
      mdisbursementamt: map[TablesColumnFile.mdisbursementamt] as String,
      minstallmentstartdt: map[TablesColumnFile.minstallmentstartdt] as String,
      minstallmentamt: map[TablesColumnFile.minstallmentamt] as String,
      minstallmentfrequency: map[TablesColumnFile.minstallmentfrequency] as String,
      mnoofinstallments: map[TablesColumnFile.mnoofinstallments] as String,
      mrateofinterest: map[TablesColumnFile.mrateofinterest] as String,
      menddt: map[TablesColumnFile.menddt] as String,
      minsurancepremiumamt: map[TablesColumnFile.minsurancepremiumamt] as String,
      msecuritydetailsgrid: map[TablesColumnFile.msecuritydetailsgrid] as String,
      msecuritydepositdt: map[TablesColumnFile.msecuritydepositdt] as String,
      mamtondepositcreation: map[TablesColumnFile.mamtondepositcreation] as String,
      mcurrentbal: map[TablesColumnFile.mcurrentbal] as String,
      mexcessbal: map[TablesColumnFile.mexcessbal] as String,
      mclosuredetailsgrid: map[TablesColumnFile.mclosuredetailsgrid] as String,
      minterestaccruedtilldt: map[TablesColumnFile.minterestaccruedtilldt] as String,
      mclosurecharges: map[TablesColumnFile.mclosurecharges] as String,
      mclosureamtasondate: map[TablesColumnFile.mclosureamtasondate] as String,
      mwaiveoffamt: map[TablesColumnFile.mwaiveoffamt] as String,
      mamttobepaidforclosure: map[TablesColumnFile.mamttobepaidforclosure] as String,
      mtotaloutstandinggrid: map[TablesColumnFile.mtotaloutstandinggrid] as String,
      mprincipalos: map[TablesColumnFile.mprincipalos] as String,
      minterestos: map[TablesColumnFile.minterestos] as String,
      mpenalos: map[TablesColumnFile.mpenalos] as String,
      motherchargesos: map[TablesColumnFile.motherchargesos] as String,
      mtotaloutstanding: map[TablesColumnFile.mtotaloutstanding] as String,
      mtotalpaymentgrid: map[TablesColumnFile.mtotalpaymentgrid] as String,
      mprincipalpaid: map[TablesColumnFile.mprincipalpaid] as String,
      minterestpaid: map[TablesColumnFile.minterestpaid] as String,
      mpenalpaid: map[TablesColumnFile.mpenalpaid] as String,
      motherchargespaid: map[TablesColumnFile.motherchargespaid] as String,
      mnoofinslpaid: map[TablesColumnFile.mnoofinslpaid] as String,
      mnoofdefaults: map[TablesColumnFile.mnoofdefaults] as String,
      mtotalpaid: map[TablesColumnFile.mtotalpaid] as String,
      mduebutnotpaidgrid: map[TablesColumnFile.mduebutnotpaidgrid] as String,
      mprincipalosdue: map[TablesColumnFile.mprincipalosdue] as String,
      minterestosdue: map[TablesColumnFile.minterestosdue] as String,
      mpenalosdue: map[TablesColumnFile.mpenalosdue] as String,
      motherchargesosdue: map[TablesColumnFile.motherchargesosdue] as String,
      mtotaldue: map[TablesColumnFile.mtotaldue] as String,
      mremark: map[TablesColumnFile.mremark] as String,
      mpaymntmode: map[TablesColumnFile.mpaymntmode] as int,
      merror: map[TablesColumnFile.merror] as String,
      momnimsg : map[TablesColumnFile.momnimsg] as String,
      mlbrcode: map[TablesColumnFile.mlbrcode] as int,
    );
  }

  factory CIFLoanClosureBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware){
    return CIFLoanClosureBean(
      mprdacctid: map[TablesColumnFile.mprdacctid] as String,
      mentrydate: map[TablesColumnFile.mentrydate] as String,
      mloandetailsgrid: map[TablesColumnFile.mloandetailsgrid] as String,
      mapplicationdt: map[TablesColumnFile.mapplicationdt] as String,
      mappliedamt: map[TablesColumnFile.mappliedamt] as String,
      mapproveddt: map[TablesColumnFile.mapproveddt] as String,
      mapprovedamt: map[TablesColumnFile.mapprovedamt] as String,
      mstartdt: map[TablesColumnFile.mstartdt] as String,
      mdisbursementdt: map[TablesColumnFile.mdisbursementdt] as String,
      mdisbursementamt: map[TablesColumnFile.mdisbursementamt] as String,
      minstallmentstartdt: map[TablesColumnFile.minstallmentstartdt] as String,
      minstallmentamt: map[TablesColumnFile.minstallmentamt] as String,
      minstallmentfrequency: map[TablesColumnFile.minstallmentfrequency] as String,
      mnoofinstallments: map[TablesColumnFile.mnoofinstallments] as String,
      mrateofinterest: map[TablesColumnFile.mrateofinterest] as String,
      menddt: map[TablesColumnFile.menddt] as String,
      minsurancepremiumamt: map[TablesColumnFile.minsurancepremiumamt] as String,
      msecuritydetailsgrid: map[TablesColumnFile.msecuritydetailsgrid] as String,
      msecuritydepositdt: map[TablesColumnFile.msecuritydepositdt] as String,
      mamtondepositcreation: map[TablesColumnFile.mamtondepositcreation] as String,
      mcurrentbal: map[TablesColumnFile.mcurrentbal] as String,
      mexcessbal: map[TablesColumnFile.mexcessbal] as String,
      mclosuredetailsgrid: map[TablesColumnFile.mclosuredetailsgrid] as String,
      minterestaccruedtilldt: map[TablesColumnFile.minterestaccruedtilldt] as String,
      mclosurecharges: map[TablesColumnFile.mclosurecharges] as String,
      mclosureamtasondate: map[TablesColumnFile.mclosureamtasondate] as String,
      mwaiveoffamt: map[TablesColumnFile.mwaiveoffamt] as String,
      mamttobepaidforclosure: map[TablesColumnFile.mamttobepaidforclosure] as String,
      mtotaloutstandinggrid: map[TablesColumnFile.mtotaloutstandinggrid] as String,
      mprincipalos: map[TablesColumnFile.mprincipalos] as String,
      minterestos: map[TablesColumnFile.minterestos] as String,
      mpenalos: map[TablesColumnFile.mpenalos] as String,
      motherchargesos: map[TablesColumnFile.motherchargesos] as String,
      mtotaloutstanding: map[TablesColumnFile.mtotaloutstanding] as String,
      mtotalpaymentgrid: map[TablesColumnFile.mtotalpaymentgrid] as String,
      mprincipalpaid: map[TablesColumnFile.mprincipalpaid] as String,
      minterestpaid: map[TablesColumnFile.minterestpaid] as String,
      mpenalpaid: map[TablesColumnFile.mpenalpaid] as String,
      motherchargespaid: map[TablesColumnFile.motherchargespaid] as String,
      mnoofinslpaid: map[TablesColumnFile.mnoofinslpaid] as String,
      mnoofdefaults: map[TablesColumnFile.mnoofdefaults] as String,
      mtotalpaid: map[TablesColumnFile.mtotalpaid] as String,
      mduebutnotpaidgrid: map[TablesColumnFile.mduebutnotpaidgrid] as String,
      mprincipalosdue: map[TablesColumnFile.mprincipalosdue] as String,
      minterestosdue: map[TablesColumnFile.minterestosdue] as String,
      mpenalosdue: map[TablesColumnFile.mpenalosdue] as String,
      motherchargesosdue: map[TablesColumnFile.motherchargesosdue] as String,
      mtotaldue: map[TablesColumnFile.mtotaldue] as String,
      mremark: map[TablesColumnFile.mremark] as String,
      mpaymntmode: map[TablesColumnFile.mpaymntmode] as int,
      merror: map[TablesColumnFile.merror] as String,
      momnimsg : map[TablesColumnFile.momnimsg] as String,
      mlbrcode: map[TablesColumnFile.mlbrcode] as int,
    );}
}
