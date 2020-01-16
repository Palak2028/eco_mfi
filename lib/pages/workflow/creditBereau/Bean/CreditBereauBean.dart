import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CbResultBean.dart';

class CreditBereauBean {


  int  trefno;
 int mrefno;
 int mlbrcode;
 int mqueueno;
 DateTime mprospectdt;
 String mnametitle;
 String mprospectname;
 int mmobno;
 DateTime mdob;
  int motpverified;
 String mcbcheckstatus;
 int mprospectstatus;
 String madd1;
 String madd2;
 String madd3;
 String mhomeloc;
 int mareacd;
 String mvillage;
  int mdistcd;
 String mstatecd;
 String mcountrycd;
 int  mpincode;
 String  mcountryoforigin;
 String mnationality;
 String mpanno;
 String  mpannodesc;

 int  misuploaded;
 String mspousename;
 String mspouserelation;
 String  mnomineename;
 String mnomineerelation;
 String  mcreditenqpurposetype;
 String  mcreditequstage;
 DateTime  mcreditreporttransdatetype;
 String  mcreditreporttransid;
 String  mcreditrequesttype;
 DateTime mcreateddt;
 String  mcreatedby;
 DateTime   mlastupdatedt;
 String mlastupdateby;
 String mgeolocation;
 String mgeolatd;
 String mgeologd;
 int  missynctocoresys;
 DateTime mlastsynsdate;
 String mstreet;
 String mhouse;
 String mcity;
 String mstate;
 String mid1;
 String mid1desc;
 int  motp;
 String mroutedto;
 int miscustcreated;
  int mtier;
  int mcustno;
  DateTime mhighmarkchkdt;
  CbResultBean cbResultMasterDetails;
  List<CbResultBean> cbLoanDetails;




 CreditBereauBean({this.trefno, this.mrefno, this.mlbrcode, this.mqueueno, this.mprospectdt, this.mnametitle, this.mprospectname,
     this.mmobno, this.mdob, this.motpverified, this.mcbcheckstatus,
     this.mprospectstatus, this.madd1, this.madd2, this.madd3, this.mhomeloc,
     this.mareacd, this.mvillage, this.mdistcd, this.mstatecd, this.mcountrycd,
     this.mpincode, this.mcountryoforigin, this.mnationality, this.mpanno,
     this.mpannodesc,this.misuploaded, this.mspousename,
     this.mspouserelation, this.mnomineename, this.mnomineerelation,
     this.mcreditenqpurposetype, this.mcreditequstage,
     this.mcreditreporttransdatetype, this.mcreditreporttransid,
     this.mcreditrequesttype, this.mcreateddt, this.mcreatedby,
     this.mlastupdatedt, this.mlastupdateby, this.mgeolocation, this.mgeolatd,
     this.mgeologd, this.missynctocoresys, this.mlastsynsdate, this.mstreet, this.mhouse,
     this.mcity, this.mstate, this.mid1, this.mid1desc, this.motp,this.mroutedto,this.miscustcreated,
      this.cbResultMasterDetails,this.cbLoanDetails,this.mtier,this.mcustno,this.mhighmarkchkdt
 });


