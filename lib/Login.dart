<<<<<<< .mine

=======
import 'package:eco_mfi/pages/workflow/FPSPages/AgentBiometricCheck.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
>>>>>>> .r1143
import 'package:eco_mfi/pages/workflow/Workflow_Grid_Dashboard.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationCenterAndGroupDetails.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/DeviceSetting.dart';
import 'package:geolocator/geolocator.dart';
import 'package:eco_mfi/MenuAndRights/UserRightsBean.dart';

//import 'package:geo_location_finder/geo_location_finder.dart';
import 'package:eco_mfi/LoginBean.dart';
import 'package:eco_mfi/LoginServices.dart';
import 'package:eco_mfi/Utilities/ReadXmlCost.dart';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/initializer.dart';
import 'package:eco_mfi/application.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/CommonAppDataBase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/main.dart';
import 'package:eco_mfi/pages/home/Home_Dashboard.dart';
import 'dart:io';
import 'package:meta/meta.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eco_mfi/pages/workflow/PassChangeModule/ChangePassword.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Settings.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingActivityMenuList.dart';
import 'package:eco_mfi/translations.dart';
import 'package:toast/toast.dart';
import 'pincode/pincode_verify.dart';
import 'pincode/pincode_create.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/Utilities/components.dart';
import 'Utilities/networt_util.dart';
import 'package:eco_mfi/Utilities/ThemeDesign.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  var settingsBean;

  LoginPage(this.settingsBean);

  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username;
  String _password;
  bool _usePinCode = false;
  bool isNetworkAvalable = false;
  LoginBean loginBeanGlobal = new LoginBean();
  static Utility obj = new Utility();

  bool autovalidate = false;

<<<<<<< .mine
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');

  String LhThumbValue = "";

  String LhIndexFingerValue = "";

  String LhMiddleFingerValue = "";

  String LhRingFingerValue = "";

  String LhPinkyFingerValue = "";

  String RhThumbValue = "";

  String RhIndexFingerValue = "";

  String RhMiddleFingerValue = "";

  String RhRingFingerValue = "";

  String RhPinkyFingerValue = "";

=======
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');

  String LhThumbValue = "";

  String LhIndexFingerValue = "";

  String LhMiddleFingerValue = "";

  String LhRingFingerValue = "";

  String LhPinkyFingerValue = "";

  String RhThumbValue = "";

  String RhIndexFingerValue = "";

  String RhMiddleFingerValue = "";

  String RhRingFingerValue = "";

  String RhPinkyFingerValue = "";

  SharedPreferences prefs;
  String projectCd="";
  LookupBeanData language;

>>>>>>> .r1143
  void _handleSubmitted() {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
      showInSnackBar("Username/Password Required");
    } else {
      form.save();
      _performLogin();
    }
  }

<<<<<<< .mine
=======
  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();

