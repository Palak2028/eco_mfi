import 'dart:async';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/address/beans/AreaDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/DistrictDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/StateDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/SubDistrictDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerAuthorizationBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetCustAuthDetailsFromOmni.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/PostCIFCustAuthorizationToOmni.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;

class CustomerAuthorization extends StatefulWidget {

  @override
  _CustomerAuthorizationState createState() => new _CustomerAuthorizationState();
}

class _CustomerAuthorizationState extends State<CustomerAuthorization> {

  bool circIndicatorIsDatSynced = false;
  bool isDataSynced = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  CustomerAuthorizationBean custAuthObj = new CustomerAuthorizationBean();
  Utility obj = new Utility();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  List<CustomerAuthorizationBean> custAuthBean;
  bool circInd  =false;
  SharedPreferences prefs;
  String usrcode;
  //bool showAdvance = false;
  List<CIFBean> cifBean;
  int custNo;
  int custStatus;


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
        title: new Text(Translations.of(context).text('Customer Authorization')),
        backgroundColor: Color(0xff07426A),
          actions: <Widget>[
            new IconButton(
                icon: const Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                onPressed: ()async{
                  circInd = true;
                  _ShowProgressInd(context);
                  authCust(custAuthObj.mcustno);
                }
            ),
          ]
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
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black),
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
                    initialValue: custAuthObj.mcustno == null
                        ? ""
                        : "${custAuthObj.mcustno}",
                    onSaved: (String value) {
                      if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                        print("mcustno value" + value);
                        custAuthObj.mcustno = int.parse(value);
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
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black),
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
                    initialValue: custAuthObj.mnid == null
                        ? ""
                        : "${custAuthObj.mnid}",
                    onSaved: (String value) {
                      if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                        print("mnid value" + value);
                        custAuthObj.mnid = value;
                        setState(() {

                        });
                      }
                    }
                )
            ),
            FloatingActionButton.extended(
                icon: Icon(Icons.assignment_turned_in),
                backgroundColor: Color(0xff07426A),
                label: new Text(Translations.of(context).text('View Customer Details')),
                onPressed: ()async{
                  circInd = true;
                  _ShowProgressInd(context);
                  proceed(custAuthObj);
                }
            ),
            new Container(
              height: 20.0,
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('BRANCH')),
                subtitle: custAuthObj.mlbrcode == null
                    ? new Text("")
                    : new Text("${custAuthObj.mlbrcode}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('Customer_Name')),
                subtitle: custAuthObj.mlongname == null
                    ? new Text("")
                    : new Text("${custAuthObj.mlongname}"),
              ),
            ),
            new Card(
              child: new ListTile(
                  title: new Text(Translations.of(context).text('Customer Status')),
                  subtitle: custAuthObj.mcuststatus == null
                      ? new Text("")
                      : new Text('${custAuthObj.mcuststatus == 1 ? "Active" :
                  custAuthObj.mcuststatus == 2 ? "Dropped Out" :
                  custAuthObj.mcuststatus == 3 ? "New" : " "}',
                    style: new TextStyle(color: Colors.blueAccent),
                  )
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('National_ID')),
                subtitle: custAuthObj.mpannodesc == null
                    ? new Text("")
                    : new Text("${custAuthObj.mpannodesc}"),
              ),
            ),
            new Card(
              child: new ListTile(
                  title: new Text(Translations.of(context).text('Gender')),
                  subtitle: custAuthObj.msexcode == null
                      ? new Text("")
                      : new Text('${custAuthObj.msexcode == "M" ? "Male" :
                  custAuthObj.msexcode == "F" ? "Female" :
                  custAuthObj.msexcode == "B" ? "Both" : " "}' )
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('dateOfBirth')),
                subtitle: custAuthObj.mdob == null
                    ? new Text("")
                    : new Text("${custAuthObj.mdob.substring(6,8).toString()+"-"+
                    custAuthObj.mdob.substring(4,6).toString()+"-"+
                    custAuthObj.mdob.substring(0,4).toString()}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('Address_Line_1')),
                subtitle: custAuthObj.madd1 == null
                    ? new Text("")
                    : new Text("${custAuthObj.madd1}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('Address_Line_2')),
                subtitle: custAuthObj.madd2 == null
                    ? new Text("")
                    : new Text("${custAuthObj.madd2}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('addLin3')),
                subtitle: custAuthObj.madd3 == null
                    ? new Text("")
                    : new Text("${custAuthObj.madd3}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('Country')),
                subtitle: custAuthObj.mcountrycd == null
                    ? new Text("")
                    : new Text("${custAuthObj.mcountrycd} ${custAuthObj.mcountrycddesc==null||custAuthObj.mcountrycddesc.trim()=='null'?'':custAuthObj.mcountrycddesc}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('State')),
                subtitle: custAuthObj.mstate == null
                    ? new Text("")
                    : new Text("${custAuthObj.mstate} ${custAuthObj.mstatedesc==null||custAuthObj.mstatedesc.trim()=='null'?'':custAuthObj.mstatedesc}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('district')),
                subtitle: custAuthObj.mcitycd == null
                    ? new Text("")
                    : new Text("${custAuthObj.mcitycd} ${custAuthObj.mcitycddesc==null||custAuthObj.mcitycddesc.trim()=='null'?'':custAuthObj.mcitycddesc}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('District')),
                subtitle: custAuthObj.mdistcd == 0
                    ? new Text("")
                    : new Text("${custAuthObj.mdistcd} ${custAuthObj.mdistcddesc==null||custAuthObj.mdistcddesc.trim()=='null'?'':custAuthObj.mdistcddesc}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('area')),
                subtitle: custAuthObj.marea == 0
                    ? new Text("")
                    : new Text("${custAuthObj.marea} ${custAuthObj.mareadesc==null||custAuthObj.mareadesc.trim()=='null'?'':custAuthObj.mareadesc}"),
              ),
            ),

          ],
        ),
      ),
    );

  }

  Future<void> proceed(CustomerAuthorizationBean custAuthObj)  async{

    if(custAuthObj.mnid == null || custAuthObj.mnid == "null" ){
      custAuthObj.mnid = "";
    }
    if(custAuthObj.mcustno == null || custAuthObj.mcustno == "null" ){
      custAuthObj.mcustno = 0;
    }

    if ((custAuthObj.mcustno == "" || custAuthObj.mcustno == null || custAuthObj.mcustno == 0) && (custAuthObj.mnid == "" || custAuthObj.mnid == null || custAuthObj.mnid == "null"))
    {
      _showAlert("Please Enter Customer Number or National ID");
      return false;

    }

    /*if (custAuthObj.mcustno == 1 || custAuthObj.mcustno == null || custAuthObj.mcustno == 0)
    {
      _showAlert("Please Enter Customer No");
      return false;
    }*/

    setState(() {

    });

    GetCustAuthDetailsFromOmni getCustAuthDetailsFromOmni = new GetCustAuthDetailsFromOmni();
    await getCustAuthDetailsFromOmni.trySave(custAuthObj).then((List<CustomerAuthorizationBean> custAuthBean) async {

      this.custAuthBean = custAuthBean;
      print("custAuthBean" + custAuthBean.toString());

      bool netAvail = false;
      netAvail = await obj.checkIfIsconnectedToNetwork();
      if (netAvail == false) {
        showMessageWithoutProgress("Network Not available");
        return;
      }
      else{
        for (int i = 0; i < custAuthBean.length; i++) {
          error = custAuthBean[i].merror.toString();
          print("cifLoanClosureBean -- merror--" + custAuthBean[i].merror.toString());
        }
        if (error != "Successful Browse")
        {
          _CheckIfThereError(error);
        }
        else
        {
          print("Successfull");
          for (int i = 0; i < custAuthBean.length; i++) {
            custAuthObj.mlbrcode = custAuthBean[i].mlbrcode;
            custAuthObj.mlongname = custAuthBean[i].mlongname;
            custAuthObj.mpannodesc = custAuthBean[i].mpannodesc;
            custAuthObj.mcuststatus = custAuthBean[i].mcuststatus;
            custAuthObj.msexcode = custAuthBean[i].msexcode;
            custAuthObj.mdob = custAuthBean[i].mdob;
            custAuthObj.madd1 = custAuthBean[i].madd1;
            custAuthObj.madd2 = custAuthBean[i].madd2;
            custAuthObj.madd3 = custAuthBean[i].madd3;
            custAuthObj.mcustno = custAuthBean[i].mcustno;

            custAuthObj.mcountrycd = custAuthBean[i].mcountrycd;
            if(custAuthObj.mcountrycd!=null&&custAuthObj.mcountrycd.trim!=''){
              await AppDatabase.get().getCountryNameViaCountryCode(custAuthObj.mcountrycd).then((val){
                custAuthObj.mcountrycddesc = val.countryName;
              });
            }

            custAuthObj.mstate = custAuthBean[i].mstate;
            if(custAuthObj.mstate!=null&&custAuthObj.mstate.trim!=''){
              await AppDatabase.get().getStateNameViaStateCode( custAuthObj.mstate).then(( StateDropDownList val){
                custAuthObj.mstatedesc = val.stateDesc;
              });
            }

            custAuthObj.mcitycd = custAuthBean[i].mcitycd;
            if(custAuthObj.mcitycd!=null&&custAuthObj.mcitycd.trim()!=''&&custAuthObj.mcitycd.trim()!='null'){
              await AppDatabase.get().getPlaceNameViaPlaceCode( custAuthObj.mcitycd.toString()).then(( SubDistrictDropDownList val){
                custAuthObj.mcitycddesc = val.placeCdDesc;
              });
            }

            custAuthObj.mdistcd = custAuthBean[i].mdistcd;
            if(custAuthObj.mdistcd!=null&&custAuthObj.mdistcd!=0){
              await AppDatabase.get().getDistrictNameViaDistrictCode( custAuthObj.mdistcd.toString()).then(( DistrictDropDownList val){
                custAuthObj.mdistcddesc = val.distDesc;
              });
            }
            custAuthObj.marea = custAuthBean[i].marea;
            if(custAuthObj.marea!=null&&custAuthObj.marea!=0){
              await AppDatabase.get().getAreaNameViaAreaCode( custAuthObj.marea.toString()).then(( AreaDropDownList val){
                custAuthObj.mareadesc = val.areaDesc;
              });



            }
          }
          /*if (showAdvance == false) {
            setState(() {
              showAdvance = true;
            });
          }*/
          Navigator.of(context).pop();
        }
      }
      setState(() {

      });
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
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _successfulSubmit(msg) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            /*title: new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 40.0,
            ),*/
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
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> authCust(int custno)  async {
    /*if (custAuthObj.mcustno == 1 || custAuthObj.mcustno == null ||
        custAuthObj.mcustno == 0) {
      _showAlert("Please Enter Customer No");
      return false;
    }*/
    if (custAuthObj.mcuststatus != 3) {
      _showAlert("Already Authorised");
      return false;
    }
    else {
      Future<bool> onPop(BuildContext context, String agrs1, String args2,
          String pageRoutedFrom) {
        return showDialog(
          context: context,
          builder: (context) =>
          new AlertDialog(
            title: new Text(agrs1),
            content: new Text(args2),
            actions: <Widget>[
              new FlatButton(
                onPressed: () =>
                {
                  Navigator.of(context).pop(true),
                  Navigator.of(context).pop(true)
                },
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
                  postCIFCustAuthorizationToOmni.trySave(custno).then((
                      List<CIFBean> cifBean) async {
                    this.cifBean = cifBean;
                    print("cifBean" + cifBean.toString());

                    bool netAvail = false;
                    netAvail = await obj.checkIfIsconnectedToNetwork();
                    if (netAvail == false) {
                      showMessageWithoutProgress("Network Not available");
                      return;
                    }
                    else {
                      if (cifBean[0].merror != null ||
                          cifBean[0].merror != "null" ||
                          cifBean[0].merror != "") {
                        _successfulSubmit(cifBean[0].merror);
                        circInd = false;
                      }
                      custNo = cifBean[0].mcustno;
                      custStatus = cifBean[0].mcuststatus;
                      print('custNo : ${custNo} and custStatus ${custStatus}');
                      if(custNo!=0 && custStatus!=0){
                          String  updateCustStatusQuery = "${TablesColumnFile.mcuststatus} = ${custStatus}  "
                              "WHERE ${TablesColumnFile.mcustno} = ${custNo} ";
                          print('updateCustStatusQuery - ${updateCustStatusQuery}');
                          if (updateCustStatusQuery != null) {
                            await AppDatabase.get().updateCustomerMaster(updateCustStatusQuery);
                          }
                          custAuthObj.mcuststatus = custStatus;
                          setState(() {});
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

  }

  void showMessageWithoutProgress(String message,
      [MaterialColor color = Colors.red]) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
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
