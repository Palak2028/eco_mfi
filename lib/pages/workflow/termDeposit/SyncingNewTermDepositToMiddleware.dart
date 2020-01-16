import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/NewTermDepositBean.dart';

class SyncTDListToMiddleware {
  static const JsonCodec JSON = const JsonCodec();
  static String _serviceUrl = "";
  static final _headers = {'Content-Type': 'application/json'};
  bool isForSingleTD = false;
  CustomerTDCheckBean custTDChkBean = new CustomerTDCheckBean();
  int mrefnoGeneratedForSingleTD = 0;

  DateTime lastSyncedToServerDaeTime;

  List listTD = List();

  Future<Null> syncedDataToMiddleware(List json) async {
    //try {
      String bodyValue = await NetworkUtil.callPostService(json.toString(),
          Constant.apiURL.toString() + _serviceUrl.toString(), _headers);
      print("url " + Constant.apiURL.toString() + _serviceUrl.toString());
      print("bodyValue" + bodyValue.toString());
      if (bodyValue == "404") {
        return null;
      } else {

        print("Retuned Value is $bodyValue");
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<NewTermDepositBean> obj = parsed
            .map<NewTermDepositBean>((json) => NewTermDepositBean.fromMap(json))
            .toList();

        for (int save = 0; save < obj.length; save++) {
          if (isForSingleTD) {
            print("Inside Single Sync");
            mrefnoGeneratedForSingleTD = obj[save].mrefno;
            custTDChkBean.trefno = obj[save].trefno;
            custTDChkBean.mrefno = obj[save].mrefno;
            custTDChkBean.mcustno = obj[save].mcustno;
            custTDChkBean.merrormessage = obj[save].merrormessage;
            custTDChkBean.mCreatedBy = obj[save].mcreatedby;
            custTDChkBean.mlastUpdatedBy = obj[save].mlastupdateby;
            custTDChkBean.mprdacctid = "0";
            print("Returned product Id is ${obj[save].mprdacctid}");
            if (obj[save].mprdacctid != null &&
                obj[save].mprdacctid.toString().toLowerCase().trim() != null) {
              custTDChkBean.mprdacctid =
                  obj[save].mprdacctid.toString().toLowerCase().trim();
            }
            custTDChkBean.mmatval = obj[save].mmatval;

            print("Product account i d is ${custTDChkBean.mprdacctid}");
          }

          await AppDatabase.get()
              .selectTermDepositOnTref(obj[save].trefno, obj[save].mcreatedby)
              .then((NewTermDepositBean tdlist) async {
            String updateTDQuery = "";
            if (obj[save] != null &&
                obj[save].mrefno != null &&
                tdlist != null &&
                (tdlist.mrefno == null || tdlist.mrefno == 0)) {

              if(isForSingleTD) {
                print("Goig in where for single TD and No Mref no");
                print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx error message${obj[save]
                    .merrormessage}");
                print("lastSyncedToServerDaeTime${lastSyncedToServerDaeTime}");
                updateTDQuery = lastSyncedToServerDaeTime != null &&
                    lastSyncedToServerDaeTime != 'null' ?
                "${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now()}', ${TablesColumnFile.merrormessage}  = '${obj[save]
                    .merrormessage}'  ,"
                    " ${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' ,"
                    "${TablesColumnFile
                    .mlastupdatedt} = '${lastSyncedToServerDaeTime.subtract(
                    Duration(minutes: 1))}' , "
                    "${TablesColumnFile.mrefno} = ${obj[save]
                    .mrefno}  , ${TablesColumnFile
                    .mprdacctid} = '${custTDChkBean
                    .mprdacctid}',${TablesColumnFile
                    .mmatval} = '${custTDChkBean
                    .mmatval}' WHERE ${TablesColumnFile.trefno} = ${obj[save]
                    .trefno} AND ${TablesColumnFile.mcreatedby} = '${obj[save]
                    .mcreatedby.trim()}'" : null;
              }else {
                print("Goig in where Not for single TD and No Mref no");
                updateTDQuery =
                "${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now()}' , ${TablesColumnFile.mrefno} = ${obj[save]
                    .mrefno},${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' ,"
                    "${TablesColumnFile.mprdacctid} = '${obj[save].mprdacctid}',"
                    " ${TablesColumnFile.mmatval} = '${obj[save].mmatval}' ,"
                    " ${TablesColumnFile.merrormessage} = '${obj[save].merrormessage}' "
                    " WHERE ${TablesColumnFile.trefno} = ${obj[save]
                    .trefno} AND ${TablesColumnFile.mcreatedby} = '${obj[save]
                    .mcreatedby.trim()}'";
              }


              } else {

              if(isForSingleTD){
                print("Goig in where Not for single TD and SOME  Mref no");

                print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx error message${obj[save].merrormessage}");
                updateTDQuery =lastSyncedToServerDaeTime!=null&&lastSyncedToServerDaeTime!='null'?
                "${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now()}' , ${TablesColumnFile.merrormessage}  = '${obj[save].merrormessage}' "
                    " ,${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' ,${TablesColumnFile.mlastupdatedt} = '${lastSyncedToServerDaeTime.subtract(Duration(minutes: 1))}' "
                    " , ${TablesColumnFile.mprdacctid} = '${obj[save].mprdacctid}',"
                    " ${TablesColumnFile.mmatval} = '${obj[save].mmatval}' ,"
                    " ${TablesColumnFile.merrormessage} = '${obj[save].merrormessage}' "
                    " WHERE ${TablesColumnFile.mrefno} = ${obj[save].mrefno} "
                    "AND ${TablesColumnFile.trefno} = ${obj[save].trefno}":null;
              }else {
                print("Goig in where  for Multiple  TD and Some  Mref no");
                updateTDQuery =
                "${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now()}' ,${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' "
                    " , ${TablesColumnFile.mprdacctid} = '${obj[save].mprdacctid}',"
                    " ${TablesColumnFile.mmatval} = '${obj[save].mmatval}' ,"
                    " ${TablesColumnFile.merrormessage} = '${obj[save].merrormessage}' "
                    " WHERE ${TablesColumnFile.mrefno} = ${obj[save]
                    .mrefno} AND ${TablesColumnFile.trefno} = ${obj[save]
                    .trefno}";
              }




               }

            if (updateTDQuery != null) {

              print("Update Query is $updateTDQuery");
              await AppDatabase.get().updateTDMaster(updateTDQuery);
            }
          });
        }
        if(!isForSingleTD)
        AppDatabase.get().updateStaticTablesLastSyncedMaster(13);
      }
   /* } catch (e) {
      print('Server Exception!!!');
      print(e);
    }*/
  }

  Future<Null> savingsNormalData() async {
    List newTermdepositList = new List();
    try {
      await AppDatabase.get()
          .selectStaticTablesLastSyncedMaster(13, false)
          .then((onValue) async {
        await AppDatabase.get()
            .selectTDListIsDataSynced(onValue)
            .then((List<NewTermDepositBean> ternDepositList) async {
          for (int i = 0; i < ternDepositList.length; i++) {
            await _toJson(ternDepositList[i]).then((onValue) async {
              newTermdepositList.add(onValue.toString());
            });
          }
          _serviceUrl = "TDReceiptsController/add/";
          await syncedDataToMiddleware(newTermdepositList);
        });
      });
    } catch (e) {
      print('Server Exception!!!');
    }

    /*





    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(13,false)
        .then((onValue) async {
      await AppDatabase.get()
          .selectTDListIsDataSynced(onValue)
          .then((List<NewTermDepositBean> savingsList) async {
        for (int i = 0; i < savingsList.length; i++) {
          print("length of TD >>>>> List " + savingsList.length.toString());
          await _toJson(savingsList[i]).then((onValue) {
            newTermdepositList.add(onValue.toString());
          });

        }

      });
    });

      _serviceUrl = "TDReceiptsController/add/";
      String json = JSON.encode(listTD);
      for (var items in json.toString().split(",")) {
        print("Json values" + items.toString());
      }
      await syncedDataToMiddleware(json);*/
    //after call needs to update mref in tab in all tables and update lastsynced in lastsynced date time table
    //});
  }

  Future<String> _toJson(NewTermDepositBean bean) async {
    var mapData = new Map();

    mapData[TablesColumnFile.trefno] = bean.trefno != null ? bean.trefno : 0;
    mapData[TablesColumnFile.mrefno] = bean.mrefno != null ? bean.mrefno : 0;
    mapData[TablesColumnFile.mlbrcode] =
        bean.mlbrcode != null ? bean.mlbrcode : 0;
    mapData[TablesColumnFile.mprdacctid] = ifNullCheck(bean.mprdacctid);
    mapData[TablesColumnFile.mnametitle] = ifNullCheck(bean.mnametitle);
    mapData[TablesColumnFile.mlongname] = ifNullCheck(bean.mlongname);
    mapData[TablesColumnFile.mcurcd] = ifNullCheck(bean.mcurcd);
    mapData[TablesColumnFile.mcertdate] =
        bean.mcertdate != null ? bean.mcertdate.toIso8601String() : null;
    mapData[TablesColumnFile.mnoinst] = bean.mnoinst != null ? bean.mnoinst : 0;
    mapData[TablesColumnFile.mnoofmonths] =
        bean.mnoofmonths != null ? bean.mnoofmonths : 0;
    mapData[TablesColumnFile.mnoofdays] =
        bean.mnoofdays != null ? bean.mnoofdays : 0;
    mapData[TablesColumnFile.mintrate] =
        bean.mintrate != null ? bean.mintrate : 0;
    mapData[TablesColumnFile.mmatval] = bean.mmatval != null ? bean.mmatval : 0;
    mapData[TablesColumnFile.mmatdate] =
        bean.mmatdate != null ? bean.mmatdate.toIso8601String() : null;
    mapData[TablesColumnFile.mreceiptstatus] =
        bean.mreceiptstatus != null ? bean.mreceiptstatus : 0;
    mapData[TablesColumnFile.mlastrepaydate] = bean.mlastrepaydate != null
        ? bean.mlastrepaydate.toIso8601String()
        : null;
    mapData[TablesColumnFile.mmainbalfcy] =
        bean.mmainbalfcy != null ? bean.mmainbalfcy : 0;
    mapData[TablesColumnFile.mintprvdamtfcy] =
        bean.mintprvdamtfcy != null ? bean.mintprvdamtfcy : 0;
    mapData[TablesColumnFile.mintpaidamtfcy] =
        bean.mintpaidamtfcy != null ? bean.mintpaidamtfcy : 0;
    mapData[TablesColumnFile.mtdsamtfcy] =
        bean.mtdsamtfcy != null ? bean.mtdsamtfcy : 0;
    mapData[TablesColumnFile.mtdsyn] = ifNullCheck(bean.mtdsyn);
    mapData[TablesColumnFile.mmodeofdeposit] = ifNullCheck(bean.mmodeofdeposit);
    mapData[TablesColumnFile.mcustno] = bean.mcustno != null ? bean.mcustno : 0;
    mapData[TablesColumnFile.mcenterid] =
        bean.mcenterid != null ? bean.mcenterid : 0;
    mapData[TablesColumnFile.mgroupcd] =
        bean.mgroupcd != null ? bean.mgroupcd : 0;
    mapData[TablesColumnFile.mprdcd] = ifNullCheck(bean.mprdcd) ;
    mapData[TablesColumnFile.mcrs] = ifNullCheck(bean.mcrs);
    mapData[TablesColumnFile.mcreateddt] =
        bean.mcreateddt != null ? bean.mcreateddt.toIso8601String() : null;
    mapData[TablesColumnFile.mcreatedby] = ifNullCheck(bean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] =
        bean.mlastupdatedt.toIso8601String();
    mapData[TablesColumnFile.mlastupdateby] = ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] = ifNullCheck(bean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] = ifNullCheck(bean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] = ifNullCheck(bean.mgeologd);
    mapData[TablesColumnFile.mlastsynsdate] = bean.mlastsynsdate != null
        ? bean.mlastsynsdate.toIso8601String()
        : null;
    mapData[TablesColumnFile.isDataSynced] = 1;
    mapData[TablesColumnFile.merrormessage] = ifNullCheck(bean.merrormessage);
    mapData[TablesColumnFile.msourceoffunds] = bean.msourceoffunds != null ? bean.msourceoffunds: 0;
    mapData[TablesColumnFile.mnoticetype] = bean.mnoticetype!= null ? bean.mnoticetype: 0;

    String json = JSON.encode(mapData);
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

  Future<CustomerTDCheckBean> SyncSingleTDToMiddleware(NewTermDepositBean item,
      DateTime lastBulkSysTime, String userCode) async {
    try {
      List _customerTDDetailList = new List();

      print("lastBulkSysTime is ${lastBulkSysTime}");
      if (lastBulkSysTime == null ||
          lastBulkSysTime.toString().trim() == 'null' ||
          lastBulkSysTime.toString().trim() == "") {
        lastSyncedToServerDaeTime = DateTime.now();
      } else {
        lastSyncedToServerDaeTime = lastBulkSysTime;
      }

      await _toJson(item).then((onValue) async {
        for (var items in onValue.toString().split(",")) {
          print("TD Sending Json is ${items}");
        }
        await _customerTDDetailList.add(onValue.toString());
      });

      _serviceUrl = "TDReceiptsController/add/";

      isForSingleTD = true;
      await syncedDataToMiddleware(_customerTDDetailList);
      return custTDChkBean;
    } catch (_) {
      return null;
    }
//after call needs to update mref in tab in all tables and update lastsynced in lastsynced date time table
  }
}

