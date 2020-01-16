import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterFormationMasterListViewBean.dart';
import 'dart:async';
import 'package:eco_mfi/Utilities/globals.dart' as globals;

import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterFormationMasterSubmissionBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/CenterFormationSubmissionService.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/ViewCustomerFormationFamilyDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/FamilyDetailsBean.dart';

import '../../../translations.dart';

class CustomerFormationFamilyDetails extends StatefulWidget {
  CustomerFormationFamilyDetails({Key key}) : super(key: key);

  static Container _get(Widget child,
          [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );

  @override
  _CustomerFormationFamilyDetailsState createState() =>
      new _CustomerFormationFamilyDetailsState();
}

class _CustomerFormationFamilyDetailsState
    extends State<CustomerFormationFamilyDetails> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  LookupBeanData education;
  LookupBeanData relationShip;
  LookupBeanData occupation;

  int count = 0;
  final TextEditingController _controller = new TextEditingController();
  static bool isSubmitClicked = false;
  FamilyDetailsBean fdb = new FamilyDetailsBean();
  final List<FamilyDetailsBean> familyObjectListLoacl =
      new List<FamilyDetailsBean>();

  bool isBool = false;
  int i = 0;

  bool ifNullCheck(String value) {
    bool isNull = false;
    try {
      if (value == null || value == 'null' || value.trim()=='') {
        isNull = true;
      }
    }catch(_){
      isNull =true;
    }
    return isNull;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    if (!isBool) {
      isBool = true;
    }

    if(CustomerFormationMasterTabsState.fdb!=null){


      for (int k = 0; k < globals.dropdownCaptionsValuesFamilyDetails.length; k++) {
        for (int i = 0; i < globals.dropdownCaptionsValuesFamilyDetails[k].length; i++) {


          if (k == 0) {
            print("for k = 0 codes are ${globals.dropdownCaptionsValuesFamilyDetails[k][i].mcode}");
            if (globals.dropdownCaptionsValuesFamilyDetails[k][i].mcode ==
                CustomerFormationMasterTabsState.fdb.meducation) {

              setValue(k, globals.dropdownCaptionsValuesFamilyDetails[k][i]);


            }
          }

          if (k == 1) {
            print("for k = 1 codes are ${globals.dropdownCaptionsValuesFamilyDetails[k][i].mcode}");
            if (globals.dropdownCaptionsValuesFamilyDetails[k][i].mcode ==
                CustomerFormationMasterTabsState.fdb.mrelationwithcust) {

              setValue(k, globals.dropdownCaptionsValuesFamilyDetails[k][i]);


            }



          }

          if (k == 2) {
            print("for k = 2 codes are ${globals.dropdownCaptionsValuesFamilyDetails[k][i].mcode}");
            if (globals.dropdownCaptionsValuesFamilyDetails[k][i].mcode ==
                CustomerFormationMasterTabsState.fdb.moccuptype.toString()) {

              setValue(k, globals.dropdownCaptionsValuesFamilyDetails[k][i]);


            }
          }
        }


      }
    }else{
      CustomerFormationMasterTabsState.fdb= new FamilyDetailsBean();
    }


    for(int i = 0;i<CustomerFormationMasterTabsState.familyDependantRadio.length;i++){
      if(CustomerFormationMasterTabsState.familyDependantRadio[i]==null)CustomerFormationMasterTabsState.familyDependantRadio[i]= 0;
    }
    if (!ifNullCheck(CustomerFormationMasterTabsState.fdb.mmemberno)) {
      CustomerFormationMasterTabsState.familyDependantRadio[0] =
          int.parse(CustomerFormationMasterTabsState.fdb.mmemberno);
    }
    else{
      CustomerFormationMasterTabsState.fdb.mmemberno = "0";
    }
  }

  Widget dependantRadio() => CustomerFormationFamilyDetails._get(new Row(
        children: _makeRadios(2, globals.radioCaptionValuesIsDependant, 0),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));

