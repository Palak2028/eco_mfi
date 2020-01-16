<<<<<<< .mine
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCPVBusinessRecordBean.dart';
=======
import 'package:eco_mfi/pages/workflow/Guarantor/GuarantorDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCPVBusinessRecordBean.dart';
>>>>>>> .r1143
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCashFlowAnalysisBean.dart';
<<<<<<< .mine
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/DeviationFormBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/SocialAndEnvironmentalBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/TradeAndNeighbourRefCheckBean.dart';
=======
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/DeviationFormBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/SocialAndEnvironmentalBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/TradeAndNeighbourRefCheckBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanImageBean.dart';
>>>>>>> .r1143
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/Kyc/beans/KycMasterBean.dart';


class CustomerLoanServices {
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();
  String _serviceUrl;
  bool isForSingleLoan = false;
  int mrefnoGeneratedForSingleLoan =0;
  DateTime lastSyncedToServerDaeTime;
  CustomerLoanCheckBean custLoanChkBean = new CustomerLoanCheckBean();

  Future<Null> syncLoan(List listValue,String userCode) async {
   try {

      String bodyValue  = await NetworkUtil.callPostService(listValue.toString(),Constant.apiURL.toString()+_serviceUrl.toString(),_headers);
      print("url "+Constant.apiURL.toString()+_serviceUrl.toString());
      if(bodyValue == "404" ){
        return null;
      } else {

        print("Returned Json is ${bodyValue}");
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<CustomerLoanDetailsBean> obj = parsed
            .map<CustomerLoanDetailsBean>(
                (json) => CustomerLoanDetailsBean.fromMapMiddleware(json))
            .toList();

        for (int cust = 0; cust < obj.length; cust++) {

          if(isForSingleLoan){
            mrefnoGeneratedForSingleLoan = obj[cust].mrefno;
            custLoanChkBean.trefno = obj[cust].trefno;
            custLoanChkBean.mrefno = obj[cust].mrefno;
            custLoanChkBean.mcustmrefno = obj[cust].mcustmrefno;
            custLoanChkBean.mcustno = obj[cust].mcustno;
            custLoanChkBean.merrormessage = obj[cust].merrormessage;
            custLoanChkBean.mCreatedBy = obj[cust].mcreatedby;
            custLoanChkBean.mlastUpdatedBy = obj[cust].mlastupdateby;
            custLoanChkBean.mleadStatus = obj[cust].mleadstatus;
            custLoanChkBean.mleadsid = obj[cust].mleadsid;
            custLoanChkBean.mprdacctid = "0";
                if(obj[cust].mprdacctid!=null&&obj[cust].mprdacctid.toString().toLowerCase().trim()!=null){
                  custLoanChkBean.mprdacctid = obj[cust].mprdacctid.toString().toLowerCase().trim();
                }


            print("Product account i d is ${custLoanChkBean.mprdacctid}");

          }



          String productAccId  = custLoanChkBean.mprdacctid;
          await AppDatabase.get()
              .selectCustomerLoanOnTrefAndMref(obj[cust].trefno, obj[cust].mcreatedby,obj[cust].mrefno)
              .then((CustomerLoanDetailsBean customerLoanDetailsBean) async {


                print("xxxxxxxxxxxxFetched List of matching tref no ${customerLoanDetailsBean.trefno}");
                print("xxxxxxxxxxxxxxxxxxxFetched List of matching mrefno no ${customerLoanDetailsBean.mrefno}");
            if ((obj[cust]!=null && obj[cust].mrefno != null )&& (customerLoanDetailsBean.mrefno==null || customerLoanDetailsBean.mrefno == 0)) {
              String updateCustQuery ="";

              print("xxxxxxxxxxxxxxinside if");
              print("xxxxxxxxxxxxxxxxxxx is for single Loan ${isForSingleLoan}");
              if(isForSingleLoan){
                print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx error message${obj[cust].merrormessage}");
                print("lastSyncedToServerDaeTime${lastSyncedToServerDaeTime}");
                updateCustQuery =lastSyncedToServerDaeTime!=null&&lastSyncedToServerDaeTime!='null'?
                "${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now()}', ${TablesColumnFile.merrormessage}  = '${obj[cust].merrormessage}'  ,"
                    " ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}',${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' ,"
                    "${TablesColumnFile.mlastupdatedt} = '${lastSyncedToServerDaeTime.subtract(Duration(minutes: 1))}' , "
                    "${TablesColumnFile.mrefno} = ${obj[cust]
                    .mrefno}  , ${TablesColumnFile.mprdacctid} = '${custLoanChkBean.mprdacctid}', "
                    " ${TablesColumnFile.missynctocoresys} =  ${obj[cust].missynctocoresys} "
                    " WHERE ${TablesColumnFile.trefno} = ${obj[cust]
                    .trefno} AND ${TablesColumnFile.mcreatedby} = '${obj[cust]
                    .mcreatedby.trim()}' AND ${TablesColumnFile.mrefno} = 0 ":null;
              }else {
                updateCustQuery =
                "${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now()}' , ${TablesColumnFile.mrefno} = ${obj[cust]
                    .mrefno},${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}'  WHERE ${TablesColumnFile.trefno} = ${obj[cust]
                    .trefno} AND ${TablesColumnFile.mcreatedby} = '${obj[cust]
                    .mcreatedby.trim()}'  AND ${TablesColumnFile.mrefno} = 0   ";
              }


              print("update Query is ${updateCustQuery}");
              if(updateCustQuery !=null) {
                await AppDatabase.get().updateCustomerLoanMaster(
                    updateCustQuery);
              }

              updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.loanmrefno} = ${obj[cust]
                  .mrefno},${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' "
                  " WHERE ${TablesColumnFile.loantrefno} = ${obj[cust]
                  .trefno} AND  ${TablesColumnFile.mcreatedby} = '${obj[cust]
                  .mcreatedby.trim()}'  AND ${TablesColumnFile.loanmrefno} = 0 ";
              // if (updateCustQuery != null) {
              await AppDatabase.get().updateCG1WhileLoanSyncMaster(updateCustQuery);

              await AppDatabase.get().updateCG2WhileLoanSyncMaster(updateCustQuery);



              updateCustQuery =
              " ${TablesColumnFile.mloanmrefno} = ${obj[cust].mrefno}, "
                  " ${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,"
                  "  ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' "
                  " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust].trefno} "
                  " AND ${TablesColumnFile.mloanmrefno} = 0 ";


              print("Update Query for cash flow ${updateCustQuery} ");


              await AppDatabase.get().updateCashFlowMaster(updateCustQuery);

              // Update Deviation Form
              updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                  .mrefno},${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}', "
                  "  ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' "
                  " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mloanmrefno} = 0 ";
              print("Update Query for deviation ${updateCustQuery} ");
              await AppDatabase.get().updateDeviationMaster(updateCustQuery);

              // Update CPV
              updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                  .mrefno},${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}', "
                  "  ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' "
                  " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mloanmrefno} = 0 ";
              print("Update Query for deviation ${updateCustQuery} ");
              await AppDatabase.get().updateCPVBusinessRecord(updateCustQuery);

              // Update Social and Env
              updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                  .mrefno},${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}', "
                  "  ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' "
                  " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mloanmrefno} = 0 ";
              print("Update Query for deviation ${updateCustQuery} ");
              await AppDatabase.get().updateSocialEnvMaster(updateCustQuery);

              // Update Trade and Neigh Check
              updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                  .mrefno},${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}', "
                  "  ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' "
                  " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mloanmrefno} = 0 ";
              print("Update Query for deviation ${updateCustQuery} ");
              await AppDatabase.get().updateTradeNeighbourRefMaster(updateCustQuery);

              // Update Guarantor Detail
              updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                  .mrefno},${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}', "
                  "  ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' "
                  " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mloanmrefno} = 0 ";
              print("Update Query for cash flow ${updateCustQuery} ");
              await AppDatabase.get().updateGuarantorMaster(updateCustQuery);
	      
	      
	                    updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                  .mrefno},${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' "
                  " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mloanmrefno} = 0 ";


              print("Update Query for cash flow ${updateCustQuery} ");


              await AppDatabase.get().updateCustomerLoanImageQuery(updateCustQuery);
	      
	      
	      
	      
	                        updateCustQuery =
                  "${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' ,"
                  "${TablesColumnFile.mlastupdatedt} = '${DateTime
                      .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                      .mrefno},${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                      .trefno}  AND ${TablesColumnFile.mloanmrefno} = 0 ";

              // Update Deviation Form
              updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                  .mrefno},${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' "
                  " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mloanmrefno} = 0 ";
              print("Update Query for deviation ${updateCustQuery} ");
              await AppDatabase.get().updateDeviationMaster(updateCustQuery);
              // Update CPV
              updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                  .mrefno},${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' "
                  " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mloanmrefno} = 0 ";
              print("Update Query for deviation ${updateCustQuery} ");
              await AppDatabase.get().updateCPVBusinessRecord(updateCustQuery);
              // Update Social and Env
              updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                  .mrefno},${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' "
                  " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mloanmrefno} = 0 ";
              print("Update Query for deviation ${updateCustQuery} ");
              await AppDatabase.get().updateSocialEnvMaster(updateCustQuery);
              // Update Trade and Neigh Check
              updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                  .mrefno},${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' "
                  " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mloanmrefno} = 0 ";
              print("Update Query for deviation ${updateCustQuery} ");
              await AppDatabase.get().updateTradeNeighbourRefMaster(updateCustQuery);

                  await AppDatabase.get().updateKYC(updateCustQuery);

	      
	      
	      
	      
	      
	      
	      


            }else{
              String updateCustQuery ="";
              if(isForSingleLoan){

                print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx error message${obj[cust].merrormessage}");
                updateCustQuery =lastSyncedToServerDaeTime!=null&&lastSyncedToServerDaeTime!='null'?
                "${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now()}' , ${TablesColumnFile.merrormessage}  = '${obj[cust].merrormessage}' "
                    ", ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}',${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' ,${TablesColumnFile.mlastupdatedt} = '${lastSyncedToServerDaeTime.subtract(Duration(minutes: 1))}' "
                    " ,  ${TablesColumnFile.mprdacctid} = '${custLoanChkBean.mprdacctid}' , "
                    "  ${TablesColumnFile.missynctocoresys}  =  ${obj[cust].missynctocoresys} "
                    "WHERE ${TablesColumnFile.mrefno} = ${obj[cust]
                    .mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust]
                    .trefno}":null;
              }else {
                updateCustQuery =
                    "${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now()}' ,${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}'  WHERE ${TablesColumnFile.mrefno} = ${obj[cust]
                    .mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust]
                    .trefno}";
              }
               if (updateCustQuery != null) {
              await AppDatabase.get().updateCustomerLoanMaster(updateCustQuery);
               }

              updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}',${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}'  WHERE ${TablesColumnFile.loanmrefno} = ${obj[cust]
                  .mrefno} AND ${TablesColumnFile.loantrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mcreatedby} = '${userCode}'";
              // if (updateCustQuery != null) {
              await AppDatabase.get().updateCG1WhileLoanSyncMaster(updateCustQuery);

              updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' ,${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' WHERE ${TablesColumnFile.loanmrefno} = ${obj[cust]
                  .mrefno} AND ${TablesColumnFile.loantrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mcreatedby} = '${userCode}'";
              // if (updateCustQuery != null) {
              await AppDatabase.get().updateCG2WhileLoanSyncMaster(updateCustQuery);


              updateCustQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}',${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}'  WHERE ${TablesColumnFile.loanmrefno} = ${obj[cust]
                  .mrefno} AND ${TablesColumnFile.loantrefno} = ${obj[cust]
                  .trefno} AND ${TablesColumnFile.mcreatedby} = '${userCode}'";
              // if (updateCustQuery != null) {
              await AppDatabase.get().updateGRTWhileLoanSyncMaster(updateCustQuery);





              await AppDatabase.get().selectCashFlowonLoanTrefLoanmerefno(obj[cust].trefno,obj[cust].mrefno,true).then((

                  CustomerLoanCashFlowAnalysisBean cashFlowbean) async {

                if(cashFlowbean!=null&&cashFlowbean.mloanmrefno==0){

                  updateCustQuery =
                  "  ${TablesColumnFile.mloanmrefno} = ${obj[cust].mrefno}, "
                      "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,"
                      "  ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                      .trefno}   AND ${TablesColumnFile.mloanmrefno} =  0 ";


                  await AppDatabase.get().updateCashFlowMaster(updateCustQuery);

                }

                else if(cashFlowbean!=null){

                  updateCustQuery = " ${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,"
                      "  ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                      .trefno}   AND ${TablesColumnFile.mloanmrefno} = ${cashFlowbean.mloanmrefno} ";


                  await AppDatabase.get().updateCashFlowMaster(updateCustQuery);
                }



              });

            // Update Deviation Form
              await AppDatabase.get().selectDeviationFormTrefLoanmerefno(obj[cust].trefno,obj[cust].mrefno,true).then((DeviationFormBean bean) async {

                if(bean!=null&&bean.mloanmrefno==0){

                  updateCustQuery =
                  "${TablesColumnFile.mlastupdatedt} = '${DateTime
                      .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                      .mrefno},${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}', "
                      "  ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
<<<<<<< .mine
                      .trefno} AND  ${TablesColumnFile.mcreatedby} = '${obj[cust]
                      .mcreatedby.trim()}'  AND ${TablesColumnFile.mloanmrefno} =  0 ";
