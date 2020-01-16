import 'package:eco_mfi/pages/workflow/FPSPages/AgentLeftHandFingureCapture.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/home/Home_Dashboard.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';

import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationBusinessCashFlow3.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationBusinessDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationCenterAndGroupDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationContactDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationDeclarationForm.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationDocuments.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationExpenditureDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationFamilyDetails.dart';

import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationLoanDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationPersonalInfo.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationSocialFinancialDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/PPI.dart';

import 'package:eco_mfi/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AssetDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/BorrowingDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/BusinessExpenditureDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CurrentAssetsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerBusinessDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/EquityBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/FamilyDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/FixedAssetsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/HouseholdExpenditureDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/LongTermLiabilitiesBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/PPIBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ShortTermLiabilitiesBean.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ContactPointVerification.dart';
import 'bean/ContactPointVerificationBean.dart';
import 'bean/TabsDisplayBean.dart';

class CustomerFormationMasterTabs extends StatefulWidget {
  var cameras;
  final CustomerListBean customerObject;

  CustomerFormationMasterTabs(this.cameras, this.customerObject);

  @override
  CustomerFormationMasterTabsState createState() =>
      new CustomerFormationMasterTabsState();
}

class CustomerFormationMasterTabsState
    extends State<CustomerFormationMasterTabs>
    with SingleTickerProviderStateMixin {
  static CustomerListBean custListBean = new CustomerListBean();
  //static CustomerBusinessDetailsBean bussBean = new CustomerBusinessDetailsBean();
  static AddressDetailsBean addressBean = new AddressDetailsBean();
  static FamilyDetailsBean fdb = new FamilyDetailsBean();
  static BorrowingDetailsBean borrowingDetailsBean = new BorrowingDetailsBean();
  static BusinessExpenditureDetailsBean busiExpnBean = new BusinessExpenditureDetailsBean();
  static HouseholdExpenditureDetailsBean hhExpnBean = new HouseholdExpenditureDetailsBean();
  static AssetDetailsBean assetBean = new AssetDetailsBean();
  static PPIMasterBean ppiBean = new PPIMasterBean();
  static FixedAssetsBean fixedAssetBean = new FixedAssetsBean();
  static CurrentAssetsBean currentAssetsBean = new CurrentAssetsBean();
  static LongTermLiabilitiesBean longTermLiabilitiesBean = new LongTermLiabilitiesBean();
  static ShortTermLiabilitiesBean shortTermLiabilitiesBean = new ShortTermLiabilitiesBean();
  static EquityBean equityBean = new EquityBean();
  static String applicantDob = "__-__-____";
  static String loanDate = "__-__-____";
  static String repaymentDate = "__-__-____";
  static String husDob = "__-__-____";
  static String id1IssueDate = "__-__-____";
  static String id1ExpDate = "__-__-____";
  static String id2IssueDate = "__-__-____";
  static String id2ExpDate = "__-__-____";
  static String cpvDate = "____";

  static List<int> personalInfoRadios = new List<int>(5);
  static List<int> socialFinancialRadios = new List<int>(3);
  static List<int> businessDetailRadios = new List<int>(4);
  static List<int> businessCashFlowRadios = new List<int>(12);
  static List<int> familyDependantRadio = new List<int>(1);
  static bool resAddPresent = false;
  String maxLengthExceedFieldName = "";
  String globError = "";
  TabController _tabController;
  int tabState = 13;
  SharedPreferences prefs;
  String username;
  String usrGrpCode;
  static String tempBnkAccNo;
  String geoLatitude;
  String geoLongitude;
  bool isWasasa  = false;
  int routePosition = 0;
  bool isTabShow  = false;
  int isFullerTon=0;
  int isOnlyLongName=0;

  int lHMinFingCount =0;
  int rHMinFingCount =0;
  int leftHandfingerCount = 0;
  int rightHandfingerCount = 0;
  /* static final GlobalKey<ScaffoldState> _scaffoldKeyMaster =
      new GlobalKey<ScaffoldState>();*/
  /*static  GlobalKey scaffoldKeyMaster =
  new GlobalKey();*/
  List<TabsDisplayBean> tabDisplayWid =[ ];
  List<Widget> tabWidget =[ ];
  int isBiometricNeeded = 0;
  int ageValidationMinParams=0;
  int ageValidationMaxParams=0;

  @override
  void initState() {
    // TODO: implement initState

    getSessionVariables();

    super.initState();
    if(Constant.isCustTab1Show){
      TabsDisplayBean tabean = new TabsDisplayBean();
      tabean.tabName = 'Profile And Centers';
      tabean.tabWidget= new CustomerFormationCenterAndGroupDetails(widget.cameras);
      tabean.tabPosition= tabDisplayWid.length+1;
      tabDisplayWid.add(tabean);
      tabWidget.add(new CustomerFormationCenterAndGroupDetails(widget.cameras));
    }
    if(Constant.isCustTab2Show){
      TabsDisplayBean tabean = new TabsDisplayBean();
      tabean.tabName = 'Personal Information';
      tabean.tabWidget= new CustomerFormationPersonalInfo();
      tabean.tabPosition= tabDisplayWid.length+1;
      tabDisplayWid.add(tabean);
      tabWidget.add(new CustomerFormationPersonalInfo());
    }
    if(Constant.isCustTab3Show){
      TabsDisplayBean tabean = new TabsDisplayBean();
      tabean.tabName = 'Contact details';
      tabean.tabWidget= new CustomerFormationContactDetails();
      tabean.tabPosition= tabDisplayWid.length+1;
      tabDisplayWid.add(tabean);
      tabWidget.add(new CustomerFormationContactDetails());
    }
    if(Constant.isCustTab4Show){
      TabsDisplayBean tabean = new TabsDisplayBean();
      tabean.tabName = 'Family Details';
      tabean.tabWidget= new CustomerFormationFamilyDetails();
      tabean.tabPosition= tabDisplayWid.length+1;
      tabDisplayWid.add(tabean);
      tabWidget.add(new CustomerFormationFamilyDetails());
    }
    if(Constant.isCustTab5Show){
      TabsDisplayBean tabean = new TabsDisplayBean();
      tabean.tabName = 'Expenditure Detail';
      tabean.tabWidget= new CustomerFormationExpenditureDetails();
      tabean.tabPosition= tabDisplayWid.length+1;
      tabDisplayWid.add(tabean);
      tabWidget.add(new CustomerFormationExpenditureDetails());
    }
    if(Constant.isCustTab6Show){
      TabsDisplayBean tabean = new TabsDisplayBean();
      tabean.tabName = 'Social Financial';
      tabean.tabWidget= new CustomerFormationSocialFinancialDetails();
      tabean.tabPosition= tabDisplayWid.length+1;
      tabDisplayWid.add(tabean);
      tabWidget.add(new CustomerFormationSocialFinancialDetails());
    }
    if(Constant.isCustTab7Show){
      TabsDisplayBean tabean = new TabsDisplayBean();
      tabean.tabName = 'Loan Details';
      tabean.tabWidget= new CustomerFormationLoanDetails();
      tabean.tabPosition= tabDisplayWid.length+1;
      tabDisplayWid.add(tabean);
      tabWidget.add(new CustomerFormationLoanDetails());
    }
    if(Constant.isCustTab8Show){
      TabsDisplayBean tabean = new TabsDisplayBean();
      tabean.tabName = 'Business Details';
      tabean.tabWidget= new CustomerFormationBusinessDetails();
      tabean.tabPosition= tabDisplayWid.length+1;
      tabDisplayWid.add(tabean);
      tabWidget.add(new CustomerFormationBusinessDetails());
    }
    if(Constant.isCustTab9Show){
      TabsDisplayBean tabean = new TabsDisplayBean();
      tabean.tabName = 'Business Cashflow';
      tabean.tabWidget= new CustomerFormationBusinessCashFlow3();
      tabean.tabPosition= tabDisplayWid.length+1;
      tabDisplayWid.add(tabean);
      tabWidget.add(new CustomerFormationBusinessCashFlow3());
    }
    if(Constant.isCustTab10Show){
      TabsDisplayBean tabean = new TabsDisplayBean();
      tabean.tabName = 'Documents';
      tabean.tabWidget= new CustomerFormationDocuments(widget.cameras);
      tabean.tabPosition= tabDisplayWid.length+1;
      tabDisplayWid.add(tabean);
      tabWidget.add(new CustomerFormationDocuments(widget.cameras));
    }
    if(Constant.isCustTab11Show){
      TabsDisplayBean tabean = new TabsDisplayBean();
      tabean.tabName = 'Poverty Index';
      tabean.tabWidget= new PPI();
      tabean.tabPosition= tabDisplayWid.length+1;
      tabDisplayWid.add(tabean);
      tabWidget.add(new PPI());
    }
    if(Constant.isCustTab12Show){
      TabsDisplayBean tabean = new TabsDisplayBean();
      tabean.tabName = 'Contact Point Verification';
      tabean.tabWidget= new ContactPointVerification() ;
      tabean.tabPosition= tabDisplayWid.length+1;
      tabDisplayWid.add(tabean);
      tabWidget.add(new ContactPointVerification());
    } if(Constant.isCustTab13Show){
      TabsDisplayBean tabean = new TabsDisplayBean();
      tabean.tabName = 'Declaration Form';
      tabean.tabWidget= new CustomerFormationDeclarationForm() ;
      tabean.tabPosition= tabDisplayWid.length+1;
      tabDisplayWid.add(tabean);
      tabWidget.add(new CustomerFormationDeclarationForm());
    }
    _tabController = new TabController(
        vsync: this, initialIndex: 0, length: tabDisplayWid.length);


    // if (widget.customerObject == null || widget.customerObject.misCbCheckDone==1) {
    if (custListBean.familyDetailsList == null) {
      custListBean.familyDetailsList = new List<FamilyDetailsBean>();
    }
    if (custListBean.pPIMasterBean == null) {
      custListBean.pPIMasterBean = new List<PPIMasterBean>();
    }
    if (custListBean.borrowingDetailsBean == null) {
      custListBean.borrowingDetailsBean = new List<BorrowingDetailsBean>();
    }

    if (custListBean.addressDetails == null) {
      custListBean.addressDetails = new List<AddressDetailsBean>();
    }
    if (custListBean.customerBusinessDetailsBean == null) {
      custListBean.customerBusinessDetailsBean = new CustomerBusinessDetailsBean();
    }
    if (custListBean.contactPointVerificationBean == null) {
      custListBean.contactPointVerificationBean = new ContactPointVerificationBean();
    }
    /*if (custListBean.assetDetailsList == null) {
        custListBean.assetDetailsList = new List<CustomModel>();
      }
      if (custListBean.savingDetailsList == null) {
        custListBean.savingDetailsList = new List<CustomModel>();
      }*/



    // print("custbean "+custListBean.imageMaster.length.toString());
    CustomerFormationMasterTabsState.custListBean.imageMaster=new List<ImageBean>();
    if (CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState.custListBean.imageMaster.length != 23) {
      for (int i = 0; i <= 23; i++) {
        CustomerFormationMasterTabsState.custListBean.imageMaster.add(ImageBean());
        print("custbean "+CustomerFormationMasterTabsState.custListBean.imageMaster.length.toString());
      }
    }
    if(widget.customerObject!=null ){
      custListBean = widget.customerObject;
      if (widget.customerObject.mdob != null && widget.customerObject.mdob != 'null' && widget.customerObject.mdob != '') {
        String tempDay;
        String tempMonth;
        if (widget.customerObject.mdob.day
            .toString()
            .length == 1)
          tempDay = "0" + widget.customerObject.mdob.day.toString();
        else
          tempDay = widget.customerObject.mdob.day.toString();

        if (widget.customerObject.mdob.month
            .toString()
            .length == 1)
          tempMonth = "0" + widget.customerObject.mdob.month.toString();
        else
          tempMonth = widget.customerObject.mdob.month.toString();

        CustomerFormationMasterTabsState.applicantDob =
            CustomerFormationMasterTabsState.applicantDob
                .replaceRange(0, 2, tempDay);
        print(
            "applicant DOB = ${CustomerFormationMasterTabsState.applicantDob}");
        CustomerFormationMasterTabsState.applicantDob =
            CustomerFormationMasterTabsState.applicantDob
                .replaceRange(3, 5, tempMonth);
        print(
            "applicant DOB = ${CustomerFormationMasterTabsState.applicantDob}");
        CustomerFormationMasterTabsState.applicantDob =
            CustomerFormationMasterTabsState.applicantDob
                .replaceRange(
                6, 10, widget.customerObject.mdob.year.toString());

      }

      if (widget.customerObject.mhusdob != null && widget.customerObject.mhusdob != 'null' && widget.customerObject.mhusdob != '') {
        String tempDayH;
        String tempMonthH;
        if (widget.customerObject.mhusdob.day
            .toString()
            .length == 1)
          tempDayH = "0" + widget.customerObject.mhusdob.day.toString();
        else
          tempDayH = widget.customerObject.mhusdob.day.toString();

        if (widget.customerObject.mhusdob.month
            .toString()
            .length == 1)
          tempMonthH = "0" + widget.customerObject.mhusdob.month.toString();
        else
          tempMonthH = widget.customerObject.mhusdob.month.toString();

        CustomerFormationMasterTabsState.husDob =
            CustomerFormationMasterTabsState.husDob
                .replaceRange(0, 2, tempDayH);
        print(
            "applicant DOB = ${CustomerFormationMasterTabsState.husDob}");
        CustomerFormationMasterTabsState.husDob =
            CustomerFormationMasterTabsState.husDob
                .replaceRange(3, 5, tempMonthH);
        print(
            "applicant DOB = ${CustomerFormationMasterTabsState.husDob}");
        CustomerFormationMasterTabsState.husDob =
            CustomerFormationMasterTabsState.husDob
                .replaceRange(
                6, 10, widget.customerObject.mhusdob.year.toString());
      }
    }

    if (widget.customerObject != null) {
      custListBean = widget.customerObject;
      if (widget.customerObject.mid1issuedate != null &&
          widget.customerObject.mid1issuedate != 'null' &&
          widget.customerObject.mid1issuedate != '') {
        String tempDay;
        String tempMonth;
        if (widget.customerObject.mid1issuedate.day
            .toString()
            .length == 1)
          tempDay = "0" + widget.customerObject.mid1issuedate.day.toString();
        else
          tempDay = widget.customerObject.mid1issuedate.day.toString();

        if (widget.customerObject.mid1issuedate.month
            .toString()
            .length == 1)
          tempMonth = "0" + widget.customerObject.mid1issuedate.month.toString();
        else
          tempMonth = widget.customerObject.mid1issuedate.month.toString();

        CustomerFormationMasterTabsState.id1IssueDate =
            CustomerFormationMasterTabsState.id1IssueDate
                .replaceRange(0, 2, tempDay);

        CustomerFormationMasterTabsState.id1IssueDate =
            CustomerFormationMasterTabsState.id1IssueDate
                .replaceRange(3, 5, tempMonth);

        CustomerFormationMasterTabsState.id1IssueDate =
            CustomerFormationMasterTabsState.id1IssueDate.replaceRange(
                6, 10, widget.customerObject.mid1issuedate.year.toString());
      }
    }


    if (widget.customerObject != null) {
      custListBean = widget.customerObject;
      if (widget.customerObject.mid1expdate != null &&
          widget.customerObject.mid1expdate != 'null' &&
          widget.customerObject.mid1expdate != '') {
        String tempDay;
        String tempMonth;
        if (widget.customerObject.mid1expdate.day
            .toString()
            .length == 1)
          tempDay = "0" + widget.customerObject.mid1expdate.day.toString();
        else
          tempDay = widget.customerObject.mid1expdate.day.toString();

        if (widget.customerObject.mid1expdate.month
            .toString()
            .length == 1)
          tempMonth = "0" + widget.customerObject.mid1expdate.month.toString();
        else
          tempMonth = widget.customerObject.mid1expdate.month.toString();

        CustomerFormationMasterTabsState.id1ExpDate =
            CustomerFormationMasterTabsState.id1ExpDate
                .replaceRange(0, 2, tempDay);

        CustomerFormationMasterTabsState.id2ExpDate =
            CustomerFormationMasterTabsState.id1ExpDate
                .replaceRange(3, 5, tempMonth);

        CustomerFormationMasterTabsState.id1ExpDate =
            CustomerFormationMasterTabsState.id1ExpDate.replaceRange(
                6, 10, widget.customerObject.mid1expdate.year.toString());
      }
    }

    if (widget.customerObject != null) {
      custListBean = widget.customerObject;
      if (widget.customerObject.mid2issuedate != null &&
          widget.customerObject.mid2issuedate != 'null' &&
          widget.customerObject.mid2issuedate != '') {
        String tempDay;
        String tempMonth;
        if (widget.customerObject.mid2issuedate.day
            .toString()
            .length == 1)
          tempDay = "0" + widget.customerObject.mid2issuedate.day.toString();
        else
          tempDay = widget.customerObject.mid2issuedate.day.toString();

        if (widget.customerObject.mid2issuedate.month
            .toString()
            .length == 1)
          tempMonth = "0" + widget.customerObject.mid2issuedate.month.toString();
        else
          tempMonth = widget.customerObject.mid2issuedate.month.toString();

        CustomerFormationMasterTabsState.id2ExpDate =
            CustomerFormationMasterTabsState.id2ExpDate
                .replaceRange(0, 2, tempDay);

        CustomerFormationMasterTabsState.id2ExpDate =
            CustomerFormationMasterTabsState.id2ExpDate
                .replaceRange(3, 5, tempMonth);

        CustomerFormationMasterTabsState.id2ExpDate =
            CustomerFormationMasterTabsState.id2ExpDate.replaceRange(
                6, 10, widget.customerObject.mid2issuedate.year.toString());
      }
    }

    if (widget.customerObject != null) {
      custListBean = widget.customerObject;
      if (widget.customerObject.mid2expdate != null &&
          widget.customerObject.mid2expdate != 'null' &&
          widget.customerObject.mid2expdate != '') {
        String tempDay;
        String tempMonth;
        if (widget.customerObject.mid2expdate.day
            .toString()
            .length == 1)
          tempDay = "0" + widget.customerObject.mid2expdate.day.toString();
        else
          tempDay = widget.customerObject.mid2expdate.day.toString();

        if (widget.customerObject.mid2expdate.month
            .toString()
            .length == 1)
          tempMonth = "0" + widget.customerObject.mid2expdate.month.toString();
        else
          tempMonth = widget.customerObject.mid2expdate.month.toString();

        CustomerFormationMasterTabsState.id2ExpDate =
            CustomerFormationMasterTabsState.id2ExpDate
                .replaceRange(0, 2, tempDay);

        CustomerFormationMasterTabsState.id2ExpDate =
            CustomerFormationMasterTabsState.id2ExpDate
                .replaceRange(3, 5, tempMonth);

        CustomerFormationMasterTabsState.id2ExpDate =
            CustomerFormationMasterTabsState.id2ExpDate.replaceRange(
                6, 10, widget.customerObject.mid2expdate.year.toString());
      }
    }

    getsharedPreferences();
  }
  getsharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    /*if (prefs.getString(TablesColumnFile.mIsWasasa) != null &&
        prefs.getString(TablesColumnFile.mIsWasasa).trim() != "")
      isWasasa = prefs.getString(TablesColumnFile.mIsWasasa).trim();*/
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    if(prefs.getInt(TablesColumnFile.isWASASA)==1){
      isWasasa = true ;

    }
    else{
      isWasasa = false;
    }
<<<<<<< .mine

    try {
      isFullerTon = prefs.getInt(TablesColumnFile.ISFULLERTON);
    }catch(_){}

    try{
      isOnlyLongName =prefs.getInt(TablesColumnFile.ISONLYLONGNAME);
    }catch(_){}
/*      print(" prefs.getInt(TablesColumnFile.AGEVALIDATIONMIN) ${prefs.getInt(TablesColumnFile.AGEVALIDATIONMIN).toString()}");
    print(" prefs.getInt(TablesColumnFile.AGEVALIDATIONMIN) ${prefs.getInt(TablesColumnFile.AGEVALIDATIONMAX).toString()}");*/

    try {
      ageValidationMinParams = prefs.getInt(TablesColumnFile.AGEVALIDATIONMIN);
    }catch(_){}

    try {
      ageValidationMaxParams = prefs.getInt(TablesColumnFile.AGEVALIDATIONMAX);
    }catch(_){}

=======
    try {
      isFullerTon = prefs.getInt(TablesColumnFile.ISFULLERTON);
    }catch(_){}
    try{
      isOnlyLongName =prefs.getInt(TablesColumnFile.ISONLYLONGNAME);
    }catch(_){}
/*      print(" prefs.getInt(TablesColumnFile.AGEVALIDATIONMIN) ${prefs.getInt(TablesColumnFile.AGEVALIDATIONMIN).toString()}");
    print(" prefs.getInt(TablesColumnFile.AGEVALIDATIONMIN) ${prefs.getInt(TablesColumnFile.AGEVALIDATIONMAX).toString()}");*/
    try {
      ageValidationMinParams = prefs.getInt(TablesColumnFile.AGEVALIDATIONMIN);
    }catch(_){}
    try {
      ageValidationMaxParams = prefs.getInt(TablesColumnFile.AGEVALIDATIONMAX);
    }catch(_){}
>>>>>>> .r1143
    isBiometricNeeded = prefs.getInt(TablesColumnFile.ISBIOMETRICNEEDED);
    lHMinFingCount =prefs.getInt(TablesColumnFile.lHMinFingCount);
    rHMinFingCount =prefs.getInt(TablesColumnFile.rHMinFingCount);




    setState(() {
      username = prefs.getString(TablesColumnFile.musrcode);
      print("usre code "+username.toString());
      geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
      print("customer latitude "+prefs.get(TablesColumnFile.geoLatitude).toString());
      print("customer longitude "+prefs.get(TablesColumnFile.geoLongitude).toString());



    });
  }

  void setRadios() {}

  void _handleTabSelection() {
    print("tab no  is ${_tabController.index}");

  }

  Future<bool> callDialog() {
    globals.Dialog.onPop(
        context,
        'Are you sure?',
        'Do you want to Go To Customer List without saving data',
        "CustomerFormationMaster");
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        callDialog();
      },
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Customer Information",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 3.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              callDialog();
              //Navigator.of(context).pop();
            },
          ),
          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          bottom: new TabBar(
            controller: _tabController,
            indicatorColor: Colors.black,
            isScrollable: true,
            tabs: new List.generate(tabDisplayWid.length, (index) {
              return new Tab(text: tabDisplayWid[index].tabName.toUpperCase());
            }),
          ),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.save,
                color: Colors.white,
                size: 40.0,
              ),
              onPressed: () async {
<<<<<<< .mine

                if(!isCustFoundInDedup) {
                  submit();
                }else{
                  _showAlert(Translations.of(context).text('Cannot_Create_Customer'), "");
                  await getTapPosition("Profile And Centers");
                  _tabController.animateTo(routePosition);
                  return ;
                }

=======

                if(!isCustFoundInDedup) {
               submit();
                }else{
                  _showAlert(Translations.of(context).text('Cannot_Create_Customer'), "");
                  await getTapPosition("Profile And Centers");
                  _tabController.animateTo(routePosition);
                  return ;
                }
>>>>>>> .r1143
              },
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
            ),
          ],
        ),
        body: new TabBarView(
          controller: _tabController,
          children:  tabWidget,
        ),
      ),
    );
  }

  void showInSnackBar(String value, context, [Color color]) {
    final snackBar = SnackBar(
      content: Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    Scaffold.of(context).showSnackBar(snackBar);
  }

  submit() async {
    int customerNumberValue;

      bool isValidated = await validateTabs();


      if(isValidated){
        int id;
        CustomerListBean bean = new CustomerListBean();

        print("xxxx bean is ${bean}");

        if (custListBean.mcreateddt == null) {
          custListBean.mcreatedby = username;
          custListBean.mcreateddt = DateTime.now();
        }
        custListBean.mgeolatd = geoLatitude;
        custListBean.mgeologd = geoLongitude;
        custListBean.mlastupdateby = username;
        custListBean.mlastupdatedt = DateTime.now();
        custListBean.missynctocoresys=0;
        if (custListBean.mrefno == null) custListBean.mrefno = 0;

        try {
          custListBean.mdob = DateTime.parse(applicantDob.substring(6) +
              "-" +
              applicantDob.substring(3, 5) +
              "-" +
              applicantDob.substring(0, 2));
        } catch (e) {
          print("date Exception");
        }

        try {
          custListBean.mhusdob = DateTime.parse(husDob.substring(6) +
              "-" +
              husDob.substring(3, 5) +
              "-" +
              husDob.substring(0, 2));
        } catch (e) {
          print("date Exception");
        }
        try {
          custListBean.mid1issuedate= DateTime.parse(id1IssueDate.substring(6) +
              "-" +
              id1IssueDate.substring(3, 5) +
              "-" +
              id1IssueDate.substring(0, 2));
        } catch (e) {
          print("id 1 date Exception");
        }

        try {
          custListBean.mid1expdate= DateTime.parse(id1ExpDate.substring(6) +
              "-" +
              id1ExpDate.substring(3, 5) +
              "-" +
              id1ExpDate.substring(0, 2));
        } catch (e) {
          print("id 1 exp date Exception");
        }

        try {
          custListBean.mid2issuedate= DateTime.parse(id2IssueDate.substring(6) +
              "-" +
              id2IssueDate.substring(3, 5) +
              "-" +
              id2IssueDate.substring(0, 2));
        } catch (e) {
          print("id 1 exp date Exception");
        }



        try {
          custListBean.mid2issuedate= DateTime.parse(id2IssueDate.substring(6) +
              "-" +
              id2IssueDate.substring(3, 5) +
              "-" +
              id2IssueDate.substring(0, 2));
        } catch (e) {
          print("id 2 issue date Exception");
        }



        try {
          custListBean.mid2expdate= DateTime.parse(id2ExpDate.substring(6) +
              "-" +
              id2ExpDate.substring(3, 5) +
              "-" +
              id2ExpDate.substring(0, 2));
        } catch (e) {
          print("id 2 expdate Exception");
        }
        custListBean.mmobno=custListBean.addressDetails[0].mMobile;
        if(isOnlyLongName==0) {
          custListBean.mlongname = custListBean.mfname.toString() + " " +
              custListBean.mmname.toString() + " " +
              custListBean.mlname.toString();
        }
        await AppDatabase.get()
            .updateCustomerFoundationMasterDetailsTable(custListBean,true)
            .then((onValue) {
          customerNumberValue = onValue;
        });

        print("Customer Mater Update Complete");
        if(custListBean.addressDetails!=null) {
          await AppDatabase.get()
              .updateCustomerFoundationAddressDetailsListTable(custListBean,false)
              .then((onValue) {
            id = onValue;
          });
        }
        print("Customer adress Update Complete");
        if(custListBean.familyDetailsList!=null) {
          await AppDatabase.get()
              .updateCustomerFoundationFamilyDetailsListTable(custListBean)
              .then((onValue) {
            id = onValue;
          });
        }
        print("Customer family Update Complete");
        if(custListBean.borrowingDetailsBean!=null) {
          await AppDatabase.get()
              .updateCustomerFoundationBorrowingDetailsListTable(custListBean)
              .then((onValue) {
            id = onValue;
          });
        }
        print("Customer borrowing Update Complete");

        if (custListBean.customerBusinessDetailsBean == null) {
          custListBean.customerBusinessDetailsBean = new CustomerBusinessDetailsBean();
        }
        custListBean.customerBusinessDetailsBean.trefno =custListBean.trefno;
        custListBean.customerBusinessDetailsBean.mrefno =custListBean.mrefno;
        custListBean.customerBusinessDetailsBean.tbussdetailsrefno =1;
        custListBean.customerBusinessDetailsBean.mbussdetailsrefno =0;
        custListBean.customerBusinessDetailsBean.mcusactivitytype =0;

        await AppDatabase.get()
            .updateCustomerFoundationBusinessDetailsTable(custListBean)
            .then((onValue) {
          id = onValue;
        });
        print("Customer business details Update Complete");
        if (custListBean.contactPointVerificationBean == null) {
          custListBean.contactPointVerificationBean = new ContactPointVerificationBean();
        }
<<<<<<< .mine

        String assetsDesc ="";
        String assetsCode ="";
        for (int i = 0; i < globals.dropdownCaptionsValuesCpvMuliselect.length; i++) {

          if(globals.dropdownCaptionsValuesCpvMuliselect[i].manschecked ==1){
            assetsDesc = assetsDesc!=null && assetsDesc!=""?assetsDesc +"~"+globals.dropdownCaptionsValuesCpvMuliselect[i].mquestiondesc:globals.dropdownCaptionsValuesCpvMuliselect[i].mquestiondesc;
            assetsCode = assetsCode!=null && assetsCode!=""?assetsCode +"~"+globals.dropdownCaptionsValuesCpvMuliselect[i].mquestionid:globals.dropdownCaptionsValuesCpvMuliselect[i].mquestionid;
          }
        }

        custListBean.contactPointVerificationBean.massetvissibledesc = assetsDesc;
        custListBean.contactPointVerificationBean.massetvissiblecode= assetsCode;

=======
        String assetsDesc ="";
        String assetsCode ="";
        for (int i = 0; i < globals.dropdownCaptionsValuesCpvMuliselect.length; i++) {
          if(globals.dropdownCaptionsValuesCpvMuliselect[i].manschecked ==1){
            assetsDesc = assetsDesc!=null && assetsDesc!=""?assetsDesc +"~"+globals.dropdownCaptionsValuesCpvMuliselect[i].mquestiondesc:globals.dropdownCaptionsValuesCpvMuliselect[i].mquestiondesc;
            assetsCode = assetsCode!=null && assetsCode!=""?assetsCode +"~"+globals.dropdownCaptionsValuesCpvMuliselect[i].mquestionid:globals.dropdownCaptionsValuesCpvMuliselect[i].mquestionid;
          }
        }
        custListBean.contactPointVerificationBean.massetvissibledesc = assetsDesc;
        custListBean.contactPointVerificationBean.massetvissiblecode= assetsCode;
>>>>>>> .r1143
        custListBean.contactPointVerificationBean.trefno =custListBean.trefno;
        custListBean.contactPointVerificationBean.mrefno =custListBean.mrefno;
        custListBean.contactPointVerificationBean.tcpvrefno =1;
        custListBean.contactPointVerificationBean.mcpvrefno =0;
          //Update CPV here
        await AppDatabase.get()
            .updateCustomerCpvTable(custListBean)
            .then((onValue) {
          id = onValue;
        });
        print("Customer business details Update Complete");

        if(custListBean.businessExpendDetailsList!=null) {
          await AppDatabase.get()
              .updateCustomerBusinessExpenseDetailsListTable(custListBean)
              .then((onValue) {
            id = onValue;
          });
        }
        print("Customer business expenditure Update Complete");

        if(custListBean.householdExpendDetailsList!=null) {
          await AppDatabase.get()
              .updateCustomerHouseholdExpenseDetailsListTable(custListBean)
              .then((onValue) {
            id = onValue;
          });
        }
        print("Customer household expenditure Update Complete");

        if(custListBean.assetDetailsList!=null) {
          await AppDatabase.get()
              .updateCustomerAssetDetailsListTable(custListBean)
              .then((onValue) {
            id = onValue;
          });
        }
        print("Customer asset detail Update Complete");

        if(custListBean.pPIMasterBean!=null) {
          await AppDatabase.get()
              .updateCustomerPPIDetailsListTable(custListBean)
              .then((onValue) {
            id = onValue;
          });
        }

        for (int i = 0; i < 23; i++) {

          if (custListBean.imageMaster[i].imgString != "" &&
              custListBean.imageMaster[i].imgString != null) {
            custListBean.imageMaster[i].trefno = custListBean.trefno;
            /*if (custListBean.imageMaster[i].mrefno == null)
              custListBean.imageMaster[i].mrefno = 0;
            else*/
            custListBean.imageMaster[i].mrefno = custListBean.mrefno;

            AppDatabase.get().updateImageMaster(custListBean.imageMaster[i], i);
          }
        }

        if(custListBean.mcustno==null) custListBean.mcustno = 0;
        await AppDatabase.get().updateCreditBereauMasterisCuCrtd(custListBean.mpannodesc,custListBean.mIdDesc,1,custListBean.mcustno);
        success(
            'Customer is created sucessfully'
                'Table refrence Number is :  ${custListBean.trefno.toString()} for getting Core ',
            context);
      }


  }


  List<CustomModel> getKeyOrValueForMultiSelect(
      int multiSelectDropdownCaptionSocialFinancial) {
    List<CustomModel> beanList;
    if (multiSelectDropdownCaptionSocialFinancial == 0) {
      beanList = globals.customModelsAssetsDetails;
    } else if (multiSelectDropdownCaptionSocialFinancial == 1) {
      beanList = globals.customModelsSavingsDetails;
    }
    return beanList;
  }

  Future<bool> validateTabs() async{
    String error = "";
    bool isMaxLengthExceed=false;

   await leftFingerCount(); // This is counting the numbers of Left hand finger captured.
   await RightFingerCount();// This is counting the numbers of Right hand finger captured.


    if(CustomerFormationMasterTabsState.custListBean.imageMaster==null){
      CustomerFormationMasterTabsState.custListBean.imageMaster= new  List<ImageBean>();
      for(int i =0;i<23;i++){
        CustomerFormationMasterTabsState.custListBean.imageMaster.add(new ImageBean());
      }
    }


    bool isRet =false;
     //1st tab
    await getTapPosition("Profile And Centers");
    if(isTabShow)
      isRet = await validateProfileAndCenter();
      if(!isRet){
        return isRet;
      }
    isTabShow=false;
    await getTapPosition("Personal Information");
    if(isTabShow)
      isRet =  await validatePersonalInfo();
    if(!isRet){
      return isRet;
    }
    isTabShow=false;
    await getTapPosition("Contact details");
    if(isTabShow)

    isRet =  await validateContactInfo();
    if(!isRet){
      return isRet;
    }
    isTabShow=false;
    await getTapPosition("Social Financial");
    if(isTabShow)
    isRet =  await socialFinancialDetails();
    if(!isRet){
      return isRet;
    }


    isTabShow=false;
    await getTapPosition("Business Details");
    if(isTabShow)
    isRet =  await socialBussDetails();
    if(!isRet){
      return isRet;
    }
    isTabShow=false;
    await getTapPosition("Documents");
    if(isTabShow)
    isRet =  await documentDetails();
    if(!isRet){
      return isRet;
    }

    isTabShow=false;
<<<<<<< .mine
    await getTapPosition("Contact Point Verification");
    if(isTabShow)
      isRet =  await validateCPV();
    if(!isRet){
      return isRet;
    }

    isTabShow=false;
=======
    await getTapPosition("Contact Point Verification");
    if(isTabShow)
      isRet =  await validateCPV();
    if(!isRet){
      return isRet;
    }
    isTabShow=false;
>>>>>>> .r1143
    await getTapPosition("Declaration Form");
    if(isTabShow)
    isRet =  await declarationDetails();
    if(!isRet){
      return isRet;
    }

    return true;
  }


  leftFingerCount() async{

    if(CustomerFormationMasterTabsState
        .custListBean.imageMaster[13].imgSubType !=
        null &&
        CustomerFormationMasterTabsState
            .custListBean.imageMaster[13].imgSubType !=
            "")
      leftHandfingerCount++;

    if(CustomerFormationMasterTabsState
        .custListBean.imageMaster[14].imgSubType !=
        null &&
        CustomerFormationMasterTabsState
            .custListBean.imageMaster[14].imgSubType !=
            "")
      leftHandfingerCount++;
    if(CustomerFormationMasterTabsState
        .custListBean.imageMaster[15].imgSubType !=
        null &&
        CustomerFormationMasterTabsState
            .custListBean.imageMaster[15].imgSubType !=
            "")
      leftHandfingerCount++;
    if(CustomerFormationMasterTabsState
        .custListBean.imageMaster[16].imgSubType !=
        null &&
        CustomerFormationMasterTabsState
            .custListBean.imageMaster[16].imgSubType !=
            "")
      leftHandfingerCount++;

    if(CustomerFormationMasterTabsState
        .custListBean.imageMaster[17].imgSubType !=
        null &&
        CustomerFormationMasterTabsState
            .custListBean.imageMaster[17].imgSubType !=
            "")
      leftHandfingerCount++;




  }
  RightFingerCount() async{
    if(CustomerFormationMasterTabsState
        .custListBean.imageMaster[18].imgSubType !=
        null &&
        CustomerFormationMasterTabsState
            .custListBean.imageMaster[18].imgSubType !=
            "")
      rightHandfingerCount++;
    if(CustomerFormationMasterTabsState
        .custListBean.imageMaster[19].imgSubType !=
        null &&
        CustomerFormationMasterTabsState
            .custListBean.imageMaster[19].imgSubType !=
            "")
      rightHandfingerCount++;
    if(CustomerFormationMasterTabsState
        .custListBean.imageMaster[20].imgSubType !=
        null &&
        CustomerFormationMasterTabsState
            .custListBean.imageMaster[20].imgSubType !=
            "")
      rightHandfingerCount++;
    if(CustomerFormationMasterTabsState
        .custListBean.imageMaster[21].imgSubType !=
        null &&
        CustomerFormationMasterTabsState
            .custListBean.imageMaster[21].imgSubType !=
            "")
      rightHandfingerCount++;

    if(CustomerFormationMasterTabsState
        .custListBean.imageMaster[22].imgSubType !=
        null &&
        CustomerFormationMasterTabsState
            .custListBean.imageMaster[22].imgSubType !=
            "")
      rightHandfingerCount++;

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

  success(String message, BuildContext context) {
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
                children: <Widget>[Text(message)],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  custListBean = new CustomerListBean();
                  addressBean = new AddressDetailsBean();
                  fdb = new FamilyDetailsBean();
                  ppiBean = new PPIMasterBean();
                  borrowingDetailsBean = new BorrowingDetailsBean();
                  custListBean.customerBusinessDetailsBean = new CustomerBusinessDetailsBean();
                    custListBean.contactPointVerificationBean = new ContactPointVerificationBean();
                  busiExpnBean = new BusinessExpenditureDetailsBean();
                  hhExpnBean = new HouseholdExpenditureDetailsBean();
                  applicantDob = "__-__-____";
                  loanDate = "__-__-____";
                  repaymentDate = "__-__-____";
                  husDob = "__-__-____";
                  id1IssueDate ="__-__-____";
                  id1ExpDate ="__-__-____";
                  id2IssueDate ="__-__-____";
                  id2ExpDate ="__-__-____";
                  personalInfoRadios = new List<int>(5);
                  socialFinancialRadios = new List<int>(3);
                  businessDetailRadios = new List<int>(4);
                  businessCashFlowRadios = new List<int>(12);
                  familyDependantRadio = new List<int>(1);
                  CustomerFormationMasterTabsState.resAddPresent= false;
                  globals.isMemberOfGroup=true;
                  globals.isDedupDone=false;
                  tempBnkAccNo = "";
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => CustomerList(widget.cameras, name)), //When Authorized Navigate to the next screen
                  );
                },
              ),
            ],
          );
        });
  }


  getTapPosition(String matchTabName) async{
           for(int route =0 ; route< tabDisplayWid.length;route++) {
             if(tabDisplayWid[route].tabName.toUpperCase() == matchTabName.toUpperCase()) {
               isTabShow=true;
               routePosition = tabDisplayWid[route].tabPosition-1;

             }
               }
  }

  Future<bool> validateProfileAndCenter() async{

    //personalInformation
    if (custListBean.imageMaster[0].imgString == "" ||
        custListBean.imageMaster[0].imgString == null) {
      //Text(Translations.of(context).text('id1Exp'))
      _showAlert(Translations.of(context).text('customer_Picture'), Translations.of(context).text("itIsMand"));
      await getTapPosition("Profile And Centers");
      _tabController.animateTo(routePosition);
      return false;
    }

    if(!globals.isDedupDone){
      _showAlert(Translations.of(context).text('Dedup'), Translations.of(context).text("itIsMand"));
      _tabController.animateTo(routePosition);
      return false;
    }
    /**
     * @Added by UJK
     * This check is for making the biometric mandatory for  minimum three fingers of the Left Hand
     */

    print("lHMinFingCount "+lHMinFingCount.toString());
    print("RHMinFingCount "+rHMinFingCount.toString());
  /*  if(isBiometricNeeded==1 ){
      if ( lHMinFingCount>0 && leftHandfingerCount < lHMinFingCount) {
        _showAlert(Translations.of(context).text('Please_select_three_fingers_from_Left_hand'), Translations.of(context).text("itIsMand"));


        _tabController.animateTo(routePosition);
        return false;
      }
      *//**
       * @Added by UJK
       *This check is for making the biometric mandatory for minimum three fingers of the Right Hand.
       *//*
      if ( rHMinFingCount>0 &&  rightHandfingerCount < rHMinFingCount) {
        _showAlert(Translations.of(context).text('Please_select_three_fingers_from_Right_hand'), Translations.of(context).text("itIsMand"));

        _tabController.animateTo(routePosition);
        return false;
      }


    }*/




    SystemParameterBean sysBean = await AppDatabase.get().getSystemParameter('11', 0);


    if(sysBean.mcodevalue!=null&&sysBean.mcodevalue.toUpperCase() == 'N'){

    }else{
    if (custListBean.mIsMbrGrp == null) {
      _showAlert(Translations.of(context).text("memberOfAGroup"), Translations.of(context).text("itIsMand"));

      _tabController.animateTo(routePosition);
      return false;
    }

      if (custListBean.mIsMbrGrp == 0) {
        if (custListBean.mcenterid == "" || custListBean.mcenterid == null) {
          _showAlert(Translations.of(context).text("CENTERID"), Translations.of(context).text("itIsMand"));

          _tabController.animateTo(routePosition);
          return false;
        }
        if (custListBean.mgroupcd == "" || custListBean.mgroupcd == null) {
          _showAlert(Translations.of(context).text("GROUPID"), Translations.of(context).text("itIsMand"));

          _tabController.animateTo(routePosition);
          return false;
        }


        if (custListBean.mprofileind == "" || custListBean.mprofileind== null) {
          _showAlert(Translations.of(context).text("roleOfMember"), Translations.of(context).text("itIsMand"));

          _tabController.animateTo(routePosition);
          return false;
        }
        return true;
      }



      else if (custListBean.mIsMbrGrp == 1) {
        if (CustomerFormationMasterTabsState.custListBean.mcusttype== "" || CustomerFormationMasterTabsState.custListBean.mcusttype==null) {
          _showAlert(Translations.of(context).text("CustType"), Translations.of(context).text("itIsMand"));

          _tabController.animateTo(routePosition);
          return false;
        }
      }
      return true;


    }
  return true;
  }

  Future<bool> validatePersonalInfo() async {
    if (
    custListBean.mnametitle == null ||
        custListBean.mnametitle.trim() == "" ||
        custListBean.mnametitle.trim() == "null") {
      _showAlert(
          Translations.of(context).text("title"),
          Translations.of(context).text("titleCannotBeBlank"));

      _tabController.animateTo(routePosition);
      return false;
    }


    Utility ut = new Utility();
<<<<<<< .mine
    if (isOnlyLongName == 0) {
    error = ut.validateOnlyCharacterField(custListBean.mfname);
=======
    if (isOnlyLongName == 0) {
      error = ut.validateOnlyCharacterField(custListBean.mfname);
>>>>>>> .r1143

      if (error != null) {
        if (CustomerFormationMasterTabsState.custListBean.mcusttype == "INS") {
          _showAlert(Translations.of(context).text("instNm"), error);
        } else {
          _showAlert(Translations.of(context).text("firstName"), error);
        }

<<<<<<< .mine
        _tabController.animateTo(routePosition);
        return false;
      }
      error = ut.validateOnlyCharacterField(custListBean.mmname);
      if(error!=null){
      if (prefs.getInt(TablesColumnFile.isWASASA) == 1 &&
          (CustomerFormationMasterTabsState.custListBean.mmname == null ||
              CustomerFormationMasterTabsState.custListBean.mmname.trim() ==
                  "null"
              || CustomerFormationMasterTabsState.custListBean.mmname.trim() ==
                  "") && (
          CustomerFormationMasterTabsState.custListBean.mcusttype != "INS"
      )
      ) {
        _showAlert(
            Translations.of(context).text("middleName"),
            Translations.of(context).text("middleNameIsMandatory"));
=======
        _tabController.animateTo(routePosition);
        return false;
      }
>>>>>>> .r1143

<<<<<<< .mine
        _tabController.animateTo(routePosition);
        return false;
      }
      }
      error = ut.validateOnlyCharacterField(custListBean.mlname);
      if (error != null &&
          CustomerFormationMasterTabsState.custListBean.mcusttype != "INS") {
        //showInSnackBar("Last name has $error ",context);
        _showAlert(Translations.of(context).text("lastName"), error);
=======
      error = ut.validateOnlyCharacterField(custListBean.mmname);
      if(error!=null){
      if (prefs.getInt(TablesColumnFile.isWASASA) == 1 &&
          (CustomerFormationMasterTabsState.custListBean.mmname == null ||
              CustomerFormationMasterTabsState.custListBean.mmname.trim() ==
                  "null"
              || CustomerFormationMasterTabsState.custListBean.mmname.trim() ==
                  "") && (
          CustomerFormationMasterTabsState.custListBean.mcusttype != "INS"
      )
      ) {
        _showAlert(
            Translations.of(context).text("middleName"),
            Translations.of(context).text("middleNameIsMandatory"));
>>>>>>> .r1143

<<<<<<< .mine
        _tabController.animateTo(routePosition);
        return false;
      }
    } else {
      error = ut.validateOnlyCharacterField(custListBean.mlongname);
      if (error != null &&
          CustomerFormationMasterTabsState.custListBean.mcusttype != "INS") {
        //showInSnackBar("Last name has $error ",context);
        _showAlert(Translations.of(context).text("LongNm"), error);
=======
        _tabController.animateTo(routePosition);
        return false;
      }
    }
    error = ut.validateOnlyCharacterField(custListBean.mlname);
      if (error != null &&
          CustomerFormationMasterTabsState.custListBean.mcusttype != "INS") {
      //showInSnackBar("Last name has $error ",context);
      _showAlert(Translations.of(context).text("lastName"), error);
>>>>>>> .r1143

        _tabController.animateTo(routePosition);
        return false;
      }
    }
<<<<<<< .mine
    if ((custListBean.mgender == "" ||
        custListBean.mgender == null || custListBean.mgender == 0) &&
        CustomerFormationMasterTabsState.custListBean.mcusttype != "INS") {
=======
    } else {
      error = ut.validateOnlyCharacterField(custListBean.mlongname);
      if (error != null &&
          CustomerFormationMasterTabsState.custListBean.mcusttype != "INS") {
        //showInSnackBar("Last name has $error ",context);
        _showAlert(Translations.of(context).text("LongNm"), error);

        _tabController.animateTo(routePosition);
        return false;
      }
    }
    if((custListBean.mgender== "" ||
        custListBean.mgender== null||custListBean.mgender==0)&&
        CustomerFormationMasterTabsState.custListBean.mcusttype!="INS") {

>>>>>>> .r1143
      _tabController.animateTo(routePosition);
      _showAlert(Translations.of(context).text("Gender"),
          Translations.of(context).text("genderIsMandatory"));
      return false;
    }
    try {
      custListBean.mdob = DateTime.parse(applicantDob.substring(6) +
          "-" +
          applicantDob.substring(3, 5) +
          "-" +
          applicantDob.substring(0, 2));
<<<<<<< .mine


      int age=0;
      try {
        age = DateTime
            .now()
            .year - custListBean.mdob.year;
      }catch(_){}


      if(age < ageValidationMinParams){
        _showAlert(Translations.of(context).text("minDob"),
            Translations.of(context).text("mandtory"));
        _tabController.animateTo(routePosition);
        return false;
      }else if(age > ageValidationMaxParams){
        _showAlert(Translations.of(context).text("maxDob"),
            Translations.of(context).text("mandtory"));
        _tabController.animateTo(routePosition);
        return false;
      }

=======
      int age=0;
      try {
        age = DateTime
            .now()
            .year - custListBean.mdob.year;

      if(age < ageValidationMinParams){
        _showAlert(Translations.of(context).text("minDob"),
            Translations.of(context).text("mandtory"));
        _tabController.animateTo(routePosition);
        return false;
      }else if(age > ageValidationMaxParams){
        _showAlert(Translations.of(context).text("maxDob"),
            Translations.of(context).text("mandtory"));
        _tabController.animateTo(routePosition);
        return false;
      }
      }catch(_){}
>>>>>>> .r1143
    } catch (e) {
      if (CustomerFormationMasterTabsState.custListBean.mcusttype == "INS") {
        _showAlert(Translations.of(context).text("insEsttDt"),
            Translations.of(context).text("DtOfEstIsMand"));
<<<<<<< .mine
      } else {
        _showAlert(Translations.of(context).text("applicantDOB"),
            Translations.of(context).text("itIsMand"));
=======
      }else {
        _showAlert(Translations.of(context).text("applicantDOB"),
            Translations.of(context).text("itIsMand"));
>>>>>>> .r1143
      }

      _tabController.animateTo(routePosition);
      return false;
    }

    if (custListBean.mdob == "" || custListBean.mdob == null ||
        custListBean.mdob.isAfter(DateTime.now().subtract(Duration(days: 1)))
    ) {
      print(custListBean.mdob);
      print(custListBean.mdob.isAfter(
          DateTime.now().subtract(Duration(days: 1))));

      print(DateTime.now().subtract(Duration(days: 1)));

<<<<<<< .mine
      if (custListBean.mcusttype == "INS")
        _showAlert(
            Translations.of(context).text("DtOfEst"),
            Translations.of(context).text("DtOfEstNotCor"));
=======
      if (custListBean.mcusttype == "INS")
        _showAlert(
          Translations.of(context).text("DtOfEst"),
          Translations.of(context).text("DtOfEstNotCor"));
>>>>>>> .r1143
      else
        _showAlert(
            Translations.of(context).text("dateOfBirth"),
            Translations.of(context).text("Date Of Birth not Correct"));


      _tabController.animateTo(routePosition);
      return false;
    }

    if ((custListBean.mmaritialStatus == "" ||
        custListBean.mmaritialStatus == null) &&
        CustomerFormationMasterTabsState.custListBean.mcusttype != "INS") {
      _tabController.animateTo(routePosition);
      _showAlert(Translations.of(context).text("marStat"),
          Translations.of(context).text("itIsMand"));
      return false;
    }

<<<<<<< .mine
=======
/*    if(isFullerTon==1) {
      if (custListBean.mfathername == "" ||
          custListBean.mfathername == null ||
          custListBean.mfathername == null) {
        _tabController.animateTo(routePosition);
        _showAlert(Translations.of(context).text("fatherName"),
            Translations.of(context).text("itIsMand"));
        return false;
      }
    }*/
    print("custListBean.mfathername ${custListBean.mfathername}");
    if(isFullerTon==1){
      if (CustomerFormationMasterTabsState.custListBean.mfathername == null || CustomerFormationMasterTabsState.custListBean.mfathername.trim() == ""
      )  {
        _showAlert(
            Translations.of(context).text("fatherNameMand"),
            Translations.of(context).text("itIsMand"));

        _tabController.animateTo(routePosition);
        return false;
      }
    }


    if(isFullerTon==0) {
    if ((custListBean.mhusbandname == "" ||
        custListBean.mhusbandname == null) &&
        (custListBean.mfathername == "" || custListBean.mfathername == null)
        &&CustomerFormationMasterTabsState.custListBean.mcusttype!="INS"
    ) {
      _showAlert(
          Translations.of(context).text("SpouseNmORAppFatherNn"),
          Translations.of(context).text("cannotBeNull"));
>>>>>>> .r1143

    if(isFullerTon==0) {
      if ((custListBean.mhusbandname == "" ||
          custListBean.mhusbandname == null) &&
          (custListBean.mfathername == "" || custListBean.mfathername == null)
          && CustomerFormationMasterTabsState.custListBean.mcusttype != "INS"
      ) {
        _showAlert(
            Translations.of(context).text("SpouseNmORAppFatherNn"),
            Translations.of(context).text("cannotBeNull"));

        _tabController.animateTo(routePosition);
        return false;
      }
    }
    }

<<<<<<< .mine
    if (CustomerFormationMasterTabsState.custListBean.mmaritialStatus == 2) {
      if (CustomerFormationMasterTabsState.custListBean.mcusttype != "INS"
          &&
          (CustomerFormationMasterTabsState.custListBean.mhusbandname == null ||
              CustomerFormationMasterTabsState.custListBean.mhusbandname
                  .trim() == "" ||
              CustomerFormationMasterTabsState.custListBean.mhusbandname
                  .trim() == "null"
          )) {
        _showAlert(
            Translations.of(context).text("SpouseName"),
            Translations.of(context).text("It_Is_Mandatory"));
        _tabController.animateTo(routePosition);
        return false;
      }
      if (CustomerFormationMasterTabsState.custListBean.mcusttype != "INS"
          && CustomerFormationMasterTabsState.custListBean.mhusdob == null) {
        _showAlert(
            Translations.of(context).text("SpouseDOB"),
            Translations.of(context).text("It_Is_Mandatory"));
        _tabController.animateTo(routePosition);
        return false;
      }
    }
=======
    if(CustomerFormationMasterTabsState.custListBean.mmaritialStatus==2){


      if(CustomerFormationMasterTabsState.custListBean.mcusttype!="INS"
          &&
          (CustomerFormationMasterTabsState.custListBean.mhusbandname == null ||
              CustomerFormationMasterTabsState.custListBean.mhusbandname
                  .trim() == "" ||
              CustomerFormationMasterTabsState.custListBean.mhusbandname
                  .trim() == "null"
          )){

        _showAlert(
            Translations.of(context).text("SpouseName"),
            Translations.of(context).text("It_Is_Mandatory"));

        _tabController.animateTo(routePosition);
        return false;



      }

      if(isFullerTon==0) {
        if (CustomerFormationMasterTabsState.custListBean.mcusttype != "INS"
            && CustomerFormationMasterTabsState.custListBean.mhusdob == null) {
          _showAlert(
              Translations.of(context).text("SpouseDOB"),
              Translations.of(context).text("It_Is_Mandatory"));

          _tabController.animateTo(routePosition);
          return false;
        }
      }

      }



    if (isFullerTon == 0) {
    if((custListBean.mRuralUrban== null||custListBean.mRuralUrban == "" ||
        custListBean.mRuralUrban== 0)) {
>>>>>>> .r1143

    if(isFullerTon==1){
      if (custListBean.mfathername == "" ||
          custListBean.mfathername == null)  {
        _showAlert(
            Translations.of(context).text("fatherNameMand"),
            Translations.of(context).text("cannotBeNull"));

        _tabController.animateTo(routePosition);
        return false;
      }
      }
    }

    if (isFullerTon == 0) {
      if ((custListBean.mRuralUrban == null || custListBean.mRuralUrban == "" ||
          custListBean.mRuralUrban == 0)) {
        _tabController.animateTo(routePosition);
        _showAlert(Translations.of(context).text("region"),
            Translations.of(context).text("itIsMand"));
        return false;
      }
    }

<<<<<<< .mine
=======
    if (isFullerTon == 0) {
    if((custListBean.mrelegion== null||custListBean.mrelegion == "" ||
        custListBean.mrelegion== 0)&&
        CustomerFormationMasterTabsState.custListBean.mcusttype!="INS") {
>>>>>>> .r1143

    if (isFullerTon == 0) {
      if ((custListBean.mrelegion == null || custListBean.mrelegion == "" ||
          custListBean.mrelegion == 0) &&
          CustomerFormationMasterTabsState.custListBean.mcusttype != "INS") {
        _tabController.animateTo(routePosition);
        _showAlert(Translations.of(context).text("religion"),

            Translations.of(context).text("itIsMand"));
        return false;
      }
    }

    if ((custListBean.mqualification == null ||
        custListBean.mqualification == "" ||
        custListBean.mqualification == 0) &&
        CustomerFormationMasterTabsState.custListBean.mcusttype != "INS") {
      _tabController.animateTo(routePosition);
      _showAlert(

          Translations.of(context).text("qual"),
          Translations.of(context).text("itIsMand"));
      return false;
    }
    }

<<<<<<< .mine

    if ((CustomerFormationMasterTabsState.custListBean.mcaste == null ||
        CustomerFormationMasterTabsState.custListBean.mcaste == "" ||
        CustomerFormationMasterTabsState.custListBean.mcaste == 'null') &&
        (isWasasa == true &&
            CustomerFormationMasterTabsState.custListBean.mcusttype != "INS")) {
=======
    if ((custListBean.mqualification == null ||
        custListBean.mqualification == "" ||
        custListBean.mqualification== 0)&&
        CustomerFormationMasterTabsState.custListBean.mcusttype!="INS") {

>>>>>>> .r1143
      _tabController.animateTo(routePosition);
      _showAlert(

<<<<<<< .mine
          Translations.of(context).text("ethnicity"),
          Translations.of(context).text("itIsMand"));
=======
          Translations.of(context).text("qual"),
          Translations.of(context).text("itIsMand"));
>>>>>>> .r1143
      return false;
    }

    print("CustomerFormationMasterTabsState.custListBean.moccupation "+CustomerFormationMasterTabsState.custListBean.moccupation.toString());

<<<<<<< .mine
    if ((CustomerFormationMasterTabsState.custListBean.moccupation == null ||
        CustomerFormationMasterTabsState.custListBean.moccupation == 0) &&
        ((isWasasa == true) || isFullerTon == 1)) {
=======
    if ((CustomerFormationMasterTabsState.custListBean.mcaste == null ||
        CustomerFormationMasterTabsState.custListBean.mcaste == "" ||
        CustomerFormationMasterTabsState.custListBean.mcaste=='null')&&
        (isWasasa == true &&
            CustomerFormationMasterTabsState.custListBean.mcusttype != "INS")) {

>>>>>>> .r1143
      _tabController.animateTo(routePosition);
      _showAlert(

<<<<<<< .mine
          Translations.of(context).text("occp"),
          Translations.of(context).text("itIsMand"));
=======
          Translations.of(context).text("ethnicity"),
          Translations.of(context).text("itIsMand"));
>>>>>>> .r1143
      return false;
    }


<<<<<<< .mine
    if ((CustomerFormationMasterTabsState.custListBean.mmainoccupndesc ==
        null ||
        CustomerFormationMasterTabsState.custListBean.mmainoccupndesc == "" ||
        CustomerFormationMasterTabsState.custListBean.mmainoccupndesc.trim() ==
            'null') && (isWasasa == true)) {
=======
    if((CustomerFormationMasterTabsState.custListBean.moccupation== null||
        CustomerFormationMasterTabsState.custListBean.moccupation== 0)&&
        ((isWasasa == true) || isFullerTon == 1)) {

>>>>>>> .r1143
      _tabController.animateTo(routePosition);
      _showAlert(

<<<<<<< .mine
          Translations.of(context).text("mainOccp"),
          Translations.of(context).text("itIsMand"));
=======
          Translations.of(context).text("occp"),
          Translations.of(context).text("itIsMand"));
>>>>>>> .r1143
      return false;
    }

<<<<<<< .mine
    if ((CustomerFormationMasterTabsState.custListBean.msuboccupndesc == null ||
        CustomerFormationMasterTabsState.custListBean.msuboccupndesc == "" ||
        CustomerFormationMasterTabsState.custListBean.msuboccupndesc.trim() ==
            'null') && (isWasasa == true)) {
=======

    if ((CustomerFormationMasterTabsState.custListBean.mmainoccupndesc ==
        null ||
        CustomerFormationMasterTabsState.custListBean.mmainoccupndesc == "" ||
        CustomerFormationMasterTabsState.custListBean.mmainoccupndesc.trim() ==
            'null') && ((isWasasa == true) || isFullerTon == 1 )) {
>>>>>>> .r1143
      _tabController.animateTo(routePosition);
      _showAlert(

<<<<<<< .mine
          Translations.of(context).text("subOccp"),
          Translations.of(context).text("itIsMand"));
=======
          Translations.of(context).text("mainOccp"),
          Translations.of(context).text("itIsMand"));
>>>>>>> .r1143
      return false;
    }

<<<<<<< .mine
    if (isFullerTon == 0) {
      if ((custListBean.mlangofcust == null || custListBean.mlangofcust == "" ||
          custListBean.mlangofcust == 0) &&
          CustomerFormationMasterTabsState.custListBean.mcusttype != "INS") {
        _tabController.animateTo(routePosition);
        _showAlert(Translations.of(context).text("mthrTng"),
            Translations.of(context).text("itIsMand"));
        return false;
      }
    }

=======
    if ((CustomerFormationMasterTabsState.custListBean.msuboccupndesc == null ||
        CustomerFormationMasterTabsState.custListBean.msuboccupndesc == "" ||
        CustomerFormationMasterTabsState.custListBean.msuboccupndesc.trim() ==
            'null') && ((isWasasa == true) || isFullerTon == 1)) {
>>>>>>> .r1143
<<<<<<< .mine
    if (isFullerTon == 1 && (custListBean.mmemberno == null || custListBean.mmemberno == "" ||
    custListBean.mmemberno == 0)){
      _showAlert(Translations.of(context).text("isDependent"),
          Translations.of(context).text("itIsMand"));
=======
      _tabController.animateTo(routePosition);
      _showAlert(

          Translations.of(context).text("subOccp"),
          Translations.of(context).text("itIsMand"));
>>>>>>> .r1143
      return false;
    }

    if (isFullerTon == 0) {

<<<<<<< .mine

      return true;
=======
      _tabController.animateTo(routePosition);
        _showAlert(Translations.of(context).text("mthrTng"),
            Translations.of(context).text("itIsMand"));
      return false;
>>>>>>> .r1143
      }
    }
    if (isFullerTon == 1 && (custListBean.mmemberno == null || custListBean.mmemberno == "")){
      _showAlert(Translations.of(context).text("isDependent"),
          Translations.of(context).text("itIsMand"));
      return false;
    }
 Future<bool>  validateContactInfo() async{


    if(isFullerTon==1){
      if(custListBean.addressDetails==null || custListBean.addressDetails == [] || custListBean.addressDetails.length ==0 || custListBean.addressDetails.length <4){
        _tabController.animateTo(routePosition);
        _showAlert(Translations.of(context).text("addDet"),
            Translations.of(context).text("atAllAddIsMand"));

<<<<<<< .mine
        return false;
      }
    }

   if (custListBean.addressDetails==null || custListBean.addressDetails == [] || custListBean.addressDetails.length == 0) {

=======
        return false;
      }
    }
   if (custListBean.addressDetails==null || custListBean.addressDetails == [] || custListBean.addressDetails.length == 0) {

>>>>>>> .r1143
     _tabController.animateTo(routePosition);
     _showAlert(Translations.of(context).text("addDet"),
         Translations.of(context).text("atOneAddIsMand"));

     return false;
   }
   return true;

  }

  Future<bool> socialFinancialDetails() async{


    if (CustomerFormationMasterTabsState.resAddPresent== true &&
        (CustomerFormationMasterTabsState.custListBean.mHouse==null
            ||CustomerFormationMasterTabsState.custListBean.mHouse==0)

    ) {
      _showAlert(Translations.of(context).text("houseType"), Translations.of(context).text("itIsMand"));

      _tabController.animateTo(routePosition);
      return false;
    }

    if (CustomerFormationMasterTabsState.resAddPresent== true &&
        (CustomerFormationMasterTabsState.custListBean.mConstruct==null
            ||CustomerFormationMasterTabsState.custListBean.mConstruct==0)

    ) {
      _showAlert(Translations.of(context).text("Construction Type"), Translations.of(context).text("itIsMand"));

      _tabController.animateTo(routePosition);
      return false;
    }


    if (CustomerFormationMasterTabsState.resAddPresent== true &&
        (CustomerFormationMasterTabsState.custListBean.mToilet==null
            ||CustomerFormationMasterTabsState.custListBean.mToilet==0)

    ) {
      _showAlert(Translations.of(context).text("toiletType"),
          Translations.of(context).text("itIsMand"));

      _tabController.animateTo(routePosition);
      return false;
    }

    if (CustomerFormationMasterTabsState.resAddPresent== true &&
        (CustomerFormationMasterTabsState.custListBean.mutils==null
            ||CustomerFormationMasterTabsState.custListBean.mutils==0)

    ) {
      _showAlert(Translations.of(context).text("utils"),
          Translations.of(context).text("itIsMand"));

      _tabController.animateTo(routePosition);
      return false;
    }
    //bank detail
    print("validation");
    print(custListBean.mbankacyn);
    if (custListBean.mbankacyn == "" || custListBean.mbankacyn == null || custListBean.mbankacyn == "0") {
      if (custListBean.mbankacno == "" || custListBean.mbankacno == null || custListBean.mbankacno == "0" || custListBean.mbankacno == "null") {
        _showAlert(Translations.of(context).text("accountNo"),
            Translations.of(context).text("itIsMand"));

        _tabController.animateTo(routePosition);
        return false;
      }
      if(CustomerFormationMasterTabsState.tempBnkAccNo!=null&&CustomerFormationMasterTabsState.custListBean.mbankacno!=null
          &&CustomerFormationMasterTabsState.tempBnkAccNo.trim()!=CustomerFormationMasterTabsState.custListBean.mbankacno.trim()
      ){

        _showAlert(Translations.of(context).text("accountNo"),
            Translations.of(context).text("BothAccctNoShldMtch"));

        _tabController.animateTo(routePosition);
        return false;

      }

      if (custListBean.mbanknamelk == "" || custListBean.mbanknamelk == null) {
        _showAlert(Translations.of(context).text("BnkNm"),
            Translations.of(context).text("itIsMand"));

        _tabController.animateTo(routePosition);
        return false;
      }
      print("yessss mbanknamelk");
      if (custListBean.mbankbranch == "" || custListBean.mbankbranch == null) {
        _showAlert(Translations.of(context).text("Branch"), Translations.of(context).text("itIsMand"));

        _tabController.animateTo(routePosition);
        return false;
      }
      print("yessss mbankbranch");
      if ((prefs.getInt(TablesColumnFile.isWASASA)!=1)&&(custListBean.mbankifsc == "" || custListBean.mbankifsc == null)) {
        _showAlert(Translations.of(context).text("IFSCCd"), Translations.of(context).text("itIsMand"));

        _tabController.animateTo(routePosition);
        return false;
      }
      print("yessss mbankifsc");
    }
    return true;
  }

  Future<bool> socialBussDetails() async{

    if (custListBean.mOccBuisness== "" ||
        custListBean.mOccBuisness == null) {
      _showAlert(Translations.of(context).text("orgType"),
          Translations.of(context).text("itIsMand"));

      _tabController.animateTo(routePosition);

      return false;
    }
    return true;
  }

  Future<bool> documentDetails() async{

    if(CustomerFormationMasterTabsState.custListBean.mpanno!=99&&(

        CustomerFormationMasterTabsState.custListBean.mpannodesc == null||
            CustomerFormationMasterTabsState.custListBean.mpannodesc=="null"||
            CustomerFormationMasterTabsState.custListBean.mpannodesc == ""



    )){

      _tabController.animateTo(routePosition);
      _showAlert(Translations.of(context).text("ID1"),
          Translations.of(context).text("id1isMand"));
      return false;
    }

    if(isFullerTon==0 && CustomerFormationMasterTabsState.custListBean.mTypeOfId!=1&&(

        CustomerFormationMasterTabsState.custListBean.mIdDesc == null||
            CustomerFormationMasterTabsState.custListBean.mIdDesc=="null"||
            CustomerFormationMasterTabsState.custListBean.mIdDesc== ""

    )){

      _tabController.animateTo(routePosition);
      _showAlert(Translations.of(context).text("ID2"),
          Translations.of(context).text("id2isMand"));
      return false;
    }


    return true;


  }

  Future<bool> declarationDetails() async {

    if (custListBean.imageMaster[11].imgString == null ||
        custListBean.imageMaster[11].imgString == "" ) {
      _showAlert(Translations.of(context).text("custSig"),
          Translations.of(context).text("itIsMand"));

      _tabController.animateTo(routePosition);
      return false;
    }

    if (globals.accepted == false) {
      _tabController.animateTo(routePosition);
      _showAlert(Translations.of(context).text("declCheckBox"),
          Translations.of(context).text("selToCreateACust"));
      return false;
    }


    return true;
  }

<<<<<<< .mine
  Future<bool> validateCPV() async{

    if(custListBean.contactPointVerificationBean.maddmatch == null||
        custListBean.contactPointVerificationBean.maddmatch=="null"||
        custListBean.contactPointVerificationBean.maddmatch == ""){

      _tabController.animateTo(routePosition);
      _showAlert(Translations.of(context).text("Does_the_address_match_with_the_address_in_HH_Certificate"),
          Translations.of(context).text("isMand"));
      return false;
    }

 /*   if(custListBean.contactPointVerificationBean.massetvissiblecode == null||
        custListBean.contactPointVerificationBean.massetvissiblecode=="null"||
        custListBean.contactPointVerificationBean.massetvissiblecode == ""){

      _tabController.animateTo(routePosition);
      _showAlert(Translations.of(context).text("Assets_Visible"),
          Translations.of(context).text("isMand"));
      return false;
    }*/


    if(custListBean.contactPointVerificationBean.mhouseprptystatus == null||
        custListBean.contactPointVerificationBean.mhouseprptystatus=="null"||
        custListBean.contactPointVerificationBean.mhouseprptystatus == ""){

      _tabController.animateTo(routePosition);
      _showAlert(Translations.of(context).text("Year_Moved_in_current_Residence"),
          Translations.of(context).text("isMand"));
      return false;
    }


    if(custListBean.contactPointVerificationBean.mhousestructure == null||
        custListBean.contactPointVerificationBean.mhousestructure=="null"||
        custListBean.contactPointVerificationBean.mhousestructure == ""){

      _tabController.animateTo(routePosition);
      _showAlert(Translations.of(context).text("House_Property_Status"),
          Translations.of(context).text("isMand"));
      return false;
    }


    if(custListBean.contactPointVerificationBean.mhousewall == null||
        custListBean.contactPointVerificationBean.mhousewall=="null"||
        custListBean.contactPointVerificationBean.mhousewall == ""){

      _tabController.animateTo(routePosition);
      _showAlert(Translations.of(context).text("House_Structure"),
          Translations.of(context).text("isMand"));
      return false;
    }


    if(custListBean.contactPointVerificationBean.mhousewall == null||
        custListBean.contactPointVerificationBean.mhousewall=="null"||
        custListBean.contactPointVerificationBean.mhousewall == ""){

      _tabController.animateTo(routePosition);
      _showAlert(Translations.of(context).text("House_Wall"),
          Translations.of(context).text("isMand"));
      return false;
    }

    if(custListBean.contactPointVerificationBean.mhouseroof == null||
    custListBean.contactPointVerificationBean.mhouseroof=="null"||
        custListBean.contactPointVerificationBean.mhouseroof == ""){

    _tabController.animateTo(routePosition);
    _showAlert(Translations.of(context).text("House_Roof"),
    Translations.of(context).text("isMand"));
    return false;
    }
    return true;



  }

=======
  Future<bool> validateCPV() async{
    if(custListBean.contactPointVerificationBean.maddmatch == null||
        custListBean.contactPointVerificationBean.maddmatch=="null"||
        custListBean.contactPointVerificationBean.maddmatch == ""){
      _tabController.animateTo(routePosition);
      _showAlert(Translations.of(context).text("Does_the_address_match_with_the_address_in_HH_Certificate"),
          Translations.of(context).text("isMand"));
      return false;
    }
 /*   if(custListBean.contactPointVerificationBean.massetvissiblecode == null||
        custListBean.contactPointVerificationBean.massetvissiblecode=="null"||
        custListBean.contactPointVerificationBean.massetvissiblecode == ""){
      _tabController.animateTo(routePosition);
      _showAlert(Translations.of(context).text("Assets_Visible"),
          Translations.of(context).text("isMand"));
      return false;
    }*/
/*    if(custListBean.contactPointVerificationBean.mhouseprptystatus == null||
        custListBean.contactPointVerificationBean.mhouseprptystatus=="null"||
        custListBean.contactPointVerificationBean.mhouseprptystatus == ""){
      _tabController.animateTo(routePosition);
      _showAlert(Translations.of(context).text("Year_Moved_in_current_Residence"),
          Translations.of(context).text("isMand"));
      return false;
    }*/

    if(custListBean.contactPointVerificationBean.mhouseprptystatus == null||
        custListBean.contactPointVerificationBean.mhouseprptystatus=="null"||
        custListBean.contactPointVerificationBean.mhouseprptystatus == ""){
      _tabController.animateTo(routePosition);
      _showAlert(Translations.of(context).text("House_Property_Status"),
          Translations.of(context).text("isMand"));
      return false;
    }
    if(custListBean.contactPointVerificationBean.mhousestructure == null||
        custListBean.contactPointVerificationBean.mhousestructure=="null"||
        custListBean.contactPointVerificationBean.mhousestructure == ""){
      _tabController.animateTo(routePosition);
      _showAlert(Translations.of(context).text("House_Structure"),
          Translations.of(context).text("isMand"));
      return false;
    }
    if(custListBean.contactPointVerificationBean.mhousewall == null||
        custListBean.contactPointVerificationBean.mhousewall=="null"||
        custListBean.contactPointVerificationBean.mhousewall == ""){
      _tabController.animateTo(routePosition);
      _showAlert(Translations.of(context).text("House_Wall"),
          Translations.of(context).text("isMand"));
      return false;
    }
    if(custListBean.contactPointVerificationBean.mhouseroof == null||
        custListBean.contactPointVerificationBean.mhouseroof=="null"||
        custListBean.contactPointVerificationBean.mhouseroof == ""){
      _tabController.animateTo(routePosition);
      _showAlert(Translations.of(context).text("House_Roof"),
          Translations.of(context).text("isMand"));
      return false;
    }
/*    if(custListBean.contactPointVerificationBean.mhouseroof == null||
    custListBean.contactPointVerificationBean.mhouseroof=="null"||
        custListBean.contactPointVerificationBean.mhouseroof == ""){
    _tabController.animateTo(routePosition);
    _showAlert(Translations.of(context).text("House_Roof"),
    Translations.of(context).text("isMand"));
    return false;
    }*/
    return true;
  }
>>>>>>> .r1143
}


