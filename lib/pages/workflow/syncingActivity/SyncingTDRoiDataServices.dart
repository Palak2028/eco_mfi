import 'dart:async';
import 'dart:convert';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LoanCycleParameterPrimaryTable/LoanCycleParameterPrimaryBean.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/ProductwiseInterestTableBean.dart';


class SyncingTDRoiDataServices {
  static String apiURL =
      "TDInterestSlabController/getAllTDInterestSlab/";  //TODO change Url
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  Future<List<ProductwiseInterestTableBean>> getProductwiseInterestTablePrimaryData  (int lbrCode) async {
    List<ProductwiseInterestTableBean> getProductwiseInterestTableDataPrimary = new List<ProductwiseInterestTableBean>();
    print("Data after Inser Loan Cycle Parameter Primary  service  1");
    try {

      final bodyValue = await NetworkUtil.callGetService(Constant.apiURL+"TDInterestSlabController/getAllTDInterestSlab/");
      if(bodyValue == "error"){
        return null;
      }
      //print("Data after Inser Loan Cycle Parameter Primary service  " + bodyValue);
      getProductwiseInterestTableDataPrimary = await _fromProductwiseInterestTablePrimaryJson(bodyValue);
      return getProductwiseInterestTableDataPrimary;
    } catch (e) {
      print('Server Exception!!!');
      return getProductwiseInterestTableDataPrimary;
    }
  }

  Future<List<ProductwiseInterestTableBean>> _fromProductwiseInterestTablePrimaryJson(String json) async{
    List<ProductwiseInterestTableBean> ProductwiseInterestTablePrimaryPrimaryBean = new List<ProductwiseInterestTableBean>();
    print(json.toString()+" coming here");
    List list = JSON.decode(json);
    print(list.toString());
    print(list.length.toString()+"coming here");
    print(json + " form jso obj response" + "here is" + list.toString());
    for (int i = 0; i < list.length; i++) {
      print(list.length);
      var bean = ProductwiseInterestTableBean.fromMap(list[i]);
      ProductwiseInterestTablePrimaryPrimaryBean.add(bean);
    }
    return ProductwiseInterestTablePrimaryPrimaryBean;
  }



  Future<List<ProductwiseInterestTableBean>> getTDParameterMaster(int lbrCode) async {
    List<ProductwiseInterestTableBean> getProductwiseInterestTableDataPrimary = new List<ProductwiseInterestTableBean>();
    print("Data after Inser in TD Parameter");
    try {

      final bodyValue = await NetworkUtil.callGetService(Constant.apiURL+"TDParameterController/getAllTDParameter/");
      if(bodyValue == "error"){
        return null;
      }
      //print("Data after Inser Loan Cycle Parameter Primary service  " + bodyValue);
      getProductwiseInterestTableDataPrimary = await _fromProductwiseInterestTablePrimaryJson(bodyValue);
      return getProductwiseInterestTableDataPrimary;
    } catch (e) {
      print('Server Exception!!!');
      return getProductwiseInterestTableDataPrimary;
    }
  }


}

