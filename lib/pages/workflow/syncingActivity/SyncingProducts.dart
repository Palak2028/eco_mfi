import 'dart:convert';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';

class SyncingProducts{


  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlGetProductInfo=
      "productData/getDataByLbrCode/";
  static const JsonCodec JSON = const JsonCodec();


  Future<Null> trySave(int lbrCode) async {
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      await getMiddleWareData(lbrCode, urlGetProductInfo);
    }
  }

  Future<Null> getMiddleWareData(
      int lbrCode, String url) async {

    try {
      String json2 = _toJsonOfAgentUserName(lbrCode);
      //String bodyValue  = await NetworkUtil.callGetService(Constant.apiURL.toString()+url.toString());
      String bodyValue  = await NetworkUtil.callPostService(json2,Constant.apiURL.toString()+url.toString(),_headers);
      print("body val "+bodyValue.toString());
      if(bodyValue == "404" ){
        return null;
      }else if(bodyValue!=null && bodyValue.toString() !='null') {
          final parsed = json.decode(bodyValue).cast<Map<String, dynamic>>();
          await AppDatabase.get().deletSomeSyncingActivityFromOmni('Product');
          List<ProductBean> obj =
          parsed.map<ProductBean>((json) => ProductBean.fromMap(json)).toList();
          for (ProductBean items in obj) {
            await AppDatabase.get().updateProductMaster(items);
          }


      }
    } catch (e) {}
  }


  String _toJsonOfAgentUserName(int lbrCode) {
    print(lbrCode.toString());
    var mapComposite = new Map();

    var mapData = new Map();
    mapData[TablesColumnFile.mlbrcode] = lbrCode;
    mapComposite[TablesColumnFile.productComposieEntity]=mapData;
    String json = JSON.encode(mapComposite);
    print(json.toString());
    return json;
  }
}