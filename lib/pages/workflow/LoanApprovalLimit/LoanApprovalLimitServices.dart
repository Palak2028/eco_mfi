import 'dart:async';
import 'dart:convert';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LoanApprovalLimit/LoanApprovalLimitBean.dart';



class LoanApprovalLimitService {

  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  Future<List<LoanApprovalLimitBean>> getLoanApprovalLimitData(int lbrCode,String muserName,int mgrpcd) async {
    List<LoanApprovalLimitBean> loanApprovalLimitBean = new List<LoanApprovalLimitBean>();

     /*try {*/
       String json2 = _toJsonOfAgentUserName(lbrCode,muserName,mgrpcd);
       final bodyValue = await NetworkUtil.callPostService(json2,Constant.apiURL+"LoanApprovalLimitController/getLoanApprovalLimitByMlbrCodeAndUserCd",_headers);

       if(bodyValue == "error"||bodyValue == "404"||bodyValue == null){
      return null;
    }

       loanApprovalLimitBean = await _fromLoanApprovalLimitJson(bodyValue);
    return loanApprovalLimitBean;
     /*} catch (e) {
      print('Server Exception!!!');
      return loanApprovalLimitBean;
    }*/
  }

  Future<List<LoanApprovalLimitBean>> _fromLoanApprovalLimitJson(String json) async{
    List<LoanApprovalLimitBean> listLoanApprovalLimitBean = new List<LoanApprovalLimitBean>();
    print(json+" coming here");
    List list = JSON.decode(json);
    print(list.toString());
    print(list.length.toString()+"coming here");
    print(json + " form jso obj response" + "here is" + list.toString());
    for (int i = 0; i < list.length; i++) {
      print(list.length);
      var bean = LoanApprovalLimitBean.fromMap(list[i]);
      listLoanApprovalLimitBean.add(bean);
    }
    return listLoanApprovalLimitBean;
  }

  String _toJsonOfAgentUserName(int lbrCode,String muserCode,int mgrpcd) {
    print("mgrpcd mgrpcd mgrpcd mgrpcd"+mgrpcd.toString());
    var mapComposite = new Map();
    var mapData = new Map();
    mapData[TablesColumnFile.mlbrcode] = lbrCode;
    mapData[TablesColumnFile.musercode] = muserCode;
    mapData[TablesColumnFile.mgrpcd] = mgrpcd;
    mapComposite[TablesColumnFile.loanApprovalLimitComposite]=mapData;
    String json = JSON.encode(mapComposite);
    print(json.toString());
    return json;
  }

}

