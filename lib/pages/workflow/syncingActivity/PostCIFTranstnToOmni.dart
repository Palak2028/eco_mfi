import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFBean.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostCIFTranstnToOmni{
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlGetCIFDetails =
      "CIF/getCifTransactionDetails/";
  static const JsonCodec JSON = const JsonCodec();
  Future<List<CIFBean> > trySave(CIFBean cifBean) async {
    //String mnid;
    //int mcustno;
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      return await getMiddleWareData(cifBean, urlGetCIFDetails);
    }
  }
  Future<List<CIFBean> > getMiddleWareData(CIFBean cifBean, String url) async {
    String json;

    json =  await getJson(cifBean);
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
      List<CIFBean> obj = parsed
          .map<CIFBean>(
              (json) => CIFBean.fromMapMiddleware(json, true))
          .toList();
      print("json"+json.toString());
      return obj;
    }
  }

  Future<String> getJson (CIFBean bean) async{
    Map map = new Map();
    //map[TablesColumnFile.mcustno] = bean.mcustno;
    map[TablesColumnFile.mlbrcode] = bean.mlbrcode;
    map[TablesColumnFile.mprdacctid] = bean.mprdacctid;
    map[TablesColumnFile.mamt] = bean.mamt;
    map[TablesColumnFile.mremark] = bean.mremark;
    map[TablesColumnFile.mnarration] = bean.mnarration;
    map[TablesColumnFile.mcreatedby] = bean.mcreatedby;

    String returnigJson = await JSON.encode(map);
    return returnigJson;
  }

  String ifNullCheck(String param){
    if(param==null)return "";
    else return param;
  }

}
