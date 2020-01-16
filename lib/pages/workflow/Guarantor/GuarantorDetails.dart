import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/ThemeDesign.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/Guarantor/GuarantorDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/Guarantor/AddGuarantor.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuarantorDetails extends StatefulWidget {

  final String mleadsId;
  final int mrefno;
  final int trefno;
  GuarantorDetails(this.mleadsId,this.mrefno,this.trefno);
  @override
  _GuarantorDetails createState() => new _GuarantorDetails();
}

class _GuarantorDetails extends State<GuarantorDetails> {
  GuarantorDetailsBean gauDetObj = new GuarantorDetailsBean();
  List<GuarantorDetailsBean> items = new List<GuarantorDetailsBean>();
  List<GuarantorDetailsBean> storedItems =
  new List<GuarantorDetailsBean>();
  Widget appBarTitle = new Text("Guarantor Details");
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
  int count=1;

  Icon actionIcon = new Icon(Icons.search);
  @override
  void initState() {
    if(widget.mleadsId!=null){
      if(widget.mleadsId!=null){
        gauDetObj.mleadsid =widget.mleadsId;

      }
      if(widget.mrefno!=null){
        gauDetObj.mloanmrefno =widget.mrefno;

      }
      if(widget.mleadsId!=null){
        gauDetObj.mloantrefno =widget.trefno;

      }
    }
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

    print("inside get item ui");

    if (items[index].mprdacctid != null &&
        items[index].mprdacctid != "null" &&
        items[index].mprdacctid != "") {
      mprdcd = items[index].mprdacctid.substring(0, 8).trim();
      custNo = items[index].mprdacctid.substring(8, 16);
      prcdAcctId = items[index].mprdacctid.substring(16, 24);
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
        _onTapItem(items[index],widget.mleadsId,widget.mrefno,widget.trefno);
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
                        "  ${items[index].mnameofguar.toUpperCase()}",
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
                            children: <Widget>[
                              Text(
                                Translations.of(context).text('trefNo')+
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
                                  children: <Widget>[
                                    Text(
                                      items[index].mrelationwithcust == "1"
                                          ? "Father"
                                          : items[index].mrelationwithcust.trim() =="2"
                                          ? "Mother"
                                          : items[index].mrelationwithcust =="3"
                                          ? "Husband"
                                          : items[index].mrelationwithcust == "4"
                                          ? "Wife"
                                          : items[index].mrelationwithcust == "5"
                                          ? "Son"
                                          : items[index].mrelationwithcust == "6"
                                          ? "Daughter"
                                          : items[index].mrelationwithcust == "7"
                                          ? "Sister"
                                          : items[index].mrelationwithcust == "8"
                                          ? "Friend"
                                          : "Self",
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
//mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[

                              Padding(
                                  padding: new EdgeInsets.only(
                                      left: 1.0, right: 10.0),
                                  child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,

                                    children: <Widget>[
                                      Text(
                                        Translations.of(context).text('National_ID') +
                                            items[index]
                                                .mnationaliddesc
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white),
                                      ),
                                    ],
                                  )
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              new Container (
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
                      children: <Widget>[
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 8.0,
                            ),
                            new Padding(
                              padding: new EdgeInsets.only(
                                top: 1.0,
                                bottom: 1.0,
                              ),
                              child: new Row(
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: <Widget>[
                                  new Text(
                                    Translations.of(context).text('CUSTOMERNUMBER') +"${items[index].mcustno}",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    Translations.of(context).text('contactNo')+"${items[index].mmobile}" ,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[500],
                                    ),
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

          future: AppDatabase.get().getGaurantorDetailsList(widget.trefno,widget.mrefno).then(
                  (List<GuarantorDetailsBean> gaurantorData){
                items.clear();
                storedItems.clear();
                gaurantorData.forEach((f){
                  print(f);
                  items.add(f);
                  storedItems.add(f);
                });
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

            if (items[position].mprdacctid != null &&
                items[position].mprdacctid != "null" &&
                items[position].mprdacctid != "") {
              mprdcd = items[position].mprdacctid.substring(0, 8).trim();
              custNo = items[position].mprdacctid.substring(8, 16);
              prcdAcctId = items[position].mprdacctid.substring(16, 24);
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
                _onTapItem(items[position],widget.mleadsId,widget.mrefno,widget.trefno);
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
                                "  ${items[position].mnameofguar.toUpperCase()}",
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
                                    children: <Widget>[
                                      Text(
                                        Translations.of(context).text('trefNo') +
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
                                              items[position].mrelationwithcust == "1"
                                                  ? "Father"
                                                  : items[position].mrelationwithcust.trim() == "2"
                                                  ? "Mother"
                                                  : items[position].mrelationwithcust == "3"
                                                  ? "Husband"
                                                  : items[position].mrelationwithcust == "4"
                                                  ? "Wife"
                                                  : items[position].mrelationwithcust == "5"
                                                  ? "Son"
                                                  : items[position].mrelationwithcust == "6"
                                                  ? "Daughter"
                                                  : items[position].mrelationwithcust == "7"
                                                  ? "Sister"
                                                  : items[position].mrelationwithcust == "8"
                                                  ? "Friend"
                                                  : "Self",
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
                                    children: <Widget>[

                                      Padding(
                                          padding: new EdgeInsets.only(
                                              left: 1.0, right: 10.0),
                                          child: Row(

                                            children: <Widget>[
                                              Text(
                                                Translations.of(context).text('National_ID')+
                                                    items[position]
                                                        .mnationaliddesc
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          )
                                      ),

                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                      new Container (
                        child: new Row (
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
                              children: <Widget>[
                                new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    new Padding(
                                      padding: new EdgeInsets.only(
                                        top: 1.0,
                                        bottom: 1.0,
                                      ),
                                      child: new Row(
                                        textBaseline: TextBaseline.alphabetic,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                        children: <Widget>[
                                          new Text(
                                            Translations.of(context).text('CUSTOMERNUMBER')+"${items[position].mcustno}" ,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            Translations.of(context).text('contactNo')+"${items[position].mmobile}" ,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey[500],
                                            ),
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
                  items = new List<GuarantorDetailsBean>();
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
            _addNewGuarantor(widget.mleadsId,widget.mrefno,widget.trefno);

          }),
      body: loanDetailsBuilder,
    );
  }
  void _addNewGuarantor(String mleadsId,int mrefno,int trefno) {
    print(" Inside _addNewGuarantor");
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new AddGuarantor(mleadsId:mleadsId,mrefno:mrefno,trefno:trefno
          )), //When Authorized Navigate to the next screen
    );
  }

  void _onTapItem(GuarantorDetailsBean item,String mleadsId,int mrefno,int trefno) {
    print("inside on tap gau det");
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new AddGuarantor(mleadsId:mleadsId,mrefno:mrefno,trefno:trefno,gaurantorDetailsPassedObject: item,
          )), //When Authorized Navigate to the next screen
    );
  }

  void filterList(String val) async {
    items.clear();

    storedItems.forEach((obj) {
      if (obj.mnameofguar.toString().contains(val) ||
          obj.trefno.toString().toLowerCase().contains(val) ||
          obj.mmobile.toString().contains(val) ||
          obj.mnationaliddesc.toString().contains(val) ||
          obj.mcustno.toString().contains(
              val) ) {

        items.add(obj);

      }
      if (val.toUpperCase() == "FATHER") {
        if (obj.mrelationwithcust == "1") {
          items.add(obj);
          //   print(items);
        }
      }
      else if (val.toUpperCase() == "MOTHER") {
        if (obj.mrelationwithcust == "2") {
          items.add(obj);
          //   print(items);
        }
      }
      else  if (val.toUpperCase() == "HUSBAND") {
        if (obj.mrelationwithcust == "3") {
          items.add(obj);
          //   print(items);
        }
      }
      else  if (val.toUpperCase() == "WIFE") {
        if (obj.mrelationwithcust =="4" ) {
          items.add(obj);
          //  print(items);
        }
      }
      else  if (val.toUpperCase() == "SON") {
        if (obj.mrelationwithcust == "5") {
          items.add(obj);
          //  print(items);
        }
      }
      else  if (val.toUpperCase() == "DAUGHTER") {
        if (obj.mrelationwithcust == "6") {
          items.add(obj);
          //  print(items);
        }
      }
      else  if (val.toUpperCase() == "SISTER") {
        if (obj.mrelationwithcust == "7") {
          items.add(obj);
          //  print(items);
        }
      }
      else  if (val.toUpperCase() == "FRIEND") {
        if (obj.mrelationwithcust == "8") {
          items.add(obj);
          //  print(items);
        }
      }
      else  {
        if (obj.mrelationwithcust == "9") {
          items.add(obj);
          //   print(items);
        }
      }
    });

    setState(() {
      count = 4;
    });
  }



}



/*
Future<void> _ShowCircInd() async {
  return showDialog<void>(
      context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('CustomerSync'),
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
*/

