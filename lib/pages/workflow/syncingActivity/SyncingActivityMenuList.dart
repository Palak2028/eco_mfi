import 'dart:async';
import 'dart:io';
import 'package:eco_mfi/MenuAndRights/UserRightsBean.dart';
import 'package:eco_mfi/pages/workflow/BranchMaster/BranchMasterService.dart';
import 'package:eco_mfi/pages/workflow/Guarantor/SyncGuarantorToMiddleware.dart';
import 'package:eco_mfi/pages/workflow/Kyc/SyncKycMasterToMiddleware.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanCashFlowService.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanImageSyncing.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/getCustomerLoanCashFlow.dart';
import 'package:eco_mfi/pages/workflow/LoanUtilization/SyncLoanUtilizationToMiddleware.dart';
import 'package:eco_mfi/pages/workflow/Savings/SyncSavingsCollectionListToMiddleware.dart';
import 'package:eco_mfi/pages/workflow/Savings/SyncSavingsListToMiddleware.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/FullScreenDialogForCenterSelection.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/disbursment/SyncDisbursmentListToMiddleware.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetCustomerFromCenter.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetDailyCollectionFromMiddleware.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetSavingsListFromMiddleware.dart';
<<<<<<< .mine

=======
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncCustomerLoanCPVBusinessRecordToMiddleware.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/LoanLevelService.dart';
>>>>>>> .r1143
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncGroupToMiddleware.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncDeviationFormToMiddleware.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncSocialAndEnvironmentalToMiddleware.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncTradeAndNeighbourRefCheckToMiddleware.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingDailyCollectedToMiddleware.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingGLAccounts.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/SyncingNewTermDepositToMiddleware.dart';
import 'package:eco_mfi/translations.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT1Services.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT2Services.dart';
import 'package:eco_mfi/pages/workflow/GRT/GRTServices.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFoundation.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanSyncing.dart';
import 'package:eco_mfi/pages/workflow/SpeedoMeter/bean/SpeedoMeterServices.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/ProspectServices.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/getProspectFormMiddleware.dart';
import 'package:eco_mfi/pages/workflow/qrScanner/QrScanner.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetCustomerFromMiddleware.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetLoanFromMiddleware.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingCountry.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingCustomerToMiddleware.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingProducts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncCentertoMiddleware.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetDisbursmentListFromMiddleware.dart';
import 'SyncingUSerAccessRights.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/LoanLevelService.dart';


class SyncingActivity extends StatefulWidget {
  @override
  SyncingActivityState createState() {
    return new SyncingActivityState();
  }
}

