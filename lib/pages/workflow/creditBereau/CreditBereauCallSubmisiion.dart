import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/app_constant.dart' as constant;
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/address/FullScreenDialogForStateSelection.dart';
import 'package:eco_mfi/pages/workflow/address/beans/StateDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterFormationMasterListViewBean.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterFormationMasterSubmissionBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/CenterFormationSubmissionService.dart';
import 'dart:async';


import 'package:barcode_scan/barcode_scan.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CreditBereauBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/ProspectView.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/SMSVerification.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart' as xml;
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/Verhoeff.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'dart:math';

class CreditBereauCallSubmisiion extends StatefulWidget {
  final CreditBereauBean CreditBeareauPassedObject;

  CreditBereauCallSubmisiion(
      {Key key, @required this.CreditBeareauPassedObject})
      : super(key: key);

  @override
  _CreditBereauCallSubmisiionState createState() =>
      new _CreditBereauCallSubmisiionState();
}

class _CreditBereauCallSubmisiionState
    extends State<CreditBereauCallSubmisiion> {
  static int que = 0;
  static bool flag = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  FullScreenDialogForStateSelection _myStateDialog =
  new FullScreenDialogForStateSelection();
  static const JsonCodec JSON = const JsonCodec();
  CreditBereauBean beanObj = new CreditBereauBean();
  CreditBereauBean cbb2 = new CreditBereauBean();
  bool circIndicatorContact = false;
  bool resendOtp = false;
  bool circIndicatorOTP = false;
  int otp;
  int tempOtp;
  int OTPVerified;
  bool verifyBtn = true;
  bool OTPMatched = false;
  var SMSVerURL = 'https://api.textlocal.in/send/?';
  bool boolValidate = false;
  SharedPreferences prefs;
  String agentUserCode;
  String tempYear ;
  String tempDay ;
  String tempMonth;
  FocusNode monthFocus;
  FocusNode yearFocus;
  String applicantDob ="__-__-____" ;
  String tempDate = "----/--/--";
  Utility obj = new Utility();
  bool otpFieldEnabled = true;
  LookupBeanData relationship;
  LookupBeanData idType1;
  StateDropDownList tempStateBean = new StateDropDownList();

  TextEditingController _useCtrl = new TextEditingController();
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy");
  var formatter = new DateFormat('yyyy-MM-dd');

  static final _headers = {'Content-Type': 'application/x-www-form-urlencoded'};

  var _focusNode = new FocusNode();

  @override
  void initState() {

    monthFocus = new FocusNode();
    yearFocus = new FocusNode();
    print("xxxxxxxxxxxxxxxinit statexxxxxxxxxxxxxxxx");
    super.initState();


    _focusNode.addListener(onChangeFocus);
    if (widget.CreditBeareauPassedObject != null) {


      print(widget.CreditBeareauPassedObject);
      beanObj  =widget.CreditBeareauPassedObject;
      mapBean();
      OTPVerified = widget.CreditBeareauPassedObject.motpverified;

      if(widget.CreditBeareauPassedObject.mdob.day.toString().length==1)tempDay = "0"+widget.CreditBeareauPassedObject.mdob.day.toString();
      else tempDay = widget.CreditBeareauPassedObject.mdob.day.toString();

      if(widget.CreditBeareauPassedObject.mdob.month.toString().length==1)tempMonth = "0"+widget.CreditBeareauPassedObject.mdob.month.toString();
      else tempMonth = widget.CreditBeareauPassedObject.mdob.month.toString();

      applicantDob = applicantDob.replaceRange(0, 2, tempDay);

      applicantDob = applicantDob.replaceRange(3, 5, tempMonth);
      print("applicant DOB = ${applicantDob}");
      applicantDob = applicantDob.replaceRange(6, 10,widget.CreditBeareauPassedObject.mdob.year.toString());



      String tempApplicantdob = applicantDob;
      print(tempApplicantdob.substring(6)+"-"+tempApplicantdob.substring(3,5)+"-"+tempApplicantdob.substring(0,2));
      DateTime  formattedDate =  DateTime.parse(tempApplicantdob.substring(6)+"-"+tempApplicantdob.substring(3,5)+"-"+tempApplicantdob.substring(0,2));
      print(formattedDate);
      tempDay = formattedDate.day.toString();
      print(tempDay);
      tempMonth = formattedDate.month.toString();
      print(tempMonth);
      tempYear = formattedDate.year.toString();
      print(tempYear);
      setState(() {

      });

      List<String> tempDropDownValues = new List<String>();
      tempDropDownValues
          .add(widget.CreditBeareauPassedObject.mnomineerelation);
      tempDropDownValues
          .add(widget.CreditBeareauPassedObject.mid1);

      for (int k = 0;
      k < globals.dropdownCaptionsValuesProspectInf.length;
      k++) {
        for (int i = 0;
        i < globals.dropdownCaptionsValuesProspectInf[k].length;
        i++) {
          if (globals.dropdownCaptionsValuesProspectInf[k][i].mcode ==
              tempDropDownValues[k]) {
            setValue(k, globals.dropdownCaptionsValuesProspectInf[k][i]);
          }
        }
      }



      print(beanObj);
    } else {
      getUsrCodeBranchCode();

      AppDatabase.get().getMaxTrefNo().then((val) {
        setState(() {

          beanObj.trefno = val;
        });
      });
      beanObj.miscustcreated= 0;
      beanObj.motpverified = 0;
      beanObj.mrefno = 0;
      beanObj.missynctocoresys = 0;
      beanObj.mprospectstatus = 0;
    }


    setState(() {});
  }


  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);
  showDropDown(LookupBeanData selectedObj, int no) {

    print("selected obj is ${selectedObj}");

    if(selectedObj.mcodedesc.isEmpty){
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          relationship = blankBean;
          //beanObj.mnomineerelation = blankBean.mcode;
          break;
        case 1:
          idType1 = blankBean;
          // beanObj.mid1 = blankBean.mcode;
          break;
        default:
          break;
      }
      setState(() {

      });
    }


    else{
      bool isBreak = false;
      for (int k = 0;
      k < globals.dropdownCaptionsValuesProspectInf[no].length;
      k++) {
        if (globals.dropdownCaptionsValuesProspectInf[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesProspectInf[no][k]);
          isBreak=true;
          break;
        }
        /*if(isBreak){
          break;
        }*/
      }
    }







  }

  setValue(int no, LookupBeanData value) {


    setState(() {
      print("coming here");
      print(no);
      switch (no) {
        case 0:
          relationship = value;
          beanObj.mnomineerelation = value.mcode;
          break;
        case 1:
          idType1 = value;
          beanObj.mid1 = value.mcode;
          break;
        default:
          break;
      }
    });
  }

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    mapData.add(blankBean);
    for (int k = 0;
    k < globals.dropdownCaptionsValuesProspectInf[no].length;
    k++) {
      mapData.add(globals.dropdownCaptionsValuesProspectInf[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      print("data here is of  dropdownwale biayajai " + value.mcodedesc);
      print("data  " + value.mcode);

      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc),
      );
    }).toList();
    /*   if(no==0){
      print(mapData);
      testString = mapData;
    }*/
    return _dropDownMenuItems1;
  }











  mapBean()async {
    /* beanObj.trefno= widget.CreditBeareauPassedObject.trefno;
    beanObj.mrefno=	widget.CreditBeareauPassedObject.mrefno;
    beanObj.mlbrcode=	 widget.CreditBeareauPassedObject.mlbrcode;
    beanObj.mqueueno=	 widget.CreditBeareauPassedObject.mqueueno;
    beanObj.maadharno=		 widget.CreditBeareauPassedObject.maadharno;
    beanObj.mprospectdt=	 widget.CreditBeareauPassedObject.mprospectdt;
    beanObj.mnametitle=	 widget.CreditBeareauPassedObject.mnametitle;
    beanObj.mprospectname=		 widget.CreditBeareauPassedObject.mprospectname;
    beanObj.mmobno=	 widget.CreditBeareauPassedObject.mmobno;
    beanObj.mdob=		 widget.CreditBeareauPassedObject.mdob;
    beanObj.motpverified=		 widget.CreditBeareauPassedObject.motpverified;
    beanObj.mcbcheckstatus=		 widget.CreditBeareauPassedObject.mcbcheckstatus;
    beanObj.mprospectstatus=		 widget.CreditBeareauPassedObject.mprospectstatus;
    beanObj.madd1=	 widget.CreditBeareauPassedObject.madd1;
    beanObj.madd2=	 widget.CreditBeareauPassedObject.madd2;
    beanObj.madd3=	 widget.CreditBeareauPassedObject.madd3;
    beanObj.mhomeloc=	 widget.CreditBeareauPassedObject.mhomeloc;
    beanObj.mareacd=		 widget.CreditBeareauPassedObject.mareacd;
    beanObj.mvillage=	 widget.CreditBeareauPassedObject.mvillage;
    beanObj.mdistcd=	  widget.CreditBeareauPassedObject.mdistcd;
    beanObj.mstatecd=	 widget.CreditBeareauPassedObject.mstatecd;
    beanObj.mcountrycd=		 widget.CreditBeareauPassedObject.mcountrycd;
    beanObj. mpincode=		 widget.CreditBeareauPassedObject. mpincode;
    beanObj. mcountryoforigin=	 widget.CreditBeareauPassedObject. mcountryoforigin;
    beanObj.mnationality=	 widget.CreditBeareauPassedObject.mnationality;
    beanObj.mpanno=	 widget.CreditBeareauPassedObject.mpanno;
    beanObj. mpannodesc= widget.CreditBeareauPassedObject.mpannodesc;
    beanObj. misuploaded=	 widget.CreditBeareauPassedObject.misuploaded;
    beanObj.mspousename=	 widget.CreditBeareauPassedObject.mspousename;
    beanObj.mspouserelation=	widget.CreditBeareauPassedObject.mspouserelation;
    beanObj.mnomineename=	 widget.CreditBeareauPassedObject.mnomineename;
    beanObj.mnomineerelation=		 widget.CreditBeareauPassedObject.mnomineerelation;
    beanObj.mcreditenqpurposetype= widget.CreditBeareauPassedObject.mcreditenqpurposetype;
    beanObj.mcreditequstage=	 widget.CreditBeareauPassedObject.mcreditequstage;
    beanObj.mcreditreporttransdatetype=		 widget.CreditBeareauPassedObject.mcreditreporttransdatetype;
    beanObj.mcreditreporttransid=		widget.CreditBeareauPassedObject.mcreditreporttransid;
    beanObj. mcreditrequesttype=	 widget.CreditBeareauPassedObject.mcreditrequesttype;
    beanObj.mcreateddt=	 widget.CreditBeareauPassedObject.mcreateddt;
    beanObj. mcreatedby=	 widget.CreditBeareauPassedObject. mcreatedby;
    beanObj.mgeolocation=		widget.CreditBeareauPassedObject.mgeolocation;
    beanObj.mgeolatd=	 widget.CreditBeareauPassedObject.mgeolatd;
    beanObj.mgeologd=		widget.CreditBeareauPassedObject.mgeologd;
    beanObj. missync=			widget.CreditBeareauPassedObject.missync;
    beanObj.mlastsynsdate=	 widget.CreditBeareauPassedObject.mlastsynsdate;
    beanObj.mhouse = widget.CreditBeareauPassedObject.mhouse;
    beanObj.mstreet = widget.CreditBeareauPassedObject.mstreet;
    beanObj.mState = widget.CreditBeareauPassedObject.mState;
  beanObj.mcity  = widget.CreditBeareauPassedObject.mcity;
  beanObj.mid1 = widget.CreditBeareauPassedObject.mid1;
    beanObj.mid1Desc = widget.CreditBeareauPassedObject.mid1Desc;
    beanObj.mcreateddt = widget.CreditBeareauPassedObject.mcreateddt;
    beanObj.mcreatedby = widget.CreditBeareauPassedObject.mcreatedby;

*/
    prefs = await SharedPreferences.getInstance();
    beanObj.mlastupdateby = prefs.get("${TablesColumnFile.usrCode}");
    beanObj.mlastupdatedt = DateTime.now();
    try{

      beanObj.mgeolatd=	 prefs.getDouble(TablesColumnFile.geoLatitude).toString();
      beanObj.mgeologd = prefs.getDouble(TablesColumnFile.geoLongitude).toString();
    }catch(_){

    }

  }




  Future getUsrCodeBranchCode() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      beanObj.mlbrcode = prefs.getInt(TablesColumnFile.musrbrcode);
      beanObj.mcreatedby = prefs.getString(TablesColumnFile.musrcode);
      print("${globals.agentUserName} is the agent username" );
      beanObj.mcreateddt = DateTime.now();
      beanObj.mlastupdateby = prefs.get("${TablesColumnFile.usrCode}");
      beanObj.mlastupdatedt = DateTime.now();

    });
  }

  static bool isSubmitClicked = false;
  String result = "";
  String uidNumber = "";
  String personName = "";
  String gender = "";
  String yearOfBirth = "";
  String co = "";
  String house = "";
  String street = "";
  String landMark = "";
  String loc = "";
  String vtc = "";
  String po = "";
  String dist = "";
  String subdist = "";
  String state = "";
  String pinCode = "";
  String dob = "";
  String addressFinal = "";
  int q = 0;
  int segId = 0;
  String idType2 = "Hello";
  String memberId = "";
  String kendraId = "";
  String nomineeRelationShip = null;
  String contactNumber;
  String id2 = null;
  String branchId = "";
  String spouseName = "";
  bool isNetworkAvailable;
  String nomineeRelation = "";

  TextEditingController co2 = new TextEditingController();

  void showMessage(String message, [MaterialColor color = Colors.grey]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: color != null ? color : null,
        content: new Text(message)));
  }

  void _insertDummies() {
    CreditBereauBean cbbb2 = new CreditBereauBean();
    AppDatabase.get().insertDummyCreditMaster(cbbb2).then((afterLogin) {});
  }

  void onChangeFocus() {
    print("xxxxxxinside onchange Focus");

    if (!_focusNode.hasFocus) {
      final FormState form = _formKey.currentState;

      validateUID(beanObj.mpanno.toString());
    }
  }

  Future deleteLocalDb() async {
    print("deleteing database");
    await AppDatabase.get().deleteDatabase();
  }

  void setPassedData(CreditBereauBean cbb3) {
    setState(() {
      beanObj = cbb3;
    });

    print("Kendra Id is" + beanObj.mlbrcode.toString());
  }

  Future<bool> callDialog() {
    globals.Dialog.onPop(
        context,
        'Are you sure?',
        'Do you want to Exit without saving data',
        "CreditBereauCallSubmission");
    globals.OTP = null;
  }

  @override
  Widget build(BuildContext context) {
    print("build Loaded");
    return new WillPopScope(
        onWillPop: () {
          callDialog();
        },
        child: new Scaffold(
            key: _scaffoldKey,
            appBar: new AppBar(
              elevation: 1.0,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  callDialog();
                },
              ),
              backgroundColor: Color(0xff01579b),
              brightness: Brightness.light,
              title: new Text(
                Translations.of(context).text('Credit_Bereau')
                ,
                //textDirection: TextDirection,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontStyle: FontStyle.normal),
              ),
              /*actions: <Widget>[
                new IconButton(
                    icon: const Icon(
                      Icons.save,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: addProspect),
                new IconButton(
                    icon: const Icon(
                      Icons.cloud_upload,
                      color: Colors.white,
                      size: 22.0,
                    ),
                    onPressed:_insertDummies )
              ],*/
            ),
            body: new SafeArea(
              top: false,
              bottom: false,
              child: new Form(
                  key: _formKey,
                  onWillPop: () {
                    Navigator.of(context).pop();
                  },
                  autovalidate: boolValidate,
                  onChanged: () {
                    final FormState _form2 = _formKey.currentState;
                    _form2.save();
                  },
                  child: SingleChildScrollView(
                      child: new Column(
                        children: <Widget>[
                          Container(
                              decoration:
                              BoxDecoration(color: Constant.mandatoryColor),
                              child: new TextFormField(
                                decoration: const InputDecoration(
                                  hintText: constant.htrefNo,
                                  labelText: constant.trefNo,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  enabled: false,
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      )),
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                                enabled: false,
                                controller: beanObj.trefno == null
                                    ? TextEditingController(text: "")
                                    : TextEditingController(
                                    text: beanObj.trefno.toString()),
                              )),
                          Container(
                              decoration:
                              BoxDecoration(color: Constant.mandatoryColor),
                              child: new Stack(
                                alignment: const Alignment(1.02, 0.0),
                                children: <Widget>[
                                  new TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        hintText: constant.scanUIDQR,
                                        labelText: constant.scanUIDQRHere,
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            decorationColor: Colors.grey),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.green,
                                            )),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.blue,
                                            )),
                                        contentPadding: EdgeInsets.all(20.0),
                                        fillColor: Colors.red,
                                      ),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(12),
                                        //globals.onlyIntNumber,
                                        WhitelistingTextInputFormatter.digitsOnly
                                      ],
                                      enabled:
                                      widget.CreditBeareauPassedObject != null
                                          ? false
                                          : true,
                                      validator: (String arg) {

                                    if(arg==null) return "Adhaar must not be null";
                                    if(arg.length!=12) return "Adhaar must 12 char long";
                                    if (validateUID(arg) == false)
                                      return 'Adhaar Not validated';
                                    else
                                      return null;
                                  },
                                  controller: beanObj.mpanno == null
                                      ? TextEditingController(text: "")
                                      : TextEditingController(
                                          text: beanObj.mpanno.toString()),
                                  /*focusNode: _focusNode,*/
                                  onSaved: (val) {
                                    if (val == null || val == "") {
                                    } else {
                                      try {
                                        beanObj.mpanno = val;
                                      } catch (e) {
                                        print("Exception in parsing adhaar No");
                                      }
                                    }
                                  }),
                              new RaisedButton(
                                color: Color(0xff01579b),
                                elevation: 20.0,
                                child: new Text(
                                  constant.bScanQR,
                                  style: TextStyle(color: Colors.white),
                                ),
                                padding: EdgeInsets.only(bottom: 0.0),
                                onPressed: () => _scanQR(),
                              ),
                            ],
                          )),
                      Container(
                          decoration:
                              BoxDecoration(color: Constant.mandatoryColor),
                              child: new TextFormField(
                                decoration: const InputDecoration(
                                  hintText: constant.applicantName,
                                  labelText: constant.scannedUIDQRName,
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      decorationColor: Colors.red),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      )),
                                  contentPadding: EdgeInsets.all(20.0),
                                ),

                                validator: (String arg) {
                                  if (arg.length < 3)
                                    return 'Name must be more than 2 charater';
                                  else if (RegExp(
                                      r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                      .hasMatch(arg)) {
                                    return "no special character allowed";
                                  } else
                                    return null;
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(30),
                                  globals.onlyCharacter
                                ],
                                controller: beanObj.mprospectname == null
                                    ? TextEditingController(text: null)
                                    : TextEditingController(
                                    text: beanObj.mprospectname),
                                onSaved: (val) {
                                  beanObj.mprospectname = val;
                                },
                              )),
                          /* Container(
                          child: new DropdownButtonFormField<String>(
                            items: <String>[
                              "Passport",
                              "Voter ID",
                              "UID",
                              "Others",
                              "Ration Card",
                              "Driving License No",
                              "Pan"
                            ].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            value: beanObj.mid1== null || beanObj.mid1 == "null"
                                ? null
                                : beanObj.mid1,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              labelText: constant.applicantID2,
                            ),
                            onChanged: (values) {
                              setState(() {
                                if (values != null) beanObj.mid1 = values;
                              });
                            },
                          )),*/
                          Container(
                              decoration:
                              BoxDecoration(color: Constant.mandatoryColor),
                              child: new TextFormField(
                                decoration: const InputDecoration(
                                  hintText: constant.houseNumber,
                                  labelText: constant.scanUIDQRHouse,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      )),
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                                validator: (String arg) {
                                  if (arg.length < 1)
                                    return 'House No must Not be Empty';
                                  else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%]')
                                      .hasMatch(arg)) {
                                    return "no special character allowed";
                                  } else
                                    return null;
                                },
                                controller: beanObj.mhouse == null
                                    ? TextEditingController(text: "")
                                    : TextEditingController(
                                    text: "${beanObj.mhouse}"),
                                onSaved: (val) {
                                  beanObj.mhouse = val;
                                },
                              )),
                          Container(
                              decoration:
                              BoxDecoration(color: Constant.mandatoryColor),
                              child: new TextFormField(
                                decoration: const InputDecoration(
                                  hintText: constant.scanUIDQstreet,
                                  labelText: constant.street,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      )),
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                                validator: (String arg) {
                                  if (arg.length < 5)
                                    return 'Address must be more than 4 charater';
                                  else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]')
                                      .hasMatch(arg)) {
                                    return "no special character allowed";
                                  } else
                                    return null;
                                },
                                controller: beanObj.mstreet == null
                                    ? TextEditingController(text: "")
                                    : TextEditingController(
                                    text: "${beanObj.mstreet}"),
                                onSaved: (val) {
                                  beanObj.mstreet = val;
                                },
                              )),
                          Container(
                              decoration:
                              BoxDecoration(color: Constant.mandatoryColor),
                              child: new TextFormField(
                                decoration: const InputDecoration(
                                  hintText: constant.scannedUIDCity,
                                  labelText: constant.applicantCity,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  /*labelStyle: TextStyle(color: Colors.grey),*/
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      )),
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(30),
                                  globals.onlyCharacter
                                ],
                                validator: (String arg) {
                                  if (arg.length < 3)
                                    return 'City must be more than 2 charater';
                                  else if (RegExp(
                                      r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                      .hasMatch(arg)) {
                                    return "no special character allowed";
                                  } else
                                    return null;
                                },
                                controller: beanObj.mcity == null ||
                                    beanObj.mcity == "null"
                                    ? TextEditingController(text: "")
                                    : TextEditingController(text: beanObj.mcity),
                                onSaved: (val) => beanObj.mcity = val,
                              )),
                          /*Container(
                          decoration:
                              BoxDecoration(color: Constant.mandatoryColor),
                          child: new TextFormField(
                            decoration: const InputDecoration(
                              hintText: constant.scannedUIDState,
                              labelText: constant.applicantState,
                              hintStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black,
                              )),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.blue,
                              )),
                              contentPadding: EdgeInsets.all(20.0),
                            ),
                            validator: (String arg) {
                              if (arg.length < 3)
                                return 'State must be more than 2 charater';
                              else if (RegExp(
                                      r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                  .hasMatch(arg)) {
                                return "no special character allowed";
                              } else
                                return null;
                            },
                            controller: beanObj.mstate == null
                                ? TextEditingController(text: "")
                                : TextEditingController(text: beanObj.mstate),
                            onSaved: (val) {

                              beanObj.mstate = val;
                              print("mstate is ${beanObj.mstate}");
                            }
                          )),*/

                      Container(
                        color: Constant.mandatoryColor,
                        child:new ListTile(
                          title: new Text(Translations.of(context).text('State')
                            ,style: TextStyle(color: Colors.grey),),
                          subtitle:
                          beanObj.mstate == null || beanObj.mstate == "null"
                              ? new Text("")
                              : new Text("${beanObj.mstate}",style: TextStyle(color: Colors.black),),
                          onTap: () async {


                                globals.cntryCd ="ET";
                                tempStateBean = await
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (BuildContext context) => _myStateDialog,
                                      fullscreenDialog: true,
                                    ));

                                if(tempStateBean!=null){
                                  beanObj.mstate = tempStateBean.stateDesc;
                                }
                                setState(() {

                                });
                              },
                            ),
                          ),

                          Divider(),



                          Container(
                              decoration:
                              BoxDecoration(color: Constant.mandatoryColor),
                              child: new TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: constant.scannedUIDPincode,
                                    labelText: constant.applicantPincode,
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        )),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        )),
                                    contentPadding: EdgeInsets.all(20.0),
                                  ),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(6),
                                    //globals.onlyIntNumber
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  validator: (String arg) {
                                    if (arg.length != 6)
                                      return 'Pincode must be 6 character long';
                                    else if (RegExp(
                                        r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]')
                                        .hasMatch(arg)) {
                                      return "no special character allowed";
                                    } else if (RegExp(r'[a-zA-Z-]').hasMatch(arg)) {
                                      return "Characters not allowed";
                                    } else
                                      return null;
                                  },
                                  controller: beanObj.mpincode == null
                                      ? TextEditingController(text: "")
                                      : TextEditingController(
                                      text: beanObj.mpincode.toString()),
                                  onSaved: (val) {
                                    if (val == null || val == "") {
                                    } else
                                      beanObj.mpincode = int.parse(val);
                                  })),

                          SizedBox(height: 20.0,),
                          Container(
                            decoration: BoxDecoration(color: Constant.mandatoryColor),
                            child: new Row(

                          children: <Widget>[

                            SizedBox(width: 20.0,),
                            Text(Constant.applicantDOB)],
                        ),
                      ),

                          new Container(
                            decoration: BoxDecoration(color: Constant.mandatoryColor,),



                            child: new Row(
                              children: <Widget>[
                            SizedBox(width: 20.0,),
                                new Container(
                                  width: 50.0,
                                  child: new TextField(
                                      decoration:
                                      InputDecoration(
                                          hintText: Translations.of(context).text('DD')

                                      ),
                                      inputFormatters: [
                                        new LengthLimitingTextInputFormatter(2),
                                        //globals.onlyIntNumber
                                        WhitelistingTextInputFormatter.digitsOnly
                                      ],
                                      controller: tempDay == null?null:new TextEditingController(text: tempDay),
                                      keyboardType: TextInputType.numberWithOptions(),

                                      onChanged: (val){

                                        if(val!="0"){
                                          tempDay = val;


                                          if(int.parse(val)<=31&&int.parse(val)>0){



                                            if(val.length==2){
                                              applicantDob = applicantDob.replaceRange(0, 2, val);
                                              FocusScope.of(context).requestFocus(monthFocus);
                                            }
                                            else{
                                              applicantDob = applicantDob.replaceRange(0, 2, "0"+val);
                                            }


                                          }
                                          else {
                                            setState(() {
                                              tempDay ="";
                                            });

                                          }


                                        }
                                      }

                                  ),

                                )
                                ,


                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text("/"),
                                ),
                                new Container(
                                  width: 50.0,
                                  child: new TextField(
                                    decoration: InputDecoration(
                                      hintText: Translations.of(context).text('MM'),


                                    ),

                                    keyboardType: TextInputType.numberWithOptions(),
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(2),
                                      //globals.onlyIntNumber
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    focusNode: monthFocus,
                                    controller: tempMonth == null?null:new TextEditingController(text: tempMonth),
                                    onChanged: (val){
                                      if(val!="0"){
                                        tempMonth = val;
                                        if(int.parse(val)<=12&&int.parse(val)>0){

                                          if(val.length==2){
                                            applicantDob = applicantDob.replaceRange(3, 5, val);

                                            FocusScope.of(context).requestFocus(yearFocus);
                                          }
                                          else{
                                            applicantDob = applicantDob.replaceRange(3, 5, "0"+val);
                                          }
                                        }
                                        else {
                                          setState(() {
                                            tempMonth ="";
                                          });

                                        }
                                      }



                                    },

                                  ),
                                )
                                ,
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text("/"),
                                ),

                                Container(
                                  width:80,

                                  child:new TextField(


                                    decoration: InputDecoration(
                                      hintText: Translations.of(context).text('YYYY'),

                                    ),

                                    keyboardType: TextInputType.numberWithOptions(),
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(4),
                                      //globals.onlyIntNumber
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],


                                    focusNode: yearFocus,
                                    controller: tempYear == null?null:new TextEditingController(text: tempYear),
                                    onChanged: (val){
                                      tempYear = val;
                                      if(val.length==4) applicantDob = applicantDob.replaceRange(6, 10,val);

                                    },
                                  ),)
                                ,

                                SizedBox(
                                  width: 50.0,
                                ),

                                IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                                  _selectDate(context);
                                } )
                              ],


                            ),

                          ),




                          Container(
                              decoration:
                              BoxDecoration(color: Constant.mandatoryColor),
                              child: widget.CreditBeareauPassedObject != null
                                  ? new TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: constant.contactNo,
                                  labelText: constant.contactNo,
                                  prefixText: constant.mobNoPrefix,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      )),
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                  globals.onlyIntNumber
                                ],
                                controller: beanObj.mmobno == null
                                    ? TextEditingController(text: "")
                                    : TextEditingController(
                                    text: beanObj.mmobno.toString()),
                                enabled: false,
                                validator: (String arg) {
                                  if (arg.length != 10)
                                    return 'Mobile No must be of 10 charater';
                                  else if (RegExp(
                                      r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]')
                                      .hasMatch(arg)) {
                                    return "no special character allowed";
                                  } else if (RegExp(r'[a-zA-Z-]')
                                      .hasMatch(arg)) {
                                    return "Characters not allowed";
                                  } else
                                    return null;
                                },
                                onSaved: (val) {
                                  if (val == null || val == "") {
                                  } else
                                    beanObj.mmobno = int.parse(val);
                                },
                              )
                                  : new Stack(
                                alignment: const Alignment(0.8, 0.0),
                                children: <Widget>[
                                  new TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: constant.contactNo,
                                      labelText: constant.contactNo,
                                      prefixText: constant.mobNoPrefix,
                                      hintStyle:
                                      TextStyle(color: Colors.grey),
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.blue,
                                          )),
                                      contentPadding: EdgeInsets.all(20.0),
                                    ),
                                    controller: beanObj.mmobno == null
                                        ? TextEditingController(text: "")
                                        : TextEditingController(
                                        text: beanObj.mmobno.toString()),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                      //globals.onlyIntNumber
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    validator: (String arg) {
                                      if (arg.length != 10)
                                        return 'Mobile No must be of 10 charater';
                                      else if (RegExp(
                                          r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]')
                                          .hasMatch(arg)) {
                                        return "no special character allowed";
                                      } else if (RegExp(r'[a-zA-Z-]')
                                          .hasMatch(arg)) {
                                        return "Characters not allowed";
                                      } else
                                        return null;
                                    },
                                    onSaved: (val) {
                                      if (val == null || val == "") {
                                      } else
                                        try {
                                          beanObj.mmobno = int.parse(val);
                                        } catch (e) {
                                          print("val");
                                        }
                                    },
                                  ),
                                  new Container(
                                      child: circIndicatorContact == true
                                          ? CircularProgressIndicator()
                                          : new RaisedButton(
                                        color: Color(0xff01579b),
                                        elevation: 20.0,
                                        child: resendOtp == false
                                            ? new Text(
                                          constant.bGenerateOtp,
                                          style: TextStyle(
                                              color:
                                              Colors.white),
                                        )
                                            : new Text(
                                          constant.bResendOtp,
                                          style: TextStyle(
                                              color:
                                              Colors.white),
                                        ),
                                        padding: EdgeInsets.only(
                                            bottom: 0.0),
                                        onPressed: () {
                                          if (beanObj.mmobno
                                              .toString()
                                              .length !=
                                              10) {
                                            print(beanObj.mmobno
                                                .toString()
                                                .length);
                                            showMessage(
                                                constant.entrVldNum);
                                          } else
                                            _generateOTP();
                                        },
                                      )),
                                ],
                              )),
                          new Container(
                            child: widget.CreditBeareauPassedObject != null
                                ? null
                                : new Stack(
                              alignment: const Alignment(0.8, 0.0),
                              children: <Widget>[
                                new TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: constant.enterOTP,
                                    labelText: constant.OTP1,
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        )),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        )),
                                    contentPadding: EdgeInsets.all(20.0),
                                  ),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(4),
                                    // globals.onlyIntNumber
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  enabled: otpFieldEnabled,
                                  controller: _useCtrl,
                                  onSaved: (val) {
                                    if (val == null || val == "") {
                                    } else
                                      otp = int.parse(val);
                                  },
                                ),
                                new Container(
                                    child: verifyBtn == false
                                        ? new Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                        : new RaisedButton(
                                      color: Color(0xff01579b),
                                      elevation: 20.0,
                                      child: new Text(constant.bVerify,
                                          style: TextStyle(
                                              color: Colors.white)),
                                      padding:
                                      EdgeInsets.only(bottom: 0.0),
                                      onPressed: () {
                                        if (globals.OTP == null) {
                                          showMessage(constant
                                              .generateOTPfirst);
                                        } else{
                                          _verify();

                                        }

                                      },
                                    ))
                              ],
                            ),
                          ),
                          new TextFormField(
                            decoration: const InputDecoration(
                              hintText: constant.enterSpouseNameHere,
                              labelText: constant.spouseName,
                              hintStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  )),
                              contentPadding: EdgeInsets.all(20.0),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30),
                              globals.onlyCharacter
                            ],
                            validator: (String arg) {
                              if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                  .hasMatch(arg)) {
                                return "no special character  or numbers allowed";
                              } else
                                return null;
                            },
                            controller: beanObj.mspousename == null
                                ? TextEditingController(text: "")
                                : TextEditingController(text: beanObj.mspousename),
                            onSaved: (val) => beanObj.mspousename = val,
                          ),
                          Container(
                              decoration:
                              BoxDecoration(color: Constant.mandatoryColor),
                              child: new TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: constant.enterNomineeHere,
                                    labelText: constant.nomineeName,
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        )),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        )),
                                    contentPadding: EdgeInsets.all(20.0),
                                  ),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(30),
                                    globals.onlyCharacter
                                  ],
                                  validator: (String arg) {
                                    if (arg.length < 3)
                                      return 'Nominee name must be more than 2 charater';
                                    else if (RegExp(
                                        r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                        .hasMatch(arg)) {
                                      return "no special character allowed";
                                    } else
                                      return null;
                                  },
                                  controller: beanObj.mnomineename == null
                                      ? TextEditingController(text: "")
                                      : TextEditingController(
                                      text: beanObj.mnomineename),
                                  onSaved: (val) {
                                    beanObj.mnomineename = val;


                                  }
                              )),
                          /*Container(
                          decoration:
                              BoxDecoration(color: Constant.mandatoryColor),
                          child: new DropdownButtonFormField<String>(
                            items: <String>[
                              'Father',
                              'Husband',
                              'Mother'
                                  'Son',
                              'Daughter',
                              'Wife',
                              'Brother',
                              'Mother-In-law',
                              'Father-In-law',
                              'Daughter-In-law',
                              'Sister-In-Law',
                              'Son-In-Law',
                              'Brother-In-law',
                              'Others'
                            ].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            value: beanObj.mnomineerelation,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              labelText: constant.nomineeRelation,
                            ),
                            validator: (String val) {
                              if (val == null || val == "") {
                                return "Relationship Selection is mandatory";
                              } else
                                return null;
                            },
                            onChanged: (String values) {
                              setState(() {
                                beanObj.mnomineerelation = values;
                              });
                            },
                          )),*/


                          Container(
                            color: Constant.mandatoryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),

                              child: new DropdownButtonFormField(
                                value: relationship,
                                items: generateDropDown(0),

                                onChanged: (LookupBeanData newValue) {
                                  showDropDown(newValue, 0);
                                },
                                validator: (args) {
                                  print(args);
                                },
                                //  isExpanded: true,
                                //hint:Text("Select"),
                                decoration: InputDecoration(labelText: Translations.of(context).text('Nominee_Relation')
                                ),
                                // style: TextStyle(color: Colors.grey),
                              ),

                            ),
                          ),
                          Container(
                              decoration:
                              BoxDecoration(color: Constant.mandatoryColor),
                              child: new TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: constant.enterBranchId,
                                  labelText: constant.branchId,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      )),
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(30),
                                  globals.onlyIntNumber
                                ],

                                validator: (String arg) {
                                  if (arg==null)
                                    return 'Branch id must not be null try login again';
                                  else
                                    return null;
                                },
                                enabled: false,
                                controller: new TextEditingController(
                                    text: "${beanObj.mlbrcode}"),
                              )),
                          Container(
                              decoration:
                              BoxDecoration(color: Constant.mandatoryColor),
                              child: new TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: constant.enterMemberId,
                                  labelText: constant.memberId,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      )),
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                                enabled: false,
                                validator: (String arg) {
                                  if (arg==null)
                                    return 'Member id must not be null try login again';
                                  else
                                    return null;
                                },
                                controller: new TextEditingController(
                                    text: beanObj.mcreatedby),
                              )),
                          /* Container(
                        decoration: BoxDecoration(
                          color: Constant.mandatoryColor
                        ),
                          child: new DropdownButtonFormField<String>(
                        items: <String>[
                          "Passport",
                          "Voter ID",
                          "UID",
                          "Others",
                          "Ration Card",
                          "Driving License No",
                          "Pan"
                        ].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        value: beanObj.mid1== null || beanObj.mid1 == "null"
                            ? null
                            : beanObj.mid1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          labelText: constant.applicantID2,
                        ),
                              validator: (String val) {
                                if (val == null || val == "") {
                                  return "Id Type Selection is mandatory";
                                } else
                                  return null;
                              },
                        onChanged: (values) {
                          setState(() {
                            if (values != null) beanObj.mid1 = values;
                          });
                        },
                      )),*/



                          Container(
                            color: Constant.mandatoryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new DropdownButtonFormField(
                                value: idType1,
                                items: generateDropDown(1),
                                onChanged: (LookupBeanData newValue) {
                                  showDropDown(newValue, 1);
                                },
                                validator: (args) {
                                  print(args);
                                },
                                //  isExpanded: true,
                                //hint:Text("Select"),
                                decoration: InputDecoration(labelText: Translations.of(context).text('Applicant_ID_2')
                                ),
                                // style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(color: Constant.mandatoryColor),
                              child:
                              new TextFormField(
                                decoration: const InputDecoration(
                                  hintText: constant.enterApplicantID2Here,
                                  labelText: constant.applicantID2,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  labelStyle: TextStyle(color: Colors.grey),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                  contentPadding: EdgeInsets.all(20.0),
                                ),

                                controller: beanObj.mid1desc == null
                                    ? TextEditingController(text: "")
                                    : TextEditingController(text: beanObj.mid1desc),
                                onEditingComplete: () {
                                  print("Done");
                                },
                                validator: (String arg) {
                                  if (arg==null)
                                    return 'ID 2 must be mandatory';
                                  else
                                    return null;
                                },

                                onSaved: (val) => beanObj.mid1desc = val,
                              )
                          ),

                          new TextFormField(
                            decoration: const InputDecoration(
                              hintText: constant.enterCreditRequestTypeHere,
                              labelText: constant.creditRequestType,
                              hintStyle: TextStyle(color: Colors.grey),
                              labelStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                              contentPadding: EdgeInsets.all(20.0),
                            ),
                            enabled: false,
                            initialValue: constant.creditRequestTypeVal,
                            inputFormatters: [
                              new LengthLimitingTextInputFormatter(30)
                            ],
                            onSaved: (val) => beanObj.mcreditrequesttype = val,
                          ),
                          new TextFormField(
                            decoration: const InputDecoration(
                              hintText: constant.creditReportTransactionIDHere,
                              labelText: constant.creditReportTransactionID,
                              hintStyle: TextStyle(color: Colors.grey),
                              labelStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                              contentPadding: EdgeInsets.all(20.0),
                            ),
                            enabled: false,
                            initialValue: constant.creditReportTransactionIDVal,
                            inputFormatters: [
                              new LengthLimitingTextInputFormatter(30)
                            ],
                            onSaved: (val) => beanObj.mcreditreporttransid = val,
                          ),
                          new TextFormField(
                            decoration: const InputDecoration(
                              hintText: constant.creditInquiryPurposeTypeHere,
                              labelText: constant.creditInquiryPurposeType,
                              hintStyle: TextStyle(color: Colors.grey),
                              labelStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                              contentPadding: EdgeInsets.all(20.0),
                            ),
                            enabled: false,
                            initialValue: constant.creditInquiryPurposeTypeVal,
                            inputFormatters: [
                              new LengthLimitingTextInputFormatter(30)
                            ],
                            onSaved: (val) => beanObj.mcreditenqpurposetype = val,
                          ),
                          new TextFormField(
                            decoration: const InputDecoration(
                              hintText: constant.creditInquiryStageHere,
                              labelText: constant.creditInquiryStage,
                              hintStyle: TextStyle(color: Colors.grey),
                              labelStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                              contentPadding: EdgeInsets.all(20.0),
                            ),
                            enabled: false,
                            initialValue: constant.creditInquiryStageVal,
                            onSaved: (val) => beanObj.mcreditequstage = val,
                          ),
                          new TextFormField(
                            decoration: const InputDecoration(
                              hintText: constant.creditReportTransactionDateTypeHere,
                              labelText: constant.creditReportTransactionDateType,
                              hintStyle: TextStyle(color: Colors.grey),
                              labelStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                              contentPadding: EdgeInsets.all(20.0),
                            ),
                            enabled: false,
                            initialValue: new DateTime.now().toIso8601String(),
                            keyboardType: TextInputType.number,
                            onSaved: (val) => beanObj.mcreditreporttransdatetype =
                                DateTime.parse(val),
                          ),
                          new Container(
                              padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                              child: new RaisedButton(
                                  child:  Text(
                                    Translations.of(context).text('Save_Prospect')
                                    ,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    if (widget.CreditBeareauPassedObject == null) {
                                      beanObj.misuploaded = 0;
                                      print("chnging is uploaded");
                                      addProspect();
                                    } else {
                                      addProspect();
                                    }
                                  })),
                        ],
                      ))),
            )));
  }

  Future _scanQR() async {
    try {
      var qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
        var document = xml.parse(result);
        print("document is ${document}");
        var textual = document.descendants
            .where((node) => node is xml.XmlText && !node.text.trim().isEmpty)
            .join('\n');
        print("Data here ois " + textual);
        int atrributeLength = document
            .findElements("PrintLetterBarcodeData")
            .elementAt(0)
            .attributes
            .length;
        for (var i = 0; i < atrributeLength; i++) {
          String value = document
              .findElements("PrintLetterBarcodeData")
              .elementAt(0)
              .attributes
              .elementAt(i)
              .toString();
          print("Yes yahi hai woh puri value " + value);
          if (value.contains("uid")) {
            var chk = validateUID(
                value.substring(value.indexOf("\"") + 1, value.length - 1));
            print(chk.toString() + "is the chk");
            if (chk == true) {
              this.uidNumber =
                  value.substring(value.indexOf("\"") + 1, value.length - 1);
              beanObj.mpanno =
                  value.substring(value.indexOf("\"") + 1, value.length - 1);
            } else {
              this.uidNumber = "Not Valid";

              print("consttttttttttttttNOT VALID");
            }

            print("Yes yahi hai woh " + uidNumber);
          }
          if (value.contains("name")) {
            personName =
                value.substring(value.indexOf("\"") + 1, value.length - 1);
            if (personName != null) beanObj.mprospectname = personName;
          }
          if (value.contains("gender")) {
            gender = value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("yob")) {
            yearOfBirth =
                value.substring(value.indexOf("\"") + 1, value.length - 1);
            // beanObj.DOB = DateTime.parse(yearOfBirth);
          }
          if (value.contains("co")) {
            co = value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("house")) {
            house = value.substring(value.indexOf("\"") + 1, value.length - 1);
            if (house != null) beanObj.mhouse = house;
          }
          if (value.contains("street")) {
            street = value.substring(value.indexOf("\"") + 1, value.length - 1);
            if (street != null) beanObj.mstreet = street;
          }
          if (value.contains("lm")) {
            landMark =
                value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("loc")) {
            loc = value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("vtc")) {
            vtc = value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("po")) {
            po = value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("dist")) {
            dist = value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("subdist")) {
            subdist =
                value.substring(value.indexOf("\"") + 1, value.length - 1);
            if (subdist != null) beanObj.mcity = subdist;
          }
          if (value.contains("state")) {
            state = value.substring(value.indexOf("\"") + 1, value.length - 1);
            if (state != null) beanObj.mstate = state;
          }
          if (value.contains("pc")) {
            pinCode =
                value.substring(value.indexOf("\"") + 1, value.length - 1);
            beanObj.mpincode = int.parse(pinCode);
          }
          if (value.contains("dob")) {

            try{
              dob = value.substring(value.indexOf("\"") + 1, value.length - 1);

              if(dob.length==10){


                DateTime  formattedDate =  DateTime.parse(dob.substring(6)+"-"+dob.substring(3,5)+"-"+dob.substring(0,2));
                print(formattedDate);

                if(formattedDate.day.toString().length==1)tempDay = "0"+formattedDate.day.toString();
                else tempDay = formattedDate.day.toString();
                print(tempDay);
                if(formattedDate.month.toString().length==1)tempMonth = "0"+formattedDate.month.toString();
                else tempMonth = formattedDate.month.toString();
                print(tempMonth);
                tempYear = formattedDate.year.toString();
                print(tempYear);
                /*String tempDay2="";
              String tempMonth2="";

              if(tempDay.length==1)tempDay2 = "0"+tempDay.toString();
              else tempDay2 = tempDay;

              if(tempMonth.length==1)tempMonth2 = "0"+tempMonth.toString();
              else tempMonth2 = tempMonth;*/
                print("applicant is " +applicantDob.toString());

                applicantDob = applicantDob.replaceRange(0, 2, tempDay);

                print(applicantDob);
                applicantDob = applicantDob.replaceRange(3, 5, tempMonth);

                print(applicantDob);
                applicantDob = applicantDob.replaceRange(6, 10,tempYear);

                print(applicantDob);
                print("applicant DOB  kiks = ${applicantDob}");


              }
            }catch(e){
              print("Date time parsing error");
            }
          }
        }
        addressFinal = co +
            ", " +
            house +
            ", " +
            street +
            ", " +
            landMark +
            ", " +
            loc +
            ", " +
            vtc +
            ", " +
            po +
            ", " +
            dist +
            ", " +
            subdist +
            ", " +
            state +
            ", " +
            pinCode;
        print("Data here UID is  " +
            uidNumber +
            " " +
            personName +
            " " +
            gender +
            " " +
            yearOfBirth +
            " " +
            co +
            " " +
            house +
            " " +
            street +
            " " +
            landMark +
            " " +
            loc +
            " " +
            vtc +
            " " +
            po +
            " " +
            dist +
            " " +
            subdist +
            " " +
            state +
            " " +
            pinCode +
            " " +
            dob);
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  bool validateUID(uid) {
    Verhoeff vObj = new Verhoeff();
    bool result = vObj.validateVerhoeff(uid);
    print(result);
    if (result == true) {
      uidNumber = uid;
    }

    /*_scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
            result == true ? "Adhar Validated" : "Adhaar Not Validated")));*/

    return result;
  }

  void addProspect() {
    final FormState form = _formKey.currentState;

    if(beanObj.mnomineerelation==null||beanObj.mnomineerelation=="") {
      showInSnackBar('please select a nominee relation');
      return;
    }

    else if(beanObj.mid1==null||beanObj.mid1==""){


      showInSnackBar('id Type 1 is mandatory');
      return;
    }
    else if(beanObj.mid1desc==null||beanObj.mid1desc==""){
      showInSnackBar('Applicant ID 2 is mandatory');
      return;
    }





    try{
      beanObj.mdob = DateTime.parse(applicantDob.substring(6)+"-"+applicantDob.substring(3,5)+"-"+applicantDob.substring(0,2));
    }catch( e){
      print(e);
      showMessage("Date Format not right");
      return;

    }

    if (form.validate()) {
      form.save();
      _performSave();
    } else {
      setState(() => boolValidate = true);
      showInSnackBar('Please fix the errors in red before submitting.');
    }
  }

  Future _performSave() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    if(beanObj.mcreatedby==null||beanObj.mcreatedby=='null'){
      beanObj.mcreatedby = prefs2.getString(TablesColumnFile.musrcode);
    }
    if(beanObj.mlastupdateby==null||beanObj.mlastupdateby=='null'){
      beanObj.mlastupdateby = prefs2.getString(TablesColumnFile.musrcode);
    }
    await _trySave();
    if (widget.CreditBeareauPassedObject == null) {
      _successfulSubmit(beanObj.mprospectname);
    } else {
      _processSuccessfull(beanObj.mprospectname);
    }
  }

  Future<void> _trySave() async {


    if(beanObj.motpverified == 0&&tempOtp != null)beanObj.motp = tempOtp;

   /* beanObj.motpverified =1;
    beanObj.motp=1234;*/
    await AppDatabase.get().updateCreditBereauMaster(beanObj).then((value) {});
  }

  Future<void> _generateOTP() async {
    bool res = true;
    setState(() {
      resendOtp = true;
      circIndicatorContact = true;
    });
    showInSnackBar("Sending OTP");
    res = await _tryPostSmsOtp(beanObj.mmobno);

    setState(() {
      circIndicatorContact = false;
    });
  }

  void _verify()  {
    print("Inside verify");


    if (globals.OTP == otp) {
      print("Matched");
      showInSnackBar("OTP Matched", Colors.green);
      beanObj.motp = otp;
      beanObj.motpverified = 1;
      print("Changing otpVerified  to ${beanObj.motpverified}");
      globals.OTP=null;
      otpFieldEnabled = false;
      OTPMatched = true;
      setState(() {
        verifyBtn = false;
      });
    } else {
      showInSnackBar("OTP Not Matched", Colors.red);
      _useCtrl.text = "";
    }
  }

  void showInSnackBar(String value, [Color color]) {
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: color != null ? color : null,
    ));
  }

  Future<bool> _tryPostSmsOtp(int contactNo) async {
    bool isNetworkAvailable;

    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();

    if (isNetworkAvailable) {
      await postSms(contactNo).then((value) {
      });
    } else {
      showInSnackBar("Network Not Available");
      return false;
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != beanObj.mdob)
      setState(() {
        beanObj.mdob= picked;
        tempDate = formatter.format(picked);
        if(picked.day.toString().length==1){
          tempDay = "0"+picked.day.toString();

        }
        else tempDay = picked.day.toString();
        applicantDob = applicantDob.replaceRange(0, 2, tempDay);
        tempYear = picked.year.toString();
        applicantDob = applicantDob.replaceRange(6, 10,tempYear);
        if(picked.month.toString().length==1){
          tempMonth = "0"+picked.month.toString();
        }
        else
          tempMonth = picked.month.toString();
        applicantDob = applicantDob.replaceRange(3, 5, tempMonth);

      });
  }

  Future<void> postSms(int contactNo) async {
    var parsed;
    try {
      var rng = new Random();
      OTP = (rng.nextDouble() * 9000 + 1000).toInt();
      print("Creating Response");
      String body1 =
          'apiKey=Vlsq0LknQoo-WOAGuq3V7jyucsWvr2hfPgW6mdSeh5&numbers=91${contactNo}&sender=SAIJAF&message=${OTP}';
      final response =
      await http.post(Uri.encodeFull(SMSVerURL),
          body: body1, headers: _headers);

      print("Response Created");
      print(response);
      print(response.statusCode);

      String res = response.body;

      var res2 = res.split(",");
      for (var items in res2) {
        print(items);
      }

      if (response.statusCode == 200) {
        print("trying to cast Data");
        parsed = json.decode(res);
        print(parsed);
        OTPResponse obj = OTPResponse.fromMap(parsed);
        globals.OTP = int.parse(obj.message.content);
        tempOtp = int.parse(obj.message.content);
        print("Trying to map Data");
        print(obj);
        print("Object Mapped");
        showInSnackBar(" OTP Sent ");
      }
    } catch (e) {
      print('Server Exception!!!');

      try {
        print("inside 2 nd try");
        OTPResponseWarning warn = OTPResponseWarning.fromMap(parsed);
        print(warn.warnings[0]);
        showInSnackBar(" ${warn.warnings[0].message} ");
      } catch (e) {
        showInSnackBar("Server not responding");
      }
      print(e.toString() + "  is the exception");
    }
  }

  Future<void> _successfulSubmit(String applicantName) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(Translations.of(context).text('Prospect_Created_Named')+applicantName
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  globals.OTP = null;
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new ProspectView()));
                },
              ),
            ],
          );
        });
  }

  Future<void> _processSuccessfull(String applicantName) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(Translations.of(context).text('Modification_Done_For_Named')+applicantName),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                        new ProspectView()), //When Authorized Navigate to the next screen
                  );
                },
              ),
            ],
          );
        });
  }
}

