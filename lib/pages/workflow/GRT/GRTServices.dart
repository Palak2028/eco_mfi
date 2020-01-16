import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/GRT/bean/CheckListGRTBean.dart';
import 'package:eco_mfi/pages/workflow/GRT/bean/GRTBean.dart';

class GRTServices {
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();
  String _serviceUrl;
  List grtList = List();
  Future<Null> syncGRT(String listValue) async {
    try {

      String bodyValue  = await NetworkUtil.callPostService(listValue.toString(),Constant.apiURL.toString()+_serviceUrl.toString(),_headers);
      print("url "+Constant.apiURL.toString()+_serviceUrl.toString());
      if(bodyValue == "404" ){
        return null;
      }else {
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<GRTBean> obj = parsed
            .map<GRTBean>((json) => GRTBean.fromMiddleware(json))
            .toList();

        for (int grt = 0; grt < obj.length; grt++) {
          await AppDatabase.get()
              .selectGRTOnTref(obj[grt].trefno, obj[grt].mcreatedby)
              .then((GRTBean grtBean) async {
            bool isSyncingFirstTime = false;
            String updateGRTQuery = null;
            String updateGRTQaQuery = null;
            try {
              print("grtBean.mrefno : " + grtBean.trefno.toString());

              if (obj[grt] != null &&
                  obj[grt].mrefno != null &&
                  grtBean != null &&
                  grtBean.mrefno == null ||
                  grtBean.mrefno == 0) {
                isSyncingFirstTime = true;
                updateGRTQuery =
                "${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now()}' , ${TablesColumnFile.mrefno} = ${obj[grt]
                    .mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[grt]
                    .trefno}";
              } else {
                updateGRTQuery =
                "${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now()}' WHERE ${TablesColumnFile.mrefno} = ${obj[grt]
                    .mrefno} AND ${TablesColumnFile.trefno} = ${obj[grt]
                    .trefno}";
              }

              if (updateGRTQuery != null) {
                await AppDatabase.get()
                    .updateGRTMasterAfterSync(updateGRTQuery);
              }

              for (int grtQa = 0;
              grtQa < obj[grt].checkListGRTBean.length;
              grtQa++) {
                if (isSyncingFirstTime) {
                  updateGRTQaQuery =
                  "${TablesColumnFile.mclgrtrefno} = ${obj[grt]
                      .checkListGRTBean[grtQa]
                      .mclgrtrefno},${TablesColumnFile.mrefno} = ${obj[grt]
                      .mrefno} WHERE  ${TablesColumnFile.trefno} = ${obj[grt]
                      .checkListGRTBean[grtQa].trefno}";
                } else {
                  updateGRTQaQuery =
                  "${TablesColumnFile.mclgrtrefno} = ${obj[grt]
                      .checkListGRTBean[grtQa]
                      .mclgrtrefno}  WHERE ${TablesColumnFile
                      .mrefno} = ${obj[grt].mrefno} AND ${TablesColumnFile
                      .trefno} = ${obj[grt].checkListGRTBean[grtQa].trefno}";
                }
                if (updateGRTQaQuery != null) {
                  await AppDatabase.get()
                      .updateGRTQAMasterAfterSync(updateGRTQaQuery);
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






  Future<String> _toListJson(
      List<CheckListGRTBean> beanChkList, GRTBean bean) async {
    var mapData = new Map();

    mapData[TablesColumnFile.trefno] =  bean.trefno!=null?bean.trefno:0;
    mapData[TablesColumnFile.mrefno] =  bean.mrefno!=null?bean.mrefno:0;
    mapData[TablesColumnFile.loantrefno] = bean.loantrefno != null ? bean.loantrefno : 0;
    mapData[TablesColumnFile.loanmrefno] = bean.loanmrefno != null ? bean.loanmrefno : 0;
    mapData[TablesColumnFile.mleadsid] = ifNullCheck(bean.mleadsid);
    mapData[TablesColumnFile.mgrtdoneby] = ifNullCheck(bean.mgrtdoneby);
    mapData[TablesColumnFile.mstarttime] =  bean.mstarttime!=null?bean.mstarttime.toIso8601String():null;
    mapData[TablesColumnFile.mendtime] = bean.mendtime!=null?bean.mendtime.toIso8601String():null;
    mapData[TablesColumnFile.mroutefrom] = ifNullCheck(bean.mroutefrom).trim();
    mapData[TablesColumnFile.mrouteto] = ifNullCheck(bean.mrouteto).trim();
    mapData[TablesColumnFile.mremark] = ifNullCheck(bean.mremarks);
    mapData[TablesColumnFile.mcreateddt] =  bean.mcreateddt!=null?bean.mcreateddt.toIso8601String():null;
    mapData[TablesColumnFile.mcreatedby] = ifNullCheck(bean.mcreatedby).trim();
    mapData[TablesColumnFile.mlastupdatedt] = bean.mlastupdatedt!=null?bean.mlastupdatedt.toIso8601String():null;
    mapData[TablesColumnFile.mlastupdateby] = ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] = ifNullCheck(bean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] = ifNullCheck(bean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] = ifNullCheck(bean.mgeologd);
    mapData[TablesColumnFile.missynctocoresys] = bean.missynctocoresys!=null?bean.missynctocoresys:0;
    mapData[TablesColumnFile.mlastsynsdate] = bean.mlastsynsdate != null
        ? bean.mlastsynsdate.toIso8601String()
        : null;

    print("beanChkList.length "+beanChkList.length.toString());

    var mapchkList;
    var checkList = List();
    for (int chkList = 0; chkList < beanChkList.length; chkList++) {
      mapchkList=Map();
      mapchkList[TablesColumnFile.tclgrtrefno] = beanChkList[chkList]!=null&&beanChkList[chkList].tclgrtrefno!=null?beanChkList[chkList].tclgrtrefno:0;
      mapchkList[TablesColumnFile.mclgrtrefno] =beanChkList[chkList]!=null&&beanChkList[chkList].mclgrtrefno!=null?beanChkList[chkList].mclgrtrefno:0;
      mapchkList[TablesColumnFile.mTableadsid] =
          beanChkList[chkList].mTableadsid;
      mapchkList[TablesColumnFile.mquestionid] =
          beanChkList[chkList].mquestionid;
      mapchkList[TablesColumnFile.manschecked] =
          beanChkList[chkList].manschecked;

      mapchkList[TablesColumnFile.trefno] = bean.trefno != null ? bean.trefno : 0;
      mapchkList[TablesColumnFile.mrefno] = bean.mrefno != null ? bean.mrefno : 0;
      checkList.add(mapchkList);

    }

    mapData["checkListGrtDetails"] =checkList;
    grtList.add(mapData);
    return mapData.toString();
  }




  String ifNullCheck(String value) {
    if (value == null || value == 'null' ) {
      value = "";
    }
    return value;
  }


  Future<Null> getAndSync() async {
    List grt = new List();
    List checkList = List();

    //try {
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(5, false)
        .then((onValue) async {
      await AppDatabase.get()
          .selectGRTListIsDataSynced(onValue)
          .then((List<GRTBean> grtBean) async {
        for (int i = 0; i < grtBean.length; i++) {
          await AppDatabase.get()
              .selectCheckListGRTIsDataSynced(
              grtBean[i].trefno, grtBean[i].mrefno)
              .then((List<CheckListGRTBean> checkListGRTBean) async {

            await _toListJson(checkListGRTBean,grtBean[i]).then((onValue) async {


              if(onValue!=null){
                List<String> ar  = onValue.split(",");
                for(var item in ar){
                  print("GRT  json = $item");
                }
              }

            });

          });

        }
        String json = JSON.encode(grtList);
        for (var items in json.toString().split(",")) {
          print("Json values" + items.toString());
        }
        _serviceUrl = "GRTData/addGrtByHolder/";
        await syncGRT(json);

      });
    });
    AppDatabase.get().updateStaticTablesLastSyncedMaster(5);
    /* } catch (e) {
      print('Server Exception!!!');
    }*/
  }

  Future<Null> getGRTForSingleLoan(List<GRTBean> grtBean) async {
    List cgt1 = new List();
    List checkList = List();



    for (int i = 0; i < grtBean.length; i++) {

      if(grtBean[i].mrefno!=null&&grtBean[i].mrefno==0){

        await AppDatabase.get()
            .selectCheckListGRTIsDataSynced(
            grtBean[i].trefno, grtBean[i].mrefno)
            .then((List<CheckListGRTBean> checkListGRTBean) async {
          await _toListJson(checkListGRTBean, grtBean[i])
              .then((onValue) async {

            if(onValue!=null){
              List<String> ar  = onValue.split(",");
              for(var item in ar){
                print("GRT Sending json = $item");
              }
            }




          });
        });


      }


    }


    String json = JSON.encode(grtList);
    for (var items in json.toString().split(",")) {
      print("Json values for GRT " + items.toString());
    }
    _serviceUrl = "GRTData/addGrtByHolder/";
    await syncGRT(json);




    //try {

    /*} catch (e) {
      print('Server Exception!!!');
    }*/
  }


}
