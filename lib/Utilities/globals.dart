library globals;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/Kyc/beans/KycMasterBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanDetailsMasterTab.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/List/CustomerLoanDetailsList.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCPVBusinessRecordBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCashFlowAnalysisBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/DeviationFormBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/SocialAndEnvironmentalBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/TradeAndNeighbourRefCheckBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/ContactPointVerification.dart';
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



bool circleIndicator=false;
String version;
//Variables
bool isLoggedIn = false;
String token = "";
String domain = "";
String apiURL = "http://Localhost:8090/countries/get/india/";
String error = "";


//prospect

List<List<LookupBeanData>> dropdownCaptionsValuesProspectInf = [
  [],
  []
];


List<List<LookupBeanData>> dropDownCaptionUtilityBillPayment = [
  [],
  [],
  [],
  []
];
List<List<LookupBeanData>>dropdownCaptionsValuesSavingsListInfo=[
  [],
  []
];
List<List<LookupBeanData>>dropdownCaptionsValuesGuarantorInfo=[
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  []
];


List<List<LookupBeanData>> dropdownCaptionsValuesCenterFormation = [
  [],
  []
];

List<List<LookupBeanData>> dropdownCaptionsValuesGroupFormation = [
  [],
  []
];





String id = "0";

String avatar = "";
List data;
List globalRadiListArrangment = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
List globalRadiListMicroEnterprises = [
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
];

//Customer Formation Starts here

//Customer Details of group etc
bool imageVisibilityDetalsTagCustomer = false;
String imageFilePathGlobalCustomerprofilePic = "";
String customerNumber = "";
String customerNumberOfCore = "";
DateTime applicationDate;
String memberOfGroup;
String memberOfGroupColl;
String existingCustomer;
bool isDedupDone= false;
bool isCustFoundInDedup= false;

bool isDedupDone= false;
bool isCustFoundInDedup= false;


String memberOfGroupSvngColl;
String memberOfGroupDisbursed;

bool isMemberOfGroup = true;
bool isMemeberOfGroupForColl = true;
bool isMemeberOfGroupForSvngColl = true;
bool isMemeberOfGroupForDisbursed = true;

List isMemberOfGroupListColl = [0];
List isExistingCustomerYN = [0];
List isServiceYN = [0];


List isMemberOfGroupListSvngColl = [0];
List isMemberOfGroupListDisbursment = [0];

List<String> radioCaptionValuesIsMemberOfGroup = ["Yes", "No"];
List<String> radioCaptionValuesIsExistingCustomer = ["Yes", "No"];

List<String> radioCaptionValuesStatusDetail = ["Yes", "No"];
List<String> radioCaptionValuesIsDependant = ["Yes", "No"];
List isMemberOfGroupList = [0];
List isDependantList = [0];
String centerName = "";
String centerNo = "";
String grouopName = "";
String groupNo;
int branchCode;
String cntryCd = "";
String countryName = "";
String stateCd = "";
String stateDesc = "";
int distCd = 0;
String distDesc = "";
String placeCd ;
String placeCdDesc = "";
int areaCd = 0;
String areaDesc = "";
List<String> radioCaptionCenterGroupDetails = ['Member Of a group'];
List<String> radioCaptionIsExistingCustomer = ['Is Existing Customer'];
List<String> radioCaptionAppliedAsInd = ['Applied as Individual'];
List<String> radioCaptionStatusDetail = ['Status'];
List<String> radioCaptionDependantYN = ['Dependent'];
//Customer personal info 1

//static members
List<String> radioCaptionsPersonalInfo = [
  'Loan Agreed',
  'Insurance',
  'Gender',
  'Region',
  'If Insurance Yes'
];
List<List<String>> radioCaptionValuesPersonalInfo = [
  ["Yes", "No"],
  ["Yes", "No"],
  ["Male", "Female"],
  ["Rural", "Urban"],
  ["Self", "Both"]
];
List<String> dropdownCaptionsPersonalInfo = [
  'If Yes, Then',
  'Religion',
  'Maritial Status',
  'Qualification',
  'Occupation',
  'Caste',
  'Title',
  'Mother Tongue',
  'Secondary Occupation',
  'Gender',
  'Rural Urban'
];
List<List<LookupBeanData>> dropdownCaptionsValuesPersonalInfo = [
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  []
];
//ends


