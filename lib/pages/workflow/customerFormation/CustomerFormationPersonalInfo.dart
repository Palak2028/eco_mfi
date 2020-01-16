
import 'dart:async';
import 'dart:io';

import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/main.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/FullScreenDialogForMainOccupationSelection.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/FullScreenDialogForSubOccupationSelection.dart';
import 'package:eco_mfi/translations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerFormationPersonalInfo extends StatefulWidget {
  CustomerFormationPersonalInfo();

  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );



  @override
  _CustomerFormationPersonalInfoState createState() =>
      new _CustomerFormationPersonalInfoState();
}

class _CustomerFormationPersonalInfoState
    extends State<CustomerFormationPersonalInfo> {
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List testString = new List();
  int isFullerTon=0;
  int isOnlyLongName=0;

  FocusNode monthFocus;
  FocusNode yearFocus;
  FocusNode monthFocusH;
  FocusNode yearFocusH;
  bool isEnabled = true;

  LookupBeanData title;
  LookupBeanData ifYesThen;
  LookupBeanData relegion;
  LookupBeanData maritialStatus;
  LookupBeanData qualification;
  LookupBeanData occupation;
  LookupBeanData caste;
  LookupBeanData region;
  LookupBeanData motherTongue;
  LookupBeanData secondryOccuptn;
  LookupBeanData ruralUrban;
  LookupBeanData gender;

  SubLookupForSubPurposeOfLoan mainOcc = new SubLookupForSubPurposeOfLoan();
  SubLookupForSubPurposeOfLoan subOcc = new SubLookupForSubPurposeOfLoan();
  SharedPreferences prefs;

  List<LookupBeanData> onValueTitle = List<LookupBeanData>();

  DateTime selectedDate = DateTime.now();
  final dateFormat = DateFormat("yyyy/MM/dd");
  var formatter = new DateFormat('dd-MM-yyyy');
  String tempDate = "----/--/--";
  String tempYear ;
  String tempDay ;
  String tempMonth;
  String tempDateH = "----/--/--";
  String tempYearH ;
  String tempDayH ;
  String tempMonthH;
  DateTime date;
  TimeOfDay time;
  bool boolValidate = false;
  List maleValidationList;
  List femaleValidationList;
  List marriedTitleList;
  List exceptionTitleList;
  String selectedGender;
  bool isWasasa  = false;
  bool isSaija = true;
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

  showDropDown(LookupBeanData selectedObj, int no) {

    if(selectedObj.mcodedesc.isEmpty){
      switch (no) {
        case 0:
          ifYesThen = blankBean;
          //CustomerFormationMasterTabsState.custListBean.ifYesThen = blankBean.mcode;

          break;
        case 1:
          relegion = blankBean;
          CustomerFormationMasterTabsState.custListBean.mrelegion = blankBean.mcode;
          break;
        case 2:
          maritialStatus = blankBean;
          CustomerFormationMasterTabsState.custListBean.mmaritialStatus= 0;
          break;
        case 3:
          qualification = blankBean;
          CustomerFormationMasterTabsState.custListBean.mqualification = blankBean.mcode;
          break;
        case 4:
          occupation = blankBean;
          CustomerFormationMasterTabsState.custListBean.moccupation =0;
          break;
        case 5:
          caste = blankBean;
          CustomerFormationMasterTabsState.custListBean.mcaste = blankBean.mcode;
          break;
        case 6:
          title = blankBean;
          CustomerFormationMasterTabsState.custListBean.mnametitle = blankBean.mcode;
          break;
        case 7:
          motherTongue = blankBean;
          CustomerFormationMasterTabsState.custListBean.mlangofcust = blankBean.mcode;
          break;
        case 8:
          secondryOccuptn = blankBean;
          CustomerFormationMasterTabsState.custListBean.msecoccupatn = 0;
          break;
        case 9:
          gender = blankBean;
          CustomerFormationMasterTabsState.custListBean.mgender = blankBean.mcode;
          break;
        case 10:
          ruralUrban = blankBean;
          CustomerFormationMasterTabsState.custListBean.mRuralUrban= 0;
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
      k < globals.dropdownCaptionsValuesPersonalInfo[no].length;
      k++) {
        if (globals.dropdownCaptionsValuesPersonalInfo[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesPersonalInfo[no][k]);
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
      switch (no) {
        case 0:
            ifYesThen = value;
            //CustomerFormationMasterTabsState.custListBean.ifYesThen = value.mcode;

          break;
        case 1:
          relegion = value;
          CustomerFormationMasterTabsState.custListBean.mrelegion = value.mcode;
          break;
        case 2:
          maritialStatus = value;
          CustomerFormationMasterTabsState.custListBean.mmaritialStatus = int.parse(value.mcode);
          break;
        case 3:
          qualification = value;
          CustomerFormationMasterTabsState.custListBean.mqualification = value.mcode;
          break;
        case 4:
          occupation = value;
          CustomerFormationMasterTabsState.custListBean.moccupation = int.parse(value.mcode);
          break;
        case 5:
          caste = value;
          CustomerFormationMasterTabsState.custListBean.mcaste = value.mcode;
          break;
        case 6:
          title = value;


          if(maleValidationList!=null&&
              maleValidationList.contains(value.mcode.toString().trim()))selectedGender ="male";


          if(femaleValidationList!=null&&
              femaleValidationList.contains(value.mcode.toString().trim()))selectedGender ="female";
          CustomerFormationMasterTabsState.custListBean.mnametitle = value.mcode;
          break;
        case 7:
          motherTongue = value;
          CustomerFormationMasterTabsState.custListBean.mlangofcust = value.mcode;
          break;
        case 8:
          secondryOccuptn = value;
          CustomerFormationMasterTabsState.custListBean.msecoccupatn = int.parse(value.mcode);
          break;
        case 9:
          gender = value;
          if(value.mcode=="M")selectedGender = "male";
          if(value.mcode=="F")selectedGender= "female";
          CustomerFormationMasterTabsState.custListBean.mgender = value.mcode;
          break;
        case 10:
          ruralUrban= value;
          CustomerFormationMasterTabsState.custListBean.mRuralUrban= int.parse(value.mcode);
          break;

        default:
          break;
      }
    });
  }

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
        k < globals.dropdownCaptionsValuesPersonalInfo[no].length;
        k++) {
      mapData.add(globals.dropdownCaptionsValuesPersonalInfo[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
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

  bool validateGender(int dropDownNumber,LookupBeanData lookupBean){

    if(dropDownNumber==6){
      if(selectedGender=="male"&&maleValidationList.contains(lookupBean.mcode)){
          return true;
      }else if(selectedGender=="female"&&femaleValidationList.contains(lookupBean.mcode))return true;

      else return false;


    }else if(dropDownNumber==9){
     if(  (selectedGender=="male" && lookupBean.mcode=="M")||
         (selectedGender=="female" && lookupBean.mcode=="F")
     ) return true;

     else return false;

    }


  }
  bool isMarried =false;
  @override
  void initState() {


    monthFocus = new FocusNode();
    yearFocus = new FocusNode();
    monthFocusH = new FocusNode();
    yearFocusH = new FocusNode();

    for(int i = 0;i<CustomerFormationMasterTabsState.personalInfoRadios.length;i++){
      if(CustomerFormationMasterTabsState.personalInfoRadios[i]==null)CustomerFormationMasterTabsState.personalInfoRadios[i]= 0;
    }
    if(CustomerFormationMasterTabsState.custListBean.mLoanAgreed!=null)CustomerFormationMasterTabsState.personalInfoRadios[0] = CustomerFormationMasterTabsState.custListBean.mLoanAgreed;
    //if(CustomerFormationMasterTabsState.custListBean.mInsuranceCovYN!=null)CustomerFormationMasterTabsState.personalInfoRadios[1] = int.parse(CustomerFormationMasterTabsState.custListBean.mInsuranceCovYN);
    if (!ifNullCheck(CustomerFormationMasterTabsState.custListBean
        .mInsuranceCovYN)) {
      CustomerFormationMasterTabsState.personalInfoRadios[1] = int.parse(
          CustomerFormationMasterTabsState.custListBean
              .mInsuranceCovYN);
    }
    else{
      CustomerFormationMasterTabsState.custListBean
          .mInsuranceCovYN = "0";
    }
    if(CustomerFormationMasterTabsState.custListBean.mGend!=null)CustomerFormationMasterTabsState.personalInfoRadios[2] = CustomerFormationMasterTabsState.custListBean.mGend;
    else {
      CustomerFormationMasterTabsState.custListBean.mGend = 0;
    }
    if(CustomerFormationMasterTabsState.custListBean.mRuralUrban!=null)CustomerFormationMasterTabsState.personalInfoRadios[3] = CustomerFormationMasterTabsState.custListBean.mRuralUrban;
    if(CustomerFormationMasterTabsState.custListBean.mTypeofCoverage!=null)CustomerFormationMasterTabsState.personalInfoRadios[4] = CustomerFormationMasterTabsState.custListBean.mTypeofCoverage;
    else {
      CustomerFormationMasterTabsState.custListBean.mTypeofCoverage = 0;
    }


    // TODO: implement initState
    super.initState();
    print("CustomerFormationMasterTabsState.custListBean.mlongname ${CustomerFormationMasterTabsState.custListBean.mlongname}");
    List<String> tempDropDownValues = new List<String>();
    tempDropDownValues
        .add(CustomerFormationMasterTabsState.custListBean.ifYesThen);
    tempDropDownValues
        .add(CustomerFormationMasterTabsState.custListBean.mrelegion);
    tempDropDownValues
        .add(CustomerFormationMasterTabsState.custListBean.mmaritialStatus.toString());
    tempDropDownValues
        .add(CustomerFormationMasterTabsState.custListBean.mqualification);
    tempDropDownValues
        .add(CustomerFormationMasterTabsState.custListBean.moccupation.toString());
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mcaste);
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mnametitle);
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mlangofcust);
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.msecoccupatn.toString());
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mgender);
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mRuralUrban.toString());
    if(!CustomerFormationMasterTabsState.applicantDob.contains("_")){
      try{

        String tempApplicantdob = CustomerFormationMasterTabsState.applicantDob;
        //print(tempApplicantdob.substring(6)+"-"+tempApplicantdob.substring(3,5)+"-"+tempApplicantdob.substring(0,2));
        DateTime  formattedDate =  DateTime.parse(tempApplicantdob.substring(6)+"-"+tempApplicantdob.substring(3,5)+"-"+tempApplicantdob.substring(0,2));
        //print(formattedDate);
        tempDay = formattedDate.day.toString();
        //print(tempDay);
        tempMonth = formattedDate.month.toString();
        //print(tempMonth);
        tempYear = formattedDate.year.toString();
        //print(tempYear);
        setState(() {

        });

      }catch(e){

        print("Exception Occupred");
      }
    }

    if(!CustomerFormationMasterTabsState.husDob.contains("_")){
      try{
        //print("inside try");

        String tempHusDob = CustomerFormationMasterTabsState.husDob;
        DateTime  formattedDate =  DateTime.parse(tempHusDob.substring(6)+"-"+tempHusDob.substring(3,5)+"-"+tempHusDob.substring(0,2));

        tempDayH = formattedDate.day.toString();

        tempMonthH = formattedDate.month.toString();

        tempYearH = formattedDate.year.toString();

        setState(() {

        });

      }catch(e){

        print("Exception Occupred");
      }
    }

    for (int k = 0;
        k < globals.dropdownCaptionsValuesPersonalInfo.length;
        k++) {
      for (int i = 0;
          i < globals.dropdownCaptionsValuesPersonalInfo[k].length;
          i++) {


        try{
          if (globals.dropdownCaptionsValuesPersonalInfo[k][i].mcode.toString().trim() ==
              tempDropDownValues[k].toString().trim()) {


            setValue(k, globals.dropdownCaptionsValuesPersonalInfo[k][i]);
          }
        }catch(_){
          print("Exception Occured");

        }
      }
    }
    if(CustomerFormationMasterTabsState.custListBean.mcusttype.toString().trim() == "INS"){

      //print("Customer Type is  ${CustomerFormationMasterTabsState.custListBean.mcusttype}");
      isEnabled = false;

    }else{
      isEnabled = true;
    }

    if(CustomerFormationMasterTabsState.custListBean.mmaritialStatus!=null&&
        CustomerFormationMasterTabsState.custListBean.mmaritialStatus==2){
      isMarried = true;
    }

    getSessionVariables();


  }



    Future<Null> getSessionVariables() async {


      prefs = await SharedPreferences.getInstance();
      try{

<<<<<<< .mine
        try {
          isFullerTon = prefs.getInt(TablesColumnFile.ISFULLERTON);
        }catch(_){}


        try{
          isOnlyLongName =prefs.getInt(TablesColumnFile.ISONLYLONGNAME);
        }catch(_){}

=======
        try {
          isFullerTon = prefs.getInt(TablesColumnFile.ISFULLERTON);
        }catch(_){}
        try{
          isOnlyLongName =prefs.getInt(TablesColumnFile.ISONLYLONGNAME);
        }catch(_){}
>>>>>>> .r1143
      if(prefs.getString(TablesColumnFile.maleValidation)!=null&&prefs.getString(TablesColumnFile.maleValidation) != "0"){
      maleValidationList = prefs.getString(TablesColumnFile.maleValidation).split("~");
      }

      if(prefs.getString(TablesColumnFile.femaleValidaton)!=null&&prefs.getString(TablesColumnFile.femaleValidaton) != "0"){
        femaleValidationList = prefs.getString(TablesColumnFile.femaleValidaton).split("~");
      }
      if(prefs.getString(TablesColumnFile.marriedTitles)!=null
          &&prefs.getString(TablesColumnFile.marriedTitles) != "0"){
        marriedTitleList = prefs.getString(TablesColumnFile.marriedTitles).split("~");
      }
      if(prefs.getString(TablesColumnFile.exceptionTitles)!=null
          &&prefs.getString(TablesColumnFile.exceptionTitles) != "0"){
        exceptionTitleList = prefs.getString(TablesColumnFile.exceptionTitles).split("~");
      }



      if(prefs.getInt(TablesColumnFile.isWASASA)==1){
        isWasasa = true ;

      }
      else{
        isWasasa = false;
      }

      if(prefs.getInt(TablesColumnFile.isSaiaja)==1){
        isSaija = true ;

      }
      else{
        isSaija = false;
      }



        setState(() {

        });
<<<<<<< .mine
      if((CustomerFormationMasterTabsState.custListBean.mmainoccupndesc ==null||
          CustomerFormationMasterTabsState.custListBean.mmainoccupndesc.trim() ==''||
          CustomerFormationMasterTabsState.custListBean.mmainoccupndesc.trim() =='null')&&
          (CustomerFormationMasterTabsState.custListBean.mmainoccupn!=null&&
              CustomerFormationMasterTabsState.custListBean.mmainoccupn.trim()!=''&&
              CustomerFormationMasterTabsState.custListBean.mmainoccupn.trim()!='null'
          )) {
        await AppDatabase.get()
            .getOccupation(
            200, 0, CustomerFormationMasterTabsState.custListBean.mmainoccupn)
            .then((SubLookupForSubPurposeOfLoan val  ) async{
              if(val!=null){
                print("Returned Value is for main Occupation ${val} ");
                CustomerFormationMasterTabsState.custListBean.mmainoccupndesc= val.codeDesc;
              }
              if((CustomerFormationMasterTabsState.custListBean.msuboccupndesc==null||
                  CustomerFormationMasterTabsState.custListBean.msuboccupndesc.trim() ==''||
                  CustomerFormationMasterTabsState.custListBean.msuboccupndesc.trim() =='null')&&
                  (CustomerFormationMasterTabsState.custListBean.msuboccupn!=null&&
                      CustomerFormationMasterTabsState.custListBean.msuboccupn.trim()!=''&&
                      CustomerFormationMasterTabsState.custListBean.msuboccupn.trim()!='null'
                  )) {
                await AppDatabase.get()
                    .getOccupation(
                    200, int.parse(CustomerFormationMasterTabsState.custListBean.mmainoccupn)
                    , CustomerFormationMasterTabsState.custListBean.msuboccupn)
                    .then((val) {
                  print("Returned Value is for sub Occupation ${val} ");
                  if(val!=null){
                    CustomerFormationMasterTabsState.custListBean.msuboccupndesc= val.codeDesc;
                  }
                });
              }
        });
      }
        setState(() {
        });
=======








      if((CustomerFormationMasterTabsState.custListBean.mmainoccupndesc ==null||
          CustomerFormationMasterTabsState.custListBean.mmainoccupndesc.trim() ==''||
          CustomerFormationMasterTabsState.custListBean.mmainoccupndesc.trim() =='null')&&
          (CustomerFormationMasterTabsState.custListBean.mmainoccupn!=null&&
              CustomerFormationMasterTabsState.custListBean.mmainoccupn.trim()!=''&&
              CustomerFormationMasterTabsState.custListBean.mmainoccupn.trim()!='null'
          )) {
        await AppDatabase.get()
            .getOccupation(
            200, 0, CustomerFormationMasterTabsState.custListBean.mmainoccupn)
            .then((SubLookupForSubPurposeOfLoan val  ) async{

              if(val!=null){
                print("Returned Value is for main Occupation ${val} ");
                CustomerFormationMasterTabsState.custListBean.mmainoccupndesc= val.codeDesc;
              }



              if((CustomerFormationMasterTabsState.custListBean.msuboccupndesc==null||
                  CustomerFormationMasterTabsState.custListBean.msuboccupndesc.trim() ==''||
                  CustomerFormationMasterTabsState.custListBean.msuboccupndesc.trim() =='null')&&
                  (CustomerFormationMasterTabsState.custListBean.msuboccupn!=null&&
                      CustomerFormationMasterTabsState.custListBean.msuboccupn.trim()!=''&&
                      CustomerFormationMasterTabsState.custListBean.msuboccupn.trim()!='null'
                  )) {


                await AppDatabase.get()
                    .getOccupation(
                    200, int.parse(CustomerFormationMasterTabsState.custListBean.mmainoccupn)
                    , CustomerFormationMasterTabsState.custListBean.msuboccupn)
                    .then((val) {
                  print("Returned Value is for sub Occupation ${val} ");
                  if(val!=null){
                    CustomerFormationMasterTabsState.custListBean.msuboccupndesc= val.codeDesc;
                  }

                });
              }




        });
      }



        setState(() {

        });

>>>>>>> .r1143
      }catch(_){
        print("Exception in getSession Variables");
      }


  }


  Widget yesNo1() => CustomerFormationPersonalInfo._get(new Row(
    children: _makeRadios(2, globals.radioCaptionValuesPersonalInfo[0], 0),
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  ));

  Widget yesNo2() => CustomerFormationPersonalInfo._get(new Row(
    children: _makeRadios(2, globals.radioCaptionValuesPersonalInfo[1], 1),
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  ));

  Widget genderRadio() => CustomerFormationPersonalInfo._get(new Row(
    children: _makeRadios(2, globals.radioCaptionValuesPersonalInfo[2], 2),
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  ));

  Widget regionRadio() => CustomerFormationPersonalInfo._get(new Row(
        children: _makeRadios(2, globals.radioCaptionValuesPersonalInfo[3], 3),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));

  Widget yesInsurance() => CustomerFormationPersonalInfo._get(new Row(
    children: _makeRadios(2, globals.radioCaptionValuesPersonalInfo[4], 4),
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  ));

  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);
  List<Widget> _makeRadios(int numberOfRadios, List textName, int position) {
    List<Widget> radios = new List<Widget>();
    for (int i = 0; i < numberOfRadios; i++) {
      radios.add(Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 10.0),
        child: new Row(
          children: <Widget>[
            new Text(
              textName[i],
              textAlign: TextAlign.right,
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontStyle: FontStyle.normal,
                fontSize: 12.0,
              ),
            ),
            new Radio(
              value: i,
              groupValue: CustomerFormationMasterTabsState.personalInfoRadios[position],
              onChanged: (selection) => _onRadioSelected(selection, position),
              activeColor: Color(0xff07426A),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ));
    }
    return radios;
  }

  Widget getTextContainer(String textValue) {
    return new Container(
      padding: EdgeInsets.fromLTRB(5.0, 20.0, 0.0, 20.0),
      child: new Text(
        textValue,
        //textDirection: TextDirection,
        textAlign: TextAlign.start,
        /*overflow: TextOverflow.ellipsis,*/
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontStyle: FontStyle.normal,
            fontSize: 12.0),
      ),
    );
  }

  _onRadioSelected(int selection, int position) {
    setState(() => CustomerFormationMasterTabsState.personalInfoRadios[position] = selection);
    if (position == 0) {
      CustomerFormationMasterTabsState.custListBean.mLoanAgreed = selection;
    } else if (position == 1) {
      CustomerFormationMasterTabsState.custListBean.mInsuranceCovYN = selection as String;

    } else if (position == 2) {
      CustomerFormationMasterTabsState.custListBean.mGend = selection;

    } else if (position == 3) {
      CustomerFormationMasterTabsState.custListBean.mRuralUrban = selection;

    } else if (position == 4) {
      CustomerFormationMasterTabsState.custListBean.mTypeofCoverage = selection;

    }
  }

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _formKey,
      //autovalidate: CustomerFormationMasterTabsState.autoValidate,
      onWillPop: () {
        return Future(() => true);
      }
      ,onChanged: () {
      final FormState form = _formKey.currentState;
      form.save();
    },
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        children: <Widget>[
          SizedBox(height: 16.0),
          Center(
            child: new Column(children: [
              //occupationRadio(),

              Container(
                  color: Constant.mandatoryColor
                  ,child:new DropdownButtonFormField(
                value: title,
                items: generateDropDown(6),
                onChanged: (LookupBeanData newValue) {
                  if(isEnabled==true){
                    if(maleValidationList.contains(newValue.mcode)||
                        femaleValidationList.contains(newValue.mcode)){

                          if((maleValidationList.contains(newValue.mcode)&&
                            CustomerFormationMasterTabsState.custListBean.mgender=="M"
                      )||(
                          femaleValidationList.contains(newValue.mcode)&&
                              CustomerFormationMasterTabsState.custListBean.mgender=="F"
                      )

                      ){
                        showDropDown(newValue, 6);
                      }
                      else if(CustomerFormationMasterTabsState.custListBean.mgender==null||CustomerFormationMasterTabsState.custListBean.mgender==""){
                        showDropDown(newValue, 6);}
                      else{_showAlert(Translations.of(context).text("Title"),
                          Translations.of(context).text("Title  Do Not match with Gender"));}
                    }
                    else {showDropDown(newValue, 6);}


                  }//for institution Acc type only allowed
                  else{
                    if(newValue.mcode.trim()=="A/C"){showDropDown(newValue, 6);}
                    else{_showAlert(Translations.of(context).text("title"),

                        Translations.of(context).text("titlCanBeA/CTypeOnly"));}
                  }



                },
                validator: (args) {
                 // print(args);
                },
                //  isExpanded: true,
                //hint:Text("Select"),
                decoration: InputDecoration(labelText: Translations.of(context).text("title")),
                // style: TextStyle(color: Colors.grey),
              ),)


            ]),
          ),

          SizedBox(height: 16.0),
          isOnlyLongName==0? new Container(
            color: Constant.mandatoryColor,
            child: new TextFormField(
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: isEnabled==true?Translations.of(context).text('entrFrstNm'):
                  Translations.of(context).text('entrInstNm'),
                  labelText: isEnabled==true?Translations.of(context).text('firstName')
                      :Translations.of(context).text('instNm'),
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
                initialValue:
                CustomerFormationMasterTabsState.custListBean.mfname != null ? CustomerFormationMasterTabsState.custListBean.mfname : "",
                onSaved: (String value) {
                  /*globals.firstName = value;*/
                  CustomerFormationMasterTabsState.custListBean.mfname =
                      value;
                }),
          ):new Container(),
          SizedBox(height: 16.0),

          isOnlyLongName==0?  Container(
            color: isWasasa==true?Constant.mandatoryColor:Colors.white,
            child: new TextFormField(
                decoration:  InputDecoration(
                  hintText: Translations.of(context).text('entrMiddleNm'),
                  labelText: Translations.of(context).text('middleName'),
                  hintStyle: TextStyle(color: Colors.grey),
                  /*labelStyle: TextStyle(color: Colors.grey),*/
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
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
                enabled: isEnabled,
              initialValue:
              CustomerFormationMasterTabsState.custListBean.mmname != null ? CustomerFormationMasterTabsState.custListBean.mmname : "",
              validator: (arg) =>
                  Utility.validateOnlyCharacterFieldNotMandat(arg),
              onSaved: (String value) {
                CustomerFormationMasterTabsState.custListBean.mmname = value;
                  if(isWasasa==true){
                    CustomerFormationMasterTabsState.custListBean.mfathername = value;
                    setState(() {

                    });
                  }

                }),
        ):new Container(),
          SizedBox(height: 16.0),
          isOnlyLongName==0?  new Container(
            color: Constant.mandatoryColor,
            child: new TextFormField(
                decoration:  InputDecoration(
                  hintText: Translations.of(context).text('entrLastNm'),
                  labelText: Translations.of(context).text('lastNm'),
                  hintStyle: TextStyle(color: Colors.grey),
                  /*labelStyle: TextStyle(color: Colors.grey),*/
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
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
                enabled: isEnabled,
                initialValue: CustomerFormationMasterTabsState.custListBean.mlname != null ? CustomerFormationMasterTabsState.custListBean.mlname : "",
                onSaved: (String value) {
                  /*globals.lastName = value;*/
                  CustomerFormationMasterTabsState.custListBean.mlname = value;
                }),
<<<<<<< .mine
        ):new Container(),
=======
        ):new Container(),
          isOnlyLongName==1?  new Container(
          color: Constant.mandatoryColor,
          child: new TextFormField(
              decoration:  InputDecoration(
                hintText: Translations.of(context).text('entrLongNm'),
                labelText: Translations.of(context).text('LongNm'),
                hintStyle: TextStyle(color: Colors.grey),
                /*labelStyle: TextStyle(color: Colors.grey),*/
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    )),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff07426A),
                    )),
                contentPadding: EdgeInsets.all(20.0),
              ),
              inputFormatters: [
                new LengthLimitingTextInputFormatter(150),
                globals.onlyCharacter
              ],
              enabled: isEnabled,
                initialValue: CustomerFormationMasterTabsState.custListBean.mlongname != null  && CustomerFormationMasterTabsState.custListBean.mlongname != 'null'? CustomerFormationMasterTabsState.custListBean.mlongname : "",
              onSaved: (String value) {
                /*globals.lastName = value;*/
                CustomerFormationMasterTabsState.custListBean.mlongname = value;
                }),
          ):new Container(),
