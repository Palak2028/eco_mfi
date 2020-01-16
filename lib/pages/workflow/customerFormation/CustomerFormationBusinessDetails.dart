import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/address/FullScreenDialogForAreaSelection.dart';
import 'package:eco_mfi/pages/workflow/address/FullScreenDialogForCountrySelection.dart';
import 'package:eco_mfi/pages/workflow/address/FullScreenDialogForDistrictSelection.dart';
import 'package:eco_mfi/pages/workflow/address/FullScreenDialogForStateSelection.dart';
import 'package:eco_mfi/pages/workflow/address/FullScreenDialogForSubDistrictSelection.dart';
import 'package:eco_mfi/pages/workflow/address/beans/AreaDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/CountryDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/DistrictDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/StateDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/SubDistrictDropDownBean.dart';
import 'package:eco_mfi/db/AppDatabase.dart';

import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerBusinessDetailsBean.dart';

import '../../../translations.dart';

class CustomerFormationBusinessDetails extends StatefulWidget {
  CustomerFormationBusinessDetails({Key key}) : super(key: key);

  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );

  @override
  _CustomerFormationBusinessDetailsState createState() =>
      new _CustomerFormationBusinessDetailsState();
}

class _CustomerFormationBusinessDetailsState
    extends State<CustomerFormationBusinessDetails> {
  CountryDropDownBean tempContrybean = new CountryDropDownBean();
  StateDropDownList tempStateBean = new StateDropDownList();
  SubDistrictDropDownList tempSubDistrictBean = new SubDistrictDropDownList();
  DistrictDropDownList tempDistrictBean = new DistrictDropDownList();
  AreaDropDownList tempAreaDistrict = new AreaDropDownList();
  FullScreenDialogForCountrySelection _myCountryDialog =
  new FullScreenDialogForCountrySelection();
  FullScreenDialogForStateSelection _myStateDialog =
  new FullScreenDialogForStateSelection();
  FullScreenDialogForDistrictSelection _myDistrictDialog =
  new FullScreenDialogForDistrictSelection();
  FullScreenDialogForSubDistrictSelection _mySubDistrictDialog =
  new FullScreenDialogForSubDistrictSelection(false);
  FullScreenDialogForAreaSelection _myAreaDialog =
  new FullScreenDialogForAreaSelection();
  String countryName="";
  String stateName="";
  String districtName="";
  String subDistrictName="";
  String areaName="";
  CountryDropDownBean cddb= new  CountryDropDownBean();




  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  LookupBeanData occupaOrBuisness;

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
    getSessionVariables();

    /* if(countryName!=null && countryName!="null" && countryName !=null){
      AppDatabase.get().getCountryNameViaCountryCode(
          tempContrybean.cntryCd.toString()).then((onValue) {
        countryName = onValue.countryName;
          };*/

    /*   if(CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean
        .mbuscountry!=null) {
      print("hjhhuihuhug"+CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean
          .mbuscountry.toString());
      AppDatabase.get().getCountryNameViaCountryCode(
          CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean
              .mbuscountry.toString()).then((onValue) {
        countryName = onValue.countryName;
        print("onValue.countryName1"+onValue.countryName.toString());
        print("countryName1"+countryName.toString());
      });
    }*/


    print("Asset Details" + globals.customModelsAssetsDetails.toString());
    print("Saving Details" + globals.customModelsSavingsDetails.toString());
    if(CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean==null){
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean = new CustomerBusinessDetailsBean();
    }
    List tempDropDownValues = new List();
    for (int i = 0; i <
        CustomerFormationMasterTabsState.businessDetailRadios.length; i++) {
      if (CustomerFormationMasterTabsState.businessDetailRadios[i] == null)
        CustomerFormationMasterTabsState.businessDetailRadios[i] = 0;
    }

    // try{
    if (!ifNullCheck(CustomerFormationMasterTabsState.custListBean
        .customerBusinessDetailsBean.mbusnhousesameplaceyn)) {
      CustomerFormationMasterTabsState.businessDetailRadios[0] = int.parse(
          CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mbusnhousesameplaceyn);
    }
    else{
      CustomerFormationMasterTabsState.custListBean
          .customerBusinessDetailsBean.mbusnhousesameplaceyn = "0";
    }
    //} catch(_){
    //CustomerFormationMasterTabsState.businessDetailRadios[0]=0;
    //}
    //try {
    if (!ifNullCheck(CustomerFormationMasterTabsState.custListBean
        .customerBusinessDetailsBean.mregisteredyn)) {
      CustomerFormationMasterTabsState.businessDetailRadios[1] = int.parse(
          CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mregisteredyn);
    }
    else{
      CustomerFormationMasterTabsState.custListBean
          .customerBusinessDetailsBean.mregisteredyn = "0";
    }
    /*}
    catch(_){
      CustomerFormationMasterTabsState.businessDetailRadios[1]=0;
    }*/
//try{
    if(!ifNullCheck(CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusinesstrend)) {
      CustomerFormationMasterTabsState.businessDetailRadios[2] = int.parse(
          CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mbusinesstrend);
    }
    else{
      CustomerFormationMasterTabsState.custListBean
          .customerBusinessDetailsBean.mbusinesstrend = "0";
    }

    if(!ifNullCheck(CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mcusactivitytype.toString())) {
      CustomerFormationMasterTabsState.businessDetailRadios[3] = int.parse(
          CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mcusactivitytype.toString());
    }
    else{
      CustomerFormationMasterTabsState.custListBean
          .customerBusinessDetailsBean.mcusactivitytype = 0;
    }

    /* }catch(_){
    CustomerFormationMasterTabsState.businessDetailRadios[2]=0;
    }*/
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mOccBuisness);

    for (int k = 0;
    k < globals.dropDownCaptionValuesBusinessDetails.length;
    k++) {
      for (int i = 0;
      i < globals.dropDownCaptionValuesBusinessDetails[k].length;
      i++) {
        if (globals.dropDownCaptionValuesBusinessDetails[k][i].mcode ==
            tempDropDownValues[k]) {
          setValue(k, globals.dropDownCaptionValuesBusinessDetails[k][i]);
        }
      }
    }
  }

  showDropDown(LookupBeanData selectedObj, int no) {
    for (int k = 0;
    k < globals.dropDownCaptionValuesBusinessDetails[no].length;
    k++) {
      if (globals.dropDownCaptionValuesBusinessDetails[no][k].mcodedesc ==
          selectedObj.mcodedesc) {
        setValue(no, globals.dropDownCaptionValuesBusinessDetails[no][k]);
      }
    }
  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          occupaOrBuisness = value;
          CustomerFormationMasterTabsState.custListBean.mOccBuisness = value.mcode;
          break;
        default:
          break;
      }
    });
  }

  Future<Null> getSessionVariables() async {
    if(CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean
        .mbuscountry!=null) {
      await AppDatabase.get().getCountryNameViaCountryCode(
          CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mbuscountry).then((onValue){
        setState(() {
          if(onValue.countryName!=null){
            countryName = onValue.countryName;
          }

        });
      });
    }
    if(CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean
        .mbusstate!=null) {
      await AppDatabase.get().getStateNameViaStateCode(
          CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mbusstate).then((onValue){
        setState(() {
          if(onValue.stateDesc!=null){
            stateName = onValue.stateDesc;
          }

        });
      });
    }
    if(CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean
        .mdistcd!=null) {
      await AppDatabase.get().getDistrictNameViaDistrictCode(
          CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mdistcd.toString()).then((onValue){
        setState(() {
          if(onValue.distDesc!=null){
            districtName = onValue.distDesc;
          }

        });
      });
    }

    if(CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean
        .mbuscity!=null) {
      await AppDatabase.get().getPlaceNameViaPlaceCode(
          CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mbuscity).then((onValue){
        setState(() {
          if(onValue.placeCdDesc!=null){
            subDistrictName = onValue.placeCdDesc;
          }

        });
      });
    }

    if(CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean
        .mbusarea!=null) {
      await AppDatabase.get().getAreaNameViaAreaCode(
          CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mbusarea.toString()).then((onValue){
        setState(() {
          if(onValue.areaDesc!=null){
            areaName = onValue.areaDesc;
          }

        });
      });
    }
  }

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    //print("caption value : " + globals.dropDownCaptionBusinessDetails[no]);

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(bean);
    for (int k = 0;
    k < globals.dropDownCaptionValuesBusinessDetails[no].length;
    k++) {
      mapData.add(globals.dropDownCaptionValuesBusinessDetails[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      //print("data here is of  dropdownwale biayajai " + value.mcodedesc);
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc),
      );
    }).toList();
    return _dropDownMenuItems1;
  }

  Widget businessTrendRadio() => CustomerFormationBusinessDetails._get(new Row(
    children:
    _makeRadios(2, globals.radioCaptionValuesBusinessDetails[0], 0),
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  ));

  Widget samePlaceRadio() => CustomerFormationBusinessDetails._get(new Row(
    children:
    _makeRadios(2, globals.radioCaptionValuesBusinessDetails[1], 1),
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  ));

  Widget registeredBusinessRadio() =>
      CustomerFormationBusinessDetails._get(new Row(
        children:
        _makeRadios(2, globals.radioCaptionValuesBusinessDetails[2], 2),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));

  Widget businessOrServiceRadio() => CustomerFormationBusinessDetails._get(new Row(
    children:
    _makeRadios(2, globals.radioCaptionValuesBusinessDetails[3], 3),
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
            groupValue: CustomerFormationMasterTabsState.businessDetailRadios[position],
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
    setState(() => CustomerFormationMasterTabsState.businessDetailRadios[position] = selection);
    if (position == 0) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusnhousesameplaceyn  =selection.toString();

    } else if (position == 1) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mregisteredyn  =selection.toString();

    } else if (position == 2) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusinesstrend=selection.toString();

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

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        children: <Widget>[
          Center(
            child: new Table(children: [

              new TableRow(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 0.1),
                  ),
                  children: [
                    //getTextContainer(globals.radioCaptionBusinessDetails[2]),
                    businessOrServiceRadio(),
                  ]),
            ]),
          ),
          Center(
            child: new Column(children: [
              //occupationRadio(),

              Container(
                color: Constant.mandatoryColor
                ,child:new DropdownButtonFormField(
                value: occupaOrBuisness,
                items: generateDropDown(0),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 0);

                },
                validator: (args) {
                  print(args);
                },
                //  isExpanded: true,
                //hint:Text("Select"),
                decoration: InputDecoration(labelText: globals.dropDownCaptionBusinessDetails[0]),
                // style: TextStyle(color: Colors.grey),
              ),)


            ]),
          ),
          /*new DropdownButtonFormField(
            value: occupaOrBuisness,
            items: generateDropDown(0),
            onChanged: (LookupBeanData newValue) {
              showDropDown(newValue, 0);

            },
            validator: (args) {
              print(args);
            },
            //  isExpanded: true,
            //hint:Text("Select"),
            decoration: InputDecoration(labelText: globals.dropDownCaptionBusinessDetails[0]),
            // style: TextStyle(color: Colors.grey),
          ),*/
          Center(
            child: new Table(children: [
              new TableRow(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 0.1),
                  ),
                  children: [
                    getTextContainer(globals.radioCaptionBusinessDetails[0]),
                    samePlaceRadio(),
                  ]),
              new TableRow(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 0.1),
                  ),
                  children: [
                    getTextContainer(globals.radioCaptionBusinessDetails[1]),
                    registeredBusinessRadio(),
                  ]),
              new TableRow(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 0.1),
                  ),
                  children: [
                    getTextContainer(globals.radioCaptionBusinessDetails[2]),
                    businessTrendRadio(),
                  ]),
            ]),
          ),

          new Form(
            key: _formKey,
            autovalidate: false,
            onWillPop: () {
              return Future(() => true);
            },
            onChanged: () {
              final FormState form = _formKey.currentState;
              form.save();
            },
            child: new Column(
              children: [

                new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration:  InputDecoration(

                    hintText: Translations.of(context).text('Enter_Org_Name'),
                    labelText: Translations.of(context).text('Org_Name'),
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
                  inputFormatters: [new LengthLimitingTextInputFormatter(30),globals.onlyAphaNumeric],
                  initialValue:
                  CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusinessname!= null&&
                      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusinessname!="null" ?
                  CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusinessname : "",
                  onSaved: (val) => CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusinessname= val,
                ),

                new TextFormField(
                  keyboardType: TextInputType.multiline,
                  decoration:  InputDecoration(

                    hintText: Translations.of(context).text('Enter_Add'),
                    labelText: Translations.of(context).text('Address'),
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
                  initialValue: CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusaddress1!= null&&
                      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusaddress1!="null"
                      ? CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusaddress1
                      : "",
                  onSaved: (val) => CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusaddress1 = val,
                ),

                SizedBox(height: 16.0),
                Container(
                  color:  Constant.semiMandatoryColor,
                  child: new ListTile(

                    title: new Text(Translations.of(context).text('Country')),
                    subtitle: countryName == null ||
                        countryName== "null"
                        ? new Text("")
                        : new Text("${countryName}"),
                    onTap: () async {
                      getCountryName();
                    },
                  ),
                ),
                new Divider(),//),
                SizedBox(height: 16.0),
                Container(
                  color: Constant.semiMandatoryColor,
                  child: new ListTile(

                    title: new Text(Translations.of(context).text('State')),
                    subtitle:
                    stateName == null || stateName== "null"
                        ? new Text("")
                        : new Text("${stateName} "),
                    onTap: () async {
                      getStateName();
                    },
                  ),
                ),

                new Divider(),
                SizedBox(height: 16.0),


                Container(
                  color: Constant.semiMandatoryColor,
                  child: new ListTile(

                    title: new Text(Translations.of(context).text('District')),
                    subtitle:
                    districtName == null || districtName== "null"
                        ? new Text("")
                        : new Text("${districtName}"),
                    onTap: () async {
                      getDistrictName();
                    },
                  ),
                ),

                new Divider(),
                SizedBox(height: 16.0),
                Container(
                  color: Constant.mandatoryColor,
                  child: new ListTile(

                    title: new Text(Translations.of(context).text('SubDistrict')),
                    subtitle: subDistrictName == null ||
                        subDistrictName== "null"
                        ? new Text("")
                        : new Text("${subDistrictName} "),
                    onTap: () async {
                      getSubDistrictName();
                    },
                  ),
                ),

                new Divider(),
                SizedBox(height: 16.0),
                new ListTile(
                  title: new Text(Translations.of(context).text('area')),
                  subtitle:
                  areaName== null || areaName== "null"
                      ? new Text("")
                      : new Text("${areaName}"),
                  onTap: () async {
                    getArea();
                  },
                ),
                new TextFormField(
                  decoration:  InputDecoration(
                    hintText: Translations.of(context).text('Enter_Landmark'),
                    labelText: Translations.of(context).text('LandMark'),
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
                  controller:  CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbuslandmark != null
                      ? TextEditingController(text:  CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbuslandmark)
                      : TextEditingController(text: ""),
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(80),
                    globals.onlyCharacter
                  ],
                  onSaved: (val) {
                    //  if(val!=null) {
                    CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbuslandmark = val;
                    // }
                  },
                ),
                Container(
                  color: Constant.semiMandatoryColor,
                  child: new TextFormField(
                    decoration:  InputDecoration(
                      hintText: Translations.of(context).text('Enter_Pin'),
                      labelText: Translations.of(context).text('Pin '),
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
                    keyboardType: TextInputType.number,
                    controller: CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbuspin != null
                        ? TextEditingController(text: CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbuspin.toString())
                        : TextEditingController(text: ""),
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(6),
                      globals.onlyIntNumber
                    ],
                    onSaved: (val) {
                      if(val!=null&&val!=""){
                        try{
                          CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbuspin = int.parse(val);
                        }catch(e){

                        }
                      }

                    },
                  ),
                ),
                new TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:  InputDecoration(

                      hintText: Translations.of(context).text('Enter_no_Of_yrs_in_Org'),
                      labelText: Translations.of(context).text('No_Of_yrs_in_Org'),
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
                    inputFormatters: [new LengthLimitingTextInputFormatter(3),globals.onlyIntNumber],
                    initialValue: CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusyrsmnths==null||
                        CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusyrsmnths==0?""
                        :CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusyrsmnths.toString(),
                    onSaved: (val) {
                      if(val!=null&&val!=""){
                        CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusyrsmnths = int.parse(val);
                      }


                    }
                ),

                new TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:  InputDecoration(

                      hintText: Translations.of(context).text('Enter_Reg_No'),
                      labelText: Translations.of(context).text('Reg_No'),
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
                    inputFormatters: [new LengthLimitingTextInputFormatter(15),globals.onlyIntNumber],
                    initialValue: CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mregistrationno==null ||
                        CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mregistrationno=="null"?"":
                    CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mregistrationno,
                    onSaved: (val) {
                      print(val);
                      if(val!=null&&val!="") {
                        CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mregistrationno = val;
                      }
                    }
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
  Future getCountryName() async {
    tempContrybean = await
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => _myCountryDialog,
          fullscreenDialog: true,
        ));
    if(tempContrybean!=null) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean
          .mbuscountry = tempContrybean.cntryCd;
      AppDatabase.get().getCountryNameViaCountryCode(
          tempContrybean.cntryCd.toString()).then((onValue) {
        countryName = onValue.countryName;
        print("onValue.countryName"+onValue.countryName);
        print("countryName"+countryName);
      });
    }
  }
  Future getStateName() async {
    tempStateBean = await
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => _myStateDialog,
          fullscreenDialog: true,
        ));
    if(tempStateBean!=null) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean
          .mbusstate = tempStateBean.stateCd;
      AppDatabase.get().getStateNameViaStateCode(
          tempStateBean.stateCd.toString()).then((onValue) {
        stateName = onValue.stateDesc;

      });
    }
  }
  Future getDistrictName() async {
    tempDistrictBean = await
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => _myDistrictDialog,
          fullscreenDialog: true,
        ));
    if(tempDistrictBean!=null) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean
          .mdistcd = tempDistrictBean.distCd;
      AppDatabase.get().getDistrictNameViaDistrictCode(
          tempDistrictBean.distCd.toString()).then((onValue) {
        districtName = onValue.distDesc;

      });
    }
  }
  Future getSubDistrictName() async {
    tempSubDistrictBean = await
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => _mySubDistrictDialog,
          fullscreenDialog: true,
        ));
    if(tempSubDistrictBean!=null) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean
          .mbuscity = tempSubDistrictBean.placeCd;
      AppDatabase.get().getPlaceNameViaPlaceCode(
          tempSubDistrictBean.placeCd.toString()).then((onValue) {
        subDistrictName = onValue.placeCdDesc;

      });
    }
  }
  Future getArea() async {
    tempAreaDistrict = await
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => _myAreaDialog,
          fullscreenDialog: true,
        ));
    if(tempAreaDistrict!=null) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean
          .mbusarea = tempAreaDistrict.areaCd;
      AppDatabase.get().getAreaNameViaAreaCode(
          tempAreaDistrict.areaCd.toString()).then((onValue) {
        areaName = onValue.areaDesc;

      });
    }
  }
}