List<List<LookupBeanData>> dropDownCaptionValuesCOdeKeysChartsType = [
[
  new LookupBeanData(mcodedesc: "Cartesian Charts",mcode: "1",mcodetype: 0),
new LookupBeanData(mcodedesc: "Pie Charts",mcode: "2",mcodetype: 0),
new LookupBeanData(mcodedesc: "Dhounut Charts",mcode: "3",mcodetype: 0),
new LookupBeanData(mcodedesc: "Bar Charts",mcode: "4",mcodetype: 0),
new LookupBeanData(mcodedesc: "Axis Charts",mcode: "5",mcodetype: 0),
new LookupBeanData(mcodedesc: "Date Time Charts",mcode: "6",mcodetype: 0),
new LookupBeanData(mcodedesc: "Numeric Charts",mcode: "7",mcodetype: 0),
new LookupBeanData(mcodedesc: "Bubble Charts",mcode: "8",mcodetype: 0),
new LookupBeanData(mcodedesc: "Column Charts",mcode: "9",mcodetype: 0),
new LookupBeanData(mcodedesc: "Spline Charts",mcode: "10",mcodetype: 0),
new LookupBeanData(mcodedesc: "StepLine Charts",mcode: "11",mcodetype: 0),
new LookupBeanData(mcodedesc: "Area Charts",mcode: "12",mcodetype: 0),
new LookupBeanData(mcodedesc: "Scatter Charts",mcode: "13",mcodetype: 0),
new LookupBeanData(mcodedesc: "Doughnut Charts",mcode: "14",mcodetype: 0),
new LookupBeanData(mcodedesc: "Radial Charts",mcode: "15",mcodetype: 0),
],
];


PersonalInfo personalInfoBean = PersonalInfo(" "," "," "," "," "," " ," "," "," "," ");
/*PersonalInfo personalInfoBean = PersonalInfo();*/

List<String> dropdownCaptionsPPIDetails = [
  'PPI Questions'
];

List<String> weekDayArray = ['0','2','3','4','5','6','7','1'];

List<String> dropdownCaptionsFamilyDetails = [
  'Education',
  'Relation',
  'Occupation'
];
List<List<LookupBeanData>> dropdownCaptionsValuesFamilyDetails = [
  [],
  [],
  []
  //[]
];
List<String> dropdownCaptionsExpenseDetails = [
  'Business Expenditure',
  'Household Expenditure'
];
List<List<LookupBeanData>> dropdownCaptionsValuesExpenseDetails = [
  [],
  []
];

List<List<LookupBeanData>> dropdownCaptionsValuePPIDetails = [
  []
  //[]
];

List<List<LookupBeanData>> dropdownCaptionsValuesModeOfPayout = [[],[]];

List<String> dropdownCaptionsModeOfPayout = ['Mode Of Payout',''];
List radiopersonalInfo = [1, 0, 0, 0];
String title = "";
String firstName;
String middleName;
String lastName;
DateTime applicantDob ;
DateTime applicantDOB;

String applicantFatherName;
String applicantSpouseName;

