import 'dart:convert';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';

class SyncingSubLookupDataServices{


  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlGetSubLookupMasterInfo =
      "SubLookupData/getAllSubLookup/";
  static const JsonCodec JSON = const JsonCodec();


  Future<Null> trySave() async {
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      await getSubLookupData();
    }
  }

  Future<List<LookupMasterBean>> getSubLookupData() async {
    List<LookupMasterBean> lookupMaster = new List<LookupMasterBean>();
    print("Data after Lookup service  1");
   try {
      final bodyValue = await NetworkUtil.callGetService(Constant.apiURL+urlGetSubLookupMasterInfo);
      if(bodyValue == "404" ){
        return null;
      }
      lookupMaster = await _fromLookupJson(bodyValue);
      AppDatabase.get().updateStaticTablesLastSyncedMasterGetFromServer(10,DateTime.now());
      return lookupMaster;
    } catch (e) {
      print('Server Exception!!!');
      return lookupMaster;
    }
  }


  Future<List<LookupMasterBean>> _fromLookupJson(String json) async{
    List<LookupMasterBean> listLookupBean = new List<LookupMasterBean>();
    List list = JSON.decode(json);
    for (int i = 0; i < list.length; i++) {
      print(list.length);
      var bean = LookupMasterBean.fromJsonSubLookup(list[i]);
      listLookupBean.add(bean);
    }
    return listLookupBean;
  }


}