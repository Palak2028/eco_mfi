import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/ViewAssetDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AssetDetailsBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerFormationSocialFinancialDetails extends StatefulWidget {
  CustomerFormationSocialFinancialDetails();
  /* final isNewCustomerComingFromList ;
  CustomerFormationSocialFinancialDetails(
      {Key key, @required this.isNewCustomerComingFromList})
      : super(key: key);
*/
  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );

  @override
  _CustomerFormationSocialFinancialDetailsState createState() =>
      new _CustomerFormationSocialFinancialDetailsState();
}

class _CustomerFormationSocialFinancialDetailsState
    extends State<CustomerFormationSocialFinancialDetails> {


  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);


  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  /*List<DropdownMenuItem<String>> generateDropDown(int no) {
    List<DropdownMenuItem<String>> _dropDownMenuItems1;
    int i=0;
    List mapdata = List();
    globals.dropDownCaptionValuesCOdeKeysSocialFinancial[no].forEach((mapValue) {
      var keys = mapValue.keys.toList();
      for(int i = 0; i <keys.length;i++){
        var val = mapValue[keys[i]];
        mapdata.add(val);
      }
    });
    mapdata.add("null");
    _dropDownMenuItems1 =  mapdata.map((value){
      return new DropdownMenuItem<String>(
        value: value ,
        child: new Text(value),
      );
    }).toList();
    return _dropDownMenuItems1;
  }*/

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    //print("caption value : " + globals.dropdownCaptionsPersonalInfo[no]);

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
    k < globals.dropDownCaptionValuesCOdeKeysSocialFinancial[no].length;
    k++) {
      mapData.add(globals.dropDownCaptionValuesCOdeKeysSocialFinancial[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      print("data here is of  dropdownwale biayajai " + value.mcodedesc);
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc,overflow: TextOverflow.ellipsis,maxLines: 3,),
      );
    }).toList();
    /*   if(no==0){
      print(mapData);
      testString = mapData;
    }*/
    return _dropDownMenuItems1;
  }

  bool isSaija = true;
  bool chkBankAccount= true;

  LookupBeanData house;
  LookupBeanData agriculturalLandOwner;
  LookupBeanData banknamelk;
  LookupBeanData asset;
  LookupBeanData construction;
  LookupBeanData toiletYN;
  LookupBeanData utils;
  SharedPreferences prefs;


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

    /*print("Asset Details" + globals.customModelsAssetsDetails.toString());
    print("Saving Details" + globals.customModelsSavingsDetails.toString());
    if (CustomerFormationMasterTabsState.custListBean.assetDetailsList == null) {
      CustomerFormationMasterTabsState.custListBean.assetDetailsList = new List<CustomModel>();
    }
    if (CustomerFormationMasterTabsState.custListBean.savingDetailsList == null) {
      CustomerFormationMasterTabsState.custListBean.savingDetailsList = new List<CustomModel>();
    }*/
    for(int i = 0;i<CustomerFormationMasterTabsState.socialFinancialRadios.length;i++){
      if(CustomerFormationMasterTabsState.socialFinancialRadios[i]==null)CustomerFormationMasterTabsState.socialFinancialRadios[i]= 0;
    }

    if(CustomerFormationMasterTabsState.custListBean.mConstruct!=null)CustomerFormationMasterTabsState.socialFinancialRadios[0] = CustomerFormationMasterTabsState.custListBean.mConstruct;
    if(CustomerFormationMasterTabsState.custListBean.mToilet!=null)CustomerFormationMasterTabsState.socialFinancialRadios[1] = CustomerFormationMasterTabsState.custListBean.mToilet;
    /*if(CustomerFormationMasterTabsState.custListBean.mBankAccYN!=null)CustomerFormationMasterTabsState.socialFinancialRadios[2] = CustomerFormationMasterTabsState.custListBean.mBankAccYN;*/

    if (!ifNullCheck(CustomerFormationMasterTabsState.custListBean.mbankacyn)) {

      try {
        CustomerFormationMasterTabsState.socialFinancialRadios[2] =
            int.parse(CustomerFormationMasterTabsState.custListBean.mbankacyn);
      } catch(_){
        CustomerFormationMasterTabsState.socialFinancialRadios[2] =1;
          }
    }
    else{
      CustomerFormationMasterTabsState.custListBean.mbankacyn = "1";
      CustomerFormationMasterTabsState.socialFinancialRadios[2] =1;

    }


    List tempDropDownValues =  new List();

    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mHouse);
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mAgricultureType);
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mbanknamelk);
    tempDropDownValues.add(CustomerFormationMasterTabsState.assetBean.mitem);
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mConstruct);
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mToilet);
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mutils);


    for (int k = 0;
    k < globals.dropDownCaptionValuesCOdeKeysSocialFinancial.length;
    k++) {
      for (int i = 0;
      i < globals.dropDownCaptionValuesCOdeKeysSocialFinancial[k].length;
      i++) {
        try {
        if (globals.dropDownCaptionValuesCOdeKeysSocialFinancial[k][i].mcode.toString().trim() ==
            tempDropDownValues[k].toString().trim()) {
          setValue(k, globals.dropDownCaptionValuesCOdeKeysSocialFinancial[k][i]);
        }
        }catch(_){
          print("Exception Occured");
        }
      }
    }


