import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFLoanClosureBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFSavingAcctClosureBean.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostCIFSavingAcctClosureTranstnToOmni{
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  CIFSavingAcctClosureBean cifSavingAcctClosureBean = new CIFSavingAcctClosureBean();
  var urlGetCIFDetails = "CIF/postSavingAcctClosureVoucher/";
  static const JsonCodec JSON = const JsonCodec();
  Future<List<CIFSavingAcctClosureBean> > trySave(CIFSavingAcctClosureBean cifSavingAcctClosureBean) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      return await getMiddleWareData(cifSavingAcctClosureBean, urlGetCIFDetails);
    }
  }
  Future<List<CIFSavingAcctClosureBean> > getMiddleWareData(CIFSavingAcctClosureBean cifSavingAcctClosureBean, String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lbrCode = prefs.getInt(TablesColumnFile.musrbrcode);
    String json;

    json =  await getJson(cifSavingAcctClosureBean,lbrCode);
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
      List<CIFSavingAcctClosureBean> obj = parsed
          .map<CIFSavingAcctClosureBean>(
              (json) => CIFSavingAcctClosureBean.fromMapMiddleware(json, true))
          .toList();
      print("json"+json.toString());
      return obj;
    }
  }

  Future<String> getJson (CIFSavingAcctClosureBean bean,int lbrCode) async{
    Map map = new Map();
    map[TablesColumnFile.mprdacctid] = bean.mprdacctid;
    map[TablesColumnFile.mlbrcode] =  bean.mlbrcode;

    String returnigJson = await JSON.encode(map);
    return returnigJson;
  }

  String ifNullCheck(String param){
    if(param==null)return "";
    else return param;
  }

}
