import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFBean.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/Beans/TermDepositClosureBean.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/NewTermDepositBean.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermDepositClosureServices{
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlgetTDClos = "TDClosure/getTDDetails";
  var urlclosTD = "TDClosure/postTDClosure";
  static const JsonCodec JSON = const JsonCodec();
  /*Future<List<NewTermDepositBean> > getListForTdClosure(int lbrCode, String userCode ) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      return await getTermDepositListFromMiddleware(lbrCode ,userCode);
    }
  }
  Future<List<NewTermDepositBean>> getTermDepositListFromMiddleware(int lbrcode,String usrcode) async {
    String json;

    json =  await getJson(lbrcode,usrcode);
    print("json"+json.toString());
    String bodyValue = await NetworkUtil.callPostService(json.toString(),
        Constant.apiURL.toString() ,_headers);
    print("url " + Constant.apiURL.toString() );
    if (bodyValue == "404" ||bodyValue ==null) {
      print("404");
      return null;
    } else {
      print("bodyValue"+bodyValue);
      final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
      List<NewTermDepositBean> obj = parsed
          .map<CIFBean>(
              (json) => NewTermDepositBean.fromMapMiddleware(json))
          .toList();
      print("json"+json.toString());
      return obj;
    }
  }*/

  Future<String> getJson (String prdaccid,int mcshorsav ,String mselectedsavingacc,double mmatval,String userCode,int lbrcode) async{
    Map map = new Map();
    map[TablesColumnFile.mprdacctid] = ifNullCheck(prdaccid);
    map[TablesColumnFile.mcreatedby] = ifNullCheck(userCode);
    map[TablesColumnFile.mlbrcode] = lbrcode;
    map[TablesColumnFile.mcshorsav] = mcshorsav==null?0:mcshorsav;
    map[TablesColumnFile.mselectedsavingacc] = ifNullCheck(mselectedsavingacc);
    map[TablesColumnFile.mmatval] = mmatval;

    String returnigJson = await JSON.encode(map);
    return returnigJson;
  }


  Future<String> getJsonDetails (String prdaccid,String userCode,int lbrcode) async{
    Map map = new Map();
    map[TablesColumnFile.mprdacctid] = ifNullCheck(prdaccid);
    map[TablesColumnFile.mcreatedby] = ifNullCheck(userCode);
    map[TablesColumnFile.mlbrcode] = lbrcode;
    String returnigJson = await JSON.encode(map);
    return returnigJson;
  }


  String ifNullCheck(String param){
    if(param==null)return "";
    else return param;
  }


  Future <TermDepositClosureBean> getTermDepositClosureDetails(String prdacctId) async {
    String json;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString(TablesColumnFile.musrcode);
    int lbrCd    = prefs.getInt(TablesColumnFile.musrbrcode);

    json =  await getJsonDetails(prdacctId,username,lbrCd);
    print("json"+json.toString());
    String bodyValue = await NetworkUtil.callPostService(json.toString(),
        Constant.apiURL.toString()+urlgetTDClos ,_headers);
    print("url " + Constant.apiURL.toString()+urlgetTDClos  );
    if (bodyValue == "404" ||bodyValue ==null) {
      print("404");
      return null;
    } else {
      print("bodyValue"+bodyValue);
      Map<String, dynamic> map = JSON.decode(bodyValue);
      TermDepositClosureBean obj = TermDepositClosureBean.fromMapMiddleware(map);
      print("json"+json.toString());
      return obj;
    }
  }




  Future <TermDepositClosureBean> postTermDepositClosure(TermDepositClosureBean tdClosureBean) async {
    String json;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString(TablesColumnFile.musrcode);
    int lbrCd    = prefs.getInt(TablesColumnFile.musrbrcode);

    json =  await getJson(tdClosureBean.mprdacctid,tdClosureBean.mcshorsav,tdClosureBean.mselectedsavingacc,
        tdClosureBean.mmatamt,username,lbrCd);
    print("json"+json.toString());
    String bodyValue = await NetworkUtil.callPostService(json.toString(),
        Constant.apiURL.toString()+urlclosTD ,_headers);
    print("url " + Constant.apiURL.toString()+urlclosTD  );
    if (bodyValue == "404" ||bodyValue ==null) {
      print("404");
      return null;
    } else {
      print("bodyValue"+bodyValue);
      Map<String, dynamic> map = JSON.decode(bodyValue);
      TermDepositClosureBean obj = TermDepositClosureBean.fromMapMiddleware(map);
      print("json"+json.toString());
      return obj;
    }
  }


}
