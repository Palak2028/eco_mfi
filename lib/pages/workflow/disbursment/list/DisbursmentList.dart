import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/FPSPages/BiometricCheck.dart';
import 'package:eco_mfi/pages/workflow/disbursment/bean/DisbursmentBean.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/ThemeDesign.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'dart:async';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

class DisbursmentList extends StatefulWidget {
  final int mcenterid;
  final int mgroupid;
  final int custNo;
  final DateTime fromdate;
  final DateTime todate;
  final String routeType;
  DisbursmentList(this.mcenterid, this.mgroupid, this.custNo, this.fromdate,
      this.todate, this.routeType);

  @override
  _DisbursmentList createState() => new _DisbursmentList();
}

class _DisbursmentList extends State<DisbursmentList> {
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  List<DisbursmentBean> items = new List<DisbursmentBean>();
  List<DisbursmentBean> storedItems = new List<DisbursmentBean>();
  Widget appBarTitle = new Text("Disbursment List");
  Icon actionIcon = new Icon(Icons.save);
  int count = 1;
  int cardsCount = 0;
  int pageCount = 0;
  int forwardClicks = 1;
  bool dontIncForwrd = false;
  SharedPreferences prefs;
  final dateFormat = DateFormat("yyyy/MM/dd hh:mm:ss");
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  bool declCheckBox = false;
  int isBiometricNeeded = 1;
  int pageNumber = 1;
  int isWasasa = 0;
  List<int> rsfLbrCodes = new List<int>();
  int lbrCode = 0;
  String username;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  bool isSaved = false;
  String mreportinguser;
  List chargsList = new List();
  String charge1;
  String charge2;
  List chargesType;
  bool disbursmentPage = true; //disbursment:disbursmnet authorize