class CustomerTDCheckBean {
  int mcustno;
  int mcustmrefno;
  String mprdacctid;
  String merrormessage;
  int mrefno;
  int trefno;
  String mCreatedBy;
  String mlastUpdatedBy;
  double mmatval;

  CustomerTDCheckBean({
    this.mcustno,
    this.mcustmrefno,
    this.mprdacctid,
    this.merrormessage,
    this.mrefno,
    this.trefno,
    this.mCreatedBy,
    this.mlastUpdatedBy,
    this.mmatval
  });

  factory CustomerTDCheckBean.fromMap(Map<String, dynamic> map, bool isTrue) {
    return CustomerTDCheckBean(
      mcustmrefno: map[TablesColumnFile.mcustmrefno] as int,
      mprdacctid: map[TablesColumnFile.mprdacctid] as String,
      merrormessage: map[TablesColumnFile.merrormessage] as String,
      mrefno: map[TablesColumnFile.mrefno] as int,
      mcustno: map[TablesColumnFile.mcustno] as int,
      trefno: map[TablesColumnFile.trefno] as int,
      mCreatedBy: map[TablesColumnFile.mcreatedby] as String,
      mlastUpdatedBy: map[TablesColumnFile.mlastupdateby] as String,
      mmatval:map[TablesColumnFile.mmatval] as double,
    );
  }
}
