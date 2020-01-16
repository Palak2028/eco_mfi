import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/DeviationFormBean.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;


class DeviationForm extends StatefulWidget {
  final deviatnFormPassedObject;
  final loanPassedObject;

  DeviationForm(this.deviatnFormPassedObject,this.loanPassedObject);
  

  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );
  @override
  _DeviationFormState createState() => new _DeviationFormState();
}

class _DeviationFormState extends State<DeviationForm> {
  TextEditingController branchController = new TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SharedPreferences prefs;
  String username;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;
  int branch = 0;
  String loginTime;
  int usrGrpCode = 0;
  DeviationFormBean dfObj = new DeviationFormBean();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  LookupBeanData devloanapp;
  bool checkBox2 = false;
  bool checkBox3 = false;
  bool checkBox4 = false;
  bool checkBox5 = false;
  bool checkBox6 = false;

  Future<Null> getSessionVariables() async {
    if (widget.deviatnFormPassedObject != null) {
      dfObj = widget.deviatnFormPassedObject;
    } else {
      AppDatabase.get().generateDeviationForm().then((onValue) {
        setState(() {
          dfObj.trefno = onValue;
        });

      });
    }
    
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode);
      username = prefs.getString(TablesColumnFile.musrcode);
      print("username"+username.toString());
      usrRole = prefs.getString(TablesColumnFile.musrdesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.mgrpcd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.mgeolocation);
      geoLatitude = prefs.get(TablesColumnFile.mgeolatd).toString();
      geoLongitude = prefs.get(TablesColumnFile.mgeologd).toString();
      reportingUser = prefs.getString(TablesColumnFile.mreportinguser);
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.deviatnFormPassedObject != null) {
      dfObj = widget.deviatnFormPassedObject;

      if (dfObj.mdrnrc == 1)
        checkBox2 = true;
      else
        checkBox2 = false;
      if (dfObj.mdrmni == 1)
        checkBox3 = true;
      else
        checkBox3 = false;
      if (dfObj.mdrdbr == 1)
        checkBox4 = true;
      else
        checkBox4 = false;
      if (dfObj.mdrmfi == 1)
        checkBox5 = true;
      else
        checkBox5 = false;
      if (dfObj.mdrbl == 1)
        checkBox6 = true;
      else
        checkBox6 = false;
    } else {
      dfObj = new DeviationFormBean();
      dfObj.mloantrefno = widget.loanPassedObject.trefno;
      dfObj.mloanmrefno = widget.loanPassedObject.mrefno;
      dfObj.mcusttrefno = widget.loanPassedObject.mcusttrefno;
      dfObj.mcustmrefno = widget.loanPassedObject.mcustmrefno;
      dfObj.mleadsid = widget.loanPassedObject.mleadsid;
    }
    
    getSessionVariables();
    List tempDropDownValues =  new List();
    tempDropDownValues.add(dfObj.mdevloanapp);
    //tempDropDownValues.add(dfObj.mcrdr);
    //print(dfObj.mdevloanapp);
    for (int k = 0;
    k < globals.dropdownCaptionsValuesDeviationForm.length;
    k++) {
      for (int i = 0;
      i < globals.dropdownCaptionsValuesDeviationForm[k].length;
      i++) {
        print("k and i is $k $i");
        print(globals.dropdownCaptionsValuesDeviationForm[k][i].mcode.length);
        try{
          if (globals.dropdownCaptionsValuesDeviationForm[k][i].mcode.toString() ==
              tempDropDownValues[k].toString().trim()) {

            print("matched $k");
            setValue(k, globals.dropdownCaptionsValuesDeviationForm[k][i]);
          }
        }catch(_){
          print("Exception in dropdown");
        }
      }
    }

  }

  showDropDown(LookupBeanData selectedObj, int no) {

    if(selectedObj.mcodedesc.isEmpty){
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          devloanapp = blankBean;
          dfObj.mdevloanapp = blankBean.mcode;
          break;
        default:
          break;
      }
      setState(() {
      });
    }
    else{
      for (int k = 0;
      k < globals.dropdownCaptionsValuesDeviationForm[no].length;
      k++) {
        if (globals.dropdownCaptionsValuesDeviationForm[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesDeviationForm[no][k]);
        }
      }
    }
  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          devloanapp = value;
          dfObj.mdevloanapp = value.mcode;
          break;
        default:
          break;
      }
    });
  }

  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);
  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
    k < globals.dropdownCaptionsValuesDeviationForm[no].length;
    k++) {
      mapData.add(globals.dropdownCaptionsValuesDeviationForm[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc,overflow: TextOverflow.ellipsis,maxLines: 3,),
      );
    }).toList();
    return _dropDownMenuItems1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title: new Text(Translations.of(context).text('DEVIATION FORM')),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.save,
              color: Colors.white,
              size: 40.0,
            ),
            onPressed: () {
              proceed();
            },
          ),

          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
        ],
      ),

      body: Form(
        key: _formKey,
        onChanged: () {
          final FormState form = _formKey.currentState;
          form.save();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Card(
                  child:
                  new TextField(
                    controller: new TextEditingController(
                        text:
<<<<<<< .mine
                        "${dfObj.mleadsid == null ? "0" : dfObj.mleadsid}"
                            "/${dfObj.mloantrefno == null ? "0" : dfObj.mloantrefno} - ${dfObj.mloanmrefno == null ? "0" : dfObj.mloanmrefno}"),
=======
                            "${dfObj.mloantrefno == null? "0" : dfObj.mloantrefno}"
                            "/${dfObj.mloanmrefno == null? "0" : dfObj.mloanmrefno}"
                            "/${dfObj.mleadsid == null||dfObj.mleadsid.trim()=="null" ? "0" : dfObj.mleadsid}"),
>>>>>>> .r1143
                    enabled: false,
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        hintText: Translations.of(context)
                            .text('Leads_Id_Leads_Refno'),
                        labelText: Translations.of(context)
                            .text('Leads_Id_Leads_Refno'),
                        prefixText: '',
                        suffixText: '',
                        suffixStyle: const TextStyle(color: Colors.green)),
                  )
              ),
              new Card(
                color: Constant.mandatoryColor,
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: devloanapp,
                    items: generateDropDown(0),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 0);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Is there any deviation on this loan application')),
                  ),
                ),
              ),
              new Card(
                child:new Column(children: <Widget>[
                  Text(
                    Translations.of(context)
                        .text('Type of deviation requested'),
                    style: TextStyle(
                        color: Colors.blue, fontSize: 18.0),
                  ),
                  //new Text(Translations.of(context).text('Type of deviation requested')),
                  new Card(
                    child :new CheckboxListTile(
                        value: checkBox2  ,
                        title: new Text(Translations.of(context).text('Waiver for NRC')),
                        onChanged: (val) {
                          setState(() {
                            checkBox2 = val;

                          });
                        }),
                  ),
                  new Card(
                    child :new CheckboxListTile(
                        value: checkBox3  ,
                        title: new Text(Translations.of(context).text('Waiver for Monthly Net Income')),
                        onChanged: (val) {
                          setState(() {
                            checkBox3 = val;

                          });
                        }),
                  ),
                  new Card(
                    child :new CheckboxListTile(
                        value: checkBox4  ,
                        title: new Text(Translations.of(context).text('Waiver for DBR')),
                        onChanged: (val) {
                          setState(() {
                            checkBox4 = val;

                          });
                        }),
                  ),
                  new Card(
                    child :new CheckboxListTile(
                        value: checkBox5  ,
                        title: new Text(Translations.of(context).text('Waiver for Customer having more 3 loans with other MFIs')),
                        onChanged: (val) {
                          setState(() {
                            checkBox5 = val;

                          });
                        }),
                  ),
                  new Card(
                    child: new CheckboxListTile(
                        value: checkBox6  ,
                        title: new Text(Translations.of(context).text('Waiver for Business License')),
                        onChanged: (val) {
                          setState(() {
                            checkBox6 = val;

                          });
                        }),
                  ),
                ]),
              ),
              Card(
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('Why customer should be provided loan by deviation approval'),
                        labelText: Translations.of(context).text('Why customer should be provided loan by deviation approval'),
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
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(200),
                      ],
                      initialValue: dfObj.mdevapproval == null ||dfObj.mdevapproval == "null"
                          ? ""
                          : "${dfObj.mdevapproval}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          dfObj.mdevapproval = value;
                        }
                      }
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  proceed() async {
    if (!validateSubmit()) {
      return;
    }

    if (checkBox2 == true)
      dfObj.mdrnrc = 1;
    else
      dfObj.mdrnrc = 0;
    if (checkBox3 == true)
      dfObj.mdrmni = 1;
    else
      dfObj.mdrmni = 0;
    if (checkBox4 == true)
      dfObj.mdrdbr = 1;
    else
      dfObj.mdrdbr = 0;
    if (checkBox5 == true)
      dfObj.mdrmfi = 1;
    else
      dfObj.mdrmfi = 0;
    if (checkBox6 == true)
      dfObj.mdrbl = 1;
    else
      dfObj.mdrbl = 0;
    
    dfObj.mcreatedby = username;
    dfObj.mlastupdateby = null;

    if ((dfObj.mcreateddt == 'null') || (dfObj.mcreateddt == null))
      dfObj.mcreateddt = DateTime.now();

    dfObj.mlastupdatedt = DateTime.now();
    dfObj.mgeolatd=geoLatitude;
    dfObj.mgeologd=geoLongitude;
    dfObj.missynctocoresys=0;
    if( dfObj.mrefno==null){
      dfObj.mrefno=0;
    }
    await AppDatabase.get()
        .updateDeviationFormMaster(dfObj)
        .then((val) {
      print("val here is " + val.toString());

    });
    _successfulSubmit();
  }

  bool validateSubmit(){

<<<<<<< .mine
    if(dfObj.mdevloanapp==""||dfObj.mdevloanapp==null){
      _showAlertWithError(Translations.of(context).text('Is there any deviation on this loan application'), Translations.of(context).text("itIsMand"));
      return false;
    }
=======

    if(dfObj.mdevloanapp==""||dfObj.mdevloanapp==null){

      _showAlertWithError(Translations.of(context).text('Is there any deviation on this loan application'), Translations.of(context).text("itIsMand"));
      return false;
    }

>>>>>>> .r1143
    if(dfObj.mdevloanapp == 'Y')
    {
      if(checkBox2 == false && checkBox3 == false && checkBox4 == false && checkBox5 == false && checkBox6 == false){
        _showAlertWithError(Translations.of(context).text('Type of deviation requested'), Translations.of(context).text("itIsMand"));
        return false;
      }
      if(dfObj.mdevapproval==""||dfObj.mdevapproval==null){

        _showAlertWithError(Translations.of(context).text('Why customer should be provided loan by deviation approval'), Translations.of(context).text("itIsMand"));
        return false;
      }
    }
    return true;
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
                  Text('Done'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  setState(() {

                  });
                },
              ),
            ],
          );
        });
  }

  Future<void> _showAlertWithError(arg, error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$arg'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$error'),
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
      },
    );
  }

}
