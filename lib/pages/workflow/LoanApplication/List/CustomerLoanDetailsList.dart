import 'package:eco_mfi/pages/workflow/Guarantor/GuarantorDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/Guarantor/SyncGuarantorToMiddleware.dart';
import 'package:eco_mfi/pages/workflow/Kyc/SyncKycMasterToMiddleware.dart';
import 'package:eco_mfi/pages/workflow/Kyc/beans/KycMasterBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanCashFlow.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanCashFlowService.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanDetailsMasterTab.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanImageSyncing.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCPVBusinessRecordBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCashFlowAnalysisBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanImageBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/DeviationFormBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/SocialAndEnvironmentalBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/TradeAndNeighbourRefCheckBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/LoanLevelService.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncCustomerLoanCPVBusinessRecordToMiddleware.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncDeviationFormToMiddleware.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncSocialAndEnvironmentalToMiddleware.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncTradeAndNeighbourRefCheckToMiddleware.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eco_mfi/Utilities/ThemeDesign.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/CGT/CGT1.dart';
import 'package:eco_mfi/pages/workflow/CGT/CGT2.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT1Bean.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT1Services.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT2Bean.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT2Services.dart';
import 'package:eco_mfi/pages/workflow/GRT/GRTServices.dart';
import 'package:eco_mfi/pages/workflow/GRT/GRTTab.dart';
import 'package:eco_mfi/pages/workflow/GRT/bean/GRTBean.dart';
import 'package:eco_mfi/pages/workflow/Guarantor/GuarantorDetails.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanSyncing.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/LoanLimitDetails.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/LoanStepper.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/LoanUtilization/LoanUtilizationBean.dart';

import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:eco_mfi/Utilities/app_constant.dart'
    as constant;

import '../LoanLevelScreens.dart';

List<TimelineModel> listWorkflow = new List<TimelineModel>();

class CustomerLoanDetailsList extends StatefulWidget {
  final String routeType;
  final String customerNum;

  static int count = 1;
  CustomerLoanDetailsList(this.routeType, this.customerNum);
  @override
  _CustomerLoanDetailsList createState() => new _CustomerLoanDetailsList();
}

class _CustomerLoanDetailsList extends State<CustomerLoanDetailsList> {
  CustomerLoanDetailsBean loanDetObj = new CustomerLoanDetailsBean();
  List<CustomerLoanDetailsBean> items = new List<CustomerLoanDetailsBean>();
  List<CustomerLoanDetailsBean> storedItems =
      new List<CustomerLoanDetailsBean>();
  Widget appBarTitle = new Text("Loan Application");
  List<bool> questionCheck;
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrCode;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String branch = "";
  CustomerListBean customerListBean;
  bool isSyncedIndex = false;
  bool circInd = false;
  DateTime lastSyncedToServerDaeTime = null;
  int stage = 0;
  //SuperTooltip tooltip;
  int currentStep = 0;
  // int mOneDayGapNeededForGRT = 0;

  static var _focusNode = new FocusNode();
  int cgt1ToCgt2Gap = 0;
  int cgt2ToGrtGap = 0;
  SystemParameterBean sysBean;

  Icon actionIcon = new Icon(Icons.search);
  @override
  void initState() {
    appBarTitle = new Text(widget.routeType);
    items.clear();
    super.initState();
    CustomerLoanDetailsList.count = 1;
    getSessionVariables();
    if(widget.routeType=="Loan Application"){
      stage  = 1;
    }else if(widget.routeType=="Loan List for CGT1"){
      stage  = 2;
    }else if(widget.routeType=="Loan List for CGT2"){
      stage  = 3;
    }else{
      stage  = 4;
    }
  }

  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();

  Future<Null> getSessionVariables() async {

    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(6, false)
        .then((onValue) async {
      lastSyncedToServerDaeTime = onValue;
    });

    prefs = await SharedPreferences.getInstance();
    setState(() {
      /* if(prefs.getString(TablesColumnFile.mOneDayGapNeededForGRT)!=null&&prefs.getString(TablesColumnFile.mOneDayGapNeededForGRT).trim()!="")
        mOneDayGapNeededForGRT = int.parse(prefs.getString(TablesColumnFile.mOneDayGapNeededForGRT));
      print(mOneDayGapNeededForGRT);*/
      username = prefs.getString(TablesColumnFile.musrcode);
      usrCode = prefs.getString(TablesColumnFile.musrcode).trim();
      usrRole = prefs.getString(TablesColumnFile.musrdesignation);
      branch = prefs.get(TablesColumnFile.musrbrcode).toString();
      usrGrpCode = prefs.getInt(TablesColumnFile.mgrpcd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.geoLocation);
      geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
      cgt1ToCgt2Gap = prefs.getInt(TablesColumnFile.CGT1toCGT2Gap);
      cgt2ToGrtGap = prefs.getInt(TablesColumnFile.CGT2toGRTGap);
    });
  }

