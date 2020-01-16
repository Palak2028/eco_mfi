import 'package:eco_mfi/pages/workflow/termDeposit/ProductwiseInterestTableBean.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/TDParameterBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/FullScreenDialogForProductSelection.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/NewTermDepositBean.dart';

class NewTermDeposit extends StatefulWidget {
  var onTapBean;

  NewTermDeposit({this.onTapBean});
  @override
  _TermDeposit createState() => _TermDeposit();
}

class _TermDeposit extends State<NewTermDeposit> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  FocusNode monthFocus;
  FocusNode yearFocus;
  FocusNode tenureMonthFocus;
  final dateFormat = DateFormat("yyyy/MM/dd");
  var formatter = new DateFormat('dd-MM-yyyy');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


 // String tempDate = "----/--/--";
  String tempYear;
  String tempDay;
  String tempMonth;
  String certDt = "__-__-____";

  LookupBeanData modeofpayment;
  String productName;
  String productNo;
  String customerName;
  String customerNo;
  String selected_months;
  String selected_days;
  int selectedDuration = 0;
  int selectedMonths = 0;
  int selectedDays = 0;
  int branch;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;
  String loginTime;
  int usrGrpCode = 0;

  String username;
  SharedPreferences prefs;
  NewTermDepositBean _newTermDepositBean = null;
  TextEditingController amountController = new TextEditingController();
  int sysParam = 0;
  int canApplyMaxMonth = 0;
  int canApplyMinMonth = 0;
  double  canApplyMinDepAmt = 0.0;
  double canApplyMaxDepAmt = 0.0;
  LookupBeanData sourceOfFunds;
  LookupBeanData noticeType;




  @override
  void initState() {
    super.initState();
    //select amout salb based on tier field from customer
    if(widget.onTapBean==null){
      _newTermDepositBean = new NewTermDepositBean();
      loadNewTDRequestPage();
    }else{
      _newTermDepositBean = widget.onTapBean;
      //certDt = _newTermDepositBean.mcertdate.toString();
      customerNo = _newTermDepositBean.mcustno.toString();
      customerName = _newTermDepositBean.mlongname;
      productNo =  _newTermDepositBean.mprdcd.toString();
      productName = _newTermDepositBean.mprdcd;
      amountController.text = _newTermDepositBean.mmainbalfcy != null
          ? _newTermDepositBean.mmainbalfcy.toString()
          : "";


      if(_newTermDepositBean.mcertdate.day.toString().length==1)tempDay = "0"+_newTermDepositBean.mcertdate.day.toString();
      else tempDay = _newTermDepositBean.mcertdate.day.toString();

      if(_newTermDepositBean.mcertdate.month.toString().length==1)tempMonth = "0"+_newTermDepositBean.mcertdate.month.toString();
      else tempMonth = _newTermDepositBean.mcertdate.month.toString();
      tempYear = _newTermDepositBean.mcertdate.year.toString();

      certDt = certDt.replaceRange(0, 2, tempDay);

      certDt = certDt.replaceRange(3, 5, tempMonth);

      certDt = certDt.replaceRange(6, 10,_newTermDepositBean.mcertdate.year.toString());

      print("certification date = $certDt");




    }


    monthFocus = new FocusNode();
    yearFocus = new FocusNode();
    tenureMonthFocus = new FocusNode();
    if(_newTermDepositBean.mnoticetype==null)_newTermDepositBean.mnoticetype=0;
    if(_newTermDepositBean.msourceoffunds==null)_newTermDepositBean.msourceoffunds=0;

    List<String> tempDropDownValues = new List<String>();
    tempDropDownValues
        .add(_newTermDepositBean.msourceoffunds.toString());
    tempDropDownValues
        .add(_newTermDepositBean.mnoticetype.toString());

    for (int k = 0;
    k < globals.dropdownCaptionsValuesModeOfPayout.length;
    k++) {
      for (int i = 0;
      i < globals.dropdownCaptionsValuesModeOfPayout[k].length;
      i++) {
        if (globals.dropdownCaptionsValuesModeOfPayout[k][i].mcode.toString() ==
            tempDropDownValues[k]) {
          setValue(k, globals.dropdownCaptionsValuesModeOfPayout[k][i]);
        }
      }
    }

    getSessionVariables();

    getsharedPreferences();



  }