=======
                      .trefno}  AND ${TablesColumnFile.mloanmrefno} =  0 ";
>>>>>>> .r1143

                  await AppDatabase.get().updateDeviationMaster(updateCustQuery);
                }


                else if(bean!=null){

                  updateCustQuery = " ${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,"
                      "  ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                      .trefno}   AND ${TablesColumnFile.mloanmrefno} = ${bean.mloanmrefno} ";


                  await AppDatabase.get().updateDeviationMaster(updateCustQuery);
                }



              });

<<<<<<< .mine
            // Update Deviation Form
              await AppDatabase.get().selectDeviationFormTrefLoanmerefno(obj[cust].trefno,obj[cust].mrefno).then((DeviationFormBean bean) async {
=======
              // Update Contact Point Verification
              await AppDatabase.get().selectCPVTrefLoanmerefno(obj[cust].trefno,obj[cust].mrefno,true).then((CustomerLoanCPVBusinessRecordBean bean) async {
>>>>>>> .r1143

<<<<<<< .mine
                if(bean!=null&&bean.mloanmrefno==0){
                  updateCustQuery =
                  "${TablesColumnFile.mlastupdatedt} = '${DateTime
                      .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                      .mrefno},${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                      .trefno} AND  ${TablesColumnFile.mcreatedby} = '${obj[cust]
                      .mcreatedby.trim()}'  AND ${TablesColumnFile.mloanmrefno} 0 ";
                  await AppDatabase.get().updateDeviationMaster(updateCustQuery);
                }
              });
              // Update Contact Point Verification
              await AppDatabase.get().selectCPVTrefLoanmerefno(obj[cust].trefno,obj[cust].mrefno).then((CustomerLoanCPVBusinessRecordBean bean) async {
                if(bean!=null&&bean.mloanmrefno==0){
                  updateCustQuery =
                  "${TablesColumnFile.mlastupdatedt} = '${DateTime
                      .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                      .mrefno},${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                      .trefno} AND  ${TablesColumnFile.mcreatedby} = '${obj[cust]
                      .mcreatedby.trim()}'  AND ${TablesColumnFile.mloanmrefno} 0 ";
                  await AppDatabase.get().updateCPVBusinessRecord(updateCustQuery);
                }
              });
              // Update Social And Env
              await AppDatabase.get().selectSocialAndEnvTrefLoanmerefno(obj[cust].trefno,obj[cust].mrefno).then((SocialAndEnvironmentalBean bean) async {
                if(bean!=null&&bean.mloanmrefno==0){
                  updateCustQuery =
                  "${TablesColumnFile.mlastupdatedt} = '${DateTime
                      .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                      .mrefno},${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                      .trefno} AND  ${TablesColumnFile.mcreatedby} = '${obj[cust]
                      .mcreatedby.trim()}'  AND ${TablesColumnFile.mloanmrefno} 0 ";
                  await AppDatabase.get().updateSocialEnvMaster(updateCustQuery);
                }
              });
              // Update Trade and Neigh Check
              await AppDatabase.get().selectTradeAndNeighTrefLoanmerefno(obj[cust].trefno,obj[cust].mrefno).then((TradeAndNeighbourRefCheckBean bean) async {
                if(bean!=null&&bean.mloanmrefno==0){
                  updateCustQuery =
                  "${TablesColumnFile.mlastupdatedt} = '${DateTime
                      .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                      .mrefno},${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                      .trefno} AND  ${TablesColumnFile.mcreatedby} = '${obj[cust]
                      .mcreatedby.trim()}'  AND ${TablesColumnFile.mloanmrefno} 0 ";
                  await AppDatabase.get().updateTradeNeighbourRefMaster(updateCustQuery);
                }
              });
