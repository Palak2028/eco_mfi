import 'dart:async';
import 'dart:convert';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LoanCycleParameterSecondaryTable/LoanCycleParameterSecondaryBean.dart';


class LoanCycleParameterSecondaryServices {
  static String apiURL =
      "LoanCycleParameterSecondaryController/getAllLoanCycleParameterSecondary/";
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  Future<List<LoanCycleParameterSecondaryBean>> getLoanCycleParameterSecondaryData(int lbrCode) async {
    List<LoanCycleParameterSecondaryBean> LoanCycleParameterSecondary = new List<LoanCycleParameterSecondaryBean>();
    print("Data after Inser Loan Cycle Parameter Secondary  service  1");
     try {
    //final bodyValue = await NetworkUtil.callGetService(Constant.apiURL+"LoanCycleParameterSecondaryController/getAllLoanCycleParameterSecondary/");
       String json2 = _toJsonOfAgentUserName(lbrCode);
       final bodyValue = await NetworkUtil.callPostService(json2,Constant.apiURL+"LoanCycleParameterSecondaryController/getLoanCycleParameterSecondaryByMlbrCode",_headers);

       if(bodyValue == "error"){
      return null;
    }
    print("Data after Inser Loan Cycle Parameter Secondary service  " + bodyValue);
    LoanCycleParameterSecondary = await _fromLoanCycleParameterSecondaryJson(bodyValue);
    return LoanCycleParameterSecondary;
     } catch (e) {
      print('Server Exception!!!');
      return LoanCycleParameterSecondary;
    }
  }

  Future<List<LoanCycleParameterSecondaryBean>> _fromLoanCycleParameterSecondaryJson(String json) async{
    List<LoanCycleParameterSecondaryBean> listLoanCycleParameterSecondaryBean = new List<LoanCycleParameterSecondaryBean>();
    print(json+" coming here");
    List list = JSON.decode(json);
    print(list.toString());
    print(list.length.toString()+"coming here");
    print(json + " form jso obj response" + "here is" + list.toString());
    for (int i = 0; i < list.length; i++) {
      print(list.length);
      var bean = LoanCycleParameterSecondaryBean.fromMap(list[i]);
      listLoanCycleParameterSecondaryBean.add(bean);
    }
    return listLoanCycleParameterSecondaryBean;
  }

  String _toJsonOfAgentUserName(int lbrCode) {
    print(lbrCode.toString());
    var mapComposite = new Map();
    var mapData = new Map();
    mapData[TablesColumnFile.mlbrcode] = lbrCode;
    mapComposite[TablesColumnFile.loanCycleParameterSecondaryComposite]=mapData;
    String json = JSON.encode(mapComposite);
    print(json.toString());
    return json;
  }

}

