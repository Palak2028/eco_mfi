import 'dart:async';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFLoanClosureBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetCIFLoanClosureDetailsFromOmni.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/PostCIFLoanClosureTranstnToOmni.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFBean.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';


class CIFLoanClosure extends StatefulWidget {

  final CIFBean cifBeanPassedObject;
  String mprdaccid;
  CIFLoanClosure(this.cifBeanPassedObject);

  @override
  _CIFLoanClosureState createState() => new _CIFLoanClosureState();
}

class _CIFLoanClosureState extends State<CIFLoanClosure> {

  bool isDataSynced = false;
  bool circIndicatorIsDatSynced = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  CIFLoanClosureBean cifLoanClosureObj = new CIFLoanClosureBean();
  LookupBeanData paymntmode;
  Utility obj = new Utility();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  List<CIFLoanClosureBean> cifLoanClosureBean;
  SharedPreferences prefs;
  String username;
  bool circInd = false;
  String entryDt = "__-__-____";
  String tempYear;
  String tempDay;
  String tempMonth;
  FocusNode monthFocus;
  FocusNode yearFocus;
  var formatter = new DateFormat('dd-MM-yyyy');
  String tempDate = "----/--/--";
  bool showLoanDetail = false;
  bool showPaymntDetail = false;
  String error;
  String mloandetailsgrid, mapplicationdt, mappliedamt, mapproveddt, mapprovedamt,
  mstartdt, mdisbursementdt, mdisbursementamt, minstallmentstartdt, minstallmentamt,
  minstallmentfrequency, mnoofinstallments, mrateofinterest, menddt, minsurancepremiumamt,
  msecuritydetailsgrid, msecuritydepositdt, mamtondepositcreation, mcurrentbal, mexcessbal,
  mclosuredetailsgrid, minterestaccruedtilldt, mclosurecharges, mclosureamtasondate,
  mwaiveoffamt, mamttobepaidforclosure, mtotaloutstandinggrid, mprincipalos, minterestos,
  mpenalos, motherchargesos, mtotaloutstanding, mtotalpaymentgrid, mprincipalpaid,
  minterestpaid, mpenalpaid, motherchargespaid, mnoofinslpaid, mnoofdefaults,
  mtotalpaid, mduebutnotpaidgrid, mprincipalosdue, minterestosdue, mpenalosdue,
  motherchargesosdue, mtotaldue;
  int branch;
  String mlongname= "";


  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  final dateFormat = DateFormat("yyyy/MM/dd hh:mm:ss");



