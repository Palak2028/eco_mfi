import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CreditBereauBean.dart';
import 'dart:convert';
import 'dart:async';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:eco_mfi/pages/workflow/creditBereau/CreditBereauCallSubmisiion.dart';
import 'dart:math';

import 'package:eco_mfi/translations.dart';

class SMSVerification extends StatefulWidget {
  @override
  _SMSVerification createState() => new _SMSVerification();
}

class _SMSVerification extends State<SMSVerification> {
  List<CreditBereauBean> items = new List<CreditBereauBean>();
  List<CreditBereauBean> storedItems = new List<CreditBereauBean>();



  int count = 1;
  bool circIndicatorOTP = false;
  bool circIndicatorContact = false;
  bool resendOtp = false;
  int val;
  int circPosition;
  Widget appBarTitle ;
  Icon actionIcon = new Icon(Icons.search);

  @override
  void initState() {

    if(globals.searchName==""){
      appBarTitle = new Text("SMS Verification");
      actionIcon = new Icon(Icons.search);
    }
    else{

      appBarTitle = this.appBarTitle = new TextField(
        style: new TextStyle(
          color: Colors.white,

        ),
        autofocus: true,
        decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.search,color: Colors.white),
            hintText: 'Search',
            hintStyle: new TextStyle(color: Colors.white)
        ),

        controller: new TextEditingController(text:globals.searchName),

        onChanged: (val){
          filterList(val.toLowerCase());
        },

      );
      actionIcon = new Icon(Icons.close);
    }

    setState(() {

    });

  }


  //bool OTPMatched =false;
  int verifyPos;
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  TextEditingController _userCtrl = new TextEditingController();
  Utility obj = new Utility();
  var SMSVerURL = 'https://api.textlocal.in/send/?';
  static const JsonCodec JSON = const JsonCodec();
  static final _headers = {'Content-Type': 'application/x-www-form-urlencoded'};

  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI2,
      );
    }
  }

  Widget _getItemUI2(BuildContext context, int position) {
    return new GestureDetector(
        onTap: () {
          _navigateCbRsult(items[position], position);
        },
        child: Card(
          // shape: OutlineInputBorder(gapPadding: 20),

          margin: EdgeInsets.all(10.0),
          color: Colors.grey[200],
          child:new ListTile(
            title: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.account_circle,
                      color: Colors.black,

                      size: 30.0,
                    ),
                    new Text("  ${items[position].mprospectname.toString()}"),
                  ],
                )
              ],
            ) ,
            subtitle:new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.phone,
                      color: Colors.green,

                      size: 20.0,
                    ),
                    new Text("  ${items[position].mmobno}"),
                    SizedBox(width: 10.0,),

                  ],
                ),

                new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.developer_board,
                      color: Colors.black,

                      size: 20.0,
                    ),
                    new Text(" ${items[position].mpanno}"),
                    SizedBox(width: 10.0,),

                  ],
                ),
                SizedBox(height: 10.0,),

                new Container(
                  //color: Colors.white,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white),
                  child: position == val
                      ? new Stack(
                      alignment: const Alignment(0.8, 0.0),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: new TextField(
                            decoration: InputDecoration(
                                hintText:Translations.of(context).text('Enter_OTP'),
                                labelText: Translations.of(context).text('OTP'),
                                border: UnderlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(20.0))),
                            autofocus: true,
                            cursorRadius: Radius.circular(20.0),
                            keyboardType:
                            TextInputType.numberWithOptions(),

                            cursorColor: Colors.blue,
                            controller: _userCtrl,
                          ),
                        ),
                        new RaisedButton(
                          onPressed: () => _verify(_userCtrl.text,
                              items[position], position),
                          child: Text("Verify",style: TextStyle(color: Colors.white),),
                          color: Color(0xff01579b),
                        )
                      ])
                      : null,
                ),





              ],


            ) ,
            trailing:  new Container(
              child: (circIndicatorContact == true) &&
                  (circPosition == position)
                  ? new CircularProgressIndicator()
                  : IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () =>
                      _generateOTP(position, items[position])),
            ),


          )

        ));
  }

  @override
  Widget build(BuildContext context) {
    var SMSListBuilder;

    if (count == 1) {
      count++;

      SMSListBuilder = new FutureBuilder(
          future: AppDatabase.get()
              .getNonSmsVerifiedCreditMasterObjects()
              .then((List<CreditBereauBean> afterLogin) {
            afterLogin.forEach((val){
              storedItems.add(val);

            });
            items = afterLogin;
            return items;
          } ),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new Text('Press button to start');
              case ConnectionState.waiting:
                return new Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child:
                        new CircularProgressIndicator());
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else
                  return getHomePageBody(context, snapshot);
            }
          });
    } else if(items!=null) {
      SMSListBuilder = ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, position) {
          return new GestureDetector(
              onTap: () {
                _navigateCbRsult(items[position], position);
              },
              child: Card(
                margin: EdgeInsets.all(10.0),
                color: Color(0xffe0e0e0),
                child:new ListTile(
                  title: new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Icon(
                            Icons.account_circle,
                            color: Colors.black,

                            size: 30.0,
                          ),
                          new Text("  ${items[position].mprospectname.toString()}"),
                        ],
                      )
                    ],
                  ) ,
                  subtitle:new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Icon(
                            Icons.phone,
                            color: Colors.green,

                            size: 20.0,
                          ),
                          new Text("  ${items[position].mmobno}"),
                          SizedBox(width: 10.0,),

                        ],
                      ),

                      new Row(
                        children: <Widget>[
                          new Icon(
                            Icons.developer_board,
                            color: Colors.black,

                            size: 20.0,
                          ),
                          new Text(" ${items[position].mpanno}"),
                          SizedBox(width: 10.0,),

                        ],
                      ),
                          SizedBox(height: 10.0,),

                          new Container(
                            //color: Colors.white,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.white),
                            child: position == val
                                ? new Stack(
                                alignment: const Alignment(0.8, 0.0),
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: new TextField(
                                      decoration: InputDecoration(
                                          hintText: Translations.of(context).text('OTP'),
                                          labelText: Translations.of(context).text('Enter_OTP'),
                                          border: UnderlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(20.0))),
                                      autofocus: true,
                                      //enableInteractiveSelection: true,
                                      cursorRadius: Radius.circular(20.0),
                                      keyboardType:
                                      TextInputType.numberWithOptions(),

                                      cursorColor: Colors.blue,
                                      controller: _userCtrl,
                                    ),
                                  ),
                                  new RaisedButton(
                                    onPressed: () => _verify(_userCtrl.text,
                                        items[position], position),
                                    child: Text("Verify",style: TextStyle(color: Colors.white),),
                                    color: Color(0xff01579b),
                                  )
                                ])
                                : null,
                          ),





                    ],


                  ) ,
                  trailing:new Column(


                    children: <Widget>[

                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            return editCustomer(context,items[position]);
                          }
                      ),

                      new Container(
                        child: (circIndicatorContact == true) &&
                            (circPosition == position)
                            ? new CircularProgressIndicator()
                            : IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () =>
                                _generateOTP(position, items[position])),
                      ),

                    ],
                  )








                )

              ));
        },
      );
    }

    return new Scaffold(
        key: _scaffoldHomeState,
        appBar: new AppBar(
          elevation: 3.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: (){
              Navigator.of(context).pop();

            },
          ),
          backgroundColor: Color(0xff01579b),
          brightness: Brightness.light,
          title:appBarTitle
            ,
            actions: <Widget>[

              new Container(child: globals.searchName==""?new IconButton(icon: actionIcon,onPressed:(){
                setState(() {

                  if ( this.actionIcon.icon == Icons.search){
                    this.actionIcon = new Icon(Icons.close);
                    this.appBarTitle = new TextField(
                      style: new TextStyle(
                        color: Colors.white,

                      ),
                      decoration: new InputDecoration(
                          prefixIcon: new Icon(Icons.search,color: Colors.white),
                          hintText: Translations.of(context).text('Search'),
                          hintStyle: new TextStyle(color: Colors.white)
                      ),

                      onChanged: (val){
                        filterList(val.toLowerCase());
                      },
                    );}
                  else {
                    this.actionIcon = new Icon(Icons.search);
                    this.appBarTitle = new Text(Translations.of(context).text('SMS_Verification'));
                    items.clear();
                    storedItems.forEach((val){
                      items.add(val);
                    });

                  }


                });
              } ,):
        new IconButton(icon: actionIcon,onPressed:(){
          setState(() {
            globals.searchName = "";
            this.actionIcon = new Icon(Icons.search);
            this.appBarTitle = new Text(Translations.of(context).text('SMS_Verification'));
            items.clear();
            storedItems.forEach((val){
              items.add(val);
            });
          });
        })
    )
              ,]
        ),
        body: SafeArea(

          child:SMSListBuilder

        ));
  }


  Future<void> _generateOTP(int circPosition, CreditBereauBean cbb) async {
    setState(() {
      resendOtp = true;
      circIndicatorContact = true;
      this.circPosition = circPosition;
    });
    showInSnackBar("Sending OTP");
    await _tryPost(cbb);

    setState(() {
      circIndicatorContact = false;
    });
  }

  Future<void> _verify(String OTP, CreditBereauBean obj, int position) async {
    print(_userCtrl.text);
    verifyPos = position;

    await AppDatabase.get().getSMSOTP(obj.trefno,obj.mrefno).then((val) {

      print("retvalue is ${val}");
      if(val==null){
        showInSnackBar("Generate an OTP first");
        _userCtrl.text = "";
        return;
      }

      print(val);
      if (val == int.parse(_userCtrl.text)) {
        AppDatabase.get()
            .verifyCreditBereauSmsResult(obj.trefno,obj.mrefno)
            .then((val) {});
          _OtpVerified(obj.mprospectname);
        print("OTP MAtched");
        setState(() {
          items.removeAt(position);
          val = null;
          _userCtrl.text = "";
        });

      } else {
        showInSnackBar("Wrong OTP",1000);
        _userCtrl.text = "";
      }
    });
  }

  Future _mockService([dynamic error]) {
    print("Waiting");
    return new Future.delayed(const Duration(seconds: 10), () {
      if (error != null) {
        throw error;
      }
    });
  }

  void showInSnackBar(String value, [int duration]) {
    _scaffoldHomeState.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      duration: Duration(milliseconds: duration != null ? duration : 1000),
    ));
  }

  void _navigateCbRsult(CreditBereauBean cbb, position) {
    print(cbb);
    setState(() {
      val = position;
      _userCtrl.text = "";
    });
  }

  Future<void> _tryPost(CreditBereauBean cbb) async {
    bool isNetworkAvailable;
    bool isloginRetValue = false;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();

    if (isNetworkAvailable) {
      await postSms(cbb).then((value) {
        print("after save");
        isloginRetValue = true;
      });
    } else {
      showInSnackBar("Network Not Available");
      return null;
    }
  }

  Future<void> postSms(CreditBereauBean cbb) async {
  
  var parsed;
    try {
      print(cbb.mmobno);
      var rng = new Random();
      OTP = (rng.nextDouble() * 9000 + 1000).toInt();
      print(globals.OTP);

      print("Creating Response");
      String body1 =
          'apiKey=Vlsq0LknQoo-WOAGuq3V7jyucsWvr2hfPgW6mdSeh5&numbers=91${cbb.mmobno}&sender=SAIJAF&message=${OTP}';
       final response =
          await http.post(Uri.encodeFull(SMSVerURL),
              body: body1, headers: _headers);

      print("Response Created");
      print(response);
      print(response.statusCode);

      String res = response.body;

      var res2 = res.split(",");
      for (var items in res2) {
        print(items);
      }

      if (response.statusCode == 200) {

        print("trying to cast Data");
         parsed = json.decode(res);
        print(parsed);
        print("cast Completed");
        OTPResponse obj = OTPResponse.fromMap(parsed);
        await AppDatabase.get()
            .updateCreditBereauSmsOTP(cbb.mmobno, globals.OTP,cbb.trefno,cbb.mrefno,DateTime.now());
        print("Trying to map Data");
        print(obj);
        print("Object Mapped");
  showInSnackBar(" OTP Sent ", 600);
      }
    } catch (e) {
      print('Server Exception!!!');
      print("ghgjhg");
  print(e.toString() + "  is the exception");
      try{

        print("inside 2 nd try");
  OTPResponseWarning warn = OTPResponseWarning.fromMap(parsed);
  print(warn.warnings[0]);
  showInSnackBar(" ${warn.warnings[0].message} ", 1000);

  }
      catch(e){
        print("Unable to map");
  }

      
    }
  }

  Future<bool> callDialog() {
    globals.Dialog.onWillPop(context, 'Are you sure?',
        'Do you want to Go To DashBoard without saving data', 'Dashboard');
  }



  void editCustomer(BuildContext context, CreditBereauBean obj) {
  Navigator.push(
  context,
  new MaterialPageRoute(
  builder: (context) => new CreditBereauCallSubmisiion(
  CreditBeareauPassedObject:
  obj)), //When Authorized Navigate to the next screen
  );
  }


  Future<void> _OtpVerified(String applicantName) async {
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
  Text('OTP Verified For ${applicantName}')
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
  }
  );}

  void filterList(String val) {
    print("inside filterList");


  items.clear();
  print(storedItems);
    storedItems.forEach((obj){
    print(obj.mprospectname);
     if(obj.mprospectname.toLowerCase().contains(val)||obj.mpanno.toString().contains(val)||obj.mmobno.toString().contains(val)){

       print("inside contains");
       print(items);
       items.add(obj);

  }


  });

    setState(() {

    });

  }

}
