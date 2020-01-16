import 'dart:async';
import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';

class LookupDataServices {
  static String apiURL =
      "lookupMasterController/getAllLookup/";
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  Future<List<LookupMasterBean>> getLookupData() async {
    List<LookupMasterBean> lookupMaster = new List<LookupMasterBean>();
  try {
    final bodyValue = await NetworkUtil.callGetService(Constant.apiURL+"lookupMasterController/getAllLookup/");
    if(bodyValue == "404" ){
      return null;
    }
    print(bodyValue);
      lookupMaster = await _fromLookupJson(bodyValue);
    AppDatabase.get().updateStaticTablesLastSyncedMasterGetFromServer(9,DateTime.now());
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
      print(list);
      var bean = LookupMasterBean.fromJson(list[i]);
      listLookupBean.add(bean);
    }
    return listLookupBean;
  }


}

