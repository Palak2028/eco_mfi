import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:eco_mfi/pages/workflow/FPSPages/AgentBiometricRegistration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/LoginBean.dart';
import 'package:eco_mfi/Utilities/app_constant.dart' as constant;
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/home/Home_Dashboard.dart';
import 'package:eco_mfi/pages/workflow/PassChangeModule/Bean/UserMasterSecondary.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';
class ChangePassword extends StatefulWidget {

  String routedFrom;
  ChangePassword(this.routedFrom);
  @override
  _ChangePasswordState createState() => new _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {



  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  LoginBean beanObj = new LoginBean();
  static const JsonCodec JSON = const JsonCodec();
  static String _serviceUrl = "/userDetailsMaster/changePassword/";
  static final _headers = {'Content-Type': 'application/json'};



  String newPass;
  String newCnfrmPass;
  bool autovalidateVar  = false;
  @override
  void initState() {
    getSessionVariables();
  }
  void getSessionVariables() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      beanObj.musrcode = prefs.get(TablesColumnFile.musrcode);
    });

  }


  callDialog(){
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(onWillPop: () {
          callDialog();
    },
        child: new Scaffold(

            key: _scaffoldKey,
            appBar: new AppBar(
              elevation: 1.0,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  callDialog();
                },
              ),
              backgroundColor: Color(0xff01579b),
              brightness: Brightness.light,
              title: new Text(
                Translations.of(context).text('Change_Password'),
                //textDirection: TextDirection,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontStyle: FontStyle.normal),
              ),
            ),

            body: new SafeArea(top: false,
              bottom: false,
              child: new Form(
                key: _formKey,
                onWillPop: () {
                  Navigator.of(context).pop();
                },
                onChanged: () {
                  final FormState _form2 = _formKey.currentState;
                  _form2.save();
                },
                autovalidate:  autovalidateVar,
                child: SingleChildScrollView(
                    child: new Column(
                        children: <Widget>[

                          SizedBox(height: 20.0,),

                  new AgentBiometricRegistration(),


                          Container(
                              child: new TextFormField(
                                decoration: const InputDecoration(
                                  hintText: constant.userCode,
                                  labelText: constant.userCode,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  enabled: false,
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      )),
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                                enabled: false,
                                controller: new TextEditingController(text: beanObj.musrcode),

                              )),



                          Container(
                              decoration:
                              BoxDecoration(color: Constant.mandatoryColor),
                              child: new TextFormField(
                                decoration:  InputDecoration(
                                  hintText: Translations.of(context).text('Enter_Current_Password'),
                                  labelText: Translations.of(context).text('Current_Password'),
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      decorationColor: Colors.red),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      )),
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                                obscureText: true,

                                validator: (String arg) {
                                  if (arg==null)
                                  return Translations.of(context).text('Current_Password_Must_Not_Be_Blank');
                                  else if (arg.length < 3)
                                    return Translations.of(context).text('Current_Password_Must_Be_More_Than_2_Charater');
                                  else
                                    return null;
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(30),
                                ],
                                controller: beanObj.musrpass == null
                                    ? TextEditingController(text: null)
                                    : TextEditingController(
                                    text: beanObj.musrpass),
                                onSaved: (val) {
                                  if(val!=null) beanObj.musrpass  = val;
                                },
                              )),

                          Container(
                              decoration:
                              BoxDecoration(color: Constant.mandatoryColor),
                              child: new TextFormField(
                                decoration: InputDecoration(
                                  hintText: Translations.of(context).text('Enter_New_Password'),
                                  labelText: Translations.of(context).text('New_Password'),
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      decorationColor: Colors.red),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      )),
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                                obscureText: true,

                                validator: (String arg) {
                                  if (arg==null )
                                    return Translations.of(context).text('new_Password_Should_Not_Be_Null');
                                  else if (arg.length < 8)
                                    return Translations.of(context).text('Password_Must_Be_More_Than_8_Charater');
                                  else if (!RegExp(
                                      r'[!@#$%<>?":_`~;[\]\\|=+)(*&^%]')
                                      .hasMatch(arg)) {
                                    return Translations.of(context).text('Atleast_One_Special_Character_Req');
                                  }  else if (arg!= null&&beanObj.musrpass==arg) {
                                    return Translations.of(context).text('New_Password_Must_Not_Same_As_Current');
                                  }
                                  else if (!RegExp(
                                      r'[A-Z]')
                                      .hasMatch(arg)) {
                                    return Translations.of(context).text('Atleast_One_UpperCase_Character_Req');
                                  }else if (!RegExp(
                                      r'[a-z]')
                                      .hasMatch(arg)) {
                                    return Translations.of(context).text('Atleast_One_Lower_Case_Character_Req');
                                  }
                                  else if (!RegExp(
                                      r'[0-9]')
                                      .hasMatch(arg)) {
                                    return Translations.of(context).text('Atleast_One_Numeric_Required');
                                  }else
                                    return null;
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(30),
                                ],
                                onSaved: (val) {

                                  if(val!=null) newPass = val;
                                },
                              )),





                          Container(
                              decoration:
                              BoxDecoration(color: Constant.mandatoryColor),
                              child: new TextFormField(
                                decoration: InputDecoration(
                                  hintText: Translations.of(context).text('Confirm_Password'),
                                  labelText: Translations.of(context).text('Confirm_Password'),
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      decorationColor: Colors.red),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      )),
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                                obscureText: true,

                                validator: (String arg) {
                                  if (arg==null )
                                    return Translations.of(context).text('new_Password_Should_Not_Be_Null');
                                  else if (arg.length < 8)
                                    return Translations.of(context).text('Password_Must_Be_More_Than_8_Charater');
                                  else if (!RegExp(
                                      r'[!@#$%<>?":_`~;[\]\\|=+)(*&^%-]')
                                      .hasMatch(arg)) {
                                    return Translations.of(context).text('Atleast_One_Special_Character_Req');
                                  }
                                  else if (!RegExp(
                                      r'[A-Z]')
                                      .hasMatch(arg)) {
                                    return Translations.of(context).text('Atleast_One_UpperCase_Character_Req');
                                  }else if (!RegExp(
                                      r'[a-z]')
                                      .hasMatch(arg)) {
                                    return Translations.of(context).text('Atleast_One_Lower_Case_Character_Req');
                                  }else if (arg!= null&&beanObj.musrpass==arg) {
                                    return Translations.of(context).text('New_Password_Must_Not_Same_As_Current');
                                  }
                                  else if (!RegExp(
                                      r'[0-9]')
                                      .hasMatch(arg)) {
                                    return Translations.of(context).text('Atleast_One_Numeric_Required');
                                  }else if (newPass != newCnfrmPass) {
                                    return Translations.of(context).text('New_Pass_And_Confirm_Must_Match');
                                  } else
                                    return null;
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(30),
                                ],
                                onSaved: (val) {
                                  newCnfrmPass= val;
                                },
                              )),



                          SizedBox(height:40.0),


                          Center(
                            child:  new Container(

                                child: new RaisedButton(
                                    child: Text(
                                      Translations.of(context).text('Change_Password'),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {

                                       tryChangePassword();
                                    })),

                          )




                          ]
                    )
                ),

              ),

            )
        )
    );
  }


  Future<Null> tryChangePassword() async {

    final FormState form = _formKey.currentState;

    bool netAvail = false;
    Utility obj = new Utility();
    netAvail = await obj.checkIfIsconnectedToNetwork();
    if (netAvail == false) {
      showInSnackBar(Translations.of(context).text('Network_Not_Available'));
      return;
    }


    if (form.validate()) {
      form.save();
      _performChangePassword();
    } else {
      setState(() => autovalidateVar = true);
      showInSnackBar(Translations.of(context).text('Please_Fix_The_Errors_In_Red_Before_Submitting'));
    }

  }


  Future _performChangePassword() async {

    LoginBean loginBean = new LoginBean();
    loginBean.musrcode = beanObj.musrcode;

    //try {

      String json =  await _toJson(beanObj);
        String bodyValue = await NetworkUtil.callPostService(json.toString(),
            Constant.apiURL.toString() + _serviceUrl.toString(), _headers);
        print("url " + Constant.apiURL.toString() + _serviceUrl.toString());
        print("returned value is "+bodyValue.toString());
        if (bodyValue == "404"|| bodyValue ==null) {
          return null;
        } else {
          print("trying to parse");
          LoginBean obj = await _fromLoginJson(bodyValue);


              print("error is ${obj.merror}");
          if(obj.merror==0){

            await AppDatabase.get().getLoginPass(loginBean).then((returnBean) async{
              if (returnBean == null) {

              }else if(returnBean.musrpass == loginBean.musrpass){
                loginBean.musrpass = beanObj.musrpass;
                await AppDatabase.get().updateUserPassword(loginBean);

              }
            });
            success("Password Changed", context);

          }
          else{
            showErrorDialog(obj.merror, obj.merrormessage);
          }

        }


    /*} catch(error){
    }*/





  }

  Future<LoginBean> _fromLoginJson(String json) async{
    Map<String, dynamic> map = JSON.decode(json);
    print(json + " form jso obj response" + "here is" + map.toString());
    var bean = LoginBean.fromMap(map);
    return bean;
  }


  void showInSnackBar(String value, [Color color]) {
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: color != null ? color : null,
    ));
  }





  success(String message, BuildContext context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(message)],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                onPressed: () {

                  if(widget.routedFrom=="login"){
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();



                    /*Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new HomeDashboard()), //When Authorized Navigate to the next screen
                    );*/

                  }else{
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }

                },
              ),
            ],
          );
        });
  }
  showErrorDialog(int errorCode, String message) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
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
                  Text(message)],
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


  Future<String> _toJson(LoginBean loginBean) async{
    var mapData = new Map();
    mapData[TablesColumnFile.musrcode] = loginBean.musrcode;
    mapData[TablesColumnFile.musrpass] = loginBean.musrpass+"~"+newPass;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    mapData[TablesColumnFile.mregdevicemacid] = androidInfo.androidId;
    mapData[TablesColumnFile.mlastupdatedt] = DateTime.now().toIso8601String();


    String json = JSON.encode(mapData);
    print(json.toString());
    return json;
  }

}