>>>>>>> .r1143


          isOnlyLongName==1?  new Container(
            color: Constant.mandatoryColor,
            child: new TextFormField(
                decoration:  InputDecoration(
                  hintText: Translations.of(context).text('entrLongNm'),
                  labelText: Translations.of(context).text('LongNm'),
                  hintStyle: TextStyle(color: Colors.grey),
                  /*labelStyle: TextStyle(color: Colors.grey),*/
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      )),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff07426A),
                      )),
                  contentPadding: EdgeInsets.all(20.0),
                ),
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(150),
                  globals.onlyCharacter
                ],
                enabled: isEnabled,
                initialValue: CustomerFormationMasterTabsState.custListBean.mlongname != null  && CustomerFormationMasterTabsState.custListBean.mlongname != 'null'? CustomerFormationMasterTabsState.custListBean.mlongname : "",
                onSaved: (String value) {
                  /*globals.lastName = value;*/
                  print("CustomerFormationMasterTabsState.custListBean.mlongname  ${CustomerFormationMasterTabsState.custListBean.mlongname}");
                  CustomerFormationMasterTabsState.custListBean.mlongname = value;
                }),
          ):new Container(),

          Container(
            color: Constant.mandatoryColor
            ,child: new DropdownButtonFormField(
            value:gender==null?null: gender,
            items: generateDropDown(9),

            onChanged: (LookupBeanData newValue) {

              if(maleValidationList.contains(CustomerFormationMasterTabsState.custListBean.mnametitle)||
                  femaleValidationList.contains(CustomerFormationMasterTabsState.custListBean.mnametitle)

              ){
                if((maleValidationList.contains(CustomerFormationMasterTabsState.custListBean.mnametitle)
                    &&newValue.mcode=="M"
                )||(
                    femaleValidationList.contains(CustomerFormationMasterTabsState.custListBean.mnametitle)
                        &&newValue.mcode=="F"
                )
                ){
                  showDropDown(newValue, 9);
                }
                else if(newValue.mcode==null||newValue.mcode==""){
                  showDropDown(newValue, 9);
                }
                else{
                  _showAlert(Translations.of(context).text("gender"),

                      Translations.of(context).text("gndrNotMatchWthTit"));
                }

              }
              else{
                showDropDown(newValue, 9);
              }

            },
            validator: (args) {
              print(args);
            },
            //  isExpanded: true,
            //hint:Text("Select"),
            decoration: InputDecoration(labelText: Translations.of(context).text("Gender")),
            // style: TextStyle(color: Colors.grey),
          ),),

          SizedBox(height: 20.0,),
          Container(
            decoration: BoxDecoration(color: Constant.mandatoryColor),
            child: new Row(

              children: <Widget>[

                isEnabled==true?Text(Constant.applicantDOB):Text(Constant.institutionEstablishmntDate)

              ],
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
                              CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(0, 2, val);
                              FocusScope.of(context).requestFocus(monthFocus);
                            }
                            else{
                              CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(0, 2, "0"+val);
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
                            CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(3, 5, val);

                            FocusScope.of(context).requestFocus(yearFocus);
                          }
                          else{
                            CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(3, 5, "0"+val);
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
                      if(val.length==4) CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(6, 10,val);

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


          isEnabled==true?Container(
            color: Constant.mandatoryColor
            ,child:new DropdownButtonFormField(
            value:maritialStatus==null?null: maritialStatus,
            items: generateDropDown(2),
            onChanged: (LookupBeanData newValue) {

              if(newValue.mcode!=null&&newValue.mcode.trim()=='2'){

<<<<<<< .mine
                isMarried =true;
=======
                isMarried =true;

>>>>>>> .r1143
                if(CustomerFormationMasterTabsState.custListBean.mnametitle==null||CustomerFormationMasterTabsState.custListBean.mnametitle.trim()==""||
                    CustomerFormationMasterTabsState.custListBean.mnametitle.trim()==null
                ){
                  _showAlert(Translations.of(context).text("maritalStatus"),
                      Translations.of(context).text("selectTitleFirst"));

                }
                else if(marriedTitleList.contains(CustomerFormationMasterTabsState.custListBean.mnametitle)){
                  showDropDown(newValue, 2);
                }else{
                  print(marriedTitleList);
                  _showAlert(Translations.of(context).text("maritalStatus"),
                      Translations.of(context).text("Title  Do Not match with Marital Status"));
                }
              }
              else{
<<<<<<< .mine
                  isMarried = false;
=======


                  isMarried = false;


>>>>>>> .r1143
                if(marriedTitleList.contains(CustomerFormationMasterTabsState.custListBean.mnametitle)&&
                    !(exceptionTitleList!=null&&exceptionTitleList.contains(CustomerFormationMasterTabsState.custListBean.mnametitle))
                ){
                  _showAlert(Translations.of(context).text("maritalStatus"),
                      Translations.of(context).text("Title  Do Not match with Marital Status"));
                }
                else{
                  showDropDown(newValue, 2);
                }
              }
            },
            validator: (args) {
            },
            //  isExpanded: true,
            //hint:Text("Select"),
            decoration: InputDecoration(labelText:Translations.of(context).text("marStat")),
            // style: TextStyle(color: Colors.grey),
          ),):new Container(),


//--father name populated by wasasa
          isWasasa? new TextField(
            decoration:  InputDecoration(
              hintText: Translations.of(context).text('entrAppFthrNm'),
              labelText: Translations.of(context).text('appFthrNm'),
              hintStyle: TextStyle(color: Colors.grey),
              /*labelStyle: TextStyle(color: Colors.grey),*/
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  )),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff07426A),
                  )),
              contentPadding: EdgeInsets.all(20.0),
            ),

            inputFormatters: [
              new LengthLimitingTextInputFormatter(100),
              globals.onlyCharacter
            ],
            enabled: isEnabled,
            controller: CustomerFormationMasterTabsState.custListBean.mfathername==null
            ||CustomerFormationMasterTabsState.custListBean.mfathername.trim()==""
            ||CustomerFormationMasterTabsState.custListBean.mfathername.trim()=="null"?
            new TextEditingController(text: ""):
            new TextEditingController(text:CustomerFormationMasterTabsState
                .custListBean.mfathername),

          onChanged:(val) {
              if(val!=null&&val.trim()!="")
              CustomerFormationMasterTabsState.custListBean.mfathername = val[val.length];
            },
            /*onSaved: (String value) {
              CustomerFormationMasterTabsState
                  .custListBean.mfathername = value;
              print("inside wasaa  father name  ${CustomerFormationMasterTabsState
                  .custListBean.mfathername}");
            }*/):
            //--father name
