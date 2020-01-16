import 'dart:async';
import 'dart:convert';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/pages/workflow/InterestOffsetMaster/InterestOffsetBean.dart';


class InterestOffsetServices {
  static String apiURL =
      "InterestOffsetController/getAllInterestOffset/";
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  Future<List<InterestOffsetBean>> getInterestOffset() async {
    List<InterestOffsetBean> IsertOffset = new List<InterestOffsetBean>();
    print("Data after Inser Offset service  1");
     try {
    final bodyValue = await NetworkUtil.callGetService(Constant.apiURL+"InterestOffsetController/getAllInterestOffset/");
    if(bodyValue == "error"){
      return null;
    }
  //  print("Data after Inser Offset service  " + bodyValue);
    IsertOffset = await _fromInterestOffsetJson(bodyValue);
    return IsertOffset;
     } catch (e) {
      print('Server Exception!!!');
      return IsertOffset;
    }
  }

  Future<List<InterestOffsetBean>> _fromInterestOffsetJson(String json) async{
    List<InterestOffsetBean> listInterestOffsetBean = new List<InterestOffsetBean>();
    print(json+" coming here");
    List list = JSON.decode(json);
    print(list.toString());
    print(list.length.toString()+"coming here");
    print(json + " form jso obj response" + "here is" + list.toString());
    for (int i = 0; i < list.length; i++) {
      print(list.length);
      var bean = InterestOffsetBean.fromMap(list[i]);
      listInterestOffsetBean.add(bean);
    }
    return listInterestOffsetBean;
  }


}

