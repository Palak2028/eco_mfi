import 'package:eco_mfi/db/TablesColumnFile.dart';

class CenterFormationMasterSubmissionBean {
  //DateTime dateTime;
  final int id;

  // final DateTime serveyData;
  String centerName;

  String branch;

  String state;

  String districts;

  String subDistricts;

  String villageName;

  int villagePopulation;

  int distanceFromBranch;

  String assignedTo;

  String serVeyType;

  String agentUserName;

  int isDataSynced;

  DateTime serveyDate;

  CenterFormationMasterSubmissionBean(
      {this.id,
      this.centerName,
      this.branch,
      this.state,
      this.districts,
      this.subDistricts,
      this.villageName,
      this.villagePopulation,
      this.distanceFromBranch,
      this.serVeyType,
      this.assignedTo,
      this.agentUserName,
      this.isDataSynced,
      this.serveyDate});

  factory CenterFormationMasterSubmissionBean.fromJson(
      Map<String, dynamic> json) {
    return CenterFormationMasterSubmissionBean(
      id: json['id'] as int,
      centerName: json[TablesColumnFile.centerName] as String,
      assignedTo: json[TablesColumnFile.assignedTo] as String,
      branch: json[TablesColumnFile.musrbrcode] as String,
      state: json[TablesColumnFile.state] as String,
      districts: json[TablesColumnFile.districts] as String,
      subDistricts: json[TablesColumnFile.subDistricts] as String,
      villageName: json[TablesColumnFile.villageName] as String,
      villagePopulation: json[TablesColumnFile.villagePopulation] as int,
      distanceFromBranch: json[TablesColumnFile.distanceFromBranch] as int,
      serVeyType: json[TablesColumnFile.serVeyType] as String,
      agentUserName: json[TablesColumnFile.agentUserName] as String,
      isDataSynced: json[TablesColumnFile.isDataSynced] as int,
    );
  }
}