//Customer Kyc 1
List<String> captionIdType = ['National ID:', 'Residence Proof ID:'];
List<List<LookupBeanData>> dropdownCaptionsValuesKyc = [[], []];
bool imageVisibilityKyc1AppId1TagCustomer = false;
bool imageVisibilityKyc1AppId12TagCustomer = false;
bool imageVisibilityKyc1AppId13TagCustomer = false;
bool imageVisibilityKyc1AppId2TagCustomer = false;
bool imageVisibilityKyc1AppId22TagCustomer = false;
bool imageVisibilityKyc1AppId23TagCustomer = false;
bool imageVisibilityKyc1AppId24TagCustomer = false;
bool imageVisibilityKyc1AppId25TagCustomer = false;
bool imageVisibilityKyc1AppId26TagCustomer = false;
bool imageVisibilityKyc1PassBook1TagCustomer = false;
bool imageVisibilityKyc1PassBook2TagCustomer = false;
bool imageVisibilityKyc1PassBook3TagCustomer = false;
bool imageVisibilityKyc1PassBook4TagCustomer = false;
bool connected = false;
String kyc1PassBook1TagPicCustomer = "";
String kyc1PassBook2TagPicCustomer = "";
String kyc1PassBook3TagPicCustomer = "";
String kyc1PassBook4TagPicCustomer = "";
String kyc1AppId1PicTagCustomer = "";
String kyc1AppId12PicTagCustomer = "";
String kyc1AppId13PicTagCustomer = "";
String kyc1AppId2PicTagCustomer = "";
String kyc1AppId22PicTagCustomer = "";
String kyc1AppId23PicTagCustomer = "";
String kyc1AppId24PicTagCustomer = "";
String kyc1AppId25PicTagCustomer = "";
String kyc1AppId26PicTagCustomer = "";
String idType1;
String idType2;
String idType1Key;
String idType2Key;
//kyc details 2
/*List<String> dropdownCaptionsValuesKycDetails2 = [
  'Address Type'
];*/
List<String> dropdownCaptionsKycDetails2 = ['Address Type'];
/*List<List<String>> dropdownCaptionsValuesKycDetails2 = [
  ["Home Address", "Office Address", "Mailing Address","Permanent Address"],
];*/
List<List<LookupBeanData>> dropdownCaptionsValuesKycDetails2 = [[]];
List<AddressDetailsBean> addressDetailsList = [];

List<String> dropdownCaptionsProfileDetails = ['Role of member','Customer Type','Customer Status','dropout reason'];
List<List<LookupBeanData>> dropdownCaptionsValuesProfileDetails = [[],[],[],[]];
List<LookupBeanData> mGroupType =[];
String addresType;
String currentAddress;
String district;
String thana;
String pin;
String post;
String mobileNumber;
String landLineNumber;

//familyDetails
List<FamilyDetailsBean> familyDetailsList = [];
String familyMember;
int age = 0;
String education;
String relationship;
String occupation;
double income;
String dependent;

//socialFinancial Details
//static content
List<String> radioCaptionSocialFinancial = [
  'Construction',
  'Toilet',
  'Bank Account'
];
List<List<String>> radioCaptionValuesSocialFinancial = [
  ["Kaccha", "Pakka"],
  ["Yes", "No"],
  ["Yes", "No"]
];
List<String> dropDownCaptionSocialFinancial = [
  'House',
  'Agricultural Land Owner',
  'Bank Name'
];

/*LookupBeanData lookUpData2= new LookupBeanData(mcode: '0',mcodedesc: 'Below 1 Acre');
LookupBeanData lookUpData3= new LookupBeanData(mcode: '1',mcodedesc: 'Between 1 to 5 acre');
LookupBeanData lookUpData4 =  new LookupBeanData(mcode: '2',mcodedesc: 'Above 5 acre');*/



List<List<LookupBeanData>> dropDownCaptionValuesCOdeKeysSocialFinancial = [
  [],
  [],
  [],
  [],
  [],
  [],
  []
];

List<List<LookupBeanData>> dropDownCaptionValuesCodeKeysBusiness = [
  [],
  [],
  [],
  [],
  []
];

List<String> multiSelectDropdownCaptionSocialFinancial = [
  'Assets Details',
  'Savings Details'
];
List<List<String>> multiSelectDropdownSocialFinancial = [
  ["TV", "Cycle/Bike", "Sewing Machine", "Cupboards", "Mobile", "Others"],
  ["Normal", "Bank", "Post Office", "Other", "Home", "LoanAgreed"]
];
List<List<LookupBeanData>> dropdownCaptionsValuesCif = [[]];
List<String> dropdownCaptionsCifDetails = ['Narration'];

List<List<LookupBeanData>> dropdownCaptionsValuesCifLoanClosure = [[]];
List<String> dropdownCaptionsCifLoanClosureDetails = ['Payment Mode'];

