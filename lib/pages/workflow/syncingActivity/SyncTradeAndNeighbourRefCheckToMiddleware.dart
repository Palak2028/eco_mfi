import 'dart:convert';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/TradeAndNeighbourRefCheckBean.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';

class SyncTradeAndNeighbourRefCheckToMiddleware {
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
      List<TradeAndNeighbourRefCheckBean> obj = parsed
          .map<TradeAndNeighbourRefCheckBean>(
              (json) => TradeAndNeighbourRefCheckBean.fromMapMiddleware(json))
          .toList();

      for (int save = 0; save < obj.length; save++) {
        print("print que : " +
            obj[save].mrefno.toString() +
            " : " +
            obj[save].trefno.toString());
        await AppDatabase.get()
            .selectTradeNeighbourRefListOnTref(obj[save].trefno, obj[save].mcreatedby)
            .then((TradeAndNeighbourRefCheckBean tradeList) async {
              print(tradeList);
          String updateTradeQuery = "";

          if (obj[save]!=null && obj[save].mrefno != null && tradeList.mrefno==null || tradeList.mrefno == 0) {
            print('if mein');
            //isSyncingFirstTime = true;
            updateTradeQuery =
            "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,${TablesColumnFile.mrefno} = ${obj[save].mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[save].trefno}";
          } else {
            print('else mein');
            updateTradeQuery =
            "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' WHERE ${TablesColumnFile.mrefno} = ${obj[save].mrefno} AND ${TablesColumnFile.trefno} = ${obj[save].trefno}";
          }

          print('updateTradeQuery --${updateTradeQuery}');
          print("No record displayed reason");
          print(tradeList.mrefno);
          print(obj[save].mrefno);
          print("upadate query save --" + updateTradeQuery);
          print("Checking..");
          if (updateTradeQuery != null) {
            await AppDatabase.get().updateTradeNeighbourRefMaster(updateTradeQuery);
          }

        });
      }
      //updating lastsynced date time with now
      AppDatabase.get().updateStaticTablesLastSyncedMaster(17);
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
        .selectStaticTablesLastSyncedMaster(17,false)
        .then((onValue) async {

          print(onValue);
          //print("trade timing "+onValue.toString());
      await AppDatabase.get()
          .selectTradeAndNeighbourRefListIsDataSynced(onValue)
          .then((List<TradeAndNeighbourRefCheckBean> tradeList) async {
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


      _serviceUrl = "/tradeAndNeighbourRefCheck/add/";
      String json = JSON.encode(listTrade);
      for (var items in json.toString().split(",")) {
        print("Json values" + items.toString());
      }

      await syncedDataToMiddleware(json);
      //after call needs to update mref in tab in all tables and update lastsynced in lastsynced date time table
    });
  }

  Future<Null> getTradeForSingleLoan(TradeAndNeighbourRefCheckBean bean) async {

    List<TradeAndNeighbourRefCheckBean> tradeList = new List<TradeAndNeighbourRefCheckBean>();
    tradeList.add(bean);
    String sendingJson  = await _toJson(bean);
    String json = JSON.encode(listTrade);
    for (var items in json.toString().split(",")) {
      print("Json values for trade " + items.toString());
    }
    _serviceUrl = "tradeAndNeighbourRefCheck/add/";
    await syncedDataToMiddleware(json);

  }



  Future<String> _toJson(TradeAndNeighbourRefCheckBean bean) async{
    var mapData = new Map();

    mapData[TablesColumnFile.trefno] =	bean.trefno!=null ? bean.trefno:0;
    mapData[TablesColumnFile.mrefno] = bean.mrefno != null ? bean.mrefno : 0;
    mapData[TablesColumnFile.mloantrefno] =	bean.mloantrefno!=null?bean.mloantrefno:0;
    mapData[TablesColumnFile.mloanmrefno] =	bean.mloanmrefno!=null?bean.mloanmrefno:0;
    mapData[TablesColumnFile.mleadsid] =	bean.mleadsid!=null?bean.mleadsid:"";
    mapData[TablesColumnFile.mcusttrefno] =	bean.mcusttrefno!=null?bean.mcusttrefno:0;
    mapData[TablesColumnFile.mcustmrefno] =	bean.mcustmrefno!=null?bean.mcustmrefno:0;
    mapData[TablesColumnFile.msupname] =	bean.msupname!=null?bean.msupname:"";
    mapData[TablesColumnFile.msupaddress] =	bean.msupaddress!=null?bean.msupaddress:"";
    mapData[TablesColumnFile.msupcontact] =		ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.msupcredit] =	bean.msupcredit!=null?bean.msupcredit:"";
    mapData[TablesColumnFile.msuponcredit] =	bean.msuponcredit!=null?bean.msuponcredit:"";
    mapData[TablesColumnFile.mclientdelay] =	bean.mclientdelay!=null?bean.mclientdelay:0;
    mapData[TablesColumnFile.mdefpayment] =	bean.mdefpayment!=null?bean.mdefpayment:"";
    mapData[TablesColumnFile.mproductsup] =	bean.mproductsup!=null?bean.mproductsup:"";
    mapData[TablesColumnFile.msalcycles] =	bean.msalcycles!=null?bean.msalcycles:0;
    mapData[TablesColumnFile.mvalsalcycles] =	bean.mvalsalcycles!=null?bean.mvalsalcycles:"";
    mapData[TablesColumnFile.mloanlender] =	bean.mloanlender!=null?bean.mloanlender:"";
    mapData[TablesColumnFile.mfacility] =	bean.mfacility!=null?bean.mfacility:"";
    mapData[TablesColumnFile.mturnover] =	bean.mturnover!=null?bean.mturnover:0;
    mapData[TablesColumnFile.mremarks] =	bean.mremarks!=null?bean.mremarks:"";
    mapData[TablesColumnFile.mbuyersname] =	bean.mbuyersname!=null?bean.mbuyersname:"";
    mapData[TablesColumnFile.mbuyersaddress] =	bean.mbuyersaddress!=null?bean.mbuyersaddress:"";
    mapData[TablesColumnFile.mcontactno] =	bean.mcontactno!=null?bean.mcontactno:"";
    mapData[TablesColumnFile.mbuyingperiod] =	bean.mbuyingperiod!=null?bean.mbuyingperiod:0;
    mapData[TablesColumnFile.mcreditbuying] =	bean.mcreditbuying!=null?bean.mcreditbuying:"";
    mapData[TablesColumnFile.mdays] =	bean.mdays!=null?bean.mdays:"";
    mapData[TablesColumnFile.mproducts] =	bean.mproducts!=null?bean.mproducts:"";
    mapData[TablesColumnFile.mmonthlypur] =	bean.mmonthlypur!=null?bean.mmonthlypur:"";
    mapData[TablesColumnFile.mquality] =	bean.mquality!=null?bean.mquality:0;
    mapData[TablesColumnFile.mreliableper] =	bean.mreliableper!=null?bean.mreliableper:"";
    mapData[TablesColumnFile.mcusremarks] =	bean.mcusremarks!=null?bean.mcusremarks:"";
    mapData[TablesColumnFile.mneigname] =	bean.mneigname!=null?bean.mneigname:"";
    mapData[TablesColumnFile.mneigadd] =	bean.mneigadd!=null?bean.mneigadd:"";
    mapData[TablesColumnFile.mknownclient] =	bean.mknownclient!=null?bean.mknownclient:0;
    mapData[TablesColumnFile.mimprovement] =	bean.mimprovement!=null?bean.mimprovement:0;
    mapData[TablesColumnFile.mrelperson] =	bean.mrelperson!=null?bean.mrelperson:"";
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
