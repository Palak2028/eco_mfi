import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT1Bean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CGT1Details extends StatefulWidget {
  final routeType1;
  final int loanNum1;
  CGT1Details(this.routeType1, this.loanNum1);
  @override
  _CGT1Details createState() => new _CGT1Details();
}

class _CGT1Details extends State<CGT1Details> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
  /*List<CustomerLoanDetailsBean> items = new List<CustomerLoanDetailsBean>();
  bool isCgt1 = false;
  bool isCgt2 = false;
  bool isGrt = false;
  String username;
  String usrCode;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  SharedPreferences prefs;
  String loginTime;
  String branch = "";
  int usrGrpCode = 0;
  CGT1Bean cgt1bean = CGT1Bean();
  List<CheckListBean> forCGT1 = List<CheckListBean>();
  List<CheckListBean> forCGT2 = List<CheckListBean>();
  List<CheckListBean> forGRT = List<CheckListBean>();
  List<CheckListBean>  storedCheckedRecords = new List<CheckListBean>();
  List<CheckListBean>  items1 = new List<CheckListBean>();


  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null&&items!=null) {
      return new Scaffold(
        body: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[

            ];
          },
          body: new Column(
            children: <Widget>[
          new Text(
          "Created At : "+cgt1bean.createdAt.toString(),
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 17),
        ),
          new Text(
            "Created By : "+cgt1bean.createdBy,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 17),
          ),
          new Text(
            "Actioned By : "+cgt1bean.routeFrom,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 17),
          ),

              new Container(
                height: 490.0,
                child: new ListView.builder(
                  itemCount: items1.length,
                  itemBuilder: _getItemUI,

                ),
              ),
            ],
          ),
        ),
      );
      *//* return ListView.builder(
        itemCount: items1.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.all(0.0),
      );*//*
    }
  }


  Widget _getItemUI(BuildContext context, int index) {

    return new GestureDetector(


      child:items1==null?new Text("nothing to display") :new Card(

        child: new Column(
          mainAxisSize: MainAxisSize.min,

          children: <Widget>[
            *//* new ListTile(
                title: new Text("Created At:   "+cgt1bean.createdAt.toString()),
                subtitle: new Text("Created By:  "+cgt1bean.createdBy),
              ),*//*

            new ListTile(
              title: new Text(
                items1[index].questionDesc,
                textAlign: TextAlign.left,
              ),
              trailing:items1[index].isChecked==0?new  Text(
                "   NO",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.red,
                ),
              ):new  Text(
                "   YES",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.green,
                ),
              )  ,
            ),
          ],

        ),
      )
      ,
    );
  }


  List<bool> questionCheck;


  @override
  void initState() {
    items.clear();
    super.initState();
    getSessionVariables();
*//*
    await getUpdate;
*//*


  }

*//*  Future<void> getUpdate() async{
    AppDatabase.get()
        .getCustomerDisStatusCheckListDetails(
        widget.loanNum1, "CGT1")
        .then((List<CheckListBean> chkList) {
      chkList.forEach((f) {
        forCGT1.add(f);
        *//**//*forCGT1 = chkList;*//**//*
        print("chkList2");
        print(chkList);

      });
    });
  }*//*

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString(TablesColumnFile.usrCode);
      usrCode = prefs.getString(TablesColumnFile.usrCode);
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      branch = prefs.get(TablesColumnFile.branch).toString();
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.geoLocation);
      geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
    });
  }

  DateTime endTime;


  @override
  Widget build(BuildContext context) {

    var  futureBuilder = new FutureBuilder(
        future:
        AppDatabase.get()
            .getCustomerCGT1Details(widget.loanNum1)
            .then((CGT1Bean CGT1DetailsList) {

          cgt1bean = CGT1DetailsList;
          print('cgt1bean');
          print(cgt1bean);

          AppDatabase.get().getCustomerDisStatusCheckListDetails(
              widget.loanNum1, "CGT1").then(
                  (List<CheckListBean> result) {
                print("result");
                print(result);
                if(result!=null){
                  result.forEach((obj){
                    storedCheckedRecords.add(obj);
                    items1.add(obj);
                  });
                  return items;
                }
                else return new  Container(
                );
              } );
          print('forCGT1');
          print(forCGT1);

          return forCGT1;


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
              else{
                if(items==null)return new Container(child: new Text(""));
                else return getHomePageBody(context, snapshot);
              }
          }
        });
*//*   Container(
     child: futureBuilder,
   );*//*
    return new Scaffold(

        body: futureBuilder

    );




    // TODO: implement build


  }

*//*List<Widget> getCard() {
    List<Widget> listCard = new List<Widget>();
    print(globals.questionCGT1.length);
    for (int i = 0; i < forCGT1.length; i++) {
      print("here");
      listCard.add(new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           new Text(forCGT1[i].questionDesc)

        ],
      ));
    }

    return listCard;
  }*//*



*/
}
