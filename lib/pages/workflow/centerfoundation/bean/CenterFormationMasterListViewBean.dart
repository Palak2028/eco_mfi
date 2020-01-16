import 'package:eco_mfi/db/TablesColumnFile.dart';

class CenterFormationMasterListViewBean {
  //DateTime dateTime;
  final int id;

  // final DateTime serveyData;
  final String centerName;
  final String branch;
  final String state;
  final String districts;
  final String subDistricts;
  final String villageName;
  final int villagePopulation;
  final int distanceFromBranch;
  final String assignedTo;
  final String serVeyType;
  final String agentUserName;
  final int isDataSynced;

  CenterFormationMasterListViewBean(
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
      this.isDataSynced});

  factory CenterFormationMasterListViewBean.fromJson(
      Map<String, dynamic> json) {
    return CenterFormationMasterListViewBean(
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