new Container(
  color:isFullerTon==0?Colors.white:Constant.mandatoryColor,
  child: new TextFormField(
      decoration:  InputDecoration(
        hintText: Translations.of(context).text('entrAppFthrNm'),
        labelText: Translations.of(context).text('appFthrNm'),
        hintStyle: TextStyle(color: Colors.grey),
        /*labelStyle: TextStyle(color: Colors.grey),*/
        border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            )),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff07426A),
            )),
        contentPadding: EdgeInsets.all(20.0),
      ),
      enabled: isEnabled,
      inputFormatters: [
        new LengthLimitingTextInputFormatter(100),
        globals.onlyCharacter
      ],
      initialValue: CustomerFormationMasterTabsState
          .custListBean.mfathername !=
          null
          ? CustomerFormationMasterTabsState
          .custListBean.mfathername
          : " ",
      onSaved: (String value) {
        CustomerFormationMasterTabsState
            .custListBean.mfathername = value;
      }),

),
          SizedBox(height: 16.0),
<<<<<<< .mine
          Container(
            color: isMarried==false?Colors.white:Constant.mandatoryColor,
            child: new TextFormField(
              textCapitalization: TextCapitalization.sentences,
              decoration:  InputDecoration(
                hintText: Translations.of(context).text('entrSpouseNam'),
                labelText: Translations.of(context).text('spouseName'),
                hintStyle: TextStyle(color: Colors.grey),
                /*labelStyle: TextStyle(color: Colors.grey),*/
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black,
                )),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xff07426A),
                )),
                contentPadding: EdgeInsets.all(20.0),
              ),
              inputFormatters: [
                new LengthLimitingTextInputFormatter(100),
                globals.onlyCharacter
              ],
              enabled: isEnabled,
              initialValue: CustomerFormationMasterTabsState
                          .custListBean.mhusbandname !=
                      null
                  ? CustomerFormationMasterTabsState
                      .custListBean.mhusbandname
                  : " ",
              onSaved: (String value) {
                CustomerFormationMasterTabsState
                    .custListBean.mhusbandname = value;
              }),
