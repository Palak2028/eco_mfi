import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanImageBean.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT1Bean.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CheckListCGT1Bean.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CustomerLoanImageService {
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();
  String _serviceUrl;
  List customerLoanImageList = List();

  Future<Null> syncImage(String jsonList) async {
   // try {
    print(jsonList);
      String bodyValue = await NetworkUtil.callPostService(jsonList,
          Constant.apiURL.toString() + _serviceUrl.toString(), _headers);
      print("url " + Constant.apiURL.toString() + _serviceUrl.toString());

      if (bodyValue == '404'||bodyValue==null) {
        return null;
      } else {

        print("bodyValue is ${bodyValue} ");
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<CustomerLoanImageBean> obj = parsed
            .map<CustomerLoanImageBean>((json) => CustomerLoanImageBean.fromMapFromMiddleWare(json))
            .toList();

        for (int loanImage = 0; loanImage< obj.length; loanImage++) {
          await AppDatabase.get()
              .selectCustomerLoanImageOnmreftref(obj[loanImage].mloantrefno, obj[loanImage].mloanmrefno)
              .then((CustomerLoanImageBean loanImageBean) async {

                print("returning query is ${loanImageBean} ");

            String updateCustomerLoanImageQuery = null;

            if (obj[loanImage] != null &&
                obj[loanImage].mrefno != null &&
                loanImageBean != null &&
                loanImageBean.mrefno == null ||
                loanImageBean.mrefno == 0) {
              updateCustomerLoanImageQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.mrefno} = ${obj[loanImage]
                  .mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[loanImage]
                  .trefno}";
            } else {
              updateCustomerLoanImageQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' WHERE ${TablesColumnFile.mrefno} = ${obj[loanImage]
                  .mrefno} AND ${TablesColumnFile.trefno} = ${obj[loanImage]
                  .trefno}";
            }

            if (updateCustomerLoanImageQuery != null) {
              await AppDatabase.get()
                  .updateCustomerLoanImageQuery(updateCustomerLoanImageQuery);
            }

          });
        }
      }

    /*} catch (e) {
      print('Server Exception!!!');
      print(e);
    }*/
  }


  Future<Null> getAndSync() async {

    try {
      await AppDatabase.get()
          .selectStaticTablesLastSyncedMaster(24, false)
          .then((returnedImageDateTime) async {
        await AppDatabase.get()
            .selectCustomerLoanImageNotSynced(returnedImageDateTime)
            .then((List<CustomerLoanImageBean> loanImageList) async {

          for (int i = 0; i < loanImageList.length; i++) {


            await _toListJson( loanImageList[i]);
          }



          String json = JSON.encode(customerLoanImageList);
          for (var items in json.toString().split(",")) {
            print("Json values" + items.toString());
          }
          _serviceUrl = "CustomerLoanImage/addCustomerLoanImage/";
          await syncImage(json);
        });
      });
      AppDatabase.get().updateStaticTablesLastSyncedMaster(24);
    }
    catch (e) {
      print('Server Exception!!!');
    }
  }
  Future<Null> getLoanImageForSingleSync(List<CustomerLoanImageBean> loanImageBean) async {

    for (int i = 0; i < loanImageBean.length; i++) {

      await _toListJson(loanImageBean[i]);
    }


    String json = JSON.encode(customerLoanImageList);
    _serviceUrl = "CustomerLoanImage/addCustomerLoanImage/";
    await syncImage(json);

  }

  Future<String> _toListJson(CustomerLoanImageBean bean) async {
    var mapData = new Map();

    mapData[TablesColumnFile.trefno] = bean.trefno != null ? bean.trefno : 0;
    mapData[TablesColumnFile.mrefno] = bean.mrefno != null ? bean.mrefno : 0;
    mapData[TablesColumnFile.mloantrefno] = bean.mloantrefno != null ? bean.mloantrefno: 0;
    mapData[TablesColumnFile.mloanmrefno] = bean.mloanmrefno!= null ? bean.mloanmrefno: 0;
    mapData[TablesColumnFile.timgrefno] = bean.timgrefno!= null ? bean.timgrefno: 0;

    if (bean.timgrefno > 3 ) {
      mapData[TablesColumnFile.mimagestring] = ifNullCheck(bean.mimagestring);
    } else {
      File imageFile = new File(bean.mimagestring);
      final Directory extDir = await getApplicationDocumentsDirectory();
      var targetPath = extDir.absolute.path + "/temp.png";
      var imgFile = null;

      if(imageFile!=null && targetPath!=null){
        imgFile = await compressAndGetFile(imageFile, targetPath);
        List<int> imageBytes = imgFile.readAsBytesSync();
        String base64Image = base64.encode(imageBytes);
        mapData[TablesColumnFile.mimagestring] = ifNullCheck(base64Image);
      }else{
        mapData[TablesColumnFile.mimagestring] = null;
      }

    }
    mapData[TablesColumnFile.mimagetype] = ifNullCheck(bean.mimagetype);
    mapData[TablesColumnFile.mimagebyteorfolder] = 0;



    mapData["mimgsize"] = 0;
    mapData[""] = ifNullCheck(bean.mimagetype);
    mapData[TablesColumnFile.mcreateddt] = bean.mcreateddt.toIso8601String();
    mapData[TablesColumnFile.mcreatedby] = bean.mcreatedby.trim();
    mapData[TablesColumnFile.mlastupdatedt] =
        bean.mlastupdatedt.toIso8601String();
    mapData[TablesColumnFile.mlastupdateby] = ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.missynctocoresys] =
    bean.missynctocoresys != null ? bean.missynctocoresys : 0;
    mapData[TablesColumnFile.mlastsynsdate] = DateTime.now().toIso8601String();


    print("beanChkList.length " + customerLoanImageList.length.toString());


    customerLoanImageList.add(mapData);
    return mapData.toString();
  }

  String ifNullCheck(String value) {
    if (value == null || value == 'null') {
      value = "";
    }
    return value;
  }


  Future<File> compressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 50,
      rotate: 0,
    );

    /*print(file.lengthSync());
    print(result.lengthSync());*/

    return result;
  }
}
