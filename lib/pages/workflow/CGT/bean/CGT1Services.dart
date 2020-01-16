import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT1Bean.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CheckListCGT1Bean.dart';

class CGT1Services {
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();
  String _serviceUrl;
  List cgt1List = List();

  Future<Null> syncCGT1(String jsonList) async {
    try {
      String bodyValue = await NetworkUtil.callPostService(jsonList,
          Constant.apiURL.toString() + _serviceUrl.toString(), _headers);
      print("url " + Constant.apiURL.toString() + _serviceUrl.toString());
      if (bodyValue == '404') {
        return null;
      } else {
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<CGT1Bean> obj = parsed
            .map<CGT1Bean>((json) => CGT1Bean.fromMiddleware(json))
            .toList();

        for (int cgt1 = 0; cgt1 < obj.length; cgt1++) {
          await AppDatabase.get()
              .selectCGT1OnTref(obj[cgt1].trefno, obj[cgt1].mcreatedby)
              .then((CGT1Bean cGT1Bean) async {
            bool isSyncingFirstTime = false;
            String updateCgt1Query = null;
            String updateCgt1QaQuery = null;
            // try {
            print("cGT1Bean.mrefno : " + cGT1Bean.trefno.toString());

            if (obj[cgt1] != null &&
                obj[cgt1].mrefno != null &&
                cGT1Bean != null &&
                cGT1Bean.mrefno == null ||
                cGT1Bean.mrefno == 0) {
              isSyncingFirstTime = true;
              updateCgt1Query =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.mrefno} = ${obj[cgt1]
                  .mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[cgt1]
                  .trefno}";
            } else {
              updateCgt1Query =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' WHERE ${TablesColumnFile.mrefno} = ${obj[cgt1]
                  .mrefno} AND ${TablesColumnFile.trefno} = ${obj[cgt1]
                  .trefno}";
            }

            if (updateCgt1Query != null) {
              await AppDatabase.get()
                  .updateCGT1MasterAfterSync(updateCgt1Query);
            }

            for (int cgt1Qa = 0;
            cgt1Qa < obj[cgt1].checkListCGT1Bean.length;
            cgt1Qa++) {
              if (isSyncingFirstTime) {
                updateCgt1QaQuery =
                "${TablesColumnFile.mclcgt1refno} = ${obj[cgt1]
                    .checkListCGT1Bean[cgt1Qa].mclcgt1refno},${TablesColumnFile
                    .mrefno} = ${obj[cgt1].mrefno} WHERE  ${TablesColumnFile
                    .trefno} = ${obj[cgt1]
                    .trefno}";
              } else {
                updateCgt1QaQuery =
                "${TablesColumnFile.mclcgt1refno} = ${obj[cgt1]
                    .checkListCGT1Bean[cgt1Qa]
                    .mclcgt1refno}  WHERE ${TablesColumnFile
                    .mrefno} = ${obj[cgt1].mrefno} AND ${TablesColumnFile
                    .trefno} = ${obj[cgt1]
                    .trefno}";
              }
              if (updateCgt1QaQuery != null) {
                await AppDatabase.get()
                    .updateCGT1QAMasterAfterSync(updateCgt1QaQuery);
              }
            }
            /*} catch (_) {}*/
          });
        }
      }

       } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
    }


  Future<Null> getAndSync() async {
    List cgt1 = new List();
    List checkList = List();

    try {
      await AppDatabase.get()
          .selectStaticTablesLastSyncedMaster(3, false)
          .then((returnedCGT1DateTime) async {
        await AppDatabase.get()
            .selectCGT1ListNotSynced(returnedCGT1DateTime)
            .then((List<CGT1Bean> cgt1Bean) async {
          for (var items in cgt1Bean) {
            print("Json values1" + items.loanmrefno.toString());
            print("Json values2" + items.loantrefno.toString());
          }
          for (int i = 0; i < cgt1Bean.length; i++) {
            await AppDatabase.get()
                .selectCheckListCGT1IsDataSynced(
                    cgt1Bean[i].trefno, cgt1Bean[i].mrefno)
                .then((List<CheckListCGT1Bean> checkListCGT1Bean) async {
              await _toListJson(checkListCGT1Bean, cgt1Bean[i])
                  .then((onValue) async {});
            });
          }
          String json = JSON.encode(cgt1List);
          for (var items in json.toString().split(",")) {
            print("Json values" + items.toString());
          }
          _serviceUrl = "CGT1Data/addCgt1ByHolder/";
          await syncCGT1(json);
        });
      });
      AppDatabase.get().updateStaticTablesLastSyncedMaster(3);
    }
    catch (e) {
      print('Server Exception!!!');
    }
  }
  Future<Null> getCGT1ForSingleLoan(List<CGT1Bean> cgt1Bean) async {
    List cgt1 = new List();
    List checkList = List();



    for (int i = 0; i < cgt1Bean.length; i++) {

      if(cgt1Bean[i].mrefno!=null&&cgt1Bean[i].mrefno==0){

        await AppDatabase.get()
            .selectCheckListCGT1IsDataSynced(
            cgt1Bean[i].trefno, cgt1Bean[i].mrefno)
            .then((List<CheckListCGT1Bean> checkListCGT1Bean) async {
          await _toListJson(checkListCGT1Bean, cgt1Bean[i])
              .then((onValue) async {

            if(onValue!=null){
              List<String> ar  = onValue.split(",");
              for(var item in ar){
                print("CGT1 Sending json = $item");
              }
            }




          });
        });


      }


    }


    String json = JSON.encode(cgt1List);
    for (var items in json.toString().split(",")) {
      print("Json values for cgt1 " + items.toString());
    }
    _serviceUrl = "CGT1Data/addCgt1ByHolder/";
    await syncCGT1(json);




    //try {

    /*} catch (e) {
      print('Server Exception!!!');
    }*/
  }

  Future<String> _toListJson(
      List<CheckListCGT1Bean> beanChkList, CGT1Bean bean) async {
    var mapData = new Map();

    mapData[TablesColumnFile.trefno] = bean.trefno != null ? bean.trefno : 0;
    mapData[TablesColumnFile.mrefno] = bean.mrefno != null ? bean.mrefno : 0;
    mapData[TablesColumnFile.loantrefno] = bean.loantrefno != null ? bean.loantrefno : 0;
    mapData[TablesColumnFile.loanmrefno] = bean.loanmrefno != null ? bean.loanmrefno : 0;
    mapData[TablesColumnFile.mleadsid] = ifNullCheck(bean.mleadsid);
    mapData[TablesColumnFile.mcgt1doneby] = ifNullCheck(bean.mcgt1doneby);
    mapData[TablesColumnFile.mstarttime] = bean.mstarttime.toIso8601String();
    mapData[TablesColumnFile.mendtime] = bean.mendtime.toIso8601String();
    mapData[TablesColumnFile.mroutefrom] = ifNullCheck(bean.mroutefrom.trim());
    mapData[TablesColumnFile.mrouteto] = ifNullCheck(bean.mrouteto.trim());
    mapData[TablesColumnFile.mremark] = ifNullCheck(bean.mremarks);
    mapData[TablesColumnFile.mcreateddt] = bean.mcreateddt.toIso8601String();
    mapData[TablesColumnFile.mcreatedby] = bean.mcreatedby.trim();
    mapData[TablesColumnFile.mlastupdatedt] =
        bean.mlastupdatedt.toIso8601String();
    mapData[TablesColumnFile.mlastupdateby] = ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] = ifNullCheck(bean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] = ifNullCheck(bean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] = ifNullCheck(bean.mgeologd);
    mapData[TablesColumnFile.missynctocoresys] =
        bean.missynctocoresys != null ? bean.missynctocoresys : 0;
    mapData[TablesColumnFile.mlastsynsdate] = DateTime.now().toIso8601String();

    print("beanChkList.length " + beanChkList.length.toString());

    var mapchkList;
    var checkList = List();
    for (int chkList = 0; chkList < beanChkList.length; chkList++) {
      mapchkList = Map();
      mapchkList["tclcgt1refno"] = beanChkList[chkList] != null &&
              beanChkList[chkList].tclcgt1refno != null
          ? beanChkList[chkList].tclcgt1refno
          : 0;
      mapchkList[TablesColumnFile.mclcgt1refno] = beanChkList[chkList] != null &&
          beanChkList[chkList].mclcgt1refno != null
          ? beanChkList[chkList].mclcgt1refno
          : 0;
      mapchkList[TablesColumnFile.mTableadsid] =
          ifNullCheck(beanChkList[chkList].mleadsid);
      mapchkList[TablesColumnFile.mquestionid] =
          ifNullCheck(beanChkList[chkList].mquestionid);
      mapchkList[TablesColumnFile.manschecked] =
          beanChkList[chkList].manschecked;
      mapchkList[TablesColumnFile.trefno] = bean.trefno != null ? bean.trefno : 0;
      mapchkList[TablesColumnFile.mrefno] = bean.mrefno != null ? bean.mrefno : 0;
      checkList.add(mapchkList);
    }

    mapData[TablesColumnFile.checkListCgt1Details] = checkList;
    cgt1List.add(mapData);
    return mapData.toString();
  }

  String ifNullCheck(String value) {
    if (value == null || value == 'null') {
      value = "";
    }
    return value;
  }
}
