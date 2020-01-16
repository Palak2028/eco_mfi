import 'dart:async';
import 'dart:convert';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/TDOffsetInterestMasterBean.dart';


class SyncingTDOffsetInterestMasterServices {
  static String apiURL =
      "TDOffsetInterestSlabController/getAllTDOffsetInterestSlab/";//TODO change Url
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  Future<List<TDOffsetInterestMasterBean>> getTDOffsetInterestMasterData  (int lbrCode) async {
    List<TDOffsetInterestMasterBean> TDOffsetInterestMasterList = new List<TDOffsetInterestMasterBean>();
    print("Data after Inser Loan Cycle Parameter Primary  service  1");
   try {

      final bodyValue = await NetworkUtil.callGetService(Constant.apiURL+"TDOffsetInterestSlabController/getAllTDOffsetInterestSlab/");//TODO
      if(bodyValue == "error"){
        return null;
      }
      print("Data after Inser Loan Cycle Parameter Primary service  " + bodyValue);
      TDOffsetInterestMasterList = await _fromLoanCycleParameterPrimaryJson(bodyValue);
      return TDOffsetInterestMasterList;
    } catch (e) {
      print('Server Exception!!!');
      return TDOffsetInterestMasterList;
    }
  }

  Future<List<TDOffsetInterestMasterBean>> _fromLoanCycleParameterPrimaryJson(String json) async{
    List<TDOffsetInterestMasterBean> TDOffsetInterestMasterListBean = new List<TDOffsetInterestMasterBean>();
    print(json.toString()+" coming here");
    List list = JSON.decode(json);
    print(list.toString());
    print(list.length.toString()+"coming here");
    print(json + " form jso obj response" + "here is" + list.toString());
    for (int i = 0; i < list.length; i++) {
      print(list.length);
      var bean = TDOffsetInterestMasterBean.fromMap(list[i]);
      TDOffsetInterestMasterListBean.add(bean);
    }
    return TDOffsetInterestMasterListBean;
  }



}

