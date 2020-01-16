import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/app_constant.dart' as oonstant;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eco_mfi/Utilities/app_constant.dart' as labels;
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/FullScreenDialogForGroupSelection.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFoundation.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/FullScreenDialogForProductSelection.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/FullScreenDialogForCenterSelection.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';

import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/collection/ViewDailyCollectionTable.dart';
import 'package:eco_mfi/pages/workflow/collection/bean/CollectionMasterBean.dart';
import 'package:eco_mfi/pages/workflow/collection/list/DailyLoanCollectionList.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_mfi/translations.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyCollectionSearchScreen extends StatefulWidget {
  DailyCollectionSearchScreen();

  static Container _get(Widget child,
          [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );

  @override
  _CollectionSearchScreen createState() => new _CollectionSearchScreen();
}

class _CollectionSearchScreen extends State<DailyCollectionSearchScreen> {
  TextEditingController branchController = new TextEditingController();
  TextEditingController pagesRequiredForPagination =
      new TextEditingController(text: "5");
  TextEditingController loanOfficerController = new TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //AnimationController textInputAnimationController;
  FullScreenDialogForCenterSelection _myCenterDialog =
      new FullScreenDialogForCenterSelection("");
  FullScreenDialogForGroupSelection _myGroupDialog =
      new FullScreenDialogForGroupSelection("");
  SystemParameterBean sysBean = new SystemParameterBean();
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
  String productName = "";
  String productNo = "";
  String requiredPages = "5";
  int skipAlredyColl = 1;
  int todaysDueOnly = 0;
  String mIsGroupLendingNeeded = "Y";
<<<<<<< .mine
  bool isHideMemberGrp=false;
=======
  bool isHideMemberGrp = false;
>>>>>>> .r1143