List<List<LookupBeanData>> dropdownCaptionsValuesTransaction = [[],[],[]];

List<List<LookupBeanData>> dropdownCaptionsValuesSocialAndEnv = [[]];

List<List<LookupBeanData>> dropdownCaptionsValuesTradeNeighbour = [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]];

List<List<LookupBeanData>> dropdownCaptionsValuesDeviationForm = [[]];

List<List<LookupBeanData>> dropdownKycMaster = [[],
  [],
  [],
  [],
  [],
  [],
  [],
];

List<List<LookupBeanData>> dropdownCaptionsValuesLoanCPV = [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]];
List<List<LookupBeanData>> dropdownCaptionsValuesDisbursment = [[]];

CustomerLoanCashFlowAnalysisBean globalCashFlowObject;
SocialAndEnvironmentalBean globalSocialAndEnvObject;
DeviationFormBean globalDeviationFormObject;
TradeAndNeighbourRefCheckBean globalTradeAndNeigObject;
CustomerLoanCPVBusinessRecordBean globalCPVBusinessObject;
KycMasterBean globalKycMasterObj ;
//ends

List radioSocialFinancial = [1, 1, 1, 1, 1, 1, 1];
SocialFinancialDetailsBean socialFinancialDetailsBean =
SocialFinancialDetailsBean();
List<CustomModel> customModelsAssetsDetails = [];
List<CustomModel> customModelsSavingsDetails = [];
int socialFinancialInitializer = 0;
String customerType = "";
int customerBankAccountNumber = 0;
String customerBankName;
String customerBankBranch;
String customerBankIFSC;

//BorrowingDetails
//static content
List<String> radioCaptionValues = ["Yes", "No"];
List<String> radioCaptionBorrowingDetails = ['Member Of a group'];
//ends
List borrowingDetails = [0];
int loanNumber = 0;
String name;
double loanAmount = 0.0;
String loanDate;
String oustandingAmount;
String currentLoanWithUs;
String repayMentDate;
String loanDetailsloanFromOthers;
List<BorrowingDetailsBean> borrowingDetailsBean = [];

// business Details
//static content
List<String> dropDownCaptionBusinessDetails = ['Organization Type'];
List<List<String>> radioCaptionValuesBusinessDetails = [
  ["Profit", "loss"],
  ["Yes", "No"],
  ["Yes", "No"],
  ["Service","Bussiness"]
];
List<String> radioCaptionBusinessDetails = [
  'House and Organization at same Place',
  'Registered Organization',
  'Organization Trend'
];
/*
List<List<String>> dropDownCaptionValuesBusinessDetails = [
  ["Owned", "Patnership", "Father/Husband"]
];
*/
List<List<LookupBeanData>> dropDownCaptionValuesBusinessDetails = [[]];
//ends
List radioBusinessDetails = [
  0,
  0,
  0,
];

//Business CashFLow
//static content
List<String> radioCaptionBusinessCashflow = [
  'January',
  'Feburary',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];
List<String> radioCaptionValuesBusinessCashflow = ["High", "Mid", "Low"];
//ends
List radioBusinessCashFlow = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
String filepath = "Hello";
String imageType;
//List<ImageBean> listImgBean = [ImageBean(),ImageBean(),ImageBean(),ImageBean(),ImageBean(),ImageBean(),ImageBean(),ImageBean(),ImageBean(),ImageBean(),ImageBean(),ImageBean(),ImageBean(),ImageBean(),ImageBean()];
List<ImageBean> listImgBean = new List<ImageBean>();


//ppi

List<String> dropDownCaptionPPIDetails = [
  "No of Children",
  "Education",
  "House Hold Type",
  "Primary Eneregy Source of cooking",
  "House Hold Posses any Cassroles Microvaves",
  "HouseHold have any  TV and DVD/VCD/VCR ",
  "Household have any mobile handset or Telephone Landline",
  "Household posess a sewing machine",
  "Household posess a  or almirah Dressing Tabel",
  "Household posess a bycle Motor Car Machine"
];