=======
          Container(
            color: isMarried==false?Colors.white:Constant.mandatoryColor,
            child: new TextFormField(

                textCapitalization: TextCapitalization.sentences,
                decoration:  InputDecoration(

                  hintText: Translations.of(context).text('entrSpouseNam'),
                  labelText: Translations.of(context).text('spouseName'),
                  hintStyle: TextStyle(color: Colors.grey),
                  /*labelStyle: TextStyle(color: Colors.grey),*/
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                  )),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xff07426A),
                  )),
                  contentPadding: EdgeInsets.all(20.0),
                ),
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(100),
                  globals.onlyCharacter
                ],
                enabled: isEnabled,
                initialValue: CustomerFormationMasterTabsState
                            .custListBean.mhusbandname !=
                        null
                    ? CustomerFormationMasterTabsState
                        .custListBean.mhusbandname
                    : " ",
                onSaved: (String value) {
                  CustomerFormationMasterTabsState
                      .custListBean.mhusbandname = value;
                }),
          ),
>>>>>>> .r1143
          ),
          SizedBox(height: 20.0,),

          isEnabled==false ||  isFullerTon==1?new Container():
          Container(
<<<<<<< .mine
           color: isMarried==false?Colors.white:Constant.mandatoryColor,
=======

           color: isMarried==false?Colors.white:Constant.mandatoryColor,
>>>>>>> .r1143
            child: new Row(
              children: <Widget>[Text(Constant.husDob)],
            ),
          ),

