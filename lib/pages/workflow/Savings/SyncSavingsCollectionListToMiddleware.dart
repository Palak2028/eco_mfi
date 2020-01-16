import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';

import 'package:path_provider/path_provider.dart';

class SyncingSavingsCollectionListtoMiddleware {
  static const JsonCodec JSON = const JsonCodec();
  static String _serviceUrl = "";
  static final _headers = {'Content-Type': 'application/json'};


  List listSavingsCollection = List();

  Future<Null> syncedDataToMiddleware(String json) async {
    //  try {
    String bodyValue = await NetworkUtil.callPostService(json.toString(),
        Constant.apiURL.toString() + _serviceUrl.toString(), _headers);
    print("url " + Constant.apiURL.toString() + _serviceUrl.toString());
    print("bodyValue"+bodyValue.toString());
    if (bodyValue == "404" ) {

      return null;
    } else {

      AppDatabase.get().updateStaticTablesLastSyncedMaster(12);
    }
  }
  /*} catch (e) {
      print('Server Exception!!!');
      print(e);
    }*/


  Future<Null> saveSavingsCollectionlData() async {
    List savingsCollectionList = new List();

    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(12,false)
        .then((onValue) async {
      await AppDatabase.get()
          .selectSavingsCollectionListIsDataSynced(onValue)
          .then((List<SavingsListBean> savingsCollectionList) async {
        for (int i = 0; i < savingsCollectionList.length; i++) {
          print("length of Savings Collection List " + savingsCollectionList.length.toString());


          await _toJson(savingsCollectionList[i]).then((onValue) {});
          /*     await _tosaveomerJson(saveomerData[i]).then((onValue){
          saveomerList.add(onValue);
        });*/
        }

      });


      _serviceUrl = "/SavingsCollectionListController/add/";
      String json = JSON.encode(listSavingsCollection);
      for (var items in json.toString().split(",")) {
        print("Json values" + items.toString());
      }

      await syncedDataToMiddleware(json);
      //after call needs to update mref in tab in all tables and update lastsynced in lastsynced date time table
    });
  }



  Future<String> _toJson(SavingsListBean bean) async{
    var mapData = new Map();
print("mapData"+mapData.toString());

    mapData[TablesColumnFile.trefno] =	bean.trefno!=null ? bean.trefno:0;
    mapData[TablesColumnFile.mrefno] = bean.mrefno != null ? bean.mrefno : 0;
    mapData[TablesColumnFile.msvngacctrefno] = bean.msvngacctrefno != null ? bean.msvngacctrefno : 0;
    mapData[TablesColumnFile.msvngaccmrefno] = bean.msvngaccmrefno != null ? bean.msvngaccmrefno : 0;
    mapData[TablesColumnFile.mlbrcode] =	bean.mlbrcode!=null?bean.mlbrcode:0;
    mapData[TablesColumnFile.mprdacctid] =	ifNullCheck(bean.mprdacctid);
    mapData[TablesColumnFile.mcollectiondate] =	ifDateNullCheck(bean.mcollectiondate);
    mapData[TablesColumnFile.mcollectedamount] =bean.mcollectedamount!=null?bean.mcollectedamount:0;
    mapData[TablesColumnFile.mmoduletype] =bean.mmoduletype!=null ? bean.mmoduletype:0;
    mapData[TablesColumnFile.mremark] =ifNullCheck(bean.mremark);
    mapData[TablesColumnFile.mcashflow] =ifNullCheck(bean.mcashflow);
    mapData[TablesColumnFile.mlbrcode] = bean.mlbrcode != null ? bean.mlbrcode : 0;
    mapData[TablesColumnFile.mcreateddt] =	ifDateNullCheck(bean.mcreateddt);
    mapData[TablesColumnFile.mcreatedby] =ifNullCheck(bean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] =	ifDateNullCheck(bean.mlastupdatedt);
    mapData[TablesColumnFile.mlastupdateby] =ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] =ifNullCheck(bean.mgeolocation);
    mapData[TablesColumnFile.mbatchcd] =ifNullCheck(bean.mbatchcd);
    mapData[TablesColumnFile.mgeolatd] =ifNullCheck(bean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] =ifNullCheck(bean.mgeologd);
    mapData[TablesColumnFile.mlastsynsdate] =	ifDateNullCheck(bean.mlastsynsdate);
    mapData[TablesColumnFile.isDataSynced] = 1;

    listSavingsCollection.add(mapData);

  }

  String ifDateNullCheck(DateTime value){
    if(value==null || value == 'null'){
      return "";
    }
    else {
      return  value.toIso8601String();
    }

  }
  String ifNullCheck(String value) {
    if (value == null || value == 'null' ) {
      value = "";
    }
    return value;
  }
}
