import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/pages/workflow/BulkLoanPreClosure/BulkLoanPreClosure.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/InternalBankTransfer.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CIF.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerAuthorization.dart';
import 'package:eco_mfi/pages/workflow/utilityBillPayment/UtilityBillPayment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/ReadXmlCost.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/home/LoanDashboard.dart';
import 'package:eco_mfi/pages/workflow/BranchMaster/BranchMasterBean.dart';
import 'package:eco_mfi/pages/workflow/CGT/CGT1.dart';
import 'package:eco_mfi/pages/workflow/CGT/CGT2.dart';
import 'package:eco_mfi/pages/workflow/GRT/GRTDocumentVerification.dart';
import 'package:eco_mfi/pages/workflow/GRT/GRTTab.dart';

import 'package:eco_mfi/pages/workflow/GroupFormation/GroupFormationMasterSubmissionListView.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/List/CustomerLoanDetailsList.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/LoanLimitDetails.dart';
import 'package:eco_mfi/pages/workflow/LoanUtilization/LoanUtilizationList.dart';
import 'package:eco_mfi/pages/workflow/Savings/SavingsList.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';
import 'package:eco_mfi/pages/workflow/SpeedoMeter/SpeedoMeter.dart';
import 'package:eco_mfi/pages/workflow/SpeedoMeter/list/SpeedoMeterList.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/CenterFormationMasterListView.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/CenterFormationMasterSubmission.dart';
import 'package:eco_mfi/pages/workflow/collection/DailyCollectionSearchScreen.dart';
import 'package:eco_mfi/pages/workflow/collection/bean/CollectionMasterBean.dart';
import 'package:eco_mfi/pages/workflow/collection/list/DailyLoanCollectionList.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/CreditBereauCallSubmisiion.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/CreditBereauDataTable.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/NOCApprovalList.dart';

import 'package:eco_mfi/pages/workflow/creditBereau/ProspectView.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/SMSVerification.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationBusinessCashFlow3.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_mfi/pages/workflow/qrScanner/QrScanner.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingActivityMenuList.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/TermDepositDashboard.dart';
import 'package:eco_mfi/pages/workflow/villageservey/Home_VillageServey_Tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/FullScreenDialogForGroupSelection.dart';
import 'centerfoundation/FullScreenDialogForCenterSelection.dart';
import 'package:eco_mfi/pages/workflow/disbursment/list/DisbursmentSearch.dart';

class WorkFlowGrid extends StatefulWidget {

  WorkFlowGrid();

  @override
  WorkFlowGridState createState() {
    return new WorkFlowGridState();
  }
}

class WorkFlowGridState extends State<WorkFlowGrid> {


  int mIsProspectNeeded = 0;
  int isCGT2Needed = 0;
  int BMGrpCode = 0;
  int grpCode = 0;
String centerCaption = "Center";
  int branch;
  BranchMasterBean branchMasterBean= null;
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;
  String companyName = "";
  String formattedLastLogin ="";
  String formattedCurrLogin="";
  DateTime branchOperationalDate;

  @override
  void initState() {
    super.initState();

    getsharedPreferences();
    setMenusAndImages();
    setState(() {
    });
  }


  getsharedPreferences()async{
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode);
      reportingUser = prefs.getString(TablesColumnFile.mreportinguser);
      username = prefs.getString(TablesColumnFile.musrname);
      usrRole = prefs.getString(TablesColumnFile.musrdesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.mgrpcd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.geoLocation);
      geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();

      if(prefs.getString(TablesColumnFile.mIsProspectNeeded)!=null&&prefs.getString(TablesColumnFile.mIsProspectNeeded).trim()!="")
        mIsProspectNeeded = int.parse(prefs.getString(TablesColumnFile.mIsProspectNeeded));

