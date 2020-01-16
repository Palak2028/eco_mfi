import 'package:eco_mfi/db/TablesColumnFile.dart';

class GroupFormationMasterListViewBean {
  final int groupNumber;
  final int branchCode;
  final int centerCode;
  final String groupType;
  final String groupRecognitionTestDate;
  final String GRTApprovedBy;
  final String meetingDay;
  final double loanAmountLimit;
  final String groupName;
  final int groupSize;
  final int branchGroupID;

  GroupFormationMasterListViewBean(
      {this.groupNumber,
      this.branchCode,
      this.centerCode,
      this.groupType,
      this.groupRecognitionTestDate,
      this.GRTApprovedBy,
      this.meetingDay,
      this.loanAmountLimit,
      this.groupName,
      this.groupSize,
      this.branchGroupID});

  factory GroupFormationMasterListViewBean.fromJson(Map<String, dynamic> map) {
    return GroupFormationMasterListViewBean(
      groupNumber: map[TablesColumnFile.groupNumber] as int,
      branchCode: map[TablesColumnFile.branchCode] as int,
      centerCode: map[TablesColumnFile.centerCode] as int,
      groupType: map[TablesColumnFile.groupType] as String,
      groupRecognitionTestDate:
          map[TablesColumnFile.groupRecognitionTestDate] as String,
      GRTApprovedBy: map[TablesColumnFile.GRTApprovedBy] as String,
      meetingDay: map[TablesColumnFile.meetingDay] as String,
      loanAmountLimit: map[TablesColumnFile.loanAmountLimit] as double,
      groupName: map[TablesColumnFile.groupName] as String,
      groupSize: map[TablesColumnFile.groupSize] as int,
      branchGroupID: map[TablesColumnFile.branchGroupID] as int,
    );
  }
}
