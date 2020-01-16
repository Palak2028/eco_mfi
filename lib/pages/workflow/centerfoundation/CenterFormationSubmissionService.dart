import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterFormationMasterSubmissionBean.dart';

class CenterFormationSubmissionService {
  static const _serviceUrl =
      'http://14.141.164.239:8090/createCentersFoundations/add/';
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  Future<CenterFormationMasterSubmissionBean> createCenter(
      CenterFormationMasterSubmissionBean center) async {
    try {
      String json = _toJson(center);
      print("jsonData here is : " + json.toString());
      final response =
          await http.post(_serviceUrl, headers: _headers, body: json);
      var c = _fromJson(response.body);
      return c;
    } catch (e) {
      print('Server Exception!!!');
      print(e);
      return null;
    }
  }

  CenterFormationMasterSubmissionBean _fromJson(String json) {
    Map<String, dynamic> map = JSON.decode(json);
    print(json + " form jso obj response");
    var center = CenterFormationMasterSubmissionBean.fromJson(map);
    return center;
  }

  String _toJson(CenterFormationMasterSubmissionBean centerSubmission) {
    var mapData = new Map();
    mapData["centerName"] = centerSubmission.centerName;
    mapData["branch"] = centerSubmission.branch;
    mapData["state"] = centerSubmission.state;
    mapData["districts"] = centerSubmission.districts;
    mapData["subDistricts"] = centerSubmission.subDistricts;
    mapData["villageName"] = centerSubmission.villageName;
    mapData["villagePopulation"] = centerSubmission.villagePopulation;
    mapData["distanceFromBranch"] = centerSubmission.distanceFromBranch;
    mapData["assignedTo"] = centerSubmission.assignedTo;
    mapData["serVeyType"] = centerSubmission.serVeyType;
    mapData["agentUserName"] = 'Shadab';
    mapData["isDataSynced"] = 0;
    String json = JSON.encode(mapData);
    return json;
  }
}
