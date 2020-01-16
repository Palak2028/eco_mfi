import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFLoanClosureBean.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostCIFLoanClosureTranstnToOmni{
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  CIFLoanClosureBean cifLoanClosureBean = new CIFLoanClosureBean();
  var urlGetCIFDetails = "CIF/postLoanClosureVoucher/";
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
    map[TablesColumnFile.mprdacctid] = bean.mprdacctid;//1
    map[TablesColumnFile.mentrydate] = entryDate;
    map[TablesColumnFile.mstartdt] = bean.mstartdt;
    map[TablesColumnFile.minterestaccruedtilldt] = bean.minterestaccruedtilldt;
    map[TablesColumnFile.mclosurecharges] = bean.mclosurecharges;//5
    map[TablesColumnFile.mclosureamtasondate] = bean.mclosureamtasondate;
    map[TablesColumnFile.mwaiveoffamt] = bean.mwaiveoffamt;
    map[TablesColumnFile.mamttobepaidforclosure] = bean.mamttobepaidforclosure;
    map[TablesColumnFile.mprincipalos] = bean.mprincipalos;
    map[TablesColumnFile.minterestos] = bean.minterestos;//10
    map[TablesColumnFile.mpenalos] = bean.mpenalos;
    map[TablesColumnFile.motherchargesos] = bean.motherchargesos;
    map[TablesColumnFile.mprincipalpaid] = bean.mprincipalpaid;
    map[TablesColumnFile.minterestpaid] = bean.minterestpaid;
    map[TablesColumnFile.mpenalpaid] = bean.mpenalpaid;//15
    map[TablesColumnFile.motherchargespaid] = bean.motherchargespaid;
    map[TablesColumnFile.mnoofinslpaid] = bean.mnoofinslpaid;
    map[TablesColumnFile.mnoofdefaults] = bean.mnoofdefaults;
    map[TablesColumnFile.mprincipalosdue] = bean.mprincipalosdue;
    map[TablesColumnFile.minterestosdue] = bean.minterestosdue;//20
    map[TablesColumnFile.mpenalosdue] = bean.mpenalosdue;
    map[TablesColumnFile.motherchargesosdue] = bean.motherchargesosdue;
    map[TablesColumnFile.mremark] = bean.mremark;
    map[TablesColumnFile.mpaymntmode] = bean.mpaymntmode;
    map[TablesColumnFile.mlbrcode] =  bean.mlbrcode;

    String returnigJson = await JSON.encode(map);
    return returnigJson;
  }

  String ifNullCheck(String param){
    if(param==null)return "";
    else return param;
  }

}