/*List<List<Map<String, LookUpDescriptionValueObj>>>
dropDownCaptionValuesPPIDetails = [
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  []
];*/
List<String> ppiMarksValue = ["", "", "", "", "", "", "", "", "", "", "", ""];

List<List<LookupBeanData>> dropdownCaptionsValuesCpv = [[],[],[],[],[]];

List<CheckBoxesChecked> dropdownCaptionsValuesCpvMuliselect;
List<String> answers = new List<String>();
int OTP;

String productName = "";
String productId = "";
String pageRoutedFrom = "";
String agentUserName = "";
int  branchId ;
String reportingUser;
String searchName= "";

//Declaration Form
bool imageVisibilityDeclarationFormTagCustomer = false;
bool imageVisibilityDeclarationFormTagSpouse = false;
String imageFilePathGlobalDeclarationFormCustomerSignature = "";
String imageFilePathGlobalDeclarationFormSpouseSignature = "";
bool accepted = false;
int adhaarNo;

BlacklistingTextInputFormatter onlyIntNumber = BlacklistingTextInputFormatter(RegExp(r'[!@#<>?":_`~;[\]\\//, .|=+)(*&^%a-zA-Z-]'));
BlacklistingTextInputFormatter onlyDoubleNumber = BlacklistingTextInputFormatter(RegExp(r'[!@#<>?":_`~;[\]\\//, |=+)(*&^%a-zA-Z-]'));
BlacklistingTextInputFormatter onlyCharacter = BlacklistingTextInputFormatter(RegExp(r'[!@#<>?":_`~;[\]\\//|$=+)(*&^%0-9-]'));
BlacklistingTextInputFormatter onlyAphaNumeric = BlacklistingTextInputFormatter(RegExp(r'[!@#<>?":_`~;[\]\\//|=+)(*&^%-]'));
BlacklistingTextInputFormatter onlydate = BlacklistingTextInputFormatter(RegExp(r'[!@#<>?":_`~;[\]\\//, .|=+)(*&^%a-zA-Z]'));
WhitelistingTextInputFormatter onlyDate = WhitelistingTextInputFormatter(RegExp(r'0-9'));
AddressDetailsBean tempAddressDetails= new AddressDetailsBean();
//Customer Formation ends here

//Loan Details
List<String> dropdownCaptionsLoanLimitDetails = ['Purpose of loan','Repayment Frequency Of loan','Mode Of Collection','Mode Of Disbursment',
];
List<List<LookupBeanData>> dropdownCaptionsValuesCustLoanDetailsInfo = [[], [],[],[]];

//CGT1

//CGT1
List<CheckListCGT1Bean> questionCGT1;
//CGT2
List<CheckListCGT2Bean> questionCGT2;


//GrtDocument Verification
List<String> dropdownCaptionsGRTDocumentVerification = ['IdType1','IdType2','IdType3'];
List radioGRt = [0, 0, 0,0];
GRTBean grtBean = GRTBean();
List<List<Map<String, String>>> dropdownCaptionsValuesGRTDocumentVerification = [ [], [], []];

//GRTQUestion

List<CheckListGRTBean> questionGRT;
List<List<String>> radioCaptionValuesGRT = [
  ["Pass", "Fail","hold"],
];


bool fingerPrintAuthForTDDone = false;
bool fingerPrintAuthForLoanApplicationDone = false;


List<List<LookupBeanData>> dropDownLanguage = [[]];

class Utility {