  @override
  void initState() {
    super.initState();

    if (widget.cifBeanPassedObject != null) {
      cifLoanClosureObj.mprdacctid = widget.cifBeanPassedObject.mprdacctid;
      mlongname = widget.cifBeanPassedObject.mlongname;

      print("obj is ${cifLoanClosureObj}");
      cifLoanClosureObj.mlbrcode = widget.cifBeanPassedObject.mlbrcode;
      print('lbrcode in loan closure ${cifLoanClosureObj.mlbrcode}');
    }

    getSessionVariables();

    if (!entryDt.contains("_")) {
      try {
        DateTime formattedDate = DateTime.parse(entryDt);
        tempDay = formattedDate.day.toString();
        tempMonth = formattedDate.month.toString();
        tempYear = formattedDate.year.toString();
        entryDt = tempDay.toString() +"-"+tempMonth.toString()+"-"+tempYear.toString();
        setState(() {});
      } catch (e) {
        print("Exception Occupred");
      }
    }


    List tempDropDownValues =  new List();
    tempDropDownValues.add(cifLoanClosureObj.mpaymntmode);
    print(cifLoanClosureObj.mpaymntmode);
    for (int k = 0;
    k < globals.dropdownCaptionsValuesCifLoanClosure.length;
    k++) {
      for (int i = 0;
      i < globals.dropdownCaptionsValuesCifLoanClosure[k].length;
      i++) {
        print("k and i is $k $i");
        print(globals.dropdownCaptionsValuesCifLoanClosure[k][i].mcode.length);
        try{
          if (globals.dropdownCaptionsValuesCifLoanClosure[k][i].mcode.toString() ==
              tempDropDownValues[k].toString().trim()) {

            print("matched $k");
            setValue(k, globals.dropdownCaptionsValuesCifLoanClosure[k][i]);
          }
        }catch(_){
          print("Exception in dropdown");
        }
      }
    }
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString(TablesColumnFile.musrcode);
      branch = prefs.get(TablesColumnFile.musrbrcode);
    });
  }

  showDropDown(LookupBeanData selectedObj, int no) {

    if(selectedObj.mcodedesc.isEmpty){
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          paymntmode = blankBean;
          cifLoanClosureObj.mpaymntmode = 0;
          break;
        default:
          break;
      }
      setState(() {
      });
    }
    else{
      for (int k = 0;
      k < globals.dropdownCaptionsValuesCifLoanClosure[no].length;
      k++) {
        if (globals.dropdownCaptionsValuesCifLoanClosure[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesCifLoanClosure[no][k]);
        }
      }
    }
  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          paymntmode = value;
          cifLoanClosureObj.mpaymntmode = int.parse(value.mcode);
          break;
        default:
          break;
      }
    });
  }

  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);
  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
    k < globals.dropdownCaptionsValuesCifLoanClosure[no].length;
    k++) {
      mapData.add(globals.dropdownCaptionsValuesCifLoanClosure[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc,overflow: TextOverflow.ellipsis,maxLines: 3,),
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
    }
    catch (_){
      print("Error in formatting prdAccId");
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: new Text("Loan Closure"),
        backgroundColor: Color(0xff07426A),
      ),
      body:  new Form(
        key: _formKey,
        autovalidate: false,
        onWillPop: () {
          return Future(() => true);
        },
        onChanged: () async{
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
                title: new Text(Translations.of(context).text('PrdAccId')),
                subtitle: cifLoanClosureObj.mprdacctid == null
                    ? new Text("")
                    : new Text(formatPrdAccId(cifLoanClosureObj.mprdacctid)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            new Padding(
              padding: new EdgeInsets.only(left: 14.0),
              child: new
              Container(
                decoration: BoxDecoration(),
                child: new Row(
                  children: <Widget>[Text(Translations.of(context).text('Entry_Date'))],
                ),
              ),
            ),
            new Container(
              decoration: BoxDecoration(),
              child: new Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                  ),
                  new Container(
                    width: 50.0,
                    child:
                    new TextField(
                        decoration: InputDecoration(hintText: Translations.of(context).text('DD')),
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
                                entryDt = entryDt.replaceRange(0, 2, val);
                                FocusScope.of(context).requestFocus(monthFocus);
                              } else {
                                entryDt =
                                    entryDt.replaceRange(0, 2, "0" + val);
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
                        hintText: Translations.of(context).text('MM'),
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
                              entryDt = entryDt.replaceRange(3, 5, val);

                              FocusScope.of(context).requestFocus(yearFocus);
                            } else {
                              entryDt =
                                  entryDt.replaceRange(3, 5, "0" + val);
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
                        hintText: Translations.of(context).text('YYYY'),
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
                          entryDt = entryDt.replaceRange(6, 10, val);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        _selectEntryDate(context);
                      })
                ],
              ),
            ),
            new Container(
              height: 20.0,
            ),
            FloatingActionButton.extended(
                heroTag: "btn1",
                icon: Icon(Icons.assignment_turned_in),
                backgroundColor: Color(0xff07426A),
                label: Text("View Loan Closure Details"),
                onPressed: ()async{
                  circInd = true;
                  _ShowProgressInd(context);
                  proceed(cifLoanClosureObj); }
            ),
            new Container(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                if (cifLoanClosureObj.mloandetailsgrid==null)
                {
                  _showAlert("Please Click View First");
                  setState(() {
                    showLoanDetail = false;
                  });
                  //return false;
                }
                else {
                  if (showLoanDetail == false) {
                    setState(() {
                      showLoanDetail = true;
                    });
                  } else if (showLoanDetail == true) {
                    setState(() {
                      showLoanDetail = false;
                    });
                  }
                }
              },
              child: new Card(
                child: new ListTile(
                  title: new Text(
                    "Loan Details",
                    style: TextStyle(fontSize: 20.0),
                  ),

                  subtitle: showLoanDetail == true
                      ? new Table(
                    border: TableBorder.all(width: 1.0, color: Colors.black),
                    children: [
                      TableRow( children: [
                        TableCell(
                          child: new Text(" "+mloandetailsgrid.substring(3, 15),
                            style: new TextStyle(color: Colors.black),),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mloandetailsgrid),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mapplicationdt),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mapplicationdt),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mappliedamt),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mappliedamt),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mapproveddt),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mapproveddt),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "+mapprovedamt),
                            ],
                          ),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mapprovedamt),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mstartdt),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mstartdt),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mdisbursementdt),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mdisbursementdt),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mdisbursementamt),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mdisbursementamt),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+minstallmentstartdt),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.minstallmentstartdt),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+minstallmentamt),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.minstallmentamt),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+minstallmentfrequency),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.minstallmentfrequency),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mnoofinstallments),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mnoofinstallments),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mrateofinterest),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mrateofinterest),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+menddt),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.menddt),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+minsurancepremiumamt),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.minsurancepremiumamt),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+msecuritydetailsgrid.substring(3, 19),
                            style: new TextStyle(color: Colors.black),),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.msecuritydetailsgrid),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+msecuritydepositdt),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.msecuritydepositdt),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mamtondepositcreation),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mamtondepositcreation),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mcurrentbal),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mcurrentbal),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mexcessbal.substring(3,17)),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mexcessbal),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mclosuredetailsgrid.substring(3, 18),
                            style: new TextStyle(color: Colors.black),),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mclosuredetailsgrid),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+minterestaccruedtilldt),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.minterestaccruedtilldt),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mclosurecharges),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mclosurecharges),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mclosureamtasondate),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mclosureamtasondate),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mwaiveoffamt),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mwaiveoffamt),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child:
                          Text(" "+mamttobepaidforclosure,style: TextStyle(fontWeight:FontWeight.bold),),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mamttobepaidforclosure),
                            ],
                          ),
                        ),
                      ]),
                    ],
                  ) : null,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (cifLoanClosureObj.mloandetailsgrid==null)
                {
                  _showAlert("Please Click View First");
                  setState(() {
                    showPaymntDetail = false;
                  });
                  //return false;
                }
                else {
                  if (showPaymntDetail == false) {
                    setState(() {
                      showPaymntDetail = true;
                    });
                  } else if (showPaymntDetail == true) {
                    setState(() {
                      showPaymntDetail = false;
                    });
                  }
                }

              },
              child: new Card(
                child: new ListTile(
                  title: new Text(
                    "Payment Details",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  subtitle: showPaymntDetail == true
                      ? new Table(
                    border: TableBorder.all(width: 1.0, color: Colors.black),
                    children: [
                      TableRow( children: [
                        TableCell(
                          child: new Text(" "+mtotaloutstandinggrid.substring(3, 20),
                            style: new TextStyle(color: Colors.black),),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mtotaloutstandinggrid),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mprincipalos),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mprincipalos),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+minterestos),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.minterestos),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mpenalos),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mpenalos),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "+motherchargesos),
                            ],
                          ),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.motherchargesos),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mtotaloutstanding),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mtotaloutstanding),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mtotalpaymentgrid.substring(3, 16),
                            style: new TextStyle(color: Colors.black),),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mtotalpaymentgrid),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mprincipalpaid),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mprincipalpaid),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+minterestpaid),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.minterestpaid),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mpenalpaid),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mpenalpaid),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+motherchargespaid),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.motherchargespaid),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mnoofinslpaid),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mnoofinslpaid),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mnoofdefaults),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mnoofdefaults),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mtotalpaid),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mtotalpaid),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mduebutnotpaidgrid.substring(3, 19),
                            style: new TextStyle(color: Colors.black),),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mduebutnotpaidgrid),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mprincipalosdue),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mprincipalosdue),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+minterestosdue),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.minterestosdue),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mpenalosdue),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mpenalosdue),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+motherchargesosdue),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.motherchargesosdue),
                            ],
                          ),
                        ),
                      ]),
                      TableRow( children: [
                        TableCell(
                          child: Text(" "+mtotaldue),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(" "),
                              new Text(cifLoanClosureObj.mtotaldue),
                            ],
                          ),
                        ),
                      ]),
                    ],
                  ) : null,
                ),
              ),
            ),
             Card(
                child:
                new TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Remarks',
                      labelText: 'Remarks',
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black),
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
                    initialValue: cifLoanClosureObj.mremark == null
                        ? ""
                        : "${cifLoanClosureObj.mremark}",
                    onSaved: (String value) {
                      if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                        cifLoanClosureObj.mremark = value;
                      }
                    }
                )
            ),
            Container(
              padding: const EdgeInsets.only(left: 20.0),
              child: new DropdownButtonFormField(
                value: paymntmode,
                items: generateDropDown(0),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 0);
                },
                validator: (args) {
                  print(args);
                },
                decoration: InputDecoration(
                    labelText: globals.dropdownCaptionsCifLoanClosureDetails[0]),
              ),
            ),
            new Container(
              height: 20.0,
            ),
            FloatingActionButton.extended(
                heroTag: "btn2",
                icon: Icon(Icons.assignment_returned),
                backgroundColor: Color(0xff07426A),
                label: Text("Submit"),
                onPressed: ()async{ submit(cifLoanClosureObj); }
            ),
          ],
        ),
      ),
    );

  }

  Future<Null> _selectEntryDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        //initialDate: DateTime.now(),
        //firstDate: DateTime.now().subtract(Duration(days: 1)),
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != cifLoanClosureObj.mentrydate)
      setState(() {
        cifLoanClosureObj.mentrydate = picked.toString();
        tempDate = formatter.format(picked);
        if (picked.day.toString().length == 1) {
          tempDay = "0" + picked.day.toString();
        } else
          tempDay = picked.day.toString();
        entryDt = entryDt.replaceRange(0, 2, tempDay);
        tempYear = picked.year.toString();
        entryDt = entryDt.replaceRange(6, 10, tempYear);
        if (picked.month.toString().length == 1) {
          tempMonth = "0" + picked.month.toString();
        } else
          tempMonth = picked.month.toString();
        entryDt = entryDt.replaceRange(3, 5, tempMonth);
      });
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



  Future<void> proceed(CIFLoanClosureBean cifLoanClosureObj)  async{

    if (cifLoanClosureObj.mentrydate == "" || cifLoanClosureObj.mentrydate == null || cifLoanClosureObj.mentrydate == 0)
    {
      _showAlert("Please Enter Date");
      return false;
    }

    setState(() {
      /*isDataSynced = true;
      circIndicatorIsDatSynced = true;*/
    });

    GetCIFLoanClosureDetailsFromOmni getCIFLoanClosureDetailsFromOmni = new GetCIFLoanClosureDetailsFromOmni();
    await getCIFLoanClosureDetailsFromOmni.trySave(cifLoanClosureObj).then((List<CIFLoanClosureBean> cifLoanClosureBean) async {

      this.cifLoanClosureBean = cifLoanClosureBean;
      print("cifLoanClosureBean" + cifLoanClosureBean.toString());

      bool netAvail = false;
      netAvail = await obj.checkIfIsconnectedToNetwork();
      if (netAvail == false) {
        showMessageWithoutProgress("Network Not available");
        return;
      }
      else{
        for (int i = 0; i < cifLoanClosureBean.length; i++) {
          error = cifLoanClosureBean[i].merror.toString();
          print("cifLoanClosureBean -- merror--" + cifLoanClosureBean[i].merror.toString());
        }
        if (error != "Successful Browse")
        {
          _CheckIfThere(error);
        }
        else
        {
          print("Successfull");
          for (int i = 0; i < cifLoanClosureBean.length; i++) {

            List str = cifLoanClosureBean[i].mloandetailsgrid.split("~");
            mloandetailsgrid = str[0];
            cifLoanClosureObj.mloandetailsgrid = str[1];

            str = cifLoanClosureBean[i].mapplicationdt.split("~");
            mapplicationdt = str[0];
            cifLoanClosureObj.mapplicationdt = str[1];

            str = cifLoanClosureBean[i].mappliedamt.split("~");
            mappliedamt = str[0];
            cifLoanClosureObj.mappliedamt = str[1];

            str = cifLoanClosureBean[i].mapproveddt.split("~");
            mapproveddt = str[0];
            cifLoanClosureObj.mapproveddt = str[1];

            str = cifLoanClosureBean[i].mapprovedamt.split("~");
            mapprovedamt = str[0];
            cifLoanClosureObj.mapprovedamt = str[1];

            str = cifLoanClosureBean[i].mstartdt.split("~");
            mstartdt = str[0];
            cifLoanClosureObj.mstartdt = str[1];

            str = cifLoanClosureBean[i].mdisbursementdt.split("~");
            mdisbursementdt = str[0];
            cifLoanClosureObj.mdisbursementdt = str[1];

            str = cifLoanClosureBean[i].mdisbursementamt.split("~");
            mdisbursementamt = str[0];
            cifLoanClosureObj.mdisbursementamt = str[1];

            str = cifLoanClosureBean[i].minstallmentstartdt.split("~");
            minstallmentstartdt = str[0];
            cifLoanClosureObj.minstallmentstartdt = str[1];

            str = cifLoanClosureBean[i].minstallmentamt.split("~");
            minstallmentamt = str[0];
            cifLoanClosureObj.minstallmentamt = str[1];

            str = cifLoanClosureBean[i].minstallmentfrequency.split("~");
            minstallmentfrequency = str[0];
            cifLoanClosureObj.minstallmentfrequency = str[1];

            str = cifLoanClosureBean[i].mnoofinstallments.split("~");
            mnoofinstallments = str[0];
            cifLoanClosureObj.mnoofinstallments = str[1];

            str = cifLoanClosureBean[i].mrateofinterest.split("~");
            mrateofinterest = str[0];
            cifLoanClosureObj.mrateofinterest = str[1];

            str = cifLoanClosureBean[i].menddt.split("~");
            menddt = str[0];
            cifLoanClosureObj.menddt = str[1];

            str = cifLoanClosureBean[i].minsurancepremiumamt.split("~");
            minsurancepremiumamt = str[0];
            cifLoanClosureObj.minsurancepremiumamt = str[1];

            str = cifLoanClosureBean[i].msecuritydetailsgrid.split("~");
            msecuritydetailsgrid = str[0];
            cifLoanClosureObj.msecuritydetailsgrid = str[1];

            str = cifLoanClosureBean[i].msecuritydepositdt.split("~");
            msecuritydepositdt = str[0];
            cifLoanClosureObj.msecuritydepositdt = str[1];

            str = cifLoanClosureBean[i].mamtondepositcreation.split("~");
            mamtondepositcreation = str[0];
            cifLoanClosureObj.mamtondepositcreation = str[1];

            str = cifLoanClosureBean[i].mcurrentbal.split("~");
            mcurrentbal = str[0];
            cifLoanClosureObj.mcurrentbal = str[1];

            str = cifLoanClosureBean[i].mexcessbal.split("~");
            mexcessbal = str[0];
            cifLoanClosureObj.mexcessbal = str[1];

            str = cifLoanClosureBean[i].mclosuredetailsgrid.split("~");
            mclosuredetailsgrid = str[0];
            cifLoanClosureObj.mclosuredetailsgrid = str[1];

            str = cifLoanClosureBean[i].minterestaccruedtilldt.split("~");
            minterestaccruedtilldt = str[0];
            cifLoanClosureObj.minterestaccruedtilldt = str[1];

            str = cifLoanClosureBean[i].mclosurecharges.split("~");
            mclosurecharges = str[0];
            cifLoanClosureObj.mclosurecharges = str[1];

            str = cifLoanClosureBean[i].mclosureamtasondate.split("~");
            mclosureamtasondate = str[0];
            cifLoanClosureObj.mclosureamtasondate = str[1];

            str = cifLoanClosureBean[i].mwaiveoffamt.split("~");
            mwaiveoffamt = str[0];
            cifLoanClosureObj.mwaiveoffamt = str[1];

            str = cifLoanClosureBean[i].mamttobepaidforclosure.split("~");
            mamttobepaidforclosure = str[0];
            cifLoanClosureObj.mamttobepaidforclosure = str[1];

            str = cifLoanClosureBean[i].mtotaloutstandinggrid.split("~");
            mtotaloutstandinggrid = str[0];
            cifLoanClosureObj.mtotaloutstandinggrid = str[1];

            str = cifLoanClosureBean[i].mprincipalos.split("~");
            mprincipalos = str[0];
            cifLoanClosureObj.mprincipalos = str[1];

            str = cifLoanClosureBean[i].minterestos.split("~");
            minterestos = str[0];
            cifLoanClosureObj.minterestos = str[1];

            str = cifLoanClosureBean[i].mpenalos.split("~");
            mpenalos = str[0];
            cifLoanClosureObj.mpenalos = str[1];

            str = cifLoanClosureBean[i].motherchargesos.split("~");
            motherchargesos = str[0];
            cifLoanClosureObj.motherchargesos = str[1];

            str = cifLoanClosureBean[i].mtotaloutstanding.split("~");
            mtotaloutstanding = str[0];
            cifLoanClosureObj.mtotaloutstanding = str[1];

            str = cifLoanClosureBean[i].mtotalpaymentgrid.split("~");
            mtotalpaymentgrid = str[0];
            cifLoanClosureObj.mtotalpaymentgrid = str[1];

            str = cifLoanClosureBean[i].mprincipalpaid.split("~");
            mprincipalpaid = str[0];
            cifLoanClosureObj.mprincipalpaid = str[1];

            str = cifLoanClosureBean[i].minterestpaid.split("~");
            minterestpaid = str[0];
            cifLoanClosureObj.minterestpaid = str[1];

            str = cifLoanClosureBean[i].mpenalpaid.split("~");
            mpenalpaid = str[0];
            cifLoanClosureObj.mpenalpaid = str[1];

            str = cifLoanClosureBean[i].motherchargespaid.split("~");
            motherchargespaid = str[0];
            cifLoanClosureObj.motherchargespaid = str[1];

            str = cifLoanClosureBean[i].mnoofinslpaid.split("~");
            mnoofinslpaid = str[0];
            cifLoanClosureObj.mnoofinslpaid = str[1];

            str = cifLoanClosureBean[i].mnoofdefaults.split("~");
            mnoofdefaults = str[0];
            cifLoanClosureObj.mnoofdefaults = str[1];

            str = cifLoanClosureBean[i].mtotalpaid.split("~");
            mtotalpaid = str[0];
            cifLoanClosureObj.mtotalpaid = str[1];

            str = cifLoanClosureBean[i].mduebutnotpaidgrid.split("~");
            mduebutnotpaidgrid = str[0];
            cifLoanClosureObj.mduebutnotpaidgrid = str[1];

            str = cifLoanClosureBean[i].mprincipalosdue.split("~");
            mprincipalosdue = str[0];
            cifLoanClosureObj.mprincipalosdue = str[1];

            str = cifLoanClosureBean[i].minterestosdue.split("~");
            minterestosdue = str[0];
            cifLoanClosureObj.minterestosdue = str[1];

            str = cifLoanClosureBean[i].mpenalosdue.split("~");
            mpenalosdue = str[0];
            cifLoanClosureObj.mpenalosdue = str[1];

            str = cifLoanClosureBean[i].motherchargesosdue.split("~");
            motherchargesosdue = str[0];
            cifLoanClosureObj.motherchargesosdue = str[1];

            str = cifLoanClosureBean[i].mtotaldue.split("~");
            mtotaldue = str[0];
            cifLoanClosureObj.mtotaldue = str[1];
          }

          if (showPaymntDetail == false) {
            setState(() {
              showPaymntDetail = true;
            });
          }
          if (showLoanDetail == false) {
            setState(() {
              showLoanDetail = true;
            });
          }
          Navigator.of(context).pop();
        }

      }
    });
  }

  Future<void> submit(CIFLoanClosureBean cifLoanClosureObj)  async{

    if (cifLoanClosureObj.mentrydate == "" || cifLoanClosureObj.mentrydate == null || cifLoanClosureObj.mentrydate == 0)
    {
      _showAlert("Please Enter Date");
      return false;
    }
    if (cifLoanClosureObj.mloandetailsgrid==null)
    {
      _showAlert("Please Click View First");
      return false;
    }
    if (cifLoanClosureObj.mpaymntmode == "" || cifLoanClosureObj.mpaymntmode == null || cifLoanClosureObj.mpaymntmode == 0)
    {
      _showAlert("Please Select Payment Mode");
      return false;
    }

    Future<bool> onPop(BuildContext context, String agrs1, String args2,String pageRoutedFrom) {
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

                setState(() {
                  isDataSynced = true;
                  circIndicatorIsDatSynced = true;
                });

                PostCIFLoanClosureTranstnToOmni postCIFLoanClosureTranstnToOmni = new PostCIFLoanClosureTranstnToOmni();
                postCIFLoanClosureTranstnToOmni.trySave(cifLoanClosureObj).then((List<CIFLoanClosureBean> cifLoanClosureBean) async {

                  this.cifLoanClosureBean = cifLoanClosureBean;
                  print("cifLoanClosureBean" + cifLoanClosureBean.toString());

                  bool netAvail = false;
                  netAvail = await obj.checkIfIsconnectedToNetwork();
                  if (netAvail == false) {
                    showMessageWithoutProgress("Network Not available");
                    return;
                  }
                  else{
                    print('omnimsg');
                    print(cifLoanClosureBean[0].momnimsg);
                    bool isSuccess = false;

                    if(cifLoanClosureBean[0].momnimsg != null || cifLoanClosureBean[0].momnimsg != "null" || cifLoanClosureBean[0].momnimsg != ""){

                      if(cifLoanClosureBean[0].momnimsg.toLowerCase().contains("success"))isSuccess=true;


                      _ShowOmniMsg(cifLoanClosureBean[0].momnimsg,isSuccess,cifLoanClosureObj);
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

    onPop(context, Translations.of(context).text('Are_You_Sure'),
        Translations.of(context).text('Do_You_Want_To_Proceed'), Translations.of(context).text('CollectionSubmit'));

  }

  Future<void> _CheckIfThere(String momnimsg) async {

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
                  new Text(momnimsg)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _ShowOmniMsg(String momnimsg,isSuccess,CIFLoanClosureBean cifBean) async {

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            /*title: new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 60.0,
            ),*/
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  new Text(momnimsg)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(Translations.of(context).text('print')),
                onPressed: () {
                 // if(isSuccess==true){
                    _callSingleLoanClosure(cifBean);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  //}

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
          content: SingleChildScrollView(
              child: SpinKitCircle(color: Colors.teal)
          ),
        );
      },
    );
  }







  _callSingleLoanClosure(
      CIFLoanClosureBean loanClosureBean) async {
    String repeatedStringAmount = "";
    double totalAmountCollected = 0.0;
    String repeatedStringCustNo = "";
    print("Loan  Collection ListBeanList" + loanClosureBean.toString());
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    String branchName = prefs.getString(TablesColumnFile.branchname);
    print("brnchName>> $branchName");
    print("bluetoothAddress $bluetootthAdd");
    if (loanClosureBean != null ) {
        repeatedStringAmount =
            loanClosureBean.mamttobepaidforclosure.toString() + "~" + repeatedStringAmount;
        totalAmountCollected =   double.parse(loanClosureBean.mamttobepaidforclosure);
        repeatedStringCustNo =
            "0"+ "~" + repeatedStringCustNo;

      print("repeatedStringAmount" + repeatedStringAmount);
      String repeatedStringEntryDate = "";
        repeatedStringEntryDate =
            DateTime.now().toString() + "~" + repeatedStringEntryDate;

      print("repeatedStringEntryDate" + repeatedStringEntryDate);

      String repeatedStringprdAccId = "";


        if (loanClosureBean.mprdacctid.trim() != '') {
          repeatedStringprdAccId =loanClosureBean.mprdacctid+"~"+"";

        }

      print("repeatedStringprdAccId" + repeatedStringprdAccId.toString());
           String mcustno = "0";
      String date = dateFormat.format(DateTime.now());


      try {
        final String result =
        await platform.invokeMethod("loanClosureCustPrint", {
          "BluetoothADD": bluetootthAdd,
          "mlbrcode":  cifLoanClosureObj.mlbrcode.toString(),
          "date": date,
          "mcustno": mcustno,
          "repeatedStringAmount": repeatedStringAmount,
          "repeatedStringprdAccId": repeatedStringprdAccId,
          "repeatedStringCustomerNumber": repeatedStringCustNo,
          "branchName": branchName,
          "company": "Wasaasaa", //companyName
          "trefno": " ",
          "centerName": "  ",
          "customerName": mlongname,
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





}
