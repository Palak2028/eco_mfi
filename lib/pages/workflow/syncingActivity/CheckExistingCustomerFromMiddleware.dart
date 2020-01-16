import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
/*import 'package:eco_mfi/pages/workflow/CGT/bean/CGT1Services.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT2Services.dart';
import 'package:eco_mfi/pages/workflow/GRT/GRTServices.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFoundation.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanSyncing.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterFoundationBean.dart';*/
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CbResultBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CreditBereauBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/ProspectServices.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
/*import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationLoanDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationDeclarationForm.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationContactDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/FamilyDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_mfi/pages/workflow/qrScanner/QrScanner.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetCustomerFromMiddleware.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingProducts.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingPurposeOfLoan.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingRepaymentFrequency.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingTransactionMode.dart';*/
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:http/http.dart' as http;
/*import 'package:dio/dio.dart';*/
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';




class ChkExstngCustFrmMiddleware{

  static const JsonCodec JSON = const JsonCodec();

  static final _headers = {'Content-Type': 'application/json'};
  static final _headers2 = {
    'Content-Type': 'aapplication/x-www-form-urlencoded'
  };

  List<CreditBereauBean> returnList = new List<CreditBereauBean>();
  List jsonList = new List();
  List idList = new List();

  String prospectJson;

  Future<CustomerCheckBean>  syncCheckedDataToMiddleware () async {

    print(Constant.apiURL.toString());
    String bodyValue = await NetworkUtil.callPostService(prospectJson,
        Constant.apiURL.toString() + Constant.chkExstngCustIp.toString(), _headers);
    print("url " + Constant.apiURL.toString() + Constant.chkExstngCustIp.toString());
    if (bodyValue == "error"||bodyValue==null) {
      print("error coming");
      return null;
    } else {


      print(bodyValue);
      final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
      print(parsed);

      print(parsed);





    print("Data returned");
    print(bodyValue);

      List<CustomerCheckBean> obj = parsed
          .map<CustomerCheckBean>(
              (json) => CustomerCheckBean.fromMap(json, true))
          .toList();

      if(obj!=null&&obj.isNotEmpty){

        return obj[0];


      }
      else return null;



    }


  }





  Future<CustomerCheckBean> checkExistingCustomer(CreditBereauBean  creditBereauObject)async {




    await  idToJson(creditBereauObject.mpanno,creditBereauObject.mid1desc);

    print(prospectJson);
    CustomerCheckBean custBean =  await  syncCheckedDataToMiddleware();


     return custBean;

    return null;
  }



  Future<Null> idToJson(String id1,String id2) async{

    var mapData = new Map();
    mapData[TablesColumnFile.mpannodesc] =	  ifNullCheck(id1);
    mapData[TablesColumnFile.mIdDesc] =	  ifNullCheck(id2);

    prospectJson  =  await JSON.encode(mapData);

  }


