import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCashFlowAnalysisBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetCustomerFromMiddleware.dart';
import 'package:path_provider/path_provider.dart';

class GetCustomerLoanCashFlow {
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlGetCustomerLoanCashFlowDetails =
      "CustomerLoanCashFlow/getData/";
  static const JsonCodec JSON = const JsonCodec();
  ImageBean setBean;

  Future<Null> trySave(String userName) async {
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      await getMiddleWareData(userName, urlGetCustomerLoanCashFlowDetails);
    }
  }

  Future<Null> getMiddleWareData(String userName, String url) async {
    //await AppDatabase.get().deletSomeUtil();

    String json;
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(21, true)
        .then((onValue) async {
      json = _toJsonOfCreatedByAndLastSyncedDateTime(userName, onValue);
      print(json);
    });
    try {
      String bodyValue = await NetworkUtil.callPostService(
          json.toString(), Constant.apiURL.toString() + url.toString(), _headers);
      print("url " + Constant.apiURL.toString() + url.toString());
      if (bodyValue == "404") {
        return null;
      } else {
        print(bodyValue);
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        DateTime updateDateimeAfterUpdate = DateTime.now();
        List<CustomerLoanCashFlowAnalysisBean> obj = parsed
            .map<CustomerLoanCashFlowAnalysisBean>(
                (json) => CustomerLoanCashFlowAnalysisBean.fromMap(json))
            .toList();

        for (int cashFlow = 0; cashFlow < obj.length; cashFlow++) {


          await AppDatabase.get()
              .updateCustomerLoanCashFlowMaster(obj[cashFlow])
              .then((onValue) {
            // customerNumberValue = onValue;
          });





        }
        //updating lastsynced date time with now
        AppDatabase.get().updateStaticTablesLastSyncedMasterGetFromServer(
            21, updateDateimeAfterUpdate);

      }

    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }

  String _toJsonOfCreatedByAndLastSyncedDateTime(
      String loggedInUser, DateTime lastsyncedDateTime) {
    var mapData = new Map();
    mapData["mcreatedby"] = loggedInUser;
    //  mapData["routeTo"] = agentUserNo.toString().trim();
    mapData["mlastsynsdate"] = lastsyncedDateTime != null &&
        lastsyncedDateTime != 'null' &&
        lastsyncedDateTime != ''
        ? lastsyncedDateTime.toIso8601String()
        : null;
    String json = JSON.encode(mapData);
    print(json);
    return json;
  }
}
