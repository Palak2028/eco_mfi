import 'dart:async';
import 'dart:convert';

import 'package:eco_mfi/MenuAndRights/MenuMasterBean.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/pages/workflow/InterestSlabMaster/InterestSlabBean.dart';


class SyncingMenusMaster {

  static String apiURL =
      "menuMaster/getAllInterestSlab/";
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  Future<List<MenuMasterBean>> getMenuMasterBean() async {
    List<MenuMasterBean> menuMasterBean = new List<MenuMasterBean>();
    print("Data after Inser Slab service  1");
    try {
      final bodyValue = await NetworkUtil.callGetService(Constant.apiURL+"menuMaster/getAllMenusFromMaster/");
      if(bodyValue == "error"){
        return null;
      }
      print("Data after Inser Slab service  " + bodyValue.toString());
      menuMasterBean = await _fromInterestSlabJson(bodyValue);
      return menuMasterBean;
    } catch (e) {
      print('Server Exception!!!');
      return menuMasterBean;
    }
  }

  Future<List<MenuMasterBean>> _fromInterestSlabJson(String json) async{
    List<MenuMasterBean> menuMasterListBean = new List<MenuMasterBean>();
    print(json+" coming here");
    List list = JSON.decode(json);
    print(list.toString());
    print(list.length.toString()+"coming here");
    print(json + " form jso obj response" + "here is" + list.toString());
    for (int i = 0; i < list.length; i++) {
      print(list.length);
      var bean = MenuMasterBean.fromMap(list[i]);
      menuMasterListBean.add(bean);
    }
    return menuMasterListBean;
  }


}