  Future<String> toProspectJson(CreditBereauBean prospectListBean)async {

    var mapData = new Map();
    mapData[TablesColumnFile.trefno] =	  prospectListBean.trefno==null?0:prospectListBean.trefno;
    mapData[TablesColumnFile.mrefno] =	  prospectListBean.mrefno==null?0:prospectListBean.mrefno;
    mapData[TablesColumnFile.mlbrcode] =	  prospectListBean.mlbrcode==null?0:prospectListBean.mlbrcode;
    mapData[TablesColumnFile.mqueueno] =	  prospectListBean.mqueueno==null?0:prospectListBean.mqueueno;
    mapData[TablesColumnFile.mprospectdt] =	  ifDateNullCheck(prospectListBean.mprospectdt);
    mapData[TablesColumnFile.mnametitle] =	  ifNullCheck(prospectListBean.mnametitle);
    mapData[TablesColumnFile.mprospectname] =	  prospectListBean.mprospectname;
    mapData[TablesColumnFile.mmobno] =	  ifNullCheck(prospectListBean.mmobno.toString());
    mapData[TablesColumnFile.mdob] =	  ifDateNullCheck(prospectListBean.mdob);
    mapData[TablesColumnFile.motpverified] =	  prospectListBean.motpverified==null?0:prospectListBean.motpverified;
    mapData[TablesColumnFile.mcbcheckstatus] =	  ifNullCheck(prospectListBean.mcbcheckstatus);
    mapData[TablesColumnFile.mprospectstatus] =	  prospectListBean.mprospectstatus==null?0:prospectListBean.mprospectstatus;
    mapData[TablesColumnFile.madd1] =	  ifNullCheck(prospectListBean.madd1);
    mapData[TablesColumnFile.madd2] =	  ifNullCheck(prospectListBean.madd2);
    mapData[TablesColumnFile.madd3] =	  ifNullCheck(prospectListBean.madd3);
    mapData[TablesColumnFile.mhomeloc] =	  ifNullCheck(prospectListBean.mhomeloc);
    mapData[TablesColumnFile.mareacd] =	  prospectListBean.mareacd==null?0:prospectListBean.mareacd;
    mapData[TablesColumnFile.mvillage] =	  ifNullCheck(prospectListBean.mvillage);
    mapData[TablesColumnFile.mdistcd] =	  prospectListBean.mdistcd==null?0:prospectListBean.mdistcd;
    mapData[TablesColumnFile.mstatecd] =	  ifNullCheck(prospectListBean.mstatecd);
    mapData[TablesColumnFile.mcountrycd] =	  ifNullCheck(prospectListBean.mcountrycd);
    mapData[TablesColumnFile.mpincode] =	  prospectListBean.mpincode==null?0:prospectListBean.mpincode;
    mapData[TablesColumnFile.mcountryoforigin] =	  ifNullCheck(prospectListBean.mcountryoforigin);
    mapData[TablesColumnFile.mnationality] =	  ifNullCheck(prospectListBean.mnationality);
    mapData[TablesColumnFile.mpanno] =	  ifNullCheck(prospectListBean.mpanno);
    mapData[TablesColumnFile.mpannodesc] =	  ifNullCheck(prospectListBean.mpannodesc);
    mapData[TablesColumnFile.missynctocoresys] =	  prospectListBean.missynctocoresys==null?0:prospectListBean.missynctocoresys;
    mapData[TablesColumnFile.misuploaded] =	  prospectListBean.misuploaded==null?0:prospectListBean.misuploaded;
    mapData[TablesColumnFile.mspousename] =	  ifNullCheck(prospectListBean.mspousename);
    mapData[TablesColumnFile.mspouserelation] =	  ifNullCheck(prospectListBean.mspouserelation);
    mapData[TablesColumnFile.mnomineename] =	  ifNullCheck(prospectListBean.mnomineename);
    mapData[TablesColumnFile.mnomineerelation] =	  ifNullCheck(prospectListBean.mnomineerelation);
    mapData[TablesColumnFile.mcreditenqpurposetype] =	  ifNullCheck(prospectListBean.mcreditenqpurposetype);
    mapData[TablesColumnFile.mcreditequstage] =	  ifNullCheck(prospectListBean.mcreditequstage);
    mapData[TablesColumnFile.mcreditreporttransdatetype] =	 ifDateNullCheck(prospectListBean.mcreditreporttransdatetype);
    mapData[TablesColumnFile.mcreditreporttransid] =	  ifNullCheck(prospectListBean.mcreditreporttransid);
    mapData[TablesColumnFile.mcreditrequesttype] =	  ifNullCheck(prospectListBean.mcreditrequesttype);
    mapData[TablesColumnFile.mcreateddt] =	  ifDateNullCheck(prospectListBean.mcreateddt);
    mapData[TablesColumnFile.mcreatedby] =	  ifNullCheck(prospectListBean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] =	  ifDateNullCheck(prospectListBean.mlastupdatedt);
    mapData[TablesColumnFile.mlastupdateby] =	  ifNullCheck(prospectListBean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] =	  ifNullCheck(prospectListBean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] =	  ifNullCheck(prospectListBean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] =	  ifNullCheck(prospectListBean.mgeologd);
    mapData[TablesColumnFile.mlastsynsdate] =	DateTime.now().toIso8601String();
    mapData[TablesColumnFile.mstreet] =	  ifNullCheck(prospectListBean.mstreet);
    mapData[TablesColumnFile.mhouse] =	  ifNullCheck(prospectListBean.mhouse);
    mapData[TablesColumnFile.mcity] =	  ifNullCheck(prospectListBean.mcity);
    mapData[TablesColumnFile.mstate] =	  ifNullCheck(prospectListBean.mstate);
    mapData[TablesColumnFile.mid1] =	  ifNullCheck(prospectListBean.mid1);
    mapData[TablesColumnFile.mid1desc] =	  ifNullCheck(prospectListBean.mid1desc);
    mapData[TablesColumnFile.motp] =	  prospectListBean.motp==null?0:prospectListBean.motp;
    mapData[TablesColumnFile.mroutedto] =	  ifNullCheck(prospectListBean.mroutedto);
    mapData[TablesColumnFile.miscustcreated] =	  prospectListBean.miscustcreated==null?0:prospectListBean.miscustcreated;
    jsonList.add(mapData);


  }




  String ifNullCheck(String value){
    if(value==null || value == 'null'){
      value = "";
    }
    return value;
  }

  String ifDateNullCheck(DateTime value){
    if(value==null || value == 'null'){
      return null;
    }
    else {
      return  value.toIso8601String();
    }

  }

}


class  CustomerCheckBean{

  String mlongname;
  String mpannodesc;
  String mIdDesc;
  int mlbrcode;
  int mcustno;
  DateTime mdob;
  String mfname;
  String mmname;
  String mlname;
  int  mcenterid;
  String merrormessage;
  int mrefno;
  int trefno;


  CustomerCheckBean({this.mlongname, this.mpannodesc, this.mIdDesc,
      this.mlbrcode,this.mcustno,this.mdob,this.mfname,this.mmname,this.mlname,this.mcenterid,this.merrormessage});

  factory CustomerCheckBean.fromMap(Map<String, dynamic> map,bool isTrue) {
    return CustomerCheckBean(
        mlongname: map[TablesColumnFile.mlongname] as String,
        mpannodesc: map[TablesColumnFile.mpannodesc] as String,
        mIdDesc: map[TablesColumnFile.mIdDesc] as String,
        mlbrcode:map[TablesColumnFile.lbrCode] as int,
      mcustno:map[TablesColumnFile.mcustno] as int,
      mdob:(map[TablesColumnFile.mdob]=="null"||map[TablesColumnFile.mdob]==null)?null:DateTime.parse(map[TablesColumnFile.mdob]) as DateTime,
      mfname: map[TablesColumnFile.mfname] as String,
      mmname: map[TablesColumnFile.mmname] as String,
      mlname: map[TablesColumnFile.mlname] as String,
      mcenterid : map[TablesColumnFile.mcenterid] as int,
      merrormessage:map [TablesColumnFile.merrormessage] as String
    );}


}