<<<<<<< .mine
    try {
      if (CustomerFormationMasterTabsState.custListBean.mHouse!=null&&
          CustomerFormationMasterTabsState.custListBean.mHouse.trim() == "4" &&
          CustomerFormationMasterTabsState.resAddPresent == true) {
        CustomerFormationMasterTabsState.resAddPresent = false;
      }
    }catch(_){
    }
=======

    try {
      if (CustomerFormationMasterTabsState.custListBean.mHouse!=null&&
          CustomerFormationMasterTabsState.custListBean.mHouse.trim() == "4" &&
          CustomerFormationMasterTabsState.resAddPresent == true) {
        CustomerFormationMasterTabsState.resAddPresent = false;
      }
    }catch(_){

    }

>>>>>>> .r1143
    getSessionVariables();
  }


  showDropDown(LookupBeanData selectedObj, int no) {

    if(selectedObj.mcodedesc.isEmpty){
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          house = blankBean;
          CustomerFormationMasterTabsState.custListBean.mHouse = blankBean.mcode;
          break;
        case 1:
          agriculturalLandOwner = blankBean;
          CustomerFormationMasterTabsState.custListBean.mAgricultureType= blankBean.mcode;
          break;
        case 2:
          banknamelk = blankBean;
          CustomerFormationMasterTabsState.custListBean.mbanknamelk= blankBean.mcode;
          break;
        case 3:
          asset = blankBean;
          CustomerFormationMasterTabsState.assetBean.mitem= 0;
          break;
        case 4:
          construction = blankBean;
          CustomerFormationMasterTabsState.custListBean.mConstruct= 0;
          break;
        case 5:
          toiletYN = blankBean;
          CustomerFormationMasterTabsState.custListBean.mToilet= 0;
          break;
        case 5:
          utils= blankBean;
          CustomerFormationMasterTabsState.custListBean.mutils= 0;
          break;
        default:
          break;
      }
      setState(() {

      });
    }
    else{
      for (int k = 0;
      k < globals.dropDownCaptionValuesCOdeKeysSocialFinancial[no].length;
      k++) {
        if (globals.dropDownCaptionValuesCOdeKeysSocialFinancial[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropDownCaptionValuesCOdeKeysSocialFinancial[no][k]);
        }
      }
    }

  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          house = value;
          CustomerFormationMasterTabsState.custListBean.mHouse = value.mcode;
<<<<<<< .mine
          if(CustomerFormationMasterTabsState.custListBean.mHouse.trim()=="4"){
            CustomerFormationMasterTabsState.resAddPresent=false;
          }else{
            CustomerFormationMasterTabsState.resAddPresent=true;
          }