<<<<<<< .mine
          isEnabled==false?new Container():
          new Container(
            color: isMarried==false?Colors.white:Constant.mandatoryColor,
            child: new Row(
=======
          isEnabled==false ||  isFullerTon==1?new Container():
          new Container(
            color: isMarried==false?Colors.white:Constant.mandatoryColor,
            child: new Row(
>>>>>>> .r1143
              children: <Widget>[
                new Container(
                  width: 50.0,
                  child: new TextField(
                      decoration:
                      InputDecoration(
                          hintText: "DD"
                      ),
                      enabled: isEnabled,
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(2),
                        globals.onlyIntNumber
                      ],
                      controller: tempDayH == null?null:new TextEditingController(text: tempDayH),
                      keyboardType: TextInputType.numberWithOptions(),

                      onChanged: (val){
                        if(val!="0"){
                          tempDayH = val;

                          if(int.parse(val)<=31&&int.parse(val)>0){

                            if(val.length==2){
                              CustomerFormationMasterTabsState.husDob = CustomerFormationMasterTabsState.husDob.replaceRange(0, 2, val);
                              FocusScope.of(context).requestFocus(monthFocusH);
                            }
                            else{
                              CustomerFormationMasterTabsState.husDob = CustomerFormationMasterTabsState.husDob.replaceRange(0, 2, "0"+val);
                            }
                          }
                          else {
                            setState(() {
                              tempDayH ="";
                            });
                          }
                        }
                      }
                  ),
                ),
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

                    enabled: isEnabled,
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(2),
                      globals.onlyIntNumber
                    ],
                    focusNode: monthFocusH,
                    controller: tempMonthH == null?null:new TextEditingController(text: tempMonthH),
                    onChanged: (val){
                      if(val!="0"){
                        tempMonthH = val;
                        if(int.parse(val)<=12&&int.parse(val)>0){

                          if(val.length==2){
                            CustomerFormationMasterTabsState.husDob = CustomerFormationMasterTabsState.husDob.replaceRange(3, 5, val);

                            FocusScope.of(context).requestFocus(yearFocusH);
                          }
                          else{
                            CustomerFormationMasterTabsState.husDob = CustomerFormationMasterTabsState.husDob.replaceRange(3, 5, "0"+val);
                          }
                        }
                        else {
                          setState(() {
                            tempMonthH ="";
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
                      hintText: "YYYY",
                    ),

                    keyboardType: TextInputType.numberWithOptions(),
                    enabled: isEnabled,
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(4),
                      globals.onlyIntNumber
                    ],
                    focusNode: yearFocusH,
                    controller: tempYearH == null?null:new TextEditingController(text: tempYearH),
                    onChanged: (val){
                      tempYearH = val;
                      if(val.length==4) CustomerFormationMasterTabsState.husDob = CustomerFormationMasterTabsState.husDob.replaceRange(6, 10,val);

                    },
                  ),),

                SizedBox(
                  width: 50.0,
                ),

                IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                  _selectHusDate(context);
                } )
              ],
            ),
          ),
          /* new ListTile(

            leading: getTextContainer(globals.radioCaptionsPersonalInfo[0]),
            trailing: yesNo1(),
          ),*/

          //
          isFullerTon==0? Container(
            color: Constant.mandatoryColor,
            child: new DropdownButtonFormField(
              value: ruralUrban,
              items: generateDropDown(10),
              onChanged: (LookupBeanData newValue) {
                showDropDown(newValue, 10);
              },
              validator: (args) {
              },

              decoration: InputDecoration(labelText:Translations.of(context).text( "region")),
              // style: TextStyle(color: Colors.grey),
            ),
          ):new  Container(),
          isSaija==true?Padding(
            padding: const EdgeInsets.only(top: 10),
            child: new Card(
                child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getTextContainer(globals.radioCaptionsPersonalInfo[0]),
                yesNo1(),
              ],
            )),
          ):new Container(),

          //--isnuarance
          isSaija==true?
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: new Card(
                child: new Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    getTextContainer(globals.radioCaptionsPersonalInfo[1]),
                    yesNo2(),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    getTextContainer(globals.radioCaptionsPersonalInfo[4]),
                    yesInsurance(),
                  ],
                ),

              ],
            )),
          ):Container(),

          /*Padding(
            padding: const EdgeInsets.only(top: 10),
            child: new Card(
                child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getTextContainer(globals.radioCaptionsPersonalInfo[2]),
                genderRadio(),
              ],
            )),
          ),*/
    isFullerTon==0?  Container(
            color: Constant.mandatoryColor,
            child: new DropdownButtonFormField(
              value: relegion,
              items: generateDropDown(1),
              onChanged: (LookupBeanData newValue) {
                showDropDown(newValue, 1);
              },
              validator: (args) {
              },
              //  isExpanded: true,
              //hint:Text("Select"),
              decoration: InputDecoration(labelText:Translations.of(context).text("religion")),
              // style: TextStyle(color: Colors.grey),
            ),
      ):new  Container(),
          Container(
            color: Constant.mandatoryColor,
            child: new DropdownButtonFormField(
              value: qualification==null?null: qualification,
              items: generateDropDown(3),
              onChanged: (LookupBeanData newValue) {
                showDropDown(newValue, 3);
              },
              validator: (args) {
              },
              //  isExpanded: true,
              //hint:Text("Select"),
              decoration: InputDecoration(labelText:isFullerTon==0?Translations.of(context).text("qual"):Translations.of(context).text("education")),
              // style: TextStyle(color: Colors.grey),
            ),
          ),

          isEnabled==false?new Container():

          isFullerTon==0? new Container(
            color: isWasasa==true?Constant.mandatoryColor:Colors.white,
            child: new DropdownButtonFormField(
            value: caste==null?null:caste,
            items: generateDropDown(5),
            onChanged: (LookupBeanData newValue) {
              showDropDown(newValue, 5);
            },
            validator: (args) {
              print(args);
            },
            //  isExpanded: true,
            //hint:Text("Select"),
            decoration: InputDecoration(labelText: isWasasa==true?Translations.of(context).text("ethnicity"):

            Translations.of(context).text("caste")),
            // style: TextStyle(color: Colors.grey),
          ),
          ):new Container(),



          /*Padding(
              padding: const EdgeInsets.only(top: 10),
              child: new Card(
                  child: new Column(children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    getTextContainer(globals.radioCaptionsPersonalInfo[3]),
                    regionRadio(),
                  ],
                ),
              ]))),*/
          isEnabled==false || isFullerTon==1?new Container():
              new Container(
                  color: Constant.mandatoryColor,
                  child:

              new DropdownButtonFormField(
                value: motherTongue==null?null:motherTongue,
                items: generateDropDown(7),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 7);
                },
                validator: (args) {
                },
                //  isExpanded: true,
                //hint:Text("Select"),
                decoration: InputDecoration(labelText: Translations.of(context).text("mthrTng")),
                // style: TextStyle(color: Colors.grey),
              )),


          Divider(),


          Container(
            color: isWasasa==true || isFullerTon==1?Constant.mandatoryColor:Colors.white,

            child: new DropdownButtonFormField(
              value: occupation==null?null:occupation,
              items: generateDropDown(4),
              onChanged: (LookupBeanData newValue) {
                showDropDown(newValue, 4);
              },
              validator: (args) {
                print(args);
              },
              //  isExpanded: true,
              //hint:Text("Select"),
              decoration: InputDecoration(labelText: Translations.of(context).text("occp")),
              // style: TextStyle(color: Colors.grey),
            ),
          ),
          isWasasa==true ||  isFullerTon==1?new Container():
          new DropdownButtonFormField(
            value: secondryOccuptn==null?null:secondryOccuptn,
            items: generateDropDown(8),
            onChanged: (LookupBeanData newValue) {
              showDropDown(newValue, 8);
            },
            validator: (args) {

            },
            //  isExpanded: true,
            //hint:Text("Select"),
            decoration: InputDecoration(labelText: Translations.of(context).text("secOccp")),
            // style: TextStyle(color: Colors.grey),
          ),