  static Future<Null> showAlertPopup(
      BuildContext context, String title, String detail) async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      child: new AlertDialog(
        title: new Text(title),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text(detail),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Done'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  String validateOnlyCharacterField(String arg) {
    if (arg == null)
      return 'Field cannot be null';
    else if (arg.length < 3)
      return 'Field must have more than 2 charater';
    else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(arg)) {
      return "no special character allowed";
    } else
      return null;
  }

  String validateLengthToMatchMiddleware(String arg,int maxlength) {
    if (arg != null && arg != "" && arg.length > maxlength) {
      return '${Constant.errorMaxExceedChar} ${maxlength} ${Constant.errorChar}';
    } return null;
  }

  static String validateOnlyCharacterFieldNotMandat(String arg) {
    if (arg != null && arg != "" && arg.length < 3)
      return 'Field must have more than 2 charater';
    else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(arg)) {
      return "no special character allowed";
    } else
      return null;
  }

  static String validateCharacterAndNumberField(String arg) {
    if (arg.length < 1)
      return 'City must Not be Empty';
    else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]').hasMatch(arg)) {
      return "no special character allowed";
    } else
      return null;
  }

  static String validateOnlyNumberField(String arg) {
    if (arg.length < 3)
      return 'City must be more than 2 charater';
    else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]').hasMatch(arg)) {
      return "no special character allowed";
    } else if (RegExp(r'[a-zA-Z-]').hasMatch(arg)) {
      return "Characters not allowed";
    } else
      return null;
  }

  static Future mockService([dynamic error]) {
    print("Waiting");
    return new Future.delayed(const Duration(seconds: 6), () {
      if (error != null) {
        throw error;
      }
    });
  }

  static clearDataOfCustomerGlobals() {
    //extras
    accepted = false;
    //Customer Details of group etc
    imageVisibilityDetalsTagCustomer = false;
    imageFilePathGlobalCustomerprofilePic = "";
    customerNumber = "";
    applicationDate ;
    centerName = "";
    centerNo = "";
    grouopName = "";
    groupNo = "";
    branchCode;
    memberOfGroup = "";
    isMemberOfGroup = true;
    isMemberOfGroupList = [0];
    isDedupDone=false;

//Customer personal info 1

    personalInfoBean = PersonalInfo(" "," "," "," "," "," "," "," "," "," ");
    // personalInfoBean = PersonalInfo();
    radiopersonalInfo = [0, 0, 0, 0];
    title = "";
    firstName = "";
    middleName = "";
    lastName = "";
    applicantDob = null;
    applicantFatherName = "";
    applicantSpouseName = "";

//Customer Kyc 1

    imageVisibilityKyc1AppId1TagCustomer = false;
    imageVisibilityKyc1AppId12TagCustomer = false;
    imageVisibilityKyc1AppId13TagCustomer = false;
    imageVisibilityKyc1AppId2TagCustomer = false;
    imageVisibilityKyc1AppId22TagCustomer = false;
    imageVisibilityKyc1AppId23TagCustomer = false;
    imageVisibilityKyc1AppId24TagCustomer = false;
    imageVisibilityKyc1AppId25TagCustomer = false;
    imageVisibilityKyc1AppId26TagCustomer = false;
    imageVisibilityKyc1PassBook1TagCustomer = false;
    imageVisibilityKyc1PassBook2TagCustomer = false;
    imageVisibilityKyc1PassBook3TagCustomer = false;
    imageVisibilityKyc1PassBook4TagCustomer = false;
    kyc1PassBook1TagPicCustomer = "";
    kyc1PassBook2TagPicCustomer = "";
    kyc1PassBook3TagPicCustomer = "";
    kyc1PassBook4TagPicCustomer = "";
    kyc1AppId1PicTagCustomer = "";
    kyc1AppId12PicTagCustomer = "";
    kyc1AppId13PicTagCustomer = "";
    kyc1AppId2PicTagCustomer = "";
    kyc1AppId22PicTagCustomer = "";
    kyc1AppId23PicTagCustomer = "";
    kyc1AppId24PicTagCustomer = "";
    kyc1AppId25PicTagCustomer = "";
    kyc1AppId26PicTagCustomer = "";
    idType1 = "";
    idType2 = "";
    idType1Key = "";
    idType2Key = "";

    addressDetailsList = [];
    addressDetailsList.clear();
    addresType = "";
    currentAddress = "";
    district = "";
    thana = "";
    pin = "";
    post = "";
    mobileNumber = "";
    landLineNumber = "";

//familyDetails
    familyDetailsList = [];
    familyDetailsList.clear();
    familyMember;
    age = 0;
    education = "";
    relationship = "";
    occupation = "";
    income = 0.0;
    dependent = "";

//social financial details

    radioSocialFinancial = [0, 0, 0, 0, 0, 0, 0];
    socialFinancialDetailsBean = SocialFinancialDetailsBean();
    customModelsAssetsDetails = [];
    customModelsSavingsDetails = [];
    customerBankAccountNumber = 0;
    customerBankName = "";
    customerBankBranch = "";
    customerBankIFSC = "";

//BorrowingDetails

    borrowingDetails = [0];
    loanNumber = 0;
    name = "";
    loanAmount = 0.0;
    loanDate = "";
    oustandingAmount = "";
    currentLoanWithUs = "";
    repayMentDate = "";
    loanDetailsloanFromOthers = "";
    borrowingDetailsBean = [];

//PPI
    ppiMarksValue = ["", "", "", "", "", "", "", "", "", "", "", ""];


// business Details
    radioBusinessDetails = [
      0,
      0,
      0,
    ];


//Business CashFLow
    radioBusinessCashFlow = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    filepath = "";
    imageType = "";
    listImgBean.clear();

    imageVisibilityDeclarationFormTagCustomer = false;
    imageVisibilityDeclarationFormTagSpouse = false;
    imageFilePathGlobalDeclarationFormCustomerSignature = "";
    imageFilePathGlobalDeclarationFormSpouseSignature = "";
    pageRoutedFrom = "";
    socialFinancialInitializer = 0;
    customerType ="";
    tempAddressDetails = new AddressDetailsBean();
  }

  static Future makeRequest() async {
    var request = await new HttpClient().postUrl(Uri.parse(apiURL));
    request.persistentConnection = false; // Use non-persistent connection.
    var response = await request.close();
  }

  static Future<String> getData(String params) async {
    makeRequest();
    return "";
  }

  static Widget newTextButton(String title, VoidCallback onPressed) {
    return new FlatButton(
      child: new Text(title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold)),
      onPressed: onPressed,
    );
  }

  static Future<bool> checkIntCon() async {
    int isVPN = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      if(prefs.getInt(TablesColumnFile.ISVPN)!=null)
      isVPN = prefs.getInt(TablesColumnFile.ISVPN);
    }catch(_){

      isVPN = 0;
    }


    print("VP SELECTED = $isVPN");
    if(isVPN==1){
      Response bodyValue = await http.get(Constant.apiURL.toString()+"/serverCheck/getServerConnectivity");
      print(Constant.apiURL.toString()+"/serverCheck/getServerConnectivity");
      print(bodyValue.statusCode);
      if(bodyValue.statusCode==200) return true;
          else return false;


    }
    else{
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile){
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi){
        return true;
      }
      return false;

    }
    return true;
  }

  Future<bool> checkIfIsconnectedToNetwork() async {

    int isVPN = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      if(prefs.getInt(TablesColumnFile.ISVPN)!=null)
        isVPN = prefs.getInt(TablesColumnFile.ISVPN);
    }catch(_){

      isVPN = 0;
    }


    print("VP SELECTED = $isVPN");
    if(isVPN==1){
      Response bodyValue = await http.get(Constant.apiURL.toString()+"/serverCheck/getServerConnectivity");
      print(Constant.apiURL.toString()+"/serverCheck/getServerConnectivity");
      print(bodyValue.statusCode);
      if(bodyValue.statusCode==200) return true;
      else return false;


    }else{
      try {
        final result = await InternetAddress.lookup('www.google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      } on SocketException catch (_) {
        return false;
      }
    }

  }
}

