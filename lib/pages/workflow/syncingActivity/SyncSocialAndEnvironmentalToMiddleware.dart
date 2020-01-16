import 'dart:convert';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/DeviationFormBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/SocialAndEnvironmentalBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/TradeAndNeighbourRefCheckBean.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';

class SyncSocialAndEnvironmentalToMiddleware {
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
      List<SocialAndEnvironmentalBean> obj = parsed
          .map<SocialAndEnvironmentalBean>(
              (json) => SocialAndEnvironmentalBean.fromMapMiddleware(json))
          .toList();

      for (int save = 0; save < obj.length; save++) {
        print("print que : " +
            obj[save].mrefno.toString() +
            " : " +
            obj[save].trefno.toString());
        await AppDatabase.get()
            .selectSocialAndEnvironmentalListOnTref(obj[save].trefno, obj[save].mcreatedby)
            .then((SocialAndEnvironmentalBean tradeList) async {
              print(tradeList);
          String updateQuery = "";

          if (obj[save]!=null && obj[save].mrefno != null && tradeList.mrefno==null || tradeList.mrefno == 0) {
            print('if mein');
            //isSyncingFirstTime = true;
            updateQuery =
            "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,${TablesColumnFile.mrefno} = ${obj[save].mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[save].trefno}";
          } else {
            print('else mein');
            updateQuery =
            "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' WHERE ${TablesColumnFile.mrefno} = ${obj[save].mrefno} AND ${TablesColumnFile.trefno} = ${obj[save].trefno}";
          }

          print('updateQuery --${updateQuery}');
          print("No record displayed reason");
          print(tradeList.mrefno);
          print(obj[save].mrefno);
          print("upadate query save --" + updateQuery);
          print("Checking..");
          if (updateQuery != null) {
            await AppDatabase.get().updateSocialEnvMaster(updateQuery);
          }

        });
      }
      //updating lastsynced date time with now
      AppDatabase.get().updateStaticTablesLastSyncedMaster(18);
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
        .selectStaticTablesLastSyncedMaster(18,false)
        .then((onValue) async {

          print(onValue);
          //print("trade timing "+onValue.toString());
      await AppDatabase.get()
          .selectSocialAndEnvironmentalListIsDataSynced(onValue)
          .then((List<SocialAndEnvironmentalBean> tradeList) async {
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


      _serviceUrl = "/socialAndEnvironmental/add/";
      String json = JSON.encode(listTrade);
      for (var items in json.toString().split(",")) {
        print("Json values" + items.toString());
      }

      await syncedDataToMiddleware(json);
      //after call needs to update mref in tab in all tables and update lastsynced in lastsynced date time table
    });
  }

  Future<Null> getSocialForSingleLoan(SocialAndEnvironmentalBean bean) async {

    List<SocialAndEnvironmentalBean> socialList = new List<SocialAndEnvironmentalBean>();
    socialList.add(bean);
    String sendingJson  = await _toJson(bean);
    String json = JSON.encode(listTrade);
    for (var items in json.toString().split(",")) {
      print("Json values for social " + items.toString());
    }
    _serviceUrl = "socialAndEnvironmental/add/";
    await syncedDataToMiddleware(json);

  }



  Future<String> _toJson(SocialAndEnvironmentalBean bean) async{
    var mapData = new Map();

    mapData[TablesColumnFile.trefno] =	bean.trefno!=null ? bean.trefno:0;
    mapData[TablesColumnFile.mrefno] = bean.mrefno != null ? bean.mrefno : 0;
    mapData[TablesColumnFile.mloantrefno] =	bean.mloantrefno!=null?bean.mloantrefno:0;
    mapData[TablesColumnFile.mloanmrefno] =	bean.mloanmrefno!=null?bean.mloanmrefno:0;
    mapData[TablesColumnFile.mleadsid] =	bean.mleadsid!=null?bean.mleadsid:"";
    mapData[TablesColumnFile.mcusttrefno] =	bean.mcusttrefno!=null?bean.mcusttrefno:0;
    mapData[TablesColumnFile.mcustmrefno] =	bean.mcustmrefno!=null?bean.mcustmrefno:0;
    mapData[TablesColumnFile.mbrwexclist] =	bean.mbrwexclist!=null?bean.mbrwexclist:0;
    mapData[TablesColumnFile.mbrwnontargetlist] =	bean.mbrwnontargetlist!=null?bean.mbrwnontargetlist:0;
    mapData[TablesColumnFile.mbrwairemission] =	bean.mbrwairemission!=null?bean.mbrwairemission:0;
    mapData[TablesColumnFile.mbrwwastewater] =	bean.mbrwwastewater!=null?bean.mbrwwastewater:0;
    mapData[TablesColumnFile.mbrwsolidhazardous] =	bean.mbrwsolidhazardous!=null?bean.mbrwsolidhazardous:0;
    mapData[TablesColumnFile.mbrwchemicalfuels] =	bean.mbrwchemicalfuels!=null?bean.mbrwchemicalfuels:0;
    mapData[TablesColumnFile.mbrwnoisefumes] =	bean.mbrwnoisefumes!=null?bean.mbrwnoisefumes:0;
    mapData[TablesColumnFile.mbrwresconsuption] =	bean.mbrwresconsuption!=null?bean.mbrwresconsuption:0;
    mapData[TablesColumnFile.mcinodesignation] =	bean.mcinodesignation!=null?bean.mcinodesignation:0;
    mapData[TablesColumnFile.mcinci] =	bean.mcinci!=null?bean.mcinci:0;
    mapData[TablesColumnFile.msilar] =	bean.msilar!=null?bean.msilar:0;
    mapData[TablesColumnFile.msidrofls] =	bean.msidrofls!=null?bean.msidrofls:0;
    mapData[TablesColumnFile.msiils] =	bean.msiils!=null?bean.msiils:0;
    mapData[TablesColumnFile.msiiip] =	bean.msiiip!=null?bean.msiiip:0;
    mapData[TablesColumnFile.msicnc] =	bean.msicnc!=null?bean.msicnc:0;
    mapData[TablesColumnFile.msiasc] =	bean.msiasc!=null?bean.msiasc:0;
    mapData[TablesColumnFile.msinsi] =	bean.msinsi!=null?bean.msinsi:0;
    mapData[TablesColumnFile.mlinpp] =	bean.mlinpp!=null?bean.mlinpp:0;
    mapData[TablesColumnFile.mliieh] =	bean.mliieh!=null?bean.mliieh:0;
    mapData[TablesColumnFile.mliiwc] =	bean.mliiwc!=null?bean.mliiwc:0;
    mapData[TablesColumnFile.mliite] =	bean.mliite!=null?bean.mliite:0;
    mapData[TablesColumnFile.mliueo] =	bean.mliueo!=null?bean.mliueo:0;
    mapData[TablesColumnFile.mlipmw] =	bean.mlipmw!=null?bean.mlipmw:0;
    mapData[TablesColumnFile.mliema] =	bean.mliema!=null?bean.mliema:0;
    mapData[TablesColumnFile.mlicfl] =	bean.mlicfl!=null?bean.mlicfl:0;
    mapData[TablesColumnFile.mlipevc] =	bean.mlipevc!=null?bean.mlipevc:0;
    mapData[TablesColumnFile.mlireou] =	bean.mlireou!=null?bean.mlireou:0;
    mapData[TablesColumnFile.mlinli] =	bean.mlinli!=null?bean.mlinli:0;
    mapData[TablesColumnFile.mbrwcat] =	bean.mbrwcat!=null?bean.mbrwcat:0;
    mapData[TablesColumnFile.mleadstatus] =	bean.mleadstatus!=null?bean.mleadstatus:0;
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
