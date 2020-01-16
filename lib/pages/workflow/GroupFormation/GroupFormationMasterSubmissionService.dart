import 'package:http/http.dart' as http;
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'dart:async';
import 'dart:convert';
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFormationMasterSubmissionBean.dart';

class GroupFormationMasterSubmissionService {
  static const _serviceUrl =
      'http://14.141.164.239:8090/createGroupsFoundations/add/';
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();


  Future<GroupFormationMasterSubmissionBean> createGroup(
      GroupFormationMasterSubmissionBean group, String userName) async {
    GroupFormationMasterSubmissionBean groupFormationMasterSubmissionBean = new GroupFormationMasterSubmissionBean();
    try {
      String json = _toJson(group,userName);
      final bodyValue = await NetworkUtil.callPostService(json,Constant.apiURL+"createGroupsFoundations/add/",_headers);
      if(bodyValue == "404" ){
        return null;
      }
      groupFormationMasterSubmissionBean = await _fromJson(bodyValue);
      return groupFormationMasterSubmissionBean;
    } catch (e) {
      print('Server Exception!!!');
      print(e);
      return null;
    }
  }


  Future<GroupFormationMasterSubmissionBean> _fromJson(String json) async{
    Map<String, dynamic> map = JSON.decode(json);
    print(json + " form jso obj response");
    var center = GroupFormationMasterSubmissionBean.fromMap(map);
    return center;
  }

  String _toJson(GroupFormationMasterSubmissionBean groupSubmission, userName) {
    var mapData = new Map();
    mapData[TablesColumnFile.groupNumber] = groupSubmission.groupNumber;
    mapData[TablesColumnFile.branchCode] = groupSubmission.branchCode;
    mapData[TablesColumnFile.centerCode] = groupSubmission.centerCode;
    mapData[TablesColumnFile.groupType] = groupSubmission.groupType;
    mapData[TablesColumnFile.groupRecognitionTestDate] =
        groupSubmission.groupRecognitionTestDate;
    mapData[TablesColumnFile.GRTApprovedBy] = groupSubmission.GRTApprovedBy;
    mapData[TablesColumnFile.meetingDay] = groupSubmission.meetingDay;
    mapData[TablesColumnFile.loanAmountLimit] = groupSubmission.loanAmountLimit;
    mapData[TablesColumnFile.groupName] = groupSubmission.groupName;
    mapData[TablesColumnFile.branchGroupID] = groupSubmission.branchGroupID;
    mapData[TablesColumnFile.agentUserName] = userName;
    mapData[TablesColumnFile.isDataSynced] = 0;
    String json = JSON.encode(mapData);
    return json;
  }
}