=======

          if(CustomerFormationMasterTabsState.custListBean.mHouse.trim()=="4"){

            CustomerFormationMasterTabsState.resAddPresent=false;
          }else{
            CustomerFormationMasterTabsState.resAddPresent=true;
          }
>>>>>>> .r1143
          break;
        case 1:
          agriculturalLandOwner = value;
          CustomerFormationMasterTabsState.custListBean.mAgricultureType = value.mcode;
          break;
        case 2:
          banknamelk = value;
          CustomerFormationMasterTabsState.custListBean.mbanknamelk= value.mcode;
          break;
        case 3:
          asset = value;
          CustomerFormationMasterTabsState.assetBean.mitem= int.parse(value.mcode);
          break;
        case 4:
          construction = value;
          CustomerFormationMasterTabsState.custListBean.mConstruct= int.parse(value.mcode);
          break;
        case 5:
          toiletYN = value;
          CustomerFormationMasterTabsState.custListBean.mToilet= int.parse(value.mcode);
          break;
        case 6:
          utils = value;
          CustomerFormationMasterTabsState.custListBean.mutils= int.parse(value.mcode);
          break;
        default:
          break;
      }
    });
  }



  Future<Null> getSessionVariables() async {

    prefs = await SharedPreferences.getInstance();


    if(prefs.getInt(TablesColumnFile.isSaiaja)==1){
      isSaija = true ;

    }
    else{
      isSaija = false;
    }


    try{
      setState(() {

      });
    }catch(_){}


  }

  Widget constructionRadio() =>
      CustomerFormationSocialFinancialDetails._get(new Row(
        children:
            _makeRadios(2, globals.radioCaptionValuesSocialFinancial[0], 0),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));

  Widget toiletRadio() => CustomerFormationSocialFinancialDetails._get(new Row(
        children:
            _makeRadios(2, globals.radioCaptionValuesSocialFinancial[1], 1),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));

  Widget bankAccountRadio() =>
      CustomerFormationSocialFinancialDetails._get(new Row(
        children:
            _makeRadios(2, globals.radioCaptionValuesSocialFinancial[2], 2),
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
            groupValue: CustomerFormationMasterTabsState.socialFinancialRadios[position],
            onChanged: (selection) {
              print(selection);

              return _onRadioSelected(selection, position);
            } ,
            activeColor:  Color(0xff07426A),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      ));
    }
    return radios;
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

  _onRadioSelected(int selection, int position) {
    setState(() => CustomerFormationMasterTabsState.socialFinancialRadios[position] = selection);
    if (position == 0) {
      CustomerFormationMasterTabsState.custListBean.mConstruct = selection;

    } else if (position == 1) {
      CustomerFormationMasterTabsState.custListBean.mToilet = selection;
    } else if (position == 2) {
      CustomerFormationMasterTabsState.custListBean.mbankacyn = selection.toString().trim();
    }
  }

  @override
  Widget build(BuildContext context) {
    return    new Form(
      key: _formKey,
      autovalidate: false,

      onChanged: () {
        final FormState form = _formKey.currentState;
        form.save();
      },
      child: Container(
        color: CustomerFormationMasterTabsState.resAddPresent==true?Constant.mandatoryColor:Colors.white,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        children: <Widget>[
          new DropdownButtonFormField(
            value: house,
            items: generateDropDown(0),
            onChanged: (LookupBeanData newValue) {
              showDropDown(newValue, 0);
            },
            validator: (args) {
              print(args);
            },
            //  isExpanded: true,
            //hint:Text("Select"),
              decoration: InputDecoration(labelText: Translations.of(context).text('house')),
            // style: TextStyle(color: Colors.grey),
          ),

          SizedBox(height: 16,),
//contsruction Dropdown
          Container(
            color: CustomerFormationMasterTabsState.resAddPresent==true?Constant.mandatoryColor:Colors.white,
            child: new DropdownButtonFormField(
              value: construction,
              items: generateDropDown(4),
              onChanged: (LookupBeanData newValue) {
                showDropDown(newValue, 4);
              },
              validator: (args) {
                print(args);
              },
              //  isExpanded: true,
              //hint:Text("Select"),
              decoration: InputDecoration(labelText: Translations.of(context).text('construction')),
              // style: TextStyle(color: Colors.grey),
            ),
          ),

          SizedBox(height: 16,),
//Toilet Dropdown
          Container(
            color: CustomerFormationMasterTabsState.resAddPresent==true?Constant.mandatoryColor:Colors.white,
            child: new DropdownButtonFormField(
              value: toiletYN,
              items: generateDropDown(5),
              onChanged: (LookupBeanData newValue) {
                showDropDown(newValue, 5);
              },
              validator: (args) {
                print(args);
              },
              //  isExpanded: true,
              //hint:Text("Select"),
              decoration: InputDecoration(labelText: Translations.of(context).text('toilet')),
              // style: TextStyle(color: Colors.grey),
            ),
          ),

          SizedBox(height: 16,),
          Container(
            color: CustomerFormationMasterTabsState.resAddPresent==true?Constant.mandatoryColor:Colors.white,
            child: new DropdownButtonFormField(
              value: utils,
              items: generateDropDown(6),
              onChanged: (LookupBeanData newValue) {
                showDropDown(newValue, 6);
              },
              validator: (args) {
                print(args);
              },
              //  isExpanded: true,
              //hint:Text("Select"),
              decoration: InputDecoration(labelText: Translations.of(context).text('utils')),
              // style: TextStyle(color: Colors.grey),
            ),
          ),

          new Card(
            child:new Column(children: <Widget>[
              new Card(
                child: new Text("Asset Details"),
              ),
              new DropdownButtonFormField(
                value: asset,
                items: generateDropDown(3),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 3);
                },
                validator: (args) {
                  print(args);
                },
                //  isExpanded: true,
                //hint:Text("Select"),
                decoration: InputDecoration(labelText: "Items"),
                // style: TextStyle(color: Colors.grey),
              ),
              
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
              new Container(
                width: 300.0,
                height: 10.0,
              ),
            ]),
          ),
            isSaija==true?new DropdownButtonFormField(
            value: agriculturalLandOwner,
            items: generateDropDown(1),
            onChanged: (LookupBeanData newValue) {
              showDropDown(newValue, 1);
            },
            validator: (args) {
              print(args);
            },
            //  isExpanded: true,
            //hint:Text("Select"),
            decoration: InputDecoration(labelText: "Agricultural Land Type"),
            // style: TextStyle(color: Colors.grey),
            ):new Container(),
      new Card(
          child: new Table(
            children: [
              new TableRow(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 0.1),
                  ),
                  children: [
                    getTextContainer(globals.radioCaptionSocialFinancial[2]),
                    bankAccountRadio(),
                  ]),
      ])),
