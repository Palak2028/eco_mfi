import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';

import 'package:path_provider/path_provider.dart';

class SyncingSavingsListtoMiddleware {
  static const JsonCodec JSON = const JsonCodec();
  static String _serviceUrl = "";
  static final _headers = {'Content-Type': 'application/json'};


  List listSavings = List();

  Future<Null> syncedDataToMiddleware(String json) async {
    try {



      print("json is $json");
      String bodyValue = await NetworkUtil.callPostService(json.toString(),
          Constant.apiURL.toString() + _serviceUrl.toString(), _headers);
      print("url " + Constant.apiURL.toString() + _serviceUrl.toString());
      print("bodyValue"+bodyValue.toString());
      if (bodyValue == "404" ) {

        return null;
      } else {
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<SavingsListBean> obj = parsed
            .map<SavingsListBean>(
                (json) => SavingsListBean.fromMapMiddleware(json, true))
            .toList();

        for (int save = 0; save < obj.length; save++) {
          print("print que : " +
              obj[save].mrefno.toString() +
              " : " +
              obj[save].trefno.toString());
          await AppDatabase.get()
              .selectSavingsListOnTref(obj[save].trefno, obj[save].mcreatedby)
              .then((SavingsListBean savingsList) async {
            String updateSavingsQuery = "";


            bool isSyncingFirstTime = false;

            print("isSyncingFirstTime111");
            print(isSyncingFirstTime);

            if (obj[save]!=null && obj[save].mrefno != null && (savingsList.mrefno==null || savingsList.mrefno == 0)) {
              isSyncingFirstTime = true;
              updateSavingsQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,${TablesColumnFile.mdateopen} = '${DateTime.now()}' ,${TablesColumnFile.mrefno} = ${obj[save].mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[save].trefno}";
            } else {
              updateSavingsQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}',${TablesColumnFile.mdateopen} = '${DateTime.now()}' WHERE ${TablesColumnFile.mrefno} = ${obj[save].mrefno} AND ${TablesColumnFile.trefno} = ${obj[save].trefno}";
            }
            print("isSyncingFirstTime222");
            print(isSyncingFirstTime);
            print("No record displayed reason");
            print(savingsList.mrefno);
            print(obj[save].mrefno);
            print("upadate query save --" + updateSavingsQuery);
            print("Checking..");
            if (updateSavingsQuery != null) {
              await AppDatabase.get().updateSavingsMaster(updateSavingsQuery);
            }

            if (isSyncingFirstTime) {
              String updateSvngCollectionQuery="${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' , ${TablesColumnFile.msvngaccmrefno} = ${obj[save].mrefno} WHERE ${TablesColumnFile.msvngacctrefno} = ${obj[save].trefno} AND ${TablesColumnFile.mcreatedby} = '${obj[save].mcreatedby}' AND ${TablesColumnFile.msvngaccmrefno} = 0";

              await AppDatabase.get().updateSavingsCollectionMaster(updateSvngCollectionQuery);
            }

          });
        }
        //updating lastsynced date time with now
        AppDatabase.get().updateStaticTablesLastSyncedMaster(11);
      }
    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }






  Future<Null> savingsNormalData() async {
    List savingsList = new List();

    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(11,false)
        .then((onValue) async {
      print("savings timinhg "+onValue.toString());
      await AppDatabase.get()
          .selectSavingsListIsDataSynced(onValue)
          .then((List<SavingsListBean> savingsList) async {
        if(savingsList.length==0){
          return;
        }
        for (int i = 0; i < savingsList.length; i++) {
          print("length of Savings List " + savingsList.length.toString());


          await _toJson(savingsList[i]).then((onValue) {});
          /*     await _tosaveomerJson(saveomerData[i]).then((onValue){
          saveomerList.add(onValue);
        });*/
        }

      });


      _serviceUrl = "/SavingsListController/add/";
      String json = JSON.encode(listSavings);
      for (var items in json.toString().split(",")) {
        print("Json values" + items.toString());
      }

      await syncedDataToMiddleware(json);
      //after call needs to update mref in tab in all tables and update lastsynced in lastsynced date time table
    });
  }



  Future<String> _toJson(SavingsListBean bean) async{
    var mapData = new Map();

    mapData[TablesColumnFile.trefno] =	bean.trefno!=null ? bean.trefno:0;
    mapData[TablesColumnFile.mrefno] = bean.mrefno != null ? bean.mrefno : 0;
    mapData[TablesColumnFile.mlbrcode] =	bean.mlbrcode!=null?bean.mlbrcode:0;
    mapData[TablesColumnFile.mcusttrefno] =	bean.mcusttrefno!=null?bean.mcusttrefno:0;
    mapData[TablesColumnFile.mcustmrefno] =	bean.mcustmrefno!=null?bean.mcustmrefno:0;
    mapData[TablesColumnFile.mprdacctid] =	ifNullCheck(bean.mprdacctid);
    mapData[TablesColumnFile.mlongname] =	ifNullCheck(bean.mlongname);
    mapData[TablesColumnFile.mmobno] =	ifNullCheck(bean.mmobno);
    mapData[TablesColumnFile.mprdcd] =	ifNullCheck(bean.mprdcd);
    mapData[TablesColumnFile.mcurcd] =	ifNullCheck(bean.mcurcd);
    mapData[TablesColumnFile.mdateopen] =	ifDateNullCheck(bean.mdateopen);
    mapData[TablesColumnFile.mdateclosed] =	ifDateNullCheck(bean.mdateclosed);
    mapData[TablesColumnFile.mfreezetype] =	bean.mfreezetype!=null?bean.mfreezetype:0;
    mapData[TablesColumnFile.macctstat] =	bean.macctstat!=null?bean.macctstat:0;
    mapData[TablesColumnFile.mcustno] =	bean.mcustno!=null ? bean.mcustno:0;
    mapData[TablesColumnFile.macttotbalfcy] =	bean.macttotbalfcy!=null?bean.macttotbalfcy:0;
    mapData[TablesColumnFile.mtotallienfcy] =	bean.mtotallienfcy!=null?bean.mtotallienfcy:0;
    mapData[TablesColumnFile.mmoduletype] =	bean.mmoduletype!=null? bean.mmoduletype:0;
    mapData[TablesColumnFile.mcenterid] =	bean.mcenterid!=null?bean.mcenterid:0;
    mapData[TablesColumnFile.mgroupcd] =	bean.mgroupcd!=null?bean.mgroupcd:0;
    mapData[TablesColumnFile.mcreateddt] =	ifDateNullCheck(bean.mcreateddt);
    mapData[TablesColumnFile.mcreatedby] =	ifNullCheck(bean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] =	ifDateNullCheck(bean.mlastupdatedt);
    mapData[TablesColumnFile.mlastupdateby] =	ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] =	ifNullCheck(bean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] =	ifNullCheck(bean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] =	ifNullCheck(bean.mgeologd);
    mapData[TablesColumnFile.mlastsynsdate] =	ifDateNullCheck(bean.mlastsynsdate);
    mapData[TablesColumnFile.merrormessage] =	ifNullCheck(bean.merrormessage);
    mapData[TablesColumnFile.isDataSynced] = 1;
    listSavings.add(mapData);

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
