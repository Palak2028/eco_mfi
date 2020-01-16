import 'dart:async';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/pages/workflow/FPSPages/BiometricCheck.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFoundation.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanDetailsMasterTab.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart' as constantResource;
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/FullScreenDialogForGroupSelection.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/FullScreenDialogForProductSelection.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/FullScreenDialogForPurposeSelection.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/List/CustomerLoanDetailsList.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/RepaymentFrequency.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/TransactionMode.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/FullScreenDialogForCenterSelection.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_mfi/pages/workflow/statusDetails/CCGTab.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class LoanLimitDetails extends StatefulWidget {
  /*CustomerLoanDetailsBean  laonLimitPassedObject;
  LoanLimitDetails({Key key, this.laonLimitPassedObject}) : super(key: key);*/

  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );
  @override
  _LoanLimitDetailsState createState() => new _LoanLimitDetailsState();
}

class _LoanLimitDetailsState extends State<LoanLimitDetails> {
  FullScreenDialogForCenterSelection _myCenterDialog =
      new FullScreenDialogForCenterSelection("");
  FullScreenDialogForGroupSelection _myGroupDialog =
      new FullScreenDialogForGroupSelection("");

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TabController _tabController;
  ProductBean prodObj = new ProductBean();
  SubLookupForSubPurposeOfLoan purposeObj = new SubLookupForSubPurposeOfLoan();
  TransactionMode transObj = new TransactionMode();
  RepaymentFrequency RepayFreqObj = new RepaymentFrequency();
  SystemParameterBean sysBean = new SystemParameterBean();
  List isMemberOfGroupListLoan = [0];
  String misIndividual = "Y";
  String mIsCustomerSelected = null;
  bool isMemeberOfGroupForLoan = true;
  int isBiometricNeeded = 0;

  String productName = "";
  int productId = null;
  double rateOfInterest;
  String purposeName = "";
  int purposeId = null;
  String subPurposeName = "";
  String subPurposeId;
  String disbursmentMode = "";
  int disbursmentModeId = null;
  String collectionMode = "";
  int collectionModeId = null;
  double canApplyMaxAmount = 0.0;
  double canApplyMaxInst = 0.0;
  double canApplyMinAmount = 0.0;
  double canApplyMinInst = 0.0;
  LookupBeanData frequency;
  LookupBeanData repaymentmode;
  LookupBeanData modeofdisb;
  LookupBeanData purpose;
  int isFullerTon=0;

  DateTime selectedDate = DateTime.now();
  //final dateFormat = DateFormat("EEEE, MMMM d, yyyy");
  DateTime date;
  TimeOfDay time;
  final dateFormat = DateFormat("yyyy/MM/dd");
  var formatter = new DateFormat('dd-MM-yyyy');
  String tempDate = "----/--/--";
  String tempYear;
  String tempDay;
  String tempMonth;
  bool boolValidate = false;
  int loanCycle = 0;
  int loanNumber;
  int branch;
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;
  String loanDisbDt = "__-__-____";
  String loaninstStrtDt = "__-__-____";
  FocusNode monthFocus;
  FocusNode yearFocus;
  FocusNode monthInstStrtFocus;
  FocusNode yearInstStrtFocus;
  String tempInstStrtDate = "----/--/--";
  String tempInstStrtYear;
  String tempInstStrtDay;
  String tempInstStrtMonth;
  int mgrpID;
  int mcenterId;
  bool fieldEnabled = true;
  String operationDate;
  bool diplayinststrtfld = false;


  @override
  void initState() {

    super.initState();

    //select amout salb based on tier field from customer
    print("mapplied as ind is ${CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappliedasind}");

    if( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt!=null
        &&CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.toString().trim()!="null"&&
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.toString().trim()!=""
    ){
      loaninstStrtDt = CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.toString();
    }

    if (!loaninstStrtDt.contains("_")) {
      try {
        DateTime formattedDate = DateTime.parse(loaninstStrtDt);
        tempInstStrtDay = formattedDate.day.toString();
        tempInstStrtMonth = formattedDate.month.toString();
        tempInstStrtYear = formattedDate.year.toString();
        loaninstStrtDt = tempInstStrtDay.toString() +"-"+tempInstStrtMonth.toString()+"-"+tempInstStrtYear.toString();
        setState(() {});
      } catch (e) {
        print("Exception Occupred in installment start date ");
      }
    }
    getSessionVariables();


    monthFocus = new FocusNode();
    yearFocus = new FocusNode();
    monthInstStrtFocus = new FocusNode();
    yearInstStrtFocus = new FocusNode();
      List<String> tempDropDownValues = new List<String>();
    tempDropDownValues.add( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mpurposeofLoan.toString());
    tempDropDownValues.add( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency);
    tempDropDownValues.add( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrepaymentmode.toString());
    tempDropDownValues.add( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mmodeofdisb.toString());




    for (int k = 0;
    k < globals.dropdownCaptionsValuesCustLoanDetailsInfo.length;
    k++) {
      for (int i = 0;
      i < globals.dropdownCaptionsValuesCustLoanDetailsInfo[k].length;
      i++) {
        if (globals.dropdownCaptionsValuesCustLoanDetailsInfo[k][i].mcode ==
            tempDropDownValues[k]) {
          setValue(k, globals.dropdownCaptionsValuesCustLoanDetailsInfo[k][i]);
        }
      }
    }
    if (globals.applicationDate == null) {
      globals.applicationDate = DateTime.now();
    }
    //  cusLoanObj.customerNumber = custListObj.customerNumber;
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.trefno != null) {
      // CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj =  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj;
    } else {
      AppDatabase.get().getMaxCustomerLoanNumber().then((val) {
        setState(() {
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.trefno = val;
        });

      });
    }

  }
