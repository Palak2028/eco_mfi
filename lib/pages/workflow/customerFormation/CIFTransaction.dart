import 'dart:async';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/FPSPages/BiometricCheck.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/PostCIFWithdrawalToOmni.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/PostCIFTranstnToOmni.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CIFTransaction extends StatefulWidget {
  final CIFBean cifBeanPassedObject;
  int transactionType;

  CIFTransaction(this.cifBeanPassedObject, this.transactionType);

  @override
  _CIFTransactionState createState() => new _CIFTransactionState();
}

class _CIFTransactionState extends State<CIFTransaction> {
  bool isDataSynced = false;
  bool circIndicatorIsDatSynced = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  CIFBean cifBeanObj = new CIFBean();
  LookupBeanData narration;
  Utility obj = new Utility();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  List<CIFBean> cifBean;
  SharedPreferences prefs;
  String username;
  bool circInd = false;
  int lbrCd;
  double withdrwlLimitAmt;
  int isBiometricNeeded = 0;
  String mIsCustomerSelected = "Y";
  bool declCheckBox = false;
  CustomerListBean customerListBean = null;
  double loanPaymntAmt = 0.0;
  String customerName;
  String nrcNo;
  double totBal = 0.0;
  String transactionRef;
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  double loanPaymntAmt = 0.0;

