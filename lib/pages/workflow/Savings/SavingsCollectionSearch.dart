import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/app_constant.dart' as oonstant;

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eco_mfi/Utilities/app_constant.dart' as labels;
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/FullScreenDialogForGroupSelection.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFoundation.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/FullScreenDialogForProductSelection.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/Savings/SavingsCollection.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/FullScreenDialogForCenterSelection.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';

import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/collection/list/DailyLoanCollectionList.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_mfi/translations.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class SavingsCollectionSearchScreen extends StatefulWidget {
  SavingsCollectionSearchScreen();

  static Container _get(Widget child,
          [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );

  @override
  _CollectionSearchScreen createState() => new _CollectionSearchScreen();
}

class _CollectionSearchScreen extends State<SavingsCollectionSearchScreen> {
  TextEditingController branchController = new TextEditingController();
  TextEditingController pagesRequiredForPagination =
      new TextEditingController(text: "5");
  TextEditingController loanOfficerController = new TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SystemParameterBean sysBean = new SystemParameterBean();

  //AnimationController textInputAnimationController;
  FullScreenDialogForCenterSelection _myCenterDialog =
      new FullScreenDialogForCenterSelection("");
  FullScreenDialogForGroupSelection _myGroupDialog =
      new FullScreenDialogForGroupSelection("");
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String userCode;
  int branch = 0;
  String usrRole = "";
  String centerName = "";
  String centerNo = "";
  String groupName = "";
  String groupNo = "";
  String customerName = "";
  String customerNo = "";
  String custmrefno = "";
  String custtrefno = "";
  String productName = "";
  String productNo = "";
  String requiredPages = "5";
  String mIsGroupNeeded = "Y";
  final dateFormat = DateFormat("yyyy/MM/dd hh:mm:ss");
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  String companyName = "";
  String printingCenterName = "";
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode);
      userCode = prefs.getString(TablesColumnFile.musrcode);
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      username = prefs.getString(TablesColumnFile.musrname);
      if (prefs.getString(TablesColumnFile.mIsGroupNeeded) != null &&
          prefs.getString(TablesColumnFile.mIsGroupNeeded).trim() != "") {
        mIsGroupNeeded = prefs.getString(TablesColumnFile.mIsGroupNeeded);

        if (mIsGroupNeeded != null &&
            mIsGroupNeeded.trim().toUpperCase() == 'N') {
          globals.isMemeberOfGroupForSvngColl = false;
        }
      }

      branchController.value = TextEditingValue(text: branch.toString());
      loanOfficerController.value = TextEditingValue(
        text: userCode.toString(),
      );
      pagesRequiredForPagination.value =
          TextEditingValue(text: requiredPages.toString());
    });

    companyName = prefs.getString(TablesColumnFile.mCompanyName);
  }

  Widget otherLoan() => SavingsCollectionSearchScreen._get(new Row(
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
            groupValue: globals.isMemberOfGroupListSvngColl[position],
            onChanged: (selection) {
              if (sysBean.mcodevalue != null &&
                  sysBean.mcodevalue.toUpperCase() == 'N') {
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
    setState(() => globals.isMemberOfGroupListSvngColl[position] = selection);
    if (position == 0) {
      globals.memberOfGroupSvngColl =
          globals.radioCaptionValuesIsMemberOfGroup[selection];
      if (globals.memberOfGroupSvngColl == 'Yes') {
        globals.isMemeberOfGroupForSvngColl = true;
      } else {
        centerName = "";
        centerNo = "";
        groupName = "";
        groupNo = "";
        globals.isMemeberOfGroupForSvngColl = false;
      }
    }
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

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    TextEditingController(text: "5");
    globals.isMemeberOfGroupForSvngColl = true;
    globals.memberOfGroupSvngColl = 'Yes';
    globals.isMemberOfGroupListSvngColl = [0];
    if (mounted) {
      getSessionVariables();
    }
    /*textInputAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));*/
  }

  @override
  void dispose() {
    //textInputAnimationController.dispose();
    super.dispose();
  }

  Widget appBarTitle = new Text("Savings Collection Search");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        title: appBarTitle,
        /*actions: <Widget>[
            new IconButton(
             // icon: actionIcon,
              onPressed: () {
                setState(() {
                  */ /*if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = new Icon(Icons.close);
                    this.appBarTitle = new TextField(
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                      decoration: new InputDecoration(
                          prefixIcon:
                          new Icon(Icons.search, color: Colors.white),
                          hintText: "Search...",
                          hintStyle: new TextStyle(color: Colors.white)),
                      onChanged: (val) {
                        */ /**/ /*items = new List<CustomerListBean>();
                        items.clear();
                        filterList(val.toLowerCase());*/ /**/ /*
                      },
                    );
                  } else {
                  */ /**/ /*  this.actionIcon = new Icon(Icons.search);
                    this.appBarTitle = new Text("Customer List");
                    items = new List<CustomerListBean>();
                    items.clear();
                    storedItems.forEach((val) {
                      items.add(val);
                    });*/ /**/ /*
                  }*/ /*
                });
              },
            ),

          ]*/
      ),
      body: Form(
        key: _formKey,
        /*onWillPop: () {
            return Future(() => true);
          },*/
        onChanged: () {
          final FormState form = _formKey.currentState;
          form.save();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: TextFormField(
                        controller: branchController,
                        //initialValue: branch.toString(),
                        enabled: false,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 16.0,
                            color: Colors.black),
                        decoration: InputDecoration(
                          icon: Icon(
                            FontAwesomeIcons.codeBranch,
                            color: Colors.amber.shade500,
                          ),
                          hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          labelText: labels.BRANCH,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: TextFormField(
                        controller: loanOfficerController,
                        enabled: false,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 16.0,
                            color: Colors.black),
                        decoration: InputDecoration(
                          icon: Icon(
                            FontAwesomeIcons.centercode,
                            color: Colors.amber.shade500,
                          ),
                          hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          labelText: labels.LOANOFFICER,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              mIsGroupNeeded == "Y"
                  ? new Table(children: [
                      new TableRow(
                          decoration: new BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.1),
                          ),
                          children: [
                            getTextContainer(
                                globals.radioCaptionCenterGroupDetails[0]),
                            otherLoan(),
                          ]),
                    ])
                  : Container(),

              /*   new TextFormField(
                  decoration: const InputDecoration(
                    hintText:  "Enter number of records you want to see in one page",
                    labelText:  "Number of records you want to see in one page",
                    hintStyle: TextStyle(color: Colors.grey),
                    */ /*labelStyle: TextStyle(color: Colors.grey),*/ /*
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    contentPadding: EdgeInsets.all(1.0),
                  ),
                  controller: pagesRequiredForPagination,
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(2),
                    globals.onlyIntNumber
                  ],
                  onSaved: (String value) {
                    requiredPages =
                        value;
                  }),*/
              /*globals.isMemberOfGroup*/
              SizedBox(height: 5.0),
              globals.isMemeberOfGroupForSvngColl && mIsGroupNeeded == "Y"
                  ? Card(
                      color: Constant.mandatoryColor,
                      child: new ListTile(
                          title: new Text(
                              Translations.of(context).text('centerNameNo')),
                          subtitle: new Text("${centerName} ${centerNo}"),
                          onTap:
                              getCenter /*() {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  _myCenterDialog,
                              fullscreenDialog: true,
                            ));
                      },*/
                          ),
                    )
                  : Container(),
              SizedBox(height: 5.0),
              globals.isMemeberOfGroupForSvngColl && mIsGroupNeeded == "Y"
                  ? Card(
                      color: Constant.mandatoryColor,
                      child: new ListTile(
                          title: new Text(
                              Translations.of(context).text('Group_Name/No')),
                          subtitle: new Text("${groupName} ${groupNo}"),
                          onTap:
                              getGroup /*() {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (BuildContext context) => _myGroupDialog,
                              fullscreenDialog: true,
                            ));
                      },*/
                          ),
                    )
                  : Container(),
              Card(
                color: Constant.mandatoryColor,
                child: new ListTile(
                    title: new Text(
                        Translations.of(context).text('Cutomer_Name/No')),
                    subtitle: new Text("${customerName} ${customerNo}"),
                    onTap: () => getCustomerNumber()),
              ),
              Card(
                color: Constant.mandatoryColor,
                child: new ListTile(
                    title: new Text(
                        Translations.of(context).text('Offline_Customer')),
                    subtitle: custtrefno==""?new Text(""):new Text("Custmrefno ${custmrefno} Custtrefno ${custtrefno}"),
                    onTap: () => getCustomertrefmref()),
              ),
              Card(
                color: Constant.mandatoryColor,
                child: new ListTile(
                    title: new Text(
                        Translations.of(context).text('Product_Name/No')),
                    subtitle: new Text("${productName} ${productNo}"),
                    onTap: () => getProduct()),
              ),
              SizedBox(height: 5.0),
              new TextFormField(
                  decoration: const InputDecoration(
                    hintText: labels.ENTERPAGESCOUNT,
                    labelText: labels.PAGESCOUNT,
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
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  controller: pagesRequiredForPagination,
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(2),
                    globals.onlyIntNumber
                  ],
                  onSaved: (String value) {
                    requiredPages = value;
                  }),
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: OutlineButton(
                            borderSide:
                                BorderSide(color: Colors.amber.shade500),
                            child: Text(oonstant.searchList),
                            textColor: Colors.amber.shade500,
                            onPressed: () {
                              int mcenterid;
                              int mgroupid;
                              int custNo;
                              int prcdNo;
                              int paginationCount;
                              int mrefno;
                              int trefno;

                              try {
                                mcenterid = centerNo != null &&
                                        centerNo.trim() != 'null' &&
                                        centerNo.trim() != ''
                                    ? int.parse(centerNo.trim())
                                    : 0;
                                mgroupid = groupNo != null &&
                                        groupNo.trim() != 'null' &&
                                        groupNo.trim() != ''
                                    ? int.parse(groupNo.trim())
                                    : 0;
                                custNo = customerNo != null &&
                                        customerNo.trim() != 'null' &&
                                        customerNo.trim() != ''
                                    ? int.parse(customerNo.trim())
                                    : 0;
                                prcdNo = productNo != null &&
                                        productNo.trim() != 'null' &&
                                        productNo.trim() != ''
                                    ? int.parse(productNo.trim())
                                    : 0;
                                paginationCount = requiredPages != null &&
                                        requiredPages.trim() != 'null' &&
                                        requiredPages.trim() != ''
                                    ? int.parse(requiredPages.trim())
                                    : 0;
                                mrefno = custmrefno != null &&
                                    custmrefno.trim() != 'null' &&
                                    custmrefno.trim() != ''
                                    ? int.parse(custmrefno.trim())
                                    : 0;

                                trefno = custtrefno != null &&
                                    custtrefno.trim() != 'null' &&
                                    custtrefno.trim() != ''
                                    ? int.parse(custtrefno.trim())
                                    : 0;
                              } catch (_) {
                                print(
                                    "Exception while parsing int in serach screen crieteria");
                              }

                              if (/*globals.isMemberOfGroup*/
                                  globals.isMemeberOfGroupForSvngColl = /*true*/
                                      false) {
                                mcenterid = 0;
                                mgroupid = 0;
                              }

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SavingsCollectionList(
                                              mcenterid,
                                              mgroupid,
                                              custNo,
                                              prcdNo,
                                              paginationCount,
                                              trefno,
                                              mrefno
                                          )));
                            },
                            shape: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: OutlineButton(
                            borderSide:
                                BorderSide(color: Colors.amber.shade500),
                            child: Text("Select Type To Print"),
                            textColor: Colors.amber.shade500,
                            onPressed: () {
                              int mcenterid;
                              int mgroupid;
                              int custNo;

                              try {
                                mcenterid = centerNo != null &&
                                        centerNo.trim() != 'null' &&
                                        centerNo.trim() != ''
                                    ? int.parse(centerNo.trim())
                                    : 0;
                                mgroupid = groupNo != null &&
                                        groupNo.trim() != 'null' &&
                                        groupNo.trim() != ''
                                    ? int.parse(groupNo.trim())
                                    : 0;
                                custNo = customerNo != null &&
                                        customerNo.trim() != 'null' &&
                                        customerNo.trim() != ''
                                    ? int.parse(customerNo.trim())
                                    : 0;
                              } catch (_) {
                                print(
                                    "Exception while parsing int in serach screen crieteria");
                              }

                              if (globals.isMemeberOfGroupForSvngColl = false) {
                                mcenterid = 0;
                                mgroupid = 0;
                              }

                              _TypesOfPrint(mcenterid, mgroupid, custNo);
                            },
                            shape: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _TypesOfPrint(int mcenterid, int mgroupid, int custNo) async {
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
                        title: new Text(('On The Basis Of Center')),
                        subtitle: new Text(
                            mcenterid.toString() != "0"
                                ? mcenterid.toString()
                                : "",
                            style: TextStyle(color: Colors.blue[800])),
                        onTap: () => IsCenterPresent(mcenterid)),
                  ),
                  Card(
                    child: new ListTile(
                        title: new Text(('On The Basis Of Group')),
                        subtitle: new Text(
                            mgroupid.toString() != "0"
                                ? mgroupid.toString()
                                : "",
                            style: TextStyle(color: Colors.blue[800])),
                        onTap: () => IsGroupPresent(mgroupid)),
                  ),
                  Card(
                    child: new ListTile(
                        title: new Text(('On The Basis Of Customer')),
                        subtitle: new Text(
                            custNo.toString() != "0" ? custNo.toString() : "",
                            style: TextStyle(color: Colors.blue[800])),
                        onTap: () => IsCustNoPresent(custNo)),
                  ),
                  Card(
                    child: new ListTile(
                        title: new Text(("Today's Records")),
                        subtitle: new Text(
                            DateTime.now().toString().substring(0, 11),
                            style: TextStyle(color: Colors.blue[800])),
                        onTap: () => TodaysRecords()),
                  ),
                ],
              ),
            ),
          );
        });
  }

  IsCenterPresent(int mcenterid) async {
    if (!centerPresent(mcenterid)) {
      return;
    }

    await AppDatabase.get()
        .getCenterFromCenterId(mcenterid)
        .then((CenterDetailsBean centerBean) {
      printingCenterName = centerBean.mcentername;
    });
    await AppDatabase.get()
        .getSavingListOnCenter(mcenterid)
        .then((List<SavingsListBean> savingsListBean) {
      print("val here is " + savingsListBean.toString());
      if (savingsListBean.isEmpty) {
        _CheckIfThere();
      } else {
        _callChannelSvngCollCenter(savingsListBean);
      }
    });
  }

  Future<void> _CheckIfThere() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.cancel,
              color: Colors.red,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Text(
                          Translations.of(context).text('No_Records_Found')),
                    ],
                  ),
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
        });
  }

  IsGroupPresent(int mgroupid) async {
    if (!groupPresent(mgroupid)) {
      return;
    }

    await AppDatabase.get()
        .getGroupFromGrpId(mgroupid)
        .then((GroupFoundationBean groupBean) {
      printingCenterName = groupBean.mgroupname;
    });
    await AppDatabase.get()
        .getSavingListOnGroup(mgroupid)
        .then((List<SavingsListBean> savingsListBean) {
      print("val here is " + savingsListBean.toString());
      if (savingsListBean.isEmpty) {
        _CheckIfThere();
      } else {
        _callChannelSvngCollGroup(savingsListBean);
      }
    });
  }

  IsCustNoPresent(int custNo) async {
    if (!custNoPresent(custNo)) {
      return;
    }
    printingCenterName = "";
    await AppDatabase.get()
        .getSavingListOnCustNo(custNo)
        .then((List<SavingsListBean> savingsListBean) async {
      print("val here is " + savingsListBean.toString());
      if (savingsListBean.isEmpty) {
        _CheckIfThere();
      } else {
        bool status = await bluetooth.isOn;
        if (status == true) {
//          Toast.show("Bluetooth is on ", context);
          _callChannelSvngCollCustNo(savingsListBean);
        } else if (status == false) {
//          Toast.show("Please Turn ON BLUETOOTH of your decive and try again!", context);
          showMessageWithoutProgress(
              "Please Turn ON BLUETOOTH of your decive and try again!");
          Future.delayed(const Duration(milliseconds: 3000), () {
            bluetooth.openSettings;
          });
        }
      }
    });
  }

  TodaysRecords() async {
    printingCenterName = "";
    await AppDatabase.get()
        .getTodaysSavingList()
        .then((List<SavingsListBean> savingsListBean) {
      print("val here is " + savingsListBean.toString());
      if (savingsListBean.isEmpty) {
        _CheckIfThere();
      } else {
        _callChannelSvngCollToday(savingsListBean);
      }
    });
  }

  _callChannelSvngCollCenter(List<SavingsListBean> savingsListBeanList) async {
    String repeatedStringAmount = "";
    String repeatedStringCustomerNumber = "";
    double totalAmountCollected = 0.0;
    print("savingsListBeanList" + savingsListBeanList.toString());
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    String branchName = prefs.getString(TablesColumnFile.branchname);
    print("bluetoothAddress $bluetootthAdd");
    if (savingsListBeanList != null && savingsListBeanList != "") {
      for (var items in savingsListBeanList) {
        repeatedStringAmount =
            items.mcollectedamount.toString() + "~" + repeatedStringAmount;
        totalAmountCollected += items.mcollectedamount;
        if(items.mcustno==0){

          repeatedStringCustomerNumber =
              items.trefno.toString() +"T"+ "~" + repeatedStringCustomerNumber;
        }else{

          repeatedStringCustomerNumber =
              items.mcustno.toString() + "~" + repeatedStringCustomerNumber;
        }

      }
      print("repeatedStringCustomerNumber" + repeatedStringAmount);
      print("repeatedStringAmount" + repeatedStringAmount);
      String repeatedStringEntryDate = "";
      for (var items in savingsListBeanList) {
        repeatedStringEntryDate =
            items.mentrydate.toString() + "~" + repeatedStringEntryDate;
      }
      print("repeatedStringEntryDate" + repeatedStringEntryDate);

      String repeatedStringprdAccId = "";
      for (var items in savingsListBeanList) {
        print("items.mprdacctid" + items.mprdacctid.toString());
        if (items.mprdacctid!=null&&items.mprdacctid.trim()!='null' &&items.mprdacctid.trim() != '') {
          repeatedStringprdAccId =
              int.parse(items.mprdacctid.substring(0, 8)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(8, 16)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(16, 24)).toString() +
                  "~" +
                  repeatedStringprdAccId;
        }
        else {
          repeatedStringprdAccId =
              "AccId Not Found" + "~" + repeatedStringprdAccId;
        }
      }
      print("repeatedStringprdAccId" + repeatedStringprdAccId.toString());
      String mlbrcode = savingsListBeanList[0].mlbrcode.toString() != ""
          ? savingsListBeanList[0].mlbrcode.toString()
          : "";
      String mcenterid = savingsListBeanList[0].mcenterid.toString();
      String date = dateFormat.format(DateTime.now());
      // String mlongname = savingsListBeanList[0].mlongname.toString();

      try {
        final String result =
            await platform.invokeMethod("svngcollcenterprint", {
          "BluetoothADD": bluetootthAdd,
          "mlbrcode": mlbrcode,
          "date": date,
          "mcenterid": mcenterid,
          "repeatedStringAmount": repeatedStringAmount,
          "repeatedStringprdAccId": repeatedStringprdAccId,
          "repeatedStringEntryDate": repeatedStringEntryDate,
          "repeatedStringCustomerNumber": repeatedStringCustomerNumber,
          "branchName": branchName,
          "company": "Wasaasaa",
          //companyName
          "trefno": savingsListBeanList[0].mbatchcd,
          "centerName": printingCenterName,
          "total": totalAmountCollected.toStringAsFixed(0),
          "username": username
          //totalAmountCollected
        });
        String geTest = 'geTest at $result';
        print("FLutter : " + geTest.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }
  }

  _callChannelSvngCollGroup(List<SavingsListBean> savingsListBeanList) async {
    String repeatedStringAmount = "";
    String repeatedStringCustomerNumber = "";
    double totalAmountCollected = 0.0;
    print("savingsListBeanList" + savingsListBeanList.toString());
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    String branchName = prefs.getString(TablesColumnFile.branchname);
    print("bluetoothAddress $bluetootthAdd");
    if (savingsListBeanList != null && savingsListBeanList != "") {
      for (var items in savingsListBeanList) {
        repeatedStringAmount =
            items.mcollectedamount.toString() + "~" + repeatedStringAmount;
        if(items.mcustno==0){

          repeatedStringCustomerNumber =
              items.trefno.toString() +"T"+ "~" + repeatedStringCustomerNumber;
        }else{

          repeatedStringCustomerNumber =
              items.mcustno.toString() + "~" + repeatedStringCustomerNumber;
        }
        totalAmountCollected += items.mcollectedamount;
      }
      print("repeatedStringAmount" + repeatedStringAmount);
      String repeatedStringEntryDate = "";
      for (var items in savingsListBeanList) {
        repeatedStringEntryDate =
            items.mentrydate.toString() + "~" + repeatedStringEntryDate;
      }
      print("repeatedStringEntryDate" + repeatedStringEntryDate);

      String repeatedStringprdAccId = "";
      for (var items in savingsListBeanList) {
        print("items.mprdacctid" + items.mprdacctid.toString());
        if (items.mprdacctid!=null&&items.mprdacctid.trim()!='null'
            &&items.mprdacctid.trim() != '') {
          repeatedStringprdAccId =
              int.parse(items.mprdacctid.substring(0, 8)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(8, 16)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(16, 24)).toString() +
                  "~" +
                  repeatedStringprdAccId;
        }
        else {
          repeatedStringprdAccId =
              "AccId Not Found" + "~" + repeatedStringprdAccId;
        }
      }
      print("repeatedStringprdAccId" + repeatedStringprdAccId.toString());
      String mlbrcode = savingsListBeanList[0].mlbrcode.toString() != ""
          ? savingsListBeanList[0].mlbrcode.toString()
          : "";
      String mgroupcd = savingsListBeanList[0].mgroupcd.toString();
      String date = dateFormat.format(DateTime.now());
      // String mlongname = savingsListBeanList[0].mlongname.toString();

      try {
        final String result =
            await platform.invokeMethod("svngcollgroupprint", {
          "BluetoothADD": bluetootthAdd,
          "mlbrcode": mlbrcode,
          "date": date,
          "mgroupcd": mgroupcd,
          "repeatedStringAmount": repeatedStringAmount,
          "repeatedStringprdAccId": repeatedStringprdAccId,
          "repeatedStringEntryDate": repeatedStringEntryDate,
          "repeatedStringCustomerNumber": repeatedStringCustomerNumber,
          "branchName": branchName,
          "company": "Wasaasaa",
          //companyName
          "trefno": savingsListBeanList[0].mbatchcd,
          "centerName": printingCenterName,
          "total": totalAmountCollected.toStringAsFixed(0),
          "username": username
          //totalAmountCollected
        });
        String geTest = 'geTest at $result';
        print("FLutter : " + geTest.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }
  }

  _callChannelSvngCollCustNo(List<SavingsListBean> savingsListBeanList) async {
    String repeatedStringAmount = "";
    String repeatedStringCustomerNumber = "";
    double totalAmountCollected = 0.0;
    String CustName = "";
    print("xxxxxx ${savingsListBeanList[0].mlongname} ");
    if (savingsListBeanList != null && savingsListBeanList.isNotEmpty) {
      CustName = savingsListBeanList[0].mlongname;
    }

    print("savingsListBeanList" + savingsListBeanList.toString());
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    String branchName = prefs.getString(TablesColumnFile.branchname);
    print("bluetoothAddress $bluetootthAdd");
    if (savingsListBeanList != null && savingsListBeanList != "") {
      for (var items in savingsListBeanList) {
        repeatedStringAmount =
            items.mcollectedamount.toString() + "~" + repeatedStringAmount;
        totalAmountCollected += items.mcollectedamount;
      }
      print("repeatedStringAmount" + repeatedStringAmount);
      String repeatedStringEntryDate = "";
      for (var items in savingsListBeanList) {
        repeatedStringEntryDate =
            items.mentrydate.toString() + "~" + repeatedStringEntryDate;
        repeatedStringCustomerNumber =
            items.mcustno.toString() + "~" + repeatedStringCustomerNumber;
      }
      print("repeatedStringEntryDate" + repeatedStringEntryDate);

      String repeatedStringprdAccId = "";
      for (var items in savingsListBeanList) {
        print("items.mprdacctid" + items.mprdacctid.toString());
        if (items.mprdacctid!=null&&items.mprdacctid.trim()!='null'
            &&items.mprdacctid.trim() != '') {
          repeatedStringprdAccId =
              int.parse(items.mprdacctid.substring(0, 8)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(8, 16)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(16, 24)).toString() +
                  "~" +
                  repeatedStringprdAccId;
        }
        else {
          repeatedStringprdAccId =
              "AccId Not Found" + "~" + repeatedStringprdAccId;
        }
      }
      print("repeatedStringprdAccId" + repeatedStringprdAccId.toString());
      String mlbrcode = savingsListBeanList[0].mlbrcode.toString() != ""
          ? savingsListBeanList[0].mlbrcode.toString()
          : "";

      if(savingsListBeanList[0].mcustno==0){

        repeatedStringCustomerNumber =
            savingsListBeanList[0].trefno.toString() +"T";
      }else{

        repeatedStringCustomerNumber =
            savingsListBeanList[0].trefno.toString();
      }
      String mcustno = savingsListBeanList[0].mcustno.toString();
      String date = dateFormat.format(DateTime.now());
      // String mlongname = savingsListBeanList[0].mlongname.toString();

      try {
        final String result =
            await platform.invokeMethod("svngcollcustnoprint", {
          "BluetoothADD": bluetootthAdd,
          "mlbrcode": mlbrcode,
          "date": date,
          "mcustno": mcustno,
          "repeatedStringAmount": repeatedStringAmount,
          "repeatedStringprdAccId": repeatedStringprdAccId,
          "repeatedStringCustomerNumber": repeatedStringCustomerNumber,
          "branchName": branchName,
          "company": "Wasaasaa",
          //companyName
          "trefno": savingsListBeanList[0].mbatchcd,
          "centerName": printingCenterName,
          "customerName": customerName,
          "total": totalAmountCollected.toStringAsFixed(0),
          "username": username
          //totalAmountCollected
        });
        String geTest = 'geTest at $result';
        print("FLutter : " + geTest.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }
  }

  _callChannelSvngCollToday(List<SavingsListBean> savingsListBeanList) async {
    String repeatedStringAmount = "";
    double totalAmountCollected = 0.0;
    print("savingsListBeanList" + savingsListBeanList.toString());
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    String branchName = prefs.getString(TablesColumnFile.branchname);
    print("bluetoothAddress $bluetootthAdd");
    if (savingsListBeanList != null && savingsListBeanList != "") {
      for (var items in savingsListBeanList) {
        repeatedStringAmount =
            items.mcollectedamount.toString() + "~" + repeatedStringAmount;
        totalAmountCollected += items.mcollectedamount;
      }
      print("repeatedStringAmount" + repeatedStringAmount);

      String repeatedStringprdAccId = "";
      for (var items in savingsListBeanList) {
        print("items.mprdacctid" + items.mprdacctid.toString());
        if (items.mprdacctid!=null&&items.mprdacctid.trim()!='null'
            &&items.mprdacctid.trim() != '') {
          repeatedStringprdAccId =
              int.parse(items.mprdacctid.substring(0, 8)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(8, 16)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(16, 24)).toString() +
                  "~" +
                  repeatedStringprdAccId;
        }
        else {
          repeatedStringprdAccId =
              "AccId Not Found" + "~" + repeatedStringprdAccId;
        }

      }
      print("at last prdacctid ${repeatedStringprdAccId}");
      String repeatedStringCustNo = "";
      for (var items in savingsListBeanList) {


        repeatedStringAmount =
            items.mcollectedamount.toString() + "~" + repeatedStringAmount;
        if(items.mcustno==0){

          repeatedStringCustNo =
              items.trefno.toString() +"T"+ "~" + repeatedStringCustNo;
        }else{

          repeatedStringCustNo =
              items.mcustno.toString() + "~" + repeatedStringCustNo;
        }

      }
      print("repeatedStringprdAccId" + repeatedStringprdAccId.toString());
      String mlbrcode = savingsListBeanList[0].mlbrcode.toString() != ""
          ? savingsListBeanList[0].mlbrcode.toString()
          : "";
      String mcustno = savingsListBeanList[0].mcustno.toString();
      String date = dateFormat.format(DateTime.now());
      // String mlongname = savingsListBeanList[0].mlongname.toString();

      try {
        final String result =
            await platform.invokeMethod("svngcolltodaysprint", {
          "BluetoothADD": bluetootthAdd,
          "mlbrcode": mlbrcode,
          "date": date,
          "repeatedStringAmount": repeatedStringAmount,
          "repeatedStringprdAccId": repeatedStringprdAccId,
          "repeatedStringCustNo": repeatedStringCustNo,
          "branchName": branchName,
          "company": "Wasaasaa",
          // companyName
          "trefno": "",
          "centerName": printingCenterName,
          "total": totalAmountCollected.toStringAsFixed(0),
          "username": username
          //totalAmountCollected
        });
        String geTest = 'geTest at $result';
        print("FLutter : " + geTest.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }
  }

  bool centerPresent(int mcenterid) {
    print("inside center Present");
    print("mcenterid" + mcenterid.toString());
    if (mcenterid == "" || mcenterid == null || mcenterid == 0) {
      _showAlert("Center Id ", "It Is Mandatory");
      return false;
    }
    return true;
  }

  bool groupPresent(int mgroupid) {
    print("inside group Present");
    print("mgroupid" + mgroupid.toString());
    if (mgroupid == "" || mgroupid == null || mgroupid == 0) {
      _showAlert("Group Id ", "It Is Mandatory");
      return false;
    }
    return true;
  }

  bool custNoPresent(int custNo) {
    print("inside custNo Present");
    print("custNo" + custNo.toString());
    if (custNo == "" || custNo == null || custNo == 0) {
      _showAlert("Customer Id ", "It Is Mandatory");
      return false;
    }
    return true;
  }

  Future<void> _showAlert(arg, error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$arg" + Translations.of(context).text('error')),
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

  Future getCustomerNumber() async {
    var customerdata;
    print("Sending first param is ${globals.isMemeberOfGroupForSvngColl}");
    customerdata = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => CustomerList(
                globals.isMemeberOfGroupForSvngColl, "Loan collection")));
    if (customerdata != null) {
      customerNo =
          customerdata.mcustno != null ? customerdata.mcustno.toString() : "0";

      customerName = customerdata.mlongname;


    }
  }

  Future getCustomertrefmref() async {
    var customerdata;
    print("Sending first param is ${globals.isMemeberOfGroupForSvngColl}");
    customerdata = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => CustomerList(
                globals.isMemeberOfGroupForSvngColl, "Saving Collection")));
    if (customerdata != null) {
      custmrefno = customerdata.mrefno != null? customerdata.mrefno.toString():"0";
      custtrefno = customerdata.trefno.toString();

    }
  }

  Future getProduct() async {
    ProductBean prodObj = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForProductSelection(11, 0),
          fullscreenDialog: true,
        ));

    productName = prodObj.mname;
    productNo = prodObj.mprdCd.toString();
  }

  Future getCenter() async {
    CenterDetailsBean getCenterFoundationList = await Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) => _myCenterDialog,
              fullscreenDialog: true,
            )) /*.then<CenterDetailsBean>((onValue){
    centerName = onValue.centerName;
    centerNo = onValue.id.toString();
  });*/
        ;
    centerName = getCenterFoundationList != null &&
            getCenterFoundationList.mcentername != null
        ? getCenterFoundationList.mcentername
        : "";
    centerNo = getCenterFoundationList != null &&
            getCenterFoundationList.mCenterId != null
        ? getCenterFoundationList.mCenterId.toString()
        : "";
  }

  Future getGroup() async {
    GroupFoundationBean groupFoundationBean = await Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) => _myGroupDialog,
              fullscreenDialog: true,
            )) /*.then<GroupFoundationBean>((onValue){
      groupName = onValue.groupName;
      groupNo = onValue.groupNumber.toString();
    })*/
        ;
    groupName =
        groupFoundationBean != null && groupFoundationBean.mgroupname != null
            ? groupFoundationBean.mgroupname
            : "";
    groupNo =
        groupFoundationBean != null && groupFoundationBean.mgroupid != null
            ? groupFoundationBean.mgroupid.toString()
            : "";
  }

  void showMessageWithoutProgress(String message,
      [MaterialColor color = Colors.red]) {
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: color,
        content: new Text(message),
        duration: const Duration(milliseconds: 2500)));
  }
}