  @override
  String toString() {
    return 'CreditBereauBean{trefno: $trefno, mrefno: $mrefno, mlbrcode: $mlbrcode, '
        'mqueueno: $mqueueno, mprospectdt: $mprospectdt, mnametitle: $mnametitle, '
        'mprospectname: $mprospectname, mmobno: $mmobno, mdob: $mdob, motpverified: $motpverified,'
        ' mcbcheckstatus: $mcbcheckstatus, mprospectstatus: $mprospectstatus, '
        'madd1: $madd1, madd2: $madd2, madd3: $madd3, mhomeloc: $mhomeloc, '
        'mareacd: $mareacd, mvillage: $mvillage, mdistcd: $mdistcd, mstatecd: $mstatecd, '
        'mcountrycd: $mcountrycd, mpincode: $mpincode, mcountryoforigin: $mcountryoforigin, '
        'mnationality: $mnationality, mpanno: $mpanno, mpannodesc: $mpannodesc, '
        'misuploaded: $misuploaded, mspousename: $mspousename, mspouserelation: $mspouserelation, '
        'mnomineename: $mnomineename, mnomineerelation: $mnomineerelation, '
        'mcreditenqpurposetype: $mcreditenqpurposetype, mcreditequstage: $mcreditequstage, '
        'mcreditreporttransdatetype: $mcreditreporttransdatetype, mcreditreporttransid: $mcreditreporttransid, '
        'mcreditrequesttype: $mcreditrequesttype, mcreateddt: $mcreateddt, '
        'mcreatedby: $mcreatedby, mlastupdatedt: $mlastupdatedt, '
        'mlastupdateby: $mlastupdateby, mgeolocation: $mgeolocation, '
        'mgeolatd: $mgeolatd, mgeologd: $mgeologd, missynctocoresys: '
        '$missynctocoresys, mlastsynsdate: $mlastsynsdate, mstreet: $mstreet, '
        'mhouse: $mhouse, mcity: $mcity, mstate: $mstate, mid1: $mid1, '
        'mid1desc: $mid1desc, motp: $motp, mroutedto: $mroutedto, '
        'miscustcreated: $miscustcreated, mtier: $mtier, mcustno: $mcustno, '
        'mhighmarkchkdt: $mhighmarkchkdt, cbResultMasterDetails: $cbResultMasterDetails, cbLoanDetails: $cbLoanDetails}';
  }

  factory CreditBereauBean.fromMap(Map<String, dynamic> map) {
   for(var itmes in map.toString().split(",")){
   print(itmes);
   }
   print("inside map");
   return CreditBereauBean(


       trefno: map[TablesColumnFile.trefno] as int,
    mrefno: map[TablesColumnFile.mrefno] as int,
   mlbrcode: map[TablesColumnFile.mlbrcode] as int ,
   mqueueno: map[TablesColumnFile.mqueueno] as int,
   mprospectdt: map[TablesColumnFile.mprospectdt]=="null"||map[TablesColumnFile.mprospectdt]==null?null:DateTime.parse(map[TablesColumnFile.mprospectdt]) as DateTime ,
       mnametitle : map[TablesColumnFile.mnametitle] as String,
       mprospectname : map[TablesColumnFile.mprospectname] as String,
       mmobno : map[TablesColumnFile.mmobno] as int,
     motp:map[TablesColumnFile.motp] as  int,
     mdob : map[TablesColumnFile.mdob]=="null"||map[TablesColumnFile.mdob]==null?null:DateTime.parse(map[TablesColumnFile.mdob]) as DateTime  ,
       motpverified :map[TablesColumnFile.motpverified]==null?null: map[TablesColumnFile.motpverified] as int ,
       mcbcheckstatus : map[TablesColumnFile.mcbcheckstatus] as String,
       mprospectstatus : map[TablesColumnFile.mprospectstatus] as int ,
       madd1 : map[TablesColumnFile.maddr1] as String,
       madd2 : map[TablesColumnFile.maddr2] as String,
       madd3 : map[TablesColumnFile.maddr3] as String,
       mhomeloc : map[TablesColumnFile.mhomeloc] as String,
       mareacd :map[TablesColumnFile.mareacd] as  int,
       mvillage : map[TablesColumnFile.mvillage] as String ,
       mdistcd : map[TablesColumnFile.mdistcd] as  int,
       mcountrycd : map[TablesColumnFile.mcountrycd] as String ,
        mpincode : map[TablesColumnFile.mpincode] as  int ,
        mcountryoforigin : map[TablesColumnFile.mcountryoforigin] as String  ,
       mnationality : map[TablesColumnFile.mnationality] as  String,
       mpanno : map[TablesColumnFile.mpanno] as  String,
        mpannodesc : map[TablesColumnFile.mpannodesc] as  String,
        misuploaded :map[TablesColumnFile.misuploaded] as  int ,
       mspousename : map[TablesColumnFile.mspousename] as  String,
       mspouserelation : map[TablesColumnFile.mspouserelation] as  String,
        mnomineename : map[TablesColumnFile.mnomineename] as  String,
       mnomineerelation : map[TablesColumnFile.mnomineerelation] as  String,
        mcreditenqpurposetype : map[TablesColumnFile.mcreditenqpurposetype] as  String,
        mcreditequstage : map[TablesColumnFile.mcreditequstage] as  String,
        mcreditreporttransdatetype :  map[TablesColumnFile.mcreditreporttransdatetype]=="null"||map[TablesColumnFile.mcreditreporttransdatetype]==null?null:DateTime.parse(map[TablesColumnFile.mcreditreporttransdatetype]) as DateTime  ,
        mcreditreporttransid : map[TablesColumnFile.mcreditreporttransid] as  String,
        mcreditrequesttype : map[TablesColumnFile.mcreditrequesttype] as  String,
     mcreateddt : map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime  ,
        mcreatedby : map[TablesColumnFile.mcreatedby] as  String,
   mlastupdatedt : map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime  ,
     mlastupdateby : map[TablesColumnFile.mlastupdateby] as  String,
     mgeolocation : map[TablesColumnFile.mgeolocation] as  String,
     mgeolatd : map[TablesColumnFile.mgeolatd] as  String,
     mgeologd : map[TablesColumnFile.mgeologd] as  String,
     missynctocoresys : map[TablesColumnFile.missynctocoresys] as  int,
     mlastsynsdate :map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime  ,
       mstreet:map[TablesColumnFile.mstreet] as  String,
      mhouse:map[TablesColumnFile.mhouse] as  String,
      mcity:map[TablesColumnFile.mcity] as  String,
      mstate:map[TablesColumnFile.mstate] as  String,
      mid1:map[TablesColumnFile.mid1] as  String,
     mid1desc:map[TablesColumnFile.mid1desc] as  String,
     mroutedto:map[TablesColumnFile.mroutedto] as  String,
     miscustcreated:map[TablesColumnFile.miscustcreated] as  int,
     mtier:map[TablesColumnFile.mtier] as  int,
     mcustno: map[TablesColumnFile.mcustno] as int,
     mhighmarkchkdt: map[TablesColumnFile.mhighmarkchkdt]=="null"||map[TablesColumnFile.mhighmarkchkdt]==null?null:DateTime.parse(map[TablesColumnFile.mhighmarkchkdt]) as DateTime  ,




  );

}




