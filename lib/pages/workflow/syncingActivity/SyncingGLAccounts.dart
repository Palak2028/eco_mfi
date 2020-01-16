import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/bean/GLAccountBean.dart';

class SyncingGLAccounts{


  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlInfo = "glAccount/getDataByMlbrcode/";
  static const JsonCodec JSON = const JsonCodec();


  Future<Null> trySave(int lbrCode) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      await getMiddleWareData(lbrCode, urlInfo);
    }
  }

  Future<Null> getMiddleWareData(
      int lbrCode, String url) async {

    try {
      String json2 = _toJson(lbrCode);
      String bodyValue  = await NetworkUtil.callPostService(json2,Constant.apiURL.toString()+url.toString(),_headers);
      print("body val "+bodyValue.toString());
      if(bodyValue == "404" ){
        return null;
      }else if(bodyValue!=null && bodyValue.toString() !='null') {
        final parsed = json.decode(bodyValue).cast<Map<String, dynamic>>();
        //await AppDatabase.get().deletSomeSyncingActivityFromOmni('Product');
        List<GLAccountBean> obj =
        parsed.map<GLAccountBean>((json) => GLAccountBean.fromMap(json)).toList();
        for (GLAccountBean items in obj) {
          await AppDatabase.get().updateGLAccountMaster(items);
        }


      }
    } catch (e) {}
  }


  String _toJson(int lbrCode) {
    var mapData = new Map();
    mapData[TablesColumnFile.mlbrcode] = lbrCode;
    String json = JSON.encode(mapData);
    print(json.toString());
    return json;
  }
}