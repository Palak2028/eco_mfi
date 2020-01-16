//import 'package:eco_mfi/pages/workflow/LoanApplication/bean/LoanCPVBusinessRecordBean.dart';
import 'package:eco_mfi/pages/workflow/Kyc/beans/KycMasterBean.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
//import 'package:eco_mfi/Kyc/beans/KycMasterBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:toast/toast.dart';

class KycMaster extends StatefulWidget {

   final kycMasterPassedObject;
   final loanPassedObject;
   KycMaster(this.kycMasterPassedObject,this.loanPassedObject);
  @override
  _KycMasterState createState() => _KycMasterState();
}

class _KycMasterState extends State<KycMaster> {

  int trefno;
  int mrefno;
  int mleadsid;
  int mloantrefno;
  int mloanmrefno;
  int mbackground;
  int mjob;
  int mlifestyle;
  int mloanrepay;
  int mnetworth;
  int mcomments;
  int mverifiedinfo;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  int missynctocoresys;
  DateTime mlastsynsdate;

  bool declCheckBox = false;
  bool fieldEnabled = true;

  int isDeclare = 0;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  KycMasterBean kycMasterBean = new KycMasterBean();
  //final textFieldController = TextEditingController();

  SharedPreferences prefs;

  //LookupBeanData kyc;
  LookupBeanData kycmBackground;
  LookupBeanData kycmJob;
  LookupBeanData kycmLifestyle;
  LookupBeanData kycmLoanrepay;
  LookupBeanData kycmNetworth;
  LookupBeanData kycmCommments;
  LookupBeanData kycmVerifiedinfo;
  //LookupBeanData kycmLeadsid;

  String branch = "";
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;

  SystemParameterBean sysBean = new SystemParameterBean();


  LookupBeanData blankBean = new LookupBeanData(
      mcodedesc: "", mcode: "", mcodetype: 0);

  proceed() async {
    if (!validateSubmit()) {
      return;
    }
    kycMasterBean.mcreatedby = username;
    //kycMasterBean.mcrs = username;
    print("kycMasterBean.mcreatedby" + kycMasterBean.mcreatedby.toString());
    print("username" + username.toString());
    kycMasterBean.mlastupdateby = username;

    if ((kycMasterBean.mcreateddt == 'null') ||  (kycMasterBean.mcreateddt == null))
      kycMasterBean.mcreateddt = DateTime.now();


    kycMasterBean.mlastupdatedt = DateTime.now();
        kycMasterBean.mgeolatd = geoLatitude;
        kycMasterBean.mgeologd = geoLongitude;
        kycMasterBean.missynctocoresys = 0;


      if ((kycMasterBean.mleadsid == 'null') || (kycMasterBean.mleadsid == null))
        kycMasterBean.mleadsid = '0';

      if((kycMasterBean.mrefno == 'null') || (kycMasterBean.mrefno == null)){
        kycMasterBean.mrefno=0;
      }

      if((kycMasterBean.mloantrefno == 'null') || (kycMasterBean.mloantrefno == null)){
        kycMasterBean.mloantrefno = 0;
      }

      if((kycMasterBean.mloanmrefno == 'null') || (kycMasterBean.mloanmrefno == null)){
        kycMasterBean.mloanmrefno = 0;
      }

    if((kycMasterBean.mcusttrefno == 'null') || (kycMasterBean.mcusttrefno == null)){
      kycMasterBean.mcusttrefno = 0;
    }

    if((kycMasterBean.mcustmrefno == 'null') || (kycMasterBean.mcustmrefno == null)){
      kycMasterBean.mcustmrefno = 0;
    }
      await AppDatabase.get()
          .updateKycMaster(kycMasterBean)
          .then((val) {
        print("val here is " + val.toString());
      });
      _successfulSubmit();
  }


