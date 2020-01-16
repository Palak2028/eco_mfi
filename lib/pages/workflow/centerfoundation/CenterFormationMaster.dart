import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/FullScreenDialogForGroupSelection.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/FullScreenDialogForProductSelection.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/LoanUtilization/LoanUtilizationBean.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/FullScreenDialogForCenterSelection.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';


import 'bean/CenterDetailsBean.dart';

class CenterFormationMaster extends StatefulWidget {
  //final savingsListPassedObject;
  //NewAccountOpening({Key key, this.savingsListPassedObject}) : super(key: key);
  final centerDetailsPassedObject ;
  CenterFormationMaster(this.centerDetailsPassedObject);
  @override
  _CenterFormationMasterState createState() => new _CenterFormationMasterState();
}
//CustomerLoanUtilizationBean cusLoanUtilObj = new CustomerLoanUtilizationBean();

class _CenterFormationMasterState extends State<CenterFormationMaster> {
  /*FullScreenDialogForCenterSelection _myCenterDialog =
  new FullScreenDialogForCenterSelection();
  FullScreenDialogForGroupSelection _myGroupDialog =
  new FullScreenDialogForGroupSelection();*/
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TabController _tabController;
  ProductBean prodObj = new ProductBean();
  LookupBeanData status;
  LookupBeanData freezType;
  DateTime selectedDate = DateTime.now();
  DateTime date;
  TimeOfDay time;
  final dateFormat = DateFormat("yyyy/MM/dd");
  var formatter = new DateFormat('dd-MM-yyyy');
  String tempDate = "----/--/--";
  String tempYear ;
  String tempDay ;
  String tempMonth;
  bool boolValidate = false;
  int accountNumber;
  int loanNumber;
  String branch = "";
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;
  FocusNode monthFocus;
  FocusNode yearFocus;
  CenterDetailsBean centerDetailsBean=new CenterDetailsBean();
   bool isNew=false;
  static String firstMeetingDate = "__-__-____";
  String mCenterRepayFromTo="";
  int mCenterRepayFrom=0;
  int mCenterRepayTo=0;
  SystemParameterBean sysBean = new SystemParameterBean();
  String error;

