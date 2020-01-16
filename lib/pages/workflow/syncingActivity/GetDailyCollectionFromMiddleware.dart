import 'dart:async';
import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';

import 'package:eco_mfi/pages/workflow/collection/bean/CollectionMasterBean.dart';

class GetDailyCollectionFromMiddleware {

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlDailyCollectionSheet=
      "DailyLoanCollectionController/getDailyLoanbyCreatedByAndLbr/";
  static const JsonCodec JSON = const JsonCodec();



  // Add same in syncing activity  to get collection for as on date
  Future<Null> trySave(int lbrCode,String usrCode) async {
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      await getMiddleWareData(lbrCode, urlDailyCollectionSheet,usrCode);
    }
  }

  Future<Null> getMiddleWareData(
      int lbrCode, String url,String usrcode) async {

    try {

      String json2 = _toJsonOfCollectionPost(lbrCode,usrcode);
      String bodyValue  = await NetworkUtil.callPostService(json2,Constant.apiURL.toString()+url.toString(),_headers);
      print("body val "+bodyValue.toString());

      print("gfgffffffffffffffffffffffffffffffffff"+json2.toString());
      if(bodyValue == "404" ){
        return null;
      }else if(bodyValue!=null && bodyValue.toString() !='null') {
        final parsed = json.decode(bodyValue).cast<Map<String, dynamic>>();
        for (int i = 0; i < parsed.length; i++) {
          print("result" + parsed[i].toString());

        }

        await AppDatabase.get().deletSomeSyncingActivityFromOmni('Collection');
        List<CollectionMasterBean> obj =
        parsed.map<CollectionMasterBean>((json) => CollectionMasterBean.fromMap(json)).toList();
        for (CollectionMasterBean items in obj) {
          await AppDatabase.get().createCollectionInsert(items);
        }

      }
    } catch (e) {}
  }


  String _toJsonOfCollectionPost(int lbrCode,String usrCode) {
    print(lbrCode.toString());
    var mapData = new Map();
    mapData[TablesColumnFile.mlbrcode] = lbrCode;
    mapData[TablesColumnFile.mcreatedby]=usrCode;
    String json = JSON.encode(mapData);
    return json;
  }
}



