import 'package:eco_mfi/db/TablesColumnFile.dart';

class GroupFormationMasterSubmissionBean {
  int groupNumber;
  int branchCode;
  int centerCode;
  String groupType;
  DateTime groupRecognitionTestDate;
  String GRTApprovedBy;
  String meetingDay;
  int loanAmountLimit;
  String groupName;
  int groupSize;
  int branchGroupID;

  GroupFormationMasterSubmissionBean({
    this.groupNumber,
    this.branchCode,
    this.centerCode,
    this.groupType,
    this.groupRecognitionTestDate,
    this.GRTApprovedBy,
    this.meetingDay,
    this.loanAmountLimit,
    this.groupName,
    this.groupSize,
    this.branchGroupID,
  });

  factory GroupFormationMasterSubmissionBean.fromMap(Map<String, dynamic> map) {
    return GroupFormationMasterSubmissionBean(
      groupNumber: map[TablesColumnFile.groupNumber] as int,
      branchCode: map[TablesColumnFile.branchCode] as int,
      centerCode: map[TablesColumnFile.centerCode] as int,
      groupType: map[TablesColumnFile.groupType] as String,
      groupRecognitionTestDate:
          map[TablesColumnFile.groupRecognitionTestDate] as DateTime,
      GRTApprovedBy: map[TablesColumnFile.GRTApprovedBy] as String,
      meetingDay: map[TablesColumnFile.meetingDay] as String,
      loanAmountLimit: map[TablesColumnFile.loanAmountLimit] as int,
      groupName: map[TablesColumnFile.groupName] as String,
      groupSize: map[TablesColumnFile.groupSize] as int,
      branchGroupID: map[TablesColumnFile.branchGroupID] as int,
    );
  }
}