  LookupBeanData centerFrequency;
  LookupBeanData centerMeetingDay;
  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);


  showDropDown(LookupBeanData selectedObj, int no) {

    if(selectedObj.mcodedesc.isEmpty){
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          centerFrequency = blankBean;
          centerDetailsBean.mmeetingfreq = blankBean.mcode;

          break;
        case 1:
          centerMeetingDay = blankBean;
          centerDetailsBean.mmeetingday = 0;
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
      k < globals.dropdownCaptionsValuesCenterFormation[no].length;
      k++) {
        if (globals.dropdownCaptionsValuesCenterFormation[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesCenterFormation[no][k]);
          isBreak=true;
          break;
        }
        if(isBreak){
          break;
        }
      }

    }


  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          centerFrequency = value;
          centerDetailsBean.mmeetingfreq = value.mcode;

          break;
        case 1:
          centerMeetingDay = value;
          centerDetailsBean.mmeetingday = int.parse(value.mcode);
          break;

        default:
          break;
      }
    });
  }

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    //print("caption value : " + globals.dropdownCaptionsPersonalInfo[no]);

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
    k < globals.dropdownCaptionsValuesCenterFormation[no].length;
    k++) {
      mapData.add(globals.dropdownCaptionsValuesCenterFormation[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      print("data here is of  dropdownwale biayajai " + value.mcodedesc);
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

  Future<bool> callDialog() {
    globals.Dialog.onPop(
        context,
        'Are you sure?',
        'Do you want to Go To Center List without saving data',
        "gggggg");
  }


  @override
  void initState() {

    if(widget.centerDetailsPassedObject!=null && widget.centerDetailsPassedObject.trefno!=null && widget.centerDetailsPassedObject.trefno!="null" && widget.centerDetailsPassedObject.trefno!="" && widget.centerDetailsPassedObject.trefno!=null){
      centerDetailsBean.trefno=widget.centerDetailsPassedObject.trefno;
      print("centerDetailsBean.mleadsid"+centerDetailsBean.trefno.toString());
      print("widget.centerDetailsPassedObject.trefno"+widget.centerDetailsPassedObject.trefno.toString());
      centerDetailsBean=widget.centerDetailsPassedObject;
      firstMeetingDate = centerDetailsBean.mfirstmeetngdt.toString();
    }



      getSessionVariables();




    super.initState();
    List<String> tempDropDownValues = new List<String>();
    tempDropDownValues
        .add(centerDetailsBean.mmeetingfreq.toString());
    tempDropDownValues
        .add(centerDetailsBean.mmeetingday.toString());

    if (centerDetailsBean.mEffectiveDt==null||centerDetailsBean.mEffectiveDt=="")
      centerDetailsBean.mEffectiveDt = DateTime.now();

    if (centerDetailsBean.mnextmeetngdt==null||centerDetailsBean.mnextmeetngdt=="")
      centerDetailsBean.mnextmeetngdt = DateTime.now();

    if (!firstMeetingDate.contains("_")) {
      try {
        DateTime formattedDate = DateTime.parse(firstMeetingDate);
        tempDay = formattedDate.day.toString();
        tempMonth = formattedDate.month.toString();
        tempYear = formattedDate.year.toString();
        firstMeetingDate = tempDay.toString() +"-"+tempMonth.toString()+"-"+tempYear.toString();
        setState(() {});
      } catch (e) {
        print("Exception Occupred");
      }
    }

    for (int k = 0;
    k < globals.dropdownCaptionsValuesCenterFormation.length;
    k++) {
      for (int i = 0;
      i < globals.dropdownCaptionsValuesCenterFormation[k].length;
      i++) {


        try{
          if (globals.dropdownCaptionsValuesCenterFormation[k][i].mcode.toString().trim() ==
              tempDropDownValues[k].toString().trim()) {

            print("Matched");
            setValue(k, globals.dropdownCaptionsValuesCenterFormation[k][i]);
          }
        }catch(_){
          print("Exception Occured");

        }
      }
    }

  }




  bool ifNullCheck(String value) {
    bool isNull = false;
    try {
      if (value == null || value == 'null' || value.trim()=='') {
        isNull = true;
      }
    }catch(_){
      isNull =true;
    }
    return isNull;
  }




  Future<Null> getSessionVariables() async {
    if (widget.centerDetailsPassedObject != null) {
      centerDetailsBean = widget.centerDetailsPassedObject;
    } else {
      AppDatabase.get().generateTrefnoForCenterCreation().then((onValue) {
        setState(() {
          centerDetailsBean.trefno = onValue;
        });

      });
    }

    sysBean = await AppDatabase.get().getSystemParameter('CNTRREPAYFROMTO', 0);
    if(sysBean.mcodevalue!=null&&sysBean.mcodevalue.trim() !=''){
      mCenterRepayFromTo = sysBean.mcodevalue;
    }
    List ar  = mCenterRepayFromTo.split("-");
    print("from " + ar[0]);
    print("from " + ar[1]);
    centerDetailsBean.mrepayfrom = int.parse(ar[0]);
    centerDetailsBean.mrepayto   = int.parse(ar[1]);


    setState(() {

    });
    prefs = await SharedPreferences.getInstance();
    setState(() {
      centerDetailsBean.mlbrcode = prefs.get(TablesColumnFile.musrbrcode);
      branch = prefs.get(TablesColumnFile.branch).toString();
      username = prefs.getString(TablesColumnFile.musrcode);
      print("username"+username.toString());
      usrRole = prefs.getString(TablesColumnFile.musrdesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.mgrpcd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.mgeolocation);
      geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
      reportingUser = prefs.getString(TablesColumnFile.mreportinguser);
      print("Center geoLatitude:"+geoLatitude + " geoLongitude:"+geoLongitude);
    });

  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () {
          callDialog();
        },
    child: new Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        elevation: 1.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {callDialog();},
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title: new Text(Constant.newCenterCreation,
          //textDirection: TextDirection,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.normal),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.save,
              color: Colors.white,
              size: 40.0,
            ),
            onPressed: () {
              proceed();
            },
          ),

          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
        ],
      ),
      body: new Form(
        key: _formKey,
        autovalidate: false,
        onWillPop: () {
          return Future(() => true);
        },
        onChanged: () async {
          final FormState form = _formKey.currentState;
          form.save();
          //await calculate();

        },

        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            SizedBox(height: 16.0),
            Card(
              child: new ListTile(
                title: new Text(Constant.centerNumber),
                subtitle:centerDetailsBean.mCenterId==null||centerDetailsBean.mCenterId==""?
                new Text(""):new Text("${centerDetailsBean.mCenterId}"),
              ),
            ),

            SizedBox(height: 16.0),
            new Container(
              color: Constant.mandatoryColor,
              child: new TextFormField(
                  decoration:  InputDecoration(
                    hintText: 'Enter Center Name',
                    labelText: Constant.centerName,
                    hintStyle: TextStyle(color: Colors.grey),
                    /*labelStyle: TextStyle(color: Colors.grey),*/
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(50),
                    globals.onlyCharacter
                  ],
                  controller:centerDetailsBean.mcentername == null
                      ? TextEditingController(text: "")
                      : TextEditingController(
                      text: centerDetailsBean.mcentername)
                  ,
                  /*initialValue:
                  centerDetailsBean.mcentername != null ? centerDetailsBean.mcentername : "",*/

                onSaved: (val) {
                  if(val!=null&&val!=""){
                    try{
                      centerDetailsBean.mcentername = (val);
                    }catch(e){

                    }
                  }

                },),
            ),

            SizedBox(height: 16.0),
            Card(
              child: new ListTile(
                title: new Text(Constant.centerCreationDate),
                subtitle:new Text("${formatter.format(centerDetailsBean.mEffectiveDt)}"),
              ),

            ),

            SizedBox(height: 20.0,),
            Container(
              decoration: BoxDecoration(color: Constant.mandatoryColor),
              child: new Row(

                children: <Widget>[Text(Constant.firstMeetingDate)],
              ),
            ),

            new Container(
              decoration: BoxDecoration(color: Constant.mandatoryColor,),
              child: new Row(
                children: <Widget>[
                  new Container(
                    width: 50.0,
                    child: new TextField(
                        decoration:
                        InputDecoration(
                            hintText: "DD"
                        ),
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(2),
                          globals.onlyIntNumber
                        ],
                        controller: tempDay == null?null:new TextEditingController(text: tempDay),
                        keyboardType: TextInputType.numberWithOptions(),

                        onChanged: (val){
                          if(val!="0"){
                            tempDay = val;
                            if(int.parse(val)<=31&&int.parse(val)>0){
                              if(val.length==2){
                                firstMeetingDate = firstMeetingDate.replaceRange(0, 2, val);
                                FocusScope.of(context).requestFocus(monthFocus);
                              }
                              else{
                                firstMeetingDate = firstMeetingDate.replaceRange(0, 2, "0"+val);
                              }
                            }
                            else {
                              setState(() {
                                tempDay ="";
                              });
                            }
                            if ((tempDay != "" && tempDay != null)  && (tempMonth != '' && tempMonth != null) && (tempYear != '' && tempYear != null)) {
                              if (validateDate(tempDay, tempMonth, tempYear)){
                                setMeetingDay(DateTime.parse(tempYear + "-" + tempMonth + "-" + tempYear));

                              }
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
                        hintText: "MM",
                      ),

                      keyboardType: TextInputType.numberWithOptions(),
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(2),
                        globals.onlyIntNumber
                      ],
                      focusNode: monthFocus,
                      controller: tempMonth == null?null:new TextEditingController(text: tempMonth),
                      onChanged: (val){
                        if(val!="0"){
                          tempMonth = val;
                          if(int.parse(val)<=12&&int.parse(val)>0){

                            if(val.length==2){
                              firstMeetingDate = firstMeetingDate.replaceRange(3, 5, val);

                              FocusScope.of(context).requestFocus(yearFocus);
                            }
                            else{
                              firstMeetingDate = firstMeetingDate.replaceRange(3, 5, "0"+val);
                            }
                          }
                          else {
                            setState(() {
                              tempMonth ="";
                            });
                          }

                          if ((tempDay != "" && tempDay != null)  && (tempMonth != '' && tempMonth != null) && (tempYear != '' && tempYear != null)) {
                            if (validateDate(tempDay, tempMonth, tempYear)){
                              setMeetingDay(DateTime.parse(tempYear + "-" + tempMonth + "-" + tempYear));
                            }
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
                        hintText: "YYYY",
                      ),

                      keyboardType: TextInputType.numberWithOptions(),
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(4),
                        globals.onlyIntNumber
                      ],


                      focusNode: yearFocus,
                      controller: tempYear == null?null:new TextEditingController(text: tempYear),
                      onChanged: (val){
                        tempYear = val;
                        if(val.length==4) firstMeetingDate = firstMeetingDate.replaceRange(6, 10,val);

                        if ((tempDay != "" && tempDay != null)  && (tempMonth != '' && tempMonth != null) && (tempYear != '' && tempYear != null)) {
                          if (validateDate(tempDay, tempMonth, tempYear)){
                            setMeetingDay(DateTime.parse(tempYear + "-" + tempMonth + "-" + tempDay));
                          }
                        }
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

            SizedBox(height: 16.0),
            new Container(
//              color: Constant.mandatoryColor,
              child: new TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter Center Meeting Location',
                    labelText: Constant.centerMeetingLocation,
                    hintStyle: TextStyle(color: Colors.grey),
                    /*labelStyle: TextStyle(color: Colors.grey),*/
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(50),
                    globals.onlyCharacter
                  ],
                  controller:centerDetailsBean.mmeetinglocn == null
                      ? TextEditingController(text: "")
                      : TextEditingController(
                      text: centerDetailsBean.mmeetinglocn)
                  ,
                  /*initialValue:
                  centerDetailsBean.mcentername != null ? centerDetailsBean.mcentername : "",*/
                  onSaved: (String value) {
                    globals.firstName = value;
                    centerDetailsBean.mmeetinglocn = value;
                  }),
            ),

            Container(
              color: Constant.mandatoryColor,
              child:new DropdownButtonFormField(
              value:centerFrequency==null?null: centerFrequency,
              items: generateDropDown(0),
              onChanged: (LookupBeanData newValue) {
                showDropDown(newValue, 0);
              },
              validator: (args) {
                print(args);
              },
              //  isExpanded: true,
              //hint:Text("Select"),
              decoration: InputDecoration(labelText: Constant.meetingFrequency),
              // style: TextStyle(color: Colors.grey),
            ),),

            new IgnorePointer(
//              color: Constant.mandatoryColor,
            ignoring: false,
              child:new DropdownButtonFormField(
                value:centerMeetingDay==null?null: centerMeetingDay,
                items: generateDropDown(1),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 1);
                },
                validator: (args) {
                  print(args);
                },
                //  isExpanded: true,
                //hint:Text("Select"),
                decoration: InputDecoration(labelText: Constant.meetingDay),
                // style: TextStyle(color: Colors.grey),
              ),),


            SizedBox(height: 20.0,),
            Container(
              child: new Row(

                children: <Widget>[Text(Constant.repayBtwn)],
              ),
            ),

            new Container(
              decoration: BoxDecoration(color: Constant.mandatoryColor,),



              child: new Row(
                children: <Widget>[
                  new Container(
                    width: 50.0,
                    child: new TextField(
                        enabled: false,
                        controller:centerDetailsBean.mrepayfrom == null
                            ? TextEditingController(text: "0")
                            : TextEditingController(
                            text: "${centerDetailsBean.mrepayfrom}")
                    ),
                  )
                  ,


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(" AND "),
                  ),
                  new Container(
                    width: 50.0,
                    child: new TextField(
                      enabled: false,
                        controller:centerDetailsBean.mrepayto == null
                            ? TextEditingController(text: "0")
                            : TextEditingController(
                            text: "${centerDetailsBean.mrepayto}")
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 16.0),
            Card(
              child: new ListTile(
                title: new Text(Constant.nextMeetingDate),
                subtitle:new Text("${formatter.format(centerDetailsBean.mnextmeetngdt)}"),
              ),
            ),

          ],
        ),
      ),

    ));

  }


  /*Future getProduct() async {
    prodObj = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForProductSelection(11),
          fullscreenDialog: true,
        ));
//    savingsListObj.mprdcd = prodObj.mprdCd.toString();
  }*/
  Future getCustomerNumber() async {
    var customerdata;
    customerdata = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                CustomerList(null,"Loan Application")));
    if (customerdata != null) {

      /*savingsListObj.mcustno =
      customerdata.mcustno != null ? customerdata.mcustno : 0;
      savingsListObj.mcusttrefno =
      customerdata.trefno != null ? customerdata.trefno : 0;
      savingsListObj.mcustmrefno =
      customerdata.mrefno != null ? customerdata.mrefno : 0;
      savingsListObj.mlongname = customerdata.mlongname;
      savingsListObj.mcenterid =
      customerdata.mcenterid != null ? customerdata.mcenterid : 0;
      savingsListObj.mgroupcd = customerdata.mgroupcd != null ? customerdata.mgroupcd : 0;*/
    }
  }


  Future<void> _successfulSubmit() async {

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
                  Text('Done'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  setState(() {

                  });
                },
              ),
            ],
          );
        });
  }
  proceed() async {
    if (!validateSubmit()) {
      return;
    }

    centerDetailsBean.mcreatedby = username;
    centerDetailsBean.mcrs = username;
    print("centerDetailsBean.mcreatedby"+centerDetailsBean.mcreatedby.toString());
    print("username"+username.toString());
    centerDetailsBean.mlastupdateby = null;
    if ((centerDetailsBean.mcreateddt == 'null') || (centerDetailsBean.mcreateddt == null))
      centerDetailsBean.mcreateddt = DateTime.now();

    centerDetailsBean.mlastupdatedt = DateTime.now();
    centerDetailsBean.mgeolatd=geoLatitude;
    centerDetailsBean.mgeologd=geoLongitude;
    centerDetailsBean.missynctocoresys=0;
    if ((centerDetailsBean.mCenterId == 'null') || (centerDetailsBean.mCenterId == null))
      centerDetailsBean.mCenterId = 0;


if( centerDetailsBean.mrefno==null){
  centerDetailsBean.mrefno=0;
}
    await AppDatabase.get()
        .updateCenterFoundation(centerDetailsBean)
        .then((val) {
      print("val here is " + val.toString());

    });
    _successfulSubmit();
  }


  Future<void> _showAlert(arg, error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$arg'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$error'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime(2100));
    if (picked != null && picked != centerDetailsBean.mfirstmeetngdt)
      setState(() {
        centerDetailsBean.mfirstmeetngdt= picked;
        tempDate = formatter.format(picked);
        if(picked.day.toString().length==1){
          tempDay = "0"+picked.day.toString();

        }
        else tempDay = picked.day.toString();
        firstMeetingDate = firstMeetingDate.replaceRange(0, 2, tempDay);
        tempYear = picked.year.toString();
        firstMeetingDate = firstMeetingDate.replaceRange(6, 10,tempYear);
        if(picked.month.toString().length==1){
          tempMonth = "0"+picked.month.toString();
        }
        else
          tempMonth = picked.month.toString();
        firstMeetingDate = firstMeetingDate.replaceRange(3, 5, tempMonth);
        print("Test-" +DateTime.parse(tempYear + "-" + tempMonth + "-" + tempDay).toIso8601String());
        setMeetingDay(DateTime.parse(tempYear + "-" + tempMonth + "-" + tempDay));
//fsdf
      });
  }


  bool validateSubmit() {
    String error = "";
    print("inside mcentername" + centerDetailsBean.mcentername.toString());
    print("inside mmeetingdaymmeetingday" + centerDetailsBean.mmeetingday.toString());

     if (centerDetailsBean.mcentername == "" || centerDetailsBean.mcentername== null) {
      _showAlert("Center Name", "Center Name is Mandatory");
      return false;
    }
    if (centerDetailsBean.mfirstmeetngdt == "" || centerDetailsBean.mfirstmeetngdt== null) {
      _showAlert("First Meeting Date", "First Meeting Date is Mandatory");
      return false;
    }
    if (centerDetailsBean.mmeetingfreq == "" || centerDetailsBean.mmeetingfreq== null) {
      _showAlert("Meeting Frequency", "Meeting Frequency is Mandatory");
      return false;
    }
    return true;

  }

  bool validateDate(String tmpDay, String tmpMonth, String tmpYear){

    try {
      String pickedDate = "__-__-____";
      String newMonth;
      pickedDate = pickedDate.replaceRange(0, 2, tmpDay);
      pickedDate = pickedDate.replaceRange(3, 5, tmpMonth);
      pickedDate = pickedDate.replaceRange(6, 10, tmpYear);


      DateTime formattedDt = DateTime.parse(
          pickedDate.substring(6) +
              "-" +
              pickedDate.substring(3, 5) +
              "-" +
              pickedDate.substring(0, 2));

      newMonth = formattedDt.month.toString();
      if (newMonth.length == 1) newMonth = "0" + newMonth;

      if (newMonth != tmpMonth)
        return false;
      else
        return true;
    }catch(_){
      print("Exception occurred");
      return false;
    }
  }

  void setMeetingDay(DateTime dt){
    String dateDay;
    dateDay = dt.weekday.toString();
    dateDay = globals.weekDayArray[int.parse(dateDay)];
    print("dateDay-"+ dateDay.toString());
    List<String> tempDropDownValues = new List<String>();
    tempDropDownValues
        .add(centerDetailsBean.mmeetingfreq.toString());
    tempDropDownValues
        .add(dateDay);

    for (int k = 0;
    k < globals.dropdownCaptionsValuesCenterFormation.length;
    k++) {
      for (int i = 0;
      i < globals.dropdownCaptionsValuesCenterFormation[k].length;
      i++) {


        try{
          if (globals.dropdownCaptionsValuesCenterFormation[k][i].mcode.toString().trim() ==
              tempDropDownValues[k].toString().trim()) {

            print("Matched");
            setValue(k, globals.dropdownCaptionsValuesCenterFormation[k][i]);
          }
        }catch(_){
          print("Exception Occured");

        }
      }
    }
  }


}