Future<Null> getSubpurposeOnEditMode()async{


    if( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mpurposeofLoan!=null){
      await AppDatabase.get()
          .getSunPurposeOfLoanListFromSubLookpTable(4000, CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mpurposeofLoan)
          .then((List<SubLookupForSubPurposeOfLoan> response){
        for(int subPurpose =0;subPurpose<response.length;subPurpose++){
          if(response[subPurpose].code!=null &&  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.msubpurposeofloan!=null) {
            if (response[subPurpose].code.trim() ==
                 CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.msubpurposeofloan.toString()) {
               CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.msubpurposeofloandesc = response[subPurpose].codeDesc;
              break;
            }
          }
        }
      });

    }

}
  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode);
      reportingUser = prefs.getString(TablesColumnFile.mreportinguser);
      username = prefs.getString(TablesColumnFile.musrcode);
      usrRole = prefs.getString(TablesColumnFile.musrdesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.mgrpcd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);

            geoLocation = prefs.getString(TablesColumnFile.geoLocation);
      try {
        isFullerTon = prefs.getInt(TablesColumnFile.ISFULLERTON);
      }catch(_){}

      try{
        geoLatitude = prefs.getDouble(TablesColumnFile.geoLatitude).toString();
        geoLongitude = prefs.getDouble(TablesColumnFile.geoLongitude).toString();
      }catch(_){
        print("Exception in getting loangitude");
      }

      if (prefs.getString(TablesColumnFile.misIndividual) != null &&
          prefs.getString(TablesColumnFile.misIndividual).trim() !=
              "") {
        misIndividual =
            prefs.getString(TablesColumnFile.misIndividual);

        if (misIndividual != null &&
            misIndividual.trim().toUpperCase() == 'N') {
          isMemeberOfGroupForLoan = false;
        }
      }
      print(prefs.getString(TablesColumnFile.misIndividual));
      isBiometricNeeded = prefs.getInt(TablesColumnFile.ISBIOMETRICNEEDED);
      operationDate = prefs.getString(TablesColumnFile.branchOperationalDate);
      print("Operational Date ${operationDate}");


      if( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloandisbdt!=null
          &&CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloandisbdt.toString().trim()!="null"&&
          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloandisbdt.toString().trim()!=""
      ){
        // cusLoanObj =  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj;
        loanDisbDt =  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloandisbdt.toString();
      }else{
        if(operationDate!=null&&operationDate.trim()!=''&&operationDate.trim()!='null'){

          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloandisbdt = DateTime.parse(operationDate);
          loanDisbDt =  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloandisbdt.toString();
          print("After saving ${CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloandisbdt}");

        }

      }






      if (!loanDisbDt.contains("_")) {

        print("Coming Inside");
        try {
          DateTime formattedDate = DateTime.parse(loanDisbDt);
          tempDay = formattedDate.day.toString();
          tempMonth = formattedDate.month.toString();
          tempYear = formattedDate.year.toString();
          loanDisbDt = tempDay.toString() +"-"+tempMonth.toString()+"-"+tempYear.toString();
          setState(() {});
        } catch (e) {
          print("Exception Occupred");
        }
      }




      if(CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd!=null&&
          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd.trim()!='null'&&
          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd.trim()!=''
      ){


        AppDatabase.get().
        getProductOnPrdCd(30,branch,CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd.trim()).then((ProductBean prdObj){
          if(prodObj.mdivisiontype!=null&&(prodObj.mdivisiontype.trim()=="I"||prodObj.mdivisiontype.trim()=="B")){
            diplayinststrtfld= true;


          }else{
            diplayinststrtfld= false;
            CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt =null;
          }
        });


      }

    });
  }




  //LookupBeanData blankBean = new LookupBeanData(codeDesc: "",code: "",codeType: 0);

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
        k < globals.dropdownCaptionsValuesCustLoanDetailsInfo[no].length;
        k++) {
      mapData.add(globals.dropdownCaptionsValuesCustLoanDetailsInfo[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
         return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc),
      );
    }).toList();

    return _dropDownMenuItems1;
  }


  showDropDown(LookupBeanData selectedObj, int no) {

      if (selectedObj.mcodedesc.isEmpty) {

      switch (no) {
        case 0:
          purpose = blankBean;
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mpurposeofLoan = 0;
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.msubpurposeofloan =null;
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.msubpurposeofloandesc=null;
          break;
        case 1:
          frequency = blankBean;
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency = blankBean.mcode;
          break;
        case 2:
          repaymentmode = blankBean;
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrepaymentmode = 0;
          break;
        case 3:
          modeofdisb = blankBean;
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mmodeofdisb = 0;
          break;
        default:
          break;
      }
      setState(() {});
    } else {
      bool isBreak = false;
      for (int k = 0;
          k < globals.dropdownCaptionsValuesCustLoanDetailsInfo[no].length;
          k++) {

        if (globals.dropdownCaptionsValuesCustLoanDetailsInfo[no][k].mcodedesc
                .trim() ==
            selectedObj.mcodedesc.trim()) {
          setValue(no, selectedObj);
          isBreak = true;
          break;
        }
        if (isBreak) {
          break;
        }
      }
    }
  }

  setValue(int no, LookupBeanData value) async{
    setState(() {

      switch (no) {
        case 0:

          purpose = value;
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mpurposeofLoan = int.parse(value.mcode);
          if( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.msubpurposeofloan==null) {
             CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.msubpurposeofloan = null;
             CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.msubpurposeofloandesc = null;
          }

          break;
        case 1:

          frequency = value;
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency = value.mcode;

          break;
        case 2:
          repaymentmode = value;
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrepaymentmode = int.parse(value.mcode);
          break;
        case 3:
          modeofdisb = value;
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mmodeofdisb = int.parse(value.mcode);
          break;
        default:
          break;
      }
    });

    if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd != null &&   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloancycle !=null &&
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency != null && branch!=null&&branch > 0){


      await AppDatabase.get()
          .selectMaxLoanAmtCanApply(
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd.trim().toString(),
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloancycle+1,
          branch,
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency)
          .then((onValue) {


            if(onValue==null||onValue.isEmpty){
              canApplyMaxAmount = 0.0;
              canApplyMinAmount = 0.0;
              canApplyMaxInst = 0.0;
              canApplyMinInst = 0.0;
            }
        for (int secondLoanCycle = 0;
            secondLoanCycle < onValue.length;
            secondLoanCycle++) {
          if(onValue[secondLoanCycle].mruletype ==1){
            canApplyMaxAmount = onValue[secondLoanCycle].mmaxamount;
            canApplyMinAmount = onValue[secondLoanCycle].mminamount;
          } else if (onValue[secondLoanCycle].mruletype == 2)
            canApplyMaxInst = onValue[secondLoanCycle].mmaxamount;
          canApplyMinInst = onValue[secondLoanCycle].mminamount;
        }
        setState(() {});
      });
    }
  }

  LookupBeanData blankBean =
      new LookupBeanData(mcodedesc: "", mcode: "", mcodetype: 0);

  Widget getTextContainer(String textValue) {
    return new Container(
      padding: EdgeInsets.fromLTRB(5.0, 20.0, 0.0, 20.0),
      child: new Text(
        textValue,

        textAlign: TextAlign.start,

        style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontStyle: FontStyle.normal,
            fontSize: 12.0),
      ),
    );
  }

  Widget groupLending() => LoanLimitDetails._get(new Row(
    children: _makeRadios(2, globals.radioCaptionValuesIsMemberOfGroup, 0),
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  ));

  List<Widget> _makeRadios(int numberOfRadios, List textName, int position) {
    List<Widget> radios = new List<Widget>();
    for (int i = 0; i < numberOfRadios; i++) {
      radios.add(new Row(
        children: <Widget>[
          new Text(
            textName[i],
            textAlign: TextAlign.right,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontStyle: FontStyle.normal,
              fontSize: 10.0,
            ),
          ),
          new Radio(
            value: i,
            groupValue:   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappliedasind==null ||   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappliedasind=='null'?0:int.parse( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappliedasind) ,
            onChanged: (selection) {
              if ((mgrpID != null &&
<<<<<<< .mine
                  mgrpID == 0)||(mgrpID == cusLoanObj.mcustno&&cusLoanObj.mcustno!=0)) {
=======
                  mgrpID == 0)||(mgrpID ==   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustno&&  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustno!=0)) {
>>>>>>> .r1143
                return null;
              }
              return _onRadioSelected(selection, position);
            },
            activeColor: Color(0xff07426A),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      ));
    }
    return radios;
  }

  _onRadioSelected(int selection, int position) {
     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdname ="";
     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd ="";
    setState(() =>   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappliedasind = selection.toString());
    if (position == 0) {
      if (globals.radioCaptionValuesIsMemberOfGroup[selection] == 'Yes') {
        isMemeberOfGroupForLoan = false;
      } else {
        isMemeberOfGroupForLoan = true;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    setState(() {

    });
    return new Scaffold(
      key: _scaffoldKey,
      body: new Form(
        key: _formKey,
        autovalidate: false,
        onWillPop: () {
          return Future(() => true);
        },
        onChanged: () async {
          final FormState form = _formKey.currentState;
          form.save();
          await calculate();
          setState(() {});
        },
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(0.0),
          children: <Widget>[


            SizedBox(),

            Align(
              alignment: Alignment.center,
              child: new RichText(text:
              TextSpan(
                text:  Translations.of(context).text('BRANCH'),
                  style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight:FontWeight.bold),
                children: [
                  new TextSpan(
                      text:" :   ",
                      style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight:FontWeight.bold)

                  )

                  ,new TextSpan(
                  text:"${CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mbranchName==null||
                      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mbranchName.trim()=='null'?
                      ""
                      :
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mbranchName.trim()
                      }",
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20.0)

                )]
              )

           ),
            ),

            SizedBox(),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('loan_tablet_ref_number')),
                subtitle: new Text("${  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.trefno}"),
              ),
            ),
            new Card(
              child: new ListTile(
                  title: new Text(Translations.of(context).text('customer_number_and_name')),
                  subtitle:   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustno == null
                      ? new Text("")
                      : new Text(
                          "${  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustno.toString() + " " +   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustname.toString()}"),
                  onTap: () => getCustomerNumber()),
            ),

            isBiometricNeeded==0?new Container():new Text(
              "Biometric Check",
              textAlign: TextAlign.center,
            ),

            isBiometricNeeded==0?new Container():new FingerScannerImageAsset(
              mIsCustomerSelected: mIsCustomerSelected,mrefno:  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustmrefno,trefno:  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcusttrefno,routeType:"Loan Application"
            ),
            isBiometricNeeded==0?new Container():new CheckboxListTile(
                value:  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj!=null&& CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcheckbiometric!=null
                    &&  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcheckbiometric==1? true:false,
                title: new Text(
                    "I declare that i want to override the biometric result."),
                onChanged: (bool val) {
                  setState(() {

                    print("Val is ${val}");
                    if(val==true){
                       CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcheckbiometric = 1;

                    }else{


                       CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcheckbiometric = 0;
                    }

                  });
                }),

            misIndividual == "Y"
                ? new Card(
                child:new Table(children: [
              new TableRow(
                  decoration: new BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.1),
                  ),
                  children: [
                    getTextContainer(
                        globals.radioCaptionAppliedAsInd[0]),
                    groupLending(),
                  ]),
            ]))
                : Container(),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('product')),
                subtitle:   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdname == null &&   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd == null
                    ? new Text("")
                    : new Text("${  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdname.trim() == null ||   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdname.trim() == 'null' ? "" :   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdname.trim()}/${  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd.trim()}"),
                onTap: getProduct,
              ),
            ),
            new Card(
              child: new DropdownButtonFormField(

                value: purpose,
                items: generateDropDown(0),
                onChanged: (LookupBeanData newValue) {

                  showDropDown(newValue, 0);

                },
               decoration:  InputDecoration(
                  hintText: Translations.of(context).text('select_purpose_of_loan'),
                  labelText: constantResource.captionValue,
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
              ),
            ),
            isFullerTon==0?new Card(
              child: new ListTile(
                  title: new Text(Translations.of(context).text('sub_purpose_of_loan')),
                  subtitle:   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.msubpurposeofloan == null
                      ? new Text("")
                      : new Text(Translations.of(context).text('subPurpose') +"${  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.msubpurposeofloandesc}"+Translations.of(context).text('and_code') +"${  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.msubpurposeofloan}"),
                  onTap: () => getPurpose("subpurpose",
                      int.parse(purpose.mcode != null ? purpose.mcode : 0))),
            ):new Container(),
            new Card(
              child: new DropdownButtonFormField(
                value: frequency,
                items: generateDropDown(1),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 1);
                },
                validator: (args) {

                },
                decoration:  InputDecoration(
                  hintText: Translations.of(context).text('select_repayment_frequency_of_loan'),
                  labelText: Translations.of(context).text('repayment_frequency_of_loan'),
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
              ),

            ),
            new Column(
              children: <Widget>[

                new Card(
                  child: new ListTile(
                      title: new Text(
                          constantResource.maxAmountApplyminAmountcanApply),
                      subtitle: canApplyMaxAmount == null ||
                              canApplyMinAmount == null
                          ? new Text("")
                          : new Text(
                              "${canApplyMinAmount}  -  ${canApplyMaxAmount}")),
                ),


                new Card(
                  child: new ListTile(
                      title: new Text(constantResource.maxInstApply),
                      subtitle: canApplyMaxInst == null ||
                              canApplyMinInst == null
                          ? new Text("")
                          : new Text(
                              "${canApplyMinInst.toInt()}  -  ${canApplyMaxInst.toInt()}")),
                ),

                new TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:  InputDecoration(
                      hintText:Translations.of(context).text('enter_applied_amount'),
                      labelText: Translations.of(context).text('applied_amount'),
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
                    initialValue:   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappldloanamt == null
                        ? ""
                        :   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappldloanamt.toString(),
                    onSaved: (String value) {

                      if (value.isNotEmpty &&
                          value != "" &&
                          value != null &&
                          value != 'null') {
                         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappldloanamt = double.parse(value);
                      }
                       CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloanamtdisbd =   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappldloanamt;
                       CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mapprvdloanamt =   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappldloanamt;
                    }),

              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              decoration: BoxDecoration(),
              child: new Row(
                children: <Widget>[Text(Constant.loandisbdt)],
              ),
            ),
            new Container(
              decoration: BoxDecoration(),
              child: new Row(
                children: <Widget>[
                  new Container(
                    width: 50.0,
                    child: new TextField(
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
                                loanDisbDt = loanDisbDt.replaceRange(0, 2, val);
                                FocusScope.of(context).requestFocus(monthFocus);
                              } else {
                                loanDisbDt =
                                    loanDisbDt.replaceRange(0, 2, "0" + val);
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
                              loanDisbDt = loanDisbDt.replaceRange(3, 5, val);

                              FocusScope.of(context).requestFocus(yearFocus);
                            } else {
                              loanDisbDt =
                                  loanDisbDt.replaceRange(3, 5, "0" + val);
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
                          loanDisbDt = loanDisbDt.replaceRange(6, 10, val);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        _selectDisDtDate(context);
                      })
                ],
              ),
            ),
//loanstart dt
            SizedBox(height: 20.0,),
            Container(
              decoration: BoxDecoration(),
              child: diplayinststrtfld==true?new Row(
                children: <Widget>[Text(Constant.loaninstStrtDt)],
              ):null,
            ),
            new Container(
              decoration: BoxDecoration(),
              child:diplayinststrtfld==true? new Row(
                children: <Widget>[
                  new Container(
                    width: 50.0,
                    child: new TextField(
                        decoration: InputDecoration(hintText:Translations.of(context).text('DD')),
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(2),
                          globals.onlyIntNumber
                        ],
                        controller: tempInstStrtDay == null
                            ? null
                            : new TextEditingController(text: tempInstStrtDay),
                        keyboardType: TextInputType.numberWithOptions(),
                        onChanged: (val) {
                          if (val != "0") {
                            tempInstStrtDay = val;

                            if (int.parse(val) <= 31 && int.parse(val) > 0) {
                              if (val.length == 2) {
                                loaninstStrtDt = loaninstStrtDt.replaceRange(0, 2, val);
                                FocusScope.of(context).requestFocus(monthInstStrtFocus);
                              } else {
                                loaninstStrtDt =
                                    loaninstStrtDt.replaceRange(0, 2, "0" + val);
                              }
                            } else {
                              setState(() {
                                tempInstStrtDay = "";
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
                        hintText:Translations.of(context).text('MM'),
                      ),
                      keyboardType: TextInputType.numberWithOptions(),
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(2),
                        globals.onlyIntNumber
                      ],
                      focusNode: monthInstStrtFocus,
                      controller: tempInstStrtMonth == null
                          ? null
                          : new TextEditingController(text: tempInstStrtMonth),
                      onChanged: (val) {
                        if (val != "0") {
                          tempInstStrtMonth = val;
                          if (int.parse(val) <= 12 && int.parse(val) > 0) {
                            if (val.length == 2) {
                              loaninstStrtDt = loaninstStrtDt.replaceRange(3, 5, val);

                              FocusScope.of(context).requestFocus(yearInstStrtFocus);
                            } else {
                              loaninstStrtDt =
                                  loaninstStrtDt.replaceRange(3, 5, "0" + val);
                            }
                          } else {
                            setState(() {
                              tempInstStrtMonth = "";
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
                      focusNode: yearInstStrtFocus,
                      controller: tempInstStrtYear == null
                          ? null
                          : new TextEditingController(text: tempInstStrtYear),
                      onChanged: (val) {
                        tempInstStrtYear = val;
                        if (val.length == 4)
                          loaninstStrtDt =  loaninstStrtDt.replaceRange(6, 10, val);

                      },

                    ),
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        _selectStrtDtDate(context);
                      })
                ],
              ):null,
            ),

            //ends
            new TextFormField(
                keyboardType: TextInputType.number,
                decoration:  InputDecoration(
                  hintText: Translations.of(context).text('enter_number_of_installment'),
                    labelText: Translations.of(context).text('number_of_installment'),
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
                initialValue:
                 CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod == null ? "" : "${  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod}",
                validator: (String value) {
                  if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                      .hasMatch(value)) {
                    return Translations.of(context).text('no_special_character_allowed');
                  } else
                    return null;
                },
                onSaved: (String value) {
                  if (value.isNotEmpty &&
                      value != "" &&
                      value != null &&
                      value != 'null') {
                     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod = int.parse(value);
                  }
                }),


            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('R.O.I')),
                subtitle:   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mintrate == null
                    ? new Text("")
                    : new Text("${ CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mintrate}"),
              ),
            ),

            new Card(
              child: new ListTile(
                  title: new Text(Translations.of(context).text('end_date')),
                  subtitle:   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mexpdt == null
                      ? new Text("")
                      : new Text("${  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mexpdt}")),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('interest_amount')),
                subtitle:   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minterestamount == null
                    ? new Text("")
                    : new Text("${  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minterestamount.roundToDouble()}"),
              ),
            ),

            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('instalment_amount')),
                subtitle:   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minstamt == null
                    ? new Text("")
                    : new Text("${  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minstamt}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('approved_amount')),
                subtitle:   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mapprvdloanamt == null
                    ? new Text("")
                    : new Text("${  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mapprvdloanamt}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('disbursment_amount')),
                subtitle:   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloanamtdisbd == null
                    ? new Text("")
                    : new Text("${  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloanamtdisbd}"),
              ),
            ),
            isFullerTon==0?  new Card(
              child: new DropdownButtonFormField(
                value: repaymentmode,
                items: generateDropDown(2),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 2);
                },
                validator: (args) {

                },
                decoration:  InputDecoration(
                  isDense: true,
                  hintText: Translations.of(context).text('Select_Mode_Of_Collection'),
                  labelText: Translations.of(context).text('mode_of_collection'),
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
              ),
            ):new Container(),
            isFullerTon==0?new Card(
              child: new Card(
                child: new DropdownButtonFormField(
                  value: modeofdisb,
                  items: generateDropDown(3),
                  onChanged: (LookupBeanData newValue) {
                    showDropDown(newValue, 3);
                  },
                  validator: (args) {

                  },
                  decoration:  InputDecoration(
                    hintText:Translations.of(context).text('select_mode_of_disbursment'),
                    labelText:Translations.of(context).text('mode_of_disbursment'),
                    hintStyle: TextStyle(color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    isDense: true,
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
                ),
              ),
            ):new Container(),
            new Container(
              height: 20.0,
            ),

            new Container(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }

  Future<Null> _selectDisDtDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked !=   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloandisbdt)
      setState(() {
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloandisbdt = picked;
        tempDate = formatter.format(picked);
        if (picked.day.toString().length == 1) {
          tempDay = "0" + picked.day.toString();
        } else
          tempDay = picked.day.toString();
        loanDisbDt = loanDisbDt.replaceRange(0, 2, tempDay);
        tempYear = picked.year.toString();
        loanDisbDt = loanDisbDt.replaceRange(6, 10, tempYear);
        if (picked.month.toString().length == 1) {
          tempMonth = "0" + picked.month.toString();
        } else
          tempMonth = picked.month.toString();
        loanDisbDt = loanDisbDt.replaceRange(3, 5, tempMonth);
      });
  }


  Future<Null> _selectStrtDtDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked !=   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt)
      setState(() {

        print("installmenyt satart date hai ${loaninstStrtDt}");
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt = picked;
        tempInstStrtDate = formatter.format(picked);
        if (picked.day.toString().length == 1) {
          tempInstStrtDay = "0" + picked.day.toString();
        } else
          tempInstStrtDay = picked.day.toString();
        loaninstStrtDt = loaninstStrtDt.replaceRange(0, 2, tempInstStrtDay);
        tempInstStrtYear = picked.year.toString();
        loaninstStrtDt = loaninstStrtDt.replaceRange(6, 10, tempInstStrtYear);
        if (picked.month.toString().length == 1) {
          tempInstStrtMonth = "0" + picked.month.toString();
        } else
          tempInstStrtMonth = picked.month.toString();
        loaninstStrtDt = loaninstStrtDt.replaceRange(3, 5, tempInstStrtMonth);
      });
    calculate();
    setState(() {

    });
  }



  Future getProduct() async {


    if(CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappliedasind ==null){
      Toast.show(Translations.of(context).text("Please Select Customer First"), context);
      return;

    }

    if(CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcusttrefno==null){
      Toast.show(Translations.of(context).text("Please Select Customer First"), context);
      return;

    }



    print("before getting customer ${  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappliedasind}");
    prodObj = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForProductSelection(30,int.parse(  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappliedasind)),
          fullscreenDialog: true,
        ));
    if (prodObj != null) {


       CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd = prodObj.mprdCd;
       CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdname = prodObj.mname.trim();
       CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcurCd = prodObj.mcurCd;
       print("Product type is ${prodObj.mdivisiontype}");
       if(prodObj.mdivisiontype!=null&&(prodObj.mdivisiontype.trim()=="I"||prodObj.mdivisiontype.trim()=="B")){
         diplayinststrtfld= true;


       }else{
         diplayinststrtfld= false;
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt =null;
       }

      print("Rturned Cusrrency coed is ${CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcurCd} ") ;
      if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustno > 0 ||   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustmrefno > 0 ||
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcusttrefno > 0) {
        if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd != null &&   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloancycle !=null &&
             CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency != null && branch > 0){
          await AppDatabase.get()
              .selectMaxLoanAmtCanApply(
               CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd.trim().toString(),
               CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloancycle+1,
              branch,
               CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency)
              .then((onValue) {

            for(int secondLoanCycle = 0;secondLoanCycle<onValue.length;secondLoanCycle++){
              if (onValue[secondLoanCycle].mruletype == 1) {
                canApplyMaxAmount = onValue[secondLoanCycle].mmaxamount;
                canApplyMinAmount = onValue[secondLoanCycle].mminamount;
              } else if (onValue[secondLoanCycle].mruletype == 2) {
                canApplyMaxInst = onValue[secondLoanCycle].mmaxamount;
                canApplyMinInst = onValue[secondLoanCycle].mminamount;
              }
            }
            setState(() {});
          });
      }
    }
      }



  }

  Future getPurpose(String purposeMode, int selectedPosition) async {
    purposeObj = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForPurposeSelection(position: selectedPosition),
          fullscreenDialog: true,
        )).then<SubLookupForSubPurposeOfLoan>((purposeObjVal) {

      //subPurposeName=purposeObjVal.codeDesc;
      //subPurposeId = purposeObjVal.code;
       CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.msubpurposeofloandesc = purposeObjVal.codeDesc;
       CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.msubpurposeofloan = int.parse(purposeObjVal.code.trim());
    });

  }

  Future<Null> calculate() async {

   // DateTime formattedLoanDisbDtDate = loanDisbDt!=null?DateTime.parse(loanDisbDt):null;

    print("Started Calsculating");
    if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd != null &&    CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloancycle !=null &&
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency != null && branch > 0){
      await AppDatabase.get()
          .selectMaxLoanAmtCanApply(
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd.trim().toString(),
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloancycle+1,
          branch,
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency)
          .then((onValue) {
            if(onValue.isEmpty){
              canApplyMaxAmount = 0.0;

              canApplyMaxAmount = 0.0;

            }

        for (int secondLoanCycle = 0;
            secondLoanCycle < onValue.length;
            secondLoanCycle++) {
          if (onValue[secondLoanCycle].mruletype == 1) {
            canApplyMaxAmount = onValue[secondLoanCycle].mmaxamount;
            canApplyMinAmount = onValue[secondLoanCycle].mminamount;
          } else if (onValue[secondLoanCycle].mruletype == 2){
            canApplyMaxInst = onValue[secondLoanCycle].mmaxamount;
            canApplyMinInst = onValue[secondLoanCycle].mminamount;
          }

        }
        setState(() {});
      });
    }



    print("loan Disb startdate--> $loanDisbDt");
    print("installment start date    $loaninstStrtDt");
    try {
      DateTime formattedLoanDisbDtDate = DateTime.parse(loanDisbDt.substring(6) +
          "-" +
          loanDisbDt.substring(3, 5) +
          "-" +
          loanDisbDt.substring(0, 2));
       CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloandisbdt=formattedLoanDisbDtDate;
    } catch (e) {
      print("Disb date Error");
    }


    try{


    DateTime formattedInstStrtDtDate = DateTime.parse(loaninstStrtDt.substring(6) +
          "-" +
          loaninstStrtDt.substring(3, 5) +
          "-" +
          loaninstStrtDt.substring(0, 2));
       CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt=formattedInstStrtDtDate;
    } catch (e) {
      print("inst Start Date error");
    }

    print(" after loan Disb startdate--> ${CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloandisbdt}");
    print("after installment start date    ${CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt}");



    print("prdCode  ${CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd}");
    print("CusrCD   ${CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcurCd}");
    print("apploaonmat  ${CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappldloanamt}");
    if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd != null &&
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcurCd != null &&
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappldloanamt != null &&
        branch != null &&
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod != null &&
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloancycle != null) {
      await AppDatabase.get()
          .selectSlabIntRate(
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd.trim().toString(),
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcurCd.trim().toString(),
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappldloanamt,
              branch,
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod,
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloancycle+1)
          .then((onValue) {


         print("intrate "+ CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mintrate .toString());
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mintrate = onValue;

        if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappldloanamt != null &&
             CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mintrate != null &&
             CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod != null &&
             CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloandisbdt != null &&
             CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency != null) {
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minterestamount = (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloanamtdisbd) *
              (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mintrate) *
              (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod / 12.0) /
              100.0;

          double totalPayingAmount =
               CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloanamtdisbd +   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minterestamount;
           CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minstamt = (totalPayingAmount /   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod).roundToDouble();


           if(diplayinststrtfld==true){

             try{
               if(  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency.trim() == "A"){
                 CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mexpdt=DateTime.now();
               }else  if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency.trim() == "M") {
                 CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mexpdt = new DateTime(
                     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.year,
                     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.month +   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod,
                     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.day);

               } else if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency.trim() == "B") {
                 if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod.isOdd) {
                   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mexpdt = new DateTime(
                       CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.year,
                       CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.month +
                           ((  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod - 1) / 2).round(),
                       CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.day + 15);

                 } else if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod.isEven) {
                   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mexpdt = new DateTime(
                       CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.year,
                       CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.month +
                           (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod / 2).round(),
                       CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.day);

                 }
               }else if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency.trim() == "L") {
                 CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mexpdt = new DateTime(
                     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.year,
                     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.month ,
                     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.day + (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod * 28));

               }else if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency.trim() == "F") {
                 CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mexpdt = new DateTime(
                     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.year,
                     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.month ,
                     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.day + (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod * 14));

               }
               else if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency.trim() == "Q") {
                 CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mexpdt = new DateTime(
                     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.year,
                     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.month +(  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod * 3),
                     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.day );
               }
               else if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency.trim() == "W") {

                 CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mexpdt = new DateTime(
                     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.year,
                     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.month,
                     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt.day + (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod * 7));

               }
             }catch(_){


             }


           }

        }

      });
    }


  }

  Future getCustomerNumber() async {
    var customerdata;
    customerdata = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                CustomerList(null,"Loan Application")));
    if (customerdata != null) {

        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustno =
          customerdata.mcustno != null ? customerdata.mcustno : 0;
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcusttrefno =
      customerdata.trefno != null ? customerdata.trefno : 0;
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustmrefno =
      customerdata.mrefno != null ? customerdata.mrefno : 0;
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustname = customerdata.mlongname;
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloancycle = customerdata.mtier != null  ? customerdata.mtier : 0;
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustcategory =
          customerdata.mcustcategory == null ? 0 : customerdata.mcustcategory;
      loanCycle = customerdata.mtier != null  ? customerdata.mtier : 0;
      mgrpID = customerdata.mgroupcd != null ? customerdata.mgroupcd : 0;
      mcenterId = customerdata.mcenterid != null ? customerdata.mcenterid : 0;

      if(mgrpID==  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustno||mgrpID==0){

          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappliedasind='0';

      }else{

          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappliedasind='1';

      }






    if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustno != null ||   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustno != 0
    ||CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcusttrefno!=null
    ) {
      mIsCustomerSelected = "Y";
    } else {
      mIsCustomerSelected = "N";
    }


        print("Applied as indivisdual  ${  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappliedasind}");

        if(customerdata.mmaritialStatus==2){
          CustomerLoanDetailsMasterTabState.isMarried=true;

          if(customerdata.mhusbandname !=null&&customerdata.mhusbandname.trim !='null'){

            CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mspouserelname = customerdata.mhusbandname;
          }


        }else{
          CustomerLoanDetailsMasterTabState.isMarried=false;
          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mspouserelname = '';
        }


    }



    setState(() {

    });
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
                  Text(Translations.of(context).text('loan_created')),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                onPressed: () {
                 // CustomerLoanDetailsList.count = 1;
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                        // new LoanLimitDetails()), //When Authorized Navigate to the next screen
                        new CustomerLoanDetailsList("Loan Application",null)),
                  );
                },
              ),
            ],
          );
        });
  }

  proceed() async {
    bool validate = await validateSubmit();

    if (!validate) {
      return;
    }
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mleadstatus = 1;
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrefno =   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrefno != null ?   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrefno : 0;
    if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcreatedby == null ||
          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcreatedby == '' ||
          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcreatedby == 'null') {
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcreatedby = username;
    }

      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrouteto = '';
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mroutefrom = '';
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mlastupdateby = username;
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcreateddt == null) {
       CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcreatedby = username;
       CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcreateddt = DateTime.now();
    }

     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mlastupdatedt = DateTime.now();
     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mgeolocation = geoLocation;
     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mgeologd = geoLongitude;
     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mgeolatd = geoLatitude;

    await AppDatabase.get()
        .updateCustomerLoanDetailsMaster( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj)
        .then((val) {

    });
    _successfulSubmit();
  }

  Future<void> _showAlertForFPSMismatch() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:
          Text("Finger Print not Matched!! Do you still want to continue?"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$error'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(Translations.of(context).text('Yes')),
              onPressed: () {
            //    saveData();


              },
            ),

            FlatButton(
              child: Text(Translations.of(context).text('Cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAlert(arg, error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$arg"+Translations.of(context).text('error')),
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

  Future<bool> validateSubmit() async {
    String error = "";

    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcusttrefno == null ||
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcusttrefno == "" ||
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustname == null ||
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustname == "" ||
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustname == "null") {
      _showAlert(
          Translations.of(context).text("Customer Tablet Ref Number And Name"),
          Translations.of(context).text("It is Mandatory"));
      // _tabController.animateTo(0);

      return false;
    }
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdname == "" ||  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdname == null) {
      _showAlert("Product Name", "It is Mandatory");
      // _tabController.animateTo(0);
      return false;
    }

    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.msubpurposeofloan == "" ||
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.msubpurposeofloan == null) {
      _showAlert(Translations.of(context).text('sub_purpose_of_loan'), Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    }
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mintrate == "" ||  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mintrate == null) {
      _showAlert("R.O.I", "It is Mandatory");
      // _tabController.animateTo(0);
      return false;
    }
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency == "" ||  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency == null) {
      _showAlert("Repayment Frequency Of Loan", "It is Mandatory");
      // _tabController.animateTo(0);
      return false;
    }
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mexpdt == "" ||  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mexpdt == null) {
      _showAlert("End Date", "It is Mandatory");

      return false;
    }
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minterestamount == "" ||
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minterestamount == null) {
      _showAlert("Interest Amount", "It is Mandatory");

      return false;
    }
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minstamt == "" ||  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minstamt == null) {
      _showAlert("Installment Amount", "It is Mandatory");

      return false;
    }
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mapprvdloanamt == "" ||  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mapprvdloanamt == null) {
      _showAlert("Approved Amount", "It is Mandatory");

      return false;
    }
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloanamtdisbd == "" ||  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloanamtdisbd == null) {
      _showAlert("Disbursment Amount", "It is Mandatory");

      return false;
    }
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrepaymentmode == "" ||
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrepaymentmode == null ||
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrepaymentmode == 0) {
      _showAlert("Mode Of Collection", "It is Mandatory");

      return false;
    }
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mmodeofdisb == "" ||
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mmodeofdisb == null ||
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrepaymentmode == 0) {
      _showAlert("Mode Of Disbursment", "It is Mandatory");

      return false;
    }

    if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mapprvdloanamt > canApplyMaxAmount ||
          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappldloanamt > canApplyMaxAmount) {
      _showAlert("Applied Amount", "Please enter correct Amount");

      return false;
    }

    if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod > canApplyMaxInst) {
      _showAlert("Period cannot be more than max apply period",
          "Please entercorrect period");

      return false;
    }
    if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod < canApplyMinInst) {
      _showAlert("Applied Installment", "Please apply correct installment");

      return false;
    }
    if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mapprvdloanamt < canApplyMinAmount) {
      _showAlert("Applied Amount", "Please enter correct Amount");

      return false;
    }

    GroupFoundationBean GrpObj =
        await AppDatabase.get().getGroupFromGrpId(mgrpID);

    if (GrpObj.mgroupprdcode != null &&
        GrpObj.mgroupprdcode.trim() != "" &&
        GrpObj.mgroupprdcode.trim() != "null" &&
        isMemeberOfGroupForLoan == true) {
      if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd != GrpObj.mgroupprdcode) {
        _showAlert("Product group mismatch ",
            "Can Only apply for ${GrpObj.mgroupprdcode}");

        return false;
      }



      await AppDatabase.get()
          .selectMaxLoanAmtCanApply(  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd.trim().toString(),
                CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloancycle + 1, branch,   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency)
          .then((onValue) {
        for (int secondLoanCycle = 0;
            secondLoanCycle < onValue.length;
            secondLoanCycle++) {
          if (onValue[secondLoanCycle].mruletype == 1) {
            canApplyMaxAmount = onValue[secondLoanCycle].mmaxamount;
            canApplyMinAmount = onValue[secondLoanCycle].mminamount;
          } else if (onValue[secondLoanCycle].mruletype == 2)
            canApplyMaxInst = onValue[secondLoanCycle].mmaxamount;
          canApplyMinInst = onValue[secondLoanCycle].mminamount;
        }
        setState(() {});
      });
    }



    if(prefs.getString(TablesColumnFile.misIndividual)=="N"){
      return true;
    }



    CenterDetailsBean centerObj =
    await AppDatabase.get().getCenterFromCenterId(mcenterId);
    if (centerObj != null &&
        centerObj.mmeetingfreq != null &&
        centerObj.mmeetingfreq.trim() != "") {
      List<String> frequencies = new List<String>();
      bool matched = false;

      if (centerObj.mmeetingfreq.trim() == "W") {
        frequencies = Constant.INSTFREQ_W.split("-");

        for (String freq in frequencies) {
          if (freq.trim() ==   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency.trim()) {
            matched = true;
            break;
          }
        }
      } else if (centerObj.mmeetingfreq.trim() == "F") {
        frequencies = Constant.INSTFREQ_F.split("-");

        for (String freq in frequencies) {
          if (freq.trim() ==   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency.trim()) {
            matched = true;
            break;
          }
        }
      } else if (centerObj.mmeetingfreq.trim() == "M") {
        frequencies = Constant.INSTFREQ_M.split("-");

        for (String freq in frequencies) {
          if (freq.trim() ==   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency.trim()) {
            matched = true;
            break;
          }
        }
      } else {
        frequencies = Constant.INSTFREQ_B.split("-");

        for (String freq in frequencies) {
          if (freq.trim() ==  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency.trim()) {
            matched = true;
            break;
          }
        }
      }

      if(matched==false){
        _showAlert("Center Meeting Frequency ", "Center meeting frequency do not match with product frequency");
        return false;
      }

    }
    return true;
  }
  void showMessage(String message, [MaterialColor color = Colors.grey]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: color != null ? color : null,
        content: new Text(message)));
  }
}
