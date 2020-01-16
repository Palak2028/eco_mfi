import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/ThemeDesign.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/Savings/NewAccountOpening.dart';
import 'package:eco_mfi/pages/workflow/Savings/ViewMinistatementTable.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/MiniStatementBean.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetMiniStatementFromMiddleware.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavingsAccountList extends StatefulWidget {
  final String routeType;
  SavingsAccountList(this.routeType);
  @override
  _SavingsAccountList createState() => new _SavingsAccountList();
}

class _SavingsAccountList extends State<SavingsAccountList> {
  SavingsListBean loanDetObj = new SavingsListBean();
  List<SavingsListBean> items = new List<SavingsListBean>();
  List<SavingsListBean> storedItems = new List<SavingsListBean>();
  Widget appBarTitle = new Text("Savings Account List");
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
  CustomerListBean customerListBean;
  int count;
  bool isDataSynced = false;
  bool circIndicatorIsDatSynced = false;
  List<MiniStatementBean> miniStatementBean;
  bool circInd  =false;



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
  }

  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.all(0.0),
      );
    }
  }

  Widget _getItemUI(BuildContext context, int index) {
    double c_width = MediaQuery.of(context).size.width * 10;
    int mcustNoInt = 0;
    int mprcdAcctIdInt = 0;
    String mprdcd = "";
    String custNo = "";
    String prcdAcctId = "";
    double TotalBalance=0.0;

    print("inside get item ui");

    if (items[index].mprdacctid != null &&
        items[index].mprdacctid != "null" &&
        items[index].mprdacctid != "") {
      mprdcd = items[index].mprdacctid.substring(0, 8).trim();
      custNo = items[index].mprdacctid.substring(8, 16);
      prcdAcctId = items[index].mprdacctid.substring(16, 24);
    }



    if (items[index].macttotbalfcy != null &&
        items[index].macttotbalfcy != "null" &&
        items[index].macttotbalfcy != "") {
      TotalBalance = items[index].macttotbalfcy;

    }
    else   if (items[index].mtotallienfcy != null &&
        items[index].mtotallienfcy != "null" &&
        items[index].mtotallienfcy != "") {
      TotalBalance = items[index].mtotallienfcy;

    }
    else   if ((items[index].mtotallienfcy != null &&
        items[index].mtotallienfcy != "null" &&
        items[index].mtotallienfcy != "")&&(items[index].macttotbalfcy != null &&
        items[index].macttotbalfcy != "null" &&
        items[index].macttotbalfcy != "")) {
      TotalBalance = items[index].mtotallienfcy+items[index].macttotbalfcy;

    }
    // print("items[index].mprdcd " + mprdcd.toString());
    if (mprdcd == null || mprdcd == 'null' || mprdcd.trim() == "") {
      // print("items[index].mprdcd " + items[index].mprdcd.toString());
      mprdcd = items[index].mprdcd;
    }

    if (custNo == null || custNo == 'null' || custNo.trim() == "") {
      //  print("items[index].mprdcd " + items[index].mprdcd.toString());
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
      //    print("Exception Here in catch future builder");
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Text(
                              Translations.of(context).text('Available_Balance')+
                              TotalBalance.toString() ,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            ),
                          ],
                        ),),

                      SizedBox(
                        height: 5.0,
                      ),
                      new Container(
                          padding: EdgeInsets.only(left: 5.0),
                          //color: Colors.green,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                Translations.of(context).text('Trefno') +
                                    items[index].trefno.toString() +
                                    "   ",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                              ),
                              Padding(
                                padding: new EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    new Text(
                                      mcustNoInt.toString() +
                                          "/" +
                                          mprdcd.toString() +
                                          "/" +
                                          mprcdAcctIdInt.toString(),
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: new EdgeInsets.only(
                                    left: 30.0, right: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      items[index].macctstat == 1
                                          ? "Normal/Operative"
                                          : items[index].macctstat == 2
                                          ? "New"
                                          : items[index].macctstat == 3
                                          ? "Closed"
                                          : items[index].macctstat == 14
                                          ? "WrittenOff"
                                          : "NPA",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellowAccent),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      new Container(
                          padding: EdgeInsets.only(left: 5.0),
                          //color: Colors.green,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[

                              Padding(
                                  padding: new EdgeInsets.only(
                                      left: 1.0, right: 10.0),
                                  child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,

                                    children: <Widget>[
                                      Text(
                                        Translations.of(context).text('Open_Date') +
                                            items[index]
                                                .mdateopen
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white),
                                      ),
                                    ],
                                  )
                              ),
                              Padding(
                                padding: new EdgeInsets.only(
                                    left: 5.0, right: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      items[index].mfreezetype == 1
                                          ? "No Freez"
                                          : "Total Freez",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              new Container(
                child: new Row (
                  children: [
                    new Expanded(
                      child: new Text (items[index].merrormessage!=null&&items[index].merrormessage.toString()!=""&&items[index].merrormessage.toString()!="null"?items[index].merrormessage.toString():'',
                        style: TextStyle(
                            fontSize: 12.0, color: Colors.red[500]),
                      ),
                    ),
                  ],
                ),
                decoration: new BoxDecoration (
                  // backgroundColor: Colors.grey[300],
                ),
                width: 400.0,
              ),
              new Container(
                width: c_width,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 8.0,
                            ),
                            new Padding(
                              padding: new EdgeInsets.only(
                                /*   top: 1.0,
                                  bottom: 1.0,*/
                              ),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: <Widget>[
                                  new Text(
                              Translations.of(context).text('GNO')+"${items[index].mgroupcd}",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    Translations.of(context).text('CNO')+"${items[index].mcenterid}",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            new Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                textBaseline: TextBaseline.alphabetic,
                                //crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: <Widget>[
                                  new OutlineButton(
                                      borderSide:
                                      BorderSide(color: Colors.white),
                                      child: Text(Translations.of(context).text('Check_Balance')),
                                      textColor: Colors.blue,
                                      onPressed: () {
                                        _CheckBalance(
                                            items[index].macttotbalfcy,
                                            items[index]
                                                .mtotallienfcy);
                                      },
                                      shape: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      )),
                                  new OutlineButton(
                                      borderSide:
                                      BorderSide(color: Colors.blue),
                                      child: Text( Translations.of(context).text('Mini_Statement')),
                                      textColor: Colors.blue,
                                      onPressed: () async {
                                        circInd = true;
                                        //  Navigator.of(context).pop();
                                        _ShowCircInd(context);
                                        getMiniStatement(items[index].mprdacctid);
                                      },
                                      shape: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      )),
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
      //  print("inside case 1 ");
      loanDetailsBuilder = new FutureBuilder(
          future: AppDatabase.get()
              .getSavingsAccountDetails()
              .then((List<SavingsListBean> utilizationData) {
            items.clear();
            storedItems.clear();
            utilizationData.forEach((f) {
              items.add(f);
              storedItems.add(f);
            });

            //  print("items length is ${items.length}");
            return items;
          }),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new Text(Translations.of(context).text('Press_Button_To_Start'));
              case ConnectionState.waiting:
                return new Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child:
                    new CircularProgressIndicator()); // new Text('Awaiting result...');
              default:
                if (snapshot.hasError)
                  return new Text(Translations.of(context).text('error') +"${snapshot.error}");
                else {
                  //  print("trying to run homepage");
                  return getHomePageBody(context, snapshot);
                }
            }
          });
    } else if (storedItems != null) {
      loanDetailsBuilder = ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, position) {
            double c_width = MediaQuery.of(context).size.width * 10;
            int mcustNoInt = 0;
            int mprcdAcctIdInt = 0;
            String mprdcd = "";
            String custNo = "";
            String prcdAcctId = "";
            double TotalBalance=0.0;
            if (items[position].macttotbalfcy != null &&
                items[position].macttotbalfcy != "null" &&
                items[position].macttotbalfcy != "") {
              TotalBalance = items[position].macttotbalfcy;

            }
            else   if (items[position].mtotallienfcy != null &&
                items[position].mtotallienfcy != "null" &&
                items[position].mtotallienfcy != "") {
              TotalBalance = items[position].mtotallienfcy;

            }
            else   if ((items[position].mtotallienfcy != null &&
                items[position].mtotallienfcy != "null" &&
                items[position].mtotallienfcy != "")&&(items[position].macttotbalfcy != null &&
                items[position].macttotbalfcy != "null" &&
                items[position].macttotbalfcy != "")) {
              TotalBalance = items[position].mtotallienfcy+items[position].macttotbalfcy;

            }
            if (items[position].mprdacctid != null &&
                items[position].mprdacctid != "null" &&
                items[position].mprdacctid != "") {
              mprdcd = items[position].mprdacctid.substring(0, 8).trim();
              custNo = items[position].mprdacctid.substring(8, 16);
              prcdAcctId = items[position].mprdacctid.substring(16, 24);
            }
            //  print("items[index].mprdcd " + mprdcd.toString());
            if (mprdcd == null || mprdcd == 'null' || mprdcd.trim() == "") {
              //    print("items[index].mprdcd " + items[position].mprdcd.toString());
              mprdcd = items[position].mprdcd;
            }

            if (custNo == null || custNo == 'null' || custNo.trim() == "") {
              //    print("items[index].mprdcd " + items[position].mprdcd.toString());
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
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    new Text(
                                      Translations.of(context).text('Available_Balance')+
                                          TotalBalance.toString() ,
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.white),
                                    ),
                                  ],
                                ),),
                              SizedBox(
                                height: 5.0,
                              ),
                              new Container(
                                  padding: EdgeInsets.only(left: 5.0),
                                  //color: Colors.green,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        Translations.of(context).text('Trefno') +
                                            items[position].trefno.toString() +
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
                                              mcustNoInt.toString() +
                                                  "/" +
                                                  mprdcd.toString() +
                                                  "/" +
                                                  mprcdAcctIdInt.toString(),
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
                                            Text(
                                              items[position].macctstat == 1
                                                  ? "Normal/Operative"
                                                  : items[position].macctstat ==
                                                  2
                                                  ? "New"
                                                  : items[position]
                                                  .macctstat ==
                                                  3
                                                  ? "Closed"
                                                  : items[position]
                                                  .macctstat ==
                                                  14
                                                  ? "WrittenOff"
                                                  : "NPA",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.yellowAccent),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              new Container(
                                  padding: EdgeInsets.only(left: 5.0),
                                  //color: Colors.green,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[

                                      Padding(
                                          padding: new EdgeInsets.only(
                                              left: 1.0, right: 10.0),
                                          child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,

                                            children: <Widget>[
                                              Text(
                                                Translations.of(context).text('Open_Date') +
                                                    items[position]
                                                        .mdateopen
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          )
                                      ),
                                      Padding(
                                        padding: new EdgeInsets.only(
                                            left: 5.0, right: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text(
                                              items[position].mfreezetype == 1
                                                  ? "No Freez"
                                                  : "Total Freez",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                      new Container (
                        child: new Row (
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            new Expanded(
                              child: new Text (items[position].merrormessage!=null&&items[position].merrormessage.toString()!=""&&items[position].merrormessage.toString()!="null"?items[position].merrormessage.toString():'',
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.red[500]),
                              ),
                            ),
                          ],
                        ),
                        decoration: new BoxDecoration (
                          // backgroundColor: Colors.grey[300],
                        ),
                        width: 400.0,
                      ),
                      new Container(
                        width: c_width,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    new Padding(
                                      padding: new EdgeInsets.only(
                                        /*   top: 1.0,
                                  bottom: 1.0,*/
                                      ),
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        textBaseline: TextBaseline.alphabetic,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                        children: <Widget>[
                                          new Text(
                                      Translations.of(context).text('GNO')+"${items[position].mgroupcd}",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            Translations.of(context).text('CNO')+"${items[position].mcenterid}",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    new Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        textBaseline: TextBaseline.alphabetic,
                                        //crossAxisAlignment: CrossAxisAlignment.baseline,
                                        children: <Widget>[

                                          new OutlineButton(
                                              borderSide:
                                              BorderSide(color: Colors.blue),
                                              child: Text(Translations.of(context).text('Check_Balance')),
                                              textColor: Colors.blue,
                                              onPressed: () {
                                                _CheckBalance(
                                                    items[position].macttotbalfcy,
                                                    items[position]
                                                        .mtotallienfcy);
                                              },
                                              shape: new OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                              )),
                                          new OutlineButton(
                                              borderSide:
                                              BorderSide(color: Colors.blue),
                                              child: Text( Translations.of(context).text('Mini_Statement')),
                                              textColor: Colors.blue,
                                              onPressed: () async {
                                                circInd = true;
                                                //Navigator.of(context).pop();

                                                _ShowCircInd(context);
                                                getMiniStatement(items[position].mprdacctid);
                                              },
                                              shape: new OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                              )),
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
                        hintText: Translations.of(context).text('Search'),
                        hintStyle: new TextStyle(color: Colors.white)),
                    onChanged: (val) {
                      filterList(val.toLowerCase());
                    },
                  );
                }
                else {
                String svngListLeng = storedItems != null &&
                storedItems.length != null &&
                storedItems.length > 0
                ? "/" + storedItems.length.toString()
                    : "";
                this.actionIcon = new Icon(Icons.search);
                this.appBarTitle =
                new Text(Translations.of(context).text('Savings_List') + svngListLeng);
                items = new List<SavingsListBean>();
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
            _addNewSavingsAccount();
          }),
      body: loanDetailsBuilder,
    );
  }

  Future<void> _CheckBalance(double accbal, double totalien) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.account_balance,
              color: Colors.green,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Text(
                          Translations.of(context).text('Your_Current_Balance_Is') + accbal.toString()),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text(Translations.of(context).text('Your_Lien_Balance_Is') +
                          totalien.toString()),
                    ],
                  )
                  /*new Text("  Your Current Balance Is:",style: TextStyle(fontSize: 8.0),),

                  new Text("  ${loanDetObj.macttotbalfcy}",style: TextStyle(fontSize: 8.0),),*/
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



  Future<void> getMiniStatement(String mprdaccid) async {

    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });
    // showMessage(Constant.gettingSavingsList);
    GetMiniStatementFromMiddleware getMiniStatementFromMiddleware =
    new GetMiniStatementFromMiddleware();
    await getMiniStatementFromMiddleware.trySave(mprdaccid).then((List<MiniStatementBean> miniStatementBean) {
      this.miniStatementBean=miniStatementBean;
      print("miniStatementBean"+miniStatementBean.toString());
      Navigator.of(context).pop();
      //if(miniStatementBean.toString()=="null"||miniStatementBean==[]){
      if(miniStatementBean==null||miniStatementBean.isEmpty){
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

    /*  setState(() {
      circIndicatorIsDatSynced = false;
    });
    Navigator.of(context).push(ShowTranperentWorkflow(this.miniStatementBean));*/

  }

/*  void _CheckBalance() {
    print("Inside Check Balance");
    new Text(" ddsf");

  }*/
  void _addNewSavingsAccount() {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) =>
          new NewAccountOpening()), //When Authorized Navigate to the next screen
    );
  }

  void _onTapItem(SavingsListBean item) {
    // print("inside on tap loan util" + item.macctstat.toString());
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new NewAccountOpening(
            savingsListPassedObject: item,
          )), //When Authorized Navigate to the next screen
    );
  }

  void filterList(String val) async {
    //  print("inside filterList");
    items.clear();

    storedItems.forEach((obj) {
      if (obj.mdateopen.toString().contains(val) ||
          obj.trefno.toString().toLowerCase().contains(val) ||
          obj.mcenterid.toString().contains(val) ||
          obj.mgroupcd.toString().contains(val) ||
          obj.mlongname.toString().toUpperCase().contains(val.toUpperCase()) ||
          obj.macctstat.toString().contains(val) ||
          obj.mcustno.toString().contains(
              val) ) {

        items.add(obj);

      }

      if (val.toUpperCase() == "NEW") {
        if (obj.macctstat == 2) {
          items.add(obj);
          //   print(items);
        }
      }
      else if (val.toUpperCase() == "NORMAL" || val.toUpperCase() == "OPERATIVE") {
        if (obj.macctstat == 1) {
          items.add(obj);
          //   print(items);
        }
      }
      else  if (val.toUpperCase() == "CLOSED") {
        if (obj.macctstat == 3) {
          items.add(obj);
          //   print(items);
        }
      }
      else  if (val.toUpperCase() == "WRITTENOFF") {
        if (obj.macctstat == 3) {
          items.add(obj);
          //  print(items);
        }
      }
      else  {
        if (obj.macctstat == 11) {
          items.add(obj);
          //   print(items);
        }
      }

    });

    setState(() {
      count = 4;
    });
  }
  Future<void> _ShowCircInd(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,

      builder: (BuildContext context) {
        return AlertDialog(

          title: Text(Translations.of(context).text('Please_Wait')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                CircularProgressIndicator()


              ],
            ),

          ),

        );

      },

    );
  }
}
