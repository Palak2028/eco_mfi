import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerAuthorizationBean.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetCustAuthDetailsFromOmni{
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  CustomerAuthorizationBean custAuthBean = new CustomerAuthorizationBean();
  var urlGetCIFDetails = "custAuth/getCustAuthDetail";
  static const JsonCodec JSON = const JsonCodec();
  Future<List<CustomerAuthorizationBean> > trySave(CustomerAuthorizationBean custAuthBean) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      return await getMiddleWareData(custAuthBean, urlGetCIFDetails);
    }
  }
  Future<List<CustomerAuthorizationBean> > getMiddleWareData(CustomerAuthorizationBean custAuthBean, String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lbrCode = prefs.getInt(TablesColumnFile.musrbrcode);
    String json;

    json =  await getJson(custAuthBean,lbrCode);
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
      List<CustomerAuthorizationBean> obj = parsed
          .map<CustomerAuthorizationBean>(
              (json) => CustomerAuthorizationBean.fromMapMiddleware(json, true))
          .toList();
      print("json"+json.toString());
      return obj;
    }
  }

  Future<String> getJson (CustomerAuthorizationBean bean,int lbrCode) async{
    Map map = new Map();

    map[TablesColumnFile.mcustno] =  bean.mcustno;
    map[TablesColumnFile.mnid] =  bean.mnid;
    String returnigJson = await JSON.encode(map);
    return returnigJson;
  }

  String ifNullCheck(String param){
    if(param==null)return "";
    else return param;
  }

}