  List<Widget> dynamicCharges = new List<Widget>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.routeType == "Disbursment") {
      disbursmentPage = true;
      appBarTitle = new Text("Disbursment List"); //Disbursment createPage
    } else {
      appBarTitle = new Text("Disbursment Auth List");
      disbursmentPage = false; //authorization page
    }
    getSessionVariables();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    lbrCode = prefs.getInt(TablesColumnFile.musrbrcode);
    username = prefs.getString(TablesColumnFile.musrcode);
    geoLocation = prefs.getString(TablesColumnFile.geoLocation);
    geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
    geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
    mreportinguser = prefs.getString(TablesColumnFile.mreportinguser);
    isBiometricNeeded = prefs.getInt(TablesColumnFile.ISBIOMETRICNEEDED);
    setState(() {
      isWasasa = prefs.getInt(TablesColumnFile.isWASASA);
      print("IsWasasa = ${isWasasa}");
    });

    try {
      for (String items
          in prefs.getString(TablesColumnFile.rsfLbrCodes).split("~")) {
        rsfLbrCodes.add(int.parse(items));
      }
    } catch (_) {}

    try {
      for (String items
          in prefs.getString(TablesColumnFile.chargesCodes).split("~")) {
        chargsList.add(items);
      }
    } catch (_) {}

    print("Charges List $chargsList");

    if (isWasasa == 1 && (rsfLbrCodes == null || rsfLbrCodes.isEmpty)) {
      //todo Show popup to sync System Paramter
    }
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilderNotSynced;
    if (count == 1) {
      count++;
      try {
        //print(CustomerListBean);
        futureBuilderNotSynced = new FutureBuilder(
            future: AppDatabase.get()
                .selectDisbursmentList(
                    widget.mcenterid,
                    widget.mgroupid,
                    widget.custNo,
                    widget.fromdate,
                    widget.todate,
                    widget.routeType)
                .then((List<DisbursmentBean> disbursmentBean) {
              items.clear();
              storedItems.clear();
              disbursmentBean.forEach((DisbursmentBean f) {
                f.misdisbursed = 0;
                storedItems.add(f);
              });
              print("storedItems.length" + storedItems.length.toString());

              if (storedItems.length >= 1) {
                pageCount = storedItems.length;

                for (int showItems = 0; showItems < 1; showItems++) {
                  items.add(storedItems[showItems]);
                }
              } else {
                items.addAll(storedItems);
              }
              setState(() {});
              return storedItems;
            }),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return new Text(
                      Translations.of(context).text('Press_Button_To_Start'));
                case ConnectionState.waiting:
                  return new Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16.0),
                      child:
                          new CircularProgressIndicator()); // new Text('Awaiting result...');
                default:
                  if (snapshot.hasError) {
                    print(Translations.of(context).text('error') +
                        "${snapshot.error}");
                    return new Center(
                      child: new Text(Translations.of(context)
                          .text('Nothing_To_Display_On_Your_Filter')),
                    );
                  } else
                    return getHomePageBody2(context, snapshot);
              }
            });
      } catch (e) {
        futureBuilderNotSynced =
            new Text(Translations.of(context).text('Nothing_To_Display'));
      }
    } else if (items != null) {
      futureBuilderNotSynced = ListView.builder(
        // Must have an item count equal to the number of items!
        itemCount: items.length,
        // A callback that will return a widget.
        itemBuilder: (context, position) {
          Color color;
          if (position % 2 == 1) {
            color = Colors.grey;
          } else {
            color = Colors.grey;
          }
          double fees = items[position].mchargesamt0 +
              items[position].mchargesamt1 +
              items[position].mchargesamt2 +
              items[position].mchargesamt3 +
              items[position].mchargesamt4 +
              items[position].mchargesamt5 +
              items[position].mchargesamt6 +
              items[position].mchargesamt7 +
              items[position].mchargesamt8 +
              items[position].mchargesamt9;
          double amttodisbrs =
              items[position].mdisbamount - items[position].msdamt - fees;
          int mcustNoInt = 0;
          int mprcdAcctIdInt = 0;
          String mprdcd = "";
          String custNo = "";
          String prcdAcctId = "";
          if (items[position].mprdacctid != null &&
              items[position].mprdacctid.trim() != 'null' &&
              items[position].mprdacctid.trim() != '') {
            mprdcd = items[position].mprdacctid.substring(0, 8).trim();
            custNo = items[position].mprdacctid.substring(9, 16);
            prcdAcctId = items[position].mprdacctid.substring(17, 24);
          }

          dynamicCharges.clear();

          print(chargsList);
          if (chargsList.isNotEmpty) {
            for (int chargesNo = 0;
                chargesNo < chargsList.length;
                chargesNo++) {
              for (int i = 0;
                  i < globals.dropdownCaptionsValuesDisbursment[0].length;
                  i++) {
                try {
                  if (globals.dropdownCaptionsValuesDisbursment[0][i].mcode
                          .toString() ==
                      chargsList[chargesNo].trim()) {
                    print("matched for ${chargsList[chargesNo]}");
                    String chargeSTring = globals
                        .dropdownCaptionsValuesDisbursment[0][i].mcodedesc;
                    double charge = 0.0;
                    switch (chargesNo) {
                      case 0:
                        charge = items[position].mchargesamt0;
                        break;
                      case 1:
                        charge = items[position].mchargesamt1;
                        break;
                      case 2:
                        charge = items[position].mchargesamt2;
                        break;
                      case 3:
                        charge = items[position].mchargesamt3;
                        break;
                      case 4:
                        charge = items[position].mchargesamt4;
                        break;
                      case 5:
                        charge = items[position].mchargesamt5;
                        break;
                      case 6:
                        charge = items[position].mchargesamt6;
                        break;
                      case 7:
                        charge = items[position].mchargesamt7;
                        break;
                      case 8:
                        charge = items[position].mchargesamt8;
                        break;
                      case 9:
                        charge = items[position].mchargesamt9;
                        break;
                      default:
                        charge = 0.0;
                        break;
                    }
                    if (charge > 0) {
                      dynamicCharges.add(
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(chargeSTring)
                                //Translations.of(context).text('disb_Amt')),
                                ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                "${charge.toString()}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                } catch (_) {
                  print("Exception in dropdown");
                }
              }
            }
          }

          try {
            if (custNo != null && custNo != 'null' && custNo != '') {
              mcustNoInt = int.parse(custNo);
            }
            if (prcdAcctId != null &&
                prcdAcctId != 'null' &&
                prcdAcctId != '') {
              mprcdAcctIdInt = int.parse(prcdAcctId);
            }
          } catch (_) {}

          return new GestureDetector(
              child: Column(
            children: <Widget>[
              /*new Card(
                //color Color(0xff2f1f4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 25.0,
                child:*/
              new Padding(
                padding: new EdgeInsets.only(
                  left: 3.0,
                  right: 3.0,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 3.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: new BoxDecoration(
                          gradient: new LinearGradient(
                              colors: [Colors.cyan, Colors.indigo],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        //color: color,
                        child: Column(
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new Text(
                                  items[position].mlongname.trim(),
                                  overflow: TextOverflow.fade,
                                  style: new TextStyle(
                                      fontSize: 18.0,
                                      fontStyle: FontStyle.normal,
                                      // color: Colors.grey[700]
                                      color: Colors.white),
                                ),
                                new IconButton(
                                    icon: Icon(
                                      Icons.print,
                                      color: isSaved == true &&
                                              items[position].mdisbstatus == 1
                                          ? Colors.green
                                          : Colors.white,
                                    ),
                                    onPressed: () {
                                      if (isSaved == true &&
                                          items[position].mdisbstatus == 1)
                                        AppDatabase.get()
                                            .getDisbursedListForIndvPrint(
                                                items[position].mcustno)
                                            .then((List<DisbursmentBean>
                                                disbursmentBean) {
                                          print("val here is " +
                                              disbursmentBean.toString());
                                          if (disbursmentBean.isEmpty) {
                                            _CheckIfThere();
                                          } else {
                                            _callChannelDisbursmentIndvPrint(
                                                disbursmentBean);
                                          }
                                        });
                                    }),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new Text(
                                    mcustNoInt.toString() +
                                        "/" +
                                        mprdcd.toString() +
                                        "/" +
                                        mprcdAcctIdInt.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                Text(
                                  Translations.of(context).text('CNO') +
                                      " ${items[position].mcenterid}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  Translations.of(context).text('GNO') +
                                      " ${items[position].mgroupcd}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Container(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              SizedBox(),
                            ],
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                    Translations.of(context).text('mleadsid')),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  "${items[position].mleadsid.toString()}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          /*new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                    Translations.of(context).text('disb_Amt')),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  "${items[position].mdisbursedamt.toString()}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),*/
                          SizedBox(
                            height: 5.0,
                          ),
                          new Column(
                            children: dynamicCharges,
                          ),

                          /*new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                    Translations.of(context).text('sdamt')),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  "${items[position].msdamt.toString()}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),*/
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                    Translations.of(context).text('chargesamt'),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text("${fees}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                    Translations.of(context).text('sdamt'),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  "${items[position].msdamt.toString()}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                    Translations.of(context)
                                        .text('amttobedisb'),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  "${items[position].mdisbamount}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          new Row(
                            children: <Widget>[
                              Center(
                                child: Container(
                                    width: 400.0,
                                    child: new TextField(
                                      controller: items[position].mremarks ==
                                                  null ||
                                              items[position].mremarks.trim() ==
                                                  'null'
                                          ? new TextEditingController(text: "")
                                          : new TextEditingController(
                                              text:
                                                  "${items[position].mremarks}"),
                                      keyboardType: TextInputType.multiline,
                                      enabled: isSaved == false ? true : false,
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: 'Enter Rremarks Here',
                                          //helperText: 'Keep it short, this is just a demo.',
                                          labelText: 'Remarks',
                                          /*  prefixIcon: const Icon(
                                                        Icons.person,
                                                        color: Colors.green,
                                                      ),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                      onChanged: (String val) {
                                        items[position].mremarks = val;
                                      },
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Center(
                            child: isBiometricNeeded == 0 &&
                                    disbursmentPage == false
                                ? new Container()
                                : new Text(
                                    "Biometric Check",
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                          Container(
                            child: isSaved == true
                                ? SizedBox(height: 1.0)
                                : isBiometricNeeded == 0 &&
                                        disbursmentPage == false
                                    ? SizedBox(height: 1.0)
                                    : new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Center(
                                            child: new FingerScannerImageAsset(
                                                mIsCustomerSelected: "N",
                                                mrefno: int.parse(
                                                    items[position]
                                                        .mprdacctid
                                                        .substring(9, 16)
                                                        .trim())),
                                          ),
                                        ],
                                      ),
                          ),
                          isSaved == true
                              ? SizedBox(height: 1.0)
                              : isBiometricNeeded == 0 &&
                                      disbursmentPage == false
                                  ? SizedBox(height: 1.0)
                                  : new CheckboxListTile(
                                      value: items[position].mcheckbiometric ==
                                                  null ||
                                              items[position].mcheckbiometric ==
                                                  0
                                          ? false
                                          : true,
                                      title: new Text(
                                          "I declare that i want to override the biometric result."),
                                      onChanged: (val) {
                                        setState(() {
                                          if (val == true) {
                                            items[position].mcheckbiometric = 1;
                                          } else {
                                            items[position].mcheckbiometric = 0;
                                          }
                                        });
                                      }),
                          SizedBox(
                            height: 10.0,
                          ),
                          disbursmentPage == false
                              ? new CheckboxListTile(
                                  value: items[position].misauthorized == null ||
                                          items[position].misauthorized== 0
                                      ? false
                                      : true,
                                  title:new Text(Translations.of(context)
                                          .text('authorize')),
                                  onChanged: (val) {

                                      setState(() {
                                        if (val == true && isSaved == false) {
                                          items[position].misdisbursed = 1;
                                        } else if (val == false &&
                                            isSaved == false) {
                                          items[position].misdisbursed = 0;
                                        } else {
                                          Toast.show("Read Mode Only", context);
                                        }
                                      });

                                  })
                              : new CheckboxListTile(
                                  value: items[position].misdisbursed == null ||
                                          items[position].misdisbursed == 0
                                      ? false
                                      : true,
                                  title: new Text(Translations.of(context)
                                          .text('Disbursed')),

                                  onChanged: (val) {

                                      setState(() {
                                        if (val == true && isSaved == false) {
                                          items[position].misdisbursed = 1;
                                        } else if (val == false &&
                                            isSaved == false) {
                                          items[position].misdisbursed = 0;
                                        } else {
                                          Toast.show("Read Mode Only", context);
                                        }
                                      });

                                  }),
                          new ButtonTheme.bar(
                            padding: new EdgeInsets.all(2.0),
                            child: new ButtonBar(
                              children: <Widget>[],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // ),
            ],
          )

              //  ),
              );
        },
      );
    } else
      futureBuilderNotSynced =
          new Text(Translations.of(context).text('Nothing_To_Display'));
    return WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
        },
        child: new Scaffold(
          key: _scaffoldHomeState,
          bottomNavigationBar: Container(
            color: Color(0xff07426A),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new IconButton(
                  icon:
                      new Icon(FontAwesomeIcons.backward, color: Colors.green),
                  onPressed: () {
                    forwardClicks == 1 ? _LastClick() : _cardsCountReverse();
                  },
                ),
                Text(
                  forwardClicks.toString() + "/" + pageCount.toString(),
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                new IconButton(
                  icon: new Icon(FontAwesomeIcons.forward, color: Colors.red),
                  onPressed: () {
                    forwardClicks == pageCount
                        ? _LastClick()
                        : _cardsCountForward();
                    //  _cardsCountForward();
                  },
                ),
              ],
            ),
          ), //key: _
          appBar: new AppBar(
              elevation: 10.0,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              backgroundColor: Color(0xff07426A),
              brightness: Brightness.light,
              title: appBarTitle,
              actions: <Widget>[
                new IconButton(
                  icon: actionIcon,
                  onPressed: () {
                    print("Coming Here");
                    storedItems[pageNumber - 1] = items[0];
                    List<Widget> columnChildre = new List<Widget>();
                    Widget submittingColumn = new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: columnChildre,
                    );
                    int count = 0;

                    double totalDisbAmount = 0.0;
                    for (int saveData = 0;
                        saveData < storedItems.length;
                        saveData++) {
                      {
                        if (storedItems[saveData].misdisbursed == 1) {
                          count++;
                          totalDisbAmount += storedItems[saveData].mdisbamount;
                          columnChildre.add(SizedBox(height: 5.0));
                          columnChildre.add(new Text(
                              "${count})   ${storedItems[saveData].mlongname} "));
                        }
                      }
                    }
                    columnChildre.add(SizedBox(height: 10.0));
                    columnChildre.add(new Text(
                      "Total :        ${totalDisbAmount} ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ));

                    if (count > 0) {
                      onPop(
                          context,
                          Translations.of(context).text('Are_You_Sure'),
                          Translations.of(context)
                              .text('are_you_sure_Disb_Amont_Foll'),
                          submittingColumn,
                          count);
                    }
                  },
                ),
                new IconButton(
                    icon: const Icon(
                      Icons.print,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (isSaved == false) {
                        Toast.show(
                            Translations.of(context).text('Save_it_First'),
                            context);
                      } else {

                        Toast.show(
                            Translations.of(context).text('Dev_In_prog'),
                            context);
                        //_callChannelDisbursmentOverAllPrint(items);
                      }
                    }),
              ]),

          body: new Container(
              child: Form(
            key: _formKey,
            onChanged: () {
              final FormState form = _formKey.currentState;
              form.save();
            },
            child: futureBuilderNotSynced,
          )),
        ));
  }

  getHomePageBody2(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI2,
        padding: EdgeInsets.all(0.0),
      );
    }
  }

  Widget _getItemUI2(BuildContext context, int index) {
    String subs = items[index].mprdacctid.substring(8);
    print("subs " + subs.toString());

    Color color;
    if (index % 2 == 1) {
      // color = Color(0xffe8eaf6);
      //color = Colors.brown[50];
      color = Colors.grey;
    } else {
      //color = Colors.white;
      color = Colors.grey;
    }
    double fees = items[index].mchargesamt0 +
        items[index].mchargesamt1 +
        items[index].mchargesamt2 +
        items[index].mchargesamt3 +
        items[index].mchargesamt4 +
        items[index].mchargesamt5 +
        items[index].mchargesamt6 +
        items[index].mchargesamt7 +
        items[index].mchargesamt8 +
        items[index].mchargesamt9;
    double amttodisbrs = items[index].mdisbamount - items[index].msdamt - fees;
    int mcustNoInt = 0;
    int mprcdAcctIdInt = 0;
    String mprdcd = "";
    String custNo = "";
    String prcdAcctId = "";
    if (items[index].mprdacctid != null &&
        items[index].mprdacctid.trim() != 'null' &&
        items[index].mprdacctid.trim() != '') {
      mprdcd = items[index].mprdacctid.substring(0, 8).trim();
      custNo = items[index].mprdacctid.substring(9, 16);
      prcdAcctId = items[index].mprdacctid.substring(17, 24);
    }

    try {
      if (custNo != null && custNo != 'null' && custNo != '') {
        mcustNoInt = int.parse(custNo);
      }
      if (prcdAcctId != null && prcdAcctId != 'null' && prcdAcctId != '') {
        mprcdAcctIdInt = int.parse(prcdAcctId);
      }
    } catch (_) {}

    print("prdcd " + mprdcd.toString());
    print("custNo " + custNo.toString());
    print("prcdAcctId " + prcdAcctId.toString());

    return new GestureDetector(
        child: Column(
      children: <Widget>[
        /*new Card(
                //color Color(0xff2f1f4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 25.0,
                child:*/
        new Padding(
          padding: new EdgeInsets.only(
            left: 3.0,
            right: 3.0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 3.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [Colors.cyan, Colors.indigo],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  //color: color,
                  child: Column(
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text(
                            items[index].mlongname.trim(),
                            overflow: TextOverflow.fade,
                            style: new TextStyle(
                                fontSize: 18.0,
                                fontStyle: FontStyle.normal,
                                // color: Colors.grey[700]
                                color: Colors.white),
                          ),
                          new IconButton(
                              icon: Icon(
                                Icons.print,
                                color: isSaved == true &&
                                        items[index].mdisbstatus == 1
                                    ? Colors.green
                                    : Colors.white,
                              ),
                              onPressed: () {
                                if (isSaved == true &&
                                    items[index].mdisbstatus == 1) {
                                  AppDatabase.get()
                                      .getDisbursedListForIndvPrint(
                                          items[index].mcustno)
                                      .then((List<DisbursmentBean>
                                          disbursmentBean) {
                                    print("val here is " +
                                        disbursmentBean.toString());
                                    if (disbursmentBean.isEmpty) {
                                      _CheckIfThere();
                                    } else {
                                      _callChannelDisbursmentIndvPrint(
                                          disbursmentBean);
                                    }
                                  });
                                } else {}
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text(
                              mcustNoInt.toString() +
                                  "/" +
                                  mprdcd.toString() +
                                  "/" +
                                  mprcdAcctIdInt.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Text(
                            Translations.of(context).text('CNO') +
                                " ${items[index].mcenterid}",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            Translations.of(context).text('GNO') +
                                " ${items[index].mgroupcd}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              new Container(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        SizedBox(),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                              Translations.of(context).text('disb_Amt')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            "${items[index].mdisbursedamt.toString()}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              new Text(Translations.of(context).text('sdamt')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            "${items[index].msdamt.toString()}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              new Text(Translations.of(context).text('sdamt')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            "${items[index].msdamt.toString()}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                              Translations.of(context).text('chargesamt')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text("${items[index].msdamt.toString()}",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                              Translations.of(context).text('amttobedisb')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            "${amttodisbrs}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    new Row(
                      children: <Widget>[
                        Center(
                          child: Container(
                              width: 300.0,
                              child: new TextField(
                                controller: items[index].mremarks == null ||
                                        items[index].mremarks.trim() == 'null'
                                    ? new TextEditingController(text: "")
                                    : new TextEditingController(
                                        text: "${items[index].mremarks}"),
                                keyboardType: TextInputType.multiline,
                                enabled: isSaved == false ? true : false,
                                decoration: new InputDecoration(
                                    border: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.teal)),
                                    hintText: 'Enter Rremarks Here',
                                    //helperText: 'Keep it short, this is just a demo.',
                                    labelText: 'Remarks',
                                    /*  prefixIcon: const Icon(
                                                        Icons.person,
                                                        color: Colors.green,
                                    ),*/
                                    prefixText: '',
                                    suffixText: '',
                                    suffixStyle:
                                        const TextStyle(color: Colors.green)),
                                onChanged: (String val) {
                                  items[index].mremarks = val;
                                },
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    new CheckboxListTile(
                        value: items[index].misdisbursed == null ||
                                items[index].misdisbursed == 0
                            ? false
                            : true,
                        title: disbursmentPage == true
                            ? new Text(
                                Translations.of(context).text('Disbursed'))
                            : new Text(
                                Translations.of(context).text('authorize')),
                        onChanged: (val) {
                          setState(() {
                            if (val == true && isSaved == true) {
                              items[index].misdisbursed = 1;
                            } else if (val == false && isSaved == true) {
                              items[index].misdisbursed = 0;
                            } else {
                              Toast.show("Read Mode Only", context);
                            }
                          });
                        }),
                    Center(
                      child: isBiometricNeeded == 0 && disbursmentPage == true
                          ? new Container()
                          : new Text(
                              "Biometric Check",
                              textAlign: TextAlign.center,
                            ),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Center(
                          child: new FingerScannerImageAsset(
                              mIsCustomerSelected: "N",
                              mrefno: int.parse(items[index]
                                  .mprdacctid
                                  .substring(9, 16)
                                  .trim())),
                        ),
                      ],
                    ),
                    new CheckboxListTile(
                        value: declCheckBox,
                        title: new Text(
                            "I declare that i want to override the biometric result."),
                        onChanged: (val) {
                          setState(() {
                            declCheckBox = val;
                          });
                        }),
                    new ButtonTheme.bar(
                      padding: new EdgeInsets.all(2.0),
                      child: new ButtonBar(
                        children: <Widget>[],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // ),
      ],
    )

        //  ),
        );
  }

  void showInSnackBar(String message) {
    _scaffoldHomeState.currentState
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _cardsCountForward() {
    forwardClicks++;
    print("items is ${items[0]}");
    storedItems[pageNumber - 1] = items[0];
    items[0] = storedItems[pageNumber];
    pageNumber++;
    setState(() {});
  }

  void _cardsCountReverse() {
    forwardClicks--;
    print("items is ${items[0]}");
    storedItems[pageNumber - 1] = items[0];
    items[0] = storedItems[pageNumber - 2];
    pageNumber--;
    setState(() {});
  }

  Future<void> _LastClick() async {
    dontIncForwrd = true;

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.clear,
              color: Colors.red,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(Translations.of(context)
                      .text('No_Further_Records_Found')),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                onPressed: () {
                  Navigator.of(context).pop();
                  //Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  success(String message, BuildContext context, bool isPartialSubmitted) {
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
                  setState(() {});
                  if (isPartialSubmitted) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }

                  setState(() {});
                },
              ),
            ],
          );
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

  _callChannelDisbursmentIndvPrint(
      List<DisbursmentBean> disbursmentBean) async {
    String repeatedStringAmount = "";
    print("disbursmentBean" + disbursmentBean.toString());
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    print("bluetoothAddress $bluetootthAdd");
    if (disbursmentBean != null && disbursmentBean != "") {
      /* for (var items in disbursmentBean) {
        repeatedStringAmount =
            items.mcollectedamount.toString() +"~"+ repeatedStringAmount;
      }*/
      print("repeatedStringAmount" + repeatedStringAmount);
      String repeatedStringEntryDate = "";
      for (var items in disbursmentBean) {
        repeatedStringEntryDate =
            items.mentrydate.toString() + "~" + repeatedStringEntryDate;
      }
      print("repeatedStringEntryDate" + repeatedStringEntryDate);

      String repeatedStringprdAccId = "";
      for (var items in disbursmentBean) {
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
      String mlbrcode = disbursmentBean[0].mlbrcode.toString() != ""
          ? disbursmentBean[0].mlbrcode.toString()
          : "";
      String mcenterid = disbursmentBean[0].mcenterid.toString();
      String date = dateFormat.format(DateTime.now());
      // String mlongname = disbursmentBean[0].mlongname.toString();

      try {
        final String result =
            await platform.invokeMethod("svngcollcenterprint", {
          "BluetoothADD": bluetootthAdd,
          "mlbrcode": mlbrcode,
          "date": date,
          "mcenterid": mcenterid,
          "repeatedStringAmount": repeatedStringAmount,
          "repeatedStringprdAccId": repeatedStringprdAccId,
          "repeatedStringEntryDate": repeatedStringEntryDate
        });
        String geTest = 'geTest at $result';
        print("FLutter : " + geTest.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }
  }

  _callChannelDisbursmentOverAllPrint(
      List<DisbursmentBean> disbursmentBeanList) async {
    String repeatedStringAmount = "";
    print("disbursmentBean" + disbursmentBeanList.toString());
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    print("bluetoothAddress $bluetootthAdd");
    if (disbursmentBeanList != null && disbursmentBeanList != "") {
      /* for (var items in disbursmentBeanList) {
        repeatedStringAmount =
            items.mcollectedamount.toString() +"~"+ repeatedStringAmount;
      }*/
      print("repeatedStringAmount" + repeatedStringAmount);
      String repeatedStringEntryDate = "";
      for (var items in disbursmentBeanList) {
        repeatedStringEntryDate =
            items.mentrydate.toString() + "~" + repeatedStringEntryDate;
      }
      print("repeatedStringEntryDate" + repeatedStringEntryDate);

      String repeatedStringprdAccId = "";
      for (var items in disbursmentBeanList) {
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
      String mlbrcode = disbursmentBeanList[0].mlbrcode.toString() != ""
          ? disbursmentBeanList[0].mlbrcode.toString()
          : "";
      String mcenterid = disbursmentBeanList[0].mcenterid.toString();
      String date = dateFormat.format(DateTime.now());
      // String mlongname = disbursmentBean[0].mlongname.toString();

      try {
        final String result =
            await platform.invokeMethod("svngcollcenterprint", {
          "BluetoothADD": bluetootthAdd,
          "mlbrcode": mlbrcode,
          "date": date,
          "mcenterid": mcenterid,
          "repeatedStringAmount": repeatedStringAmount,
          "repeatedStringprdAccId": repeatedStringprdAccId,
          "repeatedStringEntryDate": repeatedStringEntryDate
        });
        String geTest = 'geTest at $result';
        print("FLutter : " + geTest.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }
  }

  Future<bool> callDialog() {
    globals.Dialog.onPop(
        context,
        Translations.of(context).text('Are_You_Sure'),
        Translations.of(context).text('Do_You_Want_Submit_Collection_List_A'),
        Translations.of(context).text('CollectionSubmit'));
  }

  Future<bool> onPop(BuildContext context, String agrs1, String args2,
      Widget columnWidget, int count) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
            title: new Text(agrs1),
            content: Container(
              height: 60.0 + count * 30.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Row(
                    children: <Widget>[new Text(args2 + " :")],
                  ),
                  columnWidget
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () async {
                  String batchcd = DateTime.now().year.toString() +
                      DateTime.now().month.toString() +
                      DateTime.now().day.toString() +
                      DateTime.now().minute.toString() +
                      DateTime.now().second.toString() +
                      DateTime.now().millisecond.toString();

                  /*int tempTref = 0;
                  await AppDatabase.get()
                      .generateTrefNumber()
                      .then((int onValue) {
                    print("tempTref " + onValue.toString());
                    tempTref = onValue;
                  });*/

                  for (int saveData = 0;
                      saveData < storedItems.length;
                      saveData++) {
                    if (storedItems[saveData].misdisbursed == 1) {
                      print("storedItems[saveData].mnarration.toString()    " +
                          storedItems[saveData].mnarration.toString());

                      storedItems[saveData].mgeolocation = geoLocation;
                      storedItems[saveData].mgeolatd = geoLatitude;
                      storedItems[saveData].mgeologd = geoLongitude;
                      if (disbursmentPage == true) {
                        storedItems[saveData].mlastupdatedt = DateTime.now();
                        storedItems[saveData].mlastupdateby = username;
                        storedItems[saveData].mcreatedby = username;
                        storedItems[saveData].mcreateddt = DateTime.now();
                        if (rsfLbrCodes.contains(lbrCode)) {
                          storedItems[saveData].mrouteto = mreportinguser;
                        } else {
                          storedItems[saveData].mrouteto = username;
                        }
                        storedItems[saveData].mdisbstatus = 1;
                      } else {
                        storedItems[saveData].mlastupdatedt = DateTime.now();
                        storedItems[saveData].mlastupdateby = username;
                        storedItems[saveData].mdisbstatus = 2;
                      }

                      AppDatabase.get()
                          .updateDisbursedMaster(storedItems[saveData]);
                      print("saveData" + saveData.toString());
                    }
                  }
                  setState(() {
                    isSaved = true;
                  });
                  success(
                      Translations.of(context).text('Submitted_sucessfully'),
                      context,
                      false);
                },
                child: new Text(Translations.of(context).text('Yes')),
              ),
            ],
          ),
    );
  }
}