<<<<<<< .mine


          isFullerTon==1?  Container(
            child: new TextFormField(
              decoration: InputDecoration(
                //hintText: 'Enter Post here',
                //labelText: 'Post',
                hintText: Translations.of(context).text('entrisDependent'),//changed to no.of rooms from post
                labelText: Translations.of(context).text('isDependent'),
                hintStyle: TextStyle(color: Colors.grey),
                /*labelStyle: TextStyle(color: Colors.grey),*/
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    )),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff5c6bc0),
                    )),
                contentPadding: EdgeInsets.all(20.0),
              ),
              keyboardType: TextInputType.number,
              controller: CustomerFormationMasterTabsState.custListBean.mmemberno!= null
                  ? TextEditingController(text: CustomerFormationMasterTabsState.custListBean.mmemberno.toString())
                  : TextEditingController(text: ""),
              inputFormatters: [
                new LengthLimitingTextInputFormatter(2),
                globals.onlyIntNumber
              ],
              onSaved: (val) {
                if(val!=null&&val!="") {
                  try{
                    CustomerFormationMasterTabsState.custListBean.mmemberno = int.parse(val);
                  }catch(e){

                  }

                }
              },
            ),
          ):new  Container(),

          isFullerTon==1? new TextFormField(
            decoration: InputDecoration(
              hintText: Translations.of(context).text('entrdesignation'),
              labelText: Translations.of(context).text('designation'),
              hintStyle: TextStyle(color: Colors.grey),
              /*labelStyle: TextStyle(color: Colors.grey),*/
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  )),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff5c6bc0),
                  )),
              contentPadding: EdgeInsets.all(20.0),
            ),
            controller: CustomerFormationMasterTabsState.custListBean.designation != null
                ? TextEditingController(text: CustomerFormationMasterTabsState.custListBean.designation)
                : TextEditingController(text: ""),
            inputFormatters: [
              new LengthLimitingTextInputFormatter(80),
              globals.onlyCharacter
            ],
            onSaved: (val) {
              //  if(val!=null) {
              CustomerFormationMasterTabsState.custListBean.designation = val;
              // }
            },
          ):new  Container(),

          isFullerTon==1? new TextFormField(
            decoration: InputDecoration(
              hintText: Translations.of(context).text('entrorgName'),
              labelText: Translations.of(context).text('orgName'),
              hintStyle: TextStyle(color: Colors.grey),
              /*labelStyle: TextStyle(color: Colors.grey),*/
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  )),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff5c6bc0),
                  )),
              contentPadding: EdgeInsets.all(20.0),
            ),
            controller: CustomerFormationMasterTabsState.custListBean.orgName != null
                ? TextEditingController(text: CustomerFormationMasterTabsState.custListBean.orgName)
                : TextEditingController(text: ""),
            inputFormatters: [
              new LengthLimitingTextInputFormatter(80),
              globals.onlyCharacter
            ],
            onSaved: (val) {
              //  if(val!=null) {
              CustomerFormationMasterTabsState.custListBean.orgName = val;
              // }
            },
          ):new  Container(),

          isFullerTon==1? new TextFormField(
            decoration: InputDecoration(
              hintText: Translations.of(context).text('entryearsInOrg'),
              labelText: Translations.of(context).text('yearsInOrg'),
              hintStyle: TextStyle(color: Colors.grey),
              /*labelStyle: TextStyle(color: Colors.grey),*/
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  )),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff5c6bc0),
                  )),
              contentPadding: EdgeInsets.all(20.0),
            ),
            keyboardType: TextInputType.text,
            controller: CustomerFormationMasterTabsState.custListBean.yearsInOrg != null
                ? TextEditingController(text: CustomerFormationMasterTabsState.custListBean.yearsInOrg)
                : TextEditingController(text: ""),
            inputFormatters: [
              new LengthLimitingTextInputFormatter(80),
              globals.onlyAphaNumeric

            ],
            onSaved: (val) {
              //  if(val!=null) {
              CustomerFormationMasterTabsState.custListBean.yearsInOrg = val;
              // }
            },
          ):new  Container(),
