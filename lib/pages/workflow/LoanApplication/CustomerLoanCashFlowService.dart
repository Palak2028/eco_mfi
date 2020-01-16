import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCashFlowAnalysisBean.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';


class CustomerLoanCashFlowService {
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();
  String _serviceUrl;
  List CashFlowList = List();

  Future<Null> syncLoanCashFlow(String jsonList) async {
    //try {
      String bodyValue = await NetworkUtil.callPostService(jsonList,
          Constant.apiURL.toString() + _serviceUrl.toString(), _headers);
      print("url " + Constant.apiURL.toString() + _serviceUrl.toString());
      if (bodyValue == '404') {
        return null;
      } else {
        print("returned Value ${bodyValue}");
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<CustomerLoanCashFlowAnalysisBean> obj = parsed
            .map<CustomerLoanCashFlowAnalysisBean>((json) => CustomerLoanCashFlowAnalysisBean.fromMap(json))
            .toList();

        for (int cashFlowCount = 0; cashFlowCount < obj.length; cashFlowCount++) {
          await AppDatabase.get()
              .selectCashFlowonTrefAndMref(obj[cashFlowCount].trefno, obj[cashFlowCount].mcreatedby,obj[cashFlowCount].mrefno)
              .then((CustomerLoanCashFlowAnalysisBean cashFlowBean) async {
            bool isSyncingFirstTime = false;
            String updateCashFlowQuery = null;
            // try {

            if ((obj[cashFlowCount] != null &&
                obj[cashFlowCount].mrefno != null &&
                cashFlowBean != null )&&(
                cashFlowBean.mrefno == null ||
                cashFlowBean.mrefno == 0)  ) {
              isSyncingFirstTime = true;
              updateCashFlowQuery =
              "${TablesColumnFile.mlastsynsdate} = '${DateTime
                  .now()}' , ${TablesColumnFile.mrefno} = ${obj[cashFlowCount]
                  .mrefno} , "
                  " ${TablesColumnFile.missynctocoresys} = 1 "
                  " WHERE ${TablesColumnFile.trefno} = ${obj[cashFlowCount]
                  .trefno} AND  ${TablesColumnFile.mrefno} = 0 ";
            } else {
              updateCashFlowQuery =
              "${TablesColumnFile.mlastsynsdate} = '${DateTime
                  .now()}' ,"
                  " ${TablesColumnFile.missynctocoresys} = 1 "
                  " WHERE ${TablesColumnFile.mrefno} = ${obj[cashFlowCount]
                  .mrefno} AND ${TablesColumnFile.trefno} = ${obj[cashFlowCount]
                  .trefno}";
            }

            print("Update Query is ${updateCashFlowQuery}");
            if (updateCashFlowQuery != null) {
              await AppDatabase.get()
                  .updateCustomerLoanCashFlowMasterMrefno(updateCashFlowQuery);
            }