=======
                if(bean!=null&&bean.mloanmrefno==0){
>>>>>>> .r1143

                  updateCustQuery =
                  "${TablesColumnFile.mlastupdatedt} = '${DateTime
                      .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                      .mrefno},${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}', "
                      "  ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                      .trefno}  AND ${TablesColumnFile.mloanmrefno} = 0 ";

                  await AppDatabase.get().updateCPVBusinessRecord(updateCustQuery);
                }

                else if(bean!=null){

                  updateCustQuery = " ${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,"
                      "  ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                      .trefno}   AND ${TablesColumnFile.mloanmrefno} = ${bean.mloanmrefno} ";


                  await AppDatabase.get().updateCPVBusinessRecord(updateCustQuery);
                }
              });

              // Update Social And Env
              await AppDatabase.get().selectSocialAndEnvTrefLoanmerefno(obj[cust].trefno,obj[cust].mrefno,true).then((SocialAndEnvironmentalBean bean) async {

                if(bean!=null&&bean.mloanmrefno==0){

                  updateCustQuery =
                  "${TablesColumnFile.mlastupdatedt} = '${DateTime
                      .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                      .mrefno},${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}', "
                      "  ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                      .trefno}  AND ${TablesColumnFile.mloanmrefno} = 0 ";

                  await AppDatabase.get().updateSocialEnvMaster(updateCustQuery);
                }

                else if(bean!=null){

                  updateCustQuery = " ${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,"
                      "  ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                      .trefno}   AND ${TablesColumnFile.mloanmrefno} = ${bean.mloanmrefno} ";


                  await AppDatabase.get().updateSocialEnvMaster(updateCustQuery);
                }
              });

              // Update Trade and Neigh Check
              await AppDatabase.get().selectTradeAndNeighTrefLoanmerefno(obj[cust].trefno,obj[cust].mrefno,true).then((TradeAndNeighbourRefCheckBean bean) async {

                if(bean!=null&&bean.mloanmrefno==0){

                  updateCustQuery =
                  "${TablesColumnFile.mlastupdatedt} = '${DateTime
                      .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                      .mrefno},${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}', "
                      "  ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                      .trefno}  AND ${TablesColumnFile.mloanmrefno} = 0  ";

                  await AppDatabase.get().updateTradeNeighbourRefMaster(updateCustQuery);
                }
                else if(bean!=null){

                  updateCustQuery = " ${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,"
                      "  ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                      .trefno}   AND ${TablesColumnFile.mloanmrefno} = ${bean.mloanmrefno} ";


                  await AppDatabase.get().updateTradeNeighbourRefMaster(updateCustQuery);
                }
              });

              // Update Guarantor Detail
              await AppDatabase.get().selectGuarantorTrefLoanmerefno(obj[cust].trefno,obj[cust].mrefno,true).then((
                  GuarantorDetailsBean bean) async {

                if(bean!=null&&bean.mloanmrefno==0){
                  updateCustQuery =
                  "${TablesColumnFile.mlastupdatedt} = '${DateTime
                      .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                      .mrefno},${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}', "
                      "  ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                      .trefno}   AND ${TablesColumnFile.mloanmrefno} =  0 ";

                  await AppDatabase.get().updateGuarantorMaster(updateCustQuery);
                }
                else if(bean!=null){

                  updateCustQuery = " ${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,"
                      "  ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                      .trefno}   AND ${TablesColumnFile.mloanmrefno} = ${bean.mloanmrefno} ";


                  await AppDatabase.get().updateGuarantorMaster(updateCustQuery);
                }
              });
	      
	      
              await AppDatabase.get().selectCustomerLoanImageOnmreftref(obj[cust].trefno,obj[cust].mrefno).then((

                  CustomerLoanImageBean customerLoanImageBean) async {

                if(customerLoanImageBean!=null&&customerLoanImageBean.mloanmrefno==0){

                  updateCustQuery =
                  "${TablesColumnFile.mlastupdatedt} = '${DateTime
                      .now()}' , ${TablesColumnFile.mloanmrefno} = ${obj[cust]
                      .mrefno},${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                      .trefno}   AND ${TablesColumnFile.mloanmrefno} =  0 ";


                  await AppDatabase.get().updateCustomerLoanImageQuery(updateCustQuery);

                }



              });




              await AppDatabase.get().selectKycMasterTrefLoanmerefno(obj[cust].trefno,obj[cust].mrefno).then((
                  KycMasterBean kycBean) async {
                if(kycBean!=null&&kycBean.mloanmrefno==0){
                  print("updatecustquery is xxxxxxxxxxxxxxxxxxxxxxxx $updateCustQuery");
                  updateCustQuery =
                  "${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' ,"
                      "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,"
                      "${TablesColumnFile.mloanmrefno} = ${obj[cust].mrefno},"
                      "${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                      .trefno}  AND ${TablesColumnFile.mloanmrefno} = 0 ";


                  await AppDatabase.get().updateKYC(updateCustQuery);

                }

                else if(kycBean!=null){

                  updateCustQuery = " ${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,"
                      "  ${TablesColumnFile.mleadsid} = '${obj[cust].mleadsid}' "
                      " WHERE ${TablesColumnFile.mloantrefno} = ${obj[cust]
                      .trefno}   AND ${TablesColumnFile.mloanmrefno} = ${kycBean.mloanmrefno} ";


                  await AppDatabase.get().updateKYC(updateCustQuery);
                }
              });










            }



        });
	
	


        }





        //updating lastsynced date time with now
       await  AppDatabase.get().updateStaticTablesLastSyncedMaster(6);
      }

   } catch (e) {
      print('Server Exception!!!');
      print(e);
    }

    print("After ending it ");
  }


  Future<Null> getAndSync(String userCode) async {
    List _customerLoanDetailList = new List();
  try {
     await AppDatabase.get()
         .selectStaticTablesLastSyncedMaster(6,false)
         .then((onValue) async {

      await AppDatabase.get().getCustomerLoanDetailsNotSynced(onValue).then((loanList) async{
        for (int i = 0; i < loanList.length; i++) {
          await _toJsonCustomerLoan(loanList[i]).then((onValue) async {
            _customerLoanDetailList.add(onValue.toString());
          });
        }
        _serviceUrl = "customerLoanData/add/";
        await syncLoan(_customerLoanDetailList,userCode);
      });
     });
      }

   catch (e) {
      print('Server Exception!!!');

    }
  }



  Future<String> _toJsonCustomerLoan( CustomerLoanDetailsBean   customerLoan) async {
    var map = new Map();
    map[TablesColumnFile.trefno]  = customerLoan.trefno!=null?customerLoan.trefno:0;
    map[TablesColumnFile.mrefno]  = customerLoan.mrefno!=null? customerLoan.mrefno:0;
    map[TablesColumnFile.mleadsid]  =  ifNullCheck(customerLoan.mleadsid);
    map[TablesColumnFile.mappldloanamt]  =  customerLoan.mappldloanamt!=null?customerLoan.mappldloanamt:0.0;
    map[TablesColumnFile.mcustno]  = customerLoan.mcustno!=null?customerLoan.mcustno:0;
    map[TablesColumnFile.mcusttrefno]  = customerLoan.mcusttrefno!=null?customerLoan.mcusttrefno:0;
    map[TablesColumnFile.mcustmrefno]  = customerLoan.mcustmrefno!=null?customerLoan.mcustmrefno:0;
    map[TablesColumnFile.mcustcategory]  = customerLoan.mcustcategory!=null?customerLoan.mcustcategory:0;
    map[TablesColumnFile.mloanamtdisbd]  = customerLoan.mloanamtdisbd!=null?customerLoan.mloanamtdisbd:0;
    map[TablesColumnFile.mloandisbdt]  = customerLoan.mloandisbdt!=null?customerLoan.mloandisbdt.toIso8601String():null;
    map[TablesColumnFile.mleadstatus]  = customerLoan.mloanamtdisbd!=null?customerLoan.mleadstatus:0;
    map[TablesColumnFile.mexpdt]  = customerLoan.mexpdt!=null?customerLoan.mexpdt.toIso8601String():null;

    map[TablesColumnFile.minstamt]  = customerLoan.minstamt!=null?customerLoan.minstamt:0.0;
    map[TablesColumnFile.minststrtdt]  = customerLoan.minststrtdt!=null?customerLoan.minststrtdt.toIso8601String():null;
    map[TablesColumnFile.minterestamount]  = customerLoan.minterestamount!=null?customerLoan.minterestamount:0.0;
    map[TablesColumnFile.mrepaymentmode]  =customerLoan.mrepaymentmode!=null? customerLoan.mrepaymentmode:0;
    map[TablesColumnFile.mmodeofdisb]  = customerLoan.mmodeofdisb!=null?customerLoan.mmodeofdisb:0;
    map[TablesColumnFile.mperiod]  = customerLoan.mperiod!=null?customerLoan.mperiod:0;
    map[TablesColumnFile.mprdcd]  = ifNullCheck(customerLoan.mprdcd);
    map[TablesColumnFile.mpurposeofLoan]  =customerLoan.mpurposeofLoan!=null? customerLoan.mpurposeofLoan:0;
    map[TablesColumnFile.msubpurposeofloan]  = customerLoan.msubpurposeofloan!=null?customerLoan.msubpurposeofloan:0;
    map[TablesColumnFile.mintrate]  = customerLoan.mintrate!=null?customerLoan.mintrate:0;
    map[TablesColumnFile.mroutefrom]  = ifNullCheck(customerLoan.mroutefrom);
    map[TablesColumnFile.mrouteto]  = ifNullCheck(customerLoan.mrouteto);
    map[TablesColumnFile.mprdacctid]  = ifNullCheck(customerLoan.mprdacctid);
    map[TablesColumnFile.mloancycle]  = customerLoan.mloancycle!=null?customerLoan.mloancycle:0;
    map[TablesColumnFile.mfrequency]  = ifNullCheck(customerLoan.mfrequency);
    map[TablesColumnFile.mcreateddt]  = customerLoan.mcreateddt!=null?customerLoan.mcreateddt.toIso8601String():null;
    map[TablesColumnFile.mcreatedby]  = ifNullCheck(customerLoan.mcreatedby);
    map[TablesColumnFile.mlastupdatedt]  = DateTime.now().toIso8601String();
    map[TablesColumnFile.mlastupdateby]  = ifNullCheck(customerLoan.mlastupdateby);
    map[TablesColumnFile.mgeolocation]  = ifNullCheck(customerLoan.mgeolocation);
    map[TablesColumnFile.mgeolatd]  =ifNullCheck(customerLoan.mgeolatd);
    map[TablesColumnFile.mgeologd]  = ifNullCheck(customerLoan.mgeologd);
    map[TablesColumnFile.mappliedasind]  = ifNullCheck(customerLoan.mappliedasind);
    map[TablesColumnFile.missynctocoresys]  = customerLoan.missynctocoresys!=null?customerLoan.missynctocoresys:0;
    map[TablesColumnFile.mlastsynsdate]  = DateTime.now().toIso8601String();
    map[TablesColumnFile.mcheckresaddchng] = customerLoan.mcheckresaddchng!=null?customerLoan.mcheckresaddchng:0;
    map[TablesColumnFile.mspouserelname] = ifNullCheck(customerLoan.mspouserelname);
    map[TablesColumnFile.mcheckspouserepay] = customerLoan.mcheckspouserepay!=null?customerLoan.mcheckspouserepay:0;
    map[TablesColumnFile.mcheckbiometric] = customerLoan.mcheckbiometric!=null?customerLoan.mcheckbiometric:0;
    map[TablesColumnFile.monileadstatus] = 0;
    map[TablesColumnFile.mlbrcode] = customerLoan.mlbrcode!=null?customerLoan.mlbrcode:0;

    String json = JSON.encode(map);
    print("Mapping Data Complete");
    return json;
  }

  String ifNullCheck(String value) {
    if (value == null || value == 'null' ) {
      value = "";
    }
    return value.trim();
  }


  Future<CustomerLoanCheckBean> SyncSingleLoanToMiddleware(CustomerLoanDetailsBean item,DateTime lastBulkSysTime,String userCode) async {
    try {
      List _customerLoanDetailList = new List();

      print("lastBulkSysTime is ${lastBulkSysTime}");
      if(lastBulkSysTime==null||lastBulkSysTime.toString().trim()=='null'||
          lastBulkSysTime.toString().trim()==""){
        lastSyncedToServerDaeTime =DateTime.now();
      }
      else{
        lastSyncedToServerDaeTime = lastBulkSysTime;
      }










          await _toJsonCustomerLoan(item).then((onValue) async {

            for(var items in onValue.toString().split(",")){
              print("LoanSending Json is ${items}");
            }
            await _customerLoanDetailList.add(onValue.toString());
          });

        _serviceUrl = "customerLoanData/add/";


      isForSingleLoan = true;
      await syncLoan(_customerLoanDetailList,userCode);
      return custLoanChkBean;
    }catch(_){
      return null;
    }
//after call needs to update mref in tab in all tables and update lastsynced in lastsynced date time table
  }

}
class  CustomerLoanCheckBean{

