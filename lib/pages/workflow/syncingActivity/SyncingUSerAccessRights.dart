import 'dart:convert';

import 'package:eco_mfi/MenuAndRights/UserRightsBean.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';


import 'dart:async';
import 'dart:convert';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LoanApprovalLimit/LoanApprovalLimitBean.dart';



class SyncingUserAccessRights {

  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  Future<List<UserRightBean>> getUserRightBean(String muserName,int mgrpcd) async {
    List<UserRightBean> userRightBean = new List<UserRightBean>();

    try {
    String json2 = _toJsonOfAgentUserName(muserName,mgrpcd);
    final bodyValue = await NetworkUtil.callPostService(json2,Constant.apiURL+"userAccessRights/getUserAccessRightsByUSerCode",_headers);

    if(bodyValue == "error"||bodyValue == "404"||bodyValue == null){
      return null;
    }

    userRightBean = await _fromUserRightBeanJson(bodyValue);
    return userRightBean;
    } catch (e) {
      print('Server Exception!!!');

    }
  }

  Future<List<UserRightBean>> _fromUserRightBeanJson(String json) async{
    List<UserRightBean> listUserRightBean = new List<UserRightBean>();
    print(json+" coming here");
    List list = JSON.decode(json);
    print(list.toString());
    print(list.length.toString()+"coming here");
    print(json + " form jso obj response" + "here is" + list.toString());
    for (int i = 0; i < list.length; i++) {
      print(list.length);
      var bean = UserRightBean.fromMiddlewareMap(list[i]);
      listUserRightBean.add(bean);
    }
    return listUserRightBean;
  }

  String _toJsonOfAgentUserName(String muserCode,int mgrpcd) {
    print("mgrpcd mgrpcd mgrpcd mgrpcd"+mgrpcd.toString());
    var mapComposite = new Map();
    var mapData = new Map();
   // mapData[TablesColumnFile.mlbrcode] = lbrCode;
    mapData[TablesColumnFile.musrcode] = muserCode;
    mapData[TablesColumnFile.mgrpcd] = mgrpcd;
    mapComposite[TablesColumnFile.userAccressRightsCompositeEntity]=mapData;
    String json = JSON.encode(mapComposite);
    print(json.toString());
    return json;
  }

}

