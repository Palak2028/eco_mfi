import 'dart:async';
import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LoanUtilization/LoanUtilizationBean.dart';


class SyncLoanUtilizationToMiddleware {
  static const JsonCodec JSON = const JsonCodec();
  static String _serviceUrl = "";
  static final _headers = {'Content-Type': 'application/json'};
  List listLoanUtil = List();
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
        List<LoanUtilizationBean> obj = parsed
            .map<LoanUtilizationBean>(
                (json) => LoanUtilizationBean.fromMapMiddleware(json))
            .toList();

        for (int save = 0; save < obj.length; save++) {
          await AppDatabase.get()
              .selectLoanUtilizationListOnUsername(obj[save].musrname)
              .then((LoanUtilizationBean savingsList) async {
            String updateLoanUtilQuery = "";
            bool isSyncingFirstTime = false;
            print("isSyncingFirstTime111");
            print(isSyncingFirstTime);
            if (obj[save]!=null ) {
              isSyncingFirstTime = true;
              updateLoanUtilQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}'";
            } else {
              updateLoanUtilQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}'";
            }
            print("isSyncingFirstTime222");
            print(isSyncingFirstTime);
            print("upadate query save --" + updateLoanUtilQuery);
            print("Checking..");
            if (updateLoanUtilQuery != null) {
              await AppDatabase.get().updateSavingsMaster(updateLoanUtilQuery);
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
    List savingsList = new List();

    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(14,false)
        .then((onValue) async {
      print("savings timinhg "+onValue.toString());
      await AppDatabase.get()
          .selectLoanUtilListIsDataSynced(onValue)
          .then((List<LoanUtilizationBean> loanUtilList) async {
        if(loanUtilList.length==0){
          return;
        }
        for (int i = 0; i < loanUtilList.length; i++) {
          print("length of Savings List " + loanUtilList.length.toString());
          await _toJson(loanUtilList[i]).then((onValue) {});
        }

      });


      _serviceUrl = "/LoanUtilizationController/add/";
      String json = JSON.encode(listLoanUtil);
      for (var items in json.toString().split(",")) {
        print("Json values" + items.toString());
      }

      await syncedDataToMiddleware(json);
      //after call needs to update mref in tab in all tables and update lastsynced in lastsynced date time table
    });
  }



  Future<String> _toJson(LoanUtilizationBean bean) async{
    var mapData = new Map();



    mapData[TablesColumnFile.mcustno] =	bean.mcustno!=null?bean.mcustno:0;
    mapData[TablesColumnFile.mcustname] =	ifNullCheck(bean.mcustname);
    mapData[TablesColumnFile.mgroupcd] =	bean.mgroupcd!=null?bean.mgroupcd:0;
    mapData[TablesColumnFile.mcenterid] =	bean.mcenterid!=null?bean.mcenterid:0;
    mapData[TablesColumnFile.mpurposeofLoan] =	ifNullCheck(bean.mpurposeofloan);
    mapData[TablesColumnFile.mprdacctid] =	ifNullCheck(bean.mprdacctid);
    mapData[TablesColumnFile.mactualutilization] =	ifNullCheck(bean.mactualutilization);
    mapData[TablesColumnFile.mcreateddt] =	ifDateNullCheck(bean.mcreateddt);
    mapData[TablesColumnFile.mlastupdatedt] =	ifDateNullCheck(bean.mlastupdatedt);
    mapData[TablesColumnFile.musrname] =	ifNullCheck(bean.musrname);
    mapData[TablesColumnFile.mremarks] =	ifNullCheck(bean.mremarks);
    mapData[TablesColumnFile.isDataSynced] = 1;
    listLoanUtil.add(mapData);

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
