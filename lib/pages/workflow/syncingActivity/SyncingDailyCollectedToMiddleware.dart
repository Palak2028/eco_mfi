import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/collection/bean/CollectionMasterBean.dart';


class SyncingDailyCollectedToMiddleware {
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();
  String _serviceUrl;

  Future<Null> syncDailyCollection(List listValue) async {
    try {

      String bodyValue  = await NetworkUtil.callPostService(listValue.toString(),Constant.apiURL.toString()+_serviceUrl.toString(),_headers);
      print("url "+Constant.apiURL.toString()+_serviceUrl.toString());
      if(bodyValue == "404" ){
        return null;
      } else {
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
    if(parsed!=null){
      AppDatabase.get().deletSomeSyncingActivityFromOmni("collectedLoansAmtMaster");
      }
         //updating lastsynced date time with now
        AppDatabase.get().updateStaticTablesLastSyncedMaster(7);
      }

    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }


  Future<Null> getAndSync() async {
    List _collectionMasterBeanList = new List();
   try {
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(7,false)
        .then((onValue) async {

      await AppDatabase.get().getDailyColletedNotSynced(onValue).then((dailyCollectedList) async{
        for (int dailyCollectedbean = 0; dailyCollectedbean < dailyCollectedList.length; dailyCollectedbean++) {
          await _toJsonDailyCollected(dailyCollectedList[dailyCollectedbean]).then((onValue) async {
            for(var item in onValue.split(",")){
              print("Collection Json " + item);
            }


            _collectionMasterBeanList.add(onValue.toString());
          });
        }
        _serviceUrl = "DailyLoanCollectedController/add/";
        await syncDailyCollection(_collectionMasterBeanList);
      });
    });
     }

   catch (e) {
      print('Server Exception!!!');

    }
  }

  Future<String> _toJsonDailyCollected( CollectionMasterBean   collectionMasterBean) async {
    var map = new Map();
    map[TablesColumnFile.trefno]  = collectionMasterBean.trefno!=null?collectionMasterBean.trefno:0;
    map[TablesColumnFile.mlbrcode]  =  collectionMasterBean.mlbrcode!=null?collectionMasterBean.mlbrcode:0;
    map[TablesColumnFile.mprdacctid]  = ifNullCheck(collectionMasterBean.mprdacctid);
    map[TablesColumnFile.mcenterid]  = collectionMasterBean.mcenterid!=null?collectionMasterBean.mcenterid:0;
    map[TablesColumnFile.mgroupid]  = collectionMasterBean.mgroupid!=null?collectionMasterBean.mgroupid:0;
    map[TablesColumnFile.mfocode]  = ifNullCheck(collectionMasterBean.mfocode);
    map[TablesColumnFile.memino]  = collectionMasterBean.memino!=null?collectionMasterBean.memino:0;
    map[TablesColumnFile.mexpdt]  = collectionMasterBean.mexpdate!=null?collectionMasterBean.mexpdate.toIso8601String():null;
    map[TablesColumnFile.malmeffdate]  = collectionMasterBean.malmeffdate!=null?collectionMasterBean.malmeffdate.toIso8601String():null;
    map[TablesColumnFile.midealbaldate]  = collectionMasterBean.midealbaldate!=null?collectionMasterBean.midealbaldate.toIso8601String():null;
    map[TablesColumnFile.mcreateddt]  = collectionMasterBean.mcreateddt!=null?collectionMasterBean.mcreateddt.toIso8601String():null;
    // map[TablesColumnFile.mlastupdatedt]  = collectionMasterBean.midealbaldate!=null?collectionMasterBean.midealbaldate.toIso8601String():null;
    map[TablesColumnFile.madjfrmsd]  = collectionMasterBean.madjFrmSD!=null?collectionMasterBean.madjFrmSD:0;
    map[TablesColumnFile.madjfrmexcss]  = collectionMasterBean.madjfrmexcss!=null?collectionMasterBean.madjfrmexcss:0;
    map[TablesColumnFile.mpaidbygrp]  = collectionMasterBean.mpaidByGrp!=null?collectionMasterBean.mpaidByGrp:0;
    map[TablesColumnFile.mattndnc]  = collectionMasterBean.mattendence!=null?collectionMasterBean.mattendence:0;
    map[TablesColumnFile.mcustno]  = collectionMasterBean.mcustno!=null?collectionMasterBean.mcustno:0;
    map[TablesColumnFile.mremarks]  = ifNullCheck(collectionMasterBean.mremarks);
    map[TablesColumnFile.mcollamt]  = collectionMasterBean.mcollAmt!=null?collectionMasterBean.mcollAmt:0.0;
    map[TablesColumnFile.mbatchcd]  = ifNullCheck(collectionMasterBean.mbatchcd);
    String json = JSON.encode(map);
    print("Mapping Data Complete"+json.toString());
    return json;
  }

  String ifNullCheck(String value) {
    if (value == null || value == 'null' ) {
      value = "";
    }
    return value;
  }
}
