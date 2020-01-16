import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/bean/InternalBankTransferBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFBean.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/NewTermDepositBean.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InternalBankTransferService{
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlPostTransaction=
      "internalBankTransfer/doTransaction";
  static const JsonCodec JSON = const JsonCodec();


  Future<String> getJson (InternalBankTransferBean internalBanktransferBean) async{
    Map map = new Map();


    map[TablesColumnFile.mcashtr] = internalBanktransferBean.mcashtr;
    map[TablesColumnFile.mcrdr] =  ifNullCheck(internalBanktransferBean.mcrdr);
    map[TablesColumnFile.mremark] =  ifNullCheck(internalBanktransferBean.mremark);
    map[TablesColumnFile.mnarration] =  ifNullCheck(internalBanktransferBean.mnarration);
    map[TablesColumnFile.mamt] =  internalBanktransferBean.mamt;
    map[TablesColumnFile.maccid] =  ifNullCheck(internalBanktransferBean.maccid);
    map[TablesColumnFile.mdraccid] =  ifNullCheck(internalBanktransferBean.mdraccid);
    map[TablesColumnFile.mcraccid] =  ifNullCheck(internalBanktransferBean.mcraccid);
    map[TablesColumnFile.mlbrcode] =  internalBanktransferBean.mlbrcode;
    map[TablesColumnFile.mcreatedby] =  ifNullCheck(internalBanktransferBean.mcreatedby);
    String returnigJson = await JSON.encode(map);
    return returnigJson;
  }

  String ifNullCheck(String param){
    if(param==null)return "";
    else return param;
  }


  Future<InternalBankTransferBean> postInternalBanktransfer(InternalBankTransferBean internalBanktransferBean) async {
    String json;
   /*SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString(TablesColumnFile.musrcode);
    int lbrCd    = prefs.getInt(TablesColumnFile.musrbrcode);
    */

    json =  await getJson(internalBanktransferBean);
    print("json"+json.toString());
    String bodyValue = await NetworkUtil.callPostService(json.toString(),
        Constant.apiURL.toString()+urlPostTransaction ,_headers);
    print("url " + Constant.apiURL.toString()+urlPostTransaction );
    if (bodyValue == "404" ||bodyValue ==null) {
      print("404");
      return null;
    } else {
      print("bodyValue"+bodyValue);
     // final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();

      Map<String, dynamic> map = JSON.decode(bodyValue);
      print(json + " form jso obj response" + "here is" + map.toString());
      InternalBankTransferBean obj = InternalBankTransferBean.fromMapMiddleware(map);
      print("json"+json.toString());
      return obj;
    }
  }




}