  bool validateSubmit() {

//    if(kycMasterBean.mleadsid == null){
//      kycMasterBean.mleadsid = '0';
//    }

    if (kycMasterBean.mbackground == null) {
      _showAlert("Background", "Field Is Mandatory");
      return false;
    }

    if (kycMasterBean.mjob == null) {
      _showAlert("Job", "Field Is Mandatory");
      return false;
    }
    if (kycMasterBean.mlifestyle == null) {
      _showAlert("LifeStyle", "Field Is Mandatory");
      return false;
    }
    if (kycMasterBean.mloanrepay == null) {
      _showAlert("LoanRepay", "Field Is Mandatory");
      return false;
    }
    if (kycMasterBean.mnetworth == null) {
      _showAlert("NetWorth", "Field Is Mandatory");
      return false;
    }

    if (kycMasterBean.mcomments == null) {
      _showAlert("Comments", "Field Is Mandatory");
      return false;
    }


    return true;
  }

  Future<void> _showAlert(arg, error) async {
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
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
               // Navigator.of(context).pop();
                setState(() {

                });
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
                  Text('Done'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                onPressed: () {
                  setState(() {
                  // _formKey.currentState.save();
                  });
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

//genrating DropDown List
  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    //print("caption value : " + globals.dropdownCaptionsPersonalInfo[no]);

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();

    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);

    for (int k = 0; k < globals.dropdownKycMaster[no].length; k++) {
      mapData.add(globals.dropdownKycMaster[no][k]);
    }

    _dropDownMenuItems1 = mapData.map((value) {
      print("Here is dropdownwale value " + value.mcodedesc);
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

  showDropDown(LookupBeanData selectedObj, int no) {
    if (selectedObj.mcodedesc.isEmpty) {
      print("inside code Desc is null");
      switch (no) {
        case 0:
          kycmBackground = blankBean;
          kycMasterBean.mbackground = int.parse(blankBean.mcode);

          break;
        case 1:
          kycmJob = blankBean;
          kycMasterBean.mjob = int.parse(blankBean.mcode);

          break;
        case 2:
          kycmLifestyle = blankBean;
          kycMasterBean.mlifestyle = int.parse(blankBean.mcode);

          break;
        case 3:
          kycmLoanrepay = blankBean;
          kycMasterBean.mloanrepay = int.parse(blankBean.mcode);

          break;
        case 4:
          kycmNetworth = blankBean;
          kycMasterBean.mnetworth = int.parse(blankBean.mcode);

          break;
        case 5:
          kycmCommments = blankBean;
          kycMasterBean.mcomments = blankBean.mcode;
          break;
        case 6:
          kycmVerifiedinfo = blankBean;
          kycMasterBean.mverifiedinfo = int.parse(blankBean.mcode);

          break;
        default:
          break;
      }
      setState(() {

      });
    }
    else {
      bool isBreak = false;
      for (int k = 0;
      k < globals.dropdownKycMaster[no].length;
      k++) {
        if (globals.dropdownKycMaster[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownKycMaster[no][k]);
          isBreak = true;
          break;
        }
        if (isBreak) {
          break;
        }
      }
    }
  }

  setValue(int no, LookupBeanData value) async {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          kycmBackground = value;
          kycMasterBean.mbackground = int.parse(value.mcode);

          break;
        case 1:
          kycmJob = value;
          kycMasterBean.mjob = int.parse(value.mcode);
          break;

        case 2:
          kycmLifestyle = value;
          kycMasterBean.mlifestyle = int.parse(value.mcode);

          break;
        case 3:
          kycmLoanrepay = value;
          kycMasterBean.mloanrepay = int.parse(value.mcode);

          break;
        case 4:
          kycmNetworth = value;
          kycMasterBean.mnetworth = int.parse(value.mcode);

          break;
        case 5:
          kycmCommments = value;
          kycMasterBean.mcomments = value.mcode;

          break;


        default:
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    if(widget.kycMasterPassedObject!=null ){
      kycMasterBean=widget.kycMasterPassedObject;
      print("Passed KYC Object ${kycMasterBean}");


      List<String> tempDropDownValues = new List<String>();
      tempDropDownValues.add(kycMasterBean.mbackground.toString());
      tempDropDownValues.add(kycMasterBean.mjob.toString());
      tempDropDownValues.add(kycMasterBean.mlifestyle.toString());
      tempDropDownValues.add(kycMasterBean.mloanrepay.toString());
      tempDropDownValues.add(kycMasterBean.mnetworth.toString());

      print(tempDropDownValues);

      for (int k = 0; k < globals.dropdownKycMaster.length; k++) {
        for (int i = 0; i < globals.dropdownKycMaster[k].length; i++) {
          try{
            if (globals.dropdownKycMaster[k][i].mcode.toString().trim() ==
                tempDropDownValues[k].toString().trim()) {
              print("Trying to match  values ${globals.dropdownKycMaster[k][i].mcode}");
              print("Trying to match to ${tempDropDownValues[k]}");
              setValue(k, globals.dropdownKycMaster[k][i]);
            }
          }catch(_){
            print("Exception Occured");
          }
        }
      }
    }
    else{
      //kycMasterBean = new CustomerLoanCashFlowAnalysisBean();
      kycMasterBean.mloantrefno = widget.loanPassedObject.trefno;
      kycMasterBean.mloanmrefno = widget.loanPassedObject.mrefno;
      kycMasterBean.mcusttrefno = widget.loanPassedObject.mcusttrefno;
      kycMasterBean.mcustmrefno = widget.loanPassedObject.mcustmrefno;
      kycMasterBean.mleadsid = widget.loanPassedObject.mleadsid;
    }
    getSessionVariables();
  }

  //genrating tref no

  Future<Null> getSessionVariables() async {
    if (widget.kycMasterPassedObject != null) {
      kycMasterBean = widget.kycMasterPassedObject;
    } else {
      AppDatabase.get().generateTrefnoForKycMaster().then(( int onValue) {
        print("Returned value is $onValue");
        setState(() {
          kycMasterBean.trefno = onValue;

        });
      });
    }
//    setState(() {
//
//    });

    prefs = await SharedPreferences.getInstance();
    try{
      setState(() {
        branch = prefs.get(TablesColumnFile.branch).toString();
        username = prefs.getString(TablesColumnFile.musrcode);
        print("username"+username.toString());
        usrGrpCode = prefs.getInt(TablesColumnFile.mgrpcd);
        geoLocation = prefs.getString(TablesColumnFile.mgeolocation);
        geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
        geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
        reportingUser = prefs.getString(TablesColumnFile.mreportinguser);

        print("kyc geoLatitude:"+geoLatitude + " geoLongitude:"+geoLongitude);
      });
    }catch(_){}
  }




  Future<bool> callDialog() {
    globals.Dialog.onPop(
        context,
        'Are you sure?',
        'Do you want to Go back without saving data',
        "gggggg");
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () {
      callDialog();
    },
    child: new Scaffold(
        key: _scaffoldKey,
//        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          //title: Text(Translations.of(context).text("KYC")),
          elevation: 1.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              //callDialog();
              Navigator.pop(context);
            },
          ),
          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          title: Text(
            Translations.of(context).text("Kyc"),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontStyle: FontStyle.normal),
          ),
          actions: <Widget>[
             (declCheckBox == true) ?
            new IconButton(
              icon: new Icon(
                Icons.save,
                color: Colors.white,
                size: 40.0,
              ),
              onPressed: () {
                print('save button pressed');
                 proceed();
              },
            ):new IconButton(
                disabledColor: Colors.black,
                icon: new Icon(
                  Icons.save,
                  color: Colors.red,
                  size: 40.0,
                ),
                onPressed: () {
                  Toast.show("Please do the ACCEPT the declaration for ENABLE the SAVE BUTTON!", context);
                }
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
            ),
          ],
        ),

        body:
        new Form(
            key: _formKey,
            autovalidate: false,
            onWillPop: () {
              return Future(() => true);
            },
            onChanged: () async {
              final FormState form = _formKey.currentState;
              form.save();
            },

            child:ListView(
             // padding: EdgeInsets.all(0.0),
              children: <Widget>[
                SizedBox(height: 16.0),
                Card(
                  //elevation: 1.0,
                  child: Column(
                    children: <Widget>[
                      //Text('mleadsid : $mleadsid'),
                      Container(
                        child: new TextField(
                          controller: new TextEditingController(
                              text:

                              "${widget.loanPassedObject.trefno== null? "0" : widget.loanPassedObject.trefno}"
                                  "/${widget.loanPassedObject.mrefno == null? "0" : widget.loanPassedObject.mrefno}"
                                  "/${widget.loanPassedObject.mleadsid == null||widget.loanPassedObject.mleadsid.trim()=="null" ? "0" : widget.loanPassedObject.mleadsid}"),
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
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        child: new DropdownButtonFormField(
                          decoration: InputDecoration(labelText:Translations.of(context).text("background")),
                          value: kycmBackground == null ? null : kycmBackground,
                          items: generateDropDown(0),
                          onChanged: (LookupBeanData newValue) {
                            showDropDown(newValue, 0);
                          },
                          validator: (args) {
                            print(args);
                          },
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        child: new DropdownButtonFormField(
                          decoration: InputDecoration(labelText:Translations.of(context).text("job")),
                          value: kycmJob == null ? null : kycmJob,
                          items: generateDropDown(1),
                          onChanged: (LookupBeanData newValue) {
                            showDropDown(newValue, 1);
                          },
                          validator: (args) {
                            print(args);
                          },
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        child: new DropdownButtonFormField(
                          decoration: InputDecoration(labelText:Translations.of(context).text("lifestyle")),
                          value: kycmLifestyle == null ? null : kycmLifestyle,
                          items: generateDropDown(2),
                          onChanged: (LookupBeanData newValue) {
                            showDropDown(newValue, 2);
                          },
                          validator: (args) {
                            print(args);
                          },
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        child: new DropdownButtonFormField(
                          decoration: InputDecoration(labelText:Translations.of(context).text("loanrepay")),
                          value: kycmLoanrepay == null ? null : kycmLoanrepay,
                          items: generateDropDown(3),
                          onChanged: (LookupBeanData newValue) {
                            showDropDown(newValue, 3);
                          },
                          validator: (args) {
                            print(args);
                          },
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        child: new DropdownButtonFormField(

                          decoration: InputDecoration(labelText:Translations.of(context).text("networth")),
                          value: kycmNetworth == null ? null : kycmNetworth,
                          items: generateDropDown(4),
                          onChanged: (LookupBeanData newValue) {
                            showDropDown(newValue, 4);
                          },
                          validator: (args) {
                            print(args);
                          },
                        ),

                      ),
                      SizedBox(height: 16.0),
                      Container(
                        child:
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          decoration:  InputDecoration(
                            hintText: Translations.of(context).text('comments'),
                            labelText: Translations.of(context).text('comments'),
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
                            contentPadding: EdgeInsets.all(15.0),
                          ),

                            inputFormatters: [
                              new LengthLimitingTextInputFormatter(100),
                            ],
                          initialValue:
                          kycMasterBean.mcomments == null ? "" : "${kycMasterBean.mcomments}",
                         /* validator: (String value) {
                          if (value == ''){
                              return 'Commment field is blank';
                          } else
                          return null;
                          },*/


                          onSaved: (String value) {
                          if (value.isNotEmpty &&
                          value != "" &&
                          value != null &&
                          value != 'null') {
                            kycMasterBean.mcomments = value;
                           }
                          }
                        )
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        child: new CheckboxListTile(
                            value:declCheckBox,
                            title: new Text(
                                "I do hereby certify that I have verified the "
                                "information given above and do hereby "
                                "acknowledge and affirm that all the "
                                "information given above is true and accurate."),
                            onChanged: (value) {
                              setState(() {
                                declCheckBox= value;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

    ));
  }
}