=======


          isFullerTon==1?  Container(
                color:isFullerTon==0?Colors.white:Constant.mandatoryColor,
            child: new TextFormField(
              decoration: InputDecoration(
                //hintText: 'Enter Post here',
                //labelText: 'Post',
                hintText: Translations.of(context).text('entrisDependent'),//changed to no.of rooms from post
                labelText: Translations.of(context).text('isDependent'),
                hintStyle: TextStyle(color: Colors.grey),
                /*labelStyle: TextStyle(color: Colors.grey),*/
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    )),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff5c6bc0),
                    )),
                contentPadding: EdgeInsets.all(20.0),
              ),
              keyboardType: TextInputType.number,
              controller: CustomerFormationMasterTabsState.custListBean.mmemberno!= null
                  ? TextEditingController(text: CustomerFormationMasterTabsState.custListBean.mmemberno.toString())
                  : TextEditingController(text: ""),
              inputFormatters: [
                new LengthLimitingTextInputFormatter(2),
                globals.onlyIntNumber
              ],
              onSaved: (val) {
                if(val!=null&&val!="") {
                  try{
                    CustomerFormationMasterTabsState.custListBean.mmemberno = int.parse(val);
                  }catch(e){
                  }
                }
              },
            ),
          ):new  Container(),
          isFullerTon==1? new TextFormField(
            decoration: InputDecoration(
              hintText: Translations.of(context).text('entrdesignation'),
              labelText: Translations.of(context).text('designation'),
              hintStyle: TextStyle(color: Colors.grey),
              /*labelStyle: TextStyle(color: Colors.grey),*/
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  )),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff5c6bc0),
                  )),
              contentPadding: EdgeInsets.all(20.0),
            ),
            controller: CustomerFormationMasterTabsState.custListBean.designation != null
                ? TextEditingController(text: CustomerFormationMasterTabsState.custListBean.designation)
                : TextEditingController(text: ""),
            inputFormatters: [
              new LengthLimitingTextInputFormatter(80),
              globals.onlyCharacter
            ],
            onSaved: (val) {
              //  if(val!=null) {
              CustomerFormationMasterTabsState.custListBean.designation = val;
              // }
            },
          ):new  Container(),
          isFullerTon==1? new TextFormField(
            decoration: InputDecoration(
              hintText: Translations.of(context).text('entrorgName'),
              labelText: Translations.of(context).text('orgName'),
              hintStyle: TextStyle(color: Colors.grey),
              /*labelStyle: TextStyle(color: Colors.grey),*/
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  )),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff5c6bc0),
                  )),
              contentPadding: EdgeInsets.all(20.0),
            ),
            controller: CustomerFormationMasterTabsState.custListBean.orgName != null
                ? TextEditingController(text: CustomerFormationMasterTabsState.custListBean.orgName)
                : TextEditingController(text: ""),
            inputFormatters: [
              new LengthLimitingTextInputFormatter(80),
              globals.onlyCharacter
            ],
            onSaved: (val) {
              //  if(val!=null) {
              CustomerFormationMasterTabsState.custListBean.orgName = val;
              // }
            },
          ):new  Container(),
          isFullerTon==1? new TextFormField(
            decoration: InputDecoration(
              hintText: Translations.of(context).text('entryearsInOrg'),
              labelText: Translations.of(context).text('yearsInOrg'),
              hintStyle: TextStyle(color: Colors.grey),
              /*labelStyle: TextStyle(color: Colors.grey),*/
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  )),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff5c6bc0),
                  )),
              contentPadding: EdgeInsets.all(20.0),
            ),
            keyboardType: TextInputType.text,
            controller: CustomerFormationMasterTabsState.custListBean.yearsInOrg != null
                ? TextEditingController(text: CustomerFormationMasterTabsState.custListBean.yearsInOrg)
                : TextEditingController(text: ""),
            inputFormatters: [
              new LengthLimitingTextInputFormatter(80),
              globals.onlyIntNumber
            ],
            onSaved: (val) {
              //  if(val!=null) {
              CustomerFormationMasterTabsState.custListBean.yearsInOrg = val;
              // }
            },
          ):new  Container(),
