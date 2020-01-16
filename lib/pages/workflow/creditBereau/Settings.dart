import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'dart:async';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/main.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/SettingsBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart' as xml;
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'dart:math';
import 'package:device_info/device_info.dart';

class Settings extends StatefulWidget {
  final SettingsBean SettingsBeanPassedObject;

  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );


  Settings(
      {Key key, @required this.SettingsBeanPassedObject})
      : super(key: key);

  @override
  _SettingsState createState() =>
      new _SettingsState();
}


class _SettingsState
    extends State<Settings> {
  String _username;
  String _password;
  static int que = 0;
  static bool flag = false;
  bool boolVPN = false;
  bool isHttps = false;
  bool isPortRequired = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static const JsonCodec JSON = const JsonCodec();
  SettingsBean beanObj = new SettingsBean();
  SettingsBean cbb2 = new SettingsBean();
  bool circIndicatorContact = false;
  bool resendOtp = false;
  bool circIndicatorOTP = false;
  bool verifyBtn = true;
  var SMSVerURL = 'https://api.textlocal.in/send/?';
  bool boolValidate = false;
  SharedPreferences prefs;
  Utility obj = new Utility();
  TextEditingController _useCtrl = new TextEditingController();
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy");
  var formatter = new DateFormat('yyyy-MM-dd');

  static final _headers = {'Content-Type': 'application/x-www-form-urlencoded'};

  var _focusNode = new FocusNode();
  String androidId = "";

  @override
  void initState() {


    print("xxxxxxxxxxxxxxxinit statexxxxxxxxxxxxxxxx");
    super.initState();
    if(settingsBean!=null ) {

      beanObj.musrcode = settingsBean.musrcode != null &&
          settingsBean.musrcode!= "null"
          ? settingsBean.musrcode
          : "";
      beanObj.musrpass = settingsBean.musrpass != null &&
          settingsBean.musrpass != "null"
          ? settingsBean.musrpass
          : "";
      beanObj.mipaddress = settingsBean.mipaddress != null &&
          settingsBean.mipaddress != "null"
          ? settingsBean.mipaddress
          : "";
      beanObj.mportno = settingsBean.mportno != null &&
          settingsBean.mportno != "null"
          ? settingsBean.mportno
          : "";

      beanObj.mportno = settingsBean.mportno != null &&
          settingsBean.mportno != "null"
          ? settingsBean.mportno
          : "";

      print("xxxxxxxxxxxxxx${settingsBean.isPortRequired}");
      print("xxxxxxxxxxxxxx${settingsBean.isHttps}");

      isHttps = settingsBean.isHttps == null ||
          settingsBean.isHttps == 0
          ? false
          : true;

      isPortRequired = settingsBean.isPortRequired == null ||
          settingsBean.isPortRequired == 0
          ? false
          : true;
    }
    setMAcId();
  }

  Future<void> setMAcId()async{

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    setState(() {
      androidId=androidInfo.androidId;
    });

    prefs = await SharedPreferences.getInstance();
    int isVPN = prefs.getInt(TablesColumnFile.ISVPN);
    print("Value Of VPN ${isVPN}");
    if(isVPN==null){
      await await AppDatabase.get().getSystemParameter('23',0).then((SystemParameterBean sysBean){
        print("Retuned Sysbean = ${sysBean} ");
        if(sysBean==null){
          isVPN = 0;
          boolVPN = false;
        }
        else isVPN = int.parse(sysBean.mcodevalue);
      });
    }


    if(isVPN==0)boolVPN = false;

    else if(isVPN==1)boolVPN = true;
    setState(() {

    });
  }

  Widget getTextContainer(String textValue) {
    return new Container(
      padding: EdgeInsets.fromLTRB(5.0, 20.0, 0.0, 20.0),
      child: new Text(
        textValue,
        //textDirection: TextDirection,
        textAlign: TextAlign.start,
        /*overflow: TextOverflow.ellipsis,*/
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontStyle: FontStyle.normal,
            fontSize: 12.0),
      ),
    );
  }
  void setPassedData(SettingsBean cbb3) {
    setState(() {
      beanObj = cbb3;
    });

  }


  Future<bool> callDialog() {
    /*globals.Dialog.onPop(
        context,
        'Are you sure?',
        'Do you want to Exit without saving data',
        'settings');*/

    _out();
  }

  Widget statusRadio() => Settings._get(new Row(
    children: _makeRadios(2, globals.radioCaptionValuesStatusDetail, 0),
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  ));

  List<Widget> _makeRadios(int numberOfRadios, List textName, int position) {
    List<Widget> radios = new List<Widget>();
    for (int i = 0; i < numberOfRadios; i++) {
      radios.add(new Row(
        children: <Widget>[
          new Text(
            textName[i],
            textAlign: TextAlign.right,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontStyle: FontStyle.normal,
              fontSize: 10.0,
            ),
          ),
          new Radio(
            value: i,
            groupValue: beanObj.yesno,
            onChanged: (selection) => _onRadioSelected(selection, position),
            activeColor: Color(0xff07426A),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      ));
    }
    return radios;
  }

  _onRadioSelected(int selection, int position) {
    setState(() => globals.isMemberOfGroupListColl[position] = selection);
    beanObj.yesno = selection;
  }


  void changeVPN(bool val){
    setState(() {
      boolVPN = val;
    });


  }


  @override
  Widget build(BuildContext context) {
    print("build Loaded");
    bool _value1 = false;

    void onChanged1(bool value) => setState(() => _value1 = value);
    return Card(

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
                Translations.of(context).text('Settings'),
                //textDirection: TextDirection,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontStyle: FontStyle.normal),
              ),
              /*actions: <Widget>[
                new IconButton(
                    icon: const Icon(
                      Icons.save,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: addProspect),
                new IconButton(
                    icon: const Icon(
                      Icons.cloud_upload,
                      color: Colors.white,
                      size: 22.0,
                    ),
                    onPressed:_insertDummies )
              ],*/
            ),
            body: new SafeArea(
                top: false,
                bottom: false,
                child: new Form(
                    key: _formKey,
                    onWillPop: () {
                      _out();                    },
                    autovalidate: boolValidate,
                    onChanged: () {
                      final FormState _form2 = _formKey.currentState;
                      _form2.save();
                    },
                    child: SingleChildScrollView(
                        child: new Column(
                            children: <Widget>[
                              new Container(
                                color: Constant.mandatoryColor,
                                child:
                                new TextFormField(
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    hintText: Translations.of(context).text('Enter_Username_Here'),
                                    labelText: Translations.of(context).text('Username'),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    /*labelStyle: TextStyle(color: Colors.grey),*/
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        )),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xff5c6bc0),
                                        )),
                                    contentPadding: EdgeInsets.all(20.0),
                                  ),

                                  onFieldSubmitted: (v) {
                                    final FormState form = _formKey.currentState;
                                    form.save();
                                  },
                                  controller: beanObj.musrcode != null
                                      ? TextEditingController(text: beanObj.musrcode!=null && beanObj.musrcode!="null"?beanObj.musrcode:"")
                                      : TextEditingController(text: ""),
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(30),
                                    //globals.onlyCharacter
                                  ],
                                  onSaved: (val) {
                                    //  if(val!=null) {
                                    beanObj.musrcode = val;
                                    // }
                                  },
                                ),
                              ),

                              Container(
                                color: Constant.mandatoryColor,
                                child:
                                new TextFormField(
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    hintText: Translations.of(context).text('Enter_Password_Here'),
                                    labelText: Translations.of(context).text('Password'),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    /*labelStyle: TextStyle(color: Colors.grey),*/
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        )),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xff5c6bc0),
                                        )),
                                    contentPadding: EdgeInsets.all(20.0),
                                  ),
                                  onFieldSubmitted: (v) {
                                    final FormState form = _formKey.currentState;
                                    form.save();
                                  },
                                  controller: beanObj.musrpass != null
                                      ? TextEditingController(text: beanObj.musrpass)
                                      : TextEditingController(text: ""),
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(30),
                                    // globals.onlyCharacter
                                  ],
                                  onSaved: (val) {

                                    //  if(val!=null) {
                                    beanObj.musrpass = val;
                                    // }
                                  },
                                ),
                              ),
                              Container(
                                color: Constant.mandatoryColor,
                                child:
                                new TextFormField(
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    hintText: Translations.of(context).text('Enter_IP_Address_Here'),
                                    labelText: Translations.of(context).text('IP_Address'),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    /*labelStyle: TextStyle(color: Colors.grey),*/
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        )),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xff5c6bc0),
                                        )),
                                    contentPadding: EdgeInsets.all(20.0),
                                  ),
                                  onFieldSubmitted: (v) {
                                    final FormState form = _formKey.currentState;
                                    form.save();
                                  },
                                  controller: beanObj.mipaddress != null
                                      ? TextEditingController(text: beanObj.mipaddress)
                                      : TextEditingController(text: ""),
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(30),
                                    //globals.onlyDoubleNumber
                                  ],
                                  onSaved: (val) {
                                    //  if(val!=null) {
                                    beanObj.mipaddress = val;
                                    // }
                                  },
                                ),
                              ),
                              Container(
                                color: Constant.mandatoryColor,
                                child:
                                new TextFormField(
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    hintText: Translations.of(context).text('Enter_Port_Number'),
                                    labelText: Translations.of(context).text('Port_Number'),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    /*labelStyle: TextStyle(color: Colors.grey),*/
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        )),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xff5c6bc0),
                                        )),
                                    contentPadding: EdgeInsets.all(20.0),
                                  ),
                                  onFieldSubmitted: (v) {
                                    final FormState form = _formKey.currentState;
                                    form.save();
                                  },
                                  controller: beanObj.mportno != null
                                      ? TextEditingController(text: beanObj.mportno)
                                      : TextEditingController(text: ""),
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(30),
                                    //globals.onlyDoubleNumber
                                  ],
                                  onSaved: (val) {
                                    //  if(val!=null) {
                                    beanObj.mportno = val;
                                    // }
                                  },
                                ),
                              ),
                              Container(
                                color: Constant.mandatoryColor,
                                child:
                                new TextFormField(
                                  keyboardType: TextInputType.text,
                                  decoration:  InputDecoration(
                                    hintText: Translations.of(context).text('MAC_ID'),
                                    labelText: Translations.of(context).text('MAC_ID'),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    /*labelStyle: TextStyle(color: Colors.grey),*/
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        )),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xff5c6bc0),
                                        )),
                                    contentPadding: EdgeInsets.all(20.0),
                                  ),
                                  enabled: false,
                                  controller: androidId != null
                                      ? TextEditingController(text: androidId)
                                      : TextEditingController(text: ""),
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(30),
                                    //globals.onlyDoubleNumber
                                  ],

                                ),
                              ),
                              SwitchListTile(

                                title:  Text(Translations.of(context).text('VPN')),
                                value: boolVPN,
                                onChanged: (val) async {

                                  setState(() {
                                    boolVPN = val;
                                  });
                                  /*if(boolVPN==true){
                                    prefs.setInt(TablesColumnFile.ISVPN, 1);
                                  }else{
                                    prefs.setInt(TablesColumnFile.ISVPN, 0);

                                  }*/


                                }
                                ,
                                //s secondary: const Icon(Icons.lightbulb_outline),
                              ),


                              SwitchListTile(

                                title:  Text(Translations.of(context).text('Https')),
                                value: isHttps,
                                onChanged: (val) async {
                                   // changeisHTTPS(val);
                                  setState(() {
                                    isHttps = val;
                                  });
                                }
                                ,
                                //s secondary: const Icon(Icons.lightbulb_outline),
                              ),

                              SwitchListTile(

                                title:  Text(Translations.of(context).text('isWebServerConfig')),
                                value: isPortRequired,
                                onChanged: (val) async {
                                  //changeisPortRequired(val);
                                  print("val ${val}");
                                  setState(() {
                                    isPortRequired = val;
                                  });
                                }
                                ,
                                //s secondary: const Icon(Icons.lightbulb_outline),
                              ),

                              SwitchListTile(

                                title:  Text(Translations.of(context).text('Notification')),
                                value: _value1,
                                onChanged: onChanged1,
                                //s secondary: const Icon(Icons.lightbulb_outline),
                              ),

                              new Container(
                                  padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                                  child: new RaisedButton(
                                      child:  Text(
                                        Translations.of(context).text('Submit'),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        if (widget.SettingsBeanPassedObject != null) {
                                          // beanObj.misuploaded = 0;
                                          String isHttpsVal = "${isHttps? "https://" : "http://"}";
                                          String isPortRequiredVal = "${isPortRequired?"" : ":${beanObj.mportno}" }";
                                          Constant.apiURL=(isHttpsVal+beanObj.mipaddress+isPortRequiredVal+"/");
                                          print("beanObj.mipaddress");
                                          print(beanObj.mipaddress);
                                          print("Constant.apiURL");
                                          print(Constant.apiURL);
                                          print("chnging is uploaded");
                                          proceed();
                                        } else {
                                          // Constant.apiURL=beanObj.mipaddress;
                                          String isHttpsVal = "${isHttps? "https://" : "http://"}";
                                          String isPortRequiredVal = "${isPortRequired?"" : ":${beanObj.mportno}" }";
                                          Constant.apiURL=(isHttpsVal+beanObj.mipaddress+isPortRequiredVal+"/");
                                          print("beanObj.mipaddress");
                                          print(beanObj.mipaddress);
                                          print("Constant.apiURL");
                                          print(Constant.apiURL);
                                          proceed();
                                        }


                                      }))
                            ]
                        )
                    )
                )
            )
        )
    );

  }
  proceed()  async{
    beanObj.trefno=1;

    Constant.isHttpsCallNeeded = isHttps? true : false;
    beanObj.isHttps=  isHttps == null ||
        isHttps == false
        ? 0
        : 1;

    beanObj.isPortRequired=  isPortRequired == null ||
        isPortRequired == false
        ? 0
        : 1;

   // print(" settingsBean.isHttps ${settingsBean.isHttps} ");
    //print(" settingsBean.isPortRequired ${settingsBean.isPortRequired} ");
    await AppDatabase.get()
        .updateSettingsMaster(beanObj)
        .then((val) {
      //print("val here is " + val.toString());
    });

    prefs.setInt(TablesColumnFile.ISVPN, boolVPN==true?1:0);
    _successfulSubmit();
  }


  Future<void> _out() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translations.of(context).text('Back_To_Login_Page')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(Translations.of(context).text('Are_You_Sure_You_Want_To_Exit_Without_Saving'))
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                Translations.of(context).text('Yes'),
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                Translations.of(context).text('No'),
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
  Future<void> _successfulSubmit() async {
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
                  Text(Translations.of(context).text('Done')),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text((Translations.of(context).text('Ok'))),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
