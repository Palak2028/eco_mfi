import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/MiniStatementBean.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetMiniStatementFromMiddleware{
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlGetMiniStatement =
      "MiniStatementController/getMiniStatementProductAccIdAndLbrCode/";
  static const JsonCodec JSON = const JsonCodec();
  ImageBean setBean;
  Future<List<MiniStatementBean> > trySave(String mprdaccid) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
     return await getMiddleWareData(mprdaccid, urlGetMiniStatement);
    }
  }
  Future<List<MiniStatementBean> > getMiddleWareData(String mprdaccid, String url) async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lbrCode = prefs.getInt(TablesColumnFile.musrbrcode);

    String json;


    json =  await getJson(mprdaccid,lbrCode);
   print("json"+json.toString());
      String bodyValue = await NetworkUtil.callPostService(json.toString(),
          Constant.apiURL.toString() + url.toString(), _headers);
      print("url " + Constant.apiURL.toString() + url.toString());
      if (bodyValue == "404" ||bodyValue ==null) {
       print("404");
        return null;
      } else {
        print("bodyValue"+bodyValue);
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<MiniStatementBean> obj = parsed
            .map<MiniStatementBean>(
                (json) => MiniStatementBean.fromMapMiddleware(json, true))
            .toList();
print("json"+json.toString());
        return obj;
      }
  }


  Future<String> getJson (String prdAccId,int lbrCode) async{
    Map map = new Map();
    map[TablesColumnFile.mprdacctid] = ifNullCheck(prdAccId);
    map[TablesColumnFile.mlbrcode] =  lbrCode;
    String returnigJson = await JSON.encode(map);
    return returnigJson;

  }


  String ifNullCheck(String param){
    if(param==null)return "";
    else return param;
  }


}
