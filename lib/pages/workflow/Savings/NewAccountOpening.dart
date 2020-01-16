import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/FullScreenDialogForGroupSelection.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/FullScreenDialogForProductSelection.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';

import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/FullScreenDialogForCenterSelection.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewAccountOpening extends StatefulWidget {
  final savingsListPassedObject;
  NewAccountOpening({Key key, this.savingsListPassedObject}) : super(key: key);

  @override
  _NewAccountOpeningState createState() => new _NewAccountOpeningState();
}
//CustomerLoanUtilizationBean cusLoanUtilObj = new CustomerLoanUtilizationBean();

class _NewAccountOpeningState extends State<NewAccountOpening> {
  FullScreenDialogForCenterSelection _myCenterDialog =
  new FullScreenDialogForCenterSelection("");
  FullScreenDialogForGroupSelection _myGroupDialog =
  new FullScreenDialogForGroupSelection("");
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TabController _tabController;
  ProductBean prodObj = new ProductBean();
  LookupBeanData status;
  LookupBeanData freezType;
  DateTime selectedDate = DateTime.now();
  DateTime date;
  TimeOfDay time;
  final dateFormat = DateFormat("yyyy/MM/dd");
  var formatter = new DateFormat('dd-MM-yyyy');
  String tempDate = "----/--/--";
  String tempYear ;
  String tempDay ;
  String tempMonth;
  bool boolValidate = false;
  int accountNumber;
  int loanNumber;
  String branch = "";
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;
  FocusNode monthFocus;
  FocusNode yearFocus;
  SavingsListBean savingsListObj=new SavingsListBean();
   bool isNew=false;

  @override
  void initState() {

    if (widget.savingsListPassedObject != null) {
      savingsListObj = widget.savingsListPassedObject;
      print("savingsListObj.macctstat "+savingsListObj.macctstat.toString());
    }
    else
    {
      savingsListObj=new SavingsListBean();
      savingsListObj.macctstat=2;
      savingsListObj.mfreezetype=1;
      isNew=true;
      getSessionVariables();
    }
    super.initState();
    List<String> tempDropDownValues = new List<String>();
    tempDropDownValues
        .add(savingsListObj.macctstat.toString());
    tempDropDownValues
        .add(savingsListObj.mfreezetype.toString());

    for (int k = 0;
    k < globals.dropdownCaptionsValuesSavingsListInfo.length;
    k++) {
      for (int i = 0;
      i < globals.dropdownCaptionsValuesSavingsListInfo[k].length;
      i++) {


        try{
          if (int.parse(globals.dropdownCaptionsValuesSavingsListInfo[k][i].mcode).toString().trim() ==
              tempDropDownValues[k].toString().trim()) {

            print("Matched");
            setValue(k, globals.dropdownCaptionsValuesSavingsListInfo[k][i]);
          }
        }catch(_){
          print("Exception Occured");

        }
      }
    }

  }




