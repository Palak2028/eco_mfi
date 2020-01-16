import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFRepayScheduleBean.dart';

class GetRepaymentScheduleFromOmni{
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlGetRepaySchedule =
      "CIF/getRepaymentSchedule/";
  static const JsonCodec JSON = const JsonCodec();
  //ImageBean setBean;
  Future<List<CIFRepayScheduleBean> > trySave(String mprdaccid, String mleadsid) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
     return await getMiddleWareData(mprdaccid, mleadsid, urlGetRepaySchedule);
    }
  }
  Future<List<CIFRepayScheduleBean> > getMiddleWareData(String mprdaccid,String mleadsid, String url) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    int lbrCode = prefs.getInt(TablesColumnFile.musrbrcode);
      String json;
      json =  await getJson(mprdaccid,mleadsid);
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
        List<CIFRepayScheduleBean> obj = parsed
            .map<CIFRepayScheduleBean>(
                (json) => CIFRepayScheduleBean.fromMapMiddleware(json, true))
            .toList();
        print("json"+json.toString());
        return obj;
      }
  }


  Future<String> getJson (String prdAccId,String LeadsId) async{
    Map map = new Map();
    map[TablesColumnFile.mprdacctid] = ifNullCheck(prdAccId);
    map[TablesColumnFile.mleadsid] =  ifNullCheck(LeadsId);
    String returnigJson = await JSON.encode(map);
    return returnigJson;

  }


  String ifNullCheck(String param){
    if(param==null)return "";
    else return param;
  }


}
