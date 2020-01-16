import 'dart:async';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;

/*import 'package:eco_mfi/pages/workflow/CGT/bean/CGT1Services.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT2Services.dart';
import 'package:eco_mfi/pages/workflow/GRT/GRTServices.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFoundation.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanSyncing.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterFoundationBean.dart';*/

import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CbResultBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CreditBereauBean.dart';
/*import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationLoanDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationDeclarationForm.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationContactDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/FamilyDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_mfi/pages/workflow/qrScanner/QrScanner.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetCustomerFromMiddleware.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingProducts.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingPurposeOfLoan.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingRepaymentFrequency.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingTransactionMode.dart';*/
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
/*import 'package:dio/dio.dart';*/

class GetProspectFromMiddleware {
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  var addProspect = "/ProspectCreationMaster/addProspectByHolder/";
  var urlGetNOCInfo =
      "/ProspectCreationMaster/getListByRoutedToAndIsDataSynced/";

  var urlGetNocCheckedData = "/ProspectCreationMaster/getListNocCheckedData/";

  var urlGetAllProspectInfo = "/ProspectCreationMaster/getProspect/";

  SharedPreferences prefs;

  static final _headers = {'Content-Type': 'application/json'};
  DateTime lastSyncedToTab;

  /*static final _headers2 = {
    'Content-Type': 'aapplication/x-www-form-urlencoded'
  };*/
  static const JsonCodec JSON = const JsonCodec();
  Utility obj = new Utility();

  /*String agentName;*/

  static String _serviceUrl = "";
/* CbResultBean cbResult = new CbResultBean();
  List<CbResultBean> cbLoanList = new List<CbResultBean>();
  List prospectList = new List();
  List listCust = List();
  List cbLoanJsonList = List();
  String cbResultjson;
  String prospectjson;

*/

  Future<String> getProspect() async {

    print("inside getting prospect");
     lastSyncedToTab =
        await AppDatabase.get().selectlastSyncedDateTimeToTab(2);

    String json = await prospectToJson(lastSyncedToTab);
    print("Sending json is ${json}");

    List<CreditBereauBean> creditBereauBeanoObjList =
        await uploadFetchingProspectRequest(json);
  }

  Future<String> prospectToJson(DateTime lastSyncDateTime) async {
    var mapData = new Map();
    mapData[TablesColumnFile.mlastsynsdate] = ifDateNullCheck(lastSyncDateTime);
    mapData[TablesColumnFile.mcreatedby] = globals.agentUserName;
    //mapData[TablesColumnFile.mlastupdatedt] =

    String json = await JSON.encode(mapData);
    return json;
  }