class Dialog {
  static Future<bool> onWillPop(
      BuildContext context, String agrs1, String args2, String pageRoute) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(agrs1),
        content: new Text(args2),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => routePage(context, pageRoute),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }

  static Future<bool> onPop(BuildContext context, String agrs1, String args2,String pageRoutedFrom) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(agrs1),
        content: new Text(args2),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              Navigator.of(context).pop(true);
              if(pageRoutedFrom=="CustomerFormationMaster"){
                Utility.clearDataOfCustomerGlobals();
                Navigator.of(context).pop();
                CustomerFormationMasterTabsState.custListBean =  new  CustomerListBean();
                CustomerFormationMasterTabsState.addressBean = new AddressDetailsBean();
                CustomerFormationMasterTabsState.fdb = new FamilyDetailsBean();
                CustomerFormationMasterTabsState.ppiBean = new PPIMasterBean();
                CustomerFormationMasterTabsState.borrowingDetailsBean = new BorrowingDetailsBean();
                CustomerFormationMasterTabsState.applicantDob ="__-__-____";
                CustomerFormationMasterTabsState.loanDate ="__-__-____";
                CustomerFormationMasterTabsState.repaymentDate ="__-__-____";
                CustomerFormationMasterTabsState.husDob ="__-__-____";
                CustomerFormationMasterTabsState.resAddPresent = false;
                CustomerFormationMasterTabsState.tempBnkAccNo = "";
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                      //new CustomerFormationMasterTabs(widget.cameras)), //When Authorized Navigate to the next screen
                      new CustomerList(null, "Customers")),
                );
              }
              if(pageRoutedFrom=="Loan Application"){
                Navigator.of(context).pop();



                CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj = new CustomerLoanDetailsBean();
                fingerPrintAuthForLoanApplicationDone = false;
                CustomerLoanDetailsMasterTabState.isMarried = false;

                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                      // new LoanLimitDetails()), //When Authorized Navigate to the next screen
                      new CustomerLoanDetailsList("Loan Application",null)),
                );



              }


            },
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }

  static Future<bool> onDatSyncedPop(
      BuildContext context, bool circIndicatorIsDatSynced) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        actions: <Widget>[
          new Container(
            child: circIndicatorIsDatSynced == true
                ? CircularProgressIndicator(
              backgroundColor: Colors.black,
              strokeWidth: 2.0,
              key: Key('Syncing'),
            )
                : Navigator.of(context).pop(true),
          )
        ],
      ),
    ) ??
        false;
  }

  static Future<bool> alertPopup(
      BuildContext context, String agrs1, String args2, String pageRoute) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(agrs1),
        content: new Text(args2),
        actions: <Widget>[
          Center(
            child: new FlatButton(
              onPressed: () => alertPopupRoute(context, pageRoute),
              child: new Text('Ok'),
            ),
          ),
        ],
      ),
    ) ??
        false;
  }

  static alertPopupRoute(BuildContext context, String pageRoute) {
    if (pageRoute == 'Dashboard') {
      Navigator.of(context).pop(true);
    } else if (pageRoute == 'Family') {
      Navigator.of(context).pop(true);
    } else if (pageRoute == 'Same') {
      Navigator.of(context).pop(true);
    } else if(pageRoute == 'LoginPage'){
      Navigator.of(context).pop(true);
    } else if(pageRoute == 'HouseholdExpenditure'){
      Navigator.of(context).pop(true);
    } else if(pageRoute == 'BusinessExpenditure'){
      Navigator.of(context).pop(true);
    } else if(pageRoute == 'PPI'){
      Navigator.of(context).pop(true);
    } else if(pageRoute == 'AssetDetail'){
      Navigator.of(context).pop(true);
    }else if (pageRoute == 'Exit') {
      exit(0);
    }
  }

  static routePage(BuildContext context, String pageRoute) {
    if (pageRoute == 'Login') {
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new LoginPage(
                null)), //When Authorized Navigate to the next screen
      );
    } else if (pageRoute == 'CustomerList') {
      Utility.clearDataOfCustomerGlobals();
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new CustomerList(null,null)), //When Authorized Navigate to the next screen
      );
    } else if (pageRoute == 'Dashboard') {
      Utility.clearDataOfCustomerGlobals();
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new HomeDashboard()), //When Authorized Navigate to the next screen
      );
    } else if (pageRoute == 'Exit') {
      exit(0);
    }
  }

  static success(String message, BuildContext context, String routeTo) {
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
                  Text(message)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  routePage(context, routeTo);
                },
              ),
            ],
          );
        }
    );}
}
