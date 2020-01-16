import 'dart:convert';
import 'dart:io';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCPVBusinessRecordBean.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class SyncCustomerLoanCPVBusinessRecordToMiddleware {
  static const JsonCodec JSON = const JsonCodec();
  static String _serviceUrl = "";
  static final _headers = {'Content-Type': 'application/json'};


  List listTrade = new List();

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
      List<CustomerLoanCPVBusinessRecordBean> obj = parsed
          .map<CustomerLoanCPVBusinessRecordBean>(
              (json) => CustomerLoanCPVBusinessRecordBean.fromMapMiddleware(json))
          .toList();

      for (int save = 0; save < obj.length; save++) {
        print("print que : " +
            obj[save].mrefno.toString() +
            " : " +
            obj[save].trefno.toString());
        await AppDatabase.get()
            .selectLoanCPVBusinessRecordOnTref(obj[save].trefno, obj[save].mcreatedby)
            .then((CustomerLoanCPVBusinessRecordBean cpvList) async {
              print(cpvList);
          String updateCpvQuery = "";

          if (obj[save]!=null && obj[save].mrefno != null && cpvList.mrefno==null || cpvList.mrefno == 0) {
            print('if mein');
            //isSyncingFirstTime = true;
            updateCpvQuery =
            "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,${TablesColumnFile.mrefno} = ${obj[save].mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[save].trefno}";
          } else {
            print('else mein');
            updateCpvQuery =
            "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' WHERE ${TablesColumnFile.mrefno} = ${obj[save].mrefno} AND ${TablesColumnFile.trefno} = ${obj[save].trefno}";
          }

          print('updateCpvQuery --${updateCpvQuery}');
          print("No record displayed reason");
          print(cpvList.mrefno);
          print(obj[save].mrefno);
          print("upadate query save --" + updateCpvQuery);
          print("Checking..");
          if (updateCpvQuery != null) {
            await AppDatabase.get().updateCPVBusinessRecord(updateCpvQuery);
          }

        });
      }
      //updating lastsynced date time with now
      AppDatabase.get().updateStaticTablesLastSyncedMaster(22);
    }
    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }

  Future<Null> savingsNormalData() async {
    print('savingsNormalData');
    List cpvList = new List();

    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(22,false)
        .then((onValue) async {

          print(onValue);
          //print("trade timing "+onValue.toString());
      await AppDatabase.get()
          .selectLoanCPVBusinessRecordIsDataSynced(onValue)
          .then((List<CustomerLoanCPVBusinessRecordBean> cpvList) async {
            if(cpvList.length==0){
              return;
            }
        for (int i = 0; i < cpvList.length; i++) {
          print("length of trade List " + cpvList.length.toString());

          await _toJson(cpvList[i]).then((onValue) {});
        }

      });

      _serviceUrl = "/cpvBusinessRecord/add/";
      String json = JSON.encode(listTrade);
      for (var items in json.toString().split(",")) {
        print("Json values" + items.toString());
      }

      await syncedDataToMiddleware(json);
      //after call needs to update mref in tab in all tables and update lastsynced in lastsynced date time table
    });
  }

  Future<Null> getCPVForSingleLoan(CustomerLoanCPVBusinessRecordBean bean) async {
    print("getCPVForSingleLoan");
    List<CustomerLoanCPVBusinessRecordBean> cpvList = new List<CustomerLoanCPVBusinessRecordBean>();

    await _toJson(bean);
    String json = JSON.encode(listTrade);
    for (var items in json.toString().split(",")) {
      print("Json values for CPV " + items.toString());
    }
    _serviceUrl = "cpvBusinessRecord/add/";
    await syncedDataToMiddleware(json);

  }

  Future<File> compressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(

      file.absolute.path,
      targetPath,
      quality: 50,
      rotate: 0,
    );
    return result;
  }

  Future<String> _toJson(CustomerLoanCPVBusinessRecordBean bean) async{
    var mapData = new Map();

    mapData[TablesColumnFile.trefno] =	bean.trefno!=null ? bean.trefno:0;
    mapData[TablesColumnFile.mrefno] = bean.mrefno != null ? bean.mrefno : 0;
    mapData[TablesColumnFile.mloantrefno] =	bean.mloantrefno!=null?bean.mloantrefno:0;
    mapData[TablesColumnFile.mloanmrefno] =	bean.mloanmrefno!=null?bean.mloanmrefno:0;
    mapData[TablesColumnFile.mleadsid] =	bean.mleadsid!=null?bean.mleadsid:"";
    mapData[TablesColumnFile.mcusttrefno] =	bean.mcusttrefno!=null?bean.mcusttrefno:0;
    mapData[TablesColumnFile.mcustmrefno] =	bean.mcustmrefno!=null?bean.mcustmrefno:0;
    mapData[TablesColumnFile.mhblocated] =	bean.mhblocated!=null?bean.mhblocated:"";
    mapData[TablesColumnFile.mbusinessname] =	bean.mbusinessname!=null?bean.mbusinessname:"";
    mapData[TablesColumnFile.mbusinessaddress] =	bean.mbusinessaddress!=null?bean.mbusinessaddress:"";
    mapData[TablesColumnFile.maddresschanged] =	bean.maddresschanged!=null?bean.maddresschanged:"";
    if (bean.mbusinesslicense != null && bean.mbusinesslicense != "null") {
      File imageFile = new File(bean.mbusinesslicense);
      final Directory extDir = await getApplicationDocumentsDirectory();
      var targetPath = extDir.absolute.path + "/temp.png";
      var imgFile = await compressAndGetFile(imageFile, targetPath);
      List<int> imageBytes = imgFile.readAsBytesSync();
      String base64Image = base64.encode(imageBytes);
      mapData["mbusinesslicense"] = ifNullCheck(base64Image);
    } else
      mapData["mbusinesslicense"] = null;
    //mapData[TablesColumnFile.mbusinesslicense] =	bean.mbusinesslicense!=null?bean.mbusinesslicense:"";
    mapData[TablesColumnFile.mstartedym] =	ifDateNullCheck(bean.mstartedym);
    mapData[TablesColumnFile.mpropertystatus] =	bean.mpropertystatus!=null?bean.mpropertystatus:0;
    mapData[TablesColumnFile.mshopcondition] =	bean.mshopcondition!=null?bean.mshopcondition:0;
    mapData[TablesColumnFile.mbuslocation] =	bean.mbuslocation!=null?bean.mbuslocation:"";
    if (bean.mpremisesphoto != null && bean.mpremisesphoto != "null") {
      File imageFile = new File(bean.mpremisesphoto);
      final Directory extDir = await getApplicationDocumentsDirectory();
      var targetPath = extDir.absolute.path + "/temp.png";
      var imgFile = await compressAndGetFile(imageFile, targetPath);
      List<int> imageBytes = imgFile.readAsBytesSync();
      String base64Image = base64.encode(imageBytes);
      mapData["mpremisesphoto"] = ifNullCheck(base64Image);
    } else
      mapData["mpremisesphoto"] = null;

    if (bean.mpremisesphotosec != null && bean.mpremisesphotosec != "null") {
      File imageFile = new File(bean.mpremisesphotosec);
      final Directory extDir = await getApplicationDocumentsDirectory();
      var targetPath = extDir.absolute.path + "/temp.png";
      var imgFile = await compressAndGetFile(imageFile, targetPath);
      List<int> imageBytes = imgFile.readAsBytesSync();
      String base64Image = base64.encode(imageBytes);
      mapData["mpremisesphotosec"] = ifNullCheck(base64Image);
    } else
      mapData["mpremisesphotosec"] = null;

    if (bean.mpremisesphotothird != null && bean.mpremisesphotothird != "null") {
      File imageFile = new File(bean.mpremisesphotothird);
      final Directory extDir = await getApplicationDocumentsDirectory();
      var targetPath = extDir.absolute.path + "/temp.png";
      var imgFile = await compressAndGetFile(imageFile, targetPath);
      List<int> imageBytes = imgFile.readAsBytesSync();
      String base64Image = base64.encode(imageBytes);
      mapData["mpremisesphotothird"] = ifNullCheck(base64Image);
    } else
      mapData["mpremisesphotothird"] = null;

    //mapData[TablesColumnFile.mpremisesphoto] =	bean.mpremisesphoto!=null?bean.mpremisesphoto:"";
    mapData[TablesColumnFile.mnoofcustomers] =	bean.mnoofcustomers!=null?bean.mnoofcustomers:"";
    mapData[TablesColumnFile.mcuslocation] =	bean.mcuslocation!=null?bean.mcuslocation:0;
    mapData[TablesColumnFile.mcusdealing] =	bean.mcusdealing!=null?bean.mcusdealing:0;
    mapData[TablesColumnFile.mcreditsales] =	bean.mcreditsales!=null?bean.mcreditsales:"";
    mapData[TablesColumnFile.mperiodsale] =	bean.mperiodsale!=null?bean.mperiodsale:"";
    mapData[TablesColumnFile.mapplicantsrole] =	bean.mapplicantsrole!=null?bean.mapplicantsrole:0;
    mapData[TablesColumnFile.mbuspartner] =	bean.mbuspartner!=null?bean.mbuspartner:"";
    mapData[TablesColumnFile.mkeyperson] =	bean.mkeyperson!=null?bean.mkeyperson:0;
    mapData[TablesColumnFile.mcusbehaviour] =	bean.mcusbehaviour!=null?bean.mcusbehaviour:0;
    mapData[TablesColumnFile.mtransrecord] =	bean.mtransrecord!=null?bean.mtransrecord:"";
    mapData[TablesColumnFile.mrecpurandsal] =	bean.mrecpurandsal!=null?bean.mrecpurandsal:0;
    mapData[TablesColumnFile.mbooksupdated] =	bean.mbooksupdated!=null?bean.mbooksupdated:0;
    mapData[TablesColumnFile.mivlandrecord] =	bean.mivlandrecord!=null?bean.mivlandrecord:0;
    mapData[TablesColumnFile.mivsalesregister] =	bean.mivsalesregister!=null?bean.mivsalesregister:0;
    mapData[TablesColumnFile.mivcreditregister] =	bean.mivcreditregister!=null?bean.mivcreditregister:0;
    mapData[TablesColumnFile.mivinventoryregister] =	bean.mivinventoryregister!=null?bean.mivinventoryregister:0;
    mapData[TablesColumnFile.mivsalaryslip] =	bean.mivsalaryslip!=null?bean.mivsalaryslip:0;
    mapData[TablesColumnFile.mivpassbook] =	bean.mivpassbook!=null?bean.mivpassbook:0;
    mapData[TablesColumnFile.mbuscategories] =	bean.mbuscategories!=null?bean.mbuscategories:0;
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
