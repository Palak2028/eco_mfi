import 'dart:io';

import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanDetailsMasterTab.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/translations.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCPVBusinessRecordBean.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';

class CustomerLoanCPVBusinessRecord extends StatefulWidget {
  final cpvBusinessPassedObject;
  final loanPassedObject;

  CustomerLoanCPVBusinessRecord(this.cpvBusinessPassedObject,this.loanPassedObject);

  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );
  @override
  _CustomerLoanCPVBusinessRecordState createState() => new _CustomerLoanCPVBusinessRecordState();
}

class _CustomerLoanCPVBusinessRecordState extends State<CustomerLoanCPVBusinessRecord> {
  TextEditingController branchController = new TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SharedPreferences prefs;
  String username;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;
  int branch = 0;
  String loginTime;
  int usrGrpCode = 0;
  CustomerLoanCPVBusinessRecordBean cpvObj ;
  bool isDataSynced = false;
  bool circIndicatorIsDatSynced = false;
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  LookupBeanData hblocated;
  LookupBeanData addresschanged;
  LookupBeanData propertystatus;
  LookupBeanData shopconditon;
  LookupBeanData buslocation;
  LookupBeanData cuslocation;
  LookupBeanData creditsales;
  LookupBeanData periodsale;
  LookupBeanData applicantsrole;
  LookupBeanData buspatner;
  LookupBeanData keyperson;
  LookupBeanData cusbehaviour;
  LookupBeanData transrecord;
  LookupBeanData recpurandsal;
  LookupBeanData booksupdated;
  LookupBeanData buscategories;
  bool checkBox1 = false;
  bool checkBox2 = false;
  bool checkBox3 = false;
  bool checkBox4 = false;
  bool checkBox5 = false;
  bool checkBox6 = false;
  String entryDt = "__-__-____";
  String tempYear;
  String tempDay;
  String tempMonth;
  FocusNode monthFocus;
  FocusNode yearFocus;
  var formatter = new DateFormat('dd-MM-yyyy');
  String tempDate = "----/--/--";
  File f;
  File _image;
  int businessCode;
  String addr1 = "";
  String addr2 = "";
  String addr3 = "";


