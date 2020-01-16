import 'package:eco_mfi/Utilities/ThemeDesign.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/BranchMaster/BranchMasterBean.dart';
import 'package:eco_mfi/pages/workflow/BulkLoanPreClosure/bean/BulkLoanPreClosureBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/PostBulkLoanClosureTranstnToOmni.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/MiniStatementBean.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BulkLoanPreClosureList extends StatefulWidget {
  static const String routeName = '/material/data-table';
  final List<BulkLoanPreClosureBean> closureBean;
  BulkLoanPreClosureList(this.closureBean);

  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );

  @override
  _BulkLoanPreClosureList createState() =>
      _BulkLoanPreClosureList();
}

class _BulkLoanPreClosureList
    extends State<BulkLoanPreClosureList> {

  bool showPersInfo = false;
  List<int> indicesList = new List<int>();
  List<BulkLoanPreClosureBean> closureList=new List<BulkLoanPreClosureBean>();
  bool isDataSynced = false;
  bool circIndicatorIsDatSynced = false;
  List<MiniStatementBean> miniStatementBean;
  Utility utility = new Utility();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  bool circInd  =false;
  SharedPreferences prefs;
  int branch;
  BranchMasterBean branchMasterBean= null;
  bool showGraph = true;
  List<BulkLoanPreClosureBean> closureBean;
  Utility obj = new Utility();
  List<BulkLoanPreClosureBean> bulkLoanPreClosureBean;
  List<BulkLoanPreClosureBean> accList = List();
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String printingCenterName = "";
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  String username;
  final dateFormat = DateFormat("yyyy/MM/dd hh:mm:ss");


  @override
  void initState() {
    super.initState();

    if(widget.closureBean!=null){
      closureList =widget.closureBean;
    }
    if(closureList == null){
      closureList =List();
    }
    getSessionVariables();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode);
      username = prefs.getString(TablesColumnFile.musrname);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

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
          Translations.of(context).text('Loan_Pre-Closure_List'),
          //textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.save, color: Colors.white),
            onPressed: () {
              print('save data');
              onPop( context,
                  'Are you sure?',
                  'Do you want to close the account(s)?');
            },
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: new Container(
        child: new Form(
          key: _formKey,
          autovalidate: false,
          onWillPop: () {
            return Future(() => true);
          },
          onChanged: () async {
            final FormState form = _formKey.currentState;
            form.save();
          },
        child: new Stack(
          children: <Widget>[
             new Column(
                children: <Widget>[
                  new Expanded(child:
                  ListView.builder(
                      itemCount: closureList.length,
                      itemBuilder: (context, position) {
                        return new GestureDetector(

                          child: new Column(
                            children: <Widget>[
                              new Card(
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
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
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
                                          child: Column(
                                            children: <Widget>[
                                              new Text(
                                                closureList[position].mcustname.trim(),
                                                overflow: TextOverflow.fade,
                                                style: new TextStyle(
                                                    fontSize: 18.0,
                                                    fontStyle: FontStyle.normal,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              new Row(
                                                children: <Widget>[
                                                  new Text(
                                                      " "+closureList[position].mprdacctid,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white)),
                                                  Text(
                                                    "      Cust No: ${closureList[position].mcustno}",
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                  Text(
                                                    "   GNO: ${closureList[position].mgroupcd}",
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              new Row(
                                                children: <Widget>[
                                                  Text(
                                                    " InstStartDt: ${(closureList[position].minststartdt)}",
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                  Text(
                                                    "       Pre-Close Loan",
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  new Checkbox(
                                                      activeColor: Colors.orange[200],
                                                      value: closureList[position].issubmit == null ||
                                                          closureList[position].issubmit == 0
                                                          ? false
                                                          : true,
                                                      onChanged: (val) {
                                                        setState(() {
                                                          closureList[position].issubmit =
                                                          val == false ? 0 : 1;
                                                        });
                                                      }),
                                                ],
                                              )
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
                                                new Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    new Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        new Container(
                                                          // width: 100.0,
                                                          child: Text(
                                                            " Excess Amt: ${closureList[position].mexcessamt}\n",
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              color: closureList[position].mexcessamt != 0
                                                                  ? Colors.red
                                                                  : Colors.grey[500],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 3.0,
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            "   Inst Amt: ${closureList[position].minstlamt}\n",
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              color: Colors.grey[500],
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          // width:  100.0,
                                                          child: Text(
                                                            "   Amt to Col: ${closureList[position].mamttocollect}\n",
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              color: Colors.grey[500],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceAround,
                                                      children: <Widget>[
                                                        Container(
                                                          // width:  100.0,
                                                          child: Text(
                                                            " Principal O/S: ${closureList[position].mprincipleos}\n",
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              color: Colors.grey[500],
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          // width:  100.0,
                                                          child: Text(
                                                            "   Int O/S: ${(closureList[position].minterestos).toStringAsFixed(2)}\n",
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              color: Colors.grey[500],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    new Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        new Container(
                                                          width: 190.0,
                                                          child: new TextFormField(
                                                            controller:
                                                            closureList[position].mremarks != null
                                                                ? TextEditingController(
                                                                text: closureList[position]
                                                                    .mremarks)
                                                                : TextEditingController(
                                                                text: ""),
                                                            onSaved: (String value) {
                                                              closureList[position].mremarks = value;
                                                            },
                                                            keyboardType:
                                                            TextInputType.multiline,
                                                            decoration: new InputDecoration(
                                                                border: new OutlineInputBorder(
                                                                    borderSide: new BorderSide(
                                                                        color: Colors.teal)),
                                                                hintText: 'Enter Rremarks Here',
                                                                labelText: 'Remarks',
                                                                prefixText: '',
                                                                suffixText: '',
                                                                suffixStyle: const TextStyle(
                                                                    color: Colors.green)),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        Container(
                                                          width: 140.0,
                                                          child: new TextFormField(
                                                            controller:
                                                            closureList[position].mcollamt != null
                                                                ? TextEditingController(
                                                                text: closureList[position]
                                                                    .mcollamt
                                                                    .toString())
                                                                : TextEditingController(
                                                                text: ""),
                                                            onSaved: (String value) {
                                                              try {
                                                                closureList[position].mcollamt =
                                                                    double.parse(value);
                                                              } catch (_) {}
                                                            },
                                                            keyboardType: TextInputType
                                                                .numberWithOptions(),
                                                            decoration: new InputDecoration(
                                                                border: new OutlineInputBorder(
                                                                    borderSide: new BorderSide(
                                                                        color: Colors.teal)),
                                                                hintText: Translations.of(context).text('Enter_Amt_Collected_Here'),
                                                                labelText: Translations.of(context).text('Amt_Collected'),
                                                                suffixIcon: IconButton(
                                                                    icon: Icon(Icons.clear),
                                                                    onPressed: () {
                                                                      setState(() {
                                                                        closureList[position].mcollamt=null;
                                                                      });
                                                                    }),
                                                                prefixText: '',
                                                                suffixText: '',
                                                                suffixStyle: const TextStyle(
                                                                    color: Colors.green)),
                                                          ),
                                                        )
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
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }))
                ],
              ),
          ],
        ),
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
            ),
            body,
          ],
        ),
      ),
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

  Future<void> _ShowProgressInd(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translations.of(context).text('Please_Wait')),
          content: SingleChildScrollView(
              child: SpinKitCircle(color: Colors.amber.shade500)
          ),
        );
      },
    );
  }

  Future<bool> onPop(BuildContext context, String agrs1, String args2) {
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
              accList.clear();
              for (int saveData = 0; saveData < closureList.length; saveData++) {
                if(closureList[saveData].mcollamt!=null && closureList[saveData].issubmit == 1 ) {
                  accList.add(closureList[saveData]);
                }
              }

              PostBulkLoanClosureTranstnToOmni postBulkLoanClosureTranstnToOmni = new PostBulkLoanClosureTranstnToOmni();
              postBulkLoanClosureTranstnToOmni.trySave(accList).then((List<BulkLoanPreClosureBean> bulkLoanPreClosureBean) async {

                this.bulkLoanPreClosureBean = bulkLoanPreClosureBean;

                bool netAvail = false;
                netAvail = await obj.checkIfIsconnectedToNetwork();
                if (netAvail == false) {
                  showMessageWithoutProgress("Network Not available");
                  return;
                }
                else
                {
                  bool success= false;
                  if(bulkLoanPreClosureBean[0].momnimsg != null || bulkLoanPreClosureBean[0].momnimsg != "null" || bulkLoanPreClosureBean[0].momnimsg != ""){
                    if(bulkLoanPreClosureBean[0].momnimsg.toLowerCase().contains('success')){
                      success = true;
                    }

                    _ShowOmniMsg(bulkLoanPreClosureBean[0].momnimsg , success);
                    circInd = false;
                  }
                }
              });
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future<void> _ShowOmniMsg(String momnimsg,bool isSuccess) async {

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
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
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(Translations.of(context).text('print'),style: TextStyle(color: isSuccess==true?Colors.black:Colors.grey),),
                onPressed: () async {

                  if(isSuccess==true){


                    _callChannelBulkLoanClosureReceiptPrint(accList);
                  }

                },
              ),

            ],
          );
        });
  }



  _callChannelBulkLoanClosureReceiptPrint(
      List<BulkLoanPreClosureBean> bulkLoanPreClosuerList) async {

    await AppDatabase.get()
        .getCenterFromCenterId(bulkLoanPreClosuerList[0].mcenterid)
        .then((CenterDetailsBean centerBean) {
      printingCenterName = centerBean.mcentername;
    });


    String repeatedStringAmount = "";
    double totalAmountCollected = 0.0;
    String repeatedStringCustNo = "";
    print("bulLoanClosureListnListBeanList" + bulkLoanPreClosuerList.toString());
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    String branchName = prefs.getString(TablesColumnFile.branchname);
    print("bluetoothAddress $bluetootthAdd");
    if (bulkLoanPreClosuerList != null && bulkLoanPreClosuerList != "") {
      for (var items in bulkLoanPreClosuerList) {
        repeatedStringAmount =
            items.mcollamt.toString() + "~" + repeatedStringAmount;
        totalAmountCollected += items.mcollamt;
        repeatedStringCustNo =
            items.mcustno.toString() + "~" + repeatedStringCustNo;
      }
      print("repeatedStringAmount" + repeatedStringAmount);
      String repeatedStringEntryDate = "";
      for (var items in bulkLoanPreClosuerList) {
        repeatedStringEntryDate =
            DateTime.now().toString() + "~" + repeatedStringEntryDate;
      }
      print("repeatedStringEntryDate" + repeatedStringEntryDate);

      String repeatedStringprdAccId = "";
      for (var items in bulkLoanPreClosuerList) {
        print("items.mprdacctid" + items.mprdacctid.toString());
        if (items.mprdacctid.trim() != '') {
          repeatedStringprdAccId =
              items.mprdacctid.toString() +
                  "~" +
                  repeatedStringprdAccId;
        }
        if (items.mprdacctid.trim() == '') {
          repeatedStringprdAccId =
              "AccId Not Found" + "~" + repeatedStringprdAccId;
        }
      }
      print("repeatedStringprdAccId" + repeatedStringprdAccId.toString());

      String mgroupcd = bulkLoanPreClosuerList[0].mgroupcd.toString();
      String date = dateFormat.format(DateTime.now());

      // String mlongname = savingsListBeanList[0].mlongname.toString();

      try {
        final String result =
        await platform.invokeMethod("loanClosureGroupPrint", {
          "BluetoothADD": bluetootthAdd,
          "mlbrcode": branch.toString(),
          "date": date,
          "mgroupcd": mgroupcd,
          "repeatedStringAmount": repeatedStringAmount,
          "repeatedStringprdAccId": repeatedStringprdAccId,
          "repeatedStringEntryDate": repeatedStringEntryDate,
          "branchName": branchName,
          "company": "Wasaasaa", //companyName
          "trefno": "    ",
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






}