  String companyName = "";
  String printingCenterName = "";
  final dateFormat = DateFormat("yyyy/MM/dd hh:mm:ss");
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode);
      userCode = prefs.getString(TablesColumnFile.musrcode);
      username = prefs.getString(TablesColumnFile.musrname);
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      if (prefs.getInt(TablesColumnFile.isWASASA) == 1) {
        companyName = TablesColumnFile.wassasa;
      } else if (prefs.getInt(TablesColumnFile.ISFULLERTON) == 1) {
        companyName = TablesColumnFile.fullerton;
      }

      if (prefs.getString(TablesColumnFile.mIsGroupLendingNeeded) != null &&
          prefs.getString(TablesColumnFile.mIsGroupLendingNeeded).trim() !=
              "") {
        mIsGroupLendingNeeded =
            prefs.getString(TablesColumnFile.mIsGroupLendingNeeded);

        if (mIsGroupLendingNeeded != null &&
            mIsGroupLendingNeeded.trim().toUpperCase() == 'N') {
          globals.isMemeberOfGroupForColl = false;
        }
<<<<<<< .mine


        List strIlo;
        if(prefs.getString(TablesColumnFile.ISINDONUSERCD) !=null) {
          strIlo = prefs.getString(TablesColumnFile.ISINDONUSERCD).split(",");
        }

        print("strIlo ${strIlo}");
        List strGlo;
        if(prefs.getString(TablesColumnFile.ISGLOONUSERCD) !=null) {
          strGlo = prefs.getString(TablesColumnFile.ISGLOONUSERCD).split(",");
        }

        if (mIsGroupLendingNeeded != null &&  mIsGroupLendingNeeded.trim().toUpperCase() == 'Y') {

          if(strIlo !=null &&  strIlo.contains(usrGrpCode.toString())){
            globals.isMemeberOfGroupForColl = false;
            isHideMemberGrp=true;
          }else if(strGlo !=null &&  strGlo.contains(usrGrpCode.toString())){
            globals.isMemeberOfGroupForColl = true;
            isHideMemberGrp=true;
          }
        }else{
          globals.isMemeberOfGroupForColl = false;
          isHideMemberGrp=true;
        }
=======
        List strIlo;
        if (prefs.getString(TablesColumnFile.ISINDONUSERCD) != null) {
          strIlo = prefs.getString(TablesColumnFile.ISINDONUSERCD).split(",");
        }

        print("strIlo ${strIlo}");
        List strGlo;
        if (prefs.getString(TablesColumnFile.ISGLOONUSERCD) != null) {
          strGlo = prefs.getString(TablesColumnFile.ISGLOONUSERCD).split(",");
        }
        if (mIsGroupLendingNeeded != null &&
            mIsGroupLendingNeeded.trim().toUpperCase() == 'Y') {
          if (strIlo != null && strIlo.contains(usrGrpCode.toString())) {
            globals.isMemeberOfGroupForColl = false;
            isHideMemberGrp = true;
          } else if (strGlo != null && strGlo.contains(usrGrpCode.toString())) {
            globals.isMemeberOfGroupForColl = true;
            isHideMemberGrp = true;
          }
        } else {
          globals.isMemeberOfGroupForColl = false;
          isHideMemberGrp = true;
        }
>>>>>>> .r1143
      }





      branchController.value = TextEditingValue(text: branch.toString());
      loanOfficerController.value = TextEditingValue(
        text: userCode.toString(),
      );
      pagesRequiredForPagination.value =
          TextEditingValue(text: requiredPages.toString());
    });

    // companyName = prefs.getString(TablesColumnFile.mCompanyName);
  }

  Widget otherLoan() => DailyCollectionSearchScreen._get(new Row(
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
            groupValue: globals.isMemberOfGroupListColl[position],
            onChanged: (selection) {
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
    setState(() => globals.isMemberOfGroupListColl[position] = selection);
    if (position == 0) {
      globals.memberOfGroupColl =
          globals.radioCaptionValuesIsMemberOfGroup[selection];
      if (globals.memberOfGroupColl == 'Yes') {
        globals.isMemeberOfGroupForColl = true;
      } else {
        centerName = "";
        centerNo = "";
        groupName = "";
        groupNo = "";
        globals.isMemeberOfGroupForColl = false;
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

  @override
  void initState() {
    super.initState();
    TextEditingController(text: "5");
    globals.isMemeberOfGroupForColl = true;
    globals.memberOfGroupColl = 'Yes';
    globals.isMemberOfGroupListColl = [0];
    centerName = "";
    centerNo = "";
    groupName = "";
    groupNo = "";
    customerName = "";
    customerNo = "";
    productName = "";
    productNo = "";
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

  Widget appBarTitle = new Text("Loan Collection Search");

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
        title: appBarTitle,
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
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
                      padding: const EdgeInsets.only(bottom: 5.0),
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
<<<<<<< .mine
             !isHideMemberGrp
=======
              !isHideMemberGrp
>>>>>>> .r1143
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
              SizedBox(height: 5.0),
              globals.isMemeberOfGroupForColl && mIsGroupLendingNeeded == "Y"
                  ? Card(
                      color: Constant.mandatoryColor,
                      child: new ListTile(
                          title: new Text(
                              Translations.of(context).text('Center_Name/No')),
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
              globals.isMemeberOfGroupForColl && mIsGroupLendingNeeded == "Y"
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
              SizedBox(height: 5.0),
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
                        Translations.of(context).text('Product_Name/No')),
                    subtitle: new Text("${productName} ${productNo}"),
                    onTap: () => getProduct()),
              ),
              Card(
                child: Row(
                  children: <Widget>[
                    Text(
                      Translations.of(context).text('Skip_Already_Collected'),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[500],
                      ),
                    ),
                    new Checkbox(
                        activeColor: Colors.orange[200],
                        value: skipAlredyColl == null || skipAlredyColl == 0
                            ? false
                            : true,
                        onChanged: (val) {
                          setState(() {
                            skipAlredyColl = val == false ? 0 : 1;
                          });
                        }),
                    Text(
                      Translations.of(context).text('Todays_Due_Only'),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[500],
                      ),
                    ),
                    new Checkbox(
                        activeColor: Colors.orange[200],
                        value: todaysDueOnly == null || todaysDueOnly == 0
                            ? false
                            : true,
                        onChanged: (val) {
                          setState(() {
                            todaysDueOnly = val == false ? 0 : 1;
                          });
                        }),
                  ],
                ),
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
                              DateTime toDate;
                              DateTime fromDate;
                              int custNo;
                              int prcdNo;
                              int paginationCount;

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
                                toDate = DateTime.now();
                                fromDate = DateTime.now();
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
                              } catch (_) {
                                print(
                                    "Exception while parsing int in serach screen crieteria");
                              }

                              if (globals.isMemeberOfGroupForColl == false) {
                                mcenterid = 0;
                                mgroupid = 0;
                              }

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DailyLoanCollectionList(
                                              mcenterid,
                                              mgroupid,
                                              fromDate,
                                              toDate,
                                              custNo,
                                              prcdNo,
                                              paginationCount,
                                              globals.isMemeberOfGroupForColl,
                                              skipAlredyColl,
                                              todaysDueOnly)));
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

                              if (globals.isMemeberOfGroupForColl = false) {
                                mcenterid = 0;
                                mgroupid = 0;
                              }

                              _TypesOfPrint(mcenterid, mgroupid, custNo);
                              return;
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

  Future getCustomerNumber() async {
    var customerdata;
    customerdata = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => CustomerList(
                /*globals.isMemberOfGroup*/
                globals.isMemeberOfGroupForColl,
                'Loan collection')));
    if (customerdata != null) {
      customerNo =
          customerdata.mcustno != null ? customerdata.mcustno.toString() : "0";
      customerName = customerdata.mlongname;
    }
  }

  Future getProduct() async {
    ProductBean prodObj = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForProductSelection(
                  30, globals.isMemeberOfGroupForColl == true ? 0 : 1),
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
        .getCollectionListOnCenter(mcenterid)
        .then((List<CollectionMasterBean> collectionListBean) {
      print("val here is " + collectionListBean.toString());
      if (collectionListBean.isEmpty) {
        _CheckIfThere();
      } else {
        _callChannelLoanCollCenter(collectionListBean);
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
        .getCollectionListOnGroup(mgroupid)
        .then((List<CollectionMasterBean> collectionListBean) {
      print("val here is " + collectionListBean.toString());
      if (collectionListBean.isEmpty) {
        _CheckIfThere();
      } else {
        _callChannelLoanCollGroup(collectionListBean);
      }
    });
  }

  IsCustNoPresent(int custNo) async {
    if (!custNoPresent(custNo)) {
      return;
    }
    printingCenterName = "";
    await AppDatabase.get()
        .getCollectionListOnCustNo(custNo)
        .then((List<CollectionMasterBean> collectionListBean) {
      print("val here is " + collectionListBean.toString());
      if (collectionListBean.isEmpty) {
        _CheckIfThere();
      } else {
        _callChannelLoanCollCustNo(collectionListBean);
      }
    });
  }

  TodaysRecords() async {
    printingCenterName = "";
    await AppDatabase.get()
        .getTodaysCollectionList()
        .then((List<CollectionMasterBean> collectionListBean) {
      print("val here is " + collectionListBean.toString());
      if (collectionListBean.isEmpty) {
        _CheckIfThere();
      } else {
        _callChannelLoanCollToday(collectionListBean);
      }
    });
  }

  _callChannelLoanCollCenter(
      List<CollectionMasterBean> collectionListBeanList) async {
    String repeatedStringAmount = "";
    double totalAmountCollected = 0.0;
    String repeatedStringCustNo = "";
    print("collectionListBeanList" + collectionListBeanList.toString());
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    String branchName = prefs.getString(TablesColumnFile.branchname);
    print("bluetoothAddress $bluetootthAdd");
    if (collectionListBeanList != null && collectionListBeanList != "") {
      for (var items in collectionListBeanList) {
        repeatedStringAmount =
            items.mcollAmt.toString() + "~" + repeatedStringAmount;
        totalAmountCollected += items.mcollAmt;
        repeatedStringCustNo =
            items.mcustno.toString() + "~" + repeatedStringCustNo;
      }
      print("repeatedStringAmount" + repeatedStringAmount);
      String repeatedStringEntryDate = "";
      for (var items in collectionListBeanList) {
        repeatedStringEntryDate =
            items.mlastupdatedt.toString() + "~" + repeatedStringEntryDate;
      }
      print("repeatedStringEntryDate" + repeatedStringEntryDate);
      print("total Amount $totalAmountCollected");
      print("center name is ${printingCenterName}");
      print("Customer list is ${repeatedStringCustNo}");

      String repeatedStringprdAccId = "";
      for (var items in collectionListBeanList) {
        print("items.mprdacctid" + items.mprdacctid.toString());
        if (items.mprdacctid.trim() != '') {
          repeatedStringprdAccId =
              int.parse(items.mprdacctid.substring(0, 8)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(8, 16)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(16, 24)).toString() +
                  "~" +
                  repeatedStringprdAccId;
        }
        if (items.mprdacctid.trim() == '') {
          repeatedStringprdAccId =
              "AccId Not Found" + "~" + repeatedStringprdAccId;
        }
      }
      print("repeatedStringprdAccId" + repeatedStringprdAccId.toString());
      String mlbrcode = collectionListBeanList[0].mlbrcode.toString() != ""
          ? collectionListBeanList[0].mlbrcode.toString()
          : "";
      String mcenterid = collectionListBeanList[0].mcenterid.toString();
      String date = dateFormat.format(DateTime.now());
      // String mlongname = savingsListBeanList[0].mlongname.toString();

      try {
        final String result =
            await platform.invokeMethod("loancollcenterprint", {
          "BluetoothADD": bluetootthAdd,
          "mlbrcode": mlbrcode,
          "date": date,
          "mcenterid": mcenterid,
          "repeatedStringAmount": repeatedStringAmount,
          "repeatedStringprdAccId": repeatedStringprdAccId,
          "repeatedStringEntryDate": repeatedStringEntryDate,
          "branchName": branchName,
          "company": "Wasaasaa", //companyName,
          "trefno": collectionListBeanList[0].mbatchcd,
          "centerName": printingCenterName,
          "total": totalAmountCollected.toStringAsFixed(0),
          "repeatedStringCustomerNumber": repeatedStringCustNo,
          "username": username
        });
        String geTest = 'geTest at $result';
        print("FLutter : " + geTest.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }
  }

  _callChannelLoanCollGroup(
      List<CollectionMasterBean> collectionListBeanList) async {
    String repeatedStringAmount = "";
    double totalAmountCollected = 0.0;
    String repeatedStringCustNo = "";
    print("LoanCollectionListBeanList" + collectionListBeanList.toString());
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    String branchName = prefs.getString(TablesColumnFile.branchname);
    print("bluetoothAddress $bluetootthAdd");
    if (collectionListBeanList != null && collectionListBeanList != "") {
      for (var items in collectionListBeanList) {
        repeatedStringAmount =
            items.mcollAmt.toString() + "~" + repeatedStringAmount;
        totalAmountCollected += items.mcollAmt;
        repeatedStringCustNo =
            items.mcustno.toString() + "~" + repeatedStringCustNo;
      }
      print("repeatedStringAmount" + repeatedStringAmount);
      String repeatedStringEntryDate = "";
      for (var items in collectionListBeanList) {
        repeatedStringEntryDate =
            items.mlastupdatedt.toString() + "~" + repeatedStringEntryDate;
      }
      print("repeatedStringEntryDate" + repeatedStringEntryDate);

      String repeatedStringprdAccId = "";
      for (var items in collectionListBeanList) {
        print("items.mprdacctid" + items.mprdacctid.toString());
        if (items.mprdacctid.trim() != '') {
          repeatedStringprdAccId =
              int.parse(items.mprdacctid.substring(0, 8)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(8, 16)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(16, 24)).toString() +
                  "~" +
                  repeatedStringprdAccId;
        }
        if (items.mprdacctid.trim() == '') {
          repeatedStringprdAccId =
              "AccId Not Found" + "~" + repeatedStringprdAccId;
        }
      }
      print("repeatedStringprdAccId" + repeatedStringprdAccId.toString());
      String mlbrcode = collectionListBeanList[0].mlbrcode.toString() != ""
          ? collectionListBeanList[0].mlbrcode.toString()
          : "";
      String mgroupcd = collectionListBeanList[0].mgroupid.toString();
      String date = dateFormat.format(DateTime.now());

      // String mlongname = savingsListBeanList[0].mlongname.toString();

      try {
        if (companyName == TablesColumnFile.wassasa) {
          final String result =
              await platform.invokeMethod("loancollgroupprint", {
            "BluetoothADD": bluetootthAdd,
            "mlbrcode": mlbrcode,
            "date": date,
            "mgroupcd": mgroupcd,
            "repeatedStringAmount": repeatedStringAmount,
            "repeatedStringprdAccId": repeatedStringprdAccId,
            "repeatedStringEntryDate": repeatedStringEntryDate,
            "branchName": branchName,
            "company": companyName,
            "trefno": collectionListBeanList[0].mbatchcd,
            "centerName": printingCenterName,
            "total": totalAmountCollected.toStringAsFixed(0),
            "repeatedStringCustomerNumber": repeatedStringCustNo,
            "username": username
          });
          String geTest = 'geTest at $result';
          print("FLutter : " + geTest.toString());
        } else if (companyName == TablesColumnFile.fullerton) {
          final String result =
              await platform.invokeMethod("loancollgroupprint", {
            "BluetoothADD": bluetootthAdd,
            "mlbrcode": mlbrcode,
            "date": date,
            "mgroupcd": mgroupcd,
            "repeatedStringAmount": repeatedStringAmount,
            "repeatedStringprdAccId": repeatedStringprdAccId,
            "repeatedStringEntryDate": repeatedStringEntryDate,
            "branchName": branchName,
            "company": "Wasaasaa", //companyName,
            "trefno": collectionListBeanList[0].mbatchcd,
            "centerName": printingCenterName,
            "total": totalAmountCollected.toStringAsFixed(0),
            "repeatedStringCustomerNumber": repeatedStringCustNo,
            "username": username
          });
          String geTest = 'geTest at $result';
          print("FLutter : " + geTest.toString());
        }
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }
  }

  _callChannelLoanCollCustNo(
      List<CollectionMasterBean> collectionListBeanList) async {
    String repeatedStringAmount = "";
    double totalAmountCollected = 0.0;
    String repeatedStringCustNo = "";
    print("Loan  Collection ListBeanList" + collectionListBeanList.toString());
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    String branchName = prefs.getString(TablesColumnFile.branchname);
    print("bluetoothAddress $bluetootthAdd");
    if (collectionListBeanList != null && collectionListBeanList != "") {
      for (var items in collectionListBeanList) {
        repeatedStringAmount =
            items.mcollAmt.toString() + "~" + repeatedStringAmount;
        totalAmountCollected += items.mcollAmt;
        repeatedStringCustNo =
            items.mcustno.toString() + "~" + repeatedStringCustNo;
      }
      print("repeatedStringAmount" + repeatedStringAmount);
      String repeatedStringEntryDate = "";
      for (var items in collectionListBeanList) {
        repeatedStringEntryDate =
            items.mlastopendate.toString() + "~" + repeatedStringEntryDate;
      }
      print("repeatedStringEntryDate" + repeatedStringEntryDate);

      String repeatedStringprdAccId = "";
      for (var items in collectionListBeanList) {
        print("items.mprdacctid" + items.mprdacctid.toString());
        if (items.mprdacctid.trim() != '') {
          repeatedStringprdAccId =
              int.parse(items.mprdacctid.substring(0, 8)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(8, 16)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(16, 24)).toString();
        }
        if (items.mprdacctid.trim() == '') {
          repeatedStringprdAccId =
              "AccId Not Found" + "~" + repeatedStringprdAccId;
        }
      }
      print("repeatedStringprdAccId" + repeatedStringprdAccId.toString());
      String mlbrcode = collectionListBeanList[0].mlbrcode.toString() != ""
          ? collectionListBeanList[0].mlbrcode.toString()
          : "";
      String mcustno = collectionListBeanList[0].mcustno.toString();
      String date = dateFormat.format(DateTime.now());
      String mlongname = collectionListBeanList[0].mlongname.toString();

      try {
        final String result =
            await platform.invokeMethod("loancollcustnoprint", {
          "BluetoothADD": bluetootthAdd,
          "mlbrcode": mlbrcode,
          "date": date,
          "mcustno": mcustno,
          "repeatedStringAmount": repeatedStringAmount,
          "repeatedStringprdAccId": repeatedStringprdAccId,
          "repeatedStringCustomerNumber": repeatedStringCustNo,
          "branchName": branchName,
          "company": companyName,
          "trefno": collectionListBeanList[0].mbatchcd,
          "centerName": printingCenterName,
          "customerName": customerName,
          "total": totalAmountCollected.toStringAsFixed(0),
          "username": username //
        });
        String geTest = 'geTest at $result';
        print("FLutter : " + geTest.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }
  }

  _callChannelLoanCollToday(
      List<CollectionMasterBean> collectionListBeanList) async {
    String repeatedStringAmount = "";
    double totalAmountCollected = 0.0;
    print("Loan Collection ListBeanList" + collectionListBeanList.toString());
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    String branchName = prefs.getString(TablesColumnFile.branchname);
    print("bluetoothAddress $bluetootthAdd");
    if (collectionListBeanList != null && collectionListBeanList != "") {
      for (var items in collectionListBeanList) {
        repeatedStringAmount =
            items.mcollAmt.toString() + "~" + repeatedStringAmount;
        totalAmountCollected += items.mcollAmt;
      }
      print("repeatedStringAmount" + repeatedStringAmount);

      String repeatedStringprdAccId = "";
      for (var items in collectionListBeanList) {
        print("items.mprdacctid" + items.mprdacctid.toString());
        if (items.mprdacctid.trim() != '') {
          repeatedStringprdAccId =
              int.parse(items.mprdacctid.substring(0, 8)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(8, 16)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(16, 24)).toString() +
                  "~" +
                  repeatedStringprdAccId;
        }
        if (items.mprdacctid.trim() == '') {
          repeatedStringprdAccId =
              "AccId Not Found" + "~" + repeatedStringprdAccId;
        }
      }
      String repeatedStringCustNo = "";
      for (var items in collectionListBeanList) {
        repeatedStringCustNo =
            items.mcustno.toString() + "~" + repeatedStringCustNo;
      }
      print("repeatedStringprdAccId" + repeatedStringprdAccId.toString());
      String mlbrcode = collectionListBeanList[0].mlbrcode.toString() != ""
          ? collectionListBeanList[0].mlbrcode.toString()
          : "";
      String mcustno = collectionListBeanList[0].mcustno.toString();
      String date = dateFormat.format(DateTime.now());
      // String mlongname = savingsListBeanList[0].mlongname.toString();

      try {
        final String result =
            await platform.invokeMethod("loancolltodaysprint", {
          "BluetoothADD": bluetootthAdd,
          "mlbrcode": mlbrcode,
          "date": date,
          "repeatedStringAmount": repeatedStringAmount,
          "repeatedStringprdAccId": repeatedStringprdAccId,
          "repeatedStringCustomerNumber": repeatedStringCustNo,
          "branchName": branchName,
          "company": companyName,
          "trefno": "",
          "centerName": printingCenterName,
          "total": totalAmountCollected.toStringAsFixed(0),
          "username": username
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
}