class OTPResponse {
  int balance;
  int batch_id;
  int cost;
  Message message;

  //json message;
  String receipt_url;
  String custom;
  List<Messages> messages = new List<Messages>();

  OTPResponse(
      {this.balance,
        this.batch_id,
        this.cost,
        this.receipt_url,
        this.custom,
        this.messages,
        this.message});

  factory OTPResponse.fromMap(Map<String, dynamic> map) {
    print(map["message"]);
    print("inside map");

    return OTPResponse(
        balance: map["balance"] as int,
        batch_id: map["batch_id"] as int,
        cost: map["balance"] as int,
        message: Message.fromMap(map["message"]),
        receipt_url: map["receipt_url"] as String,
        messages:
        map["messages"].map<Messages>((i) => Messages.fromMap(i)).toList());
  }

  @override
  String toString() {
    return 'OTPResponse{balance: $balance, batch_id: $batch_id, cost: $cost,message : $message, receipt_url: $receipt_url, custom: $custom, messages: $messages}';
  }
}

class Message {
  int num_parts;
  String sender;
  String content;

  Message({this.num_parts, this.sender, this.content});

  factory Message.fromMap(Map<String, dynamic> map) {
    print("inside map");
    return Message(
      num_parts: map["num_parts"] as int,
      sender: map["sender"] as String,
      content: map["content"] as String,
    );
  }