            /*} catch (_) {}*/
          });
        }

        if(obj!=null&&obj.length>0){
          AppDatabase.get().updateStaticTablesLastSyncedMaster(21);
        }
      }


    /*} catch (e) {
      print('Server Exception!!!');
      print(e);
    }*/
  }


  Future<Null> getAndSync() async {
    List<CustomerLoanCashFlowAnalysisBean> cashFlowList = new List<CustomerLoanCashFlowAnalysisBean>();

   // try {
      await AppDatabase.get()
          .selectStaticTablesLastSyncedMaster(21, false)
          .then((returnedCashFlowDateTime) async {
        await AppDatabase.get()
            .selectCashFlowListNotSynced(returnedCashFlowDateTime)
            .then((List<CustomerLoanCashFlowAnalysisBean> returnedCashFlowList) async {

              print("returned bean is ${returnedCashFlowList}");
          for (var items in returnedCashFlowList) {

            cashFlowList.add(items);
            String sendingJson  = await _toListJson(items);
          }


          String json = JSON.encode(CashFlowList);
          for (var items in json.toString().split(",")) {
            print("Json values" + items.toString());
          }
          _serviceUrl = "CustomerLoanCashFlow/add/";
          await syncLoanCashFlow(json);
        });
      });
      //AppDatabase.get().updateStaticTablesLastSyncedMaster(21);
    //}
    /*catch (e) {
      print('Server Exception!!!');
    }*/
  }
  Future<Null> getCashForSingleLoan(CustomerLoanCashFlowAnalysisBean loanCashFlowBean) async {

    List<CustomerLoanCashFlowAnalysisBean> cashFlowList = new List<CustomerLoanCashFlowAnalysisBean>();
    cashFlowList.add(loanCashFlowBean);
    String sendingJson  = await _toListJson(loanCashFlowBean);
    String json = JSON.encode(CashFlowList);
    for (var items in json.toString().split(",")) {
      print("Json values for cash Flow " + items.toString());
    }
    _serviceUrl = "CustomerLoanCashFlow/add/";
    await syncLoanCashFlow(json);

  }

  Future<String> _toListJson(CustomerLoanCashFlowAnalysisBean bean) async {
    var mapData = new Map();

    mapData[TablesColumnFile.mrefno] =	bean.mrefno!= null ? bean.mrefno : 0;
    mapData[TablesColumnFile.trefno] =	         bean.trefno!= null ? bean.trefno : 0;
    mapData[TablesColumnFile.mleadsid] =	         ifNullCheck(bean.mleadsid);
    mapData[TablesColumnFile.mfimainbsinc] =	         bean.mfimainbsinc!= null ? bean.mfimainbsinc : 0.0;
    mapData[TablesColumnFile.mfisubbusinc] =	         bean.mfisubbusinc!= null ? bean.mfisubbusinc : 0.0;
    mapData[TablesColumnFile.mfirentalinc] =	         bean.mfirentalinc!= null ? bean.mfirentalinc : 0.0;
    mapData[TablesColumnFile.mfiotherinc] =	         bean.mfiotherinc!= null ? bean.mfiotherinc : 0.0;
    mapData[TablesColumnFile.mfitotalInc] =	         bean.mfitotalInc!= null ? bean.mfitotalInc : 0.0;
    mapData[TablesColumnFile.mbepurequipments] =	         bean.mbepurequipments!= null ? bean.mbepurequipments : 0.0;
    mapData[TablesColumnFile.mbepetrolcost] =	         bean.mbepetrolcost!= null ? bean.mbepetrolcost : 0.0;
    mapData[TablesColumnFile.mbewages] =	         bean.mbewages!= null ? bean.mbewages : 0.0;
    mapData[TablesColumnFile.mberent] =	         bean.mberent!= null ? bean.mberent : 0.0;
    mapData[TablesColumnFile.mbeeemi] =	         bean.mbeeemi!= null ? bean.mbeeemi : 0.0;
    mapData[TablesColumnFile.mbetotalbusexp] =	         bean.mbetotalbusexp!= null ? bean.mbetotalbusexp : 0.0;
    mapData[TablesColumnFile.mfefoodexp] =	         bean.mfefoodexp!= null ? bean.mfefoodexp : 0.0;
    mapData[TablesColumnFile.mfemobileexp] =	         bean.mfemobileexp!= null ? bean.mfemobileexp : 0.0;
    mapData[TablesColumnFile.mfemedicalexp] =	         bean.mfemedicalexp!= null ? bean.mfemedicalexp : 0.0;
    mapData[TablesColumnFile.mfeschoolfees] =	         bean.mfeschoolfees!= null ? bean.mfeschoolfees : 0.0;
    mapData[TablesColumnFile.mfecollegefees] =	         bean.mfecollegefees!= null ? bean.mfecollegefees : 0.0;
    mapData[TablesColumnFile.mfemiscellaneous] =	         bean.mfemiscellaneous!= null ? bean.mfemiscellaneous : 0.0;
    mapData[TablesColumnFile.mfeelectricity] =	         bean.mfeelectricity!= null ? bean.mfeelectricity : 0.0;
    mapData[TablesColumnFile.mfesocialcharity] =	         bean.mfesocialcharity!= null ? bean.mfesocialcharity : 0.0;
    mapData[TablesColumnFile.mfetotalfaminc] =	         bean.mfetotalfaminc!= null ? bean.mfetotalfaminc : 0.0;
    mapData[TablesColumnFile.mfetotalexp] =	         bean.mfetotalexp!= null ? bean.mfetotalexp : 0.0;
    mapData[TablesColumnFile.msurpluscash] =	         bean.msurpluscash!= null ? bean.msurpluscash : 0.0;
    mapData[TablesColumnFile.mdbr] =	         bean.mdbr!= null ? bean.mdbr : 0.0;

    mapData[TablesColumnFile.mcreateddt] = bean.mcreateddt.toIso8601String();
    mapData[TablesColumnFile.mcreatedby] = bean.mcreatedby.trim();
    mapData[TablesColumnFile.mlastupdatedt] =
        bean.mlastupdatedt.toIso8601String();
    mapData[TablesColumnFile.mlastupdateby] = ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] = ifNullCheck(bean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] = ifNullCheck(bean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] = ifNullCheck(bean.mgeologd);
    mapData[TablesColumnFile.missynctocoresys] =  bean.missynctocoresys!= null ? bean.missynctocoresys: 0;
    //bean.missynctocoresys != null ? bean.missynctocoresys : 0;
    mapData[TablesColumnFile.mlastsynsdate] = DateTime.now().toIso8601String();

    mapData[TablesColumnFile.mloanmrefno] =	bean.mloanmrefno!= null ? bean.mloanmrefno: 0;
    mapData[TablesColumnFile.mloantrefno] =	bean.mloantrefno!= null ? bean.mloantrefno: 0;
    mapData[TablesColumnFile.mcustmrefno] =	bean.mcustmrefno!= null ? bean.mcustmrefno: 0;
    mapData[TablesColumnFile.mcusttrefno] =	bean.mcusttrefno!= null ? bean.mcusttrefno: 0;



    CashFlowList.add(mapData);
    return mapData.toString();
  }

  String ifNullCheck(String value) {
    if (value == null || value == 'null') {
      value = "";
    }
    return value;
  }
}
