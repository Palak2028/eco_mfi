import 'dart:convert';
import 'dart:io';

//import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';

import 'package:path_provider/path_provider.dart';

import 'bean/DisbursmentBean.dart';

class SyncDisbursedListToMiddleware {
  static const JsonCodec JSON = const JsonCodec();
  static String _serviceUrl = "";
  static final _headers = {'Content-Type': 'application/json'};
  List listDisbursment = List();
  Future<Null> syncedDataToMiddleware(String json) async {
    //try {
      print("json is $json");
      String bodyValue = await NetworkUtil.callPostService(json.toString(),
          Constant.apiURL.toString() + _serviceUrl.toString(), _headers);
      print("url " + Constant.apiURL.toString() + _serviceUrl.toString());
      print("bodyValue"+bodyValue.toString());
      if (bodyValue == "404"|| bodyValue==null) {

        return null;
      } else {
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<DisbursmentBean> obj = parsed
            .map<DisbursmentBean>(
                (json) => DisbursmentBean.fromMapMiddleware(json, true))
            .toList();

        for (int dsbrs = 0; dsbrs < obj.length; dsbrs++) {
          print("print que : " +
              obj[dsbrs].mrefno.toString() +
              " : " +
              obj[dsbrs].trefno.toString());
          await AppDatabase.get()
              .selectDisbursmentListOnTref(obj[dsbrs].trefno, obj[dsbrs].mcreatedby)
              .then((DisbursmentBean disbursmentList) async {
            String updateDisbursmentQuery = "";
            if (obj[dsbrs]!=null && obj[dsbrs].mrefno != null && (disbursmentList.mrefno==null || disbursmentList.mrefno == 0)) {
              updateDisbursmentQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,${TablesColumnFile.mdateopen} = '${DateTime.now()}' ,${TablesColumnFile.mrefno} = ${obj[dsbrs].mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[dsbrs].trefno}";
            } else {
              updateDisbursmentQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}',${TablesColumnFile.mdateopen} = '${DateTime.now()}' WHERE ${TablesColumnFile.mrefno} = ${obj[dsbrs].mrefno} AND ${TablesColumnFile.trefno} = ${obj[dsbrs].trefno}";
            }
            print("upadate query dsbrs --" + updateDisbursmentQuery);
            if (updateDisbursmentQuery != null) {
              await AppDatabase.get().updateDisbursedListMaster(updateDisbursmentQuery);
            }

          });
        }

       // AppDatabase.get().updateStaticTablesLastSyncedMaster(26);
      }
    /*} catch (e) {
      print('Server Exception!!!');
      print(e);
    }*/
  }






  Future<Null> disbursmentNormalData() async {
    List disbursmentList = new List();

    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(26,false)
        .then((onValue) async {
      print("Disbursed List "+onValue.toString());
      await AppDatabase.get()
          .selectDisbursedListIsDataSynced(onValue)
          .then((List<DisbursmentBean> disbursmentList) async {
        if(disbursmentList.length==0){
          return;
        }
        for (int i = 0; i < disbursmentList.length; i++) {
          print("length of disbursed List " + disbursmentList.length.toString());


          await _toJson(disbursmentList[i]).then((onValue) {});

        }

      });


      _serviceUrl = "/DisbursedList/add/";
      String json = JSON.encode(listDisbursment);
      for (var items in json.toString().split(",")) {
        print("Json values" + items.toString());
      }

      await syncedDataToMiddleware(json);
      //after call needs to update mref in tab in all tables and update lastsynced in lastsynced date time table
    });
  }



  Future<String> _toJson(DisbursmentBean bean) async{
    var mapData = new Map();




    mapData[TablesColumnFile.trefno] =	bean.trefno!=null ? bean.trefno:0;
    mapData[TablesColumnFile.mrefno] =	bean.mrefno!=null? bean.mrefno:0;
    mapData[TablesColumnFile.mlbrcode] =	bean.mlbrcode!=null? bean.mlbrcode:0;
    mapData[TablesColumnFile.mprdacctid] =	ifNullCheck(bean.mprdacctid);
    mapData[TablesColumnFile.mlongname] =	ifNullCheck(bean.mlongname);
    mapData[TablesColumnFile.mgroupcd] =	bean.mgroupcd!=null? bean.mgroupcd:0;
    mapData[TablesColumnFile.mefffromdate] =	ifDateNullCheck(bean.mefffromdate);
    mapData[TablesColumnFile.mdisburseddate] =	ifDateNullCheck(bean.mdisburseddate);
    mapData[TablesColumnFile.minstlstartdate] =	ifDateNullCheck(bean.minstlstartdate);
    mapData[TablesColumnFile.minstlamt] =	bean.minstlamt!=null? bean.minstlamt:0;
    mapData[TablesColumnFile.minstlintcomp] =	bean.minstlintcomp!=null? bean.minstlintcomp:0;
    mapData[TablesColumnFile.mleadsid] =	ifNullCheck(bean.mleadsid);
    mapData[TablesColumnFile.mappliedasindvyn] =	ifNullCheck(bean.mappliedasindvyn);
    mapData[TablesColumnFile.mnewtopupflag] =	bean.mnewtopupflag!=null? bean.mnewtopupflag:0;
    mapData[TablesColumnFile.msancdate] =	ifDateNullCheck(bean.msancdate);
    mapData[TablesColumnFile.mdisbursedamt] =	bean.mdisbursedamt!=null? bean.mdisbursedamt:0;
    mapData[TablesColumnFile.msdamt] =	bean.msdamt!=null? bean.msdamt:0;
    mapData[TablesColumnFile.mrebateamt] =	bean.mrebateamt!=null? bean.mrebateamt:0;
    mapData[TablesColumnFile.mchargesamt] =	bean.mchargesamt!=null? bean.mchargesamt:0;
    mapData[TablesColumnFile.mdisbursedamtcoltd] =	bean.mdisbursedamtcoltd!=null? bean.mdisbursedamtcoltd:0;
    mapData[TablesColumnFile.msdamtcoltd] =	bean.msdamtcoltd!=null? bean.msdamtcoltd:0;
    mapData[TablesColumnFile.mrebateamtcoltd] =	bean.mrebateamtcoltd!=null? bean.mrebateamtcoltd:0;
    mapData[TablesColumnFile.mchargesamtcoltd] =	bean.mchargesamtcoltd!=null? bean.mchargesamtcoltd:0;
    mapData[TablesColumnFile.mdisbursedamtflag] =	bean.mdisbursedamtflag!=null? bean.mdisbursedamtflag:0;
    mapData[TablesColumnFile.msdamtflag] =	bean.msdamtflag!=null? bean.msdamtflag:0;
    mapData[TablesColumnFile.mrebateamtflag] =	bean.mrebateamtflag!=null? bean.mrebateamtflag:0;
    mapData[TablesColumnFile.mchargesamtflag] =	bean.mchargesamtflag!=null? bean.mchargesamtflag:0;
    mapData[TablesColumnFile.mreason] =	ifNullCheck(bean.mreason);
    mapData[TablesColumnFile.msetno] =	bean.msetno!=null? bean.msetno:0;
    mapData[TablesColumnFile.mscrollno] =	bean.mscrollno!=null? bean.mscrollno:0;
    mapData[TablesColumnFile.mentrydate] =	ifDateNullCheck(bean.mentrydate);
    mapData[TablesColumnFile.mbatchcd] =	ifNullCheck(bean.mbatchcd);
    mapData[TablesColumnFile.mmainscrollno] =	bean.mmainscrollno!=null? bean.mmainscrollno:0;
    mapData[TablesColumnFile.mbatchnumber] =	ifNullCheck(bean.mbatchnumber);
    mapData[TablesColumnFile.mnarration] =	ifNullCheck(bean.mnarration);
    mapData[TablesColumnFile.mcenterid] =	bean.mcenterid!=null? bean.mcenterid:0;
    mapData[TablesColumnFile.mcrs] =	ifNullCheck(bean.mcrs);
    mapData[TablesColumnFile.msuspbatchcd] =	ifNullCheck(bean.msuspbatchcd);
    mapData[TablesColumnFile.msuspsetno] =	bean.msuspsetno!=null? bean.msuspsetno:0;
    mapData[TablesColumnFile.msuspscrollno] =	bean.msuspscrollno!=null? bean.msuspscrollno:0;
    mapData[TablesColumnFile.msspmainscrollno] =	bean.msspmainscrollno!=null? bean.msspmainscrollno:0;
    mapData[TablesColumnFile.mpartcashamount] =	bean.mpartcashamount!=null? bean.mpartcashamount:0;
    mapData[TablesColumnFile.mpartcashbatchcd] =	ifNullCheck(bean.mpartcashbatchcd);
    mapData[TablesColumnFile.mpartcashsetno] =	bean.mpartcashsetno!=null? bean.mpartcashsetno:0;
    mapData[TablesColumnFile.mpartcashscrollno] =	bean.mpartcashscrollno!=null? bean.mpartcashscrollno:0;
    mapData[TablesColumnFile.mpartcashmainscrollno] =	bean.mpartcashmainscrollno!=null? bean.mpartcashmainscrollno:0;
    mapData[TablesColumnFile.mneftclsrBatchCd] =	ifNullCheck(bean.mneftclsrBatchCd);
    mapData[TablesColumnFile.mneftclsrsetno] =	bean.mneftclsrsetno!=null? bean.mneftclsrsetno:0;
    mapData[TablesColumnFile.mneftclsrscrollno] =	bean.mneftclsrscrollno!=null? bean.mneftclsrscrollno:0;
    mapData[TablesColumnFile.mneftclsrmainscrollno] =	bean.mneftclsrmainscrollno!=null? bean.mneftclsrmainscrollno:0;
    mapData[TablesColumnFile.mcreateddt] =	ifDateNullCheck(bean.mcreateddt);
    mapData[TablesColumnFile.mcreatedby] =	ifNullCheck(bean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] =	ifDateNullCheck(bean.mlastupdatedt);
    mapData[TablesColumnFile.mlastupdateby] =	ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] =	ifNullCheck(bean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] =	ifNullCheck(bean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] =	ifNullCheck(bean.mgeologd);
    mapData[TablesColumnFile.mlastsynsdate] =	ifDateNullCheck(bean.mlastsynsdate);
    mapData[TablesColumnFile.merrormessage] =	ifNullCheck(bean.merrormessage);
    mapData[TablesColumnFile.mdisbamount] =	bean.mdisbamount!=null? bean.mdisbamount:0;
    mapData[TablesColumnFile.mchargesamt1] =	bean.mchargesamt1!=null? bean.mchargesamt1:0;
    mapData[TablesColumnFile.mchargesamt2] =	bean.mchargesamt2!=null? bean.mchargesamt2:0;
    mapData[TablesColumnFile.mchargesamt0] =	bean.mchargesamt0!=null? bean.mchargesamt0:0;
    mapData[TablesColumnFile.mchargesamt3] =	bean.mchargesamt3!=null? bean.mchargesamt3:0;
    mapData[TablesColumnFile.mchargesamt4] =	bean.mchargesamt4!=null? bean.mchargesamt4:0;
    mapData[TablesColumnFile.mchargesamt5] =	bean.mchargesamt5!=null? bean.mchargesamt5:0;
    mapData[TablesColumnFile.mchargesamt6] =	bean.mchargesamt6!=null? bean.mchargesamt6:0;
    mapData[TablesColumnFile.mchargesamt7] =	bean.mchargesamt7!=null? bean.mchargesamt7:0;
    mapData[TablesColumnFile.mchargesamt8] =	bean.mchargesamt8!=null? bean.mchargesamt8:0;
    mapData[TablesColumnFile.mchargesamt9] =	bean.mchargesamt9!=null? bean.mchargesamt9:0;
    mapData[TablesColumnFile.isDataSynced] = 0;
    mapData[TablesColumnFile.mcheckbiometric] =	bean.mcheckbiometric!=null? bean.mcheckbiometric:0;
    mapData[TablesColumnFile.mdisbstatus] =	bean.mdisbstatus!=null? bean.mdisbstatus:0;
    mapData[TablesColumnFile.mrouteto] =	ifNullCheck(bean.mrouteto);
    mapData[TablesColumnFile.mremarks] =	ifNullCheck(bean.mremarks);

    listDisbursment.add(mapData);

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