  factory CreditBereauBean.fromMapFromMiddleware(Map<String, dynamic> map,boolFlow) {
    for(var itmes in map.toString().split(",")){
      print(itmes);
    }
    print("inside map");
    return CreditBereauBean(


      trefno: map[TablesColumnFile.trefno] as int,
      mrefno: map[TablesColumnFile.mrefno] as int,
      mlbrcode: map[TablesColumnFile.mlbrcode] as int ,
      mqueueno: map[TablesColumnFile.mqueueno] as int,
      mprospectdt: map[TablesColumnFile.mprospectdt]=="null"||map[TablesColumnFile.mprospectdt]==null?null:DateTime.parse(map[TablesColumnFile.mprospectdt]) as DateTime ,
      mnametitle : map[TablesColumnFile.mnametitle] as String,
      mprospectname : map[TablesColumnFile.mprospectname] as String,
      mmobno : int.parse(map[TablesColumnFile.mmobno]) as int,
      motp:map[TablesColumnFile.motp] as  int,
      mdob : map[TablesColumnFile.mdob]=="null"||map[TablesColumnFile.mdob]==null?null:DateTime.parse(map[TablesColumnFile.mdob]) as DateTime  ,
      motpverified :map[TablesColumnFile.motpverified]==null?null: map[TablesColumnFile.motpverified] as int ,
      mcbcheckstatus : map[TablesColumnFile.mcbcheckstatus] as String,
      mprospectstatus : map[TablesColumnFile.mprospectstatus] as int ,
      madd1 : map[TablesColumnFile.maddr1] as String,
      madd2 : map[TablesColumnFile.maddr2] as String,
      madd3 : map[TablesColumnFile.maddr3] as String,
      mhomeloc : map[TablesColumnFile.mhomeloc] as String,
      mareacd :map[TablesColumnFile.mareacd] as  int,
      mvillage : map[TablesColumnFile.mvillage] as String ,
      mdistcd : map[TablesColumnFile.mdistcd] as  int,
      mcountrycd : map[TablesColumnFile.mcountrycd] as String ,
      mpincode : map[TablesColumnFile.mpincode] as  int ,
      mcountryoforigin : map[TablesColumnFile.mcountryoforigin] as String  ,
      mnationality : map[TablesColumnFile.mnationality] as  String,
      mpanno : map[TablesColumnFile.mpanno] as  String,
      mpannodesc : map[TablesColumnFile.mpannodesc] as  String,
      misuploaded :map[TablesColumnFile.misuploaded] as  int ,
      mspousename : map[TablesColumnFile.mspousename] as  String,
      mspouserelation : map[TablesColumnFile.mspouserelation] as  String,
      mnomineename : map[TablesColumnFile.mnomineename] as  String,
      mnomineerelation : map[TablesColumnFile.mnomineerelation] as  String,
      mcreditenqpurposetype : map[TablesColumnFile.mcreditenqpurposetype] as  String,
      mcreditequstage : map[TablesColumnFile.mcreditequstage] as  String,
        mcreditreporttransdatetype :  map[TablesColumnFile.mcreditreporttransdatetype]=="null"||map[TablesColumnFile.mcreditreporttransdatetype]==null?null:DateTime.parse(map[TablesColumnFile.mcreditreporttransdatetype]) as DateTime  ,
      mcreditreporttransid : map[TablesColumnFile.mcreditreporttransid] as  String,
      mcreditrequesttype : map[TablesColumnFile.mcreditrequesttype] as  String,
      mcreateddt : map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime  ,
      mcreatedby : map[TablesColumnFile.mcreatedby] as  String,
      mlastupdatedt : map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime  ,
      mlastupdateby : map[TablesColumnFile.mlastupdateby] as  String,
      mgeolocation : map[TablesColumnFile.mgeolocation] as  String,
      mgeolatd : map[TablesColumnFile.mgeolatd] as  String,
      mgeologd : map[TablesColumnFile.mgeologd] as  String,
      missynctocoresys : map[TablesColumnFile.missynctocoresys] as  int,
      mlastsynsdate :map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime  ,
      mstreet:map[TablesColumnFile.mstreet] as  String,
      mhouse:map[TablesColumnFile.mhouse] as  String,
      mcity:map[TablesColumnFile.mcity] as  String,
      mstate:map[TablesColumnFile.mstate] as  String,
      mid1:map[TablesColumnFile.mid1] as  String,
      mid1desc:map[TablesColumnFile.mid1desc] as  String,
      mroutedto:map[TablesColumnFile.mroutedto] as  String,
      miscustcreated:map[TablesColumnFile.miscustcreated] as  int,
        mtier:map[TablesColumnFile.mtier] as  int,
        mcustno: map[TablesColumnFile.mcustno] as int,
        mhighmarkchkdt:map[TablesColumnFile.mhighmarkchkdt]=="null"||map[TablesColumnFile.mhighmarkchkdt]==null?null:DateTime.parse(map[TablesColumnFile.mhighmarkchkdt]) as DateTime    ,
      cbResultMasterDetails:map[TablesColumnFile.cbResultMasterDetails]==null?null:CbResultBean.mapFromMiddleware(map[TablesColumnFile.cbResultMasterDetails]),
      cbLoanDetails:map[TablesColumnFile.cbLoanDetails].map<CbResultBean>((i) => CbResultBean.mapFromMiddleware(i)).toList(),



    );

  }