//          globals.socialFinancialDetailsBean.bankAccount=='Yes'?new Card(
          CustomerFormationMasterTabsState.custListBean.mbankacyn =="0"?new Container(
              color:  Constant.mandatoryColor,
              child: new Column(
                children: <Widget>[
                  new Card(
                    child: new Text("Banks Details"),
                  ),
                  new TextFormField(

                    enableInteractiveSelection: false,
                      obscureText: true,
                  decoration: const InputDecoration(

                    hintText: 'Enter Account Number',
                    labelText: 'Account Number',

                    hintStyle: TextStyle(color: Colors.grey),
                    /* labelStyle: TextStyle(color: Colors.grey),*/
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
                  keyboardType: TextInputType.number,
              inputFormatters: [new LengthLimitingTextInputFormatter(20),globals.onlyIntNumber]
                  ,
                 // validator: (arg)=>Utility.validateOnlyNumberField(arg),
                  initialValue:CustomerFormationMasterTabsState.custListBean.mbankacno=="0"||
                      CustomerFormationMasterTabsState.custListBean.mbankacno==null ||
                      CustomerFormationMasterTabsState.custListBean.mbankacno=="null"?
                  "":CustomerFormationMasterTabsState.custListBean.mbankacno.toString(),
                  onSaved: (val) {
                    if(val!=null&&val!="")
                      CustomerFormationMasterTabsState.custListBean.mbankacno = val;

                    else CustomerFormationMasterTabsState.custListBean.mbankacno = "";

                  } ,
                ),


                  new TextFormField(
                    enableInteractiveSelection: false,
                    obscureText: true,
                    decoration: const InputDecoration(

                      hintText: 'Renter Account Number',
                      labelText: 'Renter Account Number',
                      hintStyle: TextStyle(color: Colors.grey),
                      /* labelStyle: TextStyle(color: Colors.grey),*/
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
                    keyboardType: TextInputType.number,
                    inputFormatters: [new LengthLimitingTextInputFormatter(20),globals.onlyIntNumber]
                    ,
                    // validator: (arg)=>Utility.validateOnlyNumberField(arg),
                    initialValue:CustomerFormationMasterTabsState.tempBnkAccNo=="0"||
                        CustomerFormationMasterTabsState.tempBnkAccNo==null ||
                        CustomerFormationMasterTabsState.tempBnkAccNo=="null"?
                    "":CustomerFormationMasterTabsState.tempBnkAccNo.toString(),
                    onSaved: (val) {
                      if(val!=null&&val!="")
                        CustomerFormationMasterTabsState.tempBnkAccNo = val;

                      else CustomerFormationMasterTabsState.tempBnkAccNo = "";

                    } ,
                  ),


              new DropdownButtonFormField(
                value: banknamelk,
                items: generateDropDown(2),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 2);
                },
                validator: (args) {
                  print(args);
                },
                //  isExpanded: true,
                //hint:Text("Select"),
                    decoration: InputDecoration(labelText: "Bank Name"),
                    /*decoration:
                    new InputDecoration(
                       labelText: constant.bankName,
                      contentPadding: EdgeInsets.all(20.0),
                      isDense: true,


                    ),*/
                // style: TextStyle(color: Colors.grey),
              ),

              /*new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(

                    hintText: 'Enter Bank Name',
                    labelText: 'Bank Name',
                    hintStyle: TextStyle(color: Colors.grey),
                    /*labelStyle: TextStyle(color: Colors.grey),*/
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
                inputFormatters: [new LengthLimitingTextInputFormatter(25),globals.onlyCharacter],
                validator: (arg)=>Utility.validateOnlyCharacterFieldNotMandat(arg),
                  initialValue:
                  CustomerFormationMasterTabsState.custListBean.mbanknamelk==null||
                      CustomerFormationMasterTabsState.custListBean.mbanknamelk=="null" ?"":
                  CustomerFormationMasterTabsState.custListBean.mbanknamelk,
                  onSaved: (val) => CustomerFormationMasterTabsState.custListBean.mbanknamelk = val,
                ),*/
             new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(

                    hintText: 'Enter Branch',
                    labelText: 'Branch',
                    hintStyle: TextStyle(color: Colors.grey),
                    /* labelStyle: TextStyle(color: Colors.grey),*/
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
               inputFormatters: [new LengthLimitingTextInputFormatter(25),globals.onlyAphaNumeric],
                  initialValue: CustomerFormationMasterTabsState.custListBean.mbankbranch==null||
                      CustomerFormationMasterTabsState.custListBean.mbankbranch=="null"? "":
                  CustomerFormationMasterTabsState.custListBean.mbankbranch,
                  onSaved: (val) {
                    CustomerFormationMasterTabsState.custListBean.mbankbranch= val;

                  } ,
                ),

             new TextFormField(
                  decoration: const InputDecoration(

                    hintText: 'Enter IFSC Code ',
                    labelText: 'IFSC Code',
                    hintStyle: TextStyle(color: Colors.grey),
                    /* labelStyle: TextStyle(color: Colors.grey),*/
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
               inputFormatters: [LengthLimitingTextInputFormatter(11),globals.onlyAphaNumeric],
               validator: (arg)=>Utility.validateCharacterAndNumberField(arg),
                  initialValue: CustomerFormationMasterTabsState.custListBean.mbankifsc==null||
                      CustomerFormationMasterTabsState.custListBean.mbankifsc=="null"? "":
                  CustomerFormationMasterTabsState.custListBean.mbankifsc,
                  onSaved: (val) => CustomerFormationMasterTabsState.custListBean.mbankifsc= val,
                ),


                ]),
      ):new Container(),

          ],
        ),
      ),
    );


  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
          new ViewAssetDetails(),
          fullscreenDialog: true,
        )).then((onValue) {
      setState(() {});
    });
  }

  void addToList() {
    bool temp = true;
    if (CustomerFormationMasterTabsState.custListBean.assetDetailsList ==
        null) {
      CustomerFormationMasterTabsState.custListBean.assetDetailsList =
      new List<AssetDetailsBean>();
    }

    if (CustomerFormationMasterTabsState.assetBean.mitem != null &&
        CustomerFormationMasterTabsState.assetBean.mitem != "null") {

      for(int  i=0;i<CustomerFormationMasterTabsState.custListBean.assetDetailsList.length;i++){

        if(CustomerFormationMasterTabsState.custListBean.assetDetailsList[i].mitem
            ==
            CustomerFormationMasterTabsState.assetBean.mitem){

          temp=false;


        }

      }

      if(temp==false){
        globals.Dialog.alertPopup(context, "Error",
            "Two assets cannot be same", "AssetDetail");

      }else{
      print("adding ${CustomerFormationMasterTabsState.assetBean}");
      CustomerFormationMasterTabsState.assetBean.trefno =
          CustomerFormationMasterTabsState.custListBean.trefno;
      if (CustomerFormationMasterTabsState.custListBean.mrefno == null)
        CustomerFormationMasterTabsState.assetBean.mrefno = 0;
      else
        CustomerFormationMasterTabsState.assetBean.mrefno =
            CustomerFormationMasterTabsState.custListBean.mrefno;

      CustomerFormationMasterTabsState.assetBean.massetdetrefno = 0;

      CustomerFormationMasterTabsState.assetBean.tassetdetrefno =
          CustomerFormationMasterTabsState
              .custListBean.assetDetailsList.length +
              1;

      print(CustomerFormationMasterTabsState.assetBean);
      asset = blankBean;
      /*setState(() {

      });*/
      if(CustomerFormationMasterTabsState.custListBean.assetDetailsList==null)
      CustomerFormationMasterTabsState.custListBean.assetDetailsList = new List<AssetDetailsBean>();
      CustomerFormationMasterTabsState.custListBean.assetDetailsList
          .add(CustomerFormationMasterTabsState.assetBean);
      print("added List is ${CustomerFormationMasterTabsState.custListBean.assetDetailsList}");

      asset = blankBean;
      setState(() {
        print("set state asset");
        CustomerFormationMasterTabsState.assetBean = new AssetDetailsBean();
      });
      }

      } else {
        globals.Dialog.alertPopup(context, "Error",
            "Please Add Asset, It should not be blank", "AssetDetail");
      }
  }
}

class CustomModel {
  static const TITLE_KEY = 'title';

  String id;
  String title;
  bool isChecked = false;


  @override
  String toString() {
    return 'CustomModel{id: $id, title: $title, isChecked: $isChecked}';
  }

  void setIsChecked(bool isChecked) {
    this.isChecked = isChecked;
  }

  bool getIsChecked() {
    return isChecked;
  }



  CustomModel(String ex) {
    title = ex;
  }

}

class SocialFinancialDetailsBean {
  String house;
  String construction;
  String toilet;
  String bankAccount;
  String agriculturalLandOwner;
  String loanFromOtherBankOrPerson;

  SocialFinancialDetailsBean(
      {this.house,
      this.construction,
      this.toilet,
      this.bankAccount,
      this.agriculturalLandOwner,
      this.loanFromOtherBankOrPerson});
}
