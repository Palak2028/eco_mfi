import 'dart:async';
import 'dart:convert';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';


class SystemParameterServices {
  static String apiURL =
      "SystemParameterController/getAllSystemParameter/";
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  Future<List<SystemParameterBean>> getSystemParameterData  () async {
    List<SystemParameterBean> SystemParameter = new List<SystemParameterBean>();
    print("Data after System Parameter service  1");
    try {
      final bodyValue = await NetworkUtil.callGetService(Constant.apiURL+"SystemParameterController/getAllSystemParameter/");
      if(bodyValue == "error"){
        return null;
      }
      print("Data after System parameter service  " + bodyValue);
      SystemParameter = await _fromSystemParameterJson(bodyValue);
      return SystemParameter;
    } catch (e) {
      print('Server Exception!!!');
      return SystemParameter;
    }
  }

  Future<List<SystemParameterBean>> _fromSystemParameterJson(String json) async{
    List<SystemParameterBean> listSystemParameterBean = new List<SystemParameterBean>();
    List list = JSON.decode(json);
    for (int i = 0; i < list.length; i++) {
      var bean = SystemParameterBean.fromMapMiddleware(list[i]);
      listSystemParameterBean.add(bean);
    }
    return listSystemParameterBean;
  }


}