  factory CreditBereauBean.fromJson(Map<String, dynamic> map) {

   return null;
  }


/*int adhaarNo;
  String aplicantName;
  int contactNo;
  String spouseName;
  String house;
  String street;
  String city;
  String state;
  int pinCode;
  DateTime DOB;
  String idType2;
  String id2;
  String nomineeName;
  String nomineeRelation;
  String branchId;
  String kendraId;
  String memberId;
  int queueNo;
  int segmentIdentifier;
  int allSaved;
  int isUploaded;
  int OTP;
  int OTPVerified;

  String creditRequestType;
  String creditReportTransctionId;
  String creditEnquiryPurposeType;
  String creditEquiryStage;
  String creditReportTransactionDateType;
  String agentUserName;
  int isDataSynced;
  String cbCheckStatus;
  String routedTo;
  String routedFrom;
  int prospectStatus;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  String updatedBy;
  CompositeProspectId compositeProspectId;
  List<CbResultBean> resultDetails;
  List<CbResultBean> loanDetails;



  CreditBereauBean(
      {this.adhaarNo,
      this.aplicantName,
      this.contactNo,
      this.spouseName,
      this.house,
      this.street,
      this.city,
      this.state,
      this.pinCode,
      this.DOB,
      this.idType2,
      this.id2,
      this.nomineeName,
      this.nomineeRelation,
      this.branchId,
      this.kendraId,
      this.memberId,
      this.queueNo,
      this.segmentIdentifier,
      this.allSaved,
      this.isUploaded,
      this.OTP,
      this.OTPVerified,
      this.creditRequestType,
      this.creditReportTransctionId,
      this.creditEnquiryPurposeType,
      this.creditEquiryStage,
      this.creditReportTransactionDateType,
      this.isDataSynced,
      this.agentUserName,
      this.cbCheckStatus,
      this.routedTo,
        this.routedFrom,
        this.prospectStatus,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.resultDetails,
        this.loanDetails,

        this.compositeProspectId

      });


  @override
  String toString() {
    return 'CreditBereauBean{adhaarNo: $adhaarNo, aplicantName: $aplicantName, contactNo: $contactNo, spouseName: $spouseName, house: $house, street: $street, city: $city, state: $state, pinCode: $pinCode, DOB: $DOB, idType2: $idType2, id2: $id2, nomineeName: $nomineeName, nomineeRelation: $nomineeRelation, branchId: $branchId, kendraId: $kendraId, memberId: $memberId, queueNo: $queueNo, segmentIdentifier: $segmentIdentifier, allSaved: $allSaved, isUploaded: $isUploaded, OTP: $OTP, OTPVerified: $OTPVerified, creditRequestType: $creditRequestType, creditReportTransctionId: $creditReportTransctionId, creditEnquiryPurposeType: $creditEnquiryPurposeType, creditEquiryStage: $creditEquiryStage, creditReportTransactionDateType: $creditReportTransactionDateType, agentUserName: $agentUserName, isDataSynced: $isDataSynced, cbCheckStatus: $cbCheckStatus, routedTo: $routedTo, routedFrom: $routedFrom, prospectStatus: $prospectStatus, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy}';
  }

  factory CreditBereauBean.fromMap(Map<String, dynamic> map) {
    print("inside map");
    return CreditBereauBean(


        adhaarNo: map[TablesColumnFile.adhaarNo] as int,


        aplicantName: map[TablesColumnFile.aplicantName] as String,
        spouseName: map[TablesColumnFile.spouseName] as String,
        house: map[TablesColumnFile.house] as String,
        contactNo: map[TablesColumnFile.contactNo] as int,
        city: map[TablesColumnFile.city] as String,
        street: map[TablesColumnFile.street] as String,
        state: map[TablesColumnFile.state] as String,
        pinCode: map[TablesColumnFile.pinCode] as int,
        idType2: map[TablesColumnFile.idType2] as String,
        id2: map[TablesColumnFile.id2] as String,
        queueNo: map[TablesColumnFile.queueNo] as int,
        DOB:map[TablesColumnFile.DOB]=="null"||map[TablesColumnFile.DOB]==null?null:DateTime.parse(map[TablesColumnFile.DOB]) as DateTime,
        nomineeName: map[TablesColumnFile.nomineeName] as String,
        nomineeRelation: map[TablesColumnFile.nomineeRelation] as String,
        branchId: map[TablesColumnFile.branchId] as String,
        kendraId: map[TablesColumnFile.kendraId] as String,
        memberId: map[TablesColumnFile.memberId] as String,
        segmentIdentifier: map[TablesColumnFile.segmentIdentifier] as int,
        allSaved: map[TablesColumnFile.allSaved] as int,
        isUploaded: map[TablesColumnFile.isUploaded] as int,
        OTP: map[TablesColumnFile.OTP] as int,
        OTPVerified: map[TablesColumnFile.OTPVerified] as int,
        creditRequestType: map[TablesColumnFile.creditRequestType] as String,
        creditReportTransctionId:
            map[TablesColumnFile.creditReportTransctionId] as String,
        creditEnquiryPurposeType:
            map[TablesColumnFile.creditEnquiryPurposeType] as String,
        creditEquiryStage: map[TablesColumnFile.creditEquiryStage] as String,
        creditReportTransactionDateType:
            map[TablesColumnFile.creditReportTransactionDateType] as String,
        agentUserName: map[TablesColumnFile.agentUserName] as String,
        isDataSynced: map[TablesColumnFile.isDataSynced] as int,
        cbCheckStatus: map[TablesColumnFile.cbCheckStatus] as String,
    routedTo: map[TablesColumnFile.routedTo] as String,
    routedFrom: map[TablesColumnFile.routedFrom] as String,
        prospectStatus: map[TablesColumnFile.prospectStatus] as int,

    createdAt: map[TablesColumnFile.createdAt]=="null"||map[TablesColumnFile.createdAt]==null?null:DateTime.parse(map[TablesColumnFile.createdAt]) as DateTime,
    updatedAt: map[TablesColumnFile.updatedAt]=="null"||map[TablesColumnFile.updatedAt]==null?null:DateTime.parse(map[TablesColumnFile.updatedAt]) as DateTime,
    createdBy: map[TablesColumnFile.createdBy] as String,
    updatedBy: map[TablesColumnFile.updatedBy] as String,
    );

  }

  factory CreditBereauBean.fromJson(Map<String, dynamic> map) {
    print("inside Bean");
    return CreditBereauBean(
        adhaarNo: map[TablesColumnFile.adhaarNo] as int,
        aplicantName: map[TablesColumnFile.aplicantName] as String,
        spouseName: map[TablesColumnFile.spouseName] as String,
        house: map[TablesColumnFile.house] as String,
        contactNo: map[TablesColumnFile.contactNo] as int,
        city: map[TablesColumnFile.city] as String,
        street: map[TablesColumnFile.street] as String,
        state: map[TablesColumnFile.state] as String,
        pinCode: map[TablesColumnFile.pinCode] as int,
        idType2: map[TablesColumnFile.idType2] as String,
        id2: map[TablesColumnFile.id2] as String,
        queueNo: map[TablesColumnFile.queueNo] as int,
        DOB: DateTime.parse(map[TablesColumnFile.DOB]) as DateTime,
        nomineeName: map[TablesColumnFile.nomineeName] as String,
        nomineeRelation: map[TablesColumnFile.nomineeRelation] as String,
        branchId: map[TablesColumnFile.branchId] as String,
        kendraId: map[TablesColumnFile.kendraId] as String,
        memberId: map[TablesColumnFile.memberId] as String,
        segmentIdentifier: map[TablesColumnFile.segmentIdentifier] as int,
        creditRequestType: map[TablesColumnFile.creditRequestType] as String,
        creditReportTransctionId:
            map[TablesColumnFile.creditReportTransctionId] as String,
        creditEnquiryPurposeType:
            map[TablesColumnFile.creditEnquiryPurposeType] as String,
        creditEquiryStage: map[TablesColumnFile.creditEquiryStage] as String,
        creditReportTransactionDateType:
            map[TablesColumnFile.creditReportTransactionDateType] as String,
        agentUserName: map[TablesColumnFile.agentUserName] as String,
        isDataSynced: map[TablesColumnFile.isDataSynced] as int,
        cbCheckStatus: map[TablesColumnFile.cbCheckStatus] as String,
        routedTo: map[TablesColumnFile.routedTo] as String,
        routedFrom: map[TablesColumnFile.routedFrom] as String,
        prospectStatus: map[TablesColumnFile.prospectStatus] as int,
        createdAt: map[TablesColumnFile.createdAt]=="null"||map[TablesColumnFile.createdAt]==null?null:DateTime.parse(map[TablesColumnFile.createdAt]) as DateTime,
        updatedAt: map[TablesColumnFile.updatedAt]=="null"||map[TablesColumnFile.updatedAt]==null?null:DateTime.parse(map[TablesColumnFile.updatedAt]) as DateTime,
        createdBy: map[TablesColumnFile.createdBy] as String,
        updatedBy: map[TablesColumnFile.updatedBy] as String);
  }

  factory CreditBereauBean.mapFromMiddleware(Map<String, dynamic> map) {

    print("inside CreditBereauBean map");
    print(map);
    return CreditBereauBean(
        compositeProspectId:CompositeProspectId.mapFromMiddleware(map["compositeProspectId"]),
        aplicantName: map[TablesColumnFile.aplicantName] as String,
        spouseName: map[TablesColumnFile.spouseName] as String,
        house: map[TablesColumnFile.house] as String,
        contactNo: map[TablesColumnFile.contactNo] as int,
        city: map[TablesColumnFile.city] as String,
        street: map[TablesColumnFile.street] as String,
        state: map[TablesColumnFile.state] as String,
        pinCode: map[TablesColumnFile.pinCode] as int,
        idType2: map[TablesColumnFile.idType2] as String,
        id2: map[TablesColumnFile.id2] as String,
        queueNo: map[TablesColumnFile.queueNo] as int,
        DOB:map[TablesColumnFile.DOB]=="null"||map[TablesColumnFile.DOB]==null?null:DateTime.parse(map[TablesColumnFile.DOB]) as DateTime,
        nomineeName: map[TablesColumnFile.nomineeName] as String,
        nomineeRelation: map[TablesColumnFile.nomineeRelation] as String,
        branchId: map[TablesColumnFile.branchId] as String,
        segmentIdentifier: map[TablesColumnFile.segmentIdentifier] as int,
        isUploaded: map[TablesColumnFile.isUploaded] as int,
        OTPVerified: map["otpVerified"] as int,
        creditRequestType: map[TablesColumnFile.creditRequestType] as String,
        creditReportTransctionId:
        map[TablesColumnFile.creditReportTransctionId] as String,
        creditEnquiryPurposeType:
        map[TablesColumnFile.creditEnquiryPurposeType] as String,
        creditEquiryStage: map[TablesColumnFile.creditEquiryStage] as String,
        creditReportTransactionDateType:
        map[TablesColumnFile.creditReportTransactionDateType] as String,
        agentUserName: map[TablesColumnFile.agentUserName] as String,
        isDataSynced: map[TablesColumnFile.isDataSynced] as int,
        cbCheckStatus: map[TablesColumnFile.cbCheckStatus] as String,
        routedTo: map[TablesColumnFile.routedTo] as String,
        routedFrom: map[TablesColumnFile.routedFrom] as String,
        prospectStatus: map[TablesColumnFile.prospectStatus] as int,
        resultDetails:map["resultDetails"].map<CbResultBean>((i) => CbResultBean.mapFromMiddleware(i,)).toList(),
        loanDetails:map["loanDetails"].map<CbResultBean>((i) => CbResultBean.mapFromMiddleware(i)).toList(),


        createdAt: map[TablesColumnFile.createdAt]=="null"||map[TablesColumnFile.createdAt]==null?null:DateTime.parse(map[TablesColumnFile.createdAt]) as DateTime,
        updatedAt: map[TablesColumnFile.updatedAt]=="null"||map[TablesColumnFile.updatedAt]==null?null:DateTime.parse(map[TablesColumnFile.updatedAt]) as DateTime,
        createdBy: map[TablesColumnFile.createdBy] as String,
        updatedBy: map[TablesColumnFile.updatedBy] as String);

  }*/
}

class CompositeProspectId{


    int adhaarNo;
  String agentUserName;


  CompositeProspectId({this.adhaarNo,this.agentUserName});

  factory CompositeProspectId.mapFromMiddleware(Map<String, dynamic> map){
    print(map);
    print("inside CompositeProspectId map");
    return CompositeProspectId(
        adhaarNo: map["adhaarNo"] as int,
        agentUserName : map["agentUserName"] as String
    );

  }


}

