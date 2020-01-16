import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/TradeAndNeighbourRefCheckBean.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;


class TradeAndNeighbourRefCheck extends StatefulWidget {
  final tradeAndNeighPassedObject;
  final loanPassedObject;

  TradeAndNeighbourRefCheck(this.tradeAndNeighPassedObject,this.loanPassedObject);


  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );
  @override
  _TradeAndNeighbourRefCheckState createState() => new _TradeAndNeighbourRefCheckState();
}

class _TradeAndNeighbourRefCheckState extends State<TradeAndNeighbourRefCheck> {
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
  TradeAndNeighbourRefCheckBean tanrcObj;
  bool isDataSynced = false;
  bool circIndicatorIsDatSynced = false;
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  LookupBeanData supcredit;
  LookupBeanData suponcredit;
  LookupBeanData clientdelay;
  LookupBeanData defpayment;
  LookupBeanData salcycles;
  LookupBeanData loanlender;
  LookupBeanData facility;
  LookupBeanData turnover;
  LookupBeanData buyingperiod;
  LookupBeanData creditbuying;
  LookupBeanData quality;
  LookupBeanData reliableper;
  LookupBeanData knownclient;
  LookupBeanData improvement;
  LookupBeanData relperson;

  Future<Null> getSessionVariables() async {
    if (widget.tradeAndNeighPassedObject != null) {
      tanrcObj = widget.tradeAndNeighPassedObject;
    } else {
      AppDatabase.get().generateTradeAndNeighbourRef().then((onValue) {
        setState(() {
          tanrcObj.trefno = onValue;
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
    if (widget.tradeAndNeighPassedObject != null) {
      tanrcObj = widget.tradeAndNeighPassedObject;
    } else {
      tanrcObj = new TradeAndNeighbourRefCheckBean();
      tanrcObj.mloantrefno = widget.loanPassedObject.trefno;
      tanrcObj.mloanmrefno = widget.loanPassedObject.mrefno;
      tanrcObj.mcusttrefno = widget.loanPassedObject.mcusttrefno;
      tanrcObj.mcustmrefno = widget.loanPassedObject.mcustmrefno;
      tanrcObj.mleadsid = widget.loanPassedObject.mleadsid;
    }
    getSessionVariables();
    List tempDropDownValues =  new List();
    tempDropDownValues.add(tanrcObj.msupcredit);
    tempDropDownValues.add(tanrcObj.msuponcredit);
    tempDropDownValues.add(tanrcObj.mclientdelay);
    tempDropDownValues.add(tanrcObj.mdefpayment);
    tempDropDownValues.add(tanrcObj.msalcycles);
    tempDropDownValues.add(tanrcObj.mloanlender);
    tempDropDownValues.add(tanrcObj.mfacility);
    tempDropDownValues.add(tanrcObj.mturnover);
    tempDropDownValues.add(tanrcObj.mbuyingperiod);
    tempDropDownValues.add(tanrcObj.mcreditbuying);
    tempDropDownValues.add(tanrcObj.mquality);
    tempDropDownValues.add(tanrcObj.mreliableper);
    tempDropDownValues.add(tanrcObj.mknownclient);
    tempDropDownValues.add(tanrcObj.mimprovement);
    tempDropDownValues.add(tanrcObj.mrelperson);

    for (int k = 0;
    k < globals.dropdownCaptionsValuesTradeNeighbour.length;
    k++) {
      for (int i = 0;
      i < globals.dropdownCaptionsValuesTradeNeighbour[k].length;
      i++) {
        print("k and i is $k $i");
        print(globals.dropdownCaptionsValuesTradeNeighbour[k][i].mcode.length);
        try{
          if (globals.dropdownCaptionsValuesTradeNeighbour[k][i].mcode.toString() ==
              tempDropDownValues[k].toString().trim()) {

            print("matched $k");
            setValue(k, globals.dropdownCaptionsValuesTradeNeighbour[k][i]);
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
          supcredit = blankBean;
          tanrcObj.msupcredit = blankBean.mcode;;
          break;
        case 1:
          suponcredit = blankBean;
          tanrcObj.msuponcredit = blankBean.mcode;;
          break;
        case 2:
          clientdelay = blankBean;
          tanrcObj.mclientdelay = 0;
          break;
        case 3:
          defpayment = blankBean;
          tanrcObj.mdefpayment = blankBean.mcode;
          break;
        case 4:
          salcycles = blankBean;
          tanrcObj.msalcycles = 0;
          break;
        case 5:
          loanlender = blankBean;
          tanrcObj.mloanlender = blankBean.mcode;
          break;
        case 6:
          facility = blankBean;
          tanrcObj.mfacility = blankBean.mcode;
          break;
        case 7:
          turnover = blankBean;
          tanrcObj.mturnover = 0;
          break;
        case 8:
          buyingperiod = blankBean;
          tanrcObj.mbuyingperiod = 0;
          break;
        case 9:
          creditbuying = blankBean;
          tanrcObj.mcreditbuying = blankBean.mcode;
          break;
        case 10:
          quality = blankBean;
          tanrcObj.mquality = 0;
          break;
        case 11:
          reliableper = blankBean;
          tanrcObj.mreliableper = blankBean.mcode;
          break;
        case 12:
          knownclient = blankBean;
          tanrcObj.mknownclient = 0;
          break;
        case 13:
          improvement = blankBean;
          tanrcObj.mimprovement = 0;
          break;
        case 14:
          relperson = blankBean;
          tanrcObj.mrelperson = blankBean.mcode;
          break;
        default:
          break;
      }
      setState(() {
      });
    }
    else{
      for (int k = 0;
      k < globals.dropdownCaptionsValuesTradeNeighbour[no].length;
      k++) {
        if (globals.dropdownCaptionsValuesTradeNeighbour[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesTradeNeighbour[no][k]);
        }
      }
    }
  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          supcredit = value;
          tanrcObj.msupcredit = value.mcode;//int.parse(value.mcode);
          break;
        case 1:
          suponcredit = value;
          tanrcObj.msuponcredit = value.mcode;
          break;
        case 2:
          clientdelay = value;
          tanrcObj.mclientdelay = int.parse(value.mcode);
          break;
        case 3:
          defpayment = value;
          tanrcObj.mdefpayment = value.mcode;
          break;
        case 4:
          salcycles = value;
          tanrcObj.msalcycles = int.parse(value.mcode);
          break;
        case 5:
          loanlender = value;
          tanrcObj.mloanlender = value.mcode;
          break;
        case 6:
          facility = value;
          tanrcObj.mfacility = value.mcode;
          break;
        case 7:
          turnover = value;
          tanrcObj.mturnover = int.parse(value.mcode);
          break;
        case 8:
          buyingperiod = value;
          tanrcObj.mbuyingperiod = int.parse(value.mcode);
          break;
        case 9:
          creditbuying = value;
          tanrcObj.mcreditbuying = value.mcode;
          break;
        case 10:
          quality = value;
          tanrcObj.mquality = int.parse(value.mcode);
          break;
        case 11:
          reliableper = value;
          tanrcObj.mreliableper = value.mcode;
          break;
        case 12:
          knownclient = value;
          tanrcObj.mknownclient = int.parse(value.mcode);
          break;
        case 13:
          improvement = value;
          tanrcObj.mimprovement = int.parse(value.mcode);
          break;
        case 14:
          relperson = value;
          tanrcObj.mrelperson = value.mcode;
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
    k < globals.dropdownCaptionsValuesTradeNeighbour[no].length;
    k++) {
      mapData.add(globals.dropdownCaptionsValuesTradeNeighbour[no][k]);
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
        title: new Text(Translations.of(context).text('TRADE AND NEIGHBOUR REFERENCE CHECK')),
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
                        "${tanrcObj.mleadsid == null ? "0" : tanrcObj.mleadsid}"
                            "/${tanrcObj.mloantrefno == null ? "0" : tanrcObj.mloantrefno} - ${tanrcObj.mloanmrefno == null ? "0" : tanrcObj.mloanmrefno}"),
=======
                            "${tanrcObj.mloantrefno == null? "0" : tanrcObj.mloantrefno}"
                            "/${tanrcObj.mloanmrefno == null? "0" : tanrcObj.mloanmrefno}"
                            "/${tanrcObj.mleadsid == null||tanrcObj.mleadsid.trim()=="null" ? "0" : tanrcObj.mleadsid}"),
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
              Text(
                Translations.of(context)
                    .text('TRADE REFERENCE CHECK'),
                style: TextStyle(
                    color: Colors.blue, fontSize: 20.0),
              ),
              Card(
                  color: Constant.mandatoryColor,
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('Name of the Supplier'),
                        labelText: Translations.of(context).text('Name of the Supplier'),
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
                        new LengthLimitingTextInputFormatter(50),
                      ],
                      initialValue: tanrcObj.msupname == null
                          ? ""
                          : "${tanrcObj.msupname}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          tanrcObj.msupname = value;
                        }
                      }
                  )
              ),
              Card(
                  color: Constant.mandatoryColor,
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('Address of the supplier'),
                        labelText: Translations.of(context).text('Address of the supplier'),
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
                        new LengthLimitingTextInputFormatter(50),
                      ],
                      initialValue: tanrcObj.msupaddress == null
                          ? ""
                          : "${tanrcObj.msupaddress}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          tanrcObj.msupaddress = value;
                        }
                      }
                  )
              ),
              Card(
                  color: Constant.mandatoryColor,
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('Contact number of the supplier'),
                        labelText: Translations.of(context).text('Contact number of the supplier'),
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
                        new LengthLimitingTextInputFormatter(12),
                        globals.onlyIntNumber
                      ],
                      initialValue: tanrcObj.msupcontact == null
                          ? ""
                          : "${tanrcObj.msupcontact}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          tanrcObj.msupcontact = value;
                        }
                      }
                  )
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: supcredit,
                    items: generateDropDown(0),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 0);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Do you supply on credit?')),
                  ),
                ),
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: suponcredit,
                    items: generateDropDown(1),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 1);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('If No - will you be willing to supply on credit')),
                  ),
                ),
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: clientdelay,
                    items: generateDropDown(2),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 2);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('How many times has the client delayed on payment?')),
                  ),
                ),
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: defpayment,
                    items: generateDropDown(3),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 3);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Has the client ever defaulted on the payment')),
                  ),
                ),
              ),
              Card(
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('What are the products that you supply?'),
                        labelText: Translations.of(context).text('What are the products that you supply?'),
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
                        new LengthLimitingTextInputFormatter(50),
                      ],
                      initialValue: tanrcObj.mproductsup == null || tanrcObj.mproductsup == "null"
                          ? ""
                          : "${tanrcObj.mproductsup}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          tanrcObj.mproductsup = value;
                        }
                      }
                  )
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: salcycles,
                    items: generateDropDown(4),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 4);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('What is the cycle of sales?')),
                  ),
                ),
              ),
              Card(
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('What is the value of sales that you make per cycle'),
                        labelText: Translations.of(context).text('What is the value of sales that you make per cycle'),
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
                        new LengthLimitingTextInputFormatter(50),
                      ],
                      initialValue: tanrcObj.mvalsalcycles == null || tanrcObj.mvalsalcycles == "null"
                          ? ""
                          : "${tanrcObj.mvalsalcycles}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          tanrcObj.mvalsalcycles = value;
                        }
                      }
                  )
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: loanlender,
                    items: generateDropDown(5),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 5);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Has he taken any loan from any other lender?')),
                  ),
                ),
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: facility,
                    items: generateDropDown(6),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 6);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Have you Increase the facility given to the client over the time')),
                  ),
                ),
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: turnover,
                    items: generateDropDown(7),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 7);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('What do you think the turnover of the client is?')),
                  ),
                ),
              ),
              Card(
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('Remarks of the Suppliers'),
                        labelText: Translations.of(context).text('Remarks of the Suppliers'),
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
                        new LengthLimitingTextInputFormatter(100),
                      ],
                      initialValue: tanrcObj.mremarks == null || tanrcObj.mremarks == "null"
                          ? ""
                          : "${tanrcObj.mremarks}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          tanrcObj.mremarks = value;
                        }
                      }
                  )
              ),
              Card(
                  color: Constant.mandatoryColor,
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('Name of the customer buyer'),
                        labelText: Translations.of(context).text('Name of the customer buyer'),
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
                        new LengthLimitingTextInputFormatter(100),
                      ],
                      initialValue: tanrcObj.mbuyersname == null
                          ? ""
                          : "${tanrcObj.mbuyersname}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          tanrcObj.mbuyersname = value;
                        }
                      }
                  )
              ),
              Card(
                  color: Constant.mandatoryColor,
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('Address of the customer buyer'),
                        labelText: Translations.of(context).text('Address of the customer buyer'),
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
                        new LengthLimitingTextInputFormatter(100),
                      ],
                      initialValue: tanrcObj.mbuyersaddress == null
                          ? ""
                          : "${tanrcObj.mbuyersaddress}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          tanrcObj.mbuyersaddress = value;
                        }
                      }
                  )
              ),
              Card(
                  color: Constant.mandatoryColor,
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('Contact number of the customer buyer'),
                        labelText: Translations.of(context).text('Contact number of the customer buyer'),
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
                        new LengthLimitingTextInputFormatter(100),
                      ],
                      initialValue: tanrcObj.mcontactno == null
                          ? ""
                          : "${tanrcObj.mcontactno}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          tanrcObj.mcontactno = value;
                        }
                      }
                  )
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: buyingperiod,
                    items: generateDropDown(8),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 8);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('How long have you been buying from the client?')),
                  ),
                ),
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: creditbuying,
                    items: generateDropDown(9),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 9);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Do you buy on credit from him?')),
                  ),
                ),
              ),
              Card(
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('If Yes, how many days?'),
                        labelText: Translations.of(context).text('If Yes, how many days?'),
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
                        new LengthLimitingTextInputFormatter(15),
                      ],
                      initialValue: tanrcObj.mdays == null || tanrcObj.mdays == "null"
                          ? ""
                          : "${tanrcObj.mdays}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          tanrcObj.mdays = value;
                        }
                      }
                  )
              ),
              Card(
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('What are the products that you buy?'),
                        labelText: Translations.of(context).text('What are the products that you buy?'),
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
                        new LengthLimitingTextInputFormatter(100),
                      ],
                      initialValue: tanrcObj.mproducts == null || tanrcObj.mproducts == "null"
                          ? ""
                          : "${tanrcObj.mproducts}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          tanrcObj.mproducts = value;
                        }
                      }
                  )
              ),
              Card(
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('What is the value of your monthly purchases?'),
                        labelText: Translations.of(context).text('What is the value of your monthly purchases?'),
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
                        new LengthLimitingTextInputFormatter(100),
                      ],
                      initialValue: tanrcObj.mmonthlypur == null || tanrcObj.mmonthlypur == "null"
                          ? ""
                          : "${tanrcObj.mmonthlypur}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          tanrcObj.mmonthlypur = value;
                        }
                      }
                  )
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: quality,
                    items: generateDropDown(10),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 10);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('How is the quality of goods purchased?')),
                  ),
                ),
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: reliableper,
                    items: generateDropDown(11),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 11);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Is he reliable person?')),
                  ),
                ),
              ),
              Card(
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('Remarks of the customer'),
                        labelText: Translations.of(context).text('Remarks of the customer'),
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
                        new LengthLimitingTextInputFormatter(50),
                      ],
                      initialValue: tanrcObj.mcusremarks == null || tanrcObj.mcusremarks == "null"
                          ? ""
                          : "${tanrcObj.mcusremarks}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          tanrcObj.mcusremarks = value;
                        }
                      }
                  )
              ),
              Text(
                Translations.of(context)
                    .text('NEIGHBOUR REFERENCE CHECKS'),
                style: TextStyle(
                    color: Colors.blue, fontSize: 20.0),
              ),
              Card(
                  color: Constant.mandatoryColor,
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('Name of the Neighbor'),
                        labelText: Translations.of(context).text('Name of the Neighbor'),
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
                        new LengthLimitingTextInputFormatter(50),
                      ],
                      initialValue: tanrcObj.mneigname == null
                          ? ""
                          : "${tanrcObj.mneigname}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          tanrcObj.mneigname = value;
                        }
                      }
                  )
              ),
              Card(
                  color: Constant.mandatoryColor,
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('Address of Neighbor'),
                        labelText: Translations.of(context).text('Address of Neighbor'),
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
                        new LengthLimitingTextInputFormatter(50),
                      ],
                      initialValue: tanrcObj.mneigadd == null
                          ? ""
                          : "${tanrcObj.mneigadd}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          tanrcObj.mneigadd = value;
                        }
                      }
                  )
              ),
              new Card(
                color: Constant.mandatoryColor,
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: knownclient,
                    items: generateDropDown(12),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 12);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('How long have you known the client?')),
                  ),
                ),
              ),
              new Card(
                color: Constant.mandatoryColor,
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: improvement,
                    items: generateDropDown(13),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 13);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Is there any improvement with the customer business over the years?')),
                  ),
                ),
              ),
              new Card(
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: relperson,
                    items: generateDropDown(14),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 14);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Is he reliable person?')),
                  ),
                ),
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
    tanrcObj.mcreatedby = username;
    tanrcObj.mlastupdateby = null;

    if ((tanrcObj.mcreateddt == 'null') || (tanrcObj.mcreateddt == null))
      tanrcObj.mcreateddt = DateTime.now();

    tanrcObj.mlastupdatedt = DateTime.now();
    tanrcObj.mgeolatd=geoLatitude;
    tanrcObj.mgeologd=geoLongitude;
    tanrcObj.missynctocoresys=0;
    if( tanrcObj.mrefno==null){
      tanrcObj.mrefno=0;
    }
    await AppDatabase.get()
        .updateTradeNeighbourRefCheckMaster(tanrcObj)
        .then((val) {
      print("val here is " + val.toString());

    });
    _successfulSubmit();
  }

  bool validateSubmit(){


    if(tanrcObj.msupname == ""||tanrcObj.msupname==null){
      _showAlertWithError(Translations.of(context).text('Name of the Supplier'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(tanrcObj.msupaddress == ""||tanrcObj.msupaddress==null){
      _showAlertWithError(Translations.of(context).text('Address of the supplier'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(tanrcObj.msupcontact == 0||tanrcObj.msupcontact==null){
      _showAlertWithError(Translations.of(context).text('Contact number of the supplier'), Translations.of(context).text("itIsMand"));
      return false;
    }
    print(tanrcObj.msupcredit);
    if(tanrcObj.msupcredit == 'N')
      {
        if(tanrcObj.msuponcredit==""||tanrcObj.msuponcredit==null){

          _showAlertWithError(Translations.of(context).text('If No - will you be willing to supply on credit'), Translations.of(context).text("itIsMand"));
          return false;
        }
      }
    if(tanrcObj.msupcredit == 'Y')
    {
      if(tanrcObj.mclientdelay==0||tanrcObj.mclientdelay==null){

        _showAlertWithError(Translations.of(context).text('How many times has the client delayed on payment?'), Translations.of(context).text("itIsMand"));
        return false;
      }
      if(tanrcObj.mdefpayment==""||tanrcObj.mdefpayment==null){

        _showAlertWithError(Translations.of(context).text('Has the client ever defaulted on the payment'), Translations.of(context).text("itIsMand"));
        return false;
      }
    }
    if(tanrcObj.mbuyersname==""||tanrcObj.mbuyersname==null){

      _showAlertWithError(Translations.of(context).text('Name of the customer buyer'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(tanrcObj.mbuyersaddress==""||tanrcObj.mbuyersaddress==null){

      _showAlertWithError(Translations.of(context).text('Address of the customer buyer'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(tanrcObj.mcontactno==""||tanrcObj.mcontactno==null){

      _showAlertWithError(Translations.of(context).text('Contact number of the customer buyer'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(tanrcObj.mcreditbuying == 'Y')
    {
      if(tanrcObj.mdays==""||tanrcObj.mdays==null){

        _showAlertWithError(Translations.of(context).text('If Yes, how many days?'), Translations.of(context).text("itIsMand"));
        return false;
      }
    }
    if(tanrcObj.mneigname == ""||tanrcObj.mneigname==null){
      _showAlertWithError(Translations.of(context).text('Name of the Neighbor'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(tanrcObj.mneigadd == ""||tanrcObj.mneigadd==null){
      _showAlertWithError(Translations.of(context).text('Address of Neighbor'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(tanrcObj.mknownclient == 0||tanrcObj.mknownclient==null){
      _showAlertWithError(Translations.of(context).text('How long have you known the client?'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(tanrcObj.mimprovement == 0||tanrcObj.mimprovement==null){
      _showAlertWithError(Translations.of(context).text('Is there any improvement with the customer business over the years?'), Translations.of(context).text("itIsMand"));
      return false;
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