  DateTime getTruncatedDate(DateTime toBeChangedDate) {
    String newDate = toBeChangedDate.toString();
    DateTime returned =
        DateTime.parse('${newDate.substring(0, 10)} 00:00:00.000');

    print(returned);

    return returned;
  }

  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) async {
    if (snapshot.data != null) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.all(0.0),
      );
    }
  }

  Widget _getItemUI(BuildContext context, int index) {
    isSyncedIndex =false;
    /* Color color;
    if (index % 2 == 1) {
      color = Colors.brown[50];
    } else {
      color = Colors.white;
    }*/
    double c_width = MediaQuery.of(context).size.width * 10;
    String mprdcd = "";
    String custNo = "";
    String tempPrcdAcctId = "";
    int prcdAcctId = 0;
    print(" prcdcd  " + items[index].mprdacctid.toString());

    if (items[index].mprdacctid != null &&
        items[index].mprdacctid != "null" &&
        items[index].mprdacctid != "") {
      try {
        tempPrcdAcctId = items[index].mprdacctid.substring(16, 24);
      } catch (_) {}
    }

    if (items[index].mprdcd != null &&
        items[index].mprdcd != 'null' &&
        items[index].mprdcd.trim() != "") {
      // print("items[index].mprdcd " + items[index].mprdcd.toString());
      mprdcd = items[index].mprdcd;
    }

    if (items[index].mcustno.toString() != null &&
        items[index].mcustno.toString() != 'null' &&
        items[index].mcustno.toString().trim() != "") {
      //  print("items[index].mprdcd " + items[index].mprdcd.toString());
      custNo = items[index].mcustno.toString();
    }

    if (tempPrcdAcctId != null &&
        tempPrcdAcctId != 'null' &&
        tempPrcdAcctId.trim() != "") {
      //  print("items[index].mprdcd " + items[index].mprdcd.toString());
      prcdAcctId = int.parse(tempPrcdAcctId.trim());
    }
    print(" tempPrcdAcctId  " + tempPrcdAcctId.toString());
    print(" prcdAcctId  " + prcdAcctId.toString());
    String leadId = items[index].mleadsid.toString() != null &&
            items[index].mleadsid.toString() != 'null'
        ? items[index].mleadsid
        : "";
    String prcdCdId = items[index].mprdcd.toString() != null &&
            items[index].mprdcd.toString() != 'null'
        ? items[index].mprdcd
        : "";
    String prcdName = items[index].mprdname.toString() != null &&
            items[index].mprdname.toString() != 'null'
        ? items[index].mprdname
        : "";


    if (items[index].mlastsynsdate == null ||
        items[index].mlastsynsdate == 'null' ||
        (items[index].mcreateddt != null &&
            items[index].mcreateddt != 'null' &&
            items[index].mcreateddt.isAfter(items[index].mlastsynsdate)) ||
        (items[index].mlastupdatedt != null &&
            items[index].mlastupdatedt != 'null' &&
            items[index].mlastupdatedt.isAfter(items[index].mlastsynsdate)) ||
        (items[index].mrefno == null || items[index].mrefno == 0)) {
      isSyncedIndex = true;
    }

    return new GestureDetector(
      onTap: () async {
        if (widget.routeType == "Loan Application") {
          _onTapItem(items[index]);
        } else if (widget.routeType == "Loan Utilization") {
          _onTap1Item(items[index]);
        } else if (widget.routeType == "Loan List for CGT1") {
          _addNewCGT1(items[index]);
        } else if (widget.routeType == "Loan List for CGT2") {
          sysBean = new SystemParameterBean();
          cgt1ToCgt2Gap = 0;
          sysBean = await AppDatabase.get().getSystemParameter('8', 0);
          if (sysBean != null) {
            print(sysBean.mcodevalue);
            try {
              cgt1ToCgt2Gap = int.parse(sysBean.mcodevalue);
            } catch (_) {
              print("Exception in parsing");
            }
          }
          print(username);
          print("created by" + items[index].mcreatedby);
          print("route to by" + items[index].mrouteto);

          if (cgt1ToCgt2Gap == null) {
            showMessage("Try Syncing Sytem parameter first");
          }else if(items[index].merrormessage!=null&&(items[index].merrormessage.trim()!=''||
              items[index].merrormessage.trim()!='null'

          )) {

            globals.Dialog.alertPopup(
                context,
                "Error Persist",
                "Remove The error to get further",
                "LoginPage");
          }
          else if ((items[index].mrouteto != null &&
                  items[index].mrouteto.trim() != 'null') &&
              (items[index].mrouteto.trim() != username.trim()) &&
              items[index].mrouteto.trim() != '') {
            globals.Dialog.alertPopup(
                context,
                "You Do not have Access for this",
                "Sync it to get further ",
                "LoginPage");
          } else if (items[index].mcreatedby.toUpperCase().trim() ==
                  usrCode.toUpperCase().trim() &&
              (items[index].mrouteto == null ||
                  items[index].mrouteto == 'null' ||
                  items[index].mrouteto.trim() == "") &&
              ((getTruncatedDate(DateTime.now())
                      .difference(getTruncatedDate(items[index].mlastupdatedt))
                      .inDays) <
                  cgt1ToCgt2Gap) &&
              cgt1ToCgt2Gap != 0) {
            //_addNewCGT2(items[index]);
            globals.Dialog.alertPopup(
                context,
                "You Do not have Access for this",
                "Atleast ${cgt1ToCgt2Gap} day from CGT2 required",
                "LoginPage");
          } else if ((items[index].mrouteto.toUpperCase().trim() ==
                  usrCode.toUpperCase().trim()) ||
              (getTruncatedDate(DateTime.now())
                          .difference(
                              getTruncatedDate(items[index].mlastupdatedt))
                          .inDays >=
                      cgt1ToCgt2Gap &&
                  items[index].mcreatedby.toUpperCase() ==
                      usrCode.toUpperCase())) {
            _addNewCGT2(items[index]);
          } else {
            print("routed to ${items[index].mrouteto}");
            print("created by to ${items[index].mcreatedby}");
            print("usrcode by${usrCode}");
            print(DateTime.now().day - items[index].mlastupdatedt.day);
            print(DateTime.now().day - items[index].mlastupdatedt.day ==
                cgt1ToCgt2Gap);

            print(items[index].mcreatedby.toUpperCase() ==
                userCode.toUpperCase());

            globals.Dialog.alertPopup(
                context, "Error", "Something went Wrong", "LoginPage");
          }
        } else if (widget.routeType == "Loan List for GRT") {
          sysBean = new SystemParameterBean();
          cgt2ToGrtGap = 0;
          sysBean = await AppDatabase.get().getSystemParameter('7', 0);
          if (sysBean != null) {
            print(sysBean.mcodevalue);

            try {
              cgt2ToGrtGap = int.parse(sysBean.mcodevalue);
            } catch (_) {
              print("Exception in parsing");
            }
          }
          if (cgt2ToGrtGap == null) {
            showMessage("Try Syncing System Parameter first");
          }else if(items[index].merrormessage!=null&&(items[index].merrormessage.trim()!=''||
              items[index].merrormessage.trim()!='null'

          )) {

            globals.Dialog.alertPopup(
                context,
                "Error Persist",
                "Remove The error to get further",
                "LoginPage");
          } else if (items[index].mrouteto.toUpperCase() != null &&
              items[index].mrouteto.toUpperCase().trim() !=
                  usrCode.toUpperCase().trim() &&
              items[index].mrouteto.trim() != '') {
            globals.Dialog.alertPopup(
                context,
                "You Do not have Access for this",
                "Please Route/Sync for Approval",
                "LoginPage");
            //added by shadab items[index].mrouteto.toUpperCase().trim == usrCode.toUpperCase().trim
          } else if (items[index].mcreatedby != null &&
              items[index].mcreatedby != 'null' &&
              usrCode != null &&
              usrCode != 'null' &&
              items[index].mcreatedby.toUpperCase().trim() !=
                  usrCode.toUpperCase().trim() &&
              items[index].mlastupdatedt != null &&
              items[index].mlastupdatedt != 'null' &&
              (getTruncatedDate(DateTime.now())
                      .difference(getTruncatedDate(items[index].mlastupdatedt))
                      .inDays) <
                  cgt2ToGrtGap &&
              cgt2ToGrtGap != 0) {
            globals.Dialog.alertPopup(
                context,
                "You Do not have Access for this",
                "Atleast  ${cgt2ToGrtGap} day from CGT2 required",
                "LoginPage");
          } else if ((items[index].mrouteto.toUpperCase().trim() ==
                      usrCode.toUpperCase().trim() ||
                  items[index].mrouteto.toUpperCase().trim() == '') && (items[index].mcreatedby.toUpperCase().trim() !=
              usrCode.toUpperCase().trim())&&
              items[index].mlastupdatedt != null &&
              items[index].mlastupdatedt != 'null' &&
              getTruncatedDate(DateTime.now())
                      .difference(getTruncatedDate(items[index].mlastupdatedt))
                      .inDays >=
                  cgt2ToGrtGap &&
              usrGrpCode != 6 &&
              usrGrpCode != 16) {
            _addNewGRT(items[index]);
          } else {
            globals.Dialog.alertPopup(context, Constant.error,
                Constant.somethingWentWrong, Constant.loginPage);
          }
        }
      },
      // child: new Card(

      child: new Card(
        //color Color(0xff2f1f4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 25.0,
        child: new Padding(
          padding: new EdgeInsets.only(
            left: 3.0,
            right: 3.0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 3.0),

                // width: c_width,
                child: Container(
                  width: c_width,
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          ThemeDesign.loginGradientEnd,
                          ThemeDesign.loginGradientStart,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  //color: color,
                  child: Column(
                    children: <Widget>[
                      new Text(
                        "${items[index].mcustname.toString() != null && items[index].mcustname.toString() != 'null' ? items[index].mcustname : ""}",
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text(
                            "Lead ID:"
                                "${leadId != null && leadId != 'null' ? leadId : ""}",
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                          new Text(
                            "A/C No:   ${prcdAcctId!=0?(custNo.toString() +
                              "/" +
                              mprdcd.toString() +
                              "/" +
                              prcdAcctId.toString()):(0)}" /*+ prcdAcctId!=0?
                                custNo.toString() +
                                "/" +
                                mprdcd.toString() +
                                "/" +
                                prcdAcctId.toString():0*/,
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text(
                            Constant.trefno.toString() +
                                ""
                                "${items[index].trefno.toString() != null && items[index].trefno.toString() != 'null' ? items[index].trefno : ""}",
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                          new Text(
                            "Group No: "
                                "${items[index].mgroupcd != null && items[index].mgroupcd.toString() != null && items[index].mgroupcd.toString() != 'null' ? items[index].mgroupcd : ""}",
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                          new Text(
                            "Center Id No: "
                                "${items[index].mcenterid != null && items[index].mcenterid.toString() != null && items[index].mcenterid.toString() != 'null' ? items[index].mcenterid : ""}",
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              new Container(
                child: new Row(
                  children: [
                    new Expanded(
                      child: new Text(
                        items[index].merrormessage != null &&
                                items[index].merrormessage.toString() != "" &&
                                items[index].merrormessage.toString() != "null"
                            ? items[index].merrormessage.toString()
                            : '',
                        style:
                            TextStyle(fontSize: 12.0, color: Colors.red[500]),
                      ),
                    ),
                  ],
                ),
                decoration: new BoxDecoration(
                    // backgroundColor: Colors.grey[300],
                    ),
                width: 400.0,
              ),
              new Container(
                width: c_width,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 5.0,
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Container(
                                  // width: 100.0,
                                  child: new Text(
                                    "Approved amount:".toString() +
                                        "${items[index].mapprvdloanamt} ",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: new TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 40.0,
                                ),
                                new Container(
                                    child: new Row(
                                  children: <Widget>[
                                    new Icon(
                                      FontAwesomeIcons.user,
                                      color: Colors.grey,
                                      size: 18.0,
                                    ),
                                    Text(
                                      items[index].mcustno.toString() != null &&
                                              items[index].mcustno.toString() !=
                                                  'null'
                                          ? items[index].mcustno.toString()
                                          : "",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  // width:  100.0,
                                  child: new Text(
                                    " Repay Freq : "
                                        "${getFrequency(items[index].mfrequency) + ""} ",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: new TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            new Row(
                              children: <Widget>[
                                new Icon(
                                  FontAwesomeIcons.productHunt,
                                  color: Colors.green,
                                  size: 18.0,
                                ),
                                Text(
                                  " : " + prcdCdId.toString() + "/" + prcdName,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.grey[500]),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "EMI:".toString() +
                                      " ${items[index].minstamt.toString() != null && items[index].mprdcd.toString() != 'null' ? items[index].minstamt : ""}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey[500]),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "Approval Remark: ".toString() +
                                      " ${items[index].mapprovaldesc.toString() != null && items[index].mapprovaldesc.toString() != 'null' ? items[index].mapprovaldesc : ""}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: items[index].mleadstatus != null &&
                                              items[index].mleadstatus == 99
                                          ? Colors.red
                                          : Colors.green),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            /*new Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: new Row(
                                textBaseline: TextBaseline.alphabetic,
                                //crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: <Widget>[



                              IconButton(icon: Icon(Icons.apps), onPressed: ()async {

                              List<int> buttonId = new List<int>();

                              await AppDatabase.get().getLoanLevelForStage(stage).then((List<LoanLevel> loanList)async {
                                await Constant.generateeTimlineList(context,
                                    items[index].mrefno,items[index].trefno,items[index].mprdacctid,
                                    items[index].mleadsid,loanList
                                );
                                Navigator.of(context).push(LoaneLevelScreensList());

                              });



                            },),


                                  new OutlineButton(
                                      borderSide:
                                      BorderSide(color: Colors.cyan[50]),
                                      child: Text("Guarantor "),
                                      textColor: Colors.blue,
                                      onPressed: () {
                                        _AddGuarantor(
                                            items[index].mleadsid,items[index].mrefno,items[index].trefno
                                            );
                                      },
                                      shape: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      )),
                                *//*  new IconButton(
                                    icon: new Icon(Icons.add, color: Colors.blue),
                                    onPressed: () {
                                      _AddGuarantor(
                                        items[index].mleadsid,
                                      );
                                    },
                                  ),*//*

                                  new OutlineButton(
                                      borderSide:
                                      BorderSide(color: Colors.cyan[50]),
                                      child: Text("Collaterals"),
                                      textColor: Colors.blue,
                                       onPressed: () {
                                        _AddGuarantor(
                                            items[index].mleadsid,items[index].mrefno,items[index].trefno                                            );
                                      },
                                      shape: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      )),

                                ],
                              ),
                            ),*/

                          ],
                        ),
                      ],
                    ),



                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(


                          icon: Icon(Icons.apps,size: 40.0,color: Colors.orange[400],), onPressed: ()async {


                          List<int> buttonId = new List<int>();

                          await AppDatabase.get().getLoanLevelForStage(stage,items[index].mprdcd).then((List<LoanLevel> loanList)async {
                            await Constant.generateeTimlineList(context,
                                loanList,items[index]
                            );
                            Navigator.of(context).push(LoaneLevelScreensList());

                          });



                        },),







                        new ButtonTheme.bar(
                          padding: new EdgeInsets.all(2.0),
                          child: new ButtonBar(
                            children: <Widget>[





                              Text(
                                " ${items[index].mleadstatus.toString() != null && items[index].mleadstatus.toString() != 'null' ? Constant.getLoanStatus(items[index].mleadstatus) : ""}",
                                overflow: TextOverflow.ellipsis,
                                style:
                                TextStyle(fontSize: 12.0, color: Colors.blue),
                              ),
                              Text(
                                " ${items[index].mrouteto.toString() != null && items[index].mrouteto.toString() != 'null' ? items[index].mrouteto : ""}",
                                overflow: TextOverflow.ellipsis,
                                style:
                                TextStyle(fontSize: 12.0, color: Colors.blue),
                              ),
                              Text(
                                " ${items[index].mcreatedby != null && items[index].mcreatedby.toString() != null && items[index].mcreatedby.toString() != 'null' ? items[index].mcreatedby : ""}",
                                overflow: TextOverflow.ellipsis,
                                style:
                                TextStyle(fontSize: 12.0, color: Colors.blue),
                              ),
                              new IconButton(
                                icon: new Icon(Icons.toc, color: Colors.black),
                                onPressed: () => _onTapWorkFlow(
                                    items[index],
                                    items[index].mrefno,
                                    items[index].trefno,
                                    items[index].mprdacctid,
                                    items[index].mleadsid,
                                    items[index].mrouteto,
                                    items[index].mleadstatus),
                              ),



                              widget.routeType == "Loan List for CGT1"
                                  ? null
                                  : isSyncedIndex
                                  ? new IconButton(
                                icon: new Icon(
                                  FontAwesomeIcons.sync,
                                  color: Colors.orange[400],
                                  size: 25.0,
                                ),
                                onPressed: () async {
                                  if(items[index].mcustmrefno==0||items[index].mcustmrefno==0){
                                    print("no mrefno");
                                    showMessage("Sync Customer First");
                                  }
                                  else{
                                    _syncLoanToMiddleware(items[index]);
                                  }

                                },
                              )
                                  : new IconButton(
                                icon: new Icon(
                                  FontAwesomeIcons.sync,
                                  color: Colors.grey,
                                  size: 25.0,
                                ),
                                onPressed: () async {
                                  showMessageWithoutProgress(
                                      "Loan Already Synced");
                                },
                              ),
                            ],
                          ),
                        ),






                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var loanDetailsBuilder;
    if (CustomerLoanDetailsList.count == 1) {
      CustomerLoanDetailsList.count++;
      try {
        loanDetailsBuilder = new FutureBuilder(
            future: widget.routeType == "Loan List for CGT1"
                ? AppDatabase.get()
                    .getCustomerLoanDetails(1)
                    .then((List<CustomerLoanDetailsBean> loanDetailsList) {
                    loanDetailsList.forEach((val) async{
                      await AppDatabase.get()
                          .getCustomerByTrefAndMref(
                          val.mcusttrefno, val.mcustmrefno)
                          .then((CustomerListBean custObj) {
                        if (custObj != null) {
                          val.mgroupcd = custObj.mgroupcd;
                          val.mcenterid = custObj.mcenterid;
                          val.mcustname = custObj.mlongname;
                        }
                        if (items.length < loanDetailsList.length) {
                          storedItems.add(val);
                          items.add(val);
                        }
                        setState(() {});
                      });
                    });
                    return (items);
                  })
                : widget.routeType == "Loan List for CGT2"
                    ? AppDatabase.get().getCustomerLoanDetails(5).then(
                        (List<CustomerLoanDetailsBean> loanDetailsList) async {
                        loanDetailsList.forEach((val) async {
                          await AppDatabase.get()
                              .getCustomerByTrefAndMref(
                                  val.mcusttrefno, val.mcustmrefno)
                              .then((CustomerListBean custObj) {
                            if (custObj != null) {
                              val.mgroupcd = custObj.mgroupcd;
                              val.mcenterid = custObj.mcenterid;
                              val.mcustname = custObj.mlongname;
                            }
                            if (items.length < loanDetailsList.length) {
                              storedItems.add(val);
                              items.add(val);
                            }
                            setState(() {});
                          });
                        });
                        return (items);
                      })
                    : widget.routeType == "Loan Application"
                        ? AppDatabase.get().getCustomerLoanDetails(0).then(
                            (List<CustomerLoanDetailsBean> loanDetailsList) {
                            loanDetailsList.forEach((val) async {
                              await AppDatabase.get()
                                  .getCustomerByTrefAndMref(
                                      val.mcusttrefno, val.mcustmrefno)
                                  .then((CustomerListBean custObj) {
                                if (custObj != null) {
                                  val.mgroupcd = custObj.mgroupcd;
                                  val.mcenterid = custObj.mcenterid;
                                  val.mcustname = custObj.mlongname;
                                }
                                if (items.length < loanDetailsList.length) {
                                  storedItems.add(val);
                                  items.add(val);
                                }
                              });
                              setState(() {});
                            });
                            return (items);
                          })
                        : widget.routeType == "Loan List for GRT"
                            ? AppDatabase.get().getCustomerLoanDetails(6).then(
                                (List<CustomerLoanDetailsBean>
                                    loanDetailsList) {
                                loanDetailsList.forEach((val) async {
                                  await AppDatabase.get()
                                      .getCustomerByTrefAndMref(
                                          val.mcusttrefno, val.mcustmrefno)
                                      .then((CustomerListBean custObj) {
                                    if (custObj != null) {
                                      val.mgroupcd = custObj.mgroupcd;
                                      val.mcenterid = custObj.mcenterid;
                                      val.mcustname = custObj.mlongname;
                                    }
                                    if (items.length < loanDetailsList.length) {
                                      storedItems.add(val);
                                      items.add(val);
                                    }
                                    setState(() {});
                                  });
                                  storedItems.add(val);
                                });
                                /*items = loanDetailsList;*/
                                return (items);
                              })
                            : widget.routeType == "Loan Utilization"
                                ? AppDatabase.get()
                                    .getCustomerLoanDetails(7)
                                    .then((List<CustomerLoanDetailsBean>
                                        loanDetailsList) {
                                    LoanUtilizationBean cusLoanUtilObj;
                                    loanDetailsList.forEach((val) {
                                      print("dtat hai vlau : " +
                                          widget.customerNum.toString());
                                      print("val.mcustno" +
                                          val.mcustno.toString());
                                      //  if (val.mcustno == widget.customerNum && val.mprdacctid!=null && val.mprdacctid!='null' && val.mprdacctid!='') {
                                      items.add(val);
                                      storedItems.add(val);
                                      setState(() {});
                                      // }
                                      // storedItems.add(val);
                                    });
                                    //TODO Below statment is temporary  , please remove while merging
                                    items = loanDetailsList;
                                    return (items);
                                  })
                                : null,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return new Text('loading...');

                default:
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  else
                    return getHomePageBody(context, snapshot);
              }
            });
      } catch (e) {
        loanDetailsBuilder = new Text("Nothing To display");
      }
    } else if (items != null) {
      loanDetailsBuilder = ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.all(0.0),
      );
    } else
      loanDetailsBuilder = new Text("nothing to display");
    // TODO: implement build
    return new Scaffold(
      key: _scaffoldHomeState,
      appBar: new AppBar(
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close);
                  this.appBarTitle = new TextField(
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.white)),
                    onChanged: (val) {
                      filterList(val.toLowerCase());
                    },
                  );
                } else {
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text(widget.routeType);
                  items.clear();
                  storedItems.forEach((val) {
                    items.add(val);
                  });
                }
              });
            },
          ),
        ],
      ),
      floatingActionButton: !(widget.routeType == "Loan List for CGT1" ||
              widget.routeType == "Loan List for CGT2" ||
              widget.routeType == "Loan List for GRT" ||
              widget.routeType == "Loan Utilization")
          ? new FloatingActionButton(
          elevation: 3.0,
        //           mini: true,
                  child: new Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.green,
                  onPressed: () {
                    if (widget.routeType == "Loan Application") {
                      _addNewLoan();
                    }
                  }

                  )
          : null,
      body: new Container(
        color: const Color(0xff07426A),
        child: loanDetailsBuilder,
      ),
    );
  }
  void _AddGuarantor(String mleadsid,int mrefno,int trefno) {
    print("_AddGuarantor");
    Navigator.push(
      context,
      new MaterialPageRoute(

          builder: (context) =>
          new GuarantorDetails(mleadsid,mrefno,trefno)), //When Authorized Navigate to the next screen
    );

  }

  void _onTapItem(CustomerLoanDetailsBean item) async {

    print(item.mcheckresaddchng);
    item.loanimageBeans = new List<CustomerLoanImageBean>();
    for (int i = 0; i < 5; i++) {
      item.loanimageBeans.add(new CustomerLoanImageBean());
    }
    await AppDatabase.get()
        .selectCustomerLoanImage(item.trefno, item.mrefno)
        .then((List<CustomerLoanImageBean> imageBean) async {
      for (int i = 0; i < imageBean.length; i++) {
        item.loanimageBeans[imageBean[i].timgrefno] = imageBean[i];


      }
    });



    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new CustomerLoanDetailsMasterTab(
                laonLimitPassedObject: item,
              )), //When Authorized Navigate to the next screen
    );
  }

  void filterList(String val) {
    items.clear();
    items = new List<CustomerLoanDetailsBean>();

    storedItems.forEach((obj) {
      if (obj.mcustno.toString().contains(val) |
      obj.trefno.toString().toLowerCase().contains(val) |
      obj.mcenterid.toString().contains(val) |
      obj.mgroupcd.toString().contains(val) |
      obj.mcustname.toString().toUpperCase().contains(val.toUpperCase()) |
      obj.mprdacctid.toString().toUpperCase().contains(val.toUpperCase()) |
      obj.mleadsid.toString().toUpperCase().contains(val.toUpperCase()) ) {
      items.add(obj);
      }
    });

    setState(() {});
  }

  void _onTap1Item(CustomerLoanDetailsBean item) {
    Navigator.pop(context, item);
  }

  void _addNewCGT1(CustomerLoanDetailsBean item) {
    for (int i = 0; i < globals.questionCGT1.length; i++) {
      globals.questionCGT1[i].manschecked = 0;
    }
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new CGT1(
                laonLimitPassedObject: item,
              )), //When Authorized Navigate to the next screen
    );
  }

  void _addNewCGT2(CustomerLoanDetailsBean item) {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new CGT2(
                laonLimitPassedObject: item,
              )), //When Authorized Navigate to the next screen
    );
  }

  void _addNewGRT(CustomerLoanDetailsBean item) {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new GRTTab(
                laonLimitPassedObject: item,
              )), //When Authorized Navigate to the next screen
    );
  }

  void _addNewLoan() {
    /*Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new LoanLimitDetails(
              laonLimitPassedObject:
                  null)), //When Authorized Navigate to the next screen
    );*/


    Navigator.push(
        context,
        new MaterialPageRoute(
        builder: (context) => new CustomerLoanDetailsMasterTab(
        laonLimitPassedObject:
        null)));




  }

  getFrequency(String mfrequency) {
    if (mfrequency == "A") {
      return "Day";
    } else if (mfrequency == "B") {
      return "BiMonthly";
    } else if (mfrequency == "D") {
      return "Daily";
    } else if (mfrequency == "F") {
      return "Fortnightly";
    } else if (mfrequency == "M") {
      return "Monthly";
    } else if (mfrequency == "W") {
      return "Weekly";
    }
    return "";
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }


  Future<void> _syncLoanToMiddleware(CustomerLoanDetailsBean item) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Loan Syncing'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want Sync this Loan')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                circInd = true;
                Navigator.of(context).pop();
                syncLoanToMiddleware(item);
                _ShowCircInd(item);
              },
            ),
            FlatButton(
              child: Text(
                'No',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _ShowCircInd(CustomerLoanDetailsBean item) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('LoanSync'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[CircularProgressIndicator()],
            ),
          ),
        );
      },
    );
  }


  void syncLoanToMiddleware(CustomerLoanDetailsBean item) async {
    try {


     bool  isNetworkAvalable = await Utility.checkIntCon();
     if(isNetworkAvalable==false){

       showMessageWithoutProgress("Network not Awailable");
     }

      CustomerLoanServices customerLoanServices =
      new CustomerLoanServices();
      await customerLoanServices.SyncSingleLoanToMiddleware(
          item, lastSyncedToServerDaeTime,usrCode)
          .then((CustomerLoanCheckBean custLoanchkBean) async{

            print("It Starts");

        if(custLoanchkBean.mleadStatus==1){

          await AppDatabase.get()
              .getCustomerLoanImage(
              custLoanchkBean.mrefno, custLoanchkBean.trefno)
              .then((List<CustomerLoanImageBean> onValue) {



            CustomerLoanImageService loanImageService = new CustomerLoanImageService();
            loanImageService.getLoanImageForSingleSync(onValue);
          });



        }


        //try {
          await AppDatabase.get()
              .getLoanLevelForStage(0, item.mprdcd)
              .then((List<LoanLevel> loanList) async {
            if (loanList != null&&loanList.isNotEmpty){
              for(LoanLevel loanListItem in loanList)  {



                if(loanListItem.mbuttonid==8){

                  try{


                    print("syncing Cash Flow for ${custLoanchkBean.trefno}  and ${custLoanchkBean.mrefno}");
              await AppDatabase.get().selectCashFlowonLoanTrefLoanmerefno(custLoanchkBean.trefno,
                  custLoanchkBean.mrefno,false).then(( CustomerLoanCashFlowAnalysisBean val)async {


                if((val!=null)&&(val.missynctocoresys==0||val.missynctocoresys==null)){
                  CustomerLoanCashFlowService cashFlowService =    CustomerLoanCashFlowService();
                  await cashFlowService.getCashForSingleLoan(val);

                }


              });
                  }catch(_){

                  }


            }
                if(loanListItem.mbuttonid==1){




                }
                else if(loanListItem.mbuttonid==2){//guarantor
                  try{

                  print("syncing gaurantor for ${custLoanchkBean.trefno}  and ${custLoanchkBean.mrefno}");

                    await AppDatabase.get().selectGuarantorTrefLoanmerefno(custLoanchkBean.trefno,
                        custLoanchkBean.mrefno,false).then(( GuarantorDetailsBean val)async {

                          print("Getting back bean ${val}");

                      if((val!=null)&&(val.missynctocoresys==0||val.missynctocoresys==null)){
                        print("value satisfied");
                        SyncGuarantorToMiddleware syncGuarantorToMiddleware =    SyncGuarantorToMiddleware();
                        await syncGuarantorToMiddleware.getGaurantor(val);

                      }


                    });
                  }catch(_){

                  }

                }
                else if(loanListItem.mbuttonid==3){//CP
                  print("syncing CPV for ${custLoanchkBean.trefno}  and ${custLoanchkBean.mrefno}");// V
                  try{
                    await AppDatabase.get().selectCPVTrefLoanmerefno(custLoanchkBean.trefno,
                        custLoanchkBean.mrefno,false).then(( CustomerLoanCPVBusinessRecordBean val)async {

                      if((val!=null)&&(val.missynctocoresys==0||val.missynctocoresys==null)){
                        SyncCustomerLoanCPVBusinessRecordToMiddleware syncCustomerLoanCPVBusinessRecordToMiddleware =    SyncCustomerLoanCPVBusinessRecordToMiddleware();
                        await syncCustomerLoanCPVBusinessRecordToMiddleware.getCPVForSingleLoan(val);
                      }

                    });
                  }catch(_){
                  }
                }
                else if(loanListItem.mbuttonid==4){//Soc

                  print("syncing Social and financial for ${custLoanchkBean.trefno}  and ${custLoanchkBean.mrefno}");// ial
                  try{
                    await AppDatabase.get().selectSocialAndEnvTrefLoanmerefno(custLoanchkBean.trefno,
                        custLoanchkBean.mrefno,false).then(( SocialAndEnvironmentalBean val)async {

                      if((val!=null)&&(val.missynctocoresys==0||val.missynctocoresys==null)){
                        SyncSocialAndEnvironmentalToMiddleware syncSocialAndEnvironmentalToMiddleware =    SyncSocialAndEnvironmentalToMiddleware();
                        await syncSocialAndEnvironmentalToMiddleware.getSocialForSingleLoan(val);
                      }

                    });
                  }catch(_){
                  }
                }
                else if(loanListItem.mbuttonid==5){
                  try{

                  await AppDatabase.get().getKycMasterObj(custLoanchkBean.trefno,custLoanchkBean.mrefno).then((KycMasterBean val) async {

                    if((val!=null)&&(val.missynctocoresys==0||val.missynctocoresys==null)){
                      SyncKycMasterToMiddleware syncKycTomiddleware =    SyncKycMasterToMiddleware();
                      await syncKycTomiddleware.getKYCforSingleLoan(val);
                    }


                  });
                  }catch(_){
                  }

                }
                else if(loanListItem.mbuttonid==6){//Trade
                  try{
                  print("syncing trade and neighbour for ${custLoanchkBean.trefno}  and ${custLoanchkBean.mrefno}");
                    await AppDatabase.get().selectTradeAndNeighTrefLoanmerefno(custLoanchkBean.trefno,
                        custLoanchkBean.mrefno,false).then(( TradeAndNeighbourRefCheckBean val)async {

                      if((val!=null)&&(val.missynctocoresys==0||val.missynctocoresys==null)){
                        SyncTradeAndNeighbourRefCheckToMiddleware syncTradeAndNeighbourRefCheckToMiddleware =    SyncTradeAndNeighbourRefCheckToMiddleware();
                        await syncTradeAndNeighbourRefCheckToMiddleware.getTradeForSingleLoan(val);
                      }

                    });
                  }catch(_){
                  }
                }
                else if(loanListItem.mbuttonid==7){//deviation


                  print("syncing Devuiation for ${custLoanchkBean.trefno}  and ${custLoanchkBean.mrefno}");
                  try{



                  await AppDatabase.get().selectDeviationFormTrefLoanmerefno(custLoanchkBean.trefno,
                      custLoanchkBean.mrefno,false).then(( DeviationFormBean val)async {


                    if((val!=null)&&(val.missynctocoresys==0||val.missynctocoresys==null)){
                      SyncDeviationFormToMiddleware deviatioNservice =    SyncDeviationFormToMiddleware();
                      await deviatioNservice.getDeviationForSingleLoan(val);

                    }


                  });
                  }catch(_){


                  }



                }


              }

            }
          });
       /* }catch(_){


        }*/





        if(custLoanchkBean.mleadStatus>1) {
          await AppDatabase.get()
              .getCustomerCGT1Details(
              custLoanchkBean.mrefno, custLoanchkBean.trefno)
              .then((List<CGT1Bean> onValue) {



            CGT1Services cgt1Services = new CGT1Services();
             cgt1Services.getCGT1ForSingleLoan(onValue);
          });


          if(custLoanchkBean.mleadStatus>5){

            await AppDatabase.get()
                .getCustomerCGT2Details(
                custLoanchkBean.mrefno, custLoanchkBean.trefno)
                .then((List<CGT2Bean> onValue) {



              CGT2Services cgt2Services = new CGT2Services();
              cgt2Services.getCGT2ForSingleLoan(onValue);
            });



            if(custLoanchkBean.mleadStatus>6){

              await AppDatabase.get()
                  .getCustomerGRTDetails(
                  custLoanchkBean.mrefno, custLoanchkBean.trefno)
                  .then((List<GRTBean> onValue) {



                GRTServices grtServices = new GRTServices();
                grtServices.getGRTForSingleLoan(onValue);
              });



            }








          }





        }





        Navigator.of(context).pop();
        if (custLoanchkBean!=null ) {
          _successfulSingleLoanSyncedToServer(custLoanchkBean, item.trefno);



        } else {
          showMessageWithoutProgress("SomeThing wentWrong Syncing Loan");
        }
      });
    } catch (_) {
      showMessageWithoutProgress("Server Exception");
    }
  }


  Future<void> _successfulSingleLoanSyncedToServer(
      CustomerLoanCheckBean custChkObj, int trefno) async {
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
                  Text(
                      'Loan Synced to server for mrefno : ${custChkObj.mrefno} And trefno : ${trefno}'),
                  Text(
                      'CustNo : ${custChkObj.mcustno} '),
                  Text(
                      'Leads Id : ${custChkObj.mleadsid} '),
                  Text(
                      'Error Message : ${custChkObj.merrormessage} '),

                  Text(
                      'Product Id : ${custChkObj.mprdacctid}'),


                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();



                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                          // new LoanLimitDetails()), //When Authorized Navigate to the next screen
                          new CustomerLoanDetailsList(widget.routeType,null)),
                    );




                },
              ),
            ],
          );
        });
  }
  _onTapWorkFlow(
      CustomerLoanDetailsBean bean,
      int mrefno,
      int trefno,
      String mprcdaccid,
      String leadId,
      String loanRotedPending,
      int leadStatus) async {
    await callasyncTimline(
        bean, mrefno, trefno, mprcdaccid, leadId, loanRotedPending, leadStatus);
    Navigator.of(context).push(ShowTranperentWorkflow());
  }

  Future<Null> callasyncTimline(
      CustomerLoanDetailsBean bean,
      int mrefno,
      int trefno,
      String mprcdaccid,
      String leadId,
      String loanRotedPending,
      int leadStatus) async {
    await generateeTimlineList(bean, mrefno, trefno, mprcdaccid, leadId,
            loanRotedPending, leadStatus)
        .then((onValue) {
      listWorkflow.clear();
      listWorkflow.addAll(onValue);
    });
  }

  Future<List<TimelineModel>> generateeTimlineList(
      CustomerLoanDetailsBean bean,
      int mrefno,
      int trefno,
      String mprcdaccid,
      String leadId,
      String loanRotedPending,
      int leadStatus) async {
    workflowBean addWorkFLowList = new workflowBean();
    await AppDatabase.get()
        .getCustomerCGT1Details(mrefno, trefno)
        .then((onValue) {
      addWorkFLowList.cgt1 = new List();
      for (int itemVal = 0; itemVal < onValue.length; itemVal++) {
        print("onValue " + onValue[itemVal].loanmrefno.toString());
        addWorkFLowList.cgt1.add(onValue[itemVal]);
        print("addWorkFLowList.cgt1 len " +
            addWorkFLowList.cgt1.length.toString());
      }
      print("length add workflow " + addWorkFLowList.cgt1.length.toString());
    });
    await AppDatabase.get()
        .getCustomerCGT2Details(mrefno, trefno)
        .then((onValue) {
      addWorkFLowList.cgt2 = new List();

      for (int itemVal = 0; itemVal < onValue.length; itemVal++) {
        print("onValue " + onValue[itemVal].loanmrefno.toString());
        addWorkFLowList.cgt2.add(onValue[itemVal]);
      }

      print(
          "length add workflow cgt2" + addWorkFLowList.cgt2.length.toString());
    });
    await AppDatabase.get()
        .getCustomerGRTDetails(mrefno, trefno)
        .then((onValue) {
      addWorkFLowList.grt = new List();
      for (int itemVal = 0; itemVal < onValue.length; itemVal++) {
        print("onValue " + onValue[itemVal].loanmrefno.toString());
        addWorkFLowList.grt.add(onValue[itemVal]);
      }

      print("length add workflowgrt " + addWorkFLowList.grt.length.toString());
    });

    List<TimelineModel> listItems = new List();
    addWorkFLowList.bean = bean;
    TimelineModel model =
        TimelineModel(generaateTimemline(addWorkFLowList.bean, 0),
            position: TimelineItemPosition.right,
       /*     iconBackground: Colors.green,
            icon: Icon(
              Icons.blur_circular,
              color: Colors.green,
            )*/);
    listItems.add(model);

    if (addWorkFLowList != null) {
      if (addWorkFLowList.cgt1 != null && addWorkFLowList.cgt1.length > 0) {
        print("coming in cgt1");
        for (int items = 0; items < addWorkFLowList.cgt1.length; items++) {
          print(" addWorkFLowList.cgt1[items] " +
              addWorkFLowList.cgt1[items].mrouteto.toString());
          TimelineModel model =
              TimelineModel(generaateTimemline(addWorkFLowList.cgt1[items], 1),
                  position: TimelineItemPosition.right,
               /*   iconBackground: Colors.green,
                  icon: Icon(
                    Icons.blur_circular,
                    color: Colors.green,
                  )*/);
          listItems.add(model);
        }
      }
      if (addWorkFLowList.cgt2 != null && addWorkFLowList.cgt2.length > 0) {
        for (int items = 0; items < addWorkFLowList.cgt2.length; items++) {
          print(" addWorkFLowList.cgt2[items] " +
              addWorkFLowList.cgt2[items].mrouteto.toString());
          TimelineModel model =
              TimelineModel(generaateTimemline(addWorkFLowList.cgt2[items], 2),
                  position: TimelineItemPosition.right,
                /*  iconBackground: Colors.green,
                  icon: Icon(
                    Icons.blur_circular,
                    color: Colors.green,
                  )*/);
          listItems.add(model);
        }
      }
      if (addWorkFLowList.grt != null && addWorkFLowList.grt.length > 0) {
        for (int items = 0; items < addWorkFLowList.grt.length; items++) {
          print(" addWorkFLowList.grt[items] " +
              addWorkFLowList.grt[items].mrouteto.toString());
          TimelineModel model =
              TimelineModel(generaateTimemline(addWorkFLowList.grt[items], 3),
                  position: TimelineItemPosition.right,
                /*  iconBackground: Colors.green,
                  icon: Icon(
                    Icons.blur_circular,
                    color: Colors.green,
                  )*/);
          listItems.add(model);
        }
      }
      if (!(leadStatus == 7)) {
        TimelineModel model = TimelineModel(
            Text("Pending with : " + loanRotedPending),
            position: TimelineItemPosition.right,
            iconBackground: Colors.redAccent,
            icon: Icon(Icons.blur_circular));
        listItems.add(model);
      } else {
        TimelineModel model =
            TimelineModel(Text("Completed With approval Process"),
                position: TimelineItemPosition.right,
              /*  iconBackground: Colors.green,
                icon: Icon(
                  Icons.blur_circular,
                  color: Colors.green,
                )*/);
        listItems.add(model);
      }
    }

    return listItems;
  }

  Widget generaateTimemline(var addWorkFLowList, int forWhat) {
    return new Container(
      //width: MediaQuery.of(context).size.width,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  addWorkFLowList.mcreatedby != null &&
                          addWorkFLowList.mcreatedby.toString() != "null" &&
                          addWorkFLowList.mcreatedby.toString() != ""
                      ? Text(
                          "CreatedBy :" + addWorkFLowList.mcreatedby.toString(),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.green[500],
                          ),
                        )
                      : Text(
                          "CreatedBy :" + "",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.green[500],
                          ),
                        ),
                  SizedBox(
                    height: 5.0,
                  ),
                  addWorkFLowList.mcreateddt != null &&
                          addWorkFLowList.mcreateddt.toString() != "null" &&
                          addWorkFLowList.mcreateddt.toString() != ""
                      ? Text(
                          "Created Date :" +
                              addWorkFLowList.mcreateddt.toString(),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.green[500],
                          ),
                        )
                      : Text(
                          "Created Date :" + "",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.green[500],
                          ),
                        ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: <Widget>[
                      forWhat > 0 && addWorkFLowList.mremarks != null &&
                      addWorkFLowList.mremarks.toString() !=
                      "null" &&
                      addWorkFLowList.mremarks.toString() != ""
                              ? Text(
                                  "Remarks :" +
                                      addWorkFLowList.mremarks.toString(),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.green[500],
                                  ),
                                )
                              : Text(
                                  ""
                                )
                          /*: addWorkFLowList.mapprovaldesc != null &&
                                  addWorkFLowList.mapprovaldesc.toString() !=
                                      "null" &&
                                  addWorkFLowList.mapprovaldesc.toString() != ""
                              ? Text(
                                  "Remarks :" +
                                      addWorkFLowList.mapprovaldesc.toString(),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.green[500],
                                  ),
                                )
                              : Text(
                                  "Remarks :" + "",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.green[500],
                                  ),
                                ),*/
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(),
                    child: new Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: <Widget>[
                        forWhat > 0
                            ? Text(
                                "   Tref no: ${addWorkFLowList.loantrefno != null ? addWorkFLowList.loantrefno : ""}",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.green[500],
                                ),
                              )
                            : Text(
                                "   LoanTrefno: ${addWorkFLowList.trefno != null ? addWorkFLowList.trefno : ""}",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.green[500],
                                ),
                              ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "LoanMrefno: ${addWorkFLowList.mrefno != null ? addWorkFLowList.mrefno : ""}",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.green[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ],
          ),
          //change button later on or remove this button
          new ButtonTheme.bar(
            padding: new EdgeInsets.all(2.0),
            child: new ButtonBar(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new IconButton(
                  icon: new Icon(
                    FontAwesomeIcons.streetView,
                    color: Colors.orange[400],
                    size: 25.0,
                  ),
                  onPressed: () async {
                    showMessageWithoutProgress("View Activity coming soon");
                  },
                ),
                //TODO make below dynamic ,
                forWhat == 0
                    ? new Text("New")
                    : forWhat == 1
                        ? new Text("CGT1")
                        : forWhat == 2 ? new Text("CGT2") : new Text("GRT")
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showMessageWithoutProgress(String message,
      [MaterialColor color = Colors.red]) {
    /* try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));*/
  }
}

class ShowTranperentWorkflow extends ModalRoute<void> {
  ShowTranperentWorkflow();

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _LoanStepper(context),
      ),
    );
  }

  Widget _LoanStepper(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title: Text("Loan Workflow"),
        actions: <Widget>[],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'WorkFlow of Loan Approval',
            style: TextStyle(color: Colors.white, fontSize: 24.0),
          ),
          IconButton(
            icon: Icon(
              (Icons.clear),
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      backgroundColor: Colors.white.withOpacity(0.85),
      body: Timeline(children: listWorkflow, position: TimelinePosition.Left),
    );
  }
}

class workflowBean {
  List<CGT1Bean> cgt1;
  List<CGT2Bean> cgt2;
  List<GRTBean> grt;
  CustomerLoanDetailsBean bean;
  workflowBean({this.cgt1, this.cgt2, this.grt, this.bean});
}
