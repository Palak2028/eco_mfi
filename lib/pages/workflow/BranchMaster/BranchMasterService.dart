


import 'dart:convert';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart%20%20';

import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/BranchMaster/BranchMasterBean.dart';

class BranchMasterServices {


  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlGetBranchInfo=
      "branchMaster/branchMasterOnMpbrCode";
  static const JsonCodec JSON = const JsonCodec();

  Future<Null> trySave(int lbrCode) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      await getMiddleWareData(lbrCode, urlGetBranchInfo);
    }
  }

  Future<Null> getMiddleWareData(
      int lbrCode, String url) async {

    try {
      String json2 = _toJsonOfMprbCd(lbrCode);
      String bodyValue  = await NetworkUtil.callPostService(json2,Constant.apiURL.toString()+url.toString(),_headers);
      print("body val "+bodyValue.toString());
      if(bodyValue == "404" ){
        return null;
      }else if(bodyValue!=null && bodyValue.toString() !='null') {
        print("bodyValue "+bodyValue.toString());
        final parsed = json.decode(bodyValue).cast<Map<String, dynamic>>();
        await AppDatabase.get().deletSomeSyncingActivityFromOmni('Branch_Master');
        List<BranchMasterBean> obj =
        parsed.map<BranchMasterBean>((json) => BranchMasterBean.fromMiddleware(json)).toList();

        for (BranchMasterBean items in obj) {
          await AppDatabase.get().updateBranchMaster(items);
        }


      }
    } catch (e) {}
  }


  String _toJsonOfMprbCd(int lbrCode) {
    var mapData = new Map();
    mapData[TablesColumnFile.mpbrcode] = lbrCode;
    String json = JSON.encode(mapData);
    print(json.toString());
    return json;
  }
}