  Future<List<CreditBereauBean>> uploadFetchingProspectRequest(
      String json) async {



    String bodyValue = await NetworkUtil.callPostService(json.toString(),
        Constant.apiURL.toString() + urlGetAllProspectInfo.toString(), _headers);
    print("url " + Constant.apiURL.toString() + urlGetAllProspectInfo.toString());
  if (bodyValue == "error"|| bodyValue == null) {
      return null;
    } else {


      print(bodyValue);
      final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
      print(parsed);
      print("Data returned");

      List<CreditBereauBean> obj = parsed
          .map<CreditBereauBean>(
              (json) => CreditBereauBean.fromMapFromMiddleware(json, true))
          .toList();

      await obj.forEach((creditBereauObj)async {

        creditBereauObj.mlastsynsdate = DateTime.now();
        if(creditBereauObj.mcreatedby.trim()==globals.agentUserName.trim()){

          /*await AppDatabase.get().checkTrefMref(creditBereauObj.trefno,creditBereauObj.mrefno).then((CreditBereauBean cbb) async{*/
          //await AppDatabase.get().getMinMrefNoCreditBereauMaster(creditBereauObj.trefno).then((int minMref) async{



            print("lastSynced  is ${lastSyncedToTab}");
            if(lastSyncedToTab==null){
              await AppDatabase.get().updateCreditBereauMaster(creditBereauObj);


              if(creditBereauObj.cbResultMasterDetails!=null) {
                creditBereauObj.cbResultMasterDetails.mrefno = creditBereauObj.mrefno;
                await AppDatabase.get().updateCreditBereauResult(creditBereauObj.cbResultMasterDetails);
              }

              creditBereauObj.cbLoanDetails.forEach((CbResultBean loanBean)async {
                loanBean.mrefno = creditBereauObj.mrefno;
                await AppDatabase.get().updateCreditBereauLoanDetailsWithLoanSeq(loanBean, loanBean.trefsrno);

              });
            }
            /*else if(minMref==0){

              await AppDatabase.get().updateCreditBereauMasterMrefFromminMref(creditBereauObj,creditBereauObj.trefno,creditBereauObj.mrefno,DateTime.now());

              if(creditBereauObj.cbResultMasterDetails!=null){
                creditBereauObj.cbResultMasterDetails.mrefno = creditBereauObj.mrefno;
                await AppDatabase.get().updateCreditBereauResultTrefSrNo(creditBereauObj.cbResultMasterDetails,creditBereauObj.trefno);

              }

              creditBereauObj.cbLoanDetails.forEach((CbResultBean loanBean)async {
                loanBean.mrefno = creditBereauObj.mrefno;
                await AppDatabase.get().updateCreditBereauLoanDetailsTrefSrNo(loanBean, loanBean.trefsrno);


              });

            }*/
            else {

              await AppDatabase.get().updateCrdtBreuMastrPrspctStatus(creditBereauObj.trefno,creditBereauObj.mrefno
              ,creditBereauObj.mprospectstatus,creditBereauObj.mlastupdatedt,DateTime.now());

              if(creditBereauObj.cbResultMasterDetails!=null){
                creditBereauObj.cbResultMasterDetails.mrefno = creditBereauObj.mrefno;
                await AppDatabase.get().updateExposureFromMrefTref(creditBereauObj.trefno,creditBereauObj.mrefno,creditBereauObj.cbResultMasterDetails.mexpsramt);
                //await AppDatabase.get().updateCreditBereauResultTrefSrNo(creditBereauObj.cbResultMasterDetails,creditBereauObj.trefno);

              }

              creditBereauObj.cbLoanDetails.forEach((CbResultBean loanBean)async {
                loanBean.mrefno = creditBereauObj.mrefno;
                //await AppDatabase.get().updateCreditBereauLoanDetailsTrefSrNo(loanBean, loanBean.trefsrno,true);
                await AppDatabase.get().updateCreditBereauLoanDetailsWithLoanSeq(loanBean, loanBean.trefsrno);


              });
            }



          /*});*/




        }

        //else if(creditBereauObj.mroutedto==globals.agentUserName.trim()){
        else {



          await AppDatabase.get().checkTrefMref(creditBereauObj.trefno,creditBereauObj.mrefno).then((CreditBereauBean cbb) async{

            cbb=null;
            if(cbb==null){

              await AppDatabase.get().updateCreditBereauMaster(creditBereauObj);


              if(creditBereauObj.cbResultMasterDetails!=null) {
                creditBereauObj.cbResultMasterDetails.mrefno = creditBereauObj.mrefno;
                await AppDatabase.get().updateCreditBereauResult(creditBereauObj.cbResultMasterDetails);
              }

              creditBereauObj.cbLoanDetails.forEach((CbResultBean loanBean)async {
                loanBean.mrefno = creditBereauObj.mrefno;
                await AppDatabase.get().updateCreditBereauLoanDetailsForImage(loanBean, loanBean.trefsrno);

              });

            }



          });

/*
             CbResultBean existingResult = await AppDatabase.get().checkCreditBereauResult(creditBereauObj);

             if(existingResult!=null){


             }*/




        }


        print("*******creditObj is ${creditBereauObj}");
        print("*******cbresult is ${creditBereauObj.cbResultMasterDetails}");

        creditBereauObj.cbLoanDetails.forEach((cbLoanDetailsObj){
          print("*******cbLoanDetails is ${cbLoanDetailsObj}");
        });


      });

      if(obj!=null&&obj.isNotEmpty) await AppDatabase.get().updatelastSyncDateTimeMasterToTab(DateTime.now(),2);
    }
  }

  String ifDateNullCheck(DateTime value){
    if(value==null || value == 'null'){
      return null;
    }
    else {
      return  value.toIso8601String();
    }

  }
}