  @override
  String toString() {
    return 'Message{num_parts: $num_parts, sender: $sender, content: $content}';
  }
}

class Messages {
  String id;
  int recipient;

  Messages({this.id, this.recipient});

  factory Messages.fromMap(Map<String, dynamic> map) {
    print("inside map");
    return Messages(
      id: map["id"] as String,
      recipient: map["recipient"] as int,
    );
  }

  @override
  String toString() {
    return 'Messages{id: $id, recipient: $recipient}';
  }
}

class OTPResponseWarning {
  List<Warnings> warnings = new List<Warnings>();

  OTPResponseWarning({this.warnings});

  @override
  String toString() {
    return 'OTPResponseWarning{warnings: $warnings}';
  }

  factory OTPResponseWarning.fromMap(Map<String, dynamic> map) {
    print(map["warnings"]);
    print("inside map");

    return OTPResponseWarning(
        warnings:
        map["warnings"].map<Warnings>((i) => Warnings.fromMap(i)).toList());
  }
}

class Warnings {
  String message;
  String numbers;

  Warnings({this.message, this.numbers});

  @override
  String toString() {
    return 'Warnings{message: $message, numbers: $numbers}';
  }

  factory Warnings.fromMap(Map<String, dynamic> map) {
    print(map["message"]);
    print("inside map");

    return Warnings(
        message: map["message"] as String, numbers: map["numbers"] as String);
  }
}