class SyncingActivityState extends State<SyncingActivity> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isDataSynced = false;
  bool circIndicatorIsDatSynced = false;
  FullScreenDialogForCenterSelection _myCenterDialog =
  new FullScreenDialogForCenterSelection("");
  CenterDetailsBean centerBean = new CenterDetailsBean();
  var addProspect = "/ProspectCreationMaster/add";
  var addProspectResult = "/creditBereauResultData/addCreditBereauResult/";
  var addProspectLoanResult = "/creditBereauLoanData/addLoanDetails/";
  var urlGetNOCInfo = "/ProspectCreationMaster/getListByRoutedTo/";
  static final _headers = {'Content-Type': 'application/json'};

  static const JsonCodec JSON = const JsonCodec();
  static Utility obj = new Utility();
  var urlGetCenterInfo = "createCentersFoundations/getCenterDataByCreatedByAndMlbrCode/";
  var urlGetGroupInfo = "createGroupsFoundations/getGroupDataByCreatedByAndMlbrCode";
  var urlUpdateCustomerLoanMaster = "customerLoanData/add/";
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  int branch = 0;
  String usrRole;
  QrScanner qr = new QrScanner();
  bool showAdvance = false;
  bool showAdvanceToServer = false;
  bool showAdvanceFromServer = false;
  String getAllCustomerOnId = "0";
  var formatter = new DateFormat('dd/MM/yyyy HH:mm');
  String loadingName= "Loading...";

  Map<int,LastSyncDateTimeBean> lastSyncMap;

  @override
  void initState() {
    lastSyncMap = new Map<int,LastSyncDateTimeBean>();
    super.initState();
    getSessionVariables();
  }



  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode);
      username = prefs.getString(TablesColumnFile.musrcode);
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      globals.branchCode = branch;
      globals.agentUserName = username;
    });

    SystemParameterBean sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('6', 0);
    getAllCustomerOnId = sysBean.mcodevalue!=null?sysBean.mcodevalue.trim():"0";
    await getDateTime();


  }



  Future<Null> getDateTime()async{


    await AppDatabase.get().getDateTime().then((List<LastSyncDateTimeBean>  lastSyncList){


      for(var LastSyncDateTimeBean in lastSyncList ){

        print(LastSyncDateTimeBean);
        lastSyncMap[LastSyncDateTimeBean.id] = LastSyncDateTimeBean;
      }



    });
    setState(() {

    });




  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Syncing activity'),
        backgroundColor: Color(0xff07426A),
      ),
      body: ModalProgressHUD(
        //  color: Colors.grey,
        inAsyncCall: circIndicatorIsDatSynced,
        //opacity: 10.5,
        color: Colors.white,
        //offset: ,
        // progressIndicator: FadingText('Loading...'),
        progressIndicator:  LinearPercentIndicator(
          width: MediaQuery.of(context).size.width - 10,
          animation: true,
          lineHeight: 50.0,
          animationDuration: 2500,
          //percent: 0.8,
          //center:  FadingText(loadingName),
	  center:  Text(loadingName),
          linearStrokeCap: LinearStrokeCap.butt,
          progressColor: Colors.grey,

        ),
        child: Container(
          child:SingleChildScrollView(
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (showAdvance == false) {
                      setState(() {
                        showAdvance = true;
                      });
                    } else if (showAdvance == true) {
                      setState(() {
                        showAdvance = false;
                      });
                    }
                  },
                  child: new Card(
                    child: new ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.sync),
                          onPressed: null,
                          iconSize: 30.0,
                          color: Colors.blueGrey,
                        ),
                        title: new Text(
                          "System Sync ",
                          style: TextStyle(fontSize: 30.0),
                        ),
                        subtitle: showAdvance == true
                            ? new Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[

                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff07426A),
                                ),
                                title: new Text(Constant
                                    .menusMaster),
                                onTap: () async {
                                  syncingMenusMasterData();
                                }),

                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff07426A),
                                ),
                                title: new Text(Constant
                                    .userAccessRights),
                                onTap: () async {
                                  syncingUserAccessRightsData();
                                }),
                      new ListTile(
                          leading: new Icon(
                            Icons.sync,
                            color: Color(0xff07426A),
                          ),
                          title: new Text(Constant.syncedSystemParameterLab),
                          onTap: () async {
                            syncSystemParameterData("Syncing Activity");
                          }),
                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff01579b),
                                ),
                                title:
                                new Text(Constant.syncBranchLab),
                                onTap: () async {
                                  _performSyncingBranch();
                                }),
                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff01579b),
                                ),
                                title: new Text(Constant.syncAddress),
                                onTap: () async {
                                  _performSyncingAddress();
                                }),




                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff07426A),
                                ),
                                title: new Text(
                                    Constant.syncedLookupsLab),
                                onTap: () async {
                                  syncLookupData();
                                }),


                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff01579b),
                                ),
                                title: new Text(
                                    Constant.syncSubLookupLab),
                                onTap: () async {
                                  _performSyncingSubLookup();
                                }),


                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff01579b),
                                ),
                                title:
                                new Text(Constant.syncProductLab),
                                onTap: () async {
                                  _performSyncingProduct();
                                }),
                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff07426A),
                                ),
                                title: new Text(
                                    Translations.of(context).text('syncLoanLevel')),
                                onTap: () async {
                                  _performSyncingLoanLevel();
                                }),

                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff07426A),
                                ),
                                title: new Text(
                                    Constant.syncedInterestSlabLab),
                                onTap: () async {
                                  syncInterestSlabData();
                                }),

                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff07426A),
                                ),
                                title: new Text(
                                    Constant.syncedInterestOffsetLab),
                                onTap: () async {
                                  syncInterestOffsetData();
                                }),

                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff07426A),
                                ),
                                title: new Text(Constant
                                    .syncLoanApprovalLimit),
                                onTap: () async {
                                  syncsyncingLoanApprovalLimitData();
                                }),

                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff07426A),
                                ),
                                title: new Text(Constant
                                    .syncedLoanCycleParameterPrimaryLab),
                                onTap: () async {
                                  syncLoanCycleParameterPrimaryData();
                                }),
                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff07426A),
                                ),
                                title: new Text(Constant
                                    .syncedLoanCycleSecondaryPrimaryLab),
                                onTap: () async {
                                  syncLoanCycleParameterSecondaryData();
                                }),




                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff07426A),
                                ),
                                title: new Text(Constant.syncedTdROI),
                                onTap: () async {
                                  _performSyncingTDRoiData();
                                }),



                          ],
                        )
                            : null,
                        trailing: IconButton(
                            icon: Icon(Icons.refresh),
                            iconSize: 50.0,
                            onPressed: () {
                              syncFactory("Syncing Activity");
                            })),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (showAdvanceToServer == false) {
                      setState(() {
                        showAdvanceToServer = true;
                      });
                    } else if (showAdvanceToServer == true) {
                      setState(() {
                        showAdvanceToServer = false;
                      });
                    }
                  },
                  child: new Card(
                    child: new ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.file_upload),
                          onPressed: null,
                          iconSize: 30.0,
                          color: Colors.blueGrey,
                        ),
                        title: new Text(
                          Constant.syncToServerLab,
                          style: TextStyle(fontSize: 30.0),
                        ),
                        subtitle: showAdvanceToServer == false
                            ? null
                            : new Column(
                          children: <Widget>[
                            /*new ListTile(
                              leading: new Icon(
                                Icons.sync,
                                color: Color(0xff01579b),
                              ),
                              title: new Text(
                                  Constant.uploadNOCCheckResultLab),
                              onTap: () async {
                                syncNOCCheckResult();
                              }),*/
                            new Container(
                              child: new ListTile(
                                  leading: new Icon(
                                    Icons.sync,
                                    color: Color(0xff07426A),
                                  ),
                                  title: new Text(
                                      Constant.syncCenterlab),
                                  subtitle:lastSyncMap.isEmpty||lastSyncMap[14].tlastSyncedFromTab==null||
                                      lastSyncMap[14].tlastSyncedFromTab=='null'||
                                      lastSyncMap[14].tlastSyncedFromTab==''?
                                      new Text('')
                                      :new Text(formatter.format(lastSyncMap[14].tlastSyncedFromTab),style: TextStyle(fontSize: 10.0),)
                                  ,
                                  onTap:
                                      () async {
                                    try {
                                      await  _performSyncingCenter();
                                    }catch(_){

                                    }
                                  }),
                            ),
                            new Container(
                              child: new ListTile(
                                  leading: new Icon(
                                    Icons.sync,
                                    color: Color(0xff07426A),
                                  ),
                                  title: new Text(
                                      Constant.syncedgrouplab),
                                  subtitle:lastSyncMap.isEmpty|| lastSyncMap[15].tlastSyncedFromTab==null||
                                      lastSyncMap[15].tlastSyncedFromTab=='null'||
                                      lastSyncMap[15].tlastSyncedFromTab==''?
                                  new Text('')
                                      :new Text(formatter.format(lastSyncMap[15].tlastSyncedFromTab),style: TextStyle(fontSize: 10.0))
                                  ,
                                  onTap:
                                      () async {
                                    try {
                                      await  _performSyncingGroup();
                                    }catch(_){

                                    }
                                  }),
                            ),
                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff01579b),
                                ),
                                title: new Text(
                                    Constant.syncProspectLab),
                                subtitle:lastSyncMap.isEmpty|| lastSyncMap[2].tlastSyncedFromTab==null||
                                    lastSyncMap[2].tlastSyncedFromTab=='null'||
                                    lastSyncMap[2].tlastSyncedFromTab==''?
                                new Text('')
                                    :new Text(formatter.format(lastSyncMap[2].tlastSyncedFromTab),style: TextStyle(fontSize: 10.0))
                                ,
                                onTap: () async {
                                  _performSyncingProspect();
                                }),
                            new Container(
                              child: new ListTile(
                                  leading: new Icon(
                                    Icons.sync,
                                    color: Color(0xff07426A),
                                  ),
                                  title: new Text(
                                      Constant.syncCustomerLab),
                                  subtitle:lastSyncMap.isEmpty|| lastSyncMap[1].tlastSyncedFromTab==null||
                                      lastSyncMap[1].tlastSyncedFromTab=='null'||
                                      lastSyncMap[1].tlastSyncedFromTab==''?
                                  new Text('')
                                      :new Text(formatter.format(lastSyncMap[1].tlastSyncedFromTab),style: TextStyle(fontSize: 10.0))
                                  ,
                                  onTap: () {
                                    syncedCustomerData();
                                  }),
                            ),
                            new Container(
                              child: new ListTile(
                                  leading: new Icon(
                                    Icons.sync,
                                    color: Color(0xff07426A),
                                  ),
                                  title: new Text(
                                      Constant.syncSavingsLab),
                                  subtitle: lastSyncMap.isEmpty||lastSyncMap[11].tlastSyncedFromTab==null||
                                      lastSyncMap[11].tlastSyncedFromTab=='null'||
                                      lastSyncMap[11].tlastSyncedFromTab==''?
                                  new Text('')
                                      :new Text(formatter.format(lastSyncMap[11].tlastSyncedFromTab),style: TextStyle(fontSize: 10.0))
                                  ,
                                  onTap: () {
                                    syncedSavingsData();
                                  }),
                            ),

                            new Container(
                              child: new ListTile(
                                  leading: new Icon(
                                    Icons.sync,
                                    color: Color(0xff07426A),
                                  ),
                                  title: new Text(
                                      Constant.syncLoanUtilization),
                                  onTap: () {
                                    syncedLoanUtilizationData();
                                  }),
                            ),
                            new Container(
                              child: new ListTile(
                                  leading: new Icon(
                                    Icons.sync,
                                    color: Color(0xff07426A),
                                  ),
                                  title: new Text(
                                      Constant.syncSavingsCollectionLab),
                                  subtitle:lastSyncMap.isEmpty|| lastSyncMap[12].tlastSyncedFromTab==null||
                                      lastSyncMap[12].tlastSyncedFromTab=='null'||
                                      lastSyncMap[12].tlastSyncedFromTab==''?
                                  new Text('')
                                      :new Text(formatter.format(lastSyncMap[12].tlastSyncedFromTab),style: TextStyle(fontSize: 10.0))
                                  ,
                                  onTap: () {
                                    syncedSavingsCollectionData();
                                  }),
                            ),

                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff01579b),
                                ),
                                title: new Text(
                                    Constant.syncLoanDetailsLab),
                                subtitle:lastSyncMap.isEmpty|| lastSyncMap[6].tlastSyncedFromTab==null||
                                    lastSyncMap[6].tlastSyncedFromTab=='null'||
                                    lastSyncMap[6].tlastSyncedFromTab==''?
                                new Text('')
                                    :new Text(formatter.format(lastSyncMap[6].tlastSyncedFromTab),style: TextStyle(fontSize: 10.0))
                                ,
                                onTap: () async {
                                  try {
                                   await  _performSyncingLoan();
                                  }catch(_){

                                  }
                                }),
                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff01579b),
                                ),
                                title: new Text("Sync SpeedoMeter"),
                                onTap: () async {
                                  _performSyncingSpeedoMeter();
                                }),
                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff01579b),
                                ),
                                title: new Text(
                                    Constant.syncDailyLoanCollected),
                                subtitle:lastSyncMap.isEmpty|| lastSyncMap[7].tlastSyncedFromTab==null||
                                    lastSyncMap[7].tlastSyncedFromTab=='null'||
                                    lastSyncMap[7].tlastSyncedFromTab==''?
                                new Text('')
                                    :new Text(formatter.format(lastSyncMap[7].tlastSyncedFromTab),style: TextStyle(fontSize: 10.0))
                                ,
                                onTap: () async {
                                  _performSyncingDailyLoanCollected();
                                }),
                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff01579b),
                                ),
                                title: new Text("Sync Term Deposit"),
                                subtitle:lastSyncMap.isEmpty|| lastSyncMap[13].tlastSyncedFromTab==null||
                                    lastSyncMap[13].tlastSyncedFromTab=='null'||
                                    lastSyncMap[13].tlastSyncedFromTab==''?
                                new Text('')
                                    :new Text(formatter.format(lastSyncMap[13].tlastSyncedFromTab),style: TextStyle(fontSize: 10.0))
                                ,
                                onTap: () async {
                                  //_performSyncingSpeedoMeter();
                                  _performSyncingTermDeposit();
                                }),
                            new Container(
                              child: new ListTile(
                                  leading: new Icon(
                                    Icons.sync,
                                    color: Color(0xff07426A),
                                  ),
                                  title: new Text(
                                      Constant.syncLoanData),
                                  onTap:
                                      () async {
                                    try {
                                      await  _performSyncingLoanCapturedData();
                                    }catch(_){

                                    }
                                  }),
        ),

                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff01579b),
                                ),
                                title: new Text( Translations.of(context).text('synDisbursedData')),
                                subtitle:lastSyncMap.isEmpty|| lastSyncMap[26]==null||lastSyncMap[26].tlastSyncedFromTab==null||
                                    lastSyncMap[26].tlastSyncedFromTab=='null'||
                                    lastSyncMap[26].tlastSyncedFromTab==''?
                                new Text('')
                                    :new Text(formatter.format(lastSyncMap[26].tlastSyncedFromTab),style: TextStyle(fontSize: 10.0))
                                ,
                                onTap: () async {
                                  _performSyncingDisbursedData();
                                }),

				
				
                          ],
                        ),
                        trailing: IconButton(
                            icon: Icon(Icons.refresh),
                            iconSize: 50.0,
                            onPressed: () {
                              syncToServer();
                            })),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (showAdvanceFromServer == false) {
                      setState(() {
                        showAdvanceFromServer = true;
                      });
                    } else if (showAdvanceFromServer == true) {
                      setState(() {
                        showAdvanceFromServer = false;
                      });
                    }
                  },
                  child: new Card(
                    child: new ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.file_download),
                          onPressed: null,
                          iconSize: 30.0,
                          color: Colors.blueGrey,
                        ),
                        title: new Text(
                          Constant.syncFromServerLab,
                          style: TextStyle(fontSize: 30.0),
                        ),
                        subtitle: showAdvanceFromServer == false
                            ? null
                            : Column(
                          children: <Widget>[
                            new Container(
                              child: new ListTile(
                                  leading: new Icon(
                                    Icons.sync,
                                    color: Color(0xff07426A),
                                  ),
                                  title: new Text(
                                      Constant.syncCenterlab),
                                  subtitle:lastSyncMap.isEmpty|| lastSyncMap[14].tlastSyncedToTab==null||
                                      lastSyncMap[14].tlastSyncedToTab=='null'||
                                      lastSyncMap[14].tlastSyncedToTab==''?
                                  new Text('')
                                      :new Text(formatter.format(lastSyncMap[14].tlastSyncedToTab),style: TextStyle(fontSize: 10.0),)
                                  ,
                                  onTap: () async {
                                    SystemParameterBean sysBean = await AppDatabase.get().getSystemParameter('11', 0);
                                    if(sysBean.mcodevalue!=null&&sysBean.mcodevalue.trim().toUpperCase() =='N'){
                                      return;
                                    }

                                    await syncedData('center');
                                  }),
                            ),
                            new Container(
                              child: new ListTile(
                                  leading: new Icon(
                                    Icons.sync,
                                    color: Color(0xff07426A),
                                  ),
                                  title: new Text(
                                      Constant.syncedgrouplab),
                                  subtitle:lastSyncMap.isEmpty|| lastSyncMap[15].tlastSyncedToTab==null||
                                      lastSyncMap[15].tlastSyncedToTab=='null'||
                                      lastSyncMap[15].tlastSyncedToTab==''?
                                  new Text('')
                                      :new Text(formatter.format(lastSyncMap[15].tlastSyncedToTab),style: TextStyle(fontSize: 10.0),)
                                  ,
                                  onTap: () async {
                                    SystemParameterBean sysBean = await AppDatabase.get().getSystemParameter('11', 0);
                                    if(sysBean.mcodevalue!=null&&sysBean.mcodevalue.trim().toUpperCase() =='N'){
                                      return;
                                    }
                                    await syncedData('group');
                                  }),
                            ),
                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff07426A),
                                ),
                                title: new Text(
                                    Constant.getWorkingCustomersLab),
                                subtitle:lastSyncMap.isEmpty|| lastSyncMap[1].tlastSyncedToTab==null||
                                    lastSyncMap[1].tlastSyncedToTab=='null'||
                                    lastSyncMap[1].tlastSyncedToTab==''?
                                new Text('')
                                    :new Text(formatter.format(lastSyncMap[1].tlastSyncedToTab),style: TextStyle(fontSize: 10.0),),
                                onTap: () async {
                                  SystemParameterBean sysBean = new SystemParameterBean();
                                  sysBean = await AppDatabase.get().getSystemParameter('6', 0);
                                  if(getAllCustomerOnId!=null&&getAllCustomerOnId.trim() =='1'){
                                    showMessageShortDuration("This module is locked") ;
                                  }
                                  else{
                                    getSyncedCustomerData();
                                    print("working");
                                  }
                                  //getSyncedCustomerData();
                                }),
                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff07426A),
                                ),
                                title: new Text(
                                    Constant.getFromCenterId),
                                onTap: () async {
                                  //await Constant.setSystemVariables();

                                  SystemParameterBean sysBean = await AppDatabase.get().getSystemParameter('11', 0);
                                  if(sysBean.mcodevalue!=null&&sysBean.mcodevalue.trim().toUpperCase() =='N'){
                                    return;
                                  }
                                  getCustommerFromCenterId();
                                }),
                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff01579b),
                                ),
                                title: new Text(
                                    Constant.getWorkingLoanLab),
                                subtitle:lastSyncMap.isEmpty|| lastSyncMap[6].tlastSyncedToTab==null||
                                    lastSyncMap[6].tlastSyncedToTab=='null'||
                                    lastSyncMap[6].tlastSyncedToTab==''?
                                new Text('')
                                    :new Text(formatter.format(lastSyncMap[6].tlastSyncedToTab),style: TextStyle(fontSize: 10.0),),
                                onTap: () async {
                                  _performGetWorkingLoan();
                                }),
                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff07426A),
                                ),
                                title: new Text(
                                    Constant.getAllProspectDataLab),
                                subtitle:lastSyncMap.isEmpty|| lastSyncMap[2].tlastSyncedToTab==null||
                                    lastSyncMap[2].tlastSyncedToTab=='null'||
                                    lastSyncMap[2].tlastSyncedToTab==''?
                                new Text('')
                                    :new Text(formatter.format(lastSyncMap[2].tlastSyncedToTab),style: TextStyle(fontSize: 10.0),),
                                onTap: () async {
                                  getAllProspectData();
                                }),
                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff07426A),
                                ),
                                title: new Text(
                                    Constant.getAllDisbursmentListLab),
                                subtitle:lastSyncMap.isEmpty|| lastSyncMap[15].tlastSyncedToTab==null||
                                    lastSyncMap[15].tlastSyncedToTab=='null'||
                                    lastSyncMap[15].tlastSyncedToTab==''?
                                new Text('')
                                    :new Text(formatter.format(lastSyncMap[15].tlastSyncedToTab),style: TextStyle(fontSize: 10.0),),
                                onTap: () async {
                                  getSyncedDisbursmentListData();
                                }),

                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff07426A),
                                ),
                                title: new Text(Constant.getDailyCollectionData),
                                subtitle:lastSyncMap.isEmpty|| lastSyncMap[7].tlastSyncedToTab==null||
                                    lastSyncMap[7].tlastSyncedToTab=='null'||
                                    lastSyncMap[7].tlastSyncedToTab==''?
                                new Text('')
                                    :new Text(formatter.format(lastSyncMap[7].tlastSyncedToTab),style: TextStyle(fontSize: 10.0),),
                                onTap: () async {

                                  getDailyCollectionData();
                                }),
                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff07426A),
                                ),
                                title: new Text(
                                    Constant.getAllSavingsListLab),
                                subtitle:lastSyncMap.isEmpty|| lastSyncMap[11].tlastSyncedToTab==null||
                                    lastSyncMap[11].tlastSyncedToTab=='null'||
                                    lastSyncMap[11].tlastSyncedToTab==''?
                                new Text('')
                                    :new Text(formatter.format(lastSyncMap[11].tlastSyncedToTab),style: TextStyle(fontSize: 10.0),),
                                onTap: () async {
                                  getSyncedSavingsListData();
                                }),