  Future<Null> getSessionVariables() async {
    if (widget.cpvBusinessPassedObject != null) {
      cpvObj = widget.cpvBusinessPassedObject;
      if (cpvObj.mivlandrecord == 1)
        checkBox1 = true;
      else
        checkBox1 = false;
      if (cpvObj.mivsalesregister == 1)
        checkBox2 = true;
      else
        checkBox2 = false;
      if (cpvObj.mivcreditregister == 1)
        checkBox3 = true;
      else
        checkBox3 = false;
      if (cpvObj.mivinventoryregister == 1)
        checkBox4 = true;
      else
        checkBox4 = false;
      if (cpvObj.mivsalaryslip == 1)
        checkBox5 = true;
      else
        checkBox5 = false;
      if (cpvObj.mivpassbook == 1)
        checkBox6 = true;
      else
        checkBox6 = false;
    } else {
      AppDatabase.get().generateTrefnoForLoanCPVBusinessRecord().then((onValue) {
        setState(() {
          cpvObj.trefno = onValue;
        });

      });
    }

    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode);
      username = prefs.getString(TablesColumnFile.musrcode);
      print("username"+username.toString());
      usrRole = prefs.getString(TablesColumnFile.musrdesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.mgrpcd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.mgeolocation);
      geoLatitude = prefs.get(TablesColumnFile.mgeolatd).toString();
      geoLongitude = prefs.get(TablesColumnFile.mgeologd).toString();
      reportingUser = prefs.getString(TablesColumnFile.mreportinguser);
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.cpvBusinessPassedObject != null) {
      cpvObj = widget.cpvBusinessPassedObject;
    } else {
      cpvObj = new CustomerLoanCPVBusinessRecordBean();
      cpvObj.mloantrefno = widget.loanPassedObject.trefno;
      cpvObj.mloanmrefno = widget.loanPassedObject.mrefno;
      cpvObj.mcusttrefno = widget.loanPassedObject.mcusttrefno;
      cpvObj.mcustmrefno = widget.loanPassedObject.mcustmrefno;
      cpvObj.mleadsid = widget.loanPassedObject.mleadsid;
    }

    getSessionVariables();
    getAdressDetails();
    List tempDropDownValues =  new List();
    tempDropDownValues.add(cpvObj.mhblocated);
    tempDropDownValues.add(cpvObj.maddresschanged);
    tempDropDownValues.add(cpvObj.mpropertystatus);
    tempDropDownValues.add(cpvObj.mshopcondition);
    tempDropDownValues.add(cpvObj.mbuslocation);
    tempDropDownValues.add(cpvObj.mcuslocation);
    tempDropDownValues.add(cpvObj.mcreditsales);
    tempDropDownValues.add(cpvObj.mperiodsale);
    tempDropDownValues.add(cpvObj.mapplicantsrole);
    tempDropDownValues.add(cpvObj.mbuspartner);
    tempDropDownValues.add(cpvObj.mkeyperson);
    tempDropDownValues.add(cpvObj.mcusbehaviour);
    tempDropDownValues.add(cpvObj.mtransrecord);
    tempDropDownValues.add(cpvObj.mrecpurandsal);
    tempDropDownValues.add(cpvObj.mbooksupdated);
    tempDropDownValues.add(cpvObj.mbuscategories);

    for (int k = 0;
    k < globals.dropdownCaptionsValuesLoanCPV.length;
    k++) {
      for (int i = 0;
      i < globals.dropdownCaptionsValuesLoanCPV[k].length;
      i++) {
        //print("k and i is $k $i");
        //print(globals.dropdownCaptionsValuesLoanCPV[k][i].mcode.length);
        try{
          if (globals.dropdownCaptionsValuesLoanCPV[k][i].mcode.toString() ==
              tempDropDownValues[k].toString().trim()) {

            //print("matched $k");
            setValue(k, globals.dropdownCaptionsValuesLoanCPV[k][i]);
          }
        }catch(_){
          print("Exception in dropdown");
        }
      }
    }

    if( cpvObj.mstartedym!=null
        &&cpvObj.mstartedym.toString().trim()!="null"&&
        cpvObj.mstartedym.toString().trim()!=""
    ){
      entryDt =  cpvObj.mstartedym.toString();
    }

    if (!entryDt.contains("_")) {
      try {
        DateTime formattedDate = DateTime.parse(entryDt);
        tempDay = formattedDate.day.toString();
        tempMonth = formattedDate.month.toString();
        tempYear = formattedDate.year.toString();
        entryDt = tempDay.toString() +"-"+tempMonth.toString()+"-"+tempYear.toString();
        setState(() {});
      } catch (e) {
        print("Exception Occupred");
      }
    }

  }

  void getAdressDetails() async{
    prefs = await SharedPreferences.getInstance();
    businessCode = await prefs.getInt(TablesColumnFile.businessAddCode);

    if( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj!=null&& CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcusttrefno!=null
        && CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustmrefno!=null)
    {
      await AppDatabase.get()
          .selectCustomerAddressDetailsListIsDataSynced(
          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcusttrefno,  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustmrefno)
          .then((List<AddressDetailsBean> addressDetails) async {

        if(addressDetails!=null&&addressDetails.isNotEmpty){


          for (int i = 0; i < addressDetails.length; i++) {

            print("adress type ${addressDetails[i].maddrType}" );
            print("residential code e ${businessCode}" );
            if(addressDetails[i].maddrType==businessCode){
              addr1 = addressDetails[i].maddr1;
              addr2 = addressDetails[i].maddr2;
              addr3 = addressDetails[i].maddr3;
            }
          }
        }
      });
    }
    try{
      setState(() {

      });
    }catch(_){

    }

  }

  showDropDown(LookupBeanData selectedObj, int no) {

    if(selectedObj.mcodedesc.isEmpty){
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          hblocated = blankBean;
          cpvObj.mhblocated = blankBean.mcode;
          break;
        case 1:
          addresschanged = blankBean;
          cpvObj.maddresschanged = blankBean.mcode;
          break;
        case 2:
          propertystatus = blankBean;
          cpvObj.mpropertystatus = 0;
          break;
        case 3:
          shopconditon = blankBean;
          cpvObj.mshopcondition = 0;
          break;
        case 4:
          buslocation = blankBean;
          cpvObj.mbuslocation = blankBean.mcode;
          break;
        case 5:
          cuslocation = blankBean;
          cpvObj.mcuslocation = 0;
          break;
        case 6:
          creditsales = blankBean;
          cpvObj.mcreditsales = blankBean.mcode;
          break;
        case 7:
          periodsale = blankBean;
          cpvObj.mperiodsale = blankBean.mcode;
          break;
        case 8:
          applicantsrole = blankBean;
          cpvObj.mapplicantsrole = 0;
          break;
        case 9:
          buspatner = blankBean;
          cpvObj.mbuspartner = blankBean.mcode;
          break;
        case 10:
          keyperson = blankBean;
          cpvObj.mkeyperson = 0;
          break;
        case 11:
          cusbehaviour = blankBean;
          cpvObj.mcusbehaviour = 0;
          break;
        case 12:
          transrecord = blankBean;
          cpvObj.mtransrecord = blankBean.mcode;
          break;
        case 13:
          recpurandsal = blankBean;
          cpvObj.mrecpurandsal = 0;
          break;
        case 14:
          booksupdated = blankBean;
          cpvObj.mbooksupdated = 0;
          break;
        case 14:
          buscategories = blankBean;
          cpvObj.mbuscategories = 0;
          break;
        default:
          break;
      }
      setState(() {
      });
    }
    else{
      for (int k = 0;
      k < globals.dropdownCaptionsValuesLoanCPV[no].length;
      k++) {
        if (globals.dropdownCaptionsValuesLoanCPV[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesLoanCPV[no][k]);
        }
      }
    }
  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          hblocated = value;
          cpvObj.mhblocated = value.mcode;
          break;
        case 1:
          addresschanged = value;
          cpvObj.maddresschanged = value.mcode;
          break;
        case 2:
          propertystatus = value;
          cpvObj.mpropertystatus = int.parse(value.mcode);
          break;
        case 3:
          shopconditon = value;
          cpvObj.mshopcondition = int.parse(value.mcode);
          break;
        case 4:
          buslocation = value;
          cpvObj.mbuslocation = value.mcode;
          break;
        case 5:
          cuslocation = value;
          cpvObj.mcuslocation = int.parse(value.mcode);
          break;
        case 6:
          creditsales = value;
          cpvObj.mcreditsales = value.mcode;
          break;
        case 7:
          periodsale = value;
          cpvObj.mperiodsale = value.mcode;
          break;
        case 8:
          applicantsrole = value;
          cpvObj.mapplicantsrole = int.parse(value.mcode);
          break;
        case 9:
          buspatner = value;
          cpvObj.mbuspartner = value.mcode;
          break;
        case 10:
          keyperson = value;
          cpvObj.mkeyperson = int.parse(value.mcode);
          break;
        case 11:
          cusbehaviour = value;
          cpvObj.mcusbehaviour = int.parse(value.mcode);
          break;
        case 12:
          transrecord = value;
          cpvObj.mtransrecord = value.mcode;
          break;
        case 13:
          recpurandsal = value;
          cpvObj.mrecpurandsal = int.parse(value.mcode);
          break;
        case 14:
          booksupdated = value;
          cpvObj.mbooksupdated = int.parse(value.mcode);
          break;
        case 15:
          buscategories = value;
          cpvObj.mbuscategories = int.parse(value.mcode);
          break;
        default:
          break;
      }
    });
  }

  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);
  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
    k < globals.dropdownCaptionsValuesLoanCPV[no].length;
    k++) {
      mapData.add(globals.dropdownCaptionsValuesLoanCPV[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc,overflow: TextOverflow.ellipsis,maxLines: 3,),
      );
    }).toList();
    return _dropDownMenuItems1;
  }


  Future getImage(imageNo) async {
    try{
      var image = await ImagePicker.pickImage(
          source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
      File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        ratioX: 1.0,
        ratioY: 1.5,
        maxWidth: 512,
        maxHeight: 512,
      );

      if(imageNo == 0)
        cpvObj.mbusinesslicense =  croppedFile.path;
      if(imageNo == 1)
        cpvObj.mpremisesphoto =  croppedFile.path;
      if(imageNo == 2)
        cpvObj.mpremisesphotosec =  croppedFile.path;
      if(imageNo == 3)
        cpvObj.mpremisesphotothird =  croppedFile.path;

      f =   File(croppedFile.path);

      setState(() {
        _image = croppedFile;
      });

    }catch(_){

    }
  }

  Future getImageFromGallery(int imageNo) async {
    try{
      var image = await ImagePicker.pickImage(
          source: ImageSource.gallery, maxHeight: 400.0, maxWidth: 400.0);

      File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        ratioX: 1.0,
        ratioY: 1.5,
        maxWidth: 512,
        maxHeight: 512,
      );
      if(imageNo == 0)
        cpvObj.mbusinesslicense =  croppedFile.path;
      if(imageNo == 1)
        cpvObj.mpremisesphoto =  croppedFile.path;
      if(imageNo == 2)
        cpvObj.mpremisesphotosec =  croppedFile.path;
      if(imageNo == 3)
        cpvObj.mpremisesphotothird =  croppedFile.path;

      setState(() {
        _image = croppedFile;
      });

    }catch(_){

    }
  }

  Future<void> _PickImage(int imageNo) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.touch_app,
              color: Colors.blue[800],
              size: 40.0,
            ),
            content: SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[

                  Card(
                    child: new ListTile(
                        title: new Text(('Take Picture From Camera')),
                        onTap: () {

                          Navigator.of(context).pop();
                          getImage(imageNo);

                        }),),

                  Card(
                    child: new ListTile(
                        title: new Text(('Choose From Gallery')),
                        onTap: () {

                          Navigator.of(context).pop();
                          getImageFromGallery(imageNo);

                        }),),


                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title: new Text(Translations.of(context).text('CONTACT POINT VERIFICATION BUSINESS & OFFICE')),
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
      body: Form(
        key: _formKey,
        onChanged: () {
          final FormState form = _formKey.currentState;
          form.save();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Card(
                  child:
                  new TextField(
                    controller: new TextEditingController(
                        text:
<<<<<<< .mine
                        "${cpvObj.mleadsid == null ? "0" : cpvObj.mleadsid}"
                            "/${cpvObj.mloantrefno == null ? "0" : cpvObj.mloantrefno} - ${cpvObj.mloanmrefno == null ? "0" : cpvObj.mloanmrefno}"),
=======
                            "${cpvObj.mloantrefno == null? "0" : cpvObj.mloantrefno}"
                            "/${cpvObj.mloanmrefno == null? "0" : cpvObj.mloanmrefno}"
                            "/${cpvObj.mleadsid == null||cpvObj.mleadsid.trim()=="null" ? "0" : cpvObj.mleadsid}"),
>>>>>>> .r1143
                    enabled: false,
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        hintText: Translations.of(context)
                            .text('Leads_Id_Leads_Refno'),
                        labelText: Translations.of(context)
                            .text('Leads_Id_Leads_Refno'),
                        prefixText: '',
                        suffixText: '',
                        suffixStyle: const TextStyle(color: Colors.green)),
                  )
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: hblocated,
                    items: generateDropDown(0),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 0);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Are the house and business/firm located together?')),
                  ),
                ),
              ),
              Card(
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('Name of Business'),
                        labelText: Translations.of(context).text('Name of Business'),
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.black),
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
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(50),
                      ],
                      initialValue: cpvObj.mbusinessname == null
                          ? ""
                          : "${cpvObj.mbusinessname}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          cpvObj.mbusinessname = value;
                        }
                      }
                  )
              ),
              /*Card(
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('Display Business address'),
                        labelText: Translations.of(context).text('Display Business address'),
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.black),
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
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(50),
                      ],
                      initialValue: cpvObj.mbusinessaddress == null || cpvObj.mbusinessaddress == "null"
                          ? ""
                          : "${cpvObj.mbusinessaddress}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          cpvObj.mbusinessaddress = value;
                        }
                      }
                  )
              ),*/
              new Card(
                  child:Container(
                  //color: Constant.mandatoryColor,
                  child:new ListTile(
                    title: new Text(Translations.of(context).text('Business Address')),
                    subtitle: addr1 == null ||
                        addr1  == "null"
                        ? new Text("")
                        : new Text("${addr1} , ${addr2}, ${addr3}"),

                  ))
                  ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: addresschanged,
                    items: generateDropDown(1),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 1);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Has customers Business address changed since previous loan?')),
                  ),
                ),
              ),
              //Business License Photo - mbusinesslicense
              new Text(
                Translations.of(context).text("Business License Photo"),
                textAlign: TextAlign.center,
              ),
              new Container(
                  height: 250.0,
                  child: new Column(
                    children: <Widget>[
                      new ListTile(
                        title: new ListTile(
                          title:
                          cpvObj.mbusinesslicense != null && cpvObj.mbusinesslicense != ""
                              ? new Image.file(
                            File(cpvObj.mbusinesslicense),
                            height: 200.0,
                            width: 200.0,
                          )
                              : new Image(
                              image:
                              new AssetImage("assets/AddImage.png"),
                              width: 100,
                              height: 200.0),
                          subtitle: new Text(
                            Translations.of(context)
                                .text("Click_Here_To_Take_A_Picture"),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            _PickImage(0);
                          },
                        ),
                      ),
                    ],
                  )),
              new Card(
                child:new Column(children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.only(left: 14.0),
                    child: new
                    Container(
                      decoration: BoxDecoration(),
                      child: new Row(
                        children: <Widget>[Text(Translations.of(context).text('What was the year and month the business started?')),],
                      ),
                    ),
                  ),
                  new Container(
                    decoration: BoxDecoration(),
                    child: new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                        ),
                        new Container(
                          width: 50.0,
                          child:
                          new TextField(
                              decoration: InputDecoration(hintText: Translations.of(context).text('DD')),
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(2),
                                globals.onlyIntNumber
                              ],
                              controller: tempDay == null
                                  ? null
                                  : new TextEditingController(text: tempDay),
                              keyboardType: TextInputType.numberWithOptions(),
                              onChanged: (val) {
                                if (val != "0") {
                                  tempDay = val;

                                  if (int.parse(val) <= 31 && int.parse(val) > 0) {
                                    if (val.length == 2) {
                                      entryDt = entryDt.replaceRange(0, 2, val);
                                      FocusScope.of(context).requestFocus(monthFocus);
                                    } else {
                                      entryDt =
                                          entryDt.replaceRange(0, 2, "0" + val);
                                    }
                                  } else {
                                    setState(() {
                                      tempDay = "";
                                    });
                                  }
                                }
                              }),
                        ),
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
                              globals.onlyIntNumber
                            ],
                            focusNode: monthFocus,
                            controller: tempMonth == null
                                ? null
                                : new TextEditingController(text: tempMonth),
                            onChanged: (val) {
                              if (val != "0") {
                                tempMonth = val;
                                if (int.parse(val) <= 12 && int.parse(val) > 0) {
                                  if (val.length == 2) {
                                    entryDt = entryDt.replaceRange(3, 5, val);

                                    FocusScope.of(context).requestFocus(yearFocus);
                                  } else {
                                    entryDt =
                                        entryDt.replaceRange(3, 5, "0" + val);
                                  }
                                } else {
                                  setState(() {
                                    tempMonth = "";
                                  });
                                }
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text("/"),
                        ),
                        Container(
                          width: 80,
                          child: new TextField(
                            decoration: InputDecoration(
                              hintText: Translations.of(context).text('YYYY'),
                            ),
                            keyboardType: TextInputType.numberWithOptions(),
                            inputFormatters: [
                              new LengthLimitingTextInputFormatter(4),
                              globals.onlyIntNumber
                            ],
                            focusNode: yearFocus,
                            controller: tempYear == null
                                ? null
                                : new TextEditingController(text: tempYear),
                            onChanged: (val) {
                              tempYear = val;
                              if (val.length == 4)
                                entryDt = entryDt.replaceRange(6, 10, val);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 50.0,
                        ),
                        IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () {
                              _selectEntryDate(context);
                            })
                      ],
                    ),
                  ),
                ]),
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: propertystatus,
                    items: generateDropDown(2),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 2);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Business Place Property Status')),
                  ),
                ),
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: shopconditon,
                    items: generateDropDown(3),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 3);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('How old the shop look like')),
                  ),
                ),
              ),
              /*Card(
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('What are the products that you supply?'),
                        labelText: Translations.of(context).text('What are the products that you supply?'),
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.black),
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
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(100),
                      ],
                      initialValue: cpvObj.mproductsup == null
                          ? ""
                          : "${cpvObj.mproductsup}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          cpvObj.mproductsup = value;
                        }
                      }
                  )
              ),*/
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: buslocation,
                    items: generateDropDown(4),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 4);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Is the location good for business?')),
                  ),
                ),
              ),
              //Business premises photo - mpremisesphoto
              new Text(
                Translations.of(context).text("Business premises photo"),
                textAlign: TextAlign.center,
              ),
              new Container(
                padding: new EdgeInsets.all(8.0),
                child: Text(
                  Translations.of(context).text('Click_Below_for_pic'),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              new Row(
                children: <Widget>[
                  new Flexible(
                    child: new Column(
                      children: <Widget>[
                        new ListTile(
                          title: new ListTile(
                            title: cpvObj.mpremisesphoto != null && cpvObj.mpremisesphoto != ""
                                ? new Image.file(
                              File(cpvObj.mpremisesphoto),
                              height: 200.0,
                              width: 200.0,
                            )
                                : new Icon(
                              Icons.camera_alt,
                              size: 40.0,
                              color: Color(0xff07426A),
                            ),
                            onTap: () {
                              _PickImage(1);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Flexible(
                    child: new Column(
                      children: <Widget>[
                        new ListTile(
                          title: new ListTile(
                            title: cpvObj.mpremisesphotosec != null && cpvObj.mpremisesphotosec != ""
                                ? new Image.file(
                              File(cpvObj.mpremisesphotosec),
                              height: 200.0,
                              width: 200.0,
                            )
                                : new Icon(
                              Icons.camera_alt,
                              size: 40.0,
                              color: Color(0xff07426A),
                            ),
                            onTap: () {
                              _PickImage(2);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              new Row(
                children: <Widget>[
                  new Flexible(
                    child: new Column(
                      children: <Widget>[
                        new ListTile(
                          title: new ListTile(
                            title: cpvObj.mpremisesphotothird != null && cpvObj.mpremisesphotothird != ""
                                ? new Image.file(
                              File(cpvObj.mpremisesphotothird),
                              height: 200.0,
                              width: 200.0,
                            )
                                : new Icon(
                              Icons.camera_alt,
                              size: 40.0,
                              color: Color(0xff07426A),
                            ),
                            onTap: () {
                              _PickImage(3);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Card(
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('How many customers were there?'),
                        labelText: Translations.of(context).text('How many customers were there?'),
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.black),
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
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(20),
                      ],
                      initialValue: cpvObj.mnoofcustomers == null || cpvObj.mnoofcustomers == "null"
                          ? ""
                          : "${cpvObj.mnoofcustomers}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          cpvObj.mnoofcustomers = value;
                        }
                      }
                  )
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: cuslocation,
                    items: generateDropDown(5),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 5);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Customers are from which locations')),
                  ),
                ),
              ),
              Card(
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('What percentage of customers dealing in credit?'),
                        labelText: Translations.of(context).text('What percentage of customers dealing in credit?'),
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.black),
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
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(3),
                        globals.onlyIntNumber
                      ],
                      initialValue: cpvObj.mcusdealing == null
                          ? ""
                          : "${cpvObj.mcusdealing}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          cpvObj.mcusdealing = int.parse(value);
                        }
                      }
                  )
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: creditsales,
                    items: generateDropDown(6),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 6);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Has the credit sales increased in last 6 months')),
                  ),
                ),
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: periodsale,
                    items: generateDropDown(7),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 7);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Is there a particular period when credit sales increase?')),
                  ),
                ),
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: applicantsrole,
                    items: generateDropDown(8),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 8);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Applicants role in business')),
                  ),
                ),
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: buspatner,
                    items: generateDropDown(9),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 9);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Did you see any partner in business?')),
                  ),
                ),
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: keyperson,
                    items: generateDropDown(10),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 10);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Who is the key person in the business?')),
                  ),
                ),
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: cusbehaviour,
                    items: generateDropDown(11),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 11);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('How was the customer/s behavior during visit?')),
                  ),
                ),
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: transrecord,
                    items: generateDropDown(12),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 12);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Does the customer make record of the transaction?')),
                  ),
                ),
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: recpurandsal,
                    items: generateDropDown(13),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 13);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('How customer records his purchases and sales?')),
                  ),
                ),
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: booksupdated,
                    items: generateDropDown(14),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 14);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('How latest are the books updated?')),
                  ),
                ),
              ),
              new Card(
                child:new Column(children: <Widget>[
                  Text(
                    Translations.of(context)
                        .text('Have you checked the following documents for income verification (as available)'),
                    style: TextStyle(
                        color: Colors.blue, fontSize: 18.0),
                  ),
                  //new Text(Translations.of(context).text('Have you checked the following documents for income verification (as available)')),
                  new Card(
                    child :new CheckboxListTile(
                        value: checkBox1  ,
                        title: new Text(Translations.of(context).text('Land record')),
                        onChanged: (val) {
                          setState(() {
                            checkBox1 = val;

                          });
                        }),
                  ),
                  new Card(
                    child :new CheckboxListTile(
                        value: checkBox2  ,
                        title: new Text(Translations.of(context).text('Sales register')),
                        onChanged: (val) {
                          setState(() {
                            checkBox2 = val;

                          });
                        }),
                  ),
                  new Card(
                    child :new CheckboxListTile(
                        value: checkBox3  ,
                        title: new Text(Translations.of(context).text('Credit Register')),
                        onChanged: (val) {
                          setState(() {
                            checkBox3 = val;

                          });
                        }),
                  ),
                  new Card(
                    child :new CheckboxListTile(
                        value: checkBox4  ,
                        title: new Text(Translations.of(context).text('Inventory register')),
                        onChanged: (val) {
                          setState(() {
                            checkBox4 = val;

                          });
                        }),
                  ),
                  new Card(
                    child :new CheckboxListTile(
                        value: checkBox5  ,
                        title: new Text(Translations.of(context).text('Salary Slip')),
                        onChanged: (val) {
                          setState(() {
                            checkBox5 = val;

                          });
                        }),
                  ),
                  new Card(
                    child: new CheckboxListTile(
                        value: checkBox6  ,
                        title: new Text(Translations.of(context).text('Passbook')),
                        onChanged: (val) {
                          setState(() {
                            checkBox6 = val;

                          });
                        }),
                  ),
                ]),
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: buscategories,
                    items: generateDropDown(15),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 15);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Based on income estimates/details the customer business is categories')),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _selectEntryDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != cpvObj.mstartedym)
      setState(() {
        cpvObj.mstartedym = picked;
        tempDate = formatter.format(picked);
        if (picked.day.toString().length == 1) {
          tempDay = "0" + picked.day.toString();
        } else
          tempDay = picked.day.toString();
        entryDt = entryDt.replaceRange(0, 2, tempDay);
        tempYear = picked.year.toString();
        entryDt = entryDt.replaceRange(6, 10, tempYear);
        if (picked.month.toString().length == 1) {
          tempMonth = "0" + picked.month.toString();
        } else
          tempMonth = picked.month.toString();
        entryDt = entryDt.replaceRange(3, 5, tempMonth);
      });
  }

  proceed() async {
    if (!validateSubmit()) {
      return;
    }

    if (checkBox1 == true)
      cpvObj.mivlandrecord = 1;
    else
      cpvObj.mivlandrecord = 0;
    if (checkBox2 == true)
      cpvObj.mivsalesregister = 1;
    else
      cpvObj.mivsalesregister = 0;
    if (checkBox3 == true)
      cpvObj.mivcreditregister = 1;
    else
      cpvObj.mivcreditregister = 0;
    if (checkBox4 == true)
      cpvObj.mivinventoryregister = 1;
    else
      cpvObj.mivinventoryregister = 0;
    if (checkBox5 == true)
      cpvObj.mivsalaryslip = 1;
    else
      cpvObj.mivsalaryslip = 0;
    if (checkBox6 == true)
      cpvObj.mivpassbook = 1;
    else
      cpvObj.mivpassbook = 0;
    cpvObj.mcreatedby = username;
    cpvObj.mlastupdateby = null;

    if ((cpvObj.mcreateddt == 'null') || (cpvObj.mcreateddt == null))
      cpvObj.mcreateddt = DateTime.now();

    cpvObj.mlastupdatedt = DateTime.now();
    cpvObj.mgeolatd=geoLatitude;
    cpvObj.mgeologd=geoLongitude;
    cpvObj.missynctocoresys=0;
    if( cpvObj.mrefno==null){
      cpvObj.mrefno=0;
    }
    await AppDatabase.get()
        .updateLoanCPVBusinessRecord(cpvObj)
        .then((val) {
      print("val here is " + val.toString());

    });
    _successfulSubmit();
  }

  bool validateSubmit(){

    if(cpvObj.mcusdealing != "" && cpvObj.mcusdealing != "null" && cpvObj.mcusdealing != null ) {
      if (cpvObj.mcusdealing > 100) {
        _showAlertWithError(Translations.of(context).text('What percentage of customers dealing in credit?'),
            Translations.of(context).text("greaterThan100"));
        return false;
      }
    }
    return true;
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


  Future<void> _showAlertWithError(arg, error) async {
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
              child: Text(Translations.of(context).text('Ok')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