// getting system parameter for the logic of Rate of Interest
  getsharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(TablesColumnFile.mTdparam) != null &&
        prefs.getString(TablesColumnFile.mTdparam).trim() != "")
      sysParam = int.parse(prefs.getString(TablesColumnFile.mTdparam).trim());
    print(sysParam);
  }

  void loadNewTDRequestPage() async {
    await AppDatabase.get().generateTDNumber().then((onValue) {
      if (onValue != null) {
        _newTermDepositBean.trefno = onValue;
      }
    });
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
      geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();

      print("branch " + branch.toString());
      print("reportingUser" + reportingUser.toString());
      print("usre code " + username.toString());
      print("usrRole " + usrRole.toString());
      print("usrGrpCode " + usrGrpCode.toString());
      print("loginTime" + loginTime.toString());
      print("geoLocation" + geoLocation.toString());
      print("geoLatitude " + geoLatitude.toString());
      print("geoLongitude" + geoLongitude.toString());
    });


    if(widget.onTapBean!=null){


      AppDatabase.get().getParameterForProduct(productNo,branch).then((TDParameterBean tdParamBean){

        if(tdParamBean!=null){
          canApplyMinMonth = tdParamBean.mminperiod;
          canApplyMaxMonth = tdParamBean.mmaxperiod;
          canApplyMinDepAmt = tdParamBean.mmindepamt;
          canApplyMaxDepAmt = tdParamBean.mmaxdepamt;
        }

      });
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      // backgroundColor: Colors.white70,
      key:_scaffoldKey,
      appBar: new AppBar(
        elevation: 1.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title: new Text(
          Constant.appBarLabelNewTermDeposit,
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
              if (!validateSubmit()) {
              } else {
                proceed();
              }
              // proceed();
              // Navigator.of(context).pop();
              /*  globals.Dialog.alertPopup(
                  context, "Sucess", "Data Saved Sucessfully!!!", "Dashboard");*/
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
        onChanged: () async {
          final FormState form = _formKey.currentState;
          form.save();
          await calculate();
          setState(() {

          });
        },
        child: SingleChildScrollView(

          padding: EdgeInsets.all(10.0),

          child: new Column(




          children: <Widget>[
            Card(
              elevation: 4.0,
              //color: Constant.mandatoryColor,
              child: new ListTile(
                  title: new Text(Constant.labelCustName),
                  subtitle: new Text(
                      "${customerName != null ? customerName : ""} ${customerNo != null ? customerNo : ""}"),
                  onTap: () => getCustomerNumber()),
            ),
            Card(
              elevation: 4.0,
              // color: Constant.mandatoryColor,
              child: new ListTile(
                  title: new Text(Constant.labelProdName),
                  subtitle: new Text(
                      "${productName != null ? productName : ""} ${productNo != null ? productNo : ""}"),
                  onTap: () => getProduct()),
            ),

            new Card(
              child: new ListTile(
                  title: new Text(
                      Translations.of(context).text('min_max_month')),
                  subtitle: canApplyMinMonth == null ||
                      canApplyMaxMonth == null
                      ? new Text("")
                      : new Text(
                      "${canApplyMinMonth}  -  ${canApplyMaxMonth}")),
            ),


            new Card(
              child: new ListTile(
                  title: new Text(
                      Translations.of(context).text('min_max_depAmt')),
                  subtitle: canApplyMinMonth == null ||
                      canApplyMaxMonth == null
                      ? new Text("")
                      : new Text(
                      "${canApplyMinDepAmt}  -  ${canApplyMaxDepAmt}")),
            ),

            Card(
              elevation: 4.0,
              // color: Constant.mandatoryColor,
              child: new TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Please Enter Amount',
                  labelText: 'Amount',
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
                onSaved: (String value) {
                  print("value is " + value);
                  if (value.isNotEmpty &&
                      value != "" &&
                      value != null &&
                      value != 'null') {
                    _newTermDepositBean.mmainbalfcy =
                        double.parse(amountController.text);
                  }
                },
              ),
            ),



            Card(
              elevation: 4.0,
              //  color: Constant.mandatoryColor,
              child: new ListTile(
                title: new Text(Constant.labelRateOfInterest),
                subtitle:
//
                new Text(

                    _newTermDepositBean.mintrate!=null?_newTermDepositBean.mintrate.toString():"0.0"),
                /* _newTermDepositBean.mintrate == null
                    ? new Text("")
                    : new Text("${_newTermDepositBean.mintrate}"),*/ //TODO for Rate of Interest
                //                  onTap: () => getCustomerNumber()
              ),
            ),

            Card(
              elevation: 4.0,
              // color: Constant.mandatoryColor,
              child:    new Container(
                padding: EdgeInsets.only(left: 15.0, bottom: 10.0, top: 10.0),
                decoration: BoxDecoration(
                  //color: Constant.mandatoryColor,
                  ),
                child: new Column(
                  children: <Widget>[

                    new Container(
                      decoration: BoxDecoration(),
                      child: new Row(
                        children: <Widget>[
                          new Container(
                            width: 50.0,
                            child: new TextField(
                                decoration: InputDecoration(hintText: "DD"),
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
                                        certDt = certDt.replaceRange(0, 2, val);
                                        FocusScope.of(context).requestFocus(monthFocus);
                                      } else {
                                        certDt =
                                            certDt.replaceRange(0, 2, "0" + val);
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
                                hintText: "MM",
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
                                      certDt = certDt.replaceRange(3, 5, val);

                                      FocusScope.of(context).requestFocus(yearFocus);
                                    } else {
                                      certDt =
                                          certDt.replaceRange(3, 5, "0" + val);
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
                                hintText: "YYYY",
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
                                  certDt = certDt.replaceRange(6, 10, val);
                              },
                              ),
                            ),
                          SizedBox(
                            width: 30.0,
                          ),
                          IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () {
                                _selectCertDtDate(context);
                              })
                        ],
                        ),
                      ),
                  ],
                  ),
                ),
            ),
            Card(
                elevation: 4.0,
                // color: Constant.mandatoryColor,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  // decoration: BoxDecoration(color: Constant.mandatoryColor),
                  child: new Row(
                    children: <Widget>[
                      Text(
                        Constant.tenure,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      new Container(
                        margin: EdgeInsets.only(left: 20.0),
                        width: 100.0,
                        child: new TextField(
                          controller:_newTermDepositBean.mnoofmonths != null
                              ? TextEditingController(
                              text: _newTermDepositBean.mnoofmonths.toString())
                              : TextEditingController(text: ""),

                          onChanged: (String value) {
                            //try {


                              print("certdat ${certDt} ");
                              print(_newTermDepositBean.mmatdate);
                              DateTime formattedLoanDisbDtDate = DateTime.parse(certDt.substring(6) +
                                  "-" +
                                  certDt.substring(3, 5) +
                                  "-" +
                                  certDt.substring(0, 2));

                              _newTermDepositBean.mcertdate = formattedLoanDisbDtDate;

                              print("certification date after parsing ${_newTermDepositBean.mcertdate}");
                              _newTermDepositBean.mnoofmonths = int.parse(value);
                              selectedMonths = int.parse(value);
                              if(_newTermDepositBean.mnoofdays==null){
                                selectedDays = 0;
                                _newTermDepositBean.mnoofdays = 0;
                              }
                              if(_newTermDepositBean.mcertdate!=null){
                                _newTermDepositBean.mmatdate = _newTermDepositBean.mcertdate.add(Duration(days:getSelectedDays()));
                              }
                              print("Maturity date is ${_newTermDepositBean.mmatdate}");
                              if(value!=null&&value.length>1){
                                setState(() {


                                  print(" maturity date is ${_newTermDepositBean.mmatdate}");
                                });
                              }


                            //} catch (_) {

                             //if(selected_months!=null) showMessage("Enter Correct Certficate Date First");
                              //print("yhan fata");
                            //}
                          },
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                                borderSide:
                                new BorderSide(color: Colors.teal)),
                            hintText: 'Months',
                            labelText: 'Months',
                          ),
                        ),
                      ),
                      new Container(
                        width: 100.0,
                        margin: EdgeInsets.only(left: 20.0),
                        child:  new TextFormField(
                          controller:_newTermDepositBean.mnoofdays != null
                              ? TextEditingController(
                              text: _newTermDepositBean.mnoofdays.toString())
                              : TextEditingController(text: ""),

                          onSaved: (String value) {

                            try {
                              DateTime formattedLoanDisbDtDate = DateTime.parse(certDt.substring(6) +
                                  "-" +
                                  certDt.substring(3, 5) +
                                  "-" +
                                  certDt.substring(0, 2));
                              _newTermDepositBean.mcertdate=formattedLoanDisbDtDate;


                              if(_newTermDepositBean.mnoofmonths==null){
                                selectedDays = 0;
                                _newTermDepositBean.mnoofmonths = 0;
                              }
                              _newTermDepositBean.mnoofdays = int.parse(value);
                              selectedDays = _newTermDepositBean.mnoofdays;

                            } catch (_) {

                              //if(selectedDays!=null) showMessage("Enter Correct Certficate Date First");
                            }
                          },
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                                borderSide:
                                new BorderSide(color: Colors.teal)),
                            hintText: 'Days',
                            labelText: 'Days',
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            Card(
              elevation: 4.0,
              // color: Constant.mandatoryColor,
              child: new ListTile(
                title: new Text(Constant.labelMaturityDate),
                subtitle:
//                  new Text("${customerName} ${customerNo}"),

                    new Text(


                      _newTermDepositBean.mmatdate!=null&&_newTermDepositBean.mmatdate!='null'?formatter.format(_newTermDepositBean.mmatdate):''
                  ,
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ),

            Container(

              child: new DropdownButtonFormField(
                value: sourceOfFunds,
                items: generateDropDown(0),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 0);
                },
                validator: (args) {
                  print(args);
                },
                //  isExpanded: true,
                //hint:Text("Select"),
                decoration: InputDecoration(
                    labelText:
                    Translations.of(context).text("sourceOfFund")),
                // style: TextStyle(color: Colors.grey),
              ),
            ),


            Container(

              child: new DropdownButtonFormField(
                value: noticeType,
                items: generateDropDown(1),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 1);
                },
                validator: (args) {
                  print(args);
                },
                //  isExpanded: true,
                //hint:Text("Select"),
                decoration: InputDecoration(
                    labelText:
                    Translations.of(context).text("noticeType")),
                // style: TextStyle(color: Colors.grey),
              ),
            ),












          ]
          )
        ),
      ),



    );
  }

  proceed() async {



    _newTermDepositBean.mlbrcode = branch;
    if (_newTermDepositBean.mrefno == null ||
        _newTermDepositBean.mrefno == 'null') {
      _newTermDepositBean.mrefno = 0;
    }
    _newTermDepositBean.mlastrepaydate = DateTime.now();
    _newTermDepositBean.mcreateddt = DateTime.now();
    _newTermDepositBean.mcreatedby = username;
    _newTermDepositBean.mlastupdatedt = DateTime.now();
    _newTermDepositBean.mlastupdateby = username;
    _newTermDepositBean.mgeolocation = geoLocation;
    _newTermDepositBean.mgeolatd = geoLatitude;
    _newTermDepositBean.mgeologd = geoLongitude;
    _newTermDepositBean.mlongname = customerName;
    _newTermDepositBean.mcrs = username;
    _newTermDepositBean.mprdacctid = "";



    print("Certification date is ${_newTermDepositBean.mcertdate}");

    await AppDatabase.get()
        .updateTermDepositMaster(_newTermDepositBean)
        .then((val) {
      print("val here is " + val.toString());
    });
    _successfulSubmit();
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
                  Text('Done'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future getCustomerNumber() async {

    var customerdata;
    customerdata = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => CustomerList(
                /*globals.isMemberOfGroup*/
                globals.isMemeberOfGroupForColl,
                "Loan collection")));
    if (customerdata != null) {
      customerNo =
          customerdata.mcustno != null ? customerdata.mcustno.toString() : "0";
      customerName = customerdata.mlongname;
      _newTermDepositBean.mcustno = int.parse(customerNo);
      _newTermDepositBean.mnametitle = customerdata.mnametitle;
    }
  }

  Future getProduct() async {
    ProductBean prodObj = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForProductSelection(20,0),
          // TODO for merging passing 30
          fullscreenDialog: true,
        ));

    if(prodObj!=null){
      productName = prodObj.mname;
      productNo = prodObj.mprdCd.toString();
      _newTermDepositBean.mprdcd = productNo;

      await AppDatabase.get().getParameterForProduct(productNo,branch).then((TDParameterBean tdParamBean){

        if(tdParamBean!=null){
          canApplyMinMonth = tdParamBean.mminperiod;
          canApplyMaxMonth = tdParamBean.mmaxperiod;
          canApplyMinDepAmt = tdParamBean.mmindepamt;
          canApplyMaxDepAmt = tdParamBean.mmaxdepamt;
        }

      });
      setState(() {

      });
    }

  }


  showDropDown(LookupBeanData selectedObj, int no) {
    print("selected Obj is ${selectedObj}");
    if (selectedObj.mcodedesc.isEmpty) {
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          sourceOfFunds = blankBean;
          break;
        case 1:
          noticeType = blankBean;
          break;
        default:
          break;
      }
      setState(() {});
    } else {
      bool isBreak = false;
      for (int k = 0;
          k < globals.dropdownCaptionsValuesModeOfPayout[no].length;
          k++) {
        if (globals.dropdownCaptionsValuesModeOfPayout[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesModeOfPayout[no][k]);
          isBreak = true;
          break;
        }
        if (isBreak) {
          break;
        }
      }
    }
  }

  LookupBeanData blankBean =
      new LookupBeanData(mcodedesc: "", mcode: "", mcodetype: 0);

  setValue(int no, LookupBeanData value) {
    print("value is ${value}");
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          sourceOfFunds = value;
          _newTermDepositBean.msourceoffunds = int.parse(value.mcode);
          break;

        case 1:
          noticeType = value;
          _newTermDepositBean.mnoticetype = int.parse(value.mcode);
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
    bean.mcode = "";
    bean.mcodetype = 0;
    mapData.add(blankBean);
    for (int k = 0;
        k < globals.dropdownCaptionsValuesModeOfPayout[no].length;
        k++) {
      mapData.add(globals.dropdownCaptionsValuesModeOfPayout[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      print("data here is of  dropdownwale biayajai " + value.mcodedesc);
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

// for validation in text field for mandatory check
  bool validateSubmit() {

    String error = "";

    if(!(_newTermDepositBean.mprdacctid==null||
        _newTermDepositBean.mprdacctid.trim()=="null"||
        _newTermDepositBean.mprdacctid.trim()==""|| _newTermDepositBean.mprdacctid.trim()=="0"
    )){

      _showAlert("Cannot Modilfy", "Once PRD ACC ID is there cannot modify ");
      return false;
    }

    print("inside validate" + _newTermDepositBean.mcertdate.toString());
    if (_newTermDepositBean.mmainbalfcy == "" ||
        _newTermDepositBean.mmainbalfcy == null) {
      _showAlert("Please Enter Amount", "It is Mandatory");
      return false;
    }
    /*if (_newTermDepositBean.mmodeofdeposit == "" ||
        _newTermDepositBean.mmodeofdeposit == null) {
      _showAlert("Please select Mode of Payment", "It is Mandatory");
      return false;
    }*/

    if (_newTermDepositBean.mcustno == "" ||
        _newTermDepositBean.mcustno == null) {
      _showAlert("Please Select Customer", "It is Mandatory");
      return false;
    }
    if (_newTermDepositBean.mprdcd == "" ||
        _newTermDepositBean.mprdcd == null||_newTermDepositBean.mprdcd == "0") {
      _showAlert("Please select Product", "It is Mandatory");
      return false;
    }
    if (_newTermDepositBean.mnoofmonths == "" ||
        _newTermDepositBean.mnoofmonths == null) {
      _showAlert("Please select Months", "It is Mandatory");
      return false;
    }
    if (_newTermDepositBean.mnoofdays == "" ||
        _newTermDepositBean.mnoofdays == null) {
      _showAlert("Please select Days", "It is Mandatory");
      return false;
    }

    DateTime formattedLoanDisbDtDate;
    try{
       formattedLoanDisbDtDate = DateTime.parse(certDt.substring(6) +
          "-" +
          certDt.substring(3, 5) +
          "-" +
          certDt.substring(0, 2));
    }catch(_){
      _showAlert("Please select Certificate Date", "It is Mandatory");
      return false;
    }


    _newTermDepositBean.mcertdate = formattedLoanDisbDtDate;
    _newTermDepositBean.mmatdate = _newTermDepositBean.mcertdate.add(Duration(days:getSelectedDays()));
    if (_newTermDepositBean.mcertdate == "" ||
        _newTermDepositBean.mcertdate == null) {
      _showAlert("Please select Certificate Date", "It is Mandatory");
      return false;
    }


    if(_newTermDepositBean.mmainbalfcy!=null&&_newTermDepositBean.mmainbalfcy<canApplyMinDepAmt){
    _showAlert(Translations.of(context).text('appliedAmount'), Translations.of(context).text("cnntBeLessMinAmt"));
    return false;
    }


    if(_newTermDepositBean.mmainbalfcy!=null&&_newTermDepositBean.mmainbalfcy>canApplyMaxDepAmt){
      _showAlert(Translations.of(context).text('appliedAmount'), Translations.of(context).text("cnntBeGreatMaxAmt"));
      return false;
    }
    if(_newTermDepositBean.msourceoffunds==null||_newTermDepositBean.msourceoffunds==0){
      _showAlert(Translations.of(context).text('sourceOfFund'), Translations.of(context).text("It is Mandatory"));
      return false;
    }

    if(_newTermDepositBean.mnoticetype==null||_newTermDepositBean.mnoticetype==0){
      _showAlert(Translations.of(context).text('noticeType'), Translations.of(context).text("It is Mandatory"));
      return false;
    }



    return true;
  }


  Future<Null> _selectCertDtDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _newTermDepositBean.mcertdate)
      setState(() {
        _newTermDepositBean.mcertdate = picked;
        if (picked.day.toString().length == 1) {
          tempDay = "0" + picked.day.toString();
        } else
          tempDay = picked.day.toString();
        certDt = certDt.replaceRange(0, 2, tempDay);
        tempYear = picked.year.toString();
        certDt = certDt.replaceRange(6, 10, tempYear);
        if (picked.month.toString().length == 1) {
          tempMonth = "0" + picked.month.toString();
        } else
          tempMonth = picked.month.toString();
        certDt = certDt.replaceRange(3, 5, tempMonth);
      });

  }

  calculate() async {




    try {
      DateTime formattedLoanDisbDtDate = DateTime.parse(certDt.substring(6) +
          "-" +
          certDt.substring(3, 5) +
          "-" +
          certDt.substring(0, 2));
      _newTermDepositBean.mcertdate=formattedLoanDisbDtDate;



    } catch (e) {
      print("date Exception");
    }

    if (sysParam == 0) {
      if (_newTermDepositBean.mmainbalfcy != null &&
          _newTermDepositBean.mmainbalfcy > 0){
        await AppDatabase.get()
            .getTDRateOfInterestTenure(
            _newTermDepositBean.mmainbalfcy )
            .then((onValue) {
              print(onValue);
              _newTermDepositBean.mintrate = onValue;

        });
      }
    } else {
      if (_newTermDepositBean.mnoofdays != null &&
              _newTermDepositBean.mnoofdays > 0 ||
          (_newTermDepositBean.mnoofmonths != null &&
              _newTermDepositBean.mnoofmonths > 0) ||
          (_newTermDepositBean.mmainbalfcy != null &&
              _newTermDepositBean.mmainbalfcy > 0)) {
        await AppDatabase.get()
            .getTDRateOfInterestTenureAndAmount(
            _newTermDepositBean.mnoofdays,
            _newTermDepositBean.mnoofmonths,
            _newTermDepositBean.mmainbalfcy)
            .then((onValue) {
          print(onValue);
          _newTermDepositBean.mintrate = onValue;


        });
      }
    }
    setState(() {

    });
  }



  int getSelectedDays(){

    int totalDays = 0;
    DateTime todaysDate  = DateTime.now();

    int alreadyDays = int.parse(tempDay);
    int alreadyMoth = int.parse(tempMonth);
    print("selectedMonths is $selectedMonths");

    try {
      DateTime formattedLoanDisbDtDate = DateTime.parse(certDt.substring(6) +
          "-" +
          certDt.substring(3, 5) +
          "-" +
          certDt.substring(0, 2));
      _newTermDepositBean.mcertdate=formattedLoanDisbDtDate;



    } catch (e) {
      print("date Exception");
    }

    DateTime tempDate = _newTermDepositBean.mcertdate.subtract(Duration(days: alreadyDays));
      int i = 0;
    for(i=0;i<selectedMonths;i++){

      if(alreadyMoth==13)alreadyMoth = 1;

      print("For i = $i already month is $alreadyMoth and days is $totalDays");

      if(alreadyMoth!=2){
        switch(alreadyMoth){
          case 1:
            totalDays+=31;
            tempDate= tempDate.add(Duration(days: 31));
            break;
          case 3:
            totalDays+=31;
            tempDate=tempDate.add(Duration(days: 31));
            break;
          case 4:
            totalDays+=30;
            tempDate=tempDate.add(Duration(days: 30));
            break;
          case 5:
            totalDays+=31;
            tempDate=tempDate.add(Duration(days: 31));
            break;
          case 6:
            totalDays+=30;
            tempDate=tempDate.add(Duration(days: 30));
            break;
          case 7:
            totalDays+=31;
            tempDate=tempDate.add(Duration(days: 31));
            break;
          case 8:
            totalDays+=31;
            tempDate=tempDate.add(Duration(days: 31));
            break;
          case 9:
            totalDays+=30;
            tempDate=tempDate.add(Duration(days: 30));
            break;
          case 10:
            print("Case 10");
            totalDays+=31;
            tempDate=tempDate.add(Duration(days: 31));
            break;
          case 11:
            totalDays+=30;
            tempDate=tempDate.add(Duration(days: 30));
            break;
          case 12:
            totalDays+=31;
            tempDate=tempDate.add(Duration(days: 31));
            break;

        }



      }else if(alreadyMoth==2){
        print("Tepm Date is $tempDate");
        int year  = tempDate.year;
        print("year is  $year");
        int yearByFourRem = year%4;
        int yearByHundredRem = year%100;
        int yearByFourHundredRem = year%400;
        if(yearByFourRem==0){

          if(yearByHundredRem==0&&yearByFourHundredRem!=0){
            totalDays+=28;
            tempDate=tempDate.add(Duration(days: 28));

          }
          else {
            totalDays+=29;
            print("Adding 29 days to $tempDate");
            tempDate=tempDate.add(Duration(days: 29));



          }


        }else{
          totalDays+=28;
          tempDate=tempDate.add(Duration(days: 28));

        }
      }
      alreadyMoth +=1;
    }


    if(selectedDays!=null&&selectedDays!=0)totalDays+=selectedDays;
    return totalDays;

  }



  void showMessage(String message, [MaterialColor color = Colors.grey]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: color != null ? color : null,
        content: new Text(message)));
  }



}