  List<Widget> _makeRadios(int numberOfRadios, List textName, int position) {
    /*print(
        "dumper " + CustomerFormationMasterTabsState.fdb.mmemberno.toString());*/
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
            groupValue: CustomerFormationMasterTabsState.familyDependantRadio[position],
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
    setState(() => CustomerFormationMasterTabsState.familyDependantRadio[position] = selection);
    if (position == 0) {
      CustomerFormationMasterTabsState.fdb.mmemberno = selection.toString();
    }
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

  showDropDown(LookupBeanData selectedObj, int no) {

    print("selected Obj is ${selectedObj}");
    if(selectedObj.mcodedesc.isEmpty){
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          education = blankBean;
          CustomerFormationMasterTabsState.fdb.meducation = selectedObj.mcode;
          break;
        case 1:

          relationShip = blankBean;
          CustomerFormationMasterTabsState.fdb.mrelationwithcust = selectedObj.mcode;
          break;
        case 2:
          occupation = blankBean;
          CustomerFormationMasterTabsState.fdb.moccuptype = int.parse(selectedObj.mcode);
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
      k < globals.dropdownCaptionsValuesFamilyDetails[no].length;
      k++) {
        if (globals.dropdownCaptionsValuesFamilyDetails[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesFamilyDetails[no][k]);
          isBreak=true;
          break;
        }
        if(isBreak){
          break;
        }
      }
    }


  }
  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);


  setValue(int no, LookupBeanData value) {
    print("value is ${value}");
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          education = value;
          CustomerFormationMasterTabsState.fdb.meducation = value.mcode;
          /*CustomerFormationMasterTabsState.custListBean.familyDetailsList.last.education = value.code;*/

          break;
        case 1:

          relationShip = value;
          CustomerFormationMasterTabsState.fdb.mrelationwithcust = value.mcode;


          /*CustomerFormationMasterTabsState.custListBean.familyDetailsList.last.relationship = value.code;*/
          break;
        case 2:
          occupation = value;
          CustomerFormationMasterTabsState.fdb.moccuptype = int.parse(value.mcode);
          /*CustomerFormationMasterTabsState.custListBean.familyDetailsList.last.occupation = value.code;*/
          break;
        default:
          break;
      }
    });
  }

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    print("caption value : " + globals.dropdownCaptionsFamilyDetails[no]);

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    bean.mcode = "";
    bean.mcodetype = 0;
    mapData.add(blankBean);
    for (int k = 0;
    k < globals.dropdownCaptionsValuesFamilyDetails[no].length;
    k++) {
      mapData.add(globals.dropdownCaptionsValuesFamilyDetails[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      print("data here is of  dropdownwale biayajai " + value.mcodedesc);
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




  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
            key: _formKey,
            /* onWillPop: () {
              return Future(() => true);
            },*/
            onChanged: () {
              final FormState form = _formKey.currentState;
              form.save();
            },
            autovalidate: true,
            child: new ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                new TextFormField(
                  keyboardType: TextInputType.text
                  ,decoration: InputDecoration(
                    hintText: Translations.of(context).text('Enter_Family_member'),
                    labelText: Translations.of(context).text('Family_Member_Name'),
                    hintStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xff07426A),
                    )),
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                  controller: CustomerFormationMasterTabsState.fdb.mname != null
                      ? TextEditingController(text: CustomerFormationMasterTabsState.fdb.mname)
                      : TextEditingController(text: ""),
                  inputFormatters: [new LengthLimitingTextInputFormatter(50),globals.onlyCharacter],
                  onSaved: (val) {
                    //if(val!=null) {
                    //globals.familyMember = val;
                    /*CustomerFormationMasterTabsState.custListBean
                        .familyDetailsList.last.name = val;*/
                    CustomerFormationMasterTabsState.fdb.mname = val;
                    //}
                  },
                ),
                new TextFormField(
                  decoration: InputDecoration(
                    hintText: Translations.of(context).text('Enter_Age_Here'),
                    labelText: Translations.of(context).text('Age'),
                    hintStyle: TextStyle(color: Colors.grey),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.red,
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xff07426A),
                    )),
                    contentPadding: EdgeInsets.all(20.0),
                  ),

                  controller:  CustomerFormationMasterTabsState.fdb.mage != null&& CustomerFormationMasterTabsState.fdb.mage != 0
                      ? TextEditingController(text: CustomerFormationMasterTabsState.fdb.mage.toString())
                      : TextEditingController(text:""),
                  keyboardType: TextInputType.number,
                  inputFormatters: [new LengthLimitingTextInputFormatter(2),globals.onlyIntNumber],
                  onSaved: (val) {
                     if(val!=null&&val!="") {
                      // globals.age = int.parse(val);
                       /*CustomerFormationMasterTabsState.custListBean
                           .familyDetailsList.last.age =  int.parse(val);*/
                       try{
                         CustomerFormationMasterTabsState.fdb.mage = int.parse(val);
                       }catch(e){

                       }

                     }
                     else{
                      // globals.age = 0;
                       /*CustomerFormationMasterTabsState.custListBean
                           .familyDetailsList.last.age =0;*/
                       CustomerFormationMasterTabsState.fdb.mage = 0;
                     }

                    //}
                  },
                ),
                /*new TextFormField(
                  decoration: const InputDecoration(
                    *//* icon: const Icon(
                      Icons.my_location,
                      color: Colors.black,
                    ),*//*
                    hintText: 'Enter Education here',
                    labelText: 'Education',
                   // hintStyle: TextStyle(color: Colors.grey),
                     // labelStyle: TextStyle(color: Colors.black),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),

                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xff07426A),
                    )),
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                  *//*initialValue:
                      globals.education != null ? globals.education : "",*//*
                  controller: globals.education != null
                      ? TextEditingController(text: CustomerFormationMasterTabsState.fdb.education)
                      : TextEditingController(text: ""),
                  keyboardType: TextInputType.text,
                  inputFormatters: [new LengthLimitingTextInputFormatter(30),globals.onlyCharacter],
                  onSaved: (val) {
                    //  if(val!=null){
                    //globals.education = val;
                    fdb.education = val;
                    // }
                  },
                ),
                new TextFormField(

                  decoration: const InputDecoration(
                    *//*    icon: const Icon(
                      Icons.my_location,
                      color: Colors.black,
                    ),*//*
                    hintText: 'Enter RelationShip here',
                    labelText: 'RelationShip ',
                    hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.black),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xff07426A),
                    )),
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                  controller: globals.relationship != null
                      ? TextEditingController(text: fdb.relationship)
                      : TextEditingController(text: ""),
                  keyboardType: TextInputType.text,
                  inputFormatters: [new LengthLimitingTextInputFormatter(30),globals.onlyCharacter],
                  onSaved: (val) {
                    //  if(val!=null) {
                    globals.relationship = val;
                    fdb.relationship = val;
                    // }
                  },
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                    *//*   icon: const Icon(
                      Icons.my_location,
                      color: Colors.black,
                    ),*//*
                    hintText: 'Enter Occupation here',
                    labelText: 'Occupation',
                    hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.black),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xff07426A),
                    )),
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                  controller: globals.occupation != null
                      ? TextEditingController(text: fdb.occupation)
                      : TextEditingController(text: ""),
                  inputFormatters: [new LengthLimitingTextInputFormatter(30),globals.onlyCharacter],
                  onSaved: (val) {
                    // if(val!=null) {
                   // globals.occupation = val;
                    fdb.occupation = val;
                    //  }
                  },
                ),*/

                new DropdownButtonFormField(
                  value: education==null?null: education,
                  items: generateDropDown(0),
                  onChanged: (LookupBeanData newValue) {
                    print("new Value is ${newValue}");
                    showDropDown(newValue, 0);
                  },
                  validator: (args) {
                    print(args);
                  },
                  //  isExpanded: true,
                  //hint:Text("Select"),
                  decoration: InputDecoration(labelText: globals.dropdownCaptionsFamilyDetails[0]),
                  // style: TextStyle(color: Colors.grey),
                ),
                new DropdownButtonFormField(
                  value: relationShip==null?null:relationShip,
                  items: generateDropDown(1),
                  onChanged: (LookupBeanData newValue) {
                    showDropDown(newValue, 1);
                  },
                  validator: (args) {
                    print(args);
                  },
                  //  isExpanded: true,
                  //hint:Text("Select"),
                  decoration: InputDecoration(labelText: globals.dropdownCaptionsFamilyDetails[1]),
                  // style: TextStyle(color: Colors.grey),
                ),
                new DropdownButtonFormField(
                  value: occupation==null?null:occupation,
                  items: generateDropDown(2),
                  onChanged: (LookupBeanData newValue) {
                    showDropDown(newValue, 2);
                  },
                  validator: (args) {
                    print(args);
                  },
                  //  isExpanded: true,
                  //hint:Text("Select"),
                  decoration: InputDecoration(labelText: globals.dropdownCaptionsFamilyDetails[2]),
                  // style: TextStyle(color: Colors.grey),
                ),


                new TextFormField(
                  decoration: InputDecoration(
                    /*   icon: const Icon(
                      Icons.my_location,
                      color: Colors.black,
                    ),*/
                    hintText: Translations.of(context).text('Enter_Income'),
                    labelText: Translations.of(context).text('income'),
                    hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xff07426A),
                    )),
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                initialValue: CustomerFormationMasterTabsState.fdb.mincome != null &&  CustomerFormationMasterTabsState.fdb.mincome != 'null'? CustomerFormationMasterTabsState.fdb.mincome.toString():"" ,
                /*  controller:
                      CustomerFormationMasterTabsState.fdb.mincome != null
                          ? TextEditingController(
                              text: CustomerFormationMasterTabsState.fdb.mincome
                                  .toString())
                          : TextEditingController(text: ""),*/
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(10),
                    globals.onlyDoubleNumber
                  ],
                  onSaved: (val) {
                    //  if(val!=null) {
                    if (val != null && val != "") {
                      globals.income = double.parse(val);
                      CustomerFormationMasterTabsState.fdb.mincome =
                          double.parse(val);
                    } else {
                      //globals.income = 0.0;
                      CustomerFormationMasterTabsState.fdb.mincome = null;
                    }

                    // }
                  },
                ),
                /*new TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: const InputDecoration(
                    *//*icon: const Icon(
                      Icons.my_location,
                      color: Colors.black,
                    ),*//*
                    hintText: 'Enter Dependant here',
                    labelText: 'Dependant',
                    hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.black),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xff07426A),
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xff07426A),
                    )),
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                  controller: CustomerFormationMasterTabsState.fdb.mmemberno != null
                      ? TextEditingController(text: CustomerFormationMasterTabsState.fdb.mmemberno)
                      : TextEditingController(text: ""),
                  inputFormatters: [new LengthLimitingTextInputFormatter(2),globals.onlyIntNumber],
                  onSaved: (val) {
                    // if(val!=null) {
                    //globals.dependent = val;
                    CustomerFormationMasterTabsState.fdb.mmemberno = val;
                    // }
                  },
                ),*/
                new Table(children: [
                  new TableRow(
                      decoration: new BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer(globals.radioCaptionDependantYN[0]),
                        dependantRadio(),
                      ]),
                ]),
                new Container(
                  width: 300.0,
                  height: 10.0,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: new IconButton(
                        icon: new Icon(
                          Icons.format_list_bulleted,
                          color: Color(0xff07426A),
                          size: 50.0,
                        ),
                        onPressed: () {
                          _navigateAndDisplaySelection(context);
                        },
                      ),
                    ),
                    Flexible(
                        child: new IconButton(
                            padding: EdgeInsets.only(right: 30.0),
                            icon: new Icon(
                              Icons.add,
                              color: Color(0xff07426A),
                              size: 50.0,
                            ),
                            splashColor: Colors.red,
                            onPressed: () {
                              addToList();
                            })),
                  ],
                ),
              ],
            )));
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              new ViewCustomerFormationFamilyDetails(),
          fullscreenDialog: true,
        )).then((onValue) {
      setState(() {});
      //Scaffold.of(context).showSnackBar(SnackBar(content: Text("$onValue")));
    });
  }

  void addToList() {

    if(CustomerFormationMasterTabsState.custListBean.familyDetailsList==null){
      CustomerFormationMasterTabsState.custListBean.familyDetailsList= new  List<FamilyDetailsBean>();
    }


    if(CustomerFormationMasterTabsState.fdb.mname!=null&&CustomerFormationMasterTabsState.fdb.mname!="null"){
     // int listLength = globals.familyDetailsList.length;
      print("adding ${CustomerFormationMasterTabsState.fdb}");
      CustomerFormationMasterTabsState.fdb.trefno = CustomerFormationMasterTabsState.custListBean.trefno;
      if(CustomerFormationMasterTabsState.custListBean.mrefno==null) CustomerFormationMasterTabsState.fdb.mrefno = 0;
     else  CustomerFormationMasterTabsState.fdb.mrefno = CustomerFormationMasterTabsState.custListBean.mrefno;

      CustomerFormationMasterTabsState.fdb.mfamilyrefno = 0;



      CustomerFormationMasterTabsState.fdb.tfamilyrefno = CustomerFormationMasterTabsState.custListBean.familyDetailsList.length + 1;

      CustomerFormationMasterTabsState.custListBean.familyDetailsList.add(CustomerFormationMasterTabsState.fdb);

      education = blankBean;
      relationShip = blankBean;
      occupation = blankBean;
      //globals.familyDetailsList.insert(listLength, fdb);
      setState(() {
        CustomerFormationMasterTabsState.fdb = new FamilyDetailsBean();
      });
    } else {
      globals.Dialog.alertPopup(context,Translations.of(context).text('error'),Translations.of(context).text('Pls_Add_Member_name'),Translations.of(context).text('family') );
    }
  }
}
