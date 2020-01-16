import 'dart:async';
import 'dart:convert';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/TDOffsetInterestMasterBean.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/TDParameterBean.dart';


class SyncingTDParameterService {
  static String apiURL =
      "TDParameterController/getAllTDParameterData/";//TODO change Url
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  Future<List<TDParameterBean>> getTDParameterData  (int lbrCode) async {
    List<TDParameterBean> TDParameterList = new List<TDParameterBean>();
    print("Data After Insert TD PArameter");
    //try {

      final bodyValue = await NetworkUtil.callGetService(Constant.apiURL+"TDParameterController/getAllTDParameterData/");//TODO
      if(bodyValue == "error"){
        return null;
      }
      print("Data after InserTD parameter second " + bodyValue);
      TDParameterList = await _fromTDParameterJson(bodyValue);
      return TDParameterList;
   /* } catch (e) {
      print('Server Exception!!!');
      return TDParameterList;
    }*/
  }

  Future<List<TDParameterBean>> _fromTDParameterJson(String json) async{
    List<TDParameterBean> TDParameterListBean = new List<TDParameterBean>();
    print(json.toString()+" coming here");
    List list = JSON.decode(json);
    print(list.toString());
    print(list.length.toString()+"coming here");
    print(json + " form jso obj response" + "here is" + list.toString());
    for (int i = 0; i < list.length; i++) {
      print(list.length);
      var bean = TDParameterBean.fromMap(list[i]);
      TDParameterListBean.add(bean);
    }
    return TDParameterListBean;
  }



}

