import 'package:eco_mfi/db/TablesColumnFile.dart';

class ProspectViewBean {
  final int adhaarNo;

  final String aplicantName;

  final int contactNo;

  final String spouseName;

  final String house;

  final String street;
  final String state;

  final String city;

  final int pinCode;

  final DateTime DOB;

  final String idType2;

  final String id2;

  final String nomineeName;

  final String nomineeRelation;

  final String branchId;

  final String kendraId;

  final String memberId;

  final int queueNo;

  final int segmentIdentifier;

  final String creditRequestType;

  final String creditReportTransctionId;

  final String creditEnquiryPurposeType;

  final String creditEquiryStage;

  final String creditReportTransactionDateType;

  final String agentUserName;

  final int isDataSynced;

  ProspectViewBean(
      {this.adhaarNo,
      this.aplicantName,
      this.contactNo,
      this.spouseName,
      this.house,
      this.street,
      this.state,
      this.city,
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
      this.creditRequestType,
      this.creditReportTransctionId,
      this.creditEnquiryPurposeType,
      this.creditEquiryStage,
      this.creditReportTransactionDateType,
      this.agentUserName,
      this.isDataSynced});

 /* factory ProspectViewBean.fromJson(Map<String, dynamic> map) {
    return ProspectViewBean(
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
        isDataSynced: map[TablesColumnFile.isDataSynced] as int);
  }*/
}
