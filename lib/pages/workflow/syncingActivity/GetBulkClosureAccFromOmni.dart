import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/BulkLoanPreClosure/bean/BulkLoanPreClosureBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFBean.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetBulkClosureAccFromOmni{
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlDetails =
      "bulkPreClosure/getAccDetails/";
  static const JsonCodec JSON = const JsonCodec();
  Future<List<BulkLoanPreClosureBean> > trySave(int mgroupcd ) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      return await getMiddleWareData(mgroupcd ,urlDetails);
    }
  }
  Future<List<BulkLoanPreClosureBean> > getMiddleWareData(int mgroupcd, String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lbrcode = prefs.getInt(TablesColumnFile.musrbrcode);
    String json;

    json =  await getJson(mgroupcd,lbrcode);
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
      List<BulkLoanPreClosureBean> obj = parsed
          .map<BulkLoanPreClosureBean>(
              (json) => BulkLoanPreClosureBean.fromMapMiddleware(json, true))
          .toList();
      print("json"+json.toString());
      return obj;
    }
  }

  Future<String> getJson (int groupcd, int lbrcode) async{
    Map map = new Map();
    map[TablesColumnFile.mgroupcd] = groupcd;
    map[TablesColumnFile.mlbrcode] =  lbrcode;
    String returnigJson = await JSON.encode(map);
    return returnigJson;
  }

  String ifNullCheck(String param){
    if(param==null)return "";
    else return param;
  }

}
