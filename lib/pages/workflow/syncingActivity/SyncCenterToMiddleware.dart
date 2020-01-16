import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';

import 'package:path_provider/path_provider.dart';

class SyncingCentertoMiddleware {
  static const JsonCodec JSON = const JsonCodec();
  static String _serviceUrl = "";
  static final _headers = {'Content-Type': 'application/json'};


  List listCenter = List();

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
      List<CenterDetailsBean> obj = parsed
          .map<CenterDetailsBean>(
              (json) => CenterDetailsBean.fromMapMiddleware(json))
          .toList();

      for (int save = 0; save < obj.length; save++) {
        print("print que : " +
            obj[save].mrefno.toString() +
            " : " +
            obj[save].trefno.toString());
        await AppDatabase.get()
            .selectCenterListOnTref(obj[save].trefno, obj[save].mcreatedby)
            .then((CenterDetailsBean centerList) async {
          String updateCenterQuery = "";


          bool isSyncingFirstTime = false;

          print("isSyncingFirstTime111");
          print(isSyncingFirstTime);

          if (obj[save]!=null && obj[save].mrefno != null && centerList.mrefno==null || centerList.mrefno == 0) {
            isSyncingFirstTime = true;
            updateCenterQuery =
            "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,${TablesColumnFile.mrefno} = ${obj[save].mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[save].trefno}";
          } else {
            updateCenterQuery =
            "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' WHERE ${TablesColumnFile.mrefno} = ${obj[save].mrefno} AND ${TablesColumnFile.trefno} = ${obj[save].trefno}";
          }
          print("isSyncingFirstTime222");
          print(isSyncingFirstTime);
          print("No record displayed reason");
          print(centerList.mrefno);
          print(obj[save].mrefno);
          print("upadate query save --" + updateCenterQuery);
          print("Checking..");
          if (updateCenterQuery != null) {
            await AppDatabase.get().updateCenterMaster(updateCenterQuery);
          }

        });
      }
      //updating lastsynced date time with now
      AppDatabase.get().updateStaticTablesLastSyncedMaster(14);
    }
    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }






  Future<Null> savingsNormalData() async {
    List centerList = new List();

    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(14,false)
        .then((onValue) async {
          print("center timing "+onValue.toString());
      await AppDatabase.get()
          .selectCenterListIsDataSynced(onValue)
          .then((List<CenterDetailsBean> centerList) async {
            if(centerList.length==0){
              return;
            }
        for (int i = 0; i < centerList.length; i++) {
          print("length of Center List " + centerList.length.toString());


          await _toJson(centerList[i]).then((onValue) {});
          /*     await _tosaveomerJson(saveomerData[i]).then((onValue){
          saveomerList.add(onValue);
        });*/
        }

      });


      _serviceUrl = "/createCentersFoundations/add/";
      String json = JSON.encode(listCenter);
      for (var items in json.toString().split(",")) {
        print("Json values" + items.toString());
      }

      await syncedDataToMiddleware(json);
      //after call needs to update mref in tab in all tables and update lastsynced in lastsynced date time table
    });
  }



  Future<String> _toJson(CenterDetailsBean bean) async{
    var mapData = new Map();

    mapData[TablesColumnFile.trefno] =	bean.trefno!=null ? bean.trefno:0;
    mapData[TablesColumnFile.mrefno] = bean.mrefno != null ? bean.mrefno : 0;
    mapData[TablesColumnFile.mCenterId] =	bean.mCenterId!=null?bean.mCenterId:0;
    mapData[TablesColumnFile.mEffectiveDt] =	ifDateNullCheck(bean.mEffectiveDt);
    mapData[TablesColumnFile.mlbrcode] =	bean.mlbrcode!=null?bean.mlbrcode:0;
    mapData[TablesColumnFile.mcentername] =	bean.mcentername!=null?bean.mcentername:"";
    mapData[TablesColumnFile.mcrs] =	bean.mcrs!=null?bean.mcrs:"";
    mapData[TablesColumnFile.marea] =	bean.marea!=null?bean.marea:"";
    mapData[TablesColumnFile.mformatndt] =	ifDateNullCheck(bean.mformatndt);
    mapData[TablesColumnFile.mmeetingfreq] =	bean.mmeetingfreq!=null?bean.mmeetingfreq:"";
    mapData[TablesColumnFile.mmeetinglocn] =	bean.mmeetinglocn!=null?bean.mmeetinglocn:"";
    mapData[TablesColumnFile.mmeetingday] =	bean.mmeetingday!=null?bean.mmeetingday:0;
    mapData[TablesColumnFile.mcentermthhmm] =	bean.mcentermthhmm!=null?bean.mcentermthhmm:0;
    mapData[TablesColumnFile.mcentermtampm] =	bean.mcentermtampm!=null?bean.mcentermtampm:0;
    mapData[TablesColumnFile.mfirstmeetngdt] =	ifDateNullCheck(bean.mfirstmeetngdt);
    mapData[TablesColumnFile.mnextmeetngdt] =	ifDateNullCheck(bean.mnextmeetngdt);
    mapData[TablesColumnFile.mlastmeetngdt] =	ifDateNullCheck(bean.mlastmeetngdt);
    mapData[TablesColumnFile.mrepayfrom] =	bean.mrepayfrom!=null? bean.mrepayfrom:0;
    mapData[TablesColumnFile.mrepayto] =	bean.mrepayto!=null?bean.mrepayto:0;
    mapData[TablesColumnFile.mcurrnoOfmembers] =	bean.mcurrnoOfmembers!=null?bean.mcurrnoOfmembers:0;
    mapData[TablesColumnFile.mcenterstatus] =	bean.mcenterstatus!=null?bean.mcenterstatus:0;
    mapData[TablesColumnFile.mdropoutdate] =	ifDateNullCheck(bean.mdropoutdate);
    mapData[TablesColumnFile.mlastmonitoringdate] =	ifDateNullCheck(bean.mlastmonitoringdate);
    mapData[TablesColumnFile.mcreateddt] =	ifDateNullCheck(bean.mcreateddt);
    mapData[TablesColumnFile.mcreatedby] =	ifNullCheck(bean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] =	ifDateNullCheck(bean.mlastupdatedt);
    mapData[TablesColumnFile.mlastupdateby] =	ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] =	ifNullCheck(bean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] =	ifNullCheck(bean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] =	ifNullCheck(bean.mgeologd);
    mapData[TablesColumnFile.missynctocoresys] =	bean.missynctocoresys!=null?bean.missynctocoresys:0;
    mapData[TablesColumnFile.mlastsynsdate] =	ifDateNullCheck(bean.mlastsynsdate);
    mapData[TablesColumnFile.isDataSynced] = 1;
    listCenter.add(mapData);

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
