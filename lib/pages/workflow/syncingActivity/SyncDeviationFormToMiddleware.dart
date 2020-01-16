import 'dart:convert';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/DeviationFormBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/TradeAndNeighbourRefCheckBean.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';

class SyncDeviationFormToMiddleware {
  static const JsonCodec JSON = const JsonCodec();
  static String _serviceUrl = "";
  static final _headers = {'Content-Type': 'application/json'};


  List listTrade = List();

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
      List<DeviationFormBean> obj = parsed
          .map<DeviationFormBean>(
              (json) => DeviationFormBean.fromMapMiddleware(json))
          .toList();

      for (int save = 0; save < obj.length; save++) {
        print("print que : " +
            obj[save].mrefno.toString() +
            " : " +
            obj[save].trefno.toString());
        await AppDatabase.get()
            .selectDeviationFormListOnTref(obj[save].trefno, obj[save].mcreatedby)
            .then((DeviationFormBean tradeList) async {
              print(tradeList);
          String updateDeviationQuery = "";

          if (obj[save]!=null && obj[save].mrefno != null && tradeList.mrefno==null || tradeList.mrefno == 0) {
            print('if mein');
            //isSyncingFirstTime = true;
            updateDeviationQuery =
            "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,${TablesColumnFile.mrefno} = ${obj[save].mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[save].trefno}";
          } else {
            print('else mein');
            updateDeviationQuery =
            "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' WHERE ${TablesColumnFile.mrefno} = ${obj[save].mrefno} AND ${TablesColumnFile.trefno} = ${obj[save].trefno}";
          }

          print('updateDeviationQuery --${updateDeviationQuery}');
          print("No record displayed reason");
          print(tradeList.mrefno);
          print(obj[save].mrefno);
          print("upadate query save --" + updateDeviationQuery);
          print("Checking..");
          if (updateDeviationQuery != null) {
            await AppDatabase.get().updateDeviationMaster(updateDeviationQuery);
          }

        });
      }
      //updating lastsynced date time with now
      AppDatabase.get().updateStaticTablesLastSyncedMaster(19);
    }
    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }

  Future<Null> savingsNormalData() async {
    print('savingsNormalData');
    List tradeList = new List();

    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(19,false)
        .then((onValue) async {

          print(onValue);
          //print("trade timing "+onValue.toString());
      await AppDatabase.get()
          .selectDeviationFormListIsDataSynced(onValue)
          .then((List<DeviationFormBean> tradeList) async {
            if(tradeList.length==0){
              return;
            }
        for (int i = 0; i < tradeList.length; i++) {
          print("length of trade List " + tradeList.length.toString());


          await _toJson(tradeList[i]).then((onValue) {});
          /*     await _tosaveomerJson(saveomerData[i]).then((onValue){
          saveomerList.add(onValue);
        });*/
        }

      });


      _serviceUrl = "/deviationForm/add/";
      String json = JSON.encode(listTrade);
      for (var items in json.toString().split(",")) {
        print("Json values" + items.toString());
      }

      await syncedDataToMiddleware(json);
      //after call needs to update mref in tab in all tables and update lastsynced in lastsynced date time table
    });
  }











  Future<Null> getDeviationForSingleLoan(DeviationFormBean deviationForm) async {

    List<DeviationFormBean> deviationLst = new List<DeviationFormBean>();
    deviationLst.add(deviationForm);
    String sendingJson  = await _toJson(deviationForm);
    String json = JSON.encode(listTrade);

    _serviceUrl = "/deviationForm/add/";
    await syncedDataToMiddleware(json);

  }



  Future<String> _toJson(DeviationFormBean bean) async{
    var mapData = new Map();

    mapData[TablesColumnFile.trefno] =	bean.trefno!=null ? bean.trefno:0;
    mapData[TablesColumnFile.mrefno] = bean.mrefno != null ? bean.mrefno : 0;
    mapData[TablesColumnFile.mloantrefno] =	bean.mloantrefno!=null?bean.mloantrefno:0;
    mapData[TablesColumnFile.mloanmrefno] =	bean.mloanmrefno!=null?bean.mloanmrefno:0;
    mapData[TablesColumnFile.mleadsid] =	bean.mleadsid!=null?bean.mleadsid:"";
    mapData[TablesColumnFile.mcusttrefno] =	bean.mcusttrefno!=null?bean.mcusttrefno:0;
    mapData[TablesColumnFile.mcustmrefno] =	bean.mcustmrefno!=null?bean.mcustmrefno:0;
    mapData[TablesColumnFile.mdevloanapp] =	bean.mdevloanapp!=null?bean.mdevloanapp:"";
    mapData[TablesColumnFile.mdrnrc] =	bean.mdrnrc!=null?bean.mdrnrc:0;
    mapData[TablesColumnFile.mdrmni] =	bean.mdrmni!=null?bean.mdrmni:0;
    mapData[TablesColumnFile.mdrdbr] =	bean.mdrdbr!=null?bean.mdrdbr:0;
    mapData[TablesColumnFile.mdrmfi] =	bean.mdrmfi!=null?bean.mdrmfi:0;
    mapData[TablesColumnFile.mdrbl] =	bean.mdrbl!=null?bean.mdrbl:0;
    mapData[TablesColumnFile.mdevapproval] =	bean.mdevapproval!=null?bean.mdevapproval:"";
    mapData[TablesColumnFile.mleadstatus] =	bean.mleadstatus!=null?bean.mleadstatus:0;
    mapData[TablesColumnFile.mcreateddt] =	ifDateNullCheck(bean.mcreateddt);
    mapData[TablesColumnFile.mcreatedby] =	ifNullCheck(bean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] =	ifDateNullCheck(bean.mlastupdatedt);
    mapData[TablesColumnFile.mlastupdateby] =	ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] =	ifNullCheck(bean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] =	ifNullCheck(bean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] =	ifNullCheck(bean.mgeologd);
    mapData[TablesColumnFile.missynctocoresys] =	bean.missynctocoresys!=null?bean.missynctocoresys:0;
    mapData[TablesColumnFile.mlastsynsdate] =	ifDateNullCheck(bean.mlastsynsdate);
    mapData[TablesColumnFile.isDataSynced] = 1;
    listTrade.add(mapData);

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
