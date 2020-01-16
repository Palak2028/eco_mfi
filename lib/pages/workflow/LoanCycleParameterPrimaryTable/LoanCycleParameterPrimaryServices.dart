import 'dart:async';
import 'dart:convert';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LoanCycleParameterPrimaryTable/LoanCycleParameterPrimaryBean.dart';


class LoanCycleParameterPrimaryServices {
  static String apiURL =
      "LoanCycleParameterPrimaryController/getAllLoanCycleParameterPrimary/";
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  Future<List<LoanCycleParameterPrimaryBean>> getLoanCycleParameterPrimaryData  (int lbrCode) async {
    List<LoanCycleParameterPrimaryBean> LoanCycleParameterPrimary = new List<LoanCycleParameterPrimaryBean>();
    print("Data after Inser Loan Cycle Parameter Primary  service  1");
     try {
    //final bodyValue = await NetworkUtil.callGetService(Constant.apiURL+"LoanCycleParameterPrimaryController/getAllLoanCycleParameterPrimary/");
       String json2 = _toJsonOfAgentUserName(lbrCode);
       final bodyValue = await NetworkUtil.callPostService(json2,Constant.apiURL+"LoanCycleParameterPrimaryController/getLoanCycleParameterPrimaryByMlbrCode",_headers);
    if(bodyValue == "error"){
      return null;
    }

    LoanCycleParameterPrimary = await _fromLoanCycleParameterPrimaryJson(bodyValue);
    return LoanCycleParameterPrimary;
     } catch (e) {
      print('Server Exception!!!');
      return LoanCycleParameterPrimary;
    }
  }

  Future<List<LoanCycleParameterPrimaryBean>> _fromLoanCycleParameterPrimaryJson(String json) async{
    List<LoanCycleParameterPrimaryBean> listLoanCycleParameterPrimaryBean = new List<LoanCycleParameterPrimaryBean>();
    print(json.toString()+" coming here");
    List list = JSON.decode(json);
    print(list.toString());
    print(list.length.toString()+"coming here");
    print(json + " form jso obj response" + "here is" + list.toString());
    for (int i = 0; i < list.length; i++) {
      print(list.length);
      var bean = LoanCycleParameterPrimaryBean.fromMap(list[i]);
      listLoanCycleParameterPrimaryBean.add(bean);
    }
    return listLoanCycleParameterPrimaryBean;
  }


  String _toJsonOfAgentUserName(int lbrCode) {

    var mapComposite = new Map();

    var mapData = new Map();
    mapData[TablesColumnFile.mlbrcode] = lbrCode;
    mapComposite[TablesColumnFile.loanCycleParameterPrimaryComposite]=mapData;
    String json = JSON.encode(mapComposite);
    print(json.toString());
    return json;
  }

}

