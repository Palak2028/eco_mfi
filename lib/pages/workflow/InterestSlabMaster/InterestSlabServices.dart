import 'dart:async';
import 'dart:convert';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/pages/workflow/InterestSlabMaster/InterestSlabBean.dart';


class InterestSlabServices {
  static String apiURL =
      "InterestSlabController/getAllInterestSlab/";
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  Future<List<InterestSlabBean>> getInterestSlab() async {
    List<InterestSlabBean> InterestSlab = new List<InterestSlabBean>();
    print("Data after Inser Slab service  1");
  try {
    final bodyValue = await NetworkUtil.callGetService(Constant.apiURL+"InterestSlabController/getAllInterestSlab/");
    if(bodyValue == "error"){
      return null;
    }
    print("Data after Inser Slab service  " + bodyValue.toString());
    InterestSlab = await _fromInterestSlabJson(bodyValue);
    return InterestSlab;
     } catch (e) {
      print('Server Exception!!!');
      return InterestSlab;
    }
  }

  Future<List<InterestSlabBean>> _fromInterestSlabJson(String json) async{
    List<InterestSlabBean> listInterestSlabBean = new List<InterestSlabBean>();
    print(json+" coming here");
    List list = JSON.decode(json);
    print(list.toString());
    print(list.length.toString()+"coming here");
    print(json + " form jso obj response" + "here is" + list.toString());
    for (int i = 0; i < list.length; i++) {
      print(list.length);
      var bean = InterestSlabBean.fromMap(list[i]);
      listInterestSlabBean.add(bean);
    }
    return listInterestSlabBean;
  }


}

