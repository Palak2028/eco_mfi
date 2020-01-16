import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/BulkLoanPreClosure/bean/BulkLoanPreClosureBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFLoanClosureBean.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostBulkLoanClosureTranstnToOmni{
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  BulkLoanPreClosureBean bulkLoanPreClosureBean = new BulkLoanPreClosureBean();
  var urlDetails = "bulkPreClosure/postVoucher/";
  static const JsonCodec JSON = const JsonCodec();
  Future<List<BulkLoanPreClosureBean> > trySave(List<BulkLoanPreClosureBean> bulkLoanPreClosureBean) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      return await getMiddleWareData(bulkLoanPreClosureBean, urlDetails);
    }
  }
  Future<List<BulkLoanPreClosureBean> > getMiddleWareData(List<BulkLoanPreClosureBean> bulkLoanPreClosureBean, String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lbrCode = prefs.getInt(TablesColumnFile.musrbrcode);
    String json;
    List accJsonList = List();
    for (int saveData = 0; saveData < bulkLoanPreClosureBean.length; saveData++) {
        json =  await getJson(bulkLoanPreClosureBean[saveData],lbrCode);
        accJsonList.add(json);
    }
    print("accJsonList-json"+accJsonList.toString());
    String bodyValue = await NetworkUtil.callPostService(accJsonList.toString(),
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

  Future<String> getJson (BulkLoanPreClosureBean bean,int lbrCode) async{
    Map map = new Map();

    map[TablesColumnFile.mprdacctid] = bean.mprdacctid;
    map[TablesColumnFile.mamttocollect] = bean.mamttocollect;
    map[TablesColumnFile.mcollamt] = bean.mcollamt;
    map[TablesColumnFile.minterestos] = bean.minterestos;
    map[TablesColumnFile.mremarks] = bean.mremarks;
    map[TablesColumnFile.mlbrcode] = lbrCode;
    String returnigJson = await JSON.encode(map);
    return returnigJson;
  }

  String ifNullCheck(String param){
    if(param==null)return "";
    else return param;
  }

}
