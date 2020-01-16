import 'package:eco_mfi/db/TablesColumnFile.dart';
/*

class SubLookupForSubPurposeOfLoan {
  int purposeId;
  String purposeName;
  String purposeDescription;

  SubLookupForSubPurposeOfLoan({this.purposeId, this.purposeName, this.purposeDescription});

  @override
  String toString() {
    return 'PurposeOfLoan{purposeId: $purposeId, purposeName: $purposeName, purposeDescription: $purposeDescription}';
  }

  factory SubLookupForSubPurposeOfLoan.fromMap(Map<String, dynamic> map) {
    return SubLookupForSubPurposeOfLoan(
        purposeId: map["purposeId"] as int,
        purposeName: map["purposeName"] as String,
        purposeDescription: map["purposeDescription"] as String);
  }
}

*/


class SubLookupForSubPurposeOfLoan{

  String codeDesc;
  String fieldValue1;
  int codeType;
  String code;


  SubLookupForSubPurposeOfLoan({this.codeDesc, this.fieldValue1, this.codeType,this.code});

  factory SubLookupForSubPurposeOfLoan.fromMap(Map<String, dynamic> json) {
    return SubLookupForSubPurposeOfLoan(
      codeDesc: json[TablesColumnFile.mcodedesc] as String,
      fieldValue1: json[TablesColumnFile.mfield1value] as String,
      codeType: json[TablesColumnFile.mcodetype] as int,
      code: json[TablesColumnFile.mcode] as String,
    );
  }
}

