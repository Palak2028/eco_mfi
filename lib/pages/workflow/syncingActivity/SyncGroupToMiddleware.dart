import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFoundation.dart';

import 'package:path_provider/path_provider.dart';

class SyncingGrouptoMiddleware {
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
      List<GroupFoundationBean> obj = parsed
          .map<GroupFoundationBean>(
              (json) => GroupFoundationBean.fromMapMiddleware(json))
          .toList();

      for (int save = 0; save < obj.length; save++) {
        print("print que : " +
            obj[save].mrefno.toString() +
            " : " +
            obj[save].trefno.toString());
        await AppDatabase.get()
            .selectGroupListOnTref(obj[save].trefno, obj[save].mcreatedby)
            .then((GroupFoundationBean groupList) async {
          String updateGroupQuery = "";


          bool isSyncingFirstTime = false;

          print("isSyncingFirstTime111");
          print(isSyncingFirstTime);

          if (obj[save]!=null && obj[save].mrefno != null && groupList.mrefno==null || groupList.mrefno == 0) {
            isSyncingFirstTime = true;
            updateGroupQuery =
            "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,${TablesColumnFile.mrefno} = ${obj[save].mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[save].trefno}";
          } else {
            updateGroupQuery =
            "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' WHERE ${TablesColumnFile.mrefno} = ${obj[save].mrefno} AND ${TablesColumnFile.trefno} = ${obj[save].trefno}";
          }
          print("isSyncingFirstTime222");
          print(isSyncingFirstTime);
          print("No record displayed reason");
          print(groupList.mrefno);
          print(obj[save].mrefno);
          print("upadate query save --" + updateGroupQuery);
          print("Checking..");
          if (updateGroupQuery != null) {
            await AppDatabase.get().updateGroupMaster(updateGroupQuery);
          }

        });
      }
      //updating lastsynced date time with now
      AppDatabase.get().updateStaticTablesLastSyncedMaster(15);
    }
    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }






  Future<Null> savingsNormalData() async {
    List groupList = new List();

    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(15,false)
        .then((onValue) async {
          print("group timing "+onValue.toString());
      await AppDatabase.get()
          .selectGroupListIsDataSynced(onValue)
          .then((List<GroupFoundationBean> groupList) async {
            if(groupList.length==0){
              return;
            }
        for (int i = 0; i < groupList.length; i++) {
          print("length of Group List " + groupList.length.toString());


          await _toJson(groupList[i]).then((onValue) {});

        }

      });


      _serviceUrl = "/createGroupsFoundations/addGroup/";
      String json = JSON.encode(listCenter);
      for (var items in json.toString().split(",")) {
        print("Json values" + items.toString());
      }

      await syncedDataToMiddleware(json);
      //after call needs to update mref in tab in all tables and update lastsynced in lastsynced date time table
    });
  }



  Future<String> _toJson(GroupFoundationBean bean) async{
    var mapData = new Map();

    mapData[TablesColumnFile.trefno] =	bean.trefno!=null ? bean.trefno:0;
    mapData[TablesColumnFile.mrefno] = bean.mrefno != null ? bean.mrefno : 0;
    mapData[TablesColumnFile.mgroupid] =	bean.mgroupid!=null?bean.mgroupid:0;
    mapData[TablesColumnFile.mgroupname] =	bean.mgroupname!=null?bean.mgroupname:"";
    mapData[TablesColumnFile.mlbrcode] =	bean.mlbrcode!=null?bean.mlbrcode:0;
    mapData[TablesColumnFile.magentcd] =	bean.magentcd!=null?bean.magentcd:"";
    mapData[TablesColumnFile.mcenterid] =	bean.mcenterid!=null?bean.mcenterid:0;
    mapData[TablesColumnFile.mGrprecogTestDate] =	ifDateNullCheck(bean.mGrprecogTestDate);
    mapData[TablesColumnFile.mMaxGroupMembers] =	bean.mMaxGroupMembers!=null?bean.mMaxGroupMembers:0;
    mapData[TablesColumnFile.mMinGroupMembers] =	bean.mMinGroupMembers!=null?bean.mMinGroupMembers:0;
    mapData[TablesColumnFile.mgrouptype] =	bean.mgrouptype!=null?bean.mgrouptype:"";
    mapData[TablesColumnFile.mgrtapprovedby] =	bean.mgrtapprovedby!=null?bean.mgrtapprovedby:"";
    mapData[TablesColumnFile.mloanlimit] =	bean.mloanlimit!=null?bean.mloanlimit:0;
    mapData[TablesColumnFile.meetingday] =	bean.meetingday!=null?bean.meetingday:0;
    mapData[TablesColumnFile.mcreateddt] =	ifDateNullCheck(bean.mcreateddt);
    mapData[TablesColumnFile.mcreatedby] =	ifNullCheck(bean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] =	ifDateNullCheck(bean.mlastupdatedt);
    mapData[TablesColumnFile.mlastupdateby] =	ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] =	ifNullCheck(bean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] =	ifNullCheck(bean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] =	ifNullCheck(bean.mgeologd);
    mapData[TablesColumnFile.mgroupprdcode] =	bean.mgroupprdcode;
    mapData[TablesColumnFile.mgroupgender] =	bean.mgroupgender;
    mapData[TablesColumnFile.trefcenterid] =	bean.trefcenterid;
    mapData[TablesColumnFile.mrefcenterid] =	bean.mrefcenterid;

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
