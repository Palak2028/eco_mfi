import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/bean/GLAccountBean.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/bean/InternalBankTransferBean.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GLAccountTransferService{
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlgetGLAccountList=
      "glAccount/getDataByMlbrcode";
  static const JsonCodec JSON = const JsonCodec();


  Future<String> getJson (int lbrcode,username) async{
    Map map = new Map();

    map[TablesColumnFile.mlbrcode] =  lbrcode;
    String returnigJson = await JSON.encode(map);
    return returnigJson;
  }

  String ifNullCheck(String param){
    if(param==null)return "";
    else return param;
  }


  Future<List<GLAccountBean>> getGLAccountList() async {
    String json;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString(TablesColumnFile.musrcode);
    int lbrCd    = prefs.getInt(TablesColumnFile.musrbrcode);

    json =  await getJson(lbrCd,username);
    print("json"+json.toString());
    String bodyValue = await NetworkUtil.callPostService(json.toString(),
        Constant.apiURL.toString()+urlgetGLAccountList ,_headers);
    print("url " + Constant.apiURL.toString()+urlgetGLAccountList );
    if (bodyValue == "404" ||bodyValue ==null) {
      print("404");
      return null;
    } else {
      print("body Value"+bodyValue);
      final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
      List<GLAccountBean> obj = parsed
          .map<GLAccountBean>(
              (json) => GLAccountBean.fromMapMiddleware(json, true))
          .toList();
      print("json"+json.toString());
      return obj;
    }
  }




}