>>>>>>> .r1143
    try{
    projectCd = prefs.getString(TablesColumnFile.PROJECTCODE);
  }catch(_){}

  if(projectCd!=null && projectCd !='null') {

    applic.onLocaleChanged(new Locale('en${projectCd}', ''));
  }else{

    applic.onLocaleChanged(new Locale('en', ''));
  }

  }

  @override
  void initState() {
    super.initState();
<<<<<<< .mine
    if (settingsBean != null) {
      _username =
          settingsBean.musrcode != null && settingsBean.musrcode != "null"
              ? settingsBean.musrcode
              : "";
      _password =
          settingsBean.musrpass != null && settingsBean.musrpass != "null"
              ? settingsBean.musrpass
              : "";
=======


    getSessionVariables();

    if (settingsBean != null) {
      _username =
          settingsBean.musrcode != null && settingsBean.musrcode != "null"
              ? settingsBean.musrcode
              : "";
      _password =
          settingsBean.musrpass != null && settingsBean.musrpass != "null"
              ? settingsBean.musrpass
              : "";
>>>>>>> .r1143
    }
<<<<<<< .mine
=======
  }

>>>>>>> .r1143
  showDropDown(LookupBeanData selectedObj, int no) {
    for (int k = 0; k < globals.dropDownLanguage[no].length; k++) {
      if (globals.dropDownLanguage[no][k].mcodedesc ==
          selectedObj.mcodedesc) {
        setValue(no, globals.dropDownLanguage[no][k]);
      }
    }
  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          language = value;
          print('${value.mcode}${projectCd}');

          try {
            applic.onLocaleChanged(
                new Locale('${value.mcode}${projectCd}', ''));
          }catch(_){
            applic.onLocaleChanged(new Locale('en${projectCd}', ''));

          }
          //new Locale('${value.mcode}${projectCd}', '');
          setState(() {

          });
          break;
        default:
          break;
      }
    });
  }

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    //print("caption value : " + globals.captionIdType[no]);

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(bean);
    for (int k = 0; k < globals.dropDownLanguage[no].length; k++) {
      mapData.add(globals.dropDownLanguage[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      //print("data here is of  dropdownwale biayajai " + value.mcodedesc);
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc),
      );
    }).toList();
    /*   if(no==0){
      print(mapData);
      testString = mapData;
    }*/
    return _dropDownMenuItems1;
  }


  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  Future<bool> _loginRequest(String username, String password) async {
    LoginBean loginBean = new LoginBean();
    bool isloginRetValue = false;
    // isNetworkAvalable = await checkIfIsconnectedToNetwork();
    isNetworkAvalable = await Utility.checkIntCon();
    loginBean.musrcode = username;
    loginBean.musrpass = password;
    if (!isNetworkAvalable) {
      try {
        print("network not available");

        await AppDatabase.get()
            .getLoginData(loginBean)
            .then((afterLogin) async {
          print("after login    ${afterLogin}");
          try {
            UserRightBean beanGet = new UserRightBean(
                mgrpcd: loginBean.mgrpcd, musrcode: loginBean.musrcode);
            await Constant.getAccessRights(beanGet);
          } catch (_) {
            print("Catch insiude");
          }
          if (afterLogin == null) {
            isloginRetValue = false;
            print("after login came null");
          } else if (afterLogin.musrcode.trim().toUpperCase() ==
                  loginBean.musrcode.trim().toUpperCase() &&
              afterLogin.musrpass.trim().toUpperCase() ==
                  loginBean.musrpass.trim().toUpperCase() &&
              afterLogin.mnextpwdchgdt != null &&
              afterLogin.mnextpwdchgdt.isAfter(DateTime.now())) {
            try {
              UserRightBean beanGet = new UserRightBean(
                  mgrpcd: loginBean.mgrpcd, musrcode: loginBean.musrcode);
              await Constant.getAccessRights(beanGet);
            } catch (_) {
              print("Catch insiude");
            }
            _afterLogin(afterLogin);
            isloginRetValue = true;
          } else if (afterLogin.musrcode.trim().toUpperCase() ==
                  loginBean.musrcode.trim().toUpperCase() &&
              afterLogin.musrpass.trim().toUpperCase() ==
                  loginBean.musrpass.trim().toUpperCase() &&
              afterLogin.mnextpwdchgdt != null &&
              afterLogin.mnextpwdchgdt.isBefore(DateTime.now())) {
            try {
              UserRightBean beanGet = new UserRightBean(
                  mgrpcd: loginBean.mgrpcd, musrcode: loginBean.musrcode);
              await Constant.getAccessRights(beanGet);
            } catch (_) {
              print("Catch insiude");
            }

            print(" after Date");
            isloginRetValue = false;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString(
                TablesColumnFile.musrcode, loginBean.musrcode.toString());
            loginBeanGlobal.merrormessage = 'Password Expired';
            try {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            } catch (_) {}
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new ChangePassword(
                      "login")), //When Authorized Navigate to the next screen
            );
          } else {
            print("inside else");
          }
        });
      } catch (error) {
        print("Ye catch fata");
        isloginRetValue = false;
      }
    } else if (isNetworkAvalable) {
      var loginServices = new LoginServices();
      //try {
      print("network is available");
      await loginServices.login(loginBean).then((value) async {
        loginBeanGlobal = value;
        print("error is  ${value.merror}");
        try {
          UserRightBean beanGet = new UserRightBean(
              mgrpcd: loginBean.mgrpcd, musrcode: loginBean.musrcode);
          await Constant.getAccessRights(beanGet);
        } catch (_) {
          print("Catch insiude");
        }

        if (value != null && value.merror == 50) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(
              TablesColumnFile.musrcode, loginBean.musrcode.toString());

          try {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          } catch (_) {
            print("3rd ctach fata");
          }
          print("error message ${value.merrormessage} ");
          await AppDatabase.get()
              .updateLoginColumn(value, username)
              .then((loginColumn) {
            print(loginColumn);
          });
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new ChangePassword(
                    "login")), //When Authorized Navigate to the next screen
          );
        } else if (value != null && value.merror == 0) {
          try {
            UserRightBean beanGet = new UserRightBean(
                mgrpcd: loginBean.mgrpcd, musrcode: loginBean.musrcode);
            await Constant.getAccessRights(beanGet);
          } catch (_) {
            print("Catch insiude");
          }

<<<<<<< .mine
          _afterLogin(value);
          SyncingActivityState obj = SyncingActivityState();
          print("updating  login column");
          await AppDatabase.get()
              .updateLoginColumn(value, username)
              .then((loginColumn) {
            print(loginColumn);
          });
          print("afterLopgin5");
          isloginRetValue = true;
          try {
            obj.syncFactory("login");
          } catch (_) {
            print("Syncing Fat gya hai");
=======
          _afterLogin(value);
          SyncingActivityState obj = SyncingActivityState();
          print("updating  login column");
          await AppDatabase.get()
              .updateLoginColumn(value, username)
              .then((loginColumn) {
            print(loginColumn);
          });
          print("afterLopgin5");
          isloginRetValue = true;
          try {
            obj.syncFactoryLimited("login");
          } catch (_) {
            print("Syncing Fat gya hai");
>>>>>>> .r1143
          }
        }
      });
      /*}catch(_){
        try {


          print("Inside 2nd catch");
          await AppDatabase.get().getLoginData(loginBean).then((afterLogin) {
            if (afterLogin == null) {
              isloginRetValue = false;
            } else if (afterLogin.musrcode.trim().toUpperCase() == loginBean.musrcode.trim().toUpperCase() &&
                afterLogin.musrpass.trim().toUpperCase() == loginBean.musrpass.trim().toUpperCase()) {
              _afterLogin(afterLogin);
              isloginRetValue = true;
            } else {

            }
          });
        } catch(error){
          isloginRetValue = false;
        }
      }*/
    }
    return isloginRetValue;
  }

  _afterLogin(LoginBean loginBean) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      print("login branch code of user " + loginBean.musrbrcode.toString());
      prefs.setString(
          TablesColumnFile.mreportinguser, loginBean.mreportinguser.toString());
      globals.agentUserName = loginBean.musrcode.toString().trim();
      globals.branchId = loginBean.musrbrcode;
      globals.reportingUser = loginBean.mreportinguser.trim();
      prefs.setString(TablesColumnFile.musrcode, loginBean.musrcode.toString());
      prefs.setString(TablesColumnFile.usrDesignation,
          loginBean.musrdesignation.toString());
      prefs.setInt(TablesColumnFile.grpCd, loginBean.mgrpcd);
      prefs.setString(
          TablesColumnFile.LoginTime, new DateTime.now().toString());
      prefs.setString(TablesColumnFile.musrname, loginBean.musrname.toString());
      prefs.setInt(TablesColumnFile.musrbrcode, loginBean.musrbrcode);
      prefs.setString(
          TablesColumnFile.mreportinguser, loginBean.mreportinguser.toString());

      await Constant.setSystemVariables("login");
      try {
        await performGeoTaggingOfAgent(prefs);
      } catch (_) {}

      if (!isNetworkAvalable) {
        prefs.setInt("error", 99);
        prefs.setString("errorMessage", "UserName or Password is not valid");
      }
    } catch (_) {}
  }

  Future<Null> performGeoTaggingOfAgent(SharedPreferences prefs) async {
    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    print("xxxxxxxxxxxxxxtrying to perform Geotagging");
    StreamSubscription<Position> positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) {
      print("setting position");
      print(position == null
          ? 'Unknown'
          : 'positions' +
              position.latitude.toString() +
              ', ' +
              position.longitude.toString());
      prefs.setDouble(TablesColumnFile.geoLatitude, position.latitude);
      prefs.setDouble(TablesColumnFile.geoLongitude, position.longitude);
    });

    print("Here comes the goelatitude");
    print(prefs.getDouble(TablesColumnFile.geoLatitude));
    Map<dynamic, dynamic> locationMap;

    /*locationMap = await GeoLocation.getLocation;
      var status = locationMap["status"];
      if ((status is String && status == "true") ||
          (status is bool) && status) {
        var lat = locationMap["latitude"];
        var lng = locationMap["longitude"];
        prefs.setDouble(TablesColumnFile.geoLatitude, lat);
        prefs.setDouble(TablesColumnFile.geoLongitude, lng);
      }*/
  }

  Future<bool> checkIfIsconnectedToNetwork() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  void _performLogin() async {
    await tryLogin(_username, _password);
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (_) {
      print("Hide snckbar fata");
    }

    /* navigateToScreen('Home');*/
    /*if(isLoggedIn==true){

    }*/
  }

  tryLogin(String username, String password) async {
    showMessage("Trying To login Please Wait", Colors.grey);

    bool isLoggedIn = await _loginRequest(username, password);
    print(
        'errormessage  in trylogin' + loginBeanGlobal.merrormessage.toString());
    if (!mounted) return;
    if (isLoggedIn) {
      print("Valid Login!");

      setState(() {
        //callSystemLevelSyncingForFirstTime();
      });
      try {
        _scaffoldKey.currentState.hideCurrentSnackBar();
      } catch (_) {
        print("Dusri bar ka scaffold fata");
      }
      await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                new HomeDashboard()), //When Authorized Navigate to the next screen
      );
    } else {
      String errorMessage = "No Response From Server";
      if (loginBeanGlobal.merrormessage != null &&
          loginBeanGlobal.merrormessage.trim() != 'null' &&
          loginBeanGlobal.merrormessage.trim() != 'null') {
        errorMessage = loginBeanGlobal.merrormessage;
      }
      print("Login not matched");
      setState(() {
        globals.Utility.showAlertPopup(context, "Info", errorMessage);
      });
    }
  }

  Future<Null> navigateToScreen(String name) async {
    if (name.contains('Home')) {
      await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                new HomeDashboard()), //When Authorized Navigate to the next screen
      );
    } else if (name.contains('ChangePassword')) {
      await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new ChangePassword(
                "login")), //When Authorized Navigate to the next screen
      );
    } else {
      print('Error: $name');
    }
  }

  String _authorized = 'Not Authorized';

  /* Future<Null> _goToBiometrics() async {
    final LocalAuthentication auth = new LocalAuthentication();
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: "scanFingure",
          useErrorDialogs: true,
          stickyAuth: false);
    } catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() async{
      _authorized = authenticated ? "Authorized" : "Not Authorized";
      print(_authorized);

      if (authenticated) {
        //do this lateron while gl;oggiong from biometric
        */ /*  await AppDatabase.get().getLoginData(loginBean).then((afterLogin) {
          if (afterLogin == null) {
          } else if (afterLogin.musrcode == loginBean.musrcode &&
              afterLogin.usrPass == loginBean.usrPass) {
            _afterLogin(afterLogin);
            isloginRetValue = true;
          } else {

          }
        });*/ /*
        //TODO if logging from biometric then take every
        // Todo logging requried data as default like login agent and all
        navigateToScreen('Home');
      } else {
        globals.Utility.showAlertPopup(
            context, "Info", "login Biometric error");
      }
    });
  }*/

  void newAccount() {
    /* Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          Initializer.addCGT2Questions();
          return HomeDashboard(widget.cameras);
        },
        fullscreenDialog: true));*/
    // navigateToScreen('Home');
    globals.Dialog.alertPopup(context, "This module is locked",
        "Please ask support team To open this", "LoginPage");
  }

  /*Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          globals.Utility.showAlertPopup(context, "Info", "In progress");
        },
        fullscreenDialog: true));*/

  void openSettings() {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new Settings(
                SettingsBeanPassedObject: null,
              )),
    );
  }

  void needHelp() {
    /*  Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          globals.Utility.showAlertPopup(context, "Info", "In progress");
        },
        fullscreenDialog: true));*/
    globals.Dialog.alertPopup(context, "This module is locked",
        "Please ask support team To open this", "LoginPage");
  }

  Future<bool> callDialog() {
    globals.Dialog.onWillPop(
        context, 'Are you sure?', 'Do you want to Exit', 'Exit');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: callDialog,
      child: new Scaffold(
        key: _scaffoldKey,
        /*appBar: new AppBar(
          elevation: 1.0,
          title: new Text(
            "Saija Microfinance",
            style: new TextStyle(color: Colors.white),
          ),
          title:  new Image(
            image: new AssetImage("assets/clientlogo.png"),
          ),
          //backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
        ),*/
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              /*IconButton(icon: Icon(Icons.menu), onPressed: () {},),
                IconButton(icon: Icon(Icons.search), onPressed: () {},),*/
              new Text("  V U : " + globals.version.toString()),
              new Image(
                image: new AssetImage("assets/only_eco.png"),
              ),
              SizedBox(),
              new Image(
                image: new AssetImage("assets/Infrasoft_Footer.png"),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: new Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 775.0
                ? MediaQuery.of(context).size.height
                : 775.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    ThemeDesign.loginGradientStart,
                    ThemeDesign.loginGradientEnd
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),

            //color: Colors.white,
            child: new ListView(
              // physics: new AlwaysScrollableScrollPhysics(),
              key: new PageStorageKey("Divider 1"),
              children: <Widget>[
                new Container(
                  height: 50.0,
                ),
                new Container(
                  padding: EdgeInsets.all(20.0),

                  // child: new Card(

                  child: new Column(
                    children: <Widget>[
                      new Container(height: 30.0),
                      Column(
                        children: <Widget>[
                          new Icon(
                            globals.isLoggedIn
                                ? Icons.lock_open
                                : Icons.lock_outline,
                            size: 60.0,
                            //color: Color(0xff07426A),
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: new Form(
                          key: formKey,
                          child: new Column(
                            children: [
                              new TextFormField(
                                decoration: new InputDecoration(
                                    labelText: Translations.of(context)
                                        .text('username'),
                                    labelStyle:
                                        TextStyle(color: Colors.white70),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.white70,
                                    ))),
                                initialValue:
                                    _username != null && _username != 'null'
                                        ? _username
                                        : "",
                                validator: (val) =>
                                    val.length < 1 ? "UsernameRequired" : null,
                                onSaved: (val) => _username = val,
                                obscureText: false,
                                keyboardType: TextInputType.text,
                                autocorrect: false,
                              ),
                              new Container(height: 10.0),
                              new TextFormField(
                                decoration: new InputDecoration(
                                    labelText: Translations.of(context)
                                        .text('password'),
                                    labelStyle:
                                        TextStyle(color: Colors.white70),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.white70,
                                    ))),
                                initialValue:
                                    _password != null && _password != 'null'
                                        ? _password
                                        : "",
                                validator: (val) =>
                                    val.length < 1 ? "PasswordRequired" : null,
                                onSaved: (val) => _password = val,
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                autocorrect: false,
                              ),
                              new Container(height: 5.0),
<<<<<<< .mine
                              new DropdownButtonFormField(
                                items: <String>['English', 'हिंदी', 'Burmese']
                                    .map((String value) {
=======
                             /* new DropdownButtonFormField(
                                items: <String>['English', 'हिंदी', 'Burmese']
                                    .map((String value) {
>>>>>>> .r1143
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  switch (val) {
                                    case ('English'):
<<<<<<< .mine
                                      applic.onLocaleChanged(
                                          new Locale('en', ''));
=======
                                      applic.onLocaleChanged(
                                          new Locale('en${projectCd}', ''));
>>>>>>> .r1143
                                      break;
<<<<<<< .mine
                                    case ('हिंदी'):
                                      applic.onLocaleChanged(
                                          new Locale('hn', ''));
=======
                                    case ('हिंदी'):
                                      applic.onLocaleChanged(
                                          new Locale('hn${projectCd}', ''));
>>>>>>> .r1143
                                      break;
                                    case ('Burmese'):
                                      applic.onLocaleChanged(
                                          new Locale('my', ''));
                                      break;
                                    default:
                                      print("Nothing ");
                                  }
                                },
                                decoration: InputDecoration(
<<<<<<< .mine
                                    labelText: "Select Language"),
                              )
=======
                                    labelText: "Select Language"),
                              )*/

>>>>>>> .r1143
                              new DropdownButtonFormField(
                                value: language,
                                items: generateDropDown(0),
                                onChanged: (LookupBeanData newValue) {
                                  showDropDown(newValue, 0);
                                },
                                validator: (args) {
                                  print(args);
                                },
                                //  isExpanded: true,
                                //hint:Text("Select"),
                                decoration:
                                InputDecoration(labelText: "Select Language"),
                                // style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // ),
                ),
                new Padding(
                  padding: EdgeInsets.all(20.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: new RaisedButton(
                            color: Color(0xff07426A),
                            onPressed: _handleSubmitted,
                            child: new Text(
                                Translations.of(context).text('login'),
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 18.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
<<<<<<< .mine
                new Container(
                    child: ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                            height: 100.0, width: 100.00),
                        // for positioning of icon of scanner
                        child: FlatButton(
                            onPressed: () async {
                              await AppDatabase.get()
                                  .getAgentFingerPrint()
                                  .then((onValue) {
                                print("ola>>"+onValue.toString());
                                if (onValue.agentrightfinger.toString() !=null && onValue.agentrightfinger.toString().length >7){
                                  RhThumbValue = onValue.agentrightfinger.toString();
                                }
                                if (onValue.agentleftfinger.toString() !=null && onValue.agentleftfinger.toString().length >7){
                                  LhThumbValue = onValue.agentleftfinger.toString();
                                }

                              });
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
                              print("bT>>> $bluetootthAdd");
                              if(bluetootthAdd.toString() !=null&& bluetootthAdd.toString().length >7 ){
                              _callChannelAgentFPSMatch();
                              }else{
                                Toast.show("Please select a bluetooth device!", context);
                              }
                            },
                            child: Image.asset(
                                "assets/fpsImages/agent_biometric_img.png")))),
                new Padding(
                  padding: EdgeInsets.all(20.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(Translations.of(context).text('create_account')),
                      new TextButton(
                          name: Translations.of(context).text('need_help'),
                          onPressed: needHelp),
                      new IconButton(
                        icon: new Icon(Icons.settings,
                            size: 40, color: Colors.white),
                        onPressed: () {
                          openSettings();
                        },
                      ),
                    ],
                  ),
=======
                new Container(
                    child: ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                            height: 100.0, width: 100.00),
                        // for positioning of icon of scanner
                        child: FlatButton(
                            onPressed: () async {
                              await AppDatabase.get()
                                  .getAgentFingerPrint()
                                  .then((onValue) {
                                print("ola>>"+onValue.toString());
                                if (onValue.agentrightfinger.toString() !=null && onValue.agentrightfinger.toString().length >7){
                                  RhThumbValue = onValue.agentrightfinger.toString();
                                }
                                if (onValue.agentleftfinger.toString() !=null && onValue.agentleftfinger.toString().length >7){
                                  LhThumbValue = onValue.agentleftfinger.toString();
                                }

                              });
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
                              print("bT>>> $bluetootthAdd");
                              if(bluetootthAdd.toString() !=null&& bluetootthAdd.toString().length >7 ){
                                _callChannelAgentFPSMatch();
                              }else{
                                Toast.show("Please select a bluetooth device!", context);
                              }

                            },
                            child: Image.asset(
                                "assets/fpsImages/agent_biometric_img.png")))),
                new Padding(
                  padding: EdgeInsets.all(20.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(Translations.of(context).text('create_account')),
                      new TextButton(
                          name: Translations.of(context).text('need_help'),
                          onPressed: needHelp),
                      new IconButton(
                        icon: new Icon(Icons.settings,
                            size: 40, color: Colors.white),
                        onPressed: () {
                          openSettings();
                        },
                      ),
                    ],
                  ),
>>>>>>> .r1143
                ),
                new TextButton(
                    name: Translations.of(context).text('device_setting'),
                    onPressed: () {
                      Navigator.push(
                          context, SlideRightRoute(page: new DeviceSetting()));
                    }),
                SizedBox(height: 400.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

<<<<<<< .mine
  void callSystemLevelSyncingForFirstTime() async {
=======
  void callSystemLevelSyncingForFirstTime() async {

>>>>>>> .r1143
  }
<<<<<<< .mine
      await AppDatabase.get()
          .selectStaticTablesLastSyncedMaster(10, true)
          .then((onValue) async {
        if (onValue == null) {
          globals.circleIndicator = true;
          await AppDatabase.get().createSubLookupInsert();
          await Constant.getDropDownInitialize();
        }
      });

      await AppDatabase.get()
          .selectStaticTablesLastSyncedMaster(9, true)
          .then((onValue) async {
        if (onValue == null) {
          globals.circleIndicator = true;
          await AppDatabase.get().createLookupInsert();
          await Constant.getDropDownInitialize();
        }
      });

      await AppDatabase.get()
          .selectStaticTablesLastSyncedMaster(8, true)
          .then((onValue) async {
        if (onValue == null) {
          globals.circleIndicator = true;
          await AppDatabase.get().createSystemParameterInsert();
          await Constant.getDropDownInitialize();
          await Constant.setSystemVariables("login");
        }
      });
      globals.circleIndicator = false;
    }
  }

=======
>>>>>>> .r1143
  void showMessage(String message, [MaterialColor color = Colors.red]) {
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Row(
        children: <Widget>[
          const CircularProgressIndicator(),
          new Text(message)
        ],
      ),
      duration: Duration(seconds: 35),
    ));
  }

  _callChannelAgentFPSMatch() async {
    //  prefs = await SharedPreferences.getInstance();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(TablesColumnFile.userType, "AGENT");
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    print("Sending Value is $RhMiddleFingerValue");
    print("Sending Value is $RhIndexFingerValue");
    print("Sending Value is  for LH Index $LhIndexFingerValue");
    print("Sending Value is  LH MIDDle $LhMiddleFingerValue");
    print("Sending Value is  LH Thumb $LhThumbValue");
    try {
      final String result = await platform.invokeMethod("callingForFPSMatch", {
        "callValue": 0,
        "BluetoothADD": bluetootthAdd,
        "LhThumbValue": LhThumbValue,
        "LhIndexFingerValue": LhIndexFingerValue,
        "LhMiddleFingerValue": LhMiddleFingerValue,
        "LhRingFingerValue": LhRingFingerValue,
        "LhPinkyFingerValue": LhPinkyFingerValue,

        "RhThumbValue": RhThumbValue,
        "RhIndexFingerValue": RhIndexFingerValue,
        "RhMiddleFingerValue": RhMiddleFingerValue,
        "RhRingFingerValue": RhRingFingerValue,
        "RhPinkyFingerValue": RhPinkyFingerValue,
        // TODO pass dynamic blutooth address
      });
      String geTest = '$result';

      if (result == '-5') {
        setState(() {
          print("User Verified");
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                new HomeDashboard()),
          );

        });
      } else if (result == '-1') {
        setState(() {});
      } else if (result == '0') {
        setState(() {});
      }
      print("FLutter : " + geTest.toString());
    } on PlatformException catch (e) {
      print("FLutter : " + e.message.toString());
    }
  }
}
