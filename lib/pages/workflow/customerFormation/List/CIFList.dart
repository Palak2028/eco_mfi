import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/BranchMaster/BranchMasterBean.dart';
import 'package:eco_mfi/pages/workflow/background.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CIFLoanClosure.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CIFSavingAcctClosure.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/ViewRepaymentSchedule.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFRepayScheduleBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetRepaymentScheduleFromOmni.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetSavingClosureDetailsFromOmni.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/PostCIFCustAuthorizationToOmni.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/Beans/TermDepositClosureBean.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/TDClosureDetail.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/TermDpositClosureServices.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_mfi/Utilities/ThemeDesign.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/pages/workflow/Savings/ViewMinistatementTable.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/MiniStatementBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CIFTransaction.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetMiniStatementFromMiddleware.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CIFList extends StatefulWidget {
  static const String routeName = '/material/data-table';
  final List<CIFBean> cifBean;
  CIFList(this.cifBean);

  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );

  @override
  _CIFList createState() =>
      _CIFList();
}

class _CIFList
    extends State<CIFList> {

  bool showPersInfo = false;
  List<int> indicesList = new List<int>();
  List<CIFBean> cifList=new List<CIFBean>();
  bool isDataSynced = false;
  bool circIndicatorIsDatSynced = false;
  List<MiniStatementBean> miniStatementBean;
  Utility utility = new Utility();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  bool circInd  =false;
  final GlobalKey<AnimatedCircularChartState> _chartKey2 =
  new GlobalKey<AnimatedCircularChartState>();
  List<CIFRepayScheduleBean> cifRepayScheduleBean;
  SharedPreferences prefs;
  int branch;
  BranchMasterBean branchMasterBean= null;
  bool showGraph = true;
  List<CIFBean> cifBean;

  @override
  void initState() {
    super.initState();

    if(widget.cifBean!=null){
      cifList =widget.cifBean;
    }
    //print("cifList--" + cifList.toString());
    if(cifList == null){
      cifList =List();
    }
    getSessionVariables();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode);
    });

    AppDatabase.get().getBranchNameOnPbrCd(cifList[0].mlbrcode).then((onValue){
      branchMasterBean = onValue;
      print("branch "+ cifList[0].mlbrcode.toString());
      print("branchMasterBean "+ branchMasterBean.toString());
    });
  }


  List<CircularStackEntry> data = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        //new CircularSegmentEntry(500.0, Colors.red[200], rankKey: 'Q1'),
        new CircularSegmentEntry(1100.0, Colors.green[200], rankKey: 'Q1'),
        new CircularSegmentEntry(1600.0, Colors.blue[200], rankKey: 'Q2'),
        new CircularSegmentEntry(1300.0, Colors.yellow[200], rankKey: 'Q3'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    //return MaterialApp(
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final headerList = new Container(
      child: new Column(children: <Widget>[
        AnimatedCircularChart(
          key: _chartKey2,
          size: const Size(300.0, 250.0),
          initialChartData: data,
          // holeRadius: 12.0,
          chartType: CircularChartType.Pie,
        ),
        new Text ('Green  : Savings Account\nBlue     : Loan Account\nYellow : TD Account\n'),
      ]),
    );

    final body = new Scaffold(
      key: _scaffoldHomeState,
      appBar: new AppBar(
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => {Navigator.of(context).pop(),Navigator.of(context).pop(), }
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title: new Text(
          'CIF Detail',
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: new Container(
        child: new Stack(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(top: 10.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Align(
                    alignment: Alignment.centerLeft,
                    child: new Padding(
                        padding: new EdgeInsets.only(left: 8.0),
                        child: new Text('CUSTOMER : '+cifList[0].mcustno.toString()+' , '+cifList[0].mlongname+'\nBranch : ${cifList[0].mlbrcode.toString()} / ${cifList[0].mbranchname!=null?cifList[0].mbranchname:""}'
                                        +'\nNational ID : ${cifList[0].mpannodesc!=null?cifList[0].mpannodesc:""}',
                          style: new TextStyle(color: Colors.white),
                        )),
                  ),
                  new RaisedButton(
                    color: Colors.black26,
                    child: Text( "Graphical Representation (Click to hide/show graph)"),
                    textColor: Colors.white,
                    onPressed: () {
                      if (showGraph == false) {
                        setState(() {
                          showGraph = true;
                        });
                      } else if (showGraph == true) {
                        setState(() {
                          showGraph = false;
                        });
                      }
                    },
                  ),
                  showGraph == true ?
                  new Container(
                      height: 345.0, width: _width, child: headerList): new Text(""),
                  new Row(
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      new Align(
                        alignment: Alignment.centerLeft,
                        child: new Padding(
                            padding: new EdgeInsets.only(left: 20.0),
                            child: new Text('Customer Status : ${cifList[0].mcuststatus == 1 ? "Active" :
                            cifList[0].mcuststatus == 2 ? "Dropped Out" :
                            cifList[0].mcuststatus == 3 ? "New" : " "}',
                              style: new TextStyle(color: Colors.blueAccent),
                            )
                        ),
                      ),
                      (cifList[0].mcuststatus == 3 ) ?
                      new Align(
                        alignment: Alignment.centerRight,
                        child: new Padding(
                            padding: new EdgeInsets.only(left: 30.0),
                            child: new RaisedButton(
                              color: Colors.teal,
                              child: Text( "Authorize Customer"),
                              textColor: Colors.white,
                                onPressed: ()async{
                                  proceed(cifList[0].mcustno);
                                }
                            )
                        ),
                      ):new Text(''),
                    ],
                  ),
                  new Text(" "),
                  new Expanded(child:
                  ListView.builder(
                      itemCount: cifList.length,
                      itemBuilder: (context, position) {
                        double c_width = MediaQuery.of(context).size.width * 10;
                        int mcustNoInt = 0;
                        int mprcdAcctIdInt = 0;
                        String mprdcd = "";
                        String custNo = "";
                        String prcdAcctId = "";
                        String acctstat = "";

                        if (cifList[position].mprdacctid != null &&
                            cifList[position].mprdacctid != "null" &&
                            cifList[position].mprdacctid != "") {
                          try {
                            mprdcd =
                                cifList[position].mprdacctid.substring(0, 8)
                                    .trim();
                          }catch(_){}
                          try{
                          custNo = cifList[position].mprdacctid.substring(8, 16);
                          }catch(_){}
                          try{
                          prcdAcctId = cifList[position].mprdacctid.substring(16, 24);
                          }catch(_){}
                        }

                        if (mprdcd == null || mprdcd == 'null' || mprdcd.trim() == "") {
                          mprdcd = cifList[position].mprdcd;
                        }
                        if (custNo == null || custNo == 'null' || custNo.trim() == "") {
                          custNo = cifList[position].mcustno.toString();
                        }
                        try {
                          if (custNo != null && custNo != 'null') {
                            mcustNoInt = int.parse(custNo);
                          }
                          if (prcdAcctId != null && prcdAcctId != 'null') {
                            mprcdAcctIdInt = int.parse(prcdAcctId);
                          }
                        } catch (_) {}

                        if (cifList[position].macctstat == 1){
                          acctstat = "Normal/Operative";
                        } else if (cifList[position].macctstat == 2){
                          acctstat = "New";
                        } else if (cifList[position].macctstat == 3){
                          acctstat = "Closed";
                        } else if (cifList[position].macctstat == 15){
                          acctstat = "WrittenOff";
                        } else {
                          acctstat = "NPA";
                        }

                        return new ListTile(
                          title: new Column(
                            children: <Widget>[
                              new Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  cifList[position].mmoduletype == 30 ?
                                  new Container(
                                    height: 72.0,
                                    width: 72.0,
                                    decoration: new BoxDecoration(
                                        color: Colors.lightGreen,
                                        boxShadow: [
                                          new BoxShadow(
                                              color:
                                              Colors.black.withAlpha(70),
                                              offset: const Offset(2.0, 2.0),
                                              blurRadius: 2.0)
                                        ],
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(12.0)),
                                        image: new DecorationImage(
                                          image: new ExactAssetImage(                   // image change karo on the basis of module type -- bhawpriya
                                            'assets/loan_account.png',
                                          ),
                                          fit: BoxFit.cover,
                                        )),
                                  ) : cifList[position].mmoduletype == 11 ?
                                  new Container(
                                    height: 72.0,
                                    width: 72.0,
                                    decoration: new BoxDecoration(
                                        color: Colors.lightGreen,
                                        boxShadow: [
                                          new BoxShadow(
                                              color:
                                              Colors.black.withAlpha(70),
                                              offset: const Offset(2.0, 2.0),
                                              blurRadius: 2.0)
                                        ],
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(12.0)),
                                        image: new DecorationImage(
                                          image: new ExactAssetImage(                   // image change karo on the basis of module type -- bhawpriya
                                            'assets/savings_account.png',
                                          ),
                                          fit: BoxFit.cover,
                                        )),
                                  ) :
                                  new Container(
                                    height: 72.0,
                                    width: 72.0,
                                    decoration: new BoxDecoration(
                                        color: Colors.lightGreen,
                                        boxShadow: [
                                          new BoxShadow(
                                              color:
                                              Colors.black.withAlpha(70),
                                              offset: const Offset(2.0, 2.0),
                                              blurRadius: 2.0)
                                        ],
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(12.0)),
                                        image: new DecorationImage(
                                          image: new ExactAssetImage(                   // image change karo on the basis of module type -- bhawpriya
                                            'assets/termdeposit_account.jpg',
                                          ),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  new SizedBox(
                                    width: 8.0,
                                  ),
                                  new Expanded(
                                      child: new Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Text(
                                            mcustNoInt.toString() +
                                                "/" +
                                                mprdcd.toString() +
                                                "/" +
                                                mprcdAcctIdInt.toString() +
                                                "(" +
                                                acctstat.toString() +
                                                ")",
                                            style: new TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
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
                                                        /*SizedBox(
                                                      height: 8.0,
                                                    ),*/
                                                        new Padding(
                                                          padding: new EdgeInsets.only(
                                                          ),
                                                          child: new Row(
                                                            textBaseline: TextBaseline.alphabetic,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.baseline,
                                                            children: <Widget>[
                                                              cifList[position].mmoduletype == 30?
                                                              Text(
                                                                "Loan Cycle: ${cifList[position].mtier}, ",
                                                                style: TextStyle(
                                                                  fontSize: 12.0,
                                                                  color: Colors.black54,
                                                                ),
                                                              ) : Text(""),
                                                              cifList[position].mmoduletype == 30 || cifList[position].mmoduletype == 11?
                                                              Text(
                                                                cifList[position].mfreezetype == 1 ? "No Freeze" :
                                                                cifList[position].mfreezetype == 4 ? "Total Freeze" :
                                                                " ",
                                                                style: TextStyle(
                                                                  fontSize: 12.0,
                                                                  color: Colors.black54,
                                                                ),
                                                              ) : Text(""),
                                                            ],
                                                          ),
                                                        ),
                                                        new Row(
                                                          textBaseline: TextBaseline.alphabetic,
                                                          children: <Widget>[
                                                            new RaisedButton(
                                                              color: Colors.teal,
                                                              child: Text( "Balance"),
                                                              textColor: Colors.white,
                                                              onPressed: () {
                                                                _CheckBalance(cifList[position]);
                                                              },
                                                            ),
                                                            new Text(" "),
                                                            cifList[position].mmoduletype == 11
                                                                ?   new Row(
                                                              textBaseline: TextBaseline.alphabetic,
                                                              children: <Widget>[
                                                                /*new Text("    "),*/
                                                                new RaisedButton(
                                                                  color: Colors.teal,
                                                                  child: Text( "Mini Statement"),
                                                                  textColor: Colors.white,
                                                                  onPressed: ()
                                                                  async {
                                                                    circInd = true;
                                                                    _ShowProgressInd(context);
                                                                    getMiniStatement(cifList[position].mprdacctid);
                                                                  },
                                                                ),
                                                              ],
                                                            ): cifList[position].mmoduletype == 30
                                                                ?  new Row(
                                                              textBaseline: TextBaseline.alphabetic,
                                                              children: <Widget>[
                                                                new RaisedButton(
                                                                  color: Colors.teal,
                                                                  child: Text( "Repay Schedule"),
                                                                  textColor: Colors.white,
                                                                  onPressed: ()
                                                                  async {
                                                                    circInd = true;
                                                                    _ShowProgressInd(context);
                                                                    getRepaymentSchedule(cifList[position].mprdacctid, cifList[position].mleadsid);
                                                                  },
                                                                ),
                                                              ],
                                                            ):((cifList[position].mmoduletype == 20 && cifList[position].macctstat !=  3)
                                                                /*(cifList[position].mmoduletype == 20 )*/)?
                                                            new RaisedButton(
                                                              color: Colors.teal,
                                                              child: Text( "Closure"),
                                                              textColor: Colors.white,
                                                              onPressed: () {

                                                                _ShowProgressInd(context);
                                                                _navigateToTermDepositClosureScreen(cifList[position].mprdacctid,cifList[position].mlongname);
                                                              },
                                                            )
                                                                :new Text(""),
                                                          ],
                                                        ),
                                                        new Row(
                                                          textBaseline: TextBaseline.alphabetic,
                                                          children: <Widget>[
                                                            (cifList[position].mmoduletype == 11 && cifList[position].macctstat !=  3) ?
                                                            new RaisedButton(
                                                              color: Colors.teal,
                                                              child: Text( "Withdrawal"),
                                                              textColor: Colors.white,
                                                              onPressed: () {
                                                                _PostTransaction(cifList[position] , 1);//withdrawal
                                                              },
                                                            ) : (cifList[position].mmoduletype == 30 && cifList[position].macctstat !=  3)?
                                                            new RaisedButton(
                                                              color: Colors.teal,
                                                              child: Text( "Payment"),
                                                              textColor: Colors.white,
                                                              onPressed: () {
                                                                _PostTransaction(cifList[position] , 3);//instalpay
                                                              },
                                                            ) : new Text(""),
                                                            new Text(" "),
                                                            (cifList[position].mmoduletype == 11 && cifList[position].macctstat !=  3)?
                                                            new RaisedButton(
                                                              color: Colors.teal,
                                                              child: Text( "Deposit"),
                                                              textColor: Colors.white,
                                                              onPressed: () {
                                                                _PostTransaction(cifList[position] , 2);//deposit
                                                              },
                                                            ) : (cifList[position].mmoduletype == 30 && cifList[position].macctstat !=  3)?
                                                            new RaisedButton(
                                                              color: Colors.teal,
                                                              child: Text( "Closure"),
                                                              textColor: Colors.white,
                                                              onPressed: () {
                                                                _OpenLoanClosureScreen(cifList[position]);
                                                              },
                                                            ): (cifList[position].mmoduletype == 30 && cifList[position].macctstat ==  3) ?
                                                            new RaisedButton(
                                                              color: Colors.teal,
                                                              child: Text( "Print"),
                                                              textColor: Colors.white,
                                                              onPressed: () {
                                                                _callChannelLoanClosurePrint(cifList[position]);
                                                              },
                                                            ) : new Text("")
                                                          ],
                                                        ),
                                                        new Row(
                                                          textBaseline: TextBaseline.alphabetic,
                                                          children: <Widget>[
                                                            (cifList[position].mmoduletype == 11 && cifList[position].macctstat !=  3) ?
                                                            new RaisedButton(
                                                              color: Colors.teal,
                                                              child: Text( "Closure"),
                                                              textColor: Colors.white,
                                                              onPressed: () {
                                                                loadSavingClosurePage(cifList[position]);
                                                              },
                                                            )  : new Text(""),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                              new Divider(),
                            ],
                          ),
                        );
                      }))
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return new WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();Navigator.of(context).pop();
        },
    child : new Container(
      decoration: new BoxDecoration(
        color: const Color(0xFF273A48),
      ),
      child: new Stack(
        children: <Widget>[
          new CustomPaint(
            size: new Size(_width, _height),
            painter: new Background(),
          ),
          body,
        ],
      ),
    ),
    );
  }

  Future<void> _CheckBalanceLoan(CIFBean cifList) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.account_balance,
              color: Colors.blueAccent,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Text("LeadsId : " + cifList.mleadsid.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text("Main Balance : " + cifList.mmainbal.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text("Interest Prov : " + cifList.minterestprov.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text("Interest Paid : " + cifList.minterestpaid.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text("Penal Prov : " + cifList.mpenalprov.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text("Penal Paid : " + cifList.mpenalpaid.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text("Disbursed Amt : " + cifList.mdisbursedamt.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text("Excess Amt : " + cifList.mexcessamt.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text("Prin Current Due : " + cifList.mprinccurrdue.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text("Prin Over Due : " + cifList.mprincoverdue.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text("Int Due : " + cifList.mintdue.toString()),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _CheckBalanceSaving(CIFBean cifList) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.account_balance,
              color: Colors.blueAccent,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Text(
                          " Shadow Clear Bal : " + cifList.mshadowclearbal.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text(" Shadow Total Bal : " + cifList.mshadowtotalbal.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text(" Actual Clear Balance : " + cifList.mactualclearbal.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text(" Actual Total Balance : " + cifList.mactualtotalbal.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text(" Lien Amt : " + cifList.mlienamt.toString()),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _CheckBalanceTD(CIFBean cifList) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.account_balance,
              color: Colors.blueAccent,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Text(" Main Balance : " + cifList.mmainbal.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text("Interest Prov : " + cifList.minterestprov.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text("Interest Paid : " + cifList.minterestpaid.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text("TDS Amt : " + cifList.mtdsamt.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text("Lien Amt : " + cifList.mlienamt.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text("MaturityValue : " + cifList.mmaturityvalue.toString()),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _CheckBalance(CIFBean cifList) async {
    print("_CheckBalance");
    print(cifList.mmoduletype);
    if (cifList.mmoduletype == 30) {
      _CheckBalanceLoan(cifList);
    }
    if (cifList.mmoduletype == 11) {
      _CheckBalanceSaving(cifList);
    }
    if (cifList.mmoduletype == 20) {
      _CheckBalanceTD(cifList);
    }
  }

  void showMessageWithoutProgress(String message,
      [MaterialColor color = Colors.red]) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  Future<void> _PostTransaction(CIFBean obj , int transactionType ) async {

    bool netAvail = false;
    netAvail = await utility.checkIfIsconnectedToNetwork();
    if (netAvail == false) {
      // showMessageWithoutProgress("Network Not available");
      print("Network Not available");
      return;
    }
    else{
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new CIFTransaction(obj , transactionType)), //
        // When Authorized Navigate to the next screen
      );
    }
  }

  Future<void> loadSavingClosurePage(CIFBean obj) async {

    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    GetSavingClosureDetailsFromOmni getSavingClosureDetailsFromOmni =
    new GetSavingClosureDetailsFromOmni();
    await getSavingClosureDetailsFromOmni.trySave(obj).then((List<CIFBean> cifBean) async {
      this.cifBean = cifBean;
      print("cifBean" + cifBean.toString());

      bool netAvail = false;
      netAvail = await utility.checkIfIsconnectedToNetwork();
      if (netAvail == false) {
        showMessageWithoutProgress("Network Not available");
        return;
      }
      else {
        for (int i = 0; i < cifBean.length; i++) {
            error = cifBean[i].merror.toString();
            print("cifLoanClosureBean -- merror--" + cifBean[i].merror.toString());
        }
        if (error != "Successful Browse")
        {
          _CheckIfThereError(error);
        }
        else
        {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new CIFSavingAcctClosure(cifBean,obj)),
            // When Authorized Navigate to the next screen
          );
        }
      }
      setState(() {

      });
    });
  }

  Future<void> _OpenLoanClosureScreen(CIFBean obj) async {

    bool netAvail = false;
    netAvail = await utility.checkIfIsconnectedToNetwork();
    if (netAvail == false) {
      showMessageWithoutProgress("Network Not available");
      return;
    }
    else{
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new CIFLoanClosure(obj)), //
        // When Authorized Navigate to the next screen
      );
    }
  }

  Future<void> getMiniStatement(String mprdaccid) async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    GetMiniStatementFromMiddleware getMiniStatementFromMiddleware =
    new GetMiniStatementFromMiddleware();
    await getMiniStatementFromMiddleware.trySave(mprdaccid).then((List<MiniStatementBean> miniStatementBean) {
      this.miniStatementBean=miniStatementBean;
      print("miniStatementBean"+miniStatementBean.toString());
      if(miniStatementBean.isEmpty){
        _CheckIfThere();
      }
      else{
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new ViewMinistatementTable(miniStatementBean)), //
          // When Authorized Navigate to the next screen
        );}
    });
  }



  Future<void> getRepaymentSchedule(String mprdaccid, String mleadsid) async {
    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    GetRepaymentScheduleFromOmni getRepaymentScheduleFromOmni = new GetRepaymentScheduleFromOmni();
    await getRepaymentScheduleFromOmni.trySave(mprdaccid,mleadsid).then((List<CIFRepayScheduleBean> cifRepayScheduleBean) async {
      this.cifRepayScheduleBean = cifRepayScheduleBean;
      print("cifRepayScheduleBean" + cifRepayScheduleBean.toString());

      bool netAvail = false;
      netAvail = await utility.checkIfIsconnectedToNetwork();
      if (netAvail == false) {
        showMessageWithoutProgress("Network Not available");
        return;
      }
      else{
        if(cifRepayScheduleBean.isEmpty){
          _CheckIfThere();
        }
        else{
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new ViewRepaymentSchedule(cifRepayScheduleBean, mprdaccid)), //
            // When Authorized Navigate to the next screen
          );
        }
      }
    });
  }

  Future<void> _CheckIfThereError(String momnimsg) async {

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
                  //Navigator.of(context).pop();
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
                      new Text(" No Records Found "),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
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

  Future<void> proceed(int custno)  async{

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

                PostCIFCustAuthorizationToOmni postCIFCustAuthorizationToOmni = new PostCIFCustAuthorizationToOmni();
                postCIFCustAuthorizationToOmni.trySave(custno).then((List<CIFBean> cifBean) async {

                  this.cifBean = cifBean;
                  print("cifBean" + cifBean.toString());

                  bool netAvail = false;
                  netAvail = await utility.checkIfIsconnectedToNetwork();
                  if (netAvail == false) {
                    showMessageWithoutProgress("Network Not available");
                    return;
                  }
                  else{
                    if(cifBean[0].merror != null || cifBean[0].merror != "null" || cifBean[0].merror != ""){
                      _successfulSubmit(cifBean[0].merror);
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

  Future<void> _successfulSubmit(msg) async {
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
                  Text(msg),
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
            ],
          );
        });
  }






 Future<void> _navigateToTermDepositClosureScreen(String prdAcctId,String mlongName) async {


   TermDepositClosureServices tdcloureservice = TermDepositClosureServices();

    await tdcloureservice.getTermDepositClosureDetails(prdAcctId).then((TermDepositClosureBean tdClosureBean   )async {



      if (tdClosureBean==null) {

        Navigator.of(context).pop();
        _showErrormessage("No Account Found");
      }

      else if(tdClosureBean.mstatus==0){
        Navigator.of(context).pop();

        _showErrormessage(tdClosureBean.merrormessage);


      }
      else
      {
        Navigator.of(context).pop();
        tdClosureBean.mlongname = mlongName;
        List<String> savingAccs = new List<String>();
        if(tdClosureBean.mselectedsavingacc!=null&&tdClosureBean.mselectedsavingacc!=""){
          savingAccs = tdClosureBean.mselectedsavingacc.split("~");
          print(savingAccs.length);
          tdClosureBean.attachedSavAccts = new List<SavingAccounts>();
          for(String accno in savingAccs ){
            tdClosureBean.attachedSavAccts.add(new SavingAccounts(macctno:accno,mlongname: mlongName ));
          }



        }
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new TDClosureDetail(
                tdClosureBeanpassedObject: tdClosureBean,
              )),
        );
      }

    });


  }





  Future<void> _showErrormessage(String mErrormessage) async {

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
                      new Text(" ${mErrormessage} "),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                onPressed: () {

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
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

  _callChannelLoanClosurePrint(CIFBean cifPrintBean) async {
      print("Branch :${branch}");
      print("BranchName :${cifList[0].mbranchname}");
      print("PrdAccId :${formatPrdAccId(cifPrintBean.mprdacctid)}");
      print("Batch :${cifPrintBean.mbatchcd}");
      print("SetNo :${cifPrintBean.msetno}");
      print("Remark : Closure");
      print("Amt :${cifPrintBean.mlcytrnamt}");
  }


}