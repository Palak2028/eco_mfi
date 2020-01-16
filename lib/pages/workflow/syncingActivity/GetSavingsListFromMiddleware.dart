import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:path_provider/path_provider.dart';

class GetSavingsListFromMiddleware{
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlGetSavingsListDetails =
      "SavingsListController/getSavingsListbyCreatedByAndLastSyncedTiming/";
  static const JsonCodec JSON = const JsonCodec();
  ImageBean setBean;

  Future<Null> trySave(String userName) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      await getMiddleWareData(userName, urlGetSavingsListDetails);
    }
  }


  Future<Null> getMiddleWareData(
      String userName, String url) async {
    //await AppDatabase.get().deletSomeUtil();

    String json;
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(11,true)
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
        print(bodyValue);
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        DateTime updateDateimeAfterUpdate = DateTime.now();
        List<SavingsListBean> obj = parsed
            .map<SavingsListBean>(
                (json) => SavingsListBean.fromMapMiddleware(json, true))
            .toList();

        for (int svngs = 0; svngs < obj.length; svngs++) {
          await AppDatabase.get()
              .updateSavingsListMaster(obj[svngs])
              .then((onValue) {
            // customerNumberValue = onValue;
          });

          print("Savings Mater Update Complete");


        }
        //updating lastsynced date time with now
        AppDatabase.get().updateStaticTablesLastSyncedMasterGetFromServer(11,updateDateimeAfterUpdate);

        await AppDatabase.get()
            .selectStaticTablesLastSyncedMaster(11,false)
            .then((onValue) async {
          if(onValue==null){
            AppDatabase.get().updateStaticTablesLastSyncedMaster(11);
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
    mapData["mlastsynsdate"] = lastsyncedDateTime!=null && lastsyncedDateTime!='null' && lastsyncedDateTime!=''? lastsyncedDateTime.toIso8601String():null;
    String json = JSON.encode(mapData);
    print(json);
    return json;
  }

}