<<<<<<< .mine
                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff07426A),
                                ),
                                title: new Text(
                                    Translations.of(context).text('getCutomerLoanCashFlow')),
                                onTap: () async {
                                  getSyncedSavingsListData();
                                }),
=======
                            new ListTile(
                                leading: new Icon(
                                  Icons.sync,
                                  color: Color(0xff07426A),
                                ),
                                title: new Text(
                                    Translations.of(context).text('getLoanCapturedData')),
                                onTap: () async {
                                  getSyncedCustomerLoanCashFlow();
                                }),




>>>>>>> .r1143
                          ],
                        ),
                        trailing: IconButton(
                            icon: Icon(Icons.refresh),
                            iconSize: 50.0,
                            onPressed: () {
                              syncFromServer();
                            })),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onDatSyncedPop(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        actions: <Widget>[
          new Container(
            child: circIndicatorIsDatSynced == true
                ? CircularProgressIndicator()
                : Navigator.of(context).pop(true),
          )
        ],
      ),
    ) ??
        false;
  }

  Future<void> syncFactory(String fromPage) async {
    print("agent username " +
        username.toString() +
        " grp code " +
        usrGrpCode.toString());
    try{
      setState(() {
        isDataSynced = true;
        circIndicatorIsDatSynced = true;
      });
    }catch(_){}

    //await Constant.setSystemVariables();
    try {
      await syncingMenusMasterData();
    }catch(_){}
    try{
      await syncingUserAccessRightsData();
    }catch(_){}

    try{
      await syncSystemParameterData(fromPage);
    }catch(_){}

    try{
      await _performSyncingBranch();
    }catch(_){}

  try{
      await _performSyncingAddress();
    }catch(_){}

    try{
      await syncLookupData();
    }catch(_){}

    try{
      await _performSyncingSubLookup();
    }catch(_){}



    try{
      await _performSyncingProduct();
    }catch(_){}

    try{
      await _performSyncingLoanLevel();
    }catch(_){}

    try{
    await syncInterestSlabData();
    }catch(_){}
    try{
    await syncInterestOffsetData();
    }catch(_){}

    //await _performSyncingTDRoiData();// getting data for the table Product wise Interest table and Offset interest Master


 try{
    await syncLoanCycleParameterPrimaryData();
  }catch(_){}try{
    await syncLoanCycleParameterSecondaryData();
  }catch(_){}try{
    // generate dropdownrelated canges here
    await syncsyncingLoanApprovalLimitData();
  }catch(_){}

  try{
    await _performSyncingTDRoiData();
  }catch(_){}

  try{
    await Constant.getDropDownInitialize();
  }catch(_){}try{
    await Constant.setSystemVariables(fromPage);
  }catch(_){}
    UserRightBean beanGet;
  try{
    beanGet= new UserRightBean(mgrpcd: usrGrpCode,musrcode: username);
    await Constant.getAccessRights(beanGet);
  }catch(_){}



    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {}

    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }

  Future<void> syncFromServer() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    SystemParameterBean sysBean1 = new SystemParameterBean();
    try {
      sysBean1 = await AppDatabase.get().getSystemParameter('11', 0);
      if (sysBean1.mcodevalue != null &&
          sysBean1.mcodevalue.trim().toUpperCase() == 'N') {

      }
      else {
        await syncedData('center');
        await syncedData('group');
      }
    }catch(_){} try{

    await getAllProspectData();
    }catch(_){} try{
    await _performGetWorkingLoan();
    }catch(_){} try{
    SystemParameterBean sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('6', 0);
    if(getAllCustomerOnId!=null&&getAllCustomerOnId.trim() =='1'){
      showMessageShortDuration("This module is locked") ;
    }
    else{
      getSyncedCustomerData();
      print("working");
    }
    }catch(_){}
    //getSyncedCustomerData();
    /*await getSyncedCustomerData();*/
    //  await getSyncedSavingsListData();
    //await getNOCPendingData();

    /*if (Constant.getAllProspectData.contains(usrGrpCode)) {
      _ChooseAction();
    }*/

    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {}

    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }

  Future<void> syncToServer() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    /*await _performSyncingCenter();
    await _performSyncingGroup();*/
    await _performSyncingProspect();
    await syncedCustomerData();
    await syncedSavingsData();
    await syncedLoanUtilizationData();
    await syncedSavingsCollectionData();
    await _performSyncingLoan();
  /*  await _performSyncingCGT1();
    await _performSyncingCGT2();
    await _performSyncingGRT();*/
    await _performSyncingDailyLoanCollected();
    //await syncNOCCheckResult();

    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {}

    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }



  Future<void> syncedSavingsCollectionData() async {
    //if (Constant.syncCustomer.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    bool isSync =true;
    List customerList = new List();
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(11,false)
        .then((onValue) async {
      print("Customer Loan Synced Time is ${onValue}");
      await AppDatabase.get()
          .selectSavingsListIsDataSynced(onValue)
          .then((List<SavingsListBean> savingsList) async {
        print("returned Saving Account List is ${savingsList}");

        if(savingsList!=null&&savingsList.length>0){

          print("Coming Inside");
          isSync= false;
          showMessageShortDuration("Sync Saving Account to Middleware First",Colors.red);
          return;
        }

      });


    });


    if(isSync==false){
      setState(() {
        circIndicatorIsDatSynced = false;
      });
      return;}





    await _tryPostSavingsCollectionList();
    await getDateTime();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    // }
  }

  Future<void> syncedLoanUtilizationData() async {
    //if (Constant.syncCustomer.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    await _tryPostLoanUtilizationList();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    // }
  }

  Future<void> syncedSavingsData() async {
    //if (Constant.syncCustomer.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });



    bool isSync =true;
    List customerList = new List();
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(1,false)
        .then((onValue) async {
      print("Customer Loan Synced Time is ${onValue}");
      await AppDatabase.get()
          .selectCustomerListIsDataSynced(onValue)
          .then((List<CustomerListBean> customerData) async {
        print("returned CustomerList is ${customerData}");

        if(customerData!=null&&customerData.length>0){

          print("Coming Inside");
          isSync= false;
          showMessageShortDuration("Sync Customer to Middleware First",Colors.red);
          return;
        }

      });


    });


    if(isSync==false){
      setState(() {
        circIndicatorIsDatSynced = false;
      });
      return;}


    await _tryPostSavingsList();
    await getDateTime();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    // }
  }

  Future<void> syncedCenterData() async {
    //if (Constant.syncCustomer.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    await _tryPostCenterList();
    await getDateTime();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    // }
  }

  Future<void> syncedCustomerData() async {
    //if (Constant.syncCustomer.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });


    try{
      await _tryPost();
    }catch(_){
    }
    await getDateTime();
    setState(() {
      circIndicatorIsDatSynced = false;
    });

    /*await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(14, false).then((onValue) async{
      await AppDatabase.get()
          .selectCenterListIsDataSynced(onValue)
          .then((List<CenterDetailsBean> centerData) async {
        print("centerData.length  "+centerData.length.toString() );
        if (centerData.length > 0) {

          setState(() {
            circIndicatorIsDatSynced = false;
            showMessage("Please sync Center before Syncing Customer");
          });
        }else{
          await AppDatabase.get()
              .selectStaticTablesLastSyncedMaster(15, false).then((onValue) async{
            await AppDatabase.get()
                .selectGroupListIsDataSynced(onValue)
                .then((List<GroupFoundationBean> groupData) async {
              print("groupData.length  "+groupData.length.toString() );
              if (groupData.length > 0) {

                setState(() {
                  circIndicatorIsDatSynced = false;
                  showMessage("Please sync Group before Syncing Customer");
                });
              }else{
                try{
                  await _tryPost();
                }catch(_){
                }
                setState(() {
                  circIndicatorIsDatSynced = false;
                });
              }
            });
          });

        }
      });
    });*/
    // }
  }


  Future<void> syncedData(String forWhat) async {
    if ((forWhat == "group" /*&& Constant.syncGroup.contains(usrGrpCode)*/) ||
        (forWhat == "center" /*&& Constant.syncCenter.contains(usrGrpCode)*/)) {
      setState(() {
        isDataSynced = true;
        circIndicatorIsDatSynced = true;
      });
      await _trySave(forWhat);

      setState(() {
        circIndicatorIsDatSynced = false;
      });
    }
  }

  Future<void> getNOCPendingData() async {
    // if (Constant.getNOCPendingData.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    loadingName= Constant.gettingNOCPendingData;
   // showMessage(Constant.gettingNOCPendingData);
    ProspectServices service = new ProspectServices();
    // await service.trySaveNOCPendingData(prefs);

    setState(() {
      circIndicatorIsDatSynced = false;
    });
    /*} else {
      showMessage("Not Autorised for ${usrGrpCode}");
    }*/
  }

  Future<void> getAllProspectData() async {
    /*if (Constant.getAllProspectData.contains(usrGrpCode)) {*/
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    loadingName= Constant.gettingALLProspect;
   // showMessage(Constant.gettingALLProspect);
    GetProspectFromMiddleware getProspect = new GetProspectFromMiddleware();
    await getProspect.getProspect();

    await getDateTime();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    // }
  }


  Future<void> getDailyCollectionData() async {
    /*if (Constant.getAllProspectData.contains(usrGrpCode)) {*/
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    loadingName= Constant.getDailyCollectionData;
    GetDailyCollectionFromMiddleware getDailyCollectionFromMiddleware = new GetDailyCollectionFromMiddleware();
    //showMessage(Constant.getDailyCollectionData);

    await getDailyCollectionFromMiddleware.trySave(branch,username);

    await getDateTime();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    // }
  }


  Future<void> syncNOCCheckResult() async {
    /*if (Constant.uploadNOCCheckRes.contains(usrGrpCode)) {*/
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    ProspectServices service = new ProspectServices();
    //await service.trySaveNOCCheckResult(prefs);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> getNOCCheckResult() async {
    //if (Constant.getNOCCheckResult.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    loadingName= Constant.gettingNOCCheckResult;
   // showMessage(Constant.gettingNOCCheckResult);
    ProspectServices service = new ProspectServices();
    //await service.trySaveNOCFinalResult(prefs);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> syncedProspectResult(String userName) async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    ProspectServices services = new ProspectServices();
    //await services.trySaveProspectResult(userName, prefs);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }

  Future<void> getSyncedCustomerData() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    loadingName= Constant.gettingWorkingCustomer;
    //showMessage(Constant.gettingWorkingCustomer);
    GetCustomerFromMiddleware getCustomerFromMiddleware =
    new GetCustomerFromMiddleware();
    await getCustomerFromMiddleware.trySave(username);
    await getDateTime();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }

  Future<void> getSyncedSavingsListData() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    loadingName= Constant.gettingSavingsList;
   // showMessage(Constant.gettingSavingsList);
    GetSavingsListFromMiddleware getSavingsListFromMiddleware =
    new GetSavingsListFromMiddleware();
    await getSavingsListFromMiddleware.trySave(username);
    await getDateTime();
    setState(() {
      circIndicatorIsDatSynced = false;
    });

  }
  Future<void> getSyncedDisbursmentListData() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    loadingName= Constant.gettingDisbursmentList;
   // showMessage(Constant.gettingDisbursmentList);
    GetDisbursmentListFromMiddleware getDisbursmentListFromMiddleware =
    new GetDisbursmentListFromMiddleware();
    await getDisbursmentListFromMiddleware.trySave(username);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }
  Future<void> syncInterestSlabData() async {
    print("Inside interest slab data");
    //if(Constant.syncInterestSlab.contains(22)){
    print("Inside slab if condition");
    loadingName= Constant.syncingInterestSlab;
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    //showMessage(Constant.syncingInterestSlab);
    try {
      await AppDatabase.get().createInterestSlabInsert();
    }catch(_){}
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    // }

  }
  Future<void> syncInterestOffsetData() async {
    //if(Constant.syncInterestOffset.contains(22)){
    loadingName= Constant.syncingInterestOffset;
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    //showMessage(Constant.syncingInterestOffset);
    try {
      await AppDatabase.get().createInterestOffsetInsert();
    }catch(_){}
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}

  }
  Future<void> syncLoanCycleParameterPrimaryData() async {
    //if(Constant.syncLoanCycleParameterPrimary.contains(22)){
    loadingName= Constant.syncingLoanCycleParameterPrimary;
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    //showMessage(Constant.syncingLoanCycleParameterPrimary);
    try {
      await AppDatabase.get().createLoanCycleParameterPrimaryInsert(branch);
    }catch(_){}
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //  }

  }
  Future<void> syncLoanCycleParameterSecondaryData() async {
    //if(Constant.syncLoanCycleParameterSecondary.contains(22)){
    loadingName= Constant.syncingLoanCycleParameterSecondary;
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    //showMessage(Constant.syncingLoanCycleParameterSecondary);
    try {
      await AppDatabase.get().createLoanCycleParameterSecondaryInsert(branch);
    }catch(_){}
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}

  }



  Future<void> syncsyncingLoanApprovalLimitData() async {
    //if(Constant.syncLoanCycleParameterSecondary.contains(22)){
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    loadingName = Constant.syncingLoanApprovalLimit;
    //showMessage(Constant.syncingLoanApprovalLimit);
    try {
      await AppDatabase.get().createLoanApprovalLimitInsert(
          branch, username, usrGrpCode);
    }catch(_){}
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}

  }


  Future<void>  syncingUserAccessRightsData() async {
    //if(Constant.syncLoanCycleParameterSecondary.contains(22)){
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    loadingName = Constant.syncingUserAccessRights;

    //showMessage(Constant.syncingUserAccessRights);
    Constant.syncingUserAccessRightsData(username,usrGrpCode);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }
  Future<void>  syncingMenusMasterData() async {
    //if(Constant.syncLoanCycleParameterSecondary.contains(22)){
    loadingName = Constant.fetchMenusMaster;
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });


    //showMessage(Constant.syncingMenusMaster);
    Constant.seySyncedUserMaster();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }
  Future<void> syncLookupData() async {
    //if (Constant.syncLookups.contains(usrGrpCode)) {
    loadingName = Constant.syncingLookups;
    setState(() {

      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });




    //showMessage(Constant.syncingLookups);//
    try {
      await AppDatabase.get().createLookupInsert();
    }catch(_){}
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> _performSyncingProduct() async {
    //if (Constant.syncProduct.contains(usrGrpCode)) {
    loadingName = Constant.syncingProduct;
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    SyncingProducts syncingProducts = new SyncingProducts();

    //showMessage(Constant.syncingProduct);
    try {
      await syncingProducts.trySave(branch);
    }catch(_){}
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }


  Future<void> _performSyncingBranch() async {
    //if (Constant.syncProduct.contains(usrGrpCode)) {
    loadingName = Constant.syncingBranch;
    setState(() {

      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    BranchMasterServices branchMasterServices = new BranchMasterServices();

    //showMessage(Constant.syncingBranch);
    await branchMasterServices.trySave(branch);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> _performSyncingAddress() async {
    //if (Constant.syncProduct.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    SyncingCountry syncingCountry = new SyncingCountry();
    loadingName = Constant.syncingAddress;
    await syncingCountry.trySave(branch);
   // showMessage(Constant.syncingAddress);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }
  Future<void> _performSyncingLoan() async {
    //if (Constant.syncLoanDetails.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    bool isSync =true;
    List customerList = new List();
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(1,false)
        .then((onValue) async {
          print("Customer Loan Synced Time is ${onValue}");
      await AppDatabase.get()
          .selectCustomerListIsDataSynced(onValue)
          .then((List<CustomerListBean> customerData) async {
            print("returned CustomerList is ${customerData}");

         if(customerData!=null&&customerData.length>0){

           print("Coming Inside");
           isSync= false;
           showMessageShortDuration("Sync Customer to Middleware First",Colors.red);
           return;
         }

      });


    });


    if(isSync==false){
      setState(() {
        circIndicatorIsDatSynced = false;
      });
      return;}
    CustomerLoanServices customerLoanServices = new CustomerLoanServices();
    await customerLoanServices.getAndSync(userCode);

   /* try{
      SyncGuarantorToMiddleware syncGuarantorToMiddleware = new SyncGuarantorToMiddleware();
      await syncGuarantorToMiddleware.getAndSync(userCode);
    }catch(_){
    }*/

    try{
      await  _performSyncingLoanImage();
    }catch(_){

    }

    try{
      await _performSyncingCGT1();
    }catch(_){
    }
    try{
      await _performSyncingCGT2();
    }catch(_){

    }
    try{
      await  _performSyncingGRT();
    }catch(_){

    }
    await getDateTime();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> _performSyncingCenter() async {

    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    try{
      await _tryPostCenterList();
      getDateTime();
    }catch(_){
    }

    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> _performSyncingLoanCapturedData() async {
    print('_performSyncingLoanData');

    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    try{
      await _tryPostLoanCaptuedDataList();
    }catch(_){
    }

    await getDateTime();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> _tryPostLoanCaptuedDataList() async {
    print('_tryPostLoanDataList');
    Utility obj = new Utility();
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      loadingName= Translations.of(context).text('Syncing_Loan_Captured_Data');
     // showMessage("Syncing Loan Captured Data");
      //Trade and Reference
      SyncTradeAndNeighbourRefCheckToMiddleware syncTradeAndNeighbourRefCheckToMiddleware =
      new SyncTradeAndNeighbourRefCheckToMiddleware();
      try{
        await syncTradeAndNeighbourRefCheckToMiddleware.savingsNormalData();
      }catch(_){

      }

      //Deviation Form
      SyncDeviationFormToMiddleware syncDeviationFormToMiddleware =
      new SyncDeviationFormToMiddleware();
      try{
        await syncDeviationFormToMiddleware.savingsNormalData();
      }catch(_){

      }

      // Social and Env
      SyncSocialAndEnvironmentalToMiddleware syncSocialAndEnvironmentalToMiddleware =
      new SyncSocialAndEnvironmentalToMiddleware();
      try{
        await syncSocialAndEnvironmentalToMiddleware.savingsNormalData();
      }catch(_){

      }

      //CONTACT POINT VERIFICATION BUSINESS & OFFICE
      SyncCustomerLoanCPVBusinessRecordToMiddleware syncCustomerLoanCPVBusinessRecordToMiddleware =
      new SyncCustomerLoanCPVBusinessRecordToMiddleware();
      try{
        await syncCustomerLoanCPVBusinessRecordToMiddleware.savingsNormalData();
      }catch(_){
      }

      //Cash Flow Services
      CustomerLoanCashFlowService customerLoanCashFlowService =
      new CustomerLoanCashFlowService();
      try{
        await customerLoanCashFlowService.getAndSync();
      }catch(_){
      }

      SyncKycMasterToMiddleware syncKycMasterToMiddleware = new SyncKycMasterToMiddleware();
      try{
        await syncKycMasterToMiddleware.savingKycData();
      }catch(_){
      }

      //Guarantor
      try{
        SyncGuarantorToMiddleware syncGuarantorToMiddleware = new SyncGuarantorToMiddleware();
        await syncGuarantorToMiddleware.getAndSync(userCode);

      }catch(_){

      }



    } else {
      showInSnackBar("Network Not Available", Colors.yellow);
      return null;

    }
  }

  Future<void> _performSyncingGroup() async {

    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(14, false).then((onValue) async{
      await AppDatabase.get()
          .selectCenterListIsDataSynced(onValue)
          .then((List<CenterDetailsBean> centerData) async {
        print("customerData.length  "+centerData.length.toString() );
        if (centerData.length > 0) {

          setState(() {
            circIndicatorIsDatSynced = false;
            loadingName= Translations.of(context).text('Please_sync_Center_before_Syncing_Group');
            // showMessage("Syncing Loan Captured Data");
           // showMessage("Please sync Center before Syncing Group");
          });
        }else{
          try{
            await _tryPostGroupList();
          }catch(_){
          }
          await getDateTime();
          setState(() {
            circIndicatorIsDatSynced = false;
          });
        }
      });
    });

    //}
  }


  /*Future<void> _performSyncingLoan() async {

    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
   // try {
      await AppDatabase.get()
          .selectStaticTablesLastSyncedMaster(6, false).then((onValue) async{
        await AppDatabase.get()
            .selectCustomerListIsDataSynced(onValue)
            .then((List<CustomerListBean> customerData) async {
          print("customerData.length  "+customerData.length.toString() );
          if (customerData.length > 0) {

            setState(() {
              circIndicatorIsDatSynced = false;
              showMessage("Please sync customer before Syncing Loan");
            });
          }else{
            CustomerLoanServices customerLoanServices = new CustomerLoanServices();
            await customerLoanServices.getAndSync(userCode);

            try{
              SyncGuarantorToMiddleware syncGuarantorToMiddleware = new SyncGuarantorToMiddleware();
              await syncGuarantorToMiddleware.getAndSync(userCode);
            }catch(_){
            }
            try{
              await _performSyncingCGT1();
            }catch(_){
            }
            try{
              await _performSyncingCGT2();
            }catch(_){

            }
            try{
              await  _performSyncingGRT();
            }catch(_){

            }
            setState(() {
              circIndicatorIsDatSynced = false;
            });
          }


        });



          });



    //}
  }
*/
  Future<void> _performSyncingCGT1() async {
    //if (Constant.syncCGT1.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    CGT1Services cgt1Services = new CGT1Services();
    await cgt1Services.getAndSync();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> _performSyncingCGT2() async {
    //if (Constant.syncCGT1.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    loadingName= Translations.of(context).text('Syncing_CGT_1');
    // showMessage("Syncing Loan Captured Data");
    //showMessage(Constant.syncingCGT1);
    CGT2Services cgt2Services = new CGT2Services();
    await cgt2Services.getAndSync();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> _performGetWorkingLoan() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    loadingName= Constant.gettingWorkingLoans;
    //showMessage(Constant.gettingWorkingLoans);
    GetLoanFromMiddleware getLoanFromMiddleware = new GetLoanFromMiddleware();
    await getLoanFromMiddleware.trySave(username,branch);
    await getDateTime();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }

  Future<void> _performSyncingGRT() async {
    //if (Constant.syncCGT1.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    GRTServices grtServices = new GRTServices();
    await grtServices.getAndSync();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> _performSyncingSpeedoMeter() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    SpeedoMeterServices smServices = new SpeedoMeterServices();
    await smServices.getAndSync();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }

  Future<void> _performSyncingTermDeposit() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    await _tryTDPost();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }
  //perform syncing master
  Future<void> _performSyncingKycMaster() async {
    setState(() {
      isDataSynced= true;
      circIndicatorIsDatSynced = true;
    });
    await _tryKycMaster();
    setState(() {
      circIndicatorIsDatSynced= false;
    });
  }

  Future<void> _performSyncingSubLookup() async {
    //if (Constant.syncSubLookups.contains(usrGrpCode)) {
    loadingName= Constant.syncingSubLookup;
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

   // showMessage(Constant.syncingSubLookup);
    try {
      await AppDatabase.get().createSubLookupInsert();
    }catch(_){}
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> _performSyncingTDRoiData() async {
    //if (Constant.syncSubLookups.contains(usrGrpCode)) {
    loadingName= Constant.syncingTDRoiTables;
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    //showMessage(Constant.syncingTDRoiTables);
    try {
      await AppDatabase.get().createTDRoiInsert(branch);
    }catch(_){}
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> _performSyncingProspect() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    loadingName= Translations.of(context).text('Syncing_Prospect');
    //showMessage(Constant.syncingProspect);
    ProspectServices prospectService = new ProspectServices();
    String msg = await prospectService.uploadProspectData();

    showMessageShortDuration(msg);
    await getDateTime();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //_scaffoldKey.currentState.hideCurrentSnackBar();
  }

  Future<void> _tryPostSavingsCollectionList() async {
    Utility obj = new Utility();
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      loadingName= Translations.of(context).text('Syncing_Display_Savings_List');
     // showMessage("Syncing Display Savings List");
      SyncingSavingsListtoMiddleware syncingSavingsListtoMiddleware =
      new SyncingSavingsListtoMiddleware();
      await syncingSavingsListtoMiddleware.savingsNormalData();


      try{
        SyncingSavingsCollectionListtoMiddleware syncingSavingsCollectionListtoMiddleware =
        new SyncingSavingsCollectionListtoMiddleware();
        await syncingSavingsCollectionListtoMiddleware.saveSavingsCollectionlData();
      }catch(_){
      }
    } else {
      showInSnackBar("Network Not Available", Colors.yellow);
      return null;
    }
  }



  Future<void> _tryPostLoanUtilizationList() async {
    Utility obj = new Utility();
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      loadingName= Translations.of(context).text('Syncing_Loan_Utilization_List');
      //showMessage("Syncing Loan Utilization List");
      SyncLoanUtilizationToMiddleware syncLoanUtilizationToMiddleware =
      new SyncLoanUtilizationToMiddleware();
      await syncLoanUtilizationToMiddleware.savingsNormalData();
    } else {
      showInSnackBar("Network Not Available", Colors.yellow);
      return null;
    }
  }

  Future<void> _tryPostSavingsList() async {
    Utility obj = new Utility();
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      loadingName= Translations.of(context).text('Syncing_Savings_List');
      //showMessage("Syncing Savings List");
      SyncingSavingsListtoMiddleware syncingSavingsListtoMiddleware =
      new SyncingSavingsListtoMiddleware();
      await syncingSavingsListtoMiddleware.savingsNormalData();
    } else {
      showInSnackBar("Network Not Available", Colors.yellow);
      return null;

    }
  }

  Future<void> _tryPostCenterList() async {
    Utility obj = new Utility();
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      loadingName= Translations.of(context).text('Syncing_Center_List');
      //showMessage("Syncing Center List");
      SyncingCentertoMiddleware syncingCentertoMiddleware =
      new SyncingCentertoMiddleware();
      await syncingCentertoMiddleware.savingsNormalData();
    } else {
      showInSnackBar("Network Not Available", Colors.yellow);
      return null;

    }
  }

  Future<void> _tryPostGroupList() async {
    Utility obj = new Utility();
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      loadingName= Translations.of(context).text('Syncing_Group_List');
      //showMessage("Syncing Group List");
      SyncingGrouptoMiddleware syncingGrouptoMiddleware =
      new SyncingGrouptoMiddleware();
      await syncingGrouptoMiddleware.savingsNormalData();
    } else {
      showInSnackBar("Network Not Available", Colors.yellow);
      return null;

    }
  }

  Future<void> _tryTDPost() async {
    Utility obj = new Utility();
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      loadingName= Translations.of(context).text('Syncing_TD_List');
      //showMessage("Syncing TD List");
      SyncTDListToMiddleware syncTDListToMiddleware =
      new SyncTDListToMiddleware();
      await syncTDListToMiddleware.savingsNormalData();
    } else {
      showInSnackBar("Network Not Available", Colors.yellow);
      return null;
    }
  }

  Future<void> _tryKycMaster() async {
    Utility obj = new Utility();
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      loadingName= Translations.of(context).text('Syncing_Kyc_List');
      //showMessage("Syncing Kyc List");
      SyncKycMasterToMiddleware syncKycMasterToMiddleware = new SyncKycMasterToMiddleware();
      await syncKycMasterToMiddleware.savingKycData();
    } else {
      showInSnackBar("Network Not Available", Colors.yellow);
      return null;
    }
  }

  Future<void> _tryPost() async {
    Utility obj = new Utility();
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      //loadingName= Syncing_Customer;
      loadingName= Translations.of(context).text('Syncing_Customer');
      //showMessage("Syncing Customer");
      SyncingCustomertoMiddleware syncingCustomerToMiddleware =
      new SyncingCustomertoMiddleware();
      await syncingCustomerToMiddleware.customerNormalData();
    } else {
      showInSnackBar("Network Not Available", Colors.yellow);
      return null;
    }
  }




  void showInSnackBar(String value, [Color color]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: color != null ? color : null,
    ));
  }

  Future<Null> _trySave(String forWhat  ) async {
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      loadingName= "Syncing ${forWhat}";

      //showMessage("Syncing ${forWhat}");
      print("agent username "+username.toString()+" grp code " + usrGrpCode.toString());
      if (forWhat == 'group') {
        await getMiddleWareData(forWhat, username, urlGetGroupInfo);
      } else if (forWhat == 'center') {
        await getMiddleWareData(forWhat, username, urlGetCenterInfo);
      }
    }
  }

  Future<Null> getMiddleWareData(
      String forWhat, String userName, String url) async {
    try {
      String json2 = _toJsonOfAgentUserName(userName);
      print(json2);
      var bodyValue = await NetworkUtil.callPostService(
          json2, Constant.apiURL.toString() + url.toString(), _headers);
      print("bodyValue ::" + bodyValue);
      if(bodyValue!=null){
        bodyValue = bodyValue.replaceAll("'" , "" );
      }

      if (bodyValue == "404" ) {
        return null;
      }
      final parsed = json.decode(bodyValue).cast<Map<String, dynamic>>();
      if (forWhat == 'group') {
        List<GroupFoundationBean> obj = parsed
            .map<GroupFoundationBean>(
                (json) => GroupFoundationBean.fromMap(json))
            .toList();
        await AppDatabase.get().deletSomeSyncingActivityFromOmni('Group');
        for (GroupFoundationBean items in obj) {
          await AppDatabase.get().updateGroupFoundation(items);
        }
      } else if (forWhat == 'center') {
        List<CenterDetailsBean> obj = parsed
            .map<CenterDetailsBean>(
                (json) => CenterDetailsBean.fromMap(json))
            .toList();
        await AppDatabase.get().deletSomeSyncingActivityFromOmni('Center');
        for (CenterDetailsBean items in obj) {
          await AppDatabase.get().updateCenterFoundation(items);
        }
      }
    } catch (e) {}
  }

  String _toJsonOfAgentUserName(agentUserNo) {
    var mapData = new Map();
    mapData[TablesColumnFile.mcreatedby] = agentUserNo.toString().trim();
    mapData[TablesColumnFile.mlbrcode] = branch;
    String json = JSON.encode(mapData);
    return json;
  }

  void showMessage(String message, [MaterialColor color = Colors.grey]) {
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {
      print(e);
    }
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: color != null ? color : null,
        content: new Text(message),
        duration: Duration(seconds: 45)));
  }

  Future<void> _ChooseAction() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sync Options'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('What you want to save'),
                Text('Syncing whole result will take more time')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Whole Result'),
              onPressed: () async {
                Navigator.of(context).pop();
                await getAllProspectData();
              },
            ),
            FlatButton(
              child: Text('NOC Check Result'),
              onPressed: () async {
                Navigator.of(context).pop();
                await getNOCCheckResult();
              },
            ),
          ],
        );
      },
    );
  }

  void showMessageShortDuration(String message, [MaterialColor color = Colors.grey]) {
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {
      print(e);
    }
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: color != null ? color : null,
        content: new Text("${message}"),
        duration: Duration(seconds: 6)));
  }

  Future<void> syncSystemParameterData(String fromPage) async {
    //if(Constant.syncSystemParameter.contains(22)){
    loadingName = Constant.syncingSystemParameter;
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });


    //showMessage(Constant.syncingSystemParameter);
    try {
      await AppDatabase.get().createSystemParameterInsert();
      await Constant.setSystemVariables(fromPage);
      // }catch(_){}
      setState(() {
        circIndicatorIsDatSynced = false;
      });
    } catch(_){}
  }

  Future<void> _performSyncingDailyLoanCollected() async {
    //if (Constant.syncLoanDetails.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    SyncingDailyCollectedToMiddleware  _syncingDailyCollectedToMiddleware = new SyncingDailyCollectedToMiddleware();
    await _syncingDailyCollectedToMiddleware.getAndSync();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }
  Future<void> getCustommerFromCenterId() async {

    centerBean = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>_myCenterDialog,
          fullscreenDialog: true,
        ));
    if(centerBean!=null){


      setState(() {
        isDataSynced = true;
        circIndicatorIsDatSynced = true;
      });
      //showMessage(Constant.gettingWorkingCustomer);
      loadingName= Translations.of(context).text('Getting_Working_Customer');
      GetCustomerFromCenter getCustomerFromMiddleware =
      new GetCustomerFromCenter();
      await getCustomerFromMiddleware.trySave(centerBean.mCenterId);
      setState(() {
        circIndicatorIsDatSynced = false;
      });




    }

    setState(() {

    });

    centerBean = new CenterDetailsBean();

  }


  Future<void> _syncGLAccounts() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    loadingName= Translations.of(context).text('Syncing_GL_Accounts');

    SyncingGLAccounts syncingGLAccounts = new SyncingGLAccounts();
    await syncingGLAccounts.trySave(branch);
  //  showMessage(Constant.syncingGLAccounts);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }



  Future<void> _performSyncingLoanLevel() async {

    //if (Constant.syncLoanDetails.contains(usrGrpCode)) {
    setState(() {
      loadingName= Translations.of(context).text('syncLoanLevel');
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    LoanLevelService  loanlevelService = new LoanLevelService();
    
    try {
      await loanlevelService.getLoanLevel();
    }catch(_){}
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> syncCashFlow() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    await tryCashFlow();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }

  Future<void> tryCashFlow() async {
    Utility obj = new Utility();
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      loadingName= Translations.of(context).text('Syncing_Cash_Flow_List');
      //showMessage("Syncing Cash Flow List");
      CustomerLoanCashFlowService customerLoanCashFlowService =
      new CustomerLoanCashFlowService();
      await customerLoanCashFlowService.getAndSync();
    } else {
      showInSnackBar("Network Not Available", Colors.yellow);
      return null;
    }
  }

<<<<<<< .mine
  Future<void> getSyncedCustomerLoanCashFlow() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    showMessage(Constant.gettingSavingsList);
    GetCustomerLoanCashFlow getCustomerLoanCashFlow =
    new GetCustomerLoanCashFlow();
    await getCustomerLoanCashFlow .trySave(username);
    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }
=======

  Future<void> getSyncedCustomerLoanCashFlow() async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    loadingName= Translations.of(context).text('Getting_Savings_List');
    //showMessage(Constant.gettingSavingsList);
    try{
      GetCustomerLoanCashFlow getCustomerLoanCashFlow =
      new GetCustomerLoanCashFlow();
      await getCustomerLoanCashFlow .trySave(username);
    }catch(_){
    }


    //Bhawpriya Add changes here

    setState(() {
      circIndicatorIsDatSynced = false;
    });
  }



  Future<void> _performSyncingLoanImage() async {
    //if (Constant.syncCGT1.contains(usrGrpCode)) {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    CustomerLoanImageService customerLoanImageService = new CustomerLoanImageService();
    await customerLoanImageService.getAndSync();
    await getDateTime();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }

  Future<void> syncFactoryLimited(String fromPage) async {
    print("agent username " +
        username.toString() +
        " grp code " +
        usrGrpCode.toString());
    try{
      setState(() {
        isDataSynced = true;
        circIndicatorIsDatSynced = true;
      });
    }catch(_){}

    bool isNetworkAvailable = await Utility.checkIntCon();
    //  isNetworkAvailable = true;
    if (isNetworkAvailable) {
      await AppDatabase.get()
          .selectStaticTablesLastSyncedMaster(10, true)
          .then((onValue) async {
        if (onValue == null) {
          globals.circleIndicator = true;
          await AppDatabase.get().createSubLookupInsert();
          await Constant.getDropDownInitialize();
        }
      });

      await AppDatabase.get()
          .selectStaticTablesLastSyncedMaster(9, true)
          .then((onValue) async {
        if (onValue == null) {
          globals.circleIndicator = true;
          await AppDatabase.get().createLookupInsert();
          await Constant.getDropDownInitialize();
        }
      });

      await AppDatabase.get()
          .selectStaticTablesLastSyncedMaster(8, true)
          .then((onValue) async {
        if (onValue == null) {
          globals.circleIndicator = true;
          await AppDatabase.get().createSystemParameterInsert();
          await Constant.getDropDownInitialize();
          await Constant.setSystemVariables("login");
        }
      });
      try{
        await _performSyncingBranch();
      }catch(_){}

      try {
        await syncingMenusMasterData();
      }catch(_){}
      try{
        await syncingUserAccessRightsData();
      }catch(_){}
    }



    try{
      await Constant.getDropDownInitialize();
    }catch(_){}try{
      await Constant.setSystemVariables(fromPage);
    }catch(_){}
    UserRightBean beanGet;
    try{
      beanGet= new UserRightBean(mgrpcd: usrGrpCode,musrcode: username);
      await Constant.getAccessRights(beanGet);
    }catch(_){}



    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {}

  }



  Future<void> _performSyncingDisbursedData() async {
    print('_performSyncingLoanData');

    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    try{
      await _tryPostDisbursedData();
    }catch(_){
    }

    await getDateTime();
    setState(() {
      circIndicatorIsDatSynced = false;
    });
    //}
  }




  Future<void> _tryPostDisbursedData() async {
    print('_tryPostDisbursedData');
    Utility obj = new Utility();
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      showMessage("Syncing Loan Captured Data");
      SyncDisbursedListToMiddleware  syncDisbursedData =
      new SyncDisbursedListToMiddleware();
      try{
        await syncDisbursedData.disbursmentNormalData();
      }catch(_){

      }
    } else {
      showInSnackBar("Network Not Available", Colors.yellow);
      return null;

    }
  }

