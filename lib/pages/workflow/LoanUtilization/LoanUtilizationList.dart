
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/CGT/CGT1.dart';
import 'package:eco_mfi/pages/workflow/CGT/CGT2.dart';
import 'package:eco_mfi/pages/workflow/GRT/GRTTab.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/LoanLimitDetails.dart';

import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;

import 'package:eco_mfi/pages/workflow/LoanUtilization/LoanUtilization.dart';
import 'package:eco_mfi/pages/workflow/LoanUtilization/LoanUtilizationBean.dart';

import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoanUtilizationList extends StatefulWidget {
  final String routeType;
  LoanUtilizationList(this.routeType);
  @override
  _LoanUtilizationList createState() => new _LoanUtilizationList();
}

class _LoanUtilizationList extends State<LoanUtilizationList> {
  LoanUtilizationBean loanDetObj = new LoanUtilizationBean();
  List<LoanUtilizationBean> items = new List<LoanUtilizationBean>();
  List<LoanUtilizationBean> storedItems =
  new List<LoanUtilizationBean>();
  Widget appBarTitle = new Text("Loan Utilization");
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


  Icon actionIcon = new Icon(Icons.search);
  @override
  void initState() {
    items.clear();
    super.initState();
    getSessionVariables();
  }
  int count = 1;
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
    return new GestureDetector(
      onTap: () {

        _onTapItem(items[index]);

      },
      child: new Card(
          child: new ListTile(

            title: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.person,
                      color: Colors.yellow,
                      size: 30.0,
                    ),
                    new Text("  ${items[index].mprdacctid.toString()}"),
                  ],
                )
              ],
            )


            ,
            subtitle: new Column(
              children: <Widget>[


                new Row(
                  children: <Widget>[

                    new Icon(
                      Icons.description,
                      color: Colors.green,
                      size: 10.0,
                    ),
                    new Text("  ${items[index].mcustname}",style: TextStyle(fontSize: 8.0),),
                    SizedBox(
                      width: 10.0,
                    ),
                  ],

                )
              ],
            ),

          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    appBarTitle = new Text(widget.routeType);
    var loanDetailsBuilder;
    loanDetailsBuilder = new FutureBuilder(
        future: AppDatabase.get().getLoanUtilizationDetails().then(
                (List<LoanUtilizationBean> utilizationData){
              items.clear();
              storedItems.clear();
              utilizationData.forEach((f){
                print(f);
                items.add(f);
                storedItems.add(f);
              });
              return storedItems;
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
              else
                return getHomePageBody(context, snapshot);
          }
        });


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
                } else {
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text(Translations.of(context).text('Loan_Requests'));
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
      floatingActionButton:new FloatingActionButton(
          child: new Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: Colors.green,
          onPressed: () {
            _addNewLoanUtilization();

          }),
      body: loanDetailsBuilder,
    );
  }
  void _addNewLoanUtilization() {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new LoanUtilization(
          )), //When Authorized Navigate to the next screen
    );
  }
  void _onTapItem(LoanUtilizationBean item) {
    print("inside on tap loan util");
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new LoanUtilization(laonUtilizationPassedObject: item,
          )), //When Authorized Navigate to the next screen
    );
  }

  void filterList(String val) {
    print("inside filterList");

    items.clear();
    print(storedItems);
    storedItems.forEach((obj) {
      if (obj.mcustno.toString().toLowerCase().contains(val) ||
/*
          obj.omniCustomerNumber.toString().contains(val) ||
*/
          obj.mprdacctid.toString().contains(val)||
          obj.mcustname.toString().contains(val)
      ) {
        print("inside contains");
        print(items);
        items.add(obj);
      }
    });

    setState(() {});
  }



}