>>>>>>> .r1143
          new Card(
            color: isWasasa==true || isFullerTon==1?Constant.mandatoryColor:Colors.white,
            child: new ListTile(
                title: new Text(isFullerTon==0?Translations.of(context).text("mainOccp"):Translations.of(context).text("Sector")),
                subtitle: CustomerFormationMasterTabsState.custListBean.mmainoccupn == null
                    ? new Text("")
                    : new Text(isFullerTon==0?"Main Occupation : ${CustomerFormationMasterTabsState.custListBean.mmainoccupndesc}   And Code : ${CustomerFormationMasterTabsState.custListBean.mmainoccupn}":
                    "Sector : ${CustomerFormationMasterTabsState.custListBean.mmainoccupndesc}   And Code : ${CustomerFormationMasterTabsState.custListBean.mmainoccupn}"),
                onTap: () => getMainOccupation(isFullerTon==0?"mainoccupation":"Sector",0 )),
          ),
          new Card(
            color:isWasasa==true || isFullerTon==1?Constant.mandatoryColor:Colors.white,
            child: new ListTile(
                title: new Text(isFullerTon==0?Translations.of(context).text("subOccp"):Translations.of(context).text("Industry")),
                subtitle: CustomerFormationMasterTabsState.custListBean.msuboccupn == null
                    ? new Text("")
                    : new Text(isFullerTon==0?"Sub Occupation : ${CustomerFormationMasterTabsState.custListBean.msuboccupndesc}   And Code : ${CustomerFormationMasterTabsState.custListBean.msuboccupn}":
                "Industry : ${CustomerFormationMasterTabsState.custListBean.msuboccupndesc}   And Code : ${CustomerFormationMasterTabsState.custListBean.msuboccupn}"),

                onTap: () => getSubOccupation(isFullerTon==0?"suboccupation":"Industry",
                    int.parse(CustomerFormationMasterTabsState.custListBean.mmainoccupn != null ? CustomerFormationMasterTabsState.custListBean.mmainoccupn : 0))),
          ),
          SizedBox(height: 16.0),


















          Center(

              /*child: new Table(children: [


              */ /*new TableRow(
                  decoration: new BoxDecoration(

                    border: Border.all(color: Colors.grey, width: 0.1),
                  ),
                  children: [
                    getTextContainer(globals.dropdownCaptionsPersonalInfo[0]),
                    //ifYesThen(),


                    new DropdownButtonFormField(
                      value : ifYesThen,
                      items:  generateDropDown(0),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue,0);
                      },
                      validator: (args){
                        print(args);
                      },
                      //  isExpanded: true,
                      //hint:Text("Select"),
                      decoration: InputDecoration(
                          labelText: "if Yes Then"
                      ),
                      // style: TextStyle(color: Colors.grey),
                    ),
                    */ /**/ /*new DropdownButton(
                      value : ifYesThen,
                      items:  generateDropDown(0),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue,0);
                      },
                      isExpanded: true,
                      hint:Text("Select"),
                      style: TextStyle(color: Colors.grey),
                    ),*/ /**/ /*
                  ]),*/ /*
              new TableRow(
                  decoration: new BoxDecoration(

                    border: Border.all(color: Colors.grey, width: 0.1),
                  ),
                  children: [
                    getTextContainer(globals.radioCaptionsPersonalInfo[2]),
                    genderRadio(),
                  ]),
              new TableRow(
                  decoration: new BoxDecoration(

                    border: Border.all(color: Colors.grey, width: 0.1),
                  ),
                  children: [
                    getTextContainer(globals.dropdownCaptionsPersonalInfo[1]),
                    //relegionRadio(),
                    new DropdownButton(

                      value : relegion,
                      items:  generateDropDown(1),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue,1);
                      },
                      isExpanded: true,
                      hint:Text("Select"),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ]),
              new TableRow(
                  decoration: new BoxDecoration(
                    color: Constant.mandatoryColor,
                    border: Border.all(color: Colors.grey, width: 0.1),
                  ),
                  children: [
                    getTextContainer(globals.dropdownCaptionsPersonalInfo[2]),
                    //maritialStatusRadio(),
                    new DropdownButton(
                      value : maritialStatus,
                      items:  generateDropDown(2),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue,2);
                      },

                      isExpanded: true,
                      hint:Text("Select"),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ]),
              new TableRow(
                  decoration: new BoxDecoration(

                    border: Border.all(color: Colors.grey, width: 0.1),
                  ),
                  children: [
                    getTextContainer(globals.dropdownCaptionsPersonalInfo[3]),
                    //qualificationRadio(),
                    new DropdownButton(
                      value : qualification,
                      items:  generateDropDown(3),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue,3);
                      },

                      isExpanded: true,
                      hint:Text("Select"),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ]),
              new TableRow(
                  decoration: new BoxDecoration(

                    border: Border.all(color: Colors.grey, width: 0.1),
                  ),
                  children: [
                    getTextContainer(globals.dropdownCaptionsPersonalInfo[4]),
                    //occupationRadio(),
                    new DropdownButton(

                      value : occupation,
                      items:  generateDropDown(4),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue,4);
                      },

                      isExpanded: true,
                      hint:Text("Select"),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ]),
              new TableRow(
                  decoration: new BoxDecoration(

                    border: Border.all(color: Colors.grey, width: 0.1),
                  ),
                  children: [
                    getTextContainer(globals.dropdownCaptionsPersonalInfo[5]),
                    //casteRadio(),
                    new DropdownButton(
                      value : caste,
                      items:  generateDropDown(5),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue,5);
                      },

                      isExpanded: true,
                      hint:Text("Select"),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ]),
              new TableRow(
                  decoration: new BoxDecoration(

                    border: Border.all(color: Colors.grey, width: 0.1),
                  ),
                  children: [
                    getTextContainer(globals.radioCaptionsPersonalInfo[3]),
                    // new Container(),
                    regionRadio(),
                  ]),
            ]),
          ),*/

              )
        ],
      ),
    );
  }


  Future getMainOccupation(String purposeMode, int selectedPosition) async {
    mainOcc = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForMainOccupationSelection(position: selectedPosition),
          fullscreenDialog: true,
        )).then<SubLookupForSubPurposeOfLoan>((purposeObjVal) {



      //subPurposeName=purposeObjVal.codeDesc;
      //subPurposeId = purposeObjVal.code;
      if(purposeObjVal.codeDesc!=null&&purposeObjVal.code!=null){


        CustomerFormationMasterTabsState.custListBean.mmainoccupndesc = purposeObjVal.codeDesc;
        CustomerFormationMasterTabsState.custListBean.mmainoccupn = (purposeObjVal.code.trim());
      }
    });
    /*  if (purposeMode == "subpurpose") {
//   if (purposeObj??  purposeObj.codeDesc??  purposeObj.code?? ) {
      subPurposeName = purposeObj.codeDesc ?? "";
      subPurposeId = purposeObj.code;
      // }
    }*/
  }

  Future getSubOccupation(String purposeMode, int selectedPosition) async {
    mainOcc = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForSubOccupationSelection(position: selectedPosition),
          fullscreenDialog: true,
        )).then<SubLookupForSubPurposeOfLoan>((purposeObjVal) {

      //subPurposeName=purposeObjVal.codeDesc;
      //subPurposeId = purposeObjVal.code;
      if(purposeObjVal.codeDesc!=null&&purposeObjVal.code!=null){
        CustomerFormationMasterTabsState.custListBean.msuboccupndesc = purposeObjVal.codeDesc;
        CustomerFormationMasterTabsState.custListBean.msuboccupn = (purposeObjVal.code.trim());
      }
    });
    /*  if (purposeMode == "subpurpose") {
//   if (purposeObj??  purposeObj.codeDesc??  purposeObj.code?? ) {
      subPurposeName = purposeObj.codeDesc ?? "";
      subPurposeId = purposeObj.code;
      // }
    }*/
  }


  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now().subtract(Duration(days: 1)),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now().subtract(Duration(days: 1)));
    if (picked != null && picked != CustomerFormationMasterTabsState
        .custListBean.mdob)
      setState(() {
        CustomerFormationMasterTabsState.custListBean.mdob= picked;
        tempDate = formatter.format(picked);
        if(picked.day.toString().length==1){
          tempDay = "0"+picked.day.toString();

        }
        else tempDay = picked.day.toString();
        CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(0, 2, tempDay);
        tempYear = picked.year.toString();
        CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(6, 10,tempYear);
        if(picked.month.toString().length==1){
          tempMonth = "0"+picked.month.toString();
        }
        else
        tempMonth = picked.month.toString();
        CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(3, 5, tempMonth);

      });
  }


  Future<Null> _selectHusDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now().subtract(Duration(days: 1)),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now().subtract(Duration(days: 1))
    );
    if (picked != null && picked != CustomerFormationMasterTabsState.custListBean.mhusdob)
      setState(() {
        CustomerFormationMasterTabsState.custListBean.mhusdob= picked;
        tempDateH = formatter.format(picked);
        if(picked.day.toString().length==1){
          tempDayH = "0"+picked.day.toString();

        }
        else tempDayH = picked.day.toString();
        CustomerFormationMasterTabsState.husDob = CustomerFormationMasterTabsState.husDob.replaceRange(0, 2, tempDayH);
        tempYearH = picked.year.toString();
        CustomerFormationMasterTabsState.husDob = CustomerFormationMasterTabsState.husDob.replaceRange(6, 10,tempYearH);
        if(picked.month.toString().length==1){
          tempMonthH = "0"+picked.month.toString();
        }
        else
          tempMonthH = picked.month.toString();
        CustomerFormationMasterTabsState.husDob = CustomerFormationMasterTabsState.husDob.replaceRange(3, 5, tempMonthH);

      });
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

}

class PersonalInfo {
  String title = " ";
  String loanAgreed = " ";
  String insurance = " ";
  String ifYesThen = " ";
  String gender = " ";
  String relegion = " ";
  String maritialStatus = " ";
  String qualification = " ";
  String occupation = " ";
  String caste = " ";
  String region = " ";

  PersonalInfo(
      this.loanAgreed,
      this.insurance,
      this.ifYesThen,
      this.gender,
      this.relegion,
      this.maritialStatus,
      this.qualification,
      this.occupation,
      this.caste,
      this.region);
}
