import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_mfi/pages/workflow/disbursment/bean/DisbursmentBean.dart';
import 'package:path_provider/path_provider.dart';

class GetDisbursmentListFromMiddleware{
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlGetDisbursmentListDetails =
      "DisbursmentListController/getDisbursmentListbyCreatedByAndLastSyncedTiming/";
  static const JsonCodec JSON = const JsonCodec();
  ImageBean setBean;

  Future<Null> trySave(String userName) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      await getMiddleWareData(userName, urlGetDisbursmentListDetails);
    }
  }


  Future<Null> getMiddleWareData(
      String userName, String url) async {
    await AppDatabase.get().deletSomeSyncingActivityFromOmni('Disbursment_Master');

    String json;
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(16,true)
        .then((onValue) async {
      json = _toJsonOfCreatedByAndLastSyncedDateTime(userName,onValue);
    });
    try {
      String bodyValue = await NetworkUtil.callPostService(json.toString(),
          Constant.apiURL.toString() + url.toString(), _headers);
      print("url " + Constant.apiURL.toString() + url.toString());
      if (bodyValue == "404" ) {
        return null;
      } else {
        print("returned Value is $bodyValue");
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        DateTime updateDateimeAfterUpdate = DateTime.now();
        List<DisbursmentBean> obj = parsed
            .map<DisbursmentBean>(
                (json) => DisbursmentBean.fromMapMiddleware(json, true))
            .toList();

    for (int dsbrs = 0; dsbrs< obj.length; dsbrs++) {
    await AppDatabase.get()
        .updateDisbursmentMaster(obj[dsbrs])
        .then((onValue) {
    // customerNumberValue = onValue;
    });

    print("Savings Mater Update Complete");


    }
        //updating lastsynced date time with now
        AppDatabase.get().updateStaticTablesLastSyncedMasterGetFromServer(12,updateDateimeAfterUpdate);

        await AppDatabase.get()
            .selectStaticTablesLastSyncedMaster(12,false)
            .then((onValue) async {
          if(onValue==null){
            AppDatabase.get().updateStaticTablesLastSyncedMaster(12);
          }

        });
      }

    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }

  }

  String _toJsonOfCreatedByAndLastSyncedDateTime(String createdBy, DateTime lastsyncedDateTime) {
    var mapData = new Map();
    mapData["mcreatedby"] = createdBy.trim();
    mapData["mlastsynsdate"] = null;


    //lastsyncedDateTime!=null && lastsyncedDateTime!='null' && lastsyncedDateTime!=''? lastsyncedDateTime.toIso8601String():null;
    String json = JSON.encode(mapData);
    print(json);
    return json;
  }

}