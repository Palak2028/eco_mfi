import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT1Bean.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT2Bean.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CheckListCGT2Bean.dart';

class CGT2Services {
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();
  String _serviceUrl;
  List cgt2List = List();

  Future<Null> syncCGT2(String listValue) async {
    try {

      String bodyValue  = await NetworkUtil.callPostService(listValue.toString(),Constant.apiURL.toString()+_serviceUrl.toString(),_headers);
      print("url "+Constant.apiURL.toString()+_serviceUrl.toString());
      if(bodyValue == "404" ){
        return null;
      } else {
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<CGT2Bean> obj = parsed
            .map<CGT2Bean>((json) => CGT2Bean.fromMiddleware(json))
            .toList();

        for (int cgt2 = 0; cgt2 < obj.length; cgt2++) {
          await AppDatabase.get()
              .selectCGT2OnTref(obj[cgt2].trefno, obj[cgt2].mcreatedby)
              .then((CGT2Bean cGT2Bean) async {
            bool isSyncingFirstTime = false;
            String updateCgt2Query = null;
            String updateCgt2QaQuery = null;
            try {
             

              if (obj[cgt2] != null &&
                  obj[cgt2].mrefno != null &&
                  cGT2Bean != null &&
                  cGT2Bean.mrefno == null ||
                  cGT2Bean.mrefno == 0) {
                isSyncingFirstTime = true;
                updateCgt2Query =
                "${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now()}' , ${TablesColumnFile.mrefno} = ${obj[cgt2]
                    .mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[cgt2]
                    .trefno}";
              } else {
                updateCgt2Query =
                "${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now()}' WHERE ${TablesColumnFile.mrefno} = ${obj[cgt2]
                    .mrefno} AND ${TablesColumnFile.trefno} = ${obj[cgt2]
                    .trefno}";
              }

              if (updateCgt2Query != null) {
                await AppDatabase.get()
                    .updateCGT2MasterAfterSync(updateCgt2Query);
              }

              for (int cgt2Qa = 0;
              cgt2Qa < obj[cgt2].checkListCGT2Bean.length;
              cgt2Qa++) {
                if (isSyncingFirstTime) {
                  updateCgt2QaQuery =
                  "${TablesColumnFile.mclcgt2refno} = ${obj[cgt2]
                      .checkListCGT2Bean[cgt2Qa]
                      .mclcgt2refno},${TablesColumnFile.mrefno} = ${obj[cgt2]
                      .mrefno} WHERE  ${TablesColumnFile.trefno} = ${obj[cgt2]
                      .trefno}";
                } else {
                  updateCgt2QaQuery =
                  "${TablesColumnFile.mclcgt2refno} = ${obj[cgt2]
                      .checkListCGT2Bean[cgt2Qa]
                      .mclcgt2refno}  WHERE ${TablesColumnFile
                      .mrefno} = ${obj[cgt2].mrefno} AND ${TablesColumnFile
                      .trefno} = ${obj[cgt2].trefno}";
                }
                if (updateCgt2QaQuery != null) {
                  await AppDatabase.get()
                      .updateCGT2QAMasterAfterSync(updateCgt2QaQuery);
                }
              }
            } catch (_) {}
          });
        }
      }

    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }


 Future<Null> getCGT2ForSingleLoan(List<CGT2Bean> cgt2Bean) async {
    List cgt2 = new List();
    List checkList = List();



    for (int i = 0; i < cgt2Bean.length; i++) {

      if(cgt2Bean[i].mrefno!=null&&cgt2Bean[i].mrefno==0){

        await AppDatabase.get()
            .selectCheckListCGT2IsDataSynced(
            cgt2Bean[i].trefno, cgt2Bean[i].mrefno)
            .then((List<CheckListCGT2Bean> checkListCGT2Bean) async {
          await _toListJson(checkListCGT2Bean, cgt2Bean[i])
              .then((onValue) async {

            if(onValue!=null){
              List<String> ar  = onValue.split(",");
              for(var item in ar){
                print("CGT2 Sending json = $item");
              }
            }




          });
        });


      }


    }


    String json = JSON.encode(cgt2List);
    for (var items in json.toString().split(",")) {
      print("Json values for cgt2 " + items.toString());
    }
    _serviceUrl = "CGT2Data/addCgt2ByHolder/";
    await syncCGT2(json);



    //try {

    /*} catch (e) {
      print('Server Exception!!!');
    }*/
  }
  Future<Null> getAndSync() async {
    List checkList = List();

    try {
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(4, false)
        .then((onValue) async {
      await AppDatabase.get()
          .selectCGT2ListNotSynced(onValue)
          .then((List<CGT2Bean> cgt2Bean) async {
        for (int i = 0; i < cgt2Bean.length; i++) {
          await AppDatabase.get()
              .selectCheckListCGT2IsDataSynced(
              cgt2Bean[i].trefno, cgt2Bean[i].mrefno)
              .then((List<CheckListCGT2Bean> checkListCGT2Bean) async {

            await _toListJson(checkListCGT2Bean,cgt2Bean[i]).then((onValue) async {

            });

          });

        }
        String json = JSON.encode(cgt2List);
        for (var items in json.toString().split(",")) {
          print("Json values for cgt2 " + items.toString());
        }
        _serviceUrl = "CGT2Data/addCgt2ByHolder/";
        await syncCGT2(json);

      });
    });
    AppDatabase.get().updateStaticTablesLastSyncedMaster(4);
     } catch (e) {
      print('Server Exception!!!');
    }
  }



  Future<String> _toListJson(
      List<CheckListCGT2Bean> beanChkList, CGT2Bean bean) async {
    var mapData = new Map();

    mapData[TablesColumnFile.trefno] =  bean.trefno!=null?bean.trefno:0;
    mapData[TablesColumnFile.mrefno] =  bean.mrefno!=null?bean.mrefno:0;
    mapData[TablesColumnFile.loantrefno] = bean.loantrefno != null ? bean.loantrefno : 0;
    mapData[TablesColumnFile.loanmrefno] = bean.loanmrefno != null ? bean.loanmrefno : 0;
    mapData[TablesColumnFile.mleadsid] = ifNullCheck(bean.mleadsid);
    mapData[TablesColumnFile.mcgt2doneby] = ifNullCheck(bean.mcgt2doneby);
    mapData[TablesColumnFile.mstarttime] = bean.mstarttime!=null?bean.mstarttime.toIso8601String():null;
    mapData[TablesColumnFile.mendtime] = bean.mendtime!=null?bean.mendtime.toIso8601String():null;
    mapData[TablesColumnFile.mroutefrom] = ifNullCheck(bean.mroutefrom);
    mapData[TablesColumnFile.mrouteto] = ifNullCheck(bean.mrouteto);
    mapData[TablesColumnFile.mremark] = ifNullCheck(bean.mremarks);
    mapData[TablesColumnFile.mcreateddt] =bean.mcreateddt!=null? bean.mcreateddt.toIso8601String():null;
    mapData[TablesColumnFile.mcreatedby] = ifNullCheck(bean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] = bean.mlastupdatedt!=null? bean.mlastupdatedt.toIso8601String():null;
    mapData[TablesColumnFile.mlastupdateby] = ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] = ifNullCheck(bean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] = ifNullCheck(bean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] = ifNullCheck(bean.mgeologd);
    mapData[TablesColumnFile.missynctocoresys] = bean.missynctocoresys!=null?bean.missynctocoresys:0;
    mapData[TablesColumnFile.mlastsynsdate] = DateTime.now().toIso8601String();

    print("beanChkList.length "+beanChkList.length.toString());

    var mapchkList;
    var checkList = List();
    for (int chkList = 0; chkList < beanChkList.length; chkList++) {
      mapchkList=Map();
      mapchkList["tclcgt2refno"] = beanChkList[chkList]!=null&&beanChkList[chkList].tclcgt2refno!=null?beanChkList[chkList].tclcgt2refno:0;
      mapchkList[TablesColumnFile.mclcgt2refno] =beanChkList[chkList]!=null&&beanChkList[chkList].mclcgt2refno!=null?beanChkList[chkList].mclcgt2refno:0;
      mapchkList[TablesColumnFile.mquestionid] =
          beanChkList[chkList].mquestionid;
      mapchkList[TablesColumnFile.manschecked] =
          beanChkList[chkList].manschecked==null?0:beanChkList[chkList].manschecked;
      mapchkList[TablesColumnFile.mleadsid] = bean.trefno != null ? bean.trefno : 0;
      mapchkList[TablesColumnFile.mrefno] = bean.mrefno != null ? bean.mrefno : 0;
      checkList.add(mapchkList);
    }

    mapData["checkListCgt2Details"] =checkList;
    cgt2List.add(mapData);
    return mapData.toString();
  }


  String ifNullCheck(String value) {
    if (value == null || value == 'null' ) {
      value = "";
    }
    return value.trim();
  }
}