>>>>>>> .r1143
}

class CustomerId {
  int customerNumberOfTab;
  String usrCode;
}


class LastSyncDateTimeBean {
  int id;
  String tTabelDesc;
  DateTime tlastSyncedFromTab;
  DateTime tlastSyncedToTab;

  @override
  String toString() {
    return 'LastSyncDateTime{id: $id, tTabelDesc: $tTabelDesc, tlastSyncedFromTab: $tlastSyncedFromTab, tlastSyncedToTab: $tlastSyncedToTab}';
  }

  LastSyncDateTimeBean({this.id, this.tTabelDesc, this.tlastSyncedFromTab,
    this.tlastSyncedToTab});


  factory LastSyncDateTimeBean.fromMap(Map<String, dynamic> map) {
    return LastSyncDateTimeBean(
      id: map[TablesColumnFile.id] as int,
      tTabelDesc: map[TablesColumnFile.tTabelDesc] as String,
      tlastSyncedFromTab: (map[TablesColumnFile.tlastSyncedFromTab] == "null" ||
          map[TablesColumnFile.tlastSyncedFromTab] == null) ? null : DateTime
          .parse(map[TablesColumnFile.tlastSyncedFromTab]) as DateTime,
      tlastSyncedToTab: (map[TablesColumnFile.tlastSyncedToTab] == "null" ||
          map[TablesColumnFile.tlastSyncedToTab] == null) ? null : DateTime
          .parse(map[TablesColumnFile.tlastSyncedToTab]) as DateTime,

    );
  }
}