import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT1Services.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT2Services.dart';
import 'package:eco_mfi/pages/workflow/GRT/GRTServices.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFoundation.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanSyncing.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CbResultBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CreditBereauBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/FamilyDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_mfi/pages/workflow/qrScanner/QrScanner.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetCustomerFromMiddleware.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingProducts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ProspectServices {
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  var addProspect = "/ProspectCreationMaster/addProspectByHolder/";
  var addProspect2 = "/ProspectCreationMaster/add";
  var addProspectResult = "/ProspectCreationMaster/addProspectCheckedResult/";
  var addProspectLoanResult = "/creditBereauLoanData/addLoanDetails/";
  var urlGetNOCInfo =
      "/ProspectCreationMaster/getListByRoutedToAndIsDataSynced/";

  var urlGetNocCheckedData = "/ProspectCreationMaster/getListNocCheckedData/";


  var urlGetAllProspectInfo = "/ProspectCreationMaster/getDataByAgentUserName/";

  SharedPreferences prefs;

  static final _headers = {'Content-Type': 'application/json'};
  static final _headers2 = {
    'Content-Type': 'aapplication/x-www-form-urlencoded'
  };
  static const JsonCodec JSON = const JsonCodec();
  Utility obj = new Utility();

  String agentName;



  static String _serviceUrl = "";
  CbResultBean  cbResult =  new CbResultBean();
  List<CbResultBean> cbLoanList =  new List<CbResultBean>();
  List<CbResultBean> cbCheckedLoanList =  new List<CbResultBean>();
  CbResultBean  cbCheckedResult =  new CbResultBean();
  List prospectList = new List();
  List prospectCheckedList = new List();
  List listCust = List();
  List cbLoanJsonList = List();
  String cbResultjson;
  String prospectjson;



  Future<Null>  syncCheckedDataToMiddleware (String json) async {

    String bodyValue = await NetworkUtil.callPostService(json.toString(),
        Constant.apiURL.toString() + addProspectResult.toString(), _headers);
    print("url " + Constant.apiURL.toString() + _serviceUrl.toString());
    if (bodyValue == "error") {
      print("error coming");
      return null;
    } else {


      print(bodyValue);
      final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
      print(parsed);


      print("Data returned");








      await AppDatabase.get().updatelastSyncDateTimeMasterFromTab(DateTime.now(),2);


    }


  }

  Future<Null> syncedDataToMiddleware(String json) async {


    String bodyValue = await NetworkUtil.callPostService(json.toString(),
        Constant.apiURL.toString() + addProspect.toString(), _headers);
    print("url " + Constant.apiURL.toString() + _serviceUrl.toString());
    if (bodyValue == "error") {
      return null;
    }
    else if(bodyValue==null){
      return null;
    }

    else {



      var parsed;
      try{
        parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
      }catch(_){
        return null;
      }

      print(parsed);


      print("Data returned");
      print(bodyValue);
      List<CreditBereauBean> obj = parsed
          .map<CreditBereauBean>(
              (json) => CreditBereauBean.fromMapFromMiddleware(json, true))
          .toList();


      await obj.forEach((creditBereauObj)async {

        creditBereauObj.mlastsynsdate = DateTime.now();
        //CreditBereauBean cbb = await AppDatabase.get().checkTrefMref(creditBereauObj.trefno,creditBereauObj.mrefno);



        if(creditBereauObj.mcreatedby.trim()==globals.agentUserName.trim()){



              CreditBereauBean tempBean = await AppDatabase.get().getPrspctFrmMrefAndTerf(creditBereauObj.mrefno,creditBereauObj.trefno);

            if(tempBean==null){
              print("TempBean is null");
              await AppDatabase.get().updateCreditBereauMasterMrefFromTref(creditBereauObj,creditBereauObj.trefno,creditBereauObj.mrefno,DateTime.now(),false);
            }
            else{
              await AppDatabase.get().updateCreditBereauMasterMrefFromTref(creditBereauObj,creditBereauObj.trefno,tempBean.mrefno,DateTime.now(),true);
            }




            if(creditBereauObj.cbResultMasterDetails!=null){

              CbResultBean tempCreditBereauResult = await AppDatabase.get().getCbResult
                (creditBereauObj.trefno, creditBereauObj.mrefno);
              if(tempCreditBereauResult==null) {
                creditBereauObj.cbResultMasterDetails.mrefno =
                    creditBereauObj.mrefno;
                await AppDatabase.get().updateCreditBereauResultTrefSrNo(
                    creditBereauObj.cbResultMasterDetails,
                    creditBereauObj.trefno);
              }
            }


            int countLoan = 0;
              List<CbResultBean> tempCreditBereauBeanObj = new List<CbResultBean>();
            creditBereauObj.cbLoanDetails.forEach((CbResultBean loanBean)async {
              if(countLoan== 0){
                tempCreditBereauBeanObj  = await AppDatabase.get().getLoanDetails(creditBereauObj.trefno,
                    creditBereauObj.mrefno);

                countLoan++;
              }
              loanBean.mrefno = creditBereauObj.mrefno;
              if(tempCreditBereauBeanObj.isEmpty) {

                await AppDatabase.get().updateCreditBereauLoanDetailsTrefSrNo(
                    loanBean, loanBean.trefsrno,false);
              }
              else{
                await AppDatabase.get().updateCreditBereauLoanDetailsTrefSrNo(
                    loanBean, loanBean.trefsrno,true);
              }


          });

        }

          else {

          print("inside routed To");

          AppDatabase.get().updateCreditBereauMasterlstUpdtDate(DateTime.now(),creditBereauObj.trefno,creditBereauObj.mrefno);



        }






        print("*******creditObj is ${creditBereauObj}");
        print("*******cbresult is ${creditBereauObj.cbResultMasterDetails}");

        creditBereauObj.cbLoanDetails.forEach((cbLoanDetailsObj){
          print("*******cbLoanDetails is ${cbLoanDetailsObj}");
        });

      });


      await AppDatabase.get().updatelastSyncDateTimeMasterFromTab(DateTime.now(),2);



      /*for (int cust = 0; cust < obj.length; cust++) {
          print("print que : " +
              obj[cust].mcreatedby.toString() +
              " : " +
              obj[cust].trefno.toString());
          await AppDatabase.get()
              .selectCustomerOnTref(obj[cust].trefno, obj[cust].mcreatedby)
              .then((CustomerListBean customerData) async {
            String updateCustQuery = null;
            String updateFamQuery = null;
            String updateBorroQuery = null;
            String updateAddrQuery = null;

            bool isSyncingFirstTime = false;
            if (customerData.mrefno != null && customerData.mrefno == 0) {
              isSyncingFirstTime = true;
              updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' , ${TablesColumnFile.mrefno} = ${obj[cust].mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[cust].trefno}";
            } else {
              updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' WHERE ${TablesColumnFile.mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust].trefno}";
            }
            if (updateCustQuery != null) {
              await AppDatabase.get().updateCustomerMaster(updateCustQuery);
            }
            for (int famList = 0;
            famList < obj[cust].familyDetailsList.length;
            famList++) {
              if (isSyncingFirstTime) {
                updateFamQuery =
                "${TablesColumnFile.mfamilyrefno} = ${obj[cust].familyDetailsList[famList].mfamilyrefno},${TablesColumnFile.mrefno} = ${obj[cust].mrefno} WHERE ${TablesColumnFile.mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust].familyDetailsList[famList].trefno}";
              } else {
                updateFamQuery =
                "${TablesColumnFile.mfamilyrefno} = ${obj[cust].familyDetailsList[famList].mfamilyrefno}  WHERE ${TablesColumnFile.mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust].familyDetailsList[famList].trefno}";
              }

              if (updateCustQuery != null) {
                await AppDatabase.get().updateFamily(updateFamQuery);
              }
            }



            for (int borroList = 0;
            borroList < obj[cust].borrowingDetailsBean.length;
            borroList++) {
              if (isSyncingFirstTime) {
                updateBorroQuery =
                "${TablesColumnFile.mborrowingrefno} = ${obj[cust].borrowingDetailsBean[borroList].mborrowingrefno},${TablesColumnFile.mrefno} = ${obj[cust].mrefno} WHERE ${TablesColumnFile.mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust].borrowingDetailsBean[borroList].trefno}";
              } else {
                updateBorroQuery =
                "${TablesColumnFile.mborrowingrefno} = ${obj[cust].borrowingDetailsBean[borroList].mborrowingrefno}  WHERE ${TablesColumnFile.mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust].borrowingDetailsBean[borroList].trefno}";
              }

              if (updateBorroQuery != null) {
                await AppDatabase.get().updateBorrowing(updateBorroQuery);
              }
            }
          });
        }
        //updating lastsynced date time with now
        AppDatabase.get().updateStaticTablesLastSyncedMaster(1);*/
    }
    /* } catch (e) {
      print('Server Exception!!!');
      print(e);
    }*/
  }


  Future<String> uploadProspectData() async {
    List prospectjsonList = new List();
    cbLoanJsonList = List();
    prospectList = new List();
    prospectCheckedList = new List();
    cbResultjson = null;


    prefs = await  SharedPreferences.getInstance();
    globals.agentUserName = prefs.getString(TablesColumnFile.musrcode);


    await AppDatabase.get().selectStaticTablesLastSyncedMaster(2,false).then((onValue) async{




      await AppDatabase.get()
          .selectProspectListIsDataSynced(onValue)
          .then((List<CreditBereauBean> prospectData) async {
        if(prospectData.isEmpty){
          print("Returned Empty");

          return ;
        }
        print("length cust "+prospectData.length.toString());
        for (int i = 0; i < prospectData.length; i++) {

          print("returned prospect is  ${prospectData[i]}");
          cbResult = new CbResultBean();
          cbLoanList = new List();
          if(globals.agentUserName!=null&&globals.agentUserName!=null&&
              globals.agentUserName.trim()!=""&&globals.agentUserName!=""&&
              globals.agentUserName.trim().toLowerCase()!="null"&&globals.agentUserName.toLowerCase()!="null"&&
              globals.agentUserName.trim().toLowerCase()==prospectData[i].mcreatedby.trim().toLowerCase()){

            await AppDatabase.get()
                .getCreditBereauResultIsSynced(prospectData[i].trefno,
                prospectData[i].mrefno).then((CbResultBean cbResultBean)async{


              cbResult= cbResultBean;

            });


            await AppDatabase.get().selectCreditBereauLoanListIsDataSynced(
                prospectData[i].trefno, prospectData[i].mrefno)
                .then((List<CbResultBean> cbResultLoanList) async {

              cbLoanList = cbResultLoanList;


            });

            await toProspectJson(prospectData[i]);
          }else if(globals.agentUserName!=null&&prospectData[i].mcreatedby!=null&&prospectData[i]!='null'&&
              globals.agentUserName!='null'&&
              globals.agentUserName.trim()!=""&&prospectData[i].mcreatedby.trim()!=""
          &&(prospectData[i].mprospectstatus==5||prospectData[i].mprospectstatus==6)
          ){


              print("inside checked list adding");

              await AppDatabase.get().selectCreditBereauLoanListIsDataSynced(
                  prospectData[i].trefno, prospectData[i].mrefno)
                  .then((List<CbResultBean> cbResultLoanList) async {

                cbCheckedLoanList = cbResultLoanList;


              });

              await AppDatabase.get().getCreditBereauResultIsSynced(
                  prospectData[i].trefno, prospectData[i].mrefno)
                  .then((CbResultBean returnedCbResultBean) async {

                cbCheckedResult= returnedCbResultBean;


              });

              await cbCheckUploadCbJson(prospectData[i]);
              print("checked List is ${prospectCheckedList}");

              prospectjson = null;




          }

        }
      });

    });




    if(prospectList.isNotEmpty){
      String json =  await JSON.encode(prospectList);

      print("Sending json is");
      for( var item in json.split(",") ){
        print(item);
      }


      await syncedDataToMiddleware(json);

    }

    if(prospectCheckedList.isNotEmpty){
      String checkedJson =  await JSON.encode(prospectCheckedList);

      await syncCheckedDataToMiddleware(checkedJson);

    }


  }





  Future<String> cbCheckUploadCbJson(CreditBereauBean  prospectListBean) async {

    var mapData = new Map();
    mapData[TablesColumnFile.trefno] =	  prospectListBean.trefno==null?0:prospectListBean.trefno;
    mapData[TablesColumnFile.mrefno] =	  prospectListBean.mrefno==null?0:prospectListBean.mrefno;
    mapData[TablesColumnFile.mprospectstatus]  = prospectListBean.mprospectstatus==null?0:prospectListBean.mprospectstatus;
    mapData[TablesColumnFile.mcreatedby]  = ifNullCheck(prospectListBean.mcreatedby);
    mapData[TablesColumnFile.mlastupdateby] = ifNullCheck(prospectListBean.mlastupdateby);
    mapData[TablesColumnFile.mroutedto] = ifNullCheck(prospectListBean.mroutedto);
    mapData[TablesColumnFile.mlastupdatedt] = ifDateNullCheck(prospectListBean.mlastupdatedt);
    mapData[TablesColumnFile.mlastsynsdate] = DateTime.now().toIso8601String();

    var mapDataCbResult = new Map() ;
    var mapCbCheckData;

    if(cbCheckedResult!=null){
      mapCbCheckData =   new Map();
      mapCbCheckData[TablesColumnFile.trefno] =cbCheckedResult.trefno==null?0:cbCheckedResult.trefno;
      mapCbCheckData[TablesColumnFile.mrefno] =cbCheckedResult.mrefno==null?0:cbCheckedResult.mrefno;
      mapCbCheckData[TablesColumnFile.mexpsramt] =cbCheckedResult.mexpsramt==null?0:cbCheckedResult.mexpsramt;

    }
    mapData[TablesColumnFile.cbResultMasterDetails] =  mapCbCheckData;


    var dataCbLoanList= new List();
    if(cbCheckedLoanList.isNotEmpty){

      for(int loanList = 0 ;loanList<cbCheckedLoanList.length;loanList++){
        mapDataCbResult = new Map();
        mapDataCbResult[TablesColumnFile.mrefno] =	cbCheckedLoanList[loanList].mrefno;
        mapDataCbResult[TablesColumnFile.trefno] =	cbCheckedLoanList[loanList].trefno;
        mapDataCbResult[TablesColumnFile.trefsrno] =	cbCheckedLoanList[loanList].trefsrno;
        mapDataCbResult[TablesColumnFile.mrefsrno] =	cbCheckedLoanList[loanList].mrefsrno;
        mapDataCbResult[TablesColumnFile.maccounttype] = ifNullCheck(cbCheckedLoanList[loanList].maccounttype);
        mapDataCbResult[TablesColumnFile.mcurrentbalance] = cbCheckedLoanList[loanList].mcurrentbalance==null?0.0:cbCheckedLoanList[loanList].mcurrentbalance;
        mapDataCbResult[TablesColumnFile.mcustbankacnum] = ifNullCheck(cbCheckedLoanList[loanList].mcustbankacnum);
        mapDataCbResult[TablesColumnFile.mdatereported] = ifNullCheck(cbCheckedLoanList[loanList].mdatereported);
        mapDataCbResult[TablesColumnFile.mdisbursedamount] = cbCheckedLoanList[loanList].mdisbursedamount==null?0.0:cbCheckedLoanList[loanList].mdisbursedamount;
        mapDataCbResult[TablesColumnFile.mnameofmfi] = ifNullCheck(cbCheckedLoanList[loanList].mnameofmfi);
        mapDataCbResult[TablesColumnFile.mmfiid] = ifNullCheck(cbCheckedLoanList[loanList].mmfiid);
        print("NOCimage string isssssss     ${cbCheckedLoanList[loanList].mnocimagestring}");
        if (cbCheckedLoanList[loanList].mnocimagestring != null && cbCheckedLoanList[loanList].mnocimagestring != "null"
            &&cbCheckedLoanList[loanList].mnocimagestring !=""){
          File imageFile = new File(cbCheckedLoanList[loanList].mnocimagestring);
          final Directory extDir = await getApplicationDocumentsDirectory();
          var targetPath = extDir.absolute.path + "/temp.png";
          var imgFile = await compressAndGetFile(imageFile, targetPath,false);
          List<int> imageBytes = imgFile.readAsBytesSync();
          String base64Image = base64.encode(imageBytes);


          mapDataCbResult["mnocimagestring"] = base64Image;
        } else
          mapDataCbResult[TablesColumnFile.mnocimagestring] = "";
        /* mapDataCbResult[TablesColumnFile.mnocimagestring] = ifNullCheck(cbLoanList[loanList].mnocimagestring);*/
        mapDataCbResult[TablesColumnFile.moverdueamount] = cbCheckedLoanList[loanList].moverdueamount==null?0.0:cbCheckedLoanList[loanList].moverdueamount;
        mapDataCbResult[TablesColumnFile.mwriteoffamount] = cbCheckedLoanList[loanList].mwriteoffamount==null?0.0:cbCheckedLoanList[loanList].mwriteoffamount;
        mapDataCbResult[TablesColumnFile.magentusername] = ifNullCheck(cbCheckedLoanList[loanList].magentusername);
        mapDataCbResult["aadhaarno"] = "";
        dataCbLoanList.add(mapDataCbResult);

      }
      mapData[TablesColumnFile.cbLoanDetails] =  dataCbLoanList;
    }

    prospectCheckedList.add(mapData);

  }

  Future<String> toProspectJson(CreditBereauBean prospectListBean)async {

    var mapData = new Map();
    mapData[TablesColumnFile.trefno] =	  prospectListBean.trefno==null?0:prospectListBean.trefno;
    mapData[TablesColumnFile.mrefno] =	  prospectListBean.mrefno==null?0:prospectListBean.mrefno;
    mapData[TablesColumnFile.mlbrcode] =	  prospectListBean.mlbrcode==null?0:prospectListBean.mlbrcode;
    mapData[TablesColumnFile.mqueueno] =	  prospectListBean.mqueueno==null?0:prospectListBean.mqueueno;
    mapData[TablesColumnFile.mprospectdt] =	  ifDateNullCheck(prospectListBean.mprospectdt);
    mapData[TablesColumnFile.mnametitle] =	  ifNullCheck(prospectListBean.mnametitle);
    mapData[TablesColumnFile.mprospectname] =	  prospectListBean.mprospectname;
    mapData[TablesColumnFile.mmobno] =	  ifNullCheck(prospectListBean.mmobno.toString());
    mapData[TablesColumnFile.mdob] =	  ifDateNullCheck(prospectListBean.mdob);
    mapData[TablesColumnFile.motpverified] =	  prospectListBean.motpverified==null?0:prospectListBean.motpverified;
    mapData[TablesColumnFile.mcbcheckstatus] =	  ifNullCheck(prospectListBean.mcbcheckstatus);
    mapData[TablesColumnFile.mprospectstatus] =	  prospectListBean.mprospectstatus==null?0:prospectListBean.mprospectstatus;
    mapData[TablesColumnFile.madd1] =	  ifNullCheck(prospectListBean.madd1);
    mapData[TablesColumnFile.madd2] =	  ifNullCheck(prospectListBean.madd2);
    mapData[TablesColumnFile.madd3] =	  ifNullCheck(prospectListBean.madd3);
    mapData[TablesColumnFile.mhomeloc] =	  ifNullCheck(prospectListBean.mhomeloc);
    mapData[TablesColumnFile.mareacd] =	  prospectListBean.mareacd==null?0:prospectListBean.mareacd;
    mapData[TablesColumnFile.mvillage] =	  ifNullCheck(prospectListBean.mvillage);
    mapData[TablesColumnFile.mdistcd] =	  prospectListBean.mdistcd==null?0:prospectListBean.mdistcd;
    mapData[TablesColumnFile.mstatecd] =	  ifNullCheck(prospectListBean.mstatecd);
    mapData[TablesColumnFile.mcountrycd] =	  ifNullCheck(prospectListBean.mcountrycd);
    mapData[TablesColumnFile.mpincode] =	  prospectListBean.mpincode==null?0:prospectListBean.mpincode;
    mapData[TablesColumnFile.mcountryoforigin] =	  ifNullCheck(prospectListBean.mcountryoforigin);
    mapData[TablesColumnFile.mnationality] =	  ifNullCheck(prospectListBean.mnationality);
    mapData[TablesColumnFile.mpanno] =	  ifNullCheck(prospectListBean.mpanno);
    mapData[TablesColumnFile.mpannodesc] =	  ifNullCheck(prospectListBean.mpannodesc);
    mapData[TablesColumnFile.missynctocoresys] =	  prospectListBean.missynctocoresys==null?0:prospectListBean.missynctocoresys;
    mapData[TablesColumnFile.misuploaded] =	  prospectListBean.misuploaded==null?0:prospectListBean.misuploaded;
    mapData[TablesColumnFile.mspousename] =	  ifNullCheck(prospectListBean.mspousename);
    mapData[TablesColumnFile.mspouserelation] =	  ifNullCheck(prospectListBean.mspouserelation);
    mapData[TablesColumnFile.mnomineename] =	  ifNullCheck(prospectListBean.mnomineename);
    mapData[TablesColumnFile.mnomineerelation] =	  ifNullCheck(prospectListBean.mnomineerelation);
    mapData[TablesColumnFile.mcreditenqpurposetype] =	  ifNullCheck(prospectListBean.mcreditenqpurposetype);
    mapData[TablesColumnFile.mcreditequstage] =	  ifNullCheck(prospectListBean.mcreditequstage);
    mapData[TablesColumnFile.mcreditreporttransdatetype] =	 ifDateNullCheck(prospectListBean.mcreditreporttransdatetype);
    mapData[TablesColumnFile.mcreditreporttransid] =	  ifNullCheck(prospectListBean.mcreditreporttransid);
    mapData[TablesColumnFile.mcreditrequesttype] =	  ifNullCheck(prospectListBean.mcreditrequesttype);
    mapData[TablesColumnFile.mcreateddt] =	  ifDateNullCheck(prospectListBean.mcreateddt);
    mapData[TablesColumnFile.mcreatedby] =	  ifNullCheck(prospectListBean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] =	  ifDateNullCheck(prospectListBean.mlastupdatedt);
    mapData[TablesColumnFile.mlastupdateby] =	  ifNullCheck(prospectListBean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] =	  ifNullCheck(prospectListBean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] =	  ifNullCheck(prospectListBean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] =	  ifNullCheck(prospectListBean.mgeologd);
    mapData[TablesColumnFile.mlastsynsdate] =	DateTime.now().toIso8601String();
    mapData[TablesColumnFile.mstreet] =	  ifNullCheck(prospectListBean.mstreet);
    mapData[TablesColumnFile.mhouse] =	  ifNullCheck(prospectListBean.mhouse);
    mapData[TablesColumnFile.mcity] =	  ifNullCheck(prospectListBean.mcity);
    mapData[TablesColumnFile.mstate] =	  ifNullCheck(prospectListBean.mstate);
    mapData[TablesColumnFile.mid1] =	  ifNullCheck(prospectListBean.mid1);
    mapData[TablesColumnFile.mid1desc] =	  ifNullCheck(prospectListBean.mid1desc);
    mapData[TablesColumnFile.motp] =	  prospectListBean.motp==null?0:prospectListBean.motp;
    mapData[TablesColumnFile.mroutedto] =	  ifNullCheck(prospectListBean.mroutedto);
    mapData[TablesColumnFile.miscustcreated] =	  prospectListBean.miscustcreated==null?0:prospectListBean.miscustcreated;
    mapData[TablesColumnFile.mtier] =	  prospectListBean.mtier==null?0:prospectListBean.mtier;
    mapData[TablesColumnFile.mcustno] =	  prospectListBean.mcustno==null?0:prospectListBean.mcustno;
    mapData[TablesColumnFile.mhighmarkchkdt] =	  ifDateNullCheck(prospectListBean.mhighmarkchkdt);
    print(mapData[TablesColumnFile.cbResultMasterDetails]);

    var mapCbCheckData;

    if(cbResult!=null){
      mapCbCheckData =   new Map();
      mapCbCheckData[TablesColumnFile.trefno] =cbResult.trefno==null?0:cbResult.trefno;
      mapCbCheckData[TablesColumnFile.mrefno] =cbResult.mrefno==null?0:cbResult.mrefno;
      mapCbCheckData[TablesColumnFile.mcbcheckstatus] =ifNullCheck(cbResult.mcbcheckstatus);
      mapCbCheckData[TablesColumnFile.mdateofissue] =ifNullCheck(cbResult.mdateofissue);
      mapCbCheckData[TablesColumnFile.mdateofrequest] =ifNullCheck(cbResult.mdateofrequest);
      mapCbCheckData[TablesColumnFile.mpreparedfor] =ifNullCheck(cbResult.mpreparedfor);
      mapCbCheckData[TablesColumnFile.miscustomercreated] ="";
      mapCbCheckData[TablesColumnFile.mreportid] = ifNullCheck(cbResult.mreportid);
      mapCbCheckData[TablesColumnFile.mothrmficnt] =cbResult.mothrmficurbal==null?0:cbResult.mothrmficnt;
      mapCbCheckData[TablesColumnFile.mloancycle] = cbResult.mothrmficurbal==null?0:cbResult.mloancycle;
      mapCbCheckData[TablesColumnFile.mothrmficurbal] =cbResult.mothrmficurbal==null?0.0:cbResult.mothrmficurbal;
      mapCbCheckData[TablesColumnFile.mothrmfiovrdueamt] =cbResult.mothrmfiovrdueamt==null?0.0:cbResult.mothrmfiovrdueamt;
      mapCbCheckData[TablesColumnFile.mothrmfidisbamt] = 	cbResult.mothrmfidisbamt==null?0.0:cbResult.mothrmfidisbamt;
      mapCbCheckData[TablesColumnFile.mtotovrdueaccno] = cbResult.mtotovrdueaccno==null?0.0:cbResult.mtotovrdueaccno;
      mapCbCheckData[TablesColumnFile.mmfitotdisbamt] = cbResult.mmfitotdisbamt==null?0.0:cbResult.mmfitotdisbamt;
      mapCbCheckData[TablesColumnFile.mmfitotcurrentbal] = cbResult.mmfitotcurrentbal==null?0:cbResult.mmfitotcurrentbal;
      mapCbCheckData[TablesColumnFile.mmfitotovrdueamt] = cbResult.mmfitotovrdueamt==null?0:cbResult.mmfitotovrdueamt;
      mapCbCheckData[TablesColumnFile.mtotovrdueamt] = 	cbResult.mtotovrdueamt==null?0:cbResult.mtotovrdueamt;
      mapCbCheckData[TablesColumnFile.mtotcurrentbal] = cbResult.mtotcurrentbal==null?0:cbResult.mtotcurrentbal;
      mapCbCheckData[TablesColumnFile.mtotdisbamt] = cbResult.mtotdisbamt==null?0:cbResult.mtotdisbamt;
      mapCbCheckData[TablesColumnFile.mexpsramt] = cbResult.mexpsramt==null?0:cbResult.mexpsramt;
      mapCbCheckData[TablesColumnFile.mcbresultblob] = ifNullCheck(cbResult.mcbresultblob);


      /*
      mapCbCheckData[TablesColumnFile.mprimarycurrentbal] =ifNullCheck(cbResult.mprimarycurrentbal);
      mapCbCheckData[TablesColumnFile.mprimarynoofaccounts] =ifNullCheck(cbResult.mprimarynoofaccounts);
      mapCbCheckData[TablesColumnFile.mprimaryoverdueamount] =ifNullCheck(cbResult.mprimaryoverdueamount);
      mapCbCheckData[TablesColumnFile.mprimarynoofactiveacs] =ifNullCheck(cbResult.mprimarynoofactiveacs);
      mapCbCheckData[TablesColumnFile.mprimarynoofodaccs] =ifNullCheck(cbResult.mprimarynoofodaccs);
      mapCbCheckData[TablesColumnFile.msecondarycurrentbalance] =ifNullCheck(cbResult.msecondarycurrentbalance);
      mapCbCheckData[TablesColumnFile.msecondarynoofaccs] =ifNullCheck(cbResult.msecondarynoofaccs);
      mapCbCheckData[TablesColumnFile.msecondaryoverdueamount] =ifNullCheck(cbResult.msecondaryoverdueamount);
      mapCbCheckData[TablesColumnFile.msecondarynoofactiveaccs] =ifNullCheck(cbResult.msecondarynoofactiveaccs);
      mapCbCheckData[TablesColumnFile.msecondarynoofodacs] =ifNullCheck(cbResult.msecondarynoofodacs);
      mapCbCheckData[TablesColumnFile.msecondarysanctionedamt] =ifNullCheck(cbResult.msecondarysanctionedamt);*/



      /*mapCbCheckData[TablesColumnFile.mcreateddt] =ifDateNullCheck(cbResult.mcreateddt);*/
    }




    var mapDataCbResult = new Map() ;
    var dataCbLoanList= new List();
    if(cbLoanList.isNotEmpty){

      for(int loanList = 0 ;loanList<cbLoanList.length;loanList++){
        mapDataCbResult = new Map();
        mapDataCbResult[TablesColumnFile.mrefno] =	cbLoanList[loanList].mrefno;
        mapDataCbResult[TablesColumnFile.trefno] =	cbLoanList[loanList].trefno;
        mapDataCbResult[TablesColumnFile.trefsrno] =	cbLoanList[loanList].trefsrno;
        mapDataCbResult[TablesColumnFile.mrefsrno] =	cbLoanList[loanList].mrefsrno;
        mapDataCbResult[TablesColumnFile.maccounttype] = ifNullCheck(cbLoanList[loanList].maccounttype);
        mapDataCbResult[TablesColumnFile.mcurrentbalance] = cbLoanList[loanList].mcurrentbalance==null?0.0:cbLoanList[loanList].mcurrentbalance;
        mapDataCbResult[TablesColumnFile.mcustbankacnum] = ifNullCheck(cbLoanList[loanList].mcustbankacnum);
        mapDataCbResult[TablesColumnFile.mdatereported] = ifNullCheck(cbLoanList[loanList].mdatereported);
        mapDataCbResult[TablesColumnFile.mdisbursedamount] = cbLoanList[loanList].mdisbursedamount==null?0.0:cbLoanList[loanList].mdisbursedamount;
        mapDataCbResult[TablesColumnFile.mnameofmfi] = ifNullCheck(cbLoanList[loanList].mnameofmfi);
        mapDataCbResult[TablesColumnFile.mmfiid] = ifNullCheck(cbLoanList[loanList].mmfiid);

        if (cbLoanList[loanList].mnocimagestring != null && cbLoanList[loanList].mnocimagestring != "null"
            &&cbLoanList[loanList].mnocimagestring !=""){
  /*        File imageFile = new File(cbLoanList[loanList].mnocimagestring);
          final Directory extDir = await getApplicationDocumentsDirectory();
          var targetPath = extDir.absolute.path + "/temp.png";
          var imgFile = await compressAndGetFile(imageFile, targetPath,true);
          List<int> imageBytes = imgFile.readAsBytesSync();
          String base64Image = base64.encode(imageBytes);
*/
        mapDataCbResult["mnocimagestring"] = cbLoanList[loanList].mnocimagestring;
	  
//	  mapDataCbResult["mnocimagestring"] = base64Image;
        } else
          mapDataCbResult[TablesColumnFile.mnocimagestring] = "";
       /* mapDataCbResult[TablesColumnFile.mnocimagestring] = ifNullCheck(cbLoanList[loanList].mnocimagestring);*/
        mapDataCbResult[TablesColumnFile.moverdueamount] = cbLoanList[loanList].moverdueamount==null?0.0:cbLoanList[loanList].moverdueamount;
        mapDataCbResult[TablesColumnFile.mwriteoffamount] = cbLoanList[loanList].mwriteoffamount==null?0.0:cbLoanList[loanList].mwriteoffamount;
        mapDataCbResult[TablesColumnFile.magentusername] = ifNullCheck(cbLoanList[loanList].magentusername);
        mapDataCbResult["aadhaarno"] = "";
        dataCbLoanList.add(mapDataCbResult);

      }
    }

    mapData[TablesColumnFile.cbResultMasterDetails] = mapCbCheckData;

    mapData[TablesColumnFile.cbLoanDetails] =  dataCbLoanList;

    print(mapData[TablesColumnFile.cbResultMasterDetails]);

    prospectList.add(mapData);


  }

  /*Future<String> _toJsonCreditBereauResult(
      CbResultBean cbResultList) async {


    var mapCbCheckData = new Map();

      mapCbCheckData[TablesColumnFile.trefno] =cbResult.trefno==null?0:cbResult.trefno;
      mapCbCheckData[TablesColumnFile.mrefno] =cbResult.mrefno==null?0:cbResult;
      mapCbCheckData[TablesColumnFile.mcbcheckstatus] =ifNullCheck(cbResult.mcbcheckstatus);
      mapCbCheckData[TablesColumnFile.mdateofissue] =ifNullCheck(cbResult.mdateofissue);
      mapCbCheckData[TablesColumnFile.mdateofrequest] =ifNullCheck(cbResult.mdateofrequest);
      mapCbCheckData[TablesColumnFile.mpreparedfor] =ifNullCheck(cbResult.mpreparedfor);
      mapCbCheckData[TablesColumnFile.mprimarycurrentbal] =ifNullCheck(cbResult.mprimarycurrentbal);
      mapCbCheckData[TablesColumnFile.mprimarynoofaccounts] =ifNullCheck(cbResult.mprimarynoofaccounts);
      mapCbCheckData[TablesColumnFile.mprimarynoofactiveacs] =ifNullCheck(cbResult.mprimarynoofactiveacs);
      mapCbCheckData[TablesColumnFile.mprimarynoofodaccs] =ifNullCheck(cbResult.mprimarynoofodaccs);
      mapCbCheckData[TablesColumnFile.mreportid] = ifNullCheck(cbResult.mreportid);
      mapCbCheckData[TablesColumnFile.msecondarycurrentbalance] =ifNullCheck(cbResult.msecondarycurrentbalance);
      mapCbCheckData[TablesColumnFile.msecondarynoofaccs] =ifNullCheck(cbResult.msecondarynoofaccs);
      mapCbCheckData[TablesColumnFile.msecondarynoofactiveaccs] =ifNullCheck(cbResult.msecondarynoofactiveaccs);
      mapCbCheckData[TablesColumnFile.msecondarynoofodacs] =ifNullCheck(cbResult.msecondarynoofodacs);
      mapCbCheckData[TablesColumnFile.msecondarysanctionedamt] =ifNullCheck(cbResult.msecondarysanctionedamt);
      mapCbCheckData[TablesColumnFile.mcreateddt] =ifDateNullCheck(cbResult.mcreateddt);

    String json = JSON.encode(mapCbCheckData);
    return json;

  }*/


  /* Future<String> _toJsonCreditBereauLoan(
      CbResultBean cbLoanList) async {
     var mapDataCbResult = new Map();
    mapDataCbResult[TablesColumnFile.mrefno] =	cbLoanList.mrefno;
    mapDataCbResult[TablesColumnFile.trefno] =	cbLoanList.trefno;
    mapDataCbResult[TablesColumnFile.trefsrno] =	cbLoanList.trefsrno;
    mapDataCbResult[TablesColumnFile.mrefsrno] =	cbLoanList.mrefsrno;
    mapDataCbResult[TablesColumnFile.maccounttype] = ifNullCheck(cbLoanList.maccounttype);
    mapDataCbResult[TablesColumnFile.mcurrentbalance] = ifNullCheck(cbLoanList.mcurrentbalance);
    mapDataCbResult[TablesColumnFile.mcustbankacnum] = ifNullCheck(cbLoanList.mcustbankacnum);
    mapDataCbResult[TablesColumnFile.mdatereported] = ifNullCheck(cbLoanList.mdatereported);
    mapDataCbResult[TablesColumnFile.mdisbursedamount] = ifNullCheck(cbLoanList.mdisbursedamount);
    mapDataCbResult[TablesColumnFile.mnameofmfi] = ifNullCheck(cbLoanList.mnameofmfi);
    mapDataCbResult[TablesColumnFile.mnocimagestring] = ifNullCheck(cbLoanList.mnocimagestring);
    mapDataCbResult[TablesColumnFile.moverdueamount] = ifNullCheck(cbLoanList.moverdueamount);
    mapDataCbResult[TablesColumnFile.mwriteoffamount] = ifNullCheck(cbLoanList.mwriteoffamount);
    mapDataCbResult[TablesColumnFile.magentusername] = ifNullCheck(cbLoanList.magentusername);
    String json = JSON.encode(mapDataCbResult);
    return json;
  }

*/





  Future<File> compressAndGetFile(File file, String targetPath, bool fromCreator) async {
    print("From creqatorr     $fromCreator");
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: fromCreator?50:50,
      rotate: 360,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  String ifNullCheck(String value){
    if(value==null || value == 'null'){
      value = "";
    }
    return value;
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



Future<Null> castMiddlewareListToObj(prspctSrvrRslt) async {

}







