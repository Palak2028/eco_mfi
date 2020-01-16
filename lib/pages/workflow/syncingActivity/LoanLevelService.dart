
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:eco_mfi/Login.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/main.dart';
import 'package:eco_mfi/pages/home/Home_Dashboard.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CheckListCGT1Bean.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CheckListCGT2Bean.dart';
import 'package:eco_mfi/pages/workflow/GRT/bean/CheckListGRTBean.dart';
import 'package:eco_mfi/pages/workflow/GRT/bean/GRTBean.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';

import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationBusinessDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationPersonalInfo.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationSocialFinancialDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/BorrowingDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';

import 'package:eco_mfi/pages/workflow/customerFormation/bean/FamilyDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/PPIBean.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LoanLevel{

  int mrefno;
  int mbuttonid;
  String mbuttonname;
  int mstageid;
  String mproductname;
  String mprdcd;
  int morderid;
  int mismandatory;

  LoanLevel({this.mrefno, this.mbuttonid, this.mbuttonname, this.mstageid,
      this.mproductname, this.mprdcd,this.morderid,this.mismandatory});



  factory LoanLevel.fromJson(Map<String, dynamic> map) {
    return LoanLevel(
      mrefno:map[TablesColumnFile.mrefno] as int,
      mbuttonid:map[TablesColumnFile.mbuttonid] as int,
      mbuttonname:map[TablesColumnFile.mbuttonname] as String,
      mstageid:map[TablesColumnFile.mstageid] as int,
      mproductname:map[TablesColumnFile.mproductname] as String,
      mprdcd:map[TablesColumnFile.mprdcd] as String,
      morderid:map[TablesColumnFile.morderid] as int,
      mismandatory:map[TablesColumnFile.mismandatory] as int,



    );


  }

}


class LoanLevelService{

  static const JsonCodec JSON = const JsonCodec();

  Future<bool> getLoanLevel() async {
    Response bodyValue = await http.get(Constant.apiURL.toString()+"/loanlevel/getloanlevel");
    print(Constant.apiURL.toString()+"/loanlevel/getloanlevel");
    final parsed = JSON.decode(bodyValue.body).cast<Map<String, dynamic>>();
    List<LoanLevel> obj = parsed
        .map<LoanLevel>(
            (json) => LoanLevel.fromJson(json))
        .toList();
    print("Returned Json "+json.toString());




    if(obj!=null&&obj.isNotEmpty){

      for(LoanLevel item in obj){
        await AppDatabase.get().upadateLoanLevelMaster(item);
      }

    }








  }





}



