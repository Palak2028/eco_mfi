import 'dart:async';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/List/CIFList.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetCIFInfoFromOmni.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFBean.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CIF extends StatefulWidget {

  @override
  _CIFState createState() => new _CIFState();
}

class _CIFState extends State<CIF> {

  bool circIndicatorIsDatSynced = false;
  bool isDataSynced = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  CIFBean cifBeanObj = new CIFBean();
  Utility obj = new Utility();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  List<CIFBean> cifBean;
  bool circInd  =false;
  SharedPreferences prefs;
  String usrcode;

  @override
  void initState() {
    super.initState();
    getSessionVariables();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      usrcode = prefs.get(TablesColumnFile.musrcode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: new Text("Customer 360"),
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
            Card(
                child:
                new TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Customer Number',
                      labelText: 'Customer Number',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.grey),
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
                    initialValue: cifBeanObj.mcustno == null
                        ? ""
                        : "${cifBeanObj.mcustno}",
                    onSaved: (String value) {
                      if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                        print("mcustno value" + value);
                        cifBeanObj.mcustno = int.parse(value);
                        setState(() {

                        });
                      }
                    }
                )
            ),
            Card(
                child:
                new TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'National ID',
                      labelText: 'National ID',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.grey),
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
                    initialValue: cifBeanObj.mnid == null
                        ? ""
                        : "${cifBeanObj.mnid}",
                    onSaved: (String value) {
                      if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                        print("mnid value" + value);
                        cifBeanObj.mnid = value;
                        setState(() {

                        });
                      }
                    }
                )
            ),
            new Container(
              height: 20.0,
            ),
            FloatingActionButton.extended(
              icon: Icon(Icons.assignment_turned_in),
              backgroundColor: Color(0xff07426A),
              label: Text("CIF Details"),
              onPressed: ()
              async {
                circInd = true;
                _ShowProgressInd(context);
                loadCIFPage(cifBeanObj.mcustno, cifBeanObj.mnid.toString());
              },
            ),
            new Container(
              height: 20.0,
            )
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

  Future<void> loadCIFPage(int custno , String nid) async {
    print("custno");
    print(custno);

    if(nid == null || nid == "null" ){
        nid = "";
      }
    if(custno == null || custno == "null" ){
      custno = 0;
    }

    if ((custno == "" || custno == null || custno == 0) && (nid == "" || nid == null || nid == "null"))
      {
        _showAlert("Please Enter Customer Number or National ID");
        return false;

      }

    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    GetCIFInfoFromOmni getCIFInfoFromOmni =
    new GetCIFInfoFromOmni();
    await getCIFInfoFromOmni.trySave(custno, nid).then((List<CIFBean> cifBean) async {
      this.cifBean = cifBean;
      print("cifBean" + cifBean.toString());

      bool netAvail = false;
      netAvail = await obj.checkIfIsconnectedToNetwork();
      if (netAvail == false) {
        showMessageWithoutProgress("Network Not available");
        return;
      }
      else {
        if (cifBean.isEmpty) {
          _CheckIfThere();
        }
        else
          {
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new CIFList(cifBean)),
              // When Authorized Navigate to the next screen
            );
          }
      }
      setState(() {

      });
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
                      new Text(" No Account Found "),
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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

}
