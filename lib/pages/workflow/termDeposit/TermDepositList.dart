import 'package:eco_mfi/pages/workflow/termDeposit/SyncingNewTermDepositToMiddleware.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/ThemeDesign.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/NewTermDeposit.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/NewTermDepositBean.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermDepositList extends StatefulWidget {

  TermDepositList();

  @override
  _TermDepositList createState() => new _TermDepositList();
}

class _TermDepositList extends State<TermDepositList> {
  NewTermDepositBean loanDetObj = new NewTermDepositBean();
  List<NewTermDepositBean> items = new List<NewTermDepositBean>();
  List<NewTermDepositBean> storedItems = new List<NewTermDepositBean>();
  Widget appBarTitle = new Text("Term Deposit List");
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
  DateTime lastSyncedToServerDaeTime = null;
  var formatter = new DateFormat('yyyy-MM-dd');

  bool circInd = false;
  NewTermDepositBean customerListBean;
  int count;

  Icon actionIcon = new Icon(Icons.search);

  @override
  void initState() {
    count = 1;
    items.clear();
    super.initState();
    getSessionVariables();
  }

  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString(TablesColumnFile.usrCode);
      usrCode = prefs.getString(TablesColumnFile.usrCode);
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      branch = prefs.get(TablesColumnFile.musrbrcode).toString();
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.geoLocation);
      geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
    });


    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(13, false)
        .then((onValue) async {
      lastSyncedToServerDaeTime = onValue;
    });
  }

  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) {
    print("snapshaot datya " + snapshot.data.toString());
    if (snapshot.data != null) {
      print("stored item length is ${storedItems.length}");
      print("items item length is ${items.length}");
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.all(0.0),
      );
    }
  }

  Widget _getItemUI(BuildContext context, int index) {
    double c_width = MediaQuery
        .of(context)
        .size
        .width * 10;
    int mcustNoInt = 0;
    int mprcdAcctIdInt = 0;
    String mprdcd = "";
    String custNo = "";
    String prcdAcctId = "";

    bool isSyncedIndex = false;

    if ((items[index].mlastsynsdate == null ||
        items[index].mlastsynsdate == 'null' ||
        (items[index].mcreateddt != null &&
            items[index].mcreateddt != 'null' &&
            items[index].mcreateddt.isAfter(items[index].mlastsynsdate)) ||
        (items[index].mlastupdatedt != null &&
            items[index].mlastupdatedt != 'null' &&
            items[index].mlastupdatedt.isAfter(items[index].mlastsynsdate)) ||
        (items[index].mrefno == null || items[index].mrefno == 0))&&(
        items[index].mprdacctid==null||items[index].mprdacctid.trim()=="0"|| items[index].mprdacctid==""
            || items[index].mprdacctid.trim()=="null"

    )) {
      isSyncedIndex = true;
    }

    bool  isPrintingAvail=true;
    if(   items[index].mprdacctid==null||
        items[index].mprdacctid.trim()=="0"||
        items[index].mprdacctid.trim()==""||
        items[index].mprdacctid.trim() =="null"
    )isPrintingAvail =false;
    String errorMsg = "";
    if(items[index].merrormessage != null &&
        items[index].merrormessage.toString() != "" &&
        items[index].merrormessage.toString() != "null"
    ){

      try{
        int.parse(items[index].merrormessage.trim());
        errorMsg = "System Busy Please try again ${items[index].merrormessage.trim()}";
      }catch(_){
        errorMsg = items[index].merrormessage;
      }
    }

    print("inside get item ui");
    mprdcd = items[index].mprdcd.toString();
    custNo = items[index].mcustno.toString();
    prcdAcctId = items[index].mprdacctid.toString();

    print("items[index].mprdcd " + mprdcd.toString());
    if (mprdcd == null || mprdcd == 'null' || mprdcd.trim() == "") {
      print("items[index].mprdcd " + items[index].mprdcd.toString());
      mprdcd = items[index].mprdcd;
    }

    if (custNo == null || custNo == 'null' || custNo.trim() == "") {
      print("items[index].mprdcd " + items[index].mprdcd.toString());
      custNo = items[index].mcustno.toString();
    }
    try {
      if (custNo != null && custNo != 'null') {
        mcustNoInt = int.parse(custNo);
      }
      if (prcdAcctId != null && prcdAcctId != 'null') {
        mprcdAcctIdInt = int.parse(prcdAcctId);
      }
    } catch (_) {
      print("Exception Here in catch future builder");
    }
    return new GestureDetector(
      onTap: () {
        _onTapItem(items[index]);
      },
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
                        //firstName+" "+middleName+" "+lastName,
                        "  ${items[index].mlongname}",
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      new Container(
                          padding: EdgeInsets.only(left: 5.0),
                          //color: Colors.green,
                          child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "TrefNo : " ,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.yellow),
                                ),
                              ),
                              Text(
                                items[index].trefno.toString() +
                                    "   ",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white),
                              ),

                              SizedBox(),
                              Text(
                                "MrefNo : "
                                ,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.yellow),
                              ),
                              Text(

                                items[index].mrefno.toString() +
                                    "   ",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white),
                              ),


                              Padding(
                                padding: new EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    new Text(
                                      "Cust No : ",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.yellow),
                                    ),
                                    new Text(
                                      items[index].mcustno.toString(),
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: new EdgeInsets.only(
                                    left: 30.0, right: 10.0),
                                child: Row(
                                  children: <Widget>[


                                  ],
                                ),
                              ),
                            ],
                          )),
                      new Container(
                          padding: EdgeInsets.only(left: 5.0),
                          //color: Colors.green,
                          child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,

                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0,top: 4.0),
                                child: new Text(
                                  "PrdAcc Id : ",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.yellow),
                                ),
                              ),

                              new Text(
                                items[index].mprdacctid.toString(),
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white),
                              )


                            ],
                          )),
                      /*new Container(
                        child:
                        new Container(
                          child: isPrintingAvail
                              ? new IconButton(
                            icon: new Icon(
                              FontAwesomeIcons.print,
                              color: Colors.green[400],
                              size: 20.0,
                            ),
                            onPressed: () async {

                            },
                          )
                              : new IconButton(
                            icon: new Icon(
                              FontAwesomeIcons.print,
                              color: Colors.grey,
                              size: 20.0,
                            ),
                            onPressed: () async {
                              showMessageWithoutProgress(
                                  "Cannot Print until PrdAcc Id is there");
                            },
                          ),



                        ),
                      )*/


                    ],
                  ),
                ),
              ),
        errorMsg==''?new Container():new Container (
                child: new Row (
                  children: [
                    new Expanded(
                      child: new Text (errorMsg,
                        style: TextStyle(
                            fontSize: 12.0, color: Colors.red[500]),
                      ),
                    ),
                  ],
                ),
                decoration: new BoxDecoration (
                  // backgroundColor: Colors.grey[300],
                ),

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

                            new Padding(
                              padding: new EdgeInsets.only(
                                /*   top: 1.0,
                                  bottom: 1.0,*/
                              ),
                              child: new Row(
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: new Text(
                                      " Amount : ",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ),
                                  new Text(
                                    "${items[index]
                                        .mmainbalfcy}",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  new Text(
                                    " Maturity Dt : ",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  new Text(
                                    "${formatter.format(items[index]
                                        .mmatdate)}",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  isSyncedIndex
                                      ? new IconButton(
                                    icon: new Icon(
                                      FontAwesomeIcons.sync,
                                      color: Colors.orange[400],
                                      size: 25.0,
                                    ),
                                    onPressed: () async {
                                      _syncTDToMiddleware(items[index]);
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
                  ],
                ),
              ),

              new Row(
                children: <Widget>[



                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new Text(
                      " Mat  Value: ",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  new Text(
                    "${items[index]
                        .mmatval}",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Open Date : ",
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey[500]),
                    ),
                  ),

                  Text(
                    formatter.format(items[index]
                        .mcreateddt)
                        .toString(),
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black),
                  ),





                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var loanDetailsBuilder;

    if (/*storedItems.isEmpty||storedItems==null*/ count == 1 || count == 2) {
      count++;
      print("inside case 1 ");
      loanDetailsBuilder = new FutureBuilder(
          future: AppDatabase.get()
              .getTermDepositList()
              .then((List<NewTermDepositBean> utilizationData) {
            items.clear();
            storedItems.clear();
            utilizationData.forEach((f) {
              items.add(f);
              storedItems.add(f);
            });

            print("items length is ${items.length}");
            return items;
          }),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new Text('Press button to start');
              case ConnectionState.waiting:
                return new Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child:
                    new CircularProgressIndicator()); // new Text('Awaiting result...');
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else {
                  print("trying to run homepage");
                  return getHomePageBody(context, snapshot);
                }
            }
          });
    } else if (storedItems != null) {
      loanDetailsBuilder = ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, position) {
            double c_width = MediaQuery
                .of(context)
                .size
                .width * 10;
            int mcustNoInt = 0;
            int mprcdAcctIdInt = 0;
            String mprdcd = "";
            String custNo = "";
            String prcdAcctId = "";



            bool isSyncedIndex = false;

            if ((items[position].mlastsynsdate == null ||
                items[position].mlastsynsdate == 'null' ||
                (items[position].mcreateddt != null &&
                    items[position].mcreateddt != 'null' &&
                    items[position].mcreateddt.isAfter(items[position].mlastsynsdate)) ||
                (items[position].mlastupdatedt != null &&
                    items[position].mlastupdatedt != 'null' &&
                    items[position].mlastupdatedt.isAfter(items[position].mlastsynsdate)) ||
                (items[position].mrefno == null || items[position].mrefno == 0))&&(
                items[position].mprdacctid==null||
                    items[position].mprdacctid.trim()=="0"||
                    items[position].mprdacctid.trim()==""||
                    items[position].mprdacctid.trim() =="null"

            )) {
              isSyncedIndex = true;
            }

            bool  isPrintingAvail=true;
            if(   items[position].mprdacctid==null||
                items[position].mprdacctid.trim()=="0"||
                items[position].mprdacctid.trim()==""||
                items[position].mprdacctid.trim() =="null"
            )isPrintingAvail =false;


            String errorMsg = "";
            if(items[position].merrormessage != null &&
                items[position].merrormessage.toString() != "" &&
                items[position].merrormessage.toString() != "null"
            ){

              try{
                int.parse(items[position].merrormessage.trim());
                errorMsg = "System Busy Please try again ${items[position].merrormessage.trim()}";
              }catch(_){
                errorMsg = items[position].merrormessage;
              }
            }


            mprdcd = items[position].mprdcd.toString();
            custNo = items[position].mcustno.toString();
            prcdAcctId = items[position].mprdacctid.toString();

            print("items[index].mprdcd " + mprdcd.toString());
            if (mprdcd == null || mprdcd == 'null' || mprdcd.trim() == "") {
              print("items[index].mprdcd " + items[position].mprdcd.toString());
              mprdcd = items[position].mprdcd;
            }

            if (custNo == null || custNo == 'null' || custNo.trim() == "") {
              print("items[index].mprdcd " + items[position].mprdcd.toString());
              custNo = items[position].mcustno.toString();
            }
            try {
              if (custNo != null && custNo != 'null') {
                mcustNoInt = int.parse(custNo);
              }
              if (prcdAcctId != null && prcdAcctId != 'null') {
                mprcdAcctIdInt = int.parse(prcdAcctId);
              }
            } catch (_) {}

            return new GestureDetector(
              onTap: () {
                _onTapItem(items[position]);
              },
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
                                //firstName+" "+middleName+" "+lastName,
                                "  ${items[position].mlongname}",
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              new Container(
                                  padding: EdgeInsets.only(left: 5.0),
                                  //color: Colors.green,
                                  child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[


                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "TrefNo : " ,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.yellow),
                                        ),
                                      ),
                                      Text(
                                            items[position].trefno.toString() +
                                            "   ",
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white),
                                      ),

                                      SizedBox(),
                                      Text(
                                        "MrefNo : "
                                            ,
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.yellow),
                                      ),
                                      Text(

                                            items[position].mrefno.toString() +
                                            "   ",
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white),
                                      ),


                                      Padding(
                                        padding: new EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        child: Row(
                                          children: <Widget>[
                                            new Text(
                                              "Cust No : ",
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.yellow),
                                            ),
                                            new Text(
                                        items[position].mcustno.toString(),
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: new EdgeInsets.only(
                                            left: 30.0, right: 10.0),

                                      ),
                                    ],
                                  )),
                              new Container(
                                  padding: EdgeInsets.only(left: 5.0),
                                  //color: Colors.green,
                                  child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,

                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0,top: 4.0),
                                        child: new Text(
                                          "PrdAcc Id : ",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.yellow),
                                        ),
                                      ),

                          new Text(
                            items[position].mprdacctid.toString(),
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white),
                          )

                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),

                  errorMsg!=""?new Container (
                        child: new Row (
                          children: [
                            new Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0,top: 4.0),
                                child: new Text (errorMsg,
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.red[500]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: new BoxDecoration (
                          // backgroundColor: Colors.grey[300],
                        ),

                      ):new Container(),
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
                                    new Padding(
                                      padding: new EdgeInsets.only(
                                        /*   top: 1.0,
                                  bottom: 1.0,*/
                                      ),
                                      child: new Row(
                                        textBaseline: TextBaseline.alphabetic,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                        children: <Widget>[

                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: new Text(
                                              " Amount : ",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ),
                                          new Text(
                                            "${items[position]
                                                .mmainbalfcy}",
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          new Text(
                                            " Maturity Dt : ",
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                          new Text(
                                            "${formatter.format(items[position]
                                                .mmatdate)}",
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          isSyncedIndex
                                              ? new IconButton(
                                            icon: new Icon(
                                              FontAwesomeIcons.sync,
                                              color: Colors.orange[400],
                                              size: 20.0,
                                            ),
                                            onPressed: () async {
                                              _syncTDToMiddleware(items[position]);
                                            },
                                          )
                                              : new IconButton(
                                            icon: new Icon(
                                              FontAwesomeIcons.sync,
                                              color: Colors.grey,
                                              size: 20.0,
                                            ),
                                            onPressed: () async {
                                              showMessageWithoutProgress(
                                                  "Loan Already Synced");
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),

                                  ],
                                ),
                              ],
                            ),



                          ],
                        ),
                      ),

                      new Row(
                        children: <Widget>[



                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text(
                                  " Mat  Value: ",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ),
                              new Text(
                                "${items[position]
                                    .mmatval}",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black,
                                ),
                              ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Open Date : ",
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey[500]),
                            ),
                          ),

                          Text(
                            formatter.format(items[position]
                                .mcreateddt)
                                .toString(),
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black),
                          ),

                          /*isPrintingAvail
                              ? new IconButton(
                            icon: new Icon(
                              FontAwesomeIcons.print,
                              color: Colors.green[400],
                              size: 20.0,
                            ),
                            onPressed: () async {

                            },
                          )
                              : new IconButton(
                            icon: new Icon(
                              FontAwesomeIcons.print,
                              color: Colors.grey,
                              size: 20.0,
                            ),
                            onPressed: () async {
                              showMessageWithoutProgress(
                                  "Cannot Print until PrdAcc Id is there");
                            },
                          ),*/



                            ],
                      )



                    ],
                  ),
                ),
              ),
            );
          });
    }

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
                      // filterList(val.toLowerCase());
                    },
                  );
                } else {
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text("Term Deposit List");
                  items = new List<NewTermDepositBean>();
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
      floatingActionButton: new FloatingActionButton(
          child: new Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: Colors.green,
          onPressed: () {
            _addNewTermDepositAccount();
          }),
      body: loanDetailsBuilder,
    );
  }

  void _addNewTermDepositAccount() {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) =>
          new NewTermDeposit()), //When Authorized Navigate to the next screen
    );
  }

  void _onTapItem(NewTermDepositBean item) {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) =>
          new NewTermDeposit(
            onTapBean: item,
          )), //When Authorized Navigate to the next screen
    );
  }


  Future<void> _syncTDToMiddleware(NewTermDepositBean item) async {
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
                syncTD(item);
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


  void syncTD(NewTermDepositBean item) async {
    try {
      bool isNetworkAvalable = await Utility.checkIntCon();
      if (isNetworkAvalable == false) {
        showMessageWithoutProgress("Network not Awailable");
      }

      SyncTDListToMiddleware tdSyncingService =
      new SyncTDListToMiddleware();
      await tdSyncingService.SyncSingleTDToMiddleware(
          item, lastSyncedToServerDaeTime,usrCode)
          .then((CustomerTDCheckBean custTdCheckbean) async {
        Navigator.of(context).pop();


        if (custTdCheckbean!=null ) {
          _successfulSingleLoanSyncedToServer(custTdCheckbean, item.trefno);



        } else {
          showMessageWithoutProgress("SomeThing wentWrong Syncing Loan");
        }

      });



    } catch (_) {}
  }


  void showMessageWithoutProgress(String message,
      [MaterialColor color = Colors.red]) {
     try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }


  Future<void> _ShowCircInd(NewTermDepositBean item) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translations.of(context).text('SyncingTD')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[CircularProgressIndicator()],
            ),
          ),
        );
      },
    );
  }




  Future<void> _successfulSingleLoanSyncedToServer(
      CustomerTDCheckBean custChkObj, int trefno) async {
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
                      'TD Synced to server for mrefno : ${custChkObj.mrefno} And trefno : ${trefno}'),
                  Text(
                      'CustNo : ${custChkObj.mcustno} '),
                  Text(
                      'Prd ACC ID : ${custChkObj.mprdacctid} '),
                  Text(
                      'Error Message : ${custChkObj.merrormessage} '),

                  Text(
                      'Maturity Value : ${custChkObj.mmatval}'),


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
                        new TermDepositList()
                    ),
                  );




                },
              ),
            ],
          );
        });
  }



}