  @override
  void initState() {
    super.initState();

    if (widget.cifBeanPassedObject != null) {
      cifBeanObj.mprdacctid = widget.cifBeanPassedObject.mprdacctid;
      cifBeanObj.mlbrcode = widget.cifBeanPassedObject.mlbrcode;
      cifBeanObj.mactualtotalbal = widget.cifBeanPassedObject.mactualtotalbal;
      cifBeanObj.mlienamt = widget.cifBeanPassedObject.mlienamt;
      withdrwlLimitAmt = double.parse(
          (cifBeanObj.mactualtotalbal - cifBeanObj.mlienamt)
              .toStringAsFixed(2));
      cifBeanObj.mcustno = widget.cifBeanPassedObject.mcustno;
<<<<<<< .mine
      cifBeanObj.mprinccurrdue = widget.cifBeanPassedObject.mprinccurrdue;
      cifBeanObj.mprincoverdue = widget.cifBeanPassedObject.mprincoverdue;
      cifBeanObj.mintdue = widget.cifBeanPassedObject.mintdue;
      loanPaymntAmt = double.parse((cifBeanObj.mprinccurrdue + cifBeanObj.mprincoverdue + cifBeanObj.mintdue).toStringAsFixed(2));
      if (widget.transactionType == 3){
        cifBeanObj.mamt = loanPaymntAmt;
      }
=======

      cifBeanObj.mprinccurrdue = widget.cifBeanPassedObject.mprinccurrdue;
      cifBeanObj.mprincoverdue = widget.cifBeanPassedObject.mprincoverdue;
      cifBeanObj.mintdue = widget.cifBeanPassedObject.mintdue;
      loanPaymntAmt = double.parse((cifBeanObj.mprinccurrdue +
              cifBeanObj.mprincoverdue +
              cifBeanObj.mintdue)
          .toStringAsFixed(2));
      if (widget.transactionType == 3) {
        cifBeanObj.mamt = loanPaymntAmt;
      }
      customerName = widget.cifBeanPassedObject.mlongname;
      nrcNo = widget.cifBeanPassedObject.mpannodesc;
      totBal = widget.cifBeanPassedObject.mactualtotalbal;
>>>>>>> .r1143
      print("cifBeanObj.mcustno ${cifBeanObj.mcustno}");
      print("obj is ${cifBeanObj}");
    }

    getSessionVariables();

    List tempDropDownValues = new List();
    tempDropDownValues.add(cifBeanObj.mnarration);
    print(cifBeanObj.mnarration);
    for (int k = 0; k < globals.dropdownCaptionsValuesCif.length; k++) {
      for (int i = 0; i < globals.dropdownCaptionsValuesCif[k].length; i++) {
        print("k and i is $k $i");
        print(globals.dropdownCaptionsValuesCif[k][i].mcode.length);
        try {
          if (globals.dropdownCaptionsValuesCif[k][i].mcode.toString() ==
              tempDropDownValues[k].toString().trim()) {
            print("matched $k");
            setValue(k, globals.dropdownCaptionsValuesCif[k][i]);
          }
        } catch (_) {
          print("Exception in dropdown");
        }
      }
    }
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString(TablesColumnFile.musrcode);
      lbrCd = prefs.getInt(TablesColumnFile.musrbrcode);
    });
    print(prefs.getString(TablesColumnFile.mIsGroupLendingNeeded));
    isBiometricNeeded = prefs.getInt(TablesColumnFile.ISBIOMETRICNEEDED);

    AppDatabase.get().getCustMrefAndTref(cifBeanObj.mcustno).then((onValue) {
      customerListBean = onValue;
      print("mcustno " + cifBeanObj.mcustno.toString());
      print("customerListBean " + customerListBean.toString());
      print("mref ${customerListBean.mrefno}");
      print("tref ${customerListBean.trefno}");
    });
  }

  showDropDown(LookupBeanData selectedObj, int no) {
    if (selectedObj.mcodedesc.isEmpty) {
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          narration = blankBean;
          cifBeanObj.mnarration = blankBean.mcode;
          break;
        default:
          break;
      }
      setState(() {});
    } else {
      for (int k = 0; k < globals.dropdownCaptionsValuesCif[no].length; k++) {
        if (globals.dropdownCaptionsValuesCif[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesCif[no][k]);
        }
      }
    }
  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          narration = value;
          cifBeanObj.mnarration = value.mcode;
          break;
        default:
          break;
      }
    });
  }

  LookupBeanData blankBean =
      new LookupBeanData(mcodedesc: "", mcode: "", mcodetype: 0);

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0; k < globals.dropdownCaptionsValuesCif[no].length; k++) {
      mapData.add(globals.dropdownCaptionsValuesCif[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(
          value.mcodedesc,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
      );
    }).toList();
    return _dropDownMenuItems1;
  }

  String formatPrdAccId(String prdaccid) {
    try {
      String newprdaccid = int.parse(prdaccid.substring(8, 16)).toString() +
          "/" +
          prdaccid.substring(0, 8).toString().trim() +
          "/" +
          int.parse(prdaccid.substring(16, 24)).toString();
      return newprdaccid;
    } catch (_) {
      print("Error in formatting prdAccId");
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: new Text("Transaction"),
        backgroundColor: Color(0xff07426A),
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
          setState(() {});
        },
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            new Container(
              height: 20.0,
            ),
            new Card(
              child: new ListTile(
                title: new Text("PrdAccId"),
                subtitle: cifBeanObj.mprdacctid == null
                    ? new Text("")
                    : new Text(formatPrdAccId(cifBeanObj.mprdacctid)),
              ),
            ),
            new Card(
              child: new ListTile(
                  title: new Text("Transaction type"),
                  subtitle: widget.transactionType == 1
                      ? new Text("Withdrawal")
                      : widget.transactionType == 2
                          ? new Text("Deposit")
                          : widget.transactionType == 3
                              ? new Text("INSTALPAY")
                              /*: widget.transactionType == 4
                    ? new Text("Closure")*/
                              : new Text("")),
            ),
            widget.transactionType == 1
                ? new Card(
                    child: new ListTile(
                      title: new Text("Withdrawal Limit"),
                      subtitle: new Text(withdrwlLimitAmt.toString()),
                    ),
                  )
                : new Text(""),
            Card(
                child: new TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Amount',
                      labelText: 'Amount',
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
                        cifBeanObj.mamt == null ? "" : "${cifBeanObj.mamt}",
                    onSaved: (String value) {
                      if (value.isNotEmpty &&
                          value != "" &&
                          value != null &&
                          value != 'null') {
                        try {
                          cifBeanObj.mamt = double.parse(value);
                        } catch (_) {}
                      }
                    })),
            Container(
              padding: const EdgeInsets.only(left: 20.0),
              child: new DropdownButtonFormField(
                value: narration,
                items: generateDropDown(0),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 0);
                },
                validator: (args) {
                  print(args);
                },
                decoration: InputDecoration(
                    labelText: globals.dropdownCaptionsCifDetails[0]),
              ),
            ),
            Card(
                child: new TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'User Narration',
                      labelText: 'User Narration',
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
                    initialValue: cifBeanObj.mremark == null
                        ? ""
                        : "${cifBeanObj.mremark}",
                    onSaved: (String value) {
                      if (value.isNotEmpty &&
                          value != "" &&
                          value != null &&
                          value != 'null') {
                        cifBeanObj.mremark = value;
                      }
                    })),
            widget.transactionType == 1
                ? isBiometricNeeded == 0
                    ? new Container()
                    : new Text(
                        "Biometric Check",
                        textAlign: TextAlign.center,
                      )
                : new Text(""),
            widget.transactionType == 1
                ? isBiometricNeeded == 0
                    ? new Container()
                    : new FingerScannerImageAsset(
                        mIsCustomerSelected: mIsCustomerSelected,
                        mrefno: customerListBean.mrefno,
                        trefno: customerListBean.trefno,
                        custno: cifBeanObj.mcustno,
                        isOnline: true,
                      )
                : new Text(""),
            widget.transactionType == 1
                ? isBiometricNeeded == 0
                    ? new Container()
                    : new CheckboxListTile(
                        value: declCheckBox,
                        title: new Text(
                            "I declare that i want to override the biometric result."),
                        onChanged: (val) {
                          setState(() {
                            declCheckBox = val;
                          });
                        })
                : new Text(""),
            new Container(
              height: 20.0,
            ),
            widget.transactionType == 1
                ? (declCheckBox == true && isBiometricNeeded == 1) ||
                        (declCheckBox == false && isBiometricNeeded == 0)
                    ? FloatingActionButton.extended(
                        icon: Icon(Icons.assignment_turned_in),
                        backgroundColor: Color(0xff07426A),
                        label: Text("Post Transaction"),
                        onPressed: () async {
                          proceedwithdrawal(cifBeanObj);
                        })
                    : FloatingActionButton.extended(
                        icon: Icon(Icons.assignment_turned_in),
                        backgroundColor: Color(0xff07426A),
                        label: Text("Post Transaction"),
                        onPressed: () {
                          Toast.show(
                              "Please do the BIOMETRIC OR ACCEPT the declaration to ENABLE the SAVE BUTTON!",
                              context);
                        })
                : FloatingActionButton.extended(
                    icon: Icon(Icons.assignment_turned_in),
                    backgroundColor: Color(0xff07426A),
                    label: Text("Post Transaction"),
                    onPressed: () async {
                      proceed(cifBeanObj);
                    }),
            new Container(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showAlert(arg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$arg'),
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

  void showMessageWithoutProgress(String message,
      [MaterialColor color = Colors.red]) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  Future<void> proceed(CIFBean cifBeanObj) async {
    if (cifBeanObj.mamt == "" ||
        cifBeanObj.mamt == null ||
        cifBeanObj.mamt == 0) {
      _showAlert("Please Enter Amount for Transaction");
      return false;
    }

    if (cifBeanObj.mremark == "" ||
        cifBeanObj.mremark == null ||
        cifBeanObj.mremark == 0) {
      _showAlert("Please Enter User Narration");
      return false;
    }

    Future<bool> onPop(BuildContext context, String agrs1, String args2,
        String pageRoutedFrom) {
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
                    circInd = true;
                    _ShowProgressInd(context);
                    cifBeanObj.mcreatedby = username;

                    setState(() {
                      isDataSynced = true;
                      circIndicatorIsDatSynced = true;
                    });

                    PostCIFTranstnToOmni postCIFTranstnToOmni =
                        new PostCIFTranstnToOmni();
                    postCIFTranstnToOmni
                        .trySave(cifBeanObj)
                        .then((List<CIFBean> cifBean) async {
                      this.cifBean = cifBean;
                      print("cifBean" + cifBean.toString());

                      bool netAvail = false;
                      netAvail = await obj.checkIfIsconnectedToNetwork();
                      if (netAvail == false) {
                        showMessageWithoutProgress("Network Not available");
                        return;
                      } else {
                        transactionRef = cifBean[0].momnitxnrefno;
                        if (cifBean[0].momnitxnrefno == null ||
                            cifBean[0].momnitxnrefno == "null" ||
                            cifBean[0].momnitxnrefno == "") {
                          _CheckIfThere(cifBean[0].merror);
                          circInd = false;
                        } else {
                          _successfulSubmit(cifBean[0].momnitxnrefno);
                          circInd = false;
                        }
                      }
                    });
                  },
                  child: new Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    onPop(
        context,
        Translations.of(context).text('Are_You_Sure'),
        Translations.of(context).text('Do_You_Want_To_Proceed'),
        Translations.of(context).text('CollectionSubmit'));
  }

  Future<void> proceedwithdrawal(CIFBean cifBeanObj) async {
    if (declCheckBox == true)
      cifBeanObj.misbiometricdeclareflagyn = "Y";
    else
      cifBeanObj.misbiometricdeclareflagyn = "N";

<<<<<<< .mine
    if (declCheckBox == true)
      cifBeanObj.misbiometricdeclareflagyn = "Y";
    else
      cifBeanObj.misbiometricdeclareflagyn = "N";
    if (cifBeanObj.mamt == "" || cifBeanObj.mamt == null || cifBeanObj.mamt == 0)
    {
=======
    if (cifBeanObj.mamt == "" ||
        cifBeanObj.mamt == null ||
        cifBeanObj.mamt == 0) {
>>>>>>> .r1143
      _showAlert("Please Enter Amount for Transaction");
      return false;
    }

    if (cifBeanObj.mamt > withdrwlLimitAmt) {
      _showAlert("Cannot withdraw more than withdrawal limit");
      return false;
    }

    if (cifBeanObj.mremark == "" ||
        cifBeanObj.mremark == null ||
        cifBeanObj.mremark == 0) {
      _showAlert("Please Enter User Narration");
      return false;
    }

    Future<bool> onPop(BuildContext context, String agrs1, String args2,
        String pageRoutedFrom) {
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
                    circInd = true;
                    _ShowProgressInd(context);
                    cifBeanObj.mcreatedby = username;

                    setState(() {
                      isDataSynced = true;
                      circIndicatorIsDatSynced = true;
                    });

                    PostCIFWithdrawalToOmni postCIFWithdrawalToOmni =
                        new PostCIFWithdrawalToOmni();
                    postCIFWithdrawalToOmni
                        .trySave(cifBeanObj)
                        .then((List<CIFBean> cifBean) async {
                      this.cifBean = cifBean;
                      print("cifBean" + cifBean.toString());

                      bool netAvail = false;
                      netAvail = await obj.checkIfIsconnectedToNetwork();
                      if (netAvail == false) {
                        showMessageWithoutProgress("Network Not available");
                        return;
                      } else {
                        transactionRef = cifBean[0].momnitxnrefno;
                        if (cifBean[0].momnitxnrefno == null ||
                            cifBean[0].momnitxnrefno == "null" ||
                            cifBean[0].momnitxnrefno == "") {
                          _CheckIfThere(cifBean[0].merror);
                          circInd = false;
                        } else {
                          _successfulSubmit(cifBean[0].momnitxnrefno);
                          circInd = false;
                        }
                      }
                    });
                  },
                  child: new Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    onPop(
        context,
        Translations.of(context).text('Are_You_Sure'),
        Translations.of(context).text('Do_You_Want_To_Proceed'),
        Translations.of(context).text('CollectionSubmit'));
  }

  Future<void> _CheckIfThere(error) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.cancel,
              color: Colors.red,
              size: 40.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(error),
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

  Future<void> _successfulSubmit(omnitxnrefno) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 40.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Transaction Posted Successfully , Please Note OMNITxnNo - ' +
                          omnitxnrefno),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('print '),
                onPressed: () {
                  _callChannelWthdrwDpstPrint();
                },
              ),
            ],
          );
        });
  }

  Future<void> _ShowProgressInd(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translations.of(context).text('Please_Wait')),
          content:
              SingleChildScrollView(child: SpinKitCircle(color: Colors.teal)),
        );
      },
    );
  }

  _callChannelWthdrwDpstPrint() async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    var now = new DateTime.now();
    var formatterDate = new DateFormat('dd-MM-yyyy');
    var formatterTime = new DateFormat('H:m:s');
    var curDate = formatterDate.format(now);
    var curTime = formatterTime.format(now);
    String trnasactionType = "";

    if (widget.transactionType == 1) {
      trnasactionType = "Withdrawal";
    } else if (widget.transactionType == 2) {
      trnasactionType = "Deposit";
    }

    try {
      final String result =
          await platform.invokeMethod("withdrawlDepositPrint", {
        "BluetoothADD": bluetootthAdd,
        "date": curDate,
        "TransactionTime": curTime,
        "VoluntaryCompulsorySavingAC": cifBeanObj.mprdacctid,
        "CustomerName": customerName,
        "TransactionReference": transactionRef,
        "CustomerNRCNo": nrcNo,
        "DepositWithdrawalAmount": cifBeanObj.mamt.toString(),
        "TotalBalance": totBal.toString(),
        "ContactPhoneNo": "132",
        "LoanOfficers": username,
        "TransactionType": trnasactionType,
        "company": "fullerton" //companyName
      });
      String geTest = 'geTest at $result';
      print("FLutter : " + geTest.toString());
    } on PlatformException catch (e) {
      print("FLutter : " + e.message.toString());
    }
  }
}