  int mcustno;
  int mcustmrefno;
  String mprdacctid;
  String merrormessage;
  int mrefno;
  int trefno;
  String mleadsid;
  String mCreatedBy;
  String mlastUpdatedBy;
  int mleadStatus;




  CustomerLoanCheckBean({this.mcustno, this.mcustmrefno, this.mprdacctid,
      this.merrormessage, this.mrefno, this.trefno,this.mleadsid,this.mCreatedBy,this.mlastUpdatedBy,this.mleadStatus
  });

  factory CustomerLoanCheckBean.fromMap(Map<String, dynamic> map,bool isTrue) {
    return CustomerLoanCheckBean(
        mcustmrefno: map[TablesColumnFile.mcustmrefno] as int,
        mprdacctid: map[TablesColumnFile.mprdacctid] as String,
        merrormessage: map[TablesColumnFile.merrormessage] as String,
        mrefno:map[TablesColumnFile.mrefno] as int,
        mcustno:map[TablesColumnFile.mcustno] as int,
        trefno: map[TablesColumnFile.trefno] as int,
      mleadsid: map[TablesColumnFile.mleadsid] as String,
      mCreatedBy:  map[TablesColumnFile.mcreatedby] as String,
      mlastUpdatedBy: map[TablesColumnFile.mlastupdateby] as String,
        mleadStatus: map[TablesColumnFile.mleadstatus] as int,
    );}


}
