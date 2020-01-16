class CreditBereauCallSubmissionBean {
  int queNo;
  int segmentIdentifier;
  String creditRequestType;
  String creditReportTransactionId;
  int adhaarNo;
  String aplicantName;
  String contactNo;
  String spouseName;
  String address;
  String city;
  String state;

  int pinCode;
  String DOB;
  String idType2;
  String id2;
  String nomineeName;
  String nomineeRelation;
  String branchId;
  String kendraId;
  String memberId;
  int allSaved;
  String creditReportTransctionId;
  String creditEnquiryPurposeType;
  String creditEquiryStage;
  String creditReportTransactionDateType;
  int maxRowCount;
  int isUploaded;

  CreditBereauCallSubmissionBean(
      {this.queNo,
      this.segmentIdentifier,
      this.creditRequestType,
      this.creditReportTransactionId,
      this.adhaarNo,
      this.aplicantName,
      this.contactNo,
      this.spouseName,
      this.address,
      this.pinCode,
      this.DOB,
      this.idType2,
      this.id2,
      this.nomineeName,
      this.nomineeRelation,
      this.branchId,
      this.kendraId,
      this.memberId,
      this.allSaved,
      this.creditReportTransctionId,
      this.creditEnquiryPurposeType,
      this.creditEquiryStage,
      this.creditReportTransactionDateType,
      this.maxRowCount,
      this.isUploaded});
}
