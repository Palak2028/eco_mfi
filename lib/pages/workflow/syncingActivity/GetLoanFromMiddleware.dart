import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetCustomerFromMiddleware.dart';
import 'package:path_provider/path_provider.dart';

class GetLoanFromMiddleware {
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlGetCustomerLoanDetails =
      "customerLoanData/getCustomerLoansbyCreatedByORrouteAndLastSyncedTiming/";
  static const JsonCodec JSON = const JsonCodec();
  ImageBean setBean;

  Future<Null> trySave(String userName,int lbrCd) async {
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      await getMiddleWareData(userName, urlGetCustomerLoanDetails,lbrCd);
    }
  }

  Future<Null> getMiddleWareData(String userName, String url,int lbrCd) async {
    //await AppDatabase.get().deletSomeUtil();

    String json;
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(6, true)
        .then((onValue) async {
      json = _toJsonOfCreatedByAndLastSyncedDateTime(userName, onValue);
      print(json);
    });
   try {
    String bodyValue = await NetworkUtil.callPostService(
        json.toString(), Constant.apiURL.toString() + url.toString(), _headers);
    print("url " + Constant.apiURL.toString() + url.toString());
    if (bodyValue == "404") {
      return null;
    } else {
      print(bodyValue);
      final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
      DateTime updateDateimeAfterUpdate = DateTime.now();
      List<CustomerLoanDetailsBean> obj = parsed
          .map<CustomerLoanDetailsBean>(
              (json) => CustomerLoanDetailsBean.fromMapMiddleware(json))
          .toList();

      for (int loan = 0; loan < obj.length; loan++) {

        if(obj[loan].mprdname==null || obj[loan].mprdname=='' ){
         await AppDatabase.get()
              .getProductOnPrdCd(30, lbrCd,obj[loan].mprdcd)
              .then((ProductBean response){
                if(response.mname !=null) {
                  obj[loan].mprdname = response.mname;
                }
         });
        }
        await AppDatabase.get()
            .updateCustomerLoanDetailsMaster(obj[loan])
            .then((onValue) {
          // customerNumberValue = onValue;
        });

        print("cgt1Bean Mater Update Complete");
        if (obj[loan].cgt1Bean != null && obj[loan].cgt1Bean.length > 0) {
          for (int cgt1List = 0;
              cgt1List < obj[loan].cgt1Bean.length;
              cgt1List++) {
            try {
              await AppDatabase.get()
                  .updateCGT1Master(obj[loan].cgt1Bean[cgt1List])
                  .then((onValue) async {
                if (obj[loan].cgt1Bean[cgt1List] != null) {
                  for (int cgt1 = 0;
                      cgt1 <
                          obj[loan].cgt1Bean[cgt1List].checkListCGT1Bean.length;
                      cgt1++) {
                    obj[loan].cgt1Bean[cgt1List].checkListCGT1Bean[cgt1].trefno =obj[loan].cgt1Bean[cgt1List].trefno;
                    obj[loan].cgt1Bean[cgt1List].checkListCGT1Bean[cgt1].mrefno =obj[loan].cgt1Bean[cgt1List].mrefno;
                    await AppDatabase.get()
                        .updateCgt1QaMaster(
                            obj[loan]
                                .cgt1Bean[cgt1List]
                                .checkListCGT1Bean[cgt1],
                            obj[loan]
                                .cgt1Bean[cgt1List]
                                .checkListCGT1Bean[cgt1]
                                .tclcgt1refno)
                        .then((onValue) {
                      //id = onValue;
                    });
                  }
                }
              });
            } catch (_) {}
          }
        }
        print("cgt2Bean Mater Update Complete");
        if (obj[loan].cgt2Bean != null && obj[loan].cgt2Bean.length > 0) {
          for (int cgt2List = 0;
              cgt2List < obj[loan].cgt2Bean.length;
              cgt2List++) {
            try {
              await AppDatabase.get()
                  .updateCGT2Master(obj[loan].cgt2Bean[cgt2List])
                  .then((onValue) async {
                if (obj[loan].cgt2Bean[cgt2List] != null) {
                  for (int cgt2 = 0;
                  cgt2 <
                      obj[loan].cgt2Bean[cgt2List].checkListCGT2Bean.length;
                  cgt2++) {
                    obj[loan].cgt2Bean[cgt2List].checkListCGT2Bean[cgt2].trefno =obj[loan].cgt2Bean[cgt2].trefno;
                    obj[loan].cgt2Bean[cgt2List].checkListCGT2Bean[cgt2].mrefno =obj[loan].cgt2Bean[cgt2].mrefno;
                    await AppDatabase.get()
                        .updateCgt2QaMaster(
                        obj[loan].cgt2Bean[cgt2List].checkListCGT2Bean[cgt2],
                        obj[loan]
                            .cgt2Bean[cgt2List]
                            .checkListCGT2Bean[cgt2]
                            .tclcgt2refno)
                        .then((onValue) {
                      //id = onValue;
                    });
                  }
                }
              });
            }catch(_){

            }
          }
        }
        if (obj[loan].grtBean != null && obj[loan].grtBean.length > 0) {
          print("grtBean Mater Update Complete");
          for (int grtList = 0; grtList < obj[loan].grtBean.length; grtList++) {
            try {
              await AppDatabase.get()
                  .updateGRTMaster(obj[loan].grtBean[grtList])
                  .then((onValue) async {
                if (obj[loan].grtBean[grtList] != null) {
                  for (int grt = 0;
                  grt < obj[loan].grtBean[grtList].checkListGRTBean.length;
                  grt++) {
                    obj[loan].grtBean[grtList].checkListGRTBean[grt].trefno =obj[loan].grtBean[grt].trefno;
                    obj[loan].grtBean[grtList].checkListGRTBean[grt].mrefno =obj[loan].grtBean[grt].mrefno;
                    await AppDatabase.get()
                        .updateGrtQaMaster(
                        obj[loan].grtBean[grtList].checkListGRTBean[grt],
                        obj[loan]
                            .grtBean[grtList]
                            .checkListGRTBean[grt]
                            .tclgrtrefno)
                        .then((onValue) {
                      //id = onValue;
                    });
                  }
                }
              });
            }catch(_){

            }
          }
        }

        GetCustomerFromMiddleware getCustObj = new GetCustomerFromMiddleware();
        if (obj[loan].custBean != null) {
          print(
              "xxxxxxxxxxxxxxx custname is ${obj[loan].custBean.mlongname}  ");
          await getCustObj.updateCustomer(obj[loan].custBean);
        }
      }
      //updating lastsynced date time with now
      AppDatabase.get().updateStaticTablesLastSyncedMasterGetFromServer(
          6, updateDateimeAfterUpdate);

      await AppDatabase.get()
          .selectStaticTablesLastSyncedMaster(6, false)
          .then((onValue) async {
        if (onValue == null) {
          AppDatabase.get().updateStaticTablesLastSyncedMaster(6);
        }
      });
    }

   } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }

  String _toJsonOfCreatedByAndLastSyncedDateTime(
      String loggedInUser, DateTime lastsyncedDateTime) {
    var mapData = new Map();
    mapData["mcreatedby"] = loggedInUser;
    //  mapData["routeTo"] = agentUserNo.toString().trim();
    mapData["mlastsynsdate"] = lastsyncedDateTime != null &&
            lastsyncedDateTime != 'null' &&
            lastsyncedDateTime != ''
        ? lastsyncedDateTime.toIso8601String()
        : null;
    String json = JSON.encode(mapData);
    print(json);
    return json;
  }
}
