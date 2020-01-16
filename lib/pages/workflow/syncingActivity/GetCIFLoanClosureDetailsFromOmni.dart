import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFLoanClosureBean.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetCIFLoanClosureDetailsFromOmni{
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  CIFLoanClosureBean cifLoanClosureBean = new CIFLoanClosureBean();
  var urlGetCIFDetails = "CIF/getLoanClosureDetail/";
  static const JsonCodec JSON = const JsonCodec();
  Future<List<CIFLoanClosureBean> > trySave(CIFLoanClosureBean cifLoanClosureBean) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      return await getMiddleWareData(cifLoanClosureBean, urlGetCIFDetails);
    }
  }
  Future<List<CIFLoanClosureBean> > getMiddleWareData(CIFLoanClosureBean cifLoanClosureBean, String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lbrCode = prefs.getInt(TablesColumnFile.musrbrcode);
    String json;

    json =  await getJson(cifLoanClosureBean,lbrCode);
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
      List<CIFLoanClosureBean> obj = parsed
          .map<CIFLoanClosureBean>(
              (json) => CIFLoanClosureBean.fromMapMiddleware(json, true))
          .toList();
      print("json"+json.toString());
      return obj;
    }
  }

  Future<String> getJson (CIFLoanClosureBean bean,int lbrCode) async{
    Map map = new Map();
    String entryDate = bean.mentrydate.substring(0, 4).toString()+bean.mentrydate.substring(5, 7).toString()+bean.mentrydate.substring(8, 10).toString();
    map[TablesColumnFile.mprdacctid] = bean.mprdacctid;
    map[TablesColumnFile.mentrydate] = entryDate;
    map[TablesColumnFile.mlbrcode] =  bean.mlbrcode;
    String returnigJson = await JSON.encode(map);
    return returnigJson;
  }

  String ifNullCheck(String param){
    if(param==null)return "";
    else return param;
  }

}