  showDropDown(LookupBeanData selectedObj, int no) {

    if(selectedObj.mcodedesc.isEmpty){
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          status = blankBean;
          break;
        case 1:
          freezType = blankBean;
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
      k < globals.dropdownCaptionsValuesSavingsListInfo[no].length;
      k++) {
        if (globals.dropdownCaptionsValuesSavingsListInfo[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesSavingsListInfo[no][k]);
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
      print("coming here");
      switch (no) {
        case 0:
          status = value;
          savingsListObj.macctstat = int.parse(value.mcode);
          break;
        case 1:
          freezType = value;
          savingsListObj.mfreezetype = int.parse(value.mcode);
          break;

        default:
          break;
      }
    });
  }
  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);
  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    print("caption value : " + globals.dropdownCaptionsValuesSavingsListInfo[no].toString());

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
    k < globals.dropdownCaptionsValuesSavingsListInfo[no].length;
    k++) {
      mapData.add(globals.dropdownCaptionsValuesSavingsListInfo[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      print("data here is of  dropdownwale biayajai " + value.mcodedesc);
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc),
      );
    }).toList();

    return _dropDownMenuItems1;
  }




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




  Future<Null> getSessionVariables() async {
    await AppDatabase.get().generateAccountNumber().then((onValue) {
      savingsListObj.trefno = onValue;
    });
    setState(() {

    });
    prefs = await SharedPreferences.getInstance();
    setState(() {
      savingsListObj.mlbrcode = prefs.get(TablesColumnFile.musrbrcode);
      branch = prefs.get(TablesColumnFile.branch).toString();
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
  Widget build(BuildContext context) {
    int mcustNoInt = 0;
    int mprcdAcctIdInt = 0;
    String mprdcd = "";
    String custNo = "";
    String prcdAcctId = "";
    if (savingsListObj.mprdacctid != null &&
        savingsListObj.mprdacctid != "null" &&
        savingsListObj.mprdacctid != "") {
      mprdcd = savingsListObj.mprdacctid.substring(0, 8).trim();
      custNo = savingsListObj.mprdacctid.substring(8, 16);
      prcdAcctId = savingsListObj.mprdacctid.substring(16, 24);
    }
    // print("items[index].mprdcd " + mprdcd.toString());
    if (mprdcd == null || mprdcd == 'null' || mprdcd.trim() == "") {
      // print("items[index].mprdcd " + items[index].mprdcd.toString());
      mprdcd = savingsListObj.mprdcd;
    }

    if (custNo == null || custNo == 'null' || custNo.trim() == "") {
      //  print("items[index].mprdcd " + items[index].mprdcd.toString());
      custNo = savingsListObj.mcustno.toString();
    }
    try {
      if (custNo != null && custNo != 'null') {
        mcustNoInt = int.parse(custNo);
      }
      if (prcdAcctId != null && prcdAcctId != 'null') {
        mprcdAcctIdInt = int.parse(prcdAcctId);
      }
    } catch (_) {
      //    print("Exception Here in catch future builder");
    }

    return new Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        elevation: 1.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title: new Text(
          Translations.of(context).text('New_Account_Opening'),
          //textDirection: TextDirection,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.normal),
        ),
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
      body: new Form(
        key: _formKey,
        autovalidate: false,
        onWillPop: () {
          return Future(() => true);
        },

        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(0.0),
          children: <Widget>[

            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('Branch_Code'),style: TextStyle(color: Color(0xff795548))),
                subtitle: new Text(savingsListObj.mlbrcode.toString(),style: TextStyle(color: Color(0xff12D6F4))),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('Savings_Account_Number')),
                subtitle: savingsListObj.mprdacctid == null
                    ? new Text("${savingsListObj.trefno}")
                    : new Text(
                  mcustNoInt.toString() +
                      "/" +
                      mprdcd.toString() +
                      "/" +
                      mprcdAcctIdInt.toString(),
                  style: TextStyle(color: Color(0xff12D6F4)),
                ),
              ),
            ),

            new Card(color: Constant.mandatoryColor,
              child: new ListTile(
                title: new Text(Translations.of(context).text('CUSTOMERNUMBER')),
                subtitle: savingsListObj.mcustno == null
                    ? new Text("")
                    : new Text("${savingsListObj.mcustno}"),
                onTap: getCustomerNumber,
              ),
            ),
            new Card(color: Constant.mandatoryColor,
              child: new ListTile(
                title: new Text(Translations.of(context).text('PRODUCTS')),
                subtitle: savingsListObj.mprdcd == null
                    ? new Text("")
                    : new Text("${savingsListObj.mprdcd}"),
                onTap: getProduct,
              ),
            ),

            isNew?Card(
              //color: Constant.mandatoryColor

              child:
              new IgnorePointer(
                ignoring: true,
                child:new DropdownButtonFormField(
                  value: status,
                  items: generateDropDown(0),
                  onChanged: (LookupBeanData newValue) {
                    showDropDown(newValue, 0);
                  },
                  validator: (args) {
                    print(args);
                  },
                  //  isExpanded: true,
                  //hint:Text("Select"),
                  decoration: InputDecoration(labelText: Translations.of(context).text('Account_Status')),
                  // style: TextStyle(color: Colors.grey),
                ),),):Card(
              //color: Constant.mandatoryColor
              child:new DropdownButtonFormField(
                value: status,
                items: generateDropDown(0),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 0);
                },
                validator: (args) {
                  print(args);
                },
                //  isExpanded: true,
                //hint:Text("Select"),
                decoration: InputDecoration(labelText: Translations.of(context).text('Account_Status')),
                // style: TextStyle(color: Colors.grey),
              ),),
            isNew?Card(
    //color: Constant.mandatoryColor

    child:
    new IgnorePointer(
    ignoring: true,
    child:new DropdownButtonFormField(
    value: freezType,
    items: generateDropDown(1),
    onChanged: (LookupBeanData newValue) {
    showDropDown(newValue, 1);
    },
    validator: (args) {
    print(args);
    },
    //  isExpanded: true,
    //hint:Text("Select"),
    decoration: InputDecoration(labelText: Translations.of(context).text('Freeze_Type')),
    // style: TextStyle(color: Colors.grey),
    ),),):Card(
              //color: Constant.mandatoryColor
              child:new DropdownButtonFormField(
              value: freezType,
              items: generateDropDown(1),
              onChanged: (LookupBeanData newValue) {
                showDropDown(newValue, 1);
              },
              validator: (args) {
                print(args);
              },
              //  isExpanded: true,
              //hint:Text("Select"),
                decoration: InputDecoration(labelText: Translations.of(context).text('Freeze_Type')),
              // style: TextStyle(color: Colors.grey),
            ),),
          ],
        ),
      ),

    );

  }


  Future getProduct() async {
    prodObj = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForProductSelection(11,0),
          fullscreenDialog: true,
        ));
    savingsListObj.mprdcd = prodObj.mprdCd.toString();
  }
  Future getCustomerNumber() async {
    var customerdata;
    customerdata = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                CustomerList(null,"Others")));
    if (customerdata != null) {

      savingsListObj.mcustno =
      customerdata.mcustno != null ? customerdata.mcustno : 0;
      savingsListObj.mcusttrefno =
      customerdata.trefno != null ? customerdata.trefno : 0;
      savingsListObj.mcustmrefno =
      customerdata.mrefno != null ? customerdata.mrefno : 0;
      savingsListObj.mlongname = customerdata.mlongname;
      savingsListObj.mcenterid =
      customerdata.mcenterid != null ? customerdata.mcenterid : 0;
      savingsListObj.mgroupcd = customerdata.mgroupcd != null ? customerdata.mgroupcd : 0;
    }
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
                  Text(Translations.of(context).text('Done')),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
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
  proceed() async {
    if (!validateSubmit()) {
      return;
    }

    savingsListObj.mmoduletype=11;
    savingsListObj.mcreatedby = username;
    print("savingsListObj.mcreatedby"+savingsListObj.mcreatedby.toString());
    print("username"+username.toString());
    savingsListObj.mlastupdateby = null;
    savingsListObj.mcreateddt = DateTime.now();
    savingsListObj.mlastupdatedt = DateTime.now();
    savingsListObj.mdateopen = DateTime.now();
    savingsListObj.mgeolocation = geoLocation;
    savingsListObj.mgeologd = geoLongitude;
    savingsListObj.mgeolatd = geoLatitude;
if( savingsListObj.mrefno==null){
  savingsListObj.mrefno=0;
}
    await AppDatabase.get()
        .updateSavingsListMaster(savingsListObj)
        .then((val) {
      print("val here is " + val.toString());

    });
    _successfulSubmit();
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


  bool validateSubmit() {
    String error = "";
    print("inside validate");
     if (savingsListObj.mcustno == "" || savingsListObj.mcustno== null) {
      _showAlert("Customer Number", "It is Mandatory");
      return false;
    }
    if (savingsListObj.mprdcd == "" || savingsListObj.mprdcd== null) {
      _showAlert("Product Code", "It is Mandatory");
      return false;
    }
    return true;

  }

}