      if(prefs.getString(TablesColumnFile.CENTERCAPTION)!=null&&prefs.getString(TablesColumnFile.CENTERCAPTION).trim()!="")
        centerCaption = prefs.getString(TablesColumnFile.CENTERCAPTION);

      if (prefs.getString(TablesColumnFile.mCompanyName) != null &&
          prefs.getString(TablesColumnFile.mCompanyName).trim() != "")
        companyName = prefs.getString(TablesColumnFile.mCompanyName);

      if(prefs.getString(TablesColumnFile.isCGT2Needed)!=null&&prefs.getString(TablesColumnFile.isCGT2Needed).trim()!="")
        isCGT2Needed = int.parse(prefs.getString(TablesColumnFile.isCGT2Needed));
    });
    //SharedPreferences prefs =  await SharedPreferences.getInstance();
    if(loginTime!=null && loginTime.trim()!='null' && loginTime !='') {
      formattedLastLogin =
          DateFormat('yyyy-MM-dd  kk:mm').format(DateTime.parse(loginTime));
      formattedCurrLogin =
          DateFormat('yyyy-MM-dd  kk:mm').format(DateTime.parse(loginTime));
    }
     prefs =  await SharedPreferences.getInstance();
    if(prefs.getString(TablesColumnFile.mIsProspectNeeded)!=null&&prefs.getString(TablesColumnFile.mIsProspectNeeded).trim()!="")
      mIsProspectNeeded = int.parse(prefs.getString(TablesColumnFile.mIsProspectNeeded));
    print(mIsProspectNeeded);
    if(prefs.getInt(TablesColumnFile.BMGrpCode)!=null)
      BMGrpCode = prefs.getInt(TablesColumnFile.BMGrpCode);
    print(BMGrpCode);
    if(prefs.getInt(TablesColumnFile.grpCd)!=null&&prefs.getInt(TablesColumnFile.grpCd)!=0)
      grpCode = prefs.getInt(TablesColumnFile.grpCd);
    print(grpCode);

    AppDatabase.get().getBranchNameOnPbrCd(branch).then((onValue){
      branchMasterBean = onValue;
      if(branchMasterBean!=null&&branchMasterBean.mlastopendate!=null)
        prefs.setString(TablesColumnFile.branchname,branchMasterBean.mname);
      prefs.setString(TablesColumnFile.branchOperationalDate, branchMasterBean.mlastopendate.toString());
      print("branch "+ branch.toString());
      print("branchMasterBean "+ branchMasterBean.toString());
    });

  }

  GestureDetector gestureDetector(name, image,onTap) {
    return new GestureDetector(
      child: new RaisedButton(
          elevation: 2.0,
          highlightColor: Colors.black,
          splashColor: Colors.orange,
          colorBrightness: Brightness.dark,
          color: Colors.white,
          onPressed: () {
            if (onTap == 1) {
              print("Village Summary");
              /*   Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                new HomeTabsVillageServey()

            ), //When Authorized Navigate to the next screen
          );*/
              globals.Dialog.alertPopup(context, "This module is locked",
                  "Please ask support team To open this", "Dashboard");
            } else if (onTap == 2) {
              print("Qr Scanner");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new QrScanner()), //When Authorized Navigate to the next screen
              );
            } else if (onTap == 3) {
              // AppDatabase.get().getProductList(30,1);
              print("Center Creation");
               Navigator.push(
            context,
            new MaterialPageRoute(
                /*builder: (context) =>
                new AddGuarantor()),*/
                builder: (context) =>
                new FullScreenDialogForCenterSelection("Center Creation")), //When Authorized Navigate to the next screen
          );
              /*globals.Dialog.alertPopup(context, "This module is locked",
                  "Please ask support team To open this", "Dashboard");*/
            } /*else if (onTap == "CB Results") {
              print("CB Results");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new CreditBereauDataTable()), //When Authorized Navigate to the next screen
              );
            }*/ else if (onTap == 4) {
              print("Group Creation");
              globals.centerNo="GroupCreation";
                  Navigator.push(
            context,
                    new MaterialPageRoute(

                        builder: (context) =>
                        new FullScreenDialogForGroupSelection("Group Creation")), //When Authorized Navigate to the next screen
                  );
            /*new MaterialPageRoute(
                builder: (context) => new AddGuarantor()),
//                new GroupFormationMasterSubmissionListView()), //When Authorized Navigate to the next screen
          );*/
              /*globals.Dialog.alertPopup(context, "This module is locked",
                  "Please ask support team To open this", "Dashboard");*/

            } else if (onTap == 5) {
              globals.Utility.clearDataOfCustomerGlobals();
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    //new CustomerFormationMasterTabs(widget.cameras)), //When Authorized Navigate to the next screen
                    new CustomerList(null, name)),
              );
            } else if (onTap == 6) {
              globals.Utility.clearDataOfCustomerGlobals();
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    //new CustomerFormationMasterTabs(widget.cameras)), //When Authorized Navigate to the next screen
                    new LoanDashboard()),
              );
            }else if (onTap == 7) {
              print("Credit Check -- Prospect Creation");
              print("CB Call Screen");
           /*   if(mIsProspectNeeded==0){
                globals.Dialog.alertPopup(context, "This module is locked",
                    "Please ask support team To open this", "Dashboard");
              }else if(mIsProspectNeeded==1){*/
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                      new ProspectView()), //When Authorized Navigate to the next screen
                );


            }
            else if (onTap == 8) {
                     Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new NOCApprovalList()), //When Authorized Navigate to the next screen
              );
            } else if (onTap == 9) {
              print("SMS Verification");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new SMSVerification()), //When Authorized Navigate to the next screen
              );
            } else if (onTap == 10) {
              print("Syncing Activity");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new SyncingActivity()), //When Authorized Navigate to the next screen
              );
            }  else if (onTap == 11) {
              print("SpeedoMeter");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new SpeedoMeterList()), //When Authorized Navigate to the next screen
              );
            }
            else if(onTap == 12){

              print("Savings");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new SavingsList()), //When Authorized Navigate to the next screen
              );
            }
            else if(onTap == 13){

              print("Disbursment");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new DisbursmentListSearch("Disbursment")), //When Authorized Navigate to the next screen
              );
            }else if(onTap == 14){
              print("Term Deposit");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new TermDepositDashboard()),

                );
            }
            else if(onTap == 15){

              print("Customer 360");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new CIF()), //When Authorized Navigate to the next screen
              );
            }else if(onTap == 16){
              print("Utility Bill");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new UtilityBillPayment()),

              );
            }
            else if(onTap == 17){

              print("Bulk Loan Pre-Closure");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new BulkLoanPreClosure()), //When Authorized Navigate to the next screen
              );
            }
            else if(onTap == 18){

              print("Internal Bank Transfer");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new InternalBankTransfer()), //When Authorized Navigate to the next screen
              );
            }
            else if(onTap == 28){

              print("Customer Authorization");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new CustomerAuthorization()), //When Authorized Navigate to the next screen
              );
            }


          },
          child: new FittedBox(
            alignment: Alignment.center,
            fit: BoxFit.none,
            child: new Column(
              children: <Widget>[
                new Image(
                  image: new AssetImage(image),
                ),
                SizedBox.fromSize(),
                new Center(
                  child: new Text(
                    name,
                    style:
                    new TextStyle(color: Color(0xff07426A), fontSize: 11.0,),
                  ),
                  heightFactor: 2.0,
                )
              ],
            ),
          )),
    );

    /*return new Card(
        elevation: 1.5,
        color: Colors.white,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            new Image(image: new AssetImage(image)),
            new Center(
              child: new Text(name),
              heightFactor: 0.00,
            )
          ],
        ));*/
  }

  @override
  Widget build(BuildContext context) {

    return
      new Column(
        children: <Widget>[
      new Flexible (
        flex: 0,
      child:Card(
        child: Column(

          children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Row(
                    children: <Widget>[

                      new Text("Welcome ",style:
                      new TextStyle(color: Color(0xff07426A), fontSize: 18.0,fontStyle: FontStyle.normal),),
                  ]),
                  Row(
                    children: <Widget>[

                   /*   new Text("Welcome : ",style:
                      new TextStyle(color: Color(0xff07426A), fontSize: 14.0,),),*/
                      new Text(username.toString() ,style:
                      new TextStyle(color: Colors.deepOrange[400], fontSize: 14.0,),),
                      new Text(" Reporting To : ",style:
                      new TextStyle(color: Color(0xff07426A), fontSize: 14.0,),),
                      new Text(reportingUser.toString() ,style:
                      new TextStyle(color: Colors.deepOrange[400], fontSize: 14.0,),),

                    ],
                  ),
                 /* Row(
                    children: <Widget>[
                      new Text("Current Login Time : ",style:
                      new TextStyle(color: Color(0xff07426A), fontSize: 14.0,),),
                      new Text(formattedLastLogin.toString(),style:
                      new TextStyle(color: Colors.deepOrange[400], fontSize: 14.0,),),

                    ],
                  ),
                  Row(
                    children: <Widget>[
                      new Text("Last Login Time : ",style:
                      new TextStyle(color: Color(0xff07426A), fontSize: 14.0,),),
                      new Text(formattedLastLogin.toString(),style:
                      new TextStyle(color: Colors.deepOrange[400], fontSize: 14.0,),),

                    ],
                  ),*/
                  Row(
                    children: <Widget>[
                      new Text("Branch : ",style:
                      new TextStyle(color: Color(0xff07426A), fontSize: 14.0,),),
                      new Text('${branch.toString()} / ${branchMasterBean!=null?branchMasterBean.mname:""}',style:
                      new TextStyle(color: Colors.deepOrange[400], fontSize: 14.0,),),
                    ],
                  ),
                ],
              ),
              Column(
               crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[

                  new GestureDetector(
                    child: new RaisedButton(
                        elevation: 1.0,
                        highlightColor: Colors.black,
                        splashColor: Colors.orange,
                        colorBrightness: Brightness.dark,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                new SyncingActivity()), //When Authorized Navigate to the next screen
                          );
                        },
                        child: new FittedBox(
                          alignment: Alignment.center,
                          fit: BoxFit.none,
                          child: new Column(
                            children: <Widget>[
                              new Image(
                                image: new AssetImage("assets/Syncing.png"),height: 25.0,width: 25.0,
                              ),
                              SizedBox.fromSize(),
                              new Center(
                                child: new Text(
                                  "Syncing Activity",
                                  style:
                                  new TextStyle(color: Color(0xff07426A), fontSize: 10.0,),
                                ),
                                heightFactor: 2.0,
                              )
                            ],
                          ),
                        )),
                  ),
                  //gestureDetector("Syncing Activity", "assets/Syncing.png"),
                ],
              ),
            ],
          )
          ],
        ),
      ),

      ),
      new Flexible (
      flex: 7,
       child:new GridView.count(
      primary: true,
      padding: const EdgeInsets.all(4.0),
      crossAxisCount: 3,
      //childAspectRatio: 0.80,
      mainAxisSpacing: 7.0,
      crossAxisSpacing: 7.0,
              children: commentWidgets,

    ),
      )
        ],
    );
  }

  void setMenusAndImages() async {
    for (int display = 0; display < Constant.gridDashBoardMenus.length; display++) {
      commentWidgets
          .add(gestureDetector(Constant.gridDashBoardMenus[display].menuDesc,Constant.gridDashBoardMenus[display].murl,Constant.gridDashBoardMenus[display].menuId));
    }

    setState(() {
    });
  }
  var commentWidgets = List<Widget>();
}
