import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/Kyc/beans/KycMasterBean.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/NewTermDepositBean.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/SyncingNewTermDepositToMiddleware.dart';

class SyncKycMasterToMiddleware {
  static const JsonCodec JSON = const JsonCodec();
  static String _serviceUrl = "";
  static final _headers = {'Content-Type': 'application/json'};
  bool isForSingleTD = false;
  //KycMasterBean kycMasterBean = new KycMasterBean();
  int mrefnoGeneratedForSingleTD = 0;

  DateTime lastSyncedToServerDateTime;

  List listTD = List();

  Future<Null> syncedDataToMiddleware(List json) async {
    //try {
    print("Sending json is ${json} ");
    String bodyValue = await NetworkUtil.callPostService(json.toString(),
        Constant.apiURL.toString() + _serviceUrl.toString(), _headers);

        print("url " + Constant.apiURL.toString() + _serviceUrl.toString());
        print("bodyValue" + bodyValue.toString());

    if (bodyValue == "404") {
      return null;
    } else {
      print("Retuned Value is $bodyValue");
      final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
      List<KycMasterBean> obj = parsed
          .map<KycMasterBean>((json) => KycMasterBean.fromMap(json))
          .toList();

      for (int save = 0; save < obj.length; save++) {


        await AppDatabase.get()
            .selectKycMasterOnTrefAndMrefNo(obj[save].trefno, obj[save].mrefno)
            .then((KycMasterBean tdkyclist) async {
          String updateKycQuery = "";
          if (obj[save] != null &&  obj[save].mrefno != null &&  tdkyclist != null &&
              (tdkyclist.mrefno == null || tdkyclist.mrefno == 0)) {

              print("Going in where for single TD and No Mref no");

              print("lastSyncedToServerDateTime ${lastSyncedToServerDateTime}");

              updateKycQuery =

              "${TablesColumnFile.mleadsid} ='${obj[save].mleadsid}',"
              "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,"
               " ${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' ,"
               "${TablesColumnFile.mrefno} = ${obj[save].mrefno} "
               " WHERE ${TablesColumnFile.trefno} = ${obj[save].trefno} "
               " AND ${TablesColumnFile.mrefno } =  0 " ;

          } else {

              print("Going in where Not for single TD and SOME  Mref no");

              updateKycQuery =

              "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,"
              " ${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' "
              " WHERE ${TablesColumnFile.mrefno} = ${obj[save].mrefno} "
              " AND ${TablesColumnFile.trefno} = ${obj[save].trefno} " ;
          }

          if (updateKycQuery != null) {
            print("Update Query is $updateKycQuery");
            await AppDatabase.get().updateKycListMaster(updateKycQuery);
          }
        });
      }

      if(obj!=null&&obj.length>0){
        AppDatabase.get().updateStaticTablesLastSyncedMaster(20);
      }
    }
    /* } catch (e) {
      print('Server Exception!!!');
      print(e);
    }*/
  }


  KycMasterBean bindKycListBean(Map<String, dynamic> result) {
   // NewTermDepositBean savingsListBean = new NewTermDepositBean();
    return KycMasterBean.fromMap(result);
  }

  Future<Null> savingKycData() async {
    List newKycMasterList = new List();
    //try {
      await AppDatabase.get()
          .selectStaticTablesLastSyncedMaster(20, false)
          .then((onValue) async {
        await AppDatabase.get()
            .selectKycMasterListIsDataSynced(onValue)
            .then(
                (List<KycMasterBean> kycList) async {
                  for (int i = 0; i < kycList.length; i++) {
                    await _toJson(kycList[i]).then((onValue) async {

                      newKycMasterList.add(onValue.toString());
                    });
          }
          _serviceUrl = "kycMasterData/add";
          await syncedDataToMiddleware(newKycMasterList);
        });
      });
    /*} catch (e) {
      print('Server Exception!!!');
    }*/
  }



  Future<Null> getKYCforSingleLoan(KycMasterBean kycBean) async {

    List newKycMasterList = new List();
    await _toJson(kycBean).then((onValue) async {

      newKycMasterList.add(onValue.toString());
    });

    _serviceUrl = "kycMasterData/add";
    await syncedDataToMiddleware(newKycMasterList);

  }

  Future<String> _toJson(KycMasterBean bean) async {
    var mapData = new Map();
    mapData[TablesColumnFile.trefno] = bean.trefno != null ? bean.trefno : 0;
    mapData[TablesColumnFile.mrefno] = bean.mrefno != null ? bean.mrefno : 0;
    mapData[TablesColumnFile.mleadsid] =	bean.mleadsid!=null?bean.mleadsid:"";
    mapData[TablesColumnFile.mloantrefno] = bean.mloantrefno != null ? bean.mloantrefno : 0;
    mapData[TablesColumnFile.mloanmrefno] = bean.mloanmrefno != null ? bean.mloanmrefno : 0;
    mapData[TablesColumnFile.mcusttrefno] = bean.mcusttrefno != null ? bean.mcusttrefno : 0;
    mapData[TablesColumnFile.mcustmrefno] = bean.mcustmrefno != null ? bean.mcustmrefno : 0;
    mapData[TablesColumnFile.mbackground] = bean.mbackground != null ? bean.mbackground : 0;
    mapData[TablesColumnFile.mjob] = bean.mjob != null ? bean.mjob : 0;
    mapData[TablesColumnFile.mlifestyle] = bean.mlifestyle != null ? bean.mlifestyle : 0;
    mapData[TablesColumnFile.mloanrepay] = bean.mloanrepay != null ? bean.mloanrepay : 0;
    mapData[TablesColumnFile.mnetworth] = bean.mnetworth != null ? bean.mnetworth : 0;
    mapData[TablesColumnFile.mcomments] = ifNullCheck(bean.mcomments);
    mapData[TablesColumnFile.mverifiedinfo] = bean.mverifiedinfo != null ? bean.mverifiedinfo : 0;
    mapData[TablesColumnFile.mcreateddt] = bean.mcreateddt != null ? bean.mcreateddt.toIso8601String() : null;
    mapData[TablesColumnFile.mcreatedby] = ifNullCheck(bean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] = bean.mlastupdatedt.toIso8601String();
    mapData[TablesColumnFile.mlastupdateby] = ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] = ifNullCheck(bean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] = ifNullCheck(bean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] = ifNullCheck(bean.mgeologd);
    mapData[TablesColumnFile.missynctocoresys] = 0;
    mapData[TablesColumnFile.mlastsynsdate] = bean.mlastsynsdate != null ? bean.mlastsynsdate.toIso8601String() : null;


    String json = JSON.encode(mapData);
    print("json is $_toJson(bean)");
    print("Mapping Data Complete");
    return json;
  }

  String ifDateNullCheck(DateTime value) {
    if (value == null || value == 'null') {
      return "";
    } else {
      return value.toIso8601String();
    }
  }

  String ifNullCheck(String value) {
    if (value == null || value == 'null') {
      value = "";
    }
    return value;
  }
}