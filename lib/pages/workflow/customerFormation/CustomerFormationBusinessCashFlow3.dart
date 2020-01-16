import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterFormationMasterListViewBean.dart';
import 'dart:async';

import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterFormationMasterSubmissionBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/CenterFormationSubmissionService.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/ViewCurrentAssetDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/ViewEquityDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/ViewFixedAssetDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/ViewLongTermLiabilityDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/ViewShortTermLiabilityDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CurrentAssetsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerBusinessDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/EquityBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/FixedAssetsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/LongTermLiabilitiesBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ShortTermLiabilitiesBean.dart';

class CustomerFormationBusinessCashFlow3 extends StatefulWidget {
  CustomerFormationBusinessCashFlow3({Key key}) : super(key: key);

  static Container _get(Widget child,
          [EdgeInsets pad = const EdgeInsets.all(1.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );

  @override
  _CustomerFormationBusinessCashFlow3State createState() =>
      new _CustomerFormationBusinessCashFlow3State();
}

class _CustomerFormationBusinessCashFlow3State
    extends State<CustomerFormationBusinessCashFlow3> {
  bool showAdvance = false;
  bool showAssets = false;
  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);
  List<FilterChip> filterChip = new List<FilterChip>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    print("checking for lookup business cash flow ");
    print(globals.dropDownCaptionValuesCodeKeysBusiness[no].length);
    mapData.add(blankBean);
    for (int k = 0;
    k < globals.dropDownCaptionValuesCodeKeysBusiness[no].length;
    k++) {
      mapData.add(globals.dropDownCaptionValuesCodeKeysBusiness[no][k]);
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

  LookupBeanData fixedAssets;
  LookupBeanData currentAssets;
  LookupBeanData longTermLiabilities;
  LookupBeanData shortTermLiabilities;
  LookupBeanData equity;



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
    for (int bussCashFlow = 0; bussCashFlow <
        CustomerFormationMasterTabsState.businessCashFlowRadios.length;
    bussCashFlow++) {
      if (CustomerFormationMasterTabsState
          .businessCashFlowRadios[bussCashFlow] == null)
        CustomerFormationMasterTabsState.businessCashFlowRadios[bussCashFlow] =
        0;
    }

    if (CustomerFormationMasterTabsState.custListBean
        .customerBusinessDetailsBean == null) {
      CustomerFormationMasterTabsState.custListBean
          .customerBusinessDetailsBean = new CustomerBusinessDetailsBean();
    }

/*    if (ifNullCheck(CustomerFormationMasterTabsState.custListBean
        .customerBusinessDetailsBean.mbusseasonalityjan)) {
      CustomerFormationMasterTabsState.businessCashFlowRadios[0] = 0;
    }else{*/
    if (!ifNullCheck(CustomerFormationMasterTabsState.custListBean
        .customerBusinessDetailsBean.mbusseasonalityjan)) {
      CustomerFormationMasterTabsState.businessCashFlowRadios[0] = int.parse(
          CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mbusseasonalityjan);
    }
    else{
      CustomerFormationMasterTabsState.custListBean
          .customerBusinessDetailsBean.mbusseasonalityjan = "0";
    }

    if (!ifNullCheck(CustomerFormationMasterTabsState.custListBean
        .customerBusinessDetailsBean.mbusseasonalityfeb)) {
      CustomerFormationMasterTabsState.businessCashFlowRadios[1] =
          int.parse(CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mbusseasonalityfeb);
    }
    else{
      CustomerFormationMasterTabsState.custListBean
          .customerBusinessDetailsBean.mbusseasonalityfeb = "0";
    }

    if (!ifNullCheck(CustomerFormationMasterTabsState.custListBean
        .customerBusinessDetailsBean.mbusseasonalitymar)) {
      CustomerFormationMasterTabsState.businessCashFlowRadios[2] =
          int.parse(CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mbusseasonalitymar);
    }
    else{
      CustomerFormationMasterTabsState.custListBean
          .customerBusinessDetailsBean.mbusseasonalitymar = "0";
    }
    if (!ifNullCheck(CustomerFormationMasterTabsState.custListBean
        .customerBusinessDetailsBean.mbusseasonalityapr)) {
      CustomerFormationMasterTabsState.businessCashFlowRadios[3] =
          int.parse(CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mbusseasonalityapr);
    }
    else{
      CustomerFormationMasterTabsState.custListBean
          .customerBusinessDetailsBean.mbusseasonalityapr = "0";
    }
    if (!ifNullCheck(CustomerFormationMasterTabsState.custListBean
        .customerBusinessDetailsBean.mbusseasonalitymay)) {
      CustomerFormationMasterTabsState.businessCashFlowRadios[4] =
          int.parse(CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mbusseasonalitymay);
    }
    else{
      CustomerFormationMasterTabsState.custListBean
          .customerBusinessDetailsBean.mbusseasonalitymay = "0";
    }
    if (!ifNullCheck(CustomerFormationMasterTabsState.custListBean
        .customerBusinessDetailsBean.mbusseasonalityjun)) {
      CustomerFormationMasterTabsState.businessCashFlowRadios[5] =
          int.parse(CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mbusseasonalityjun);
    }
    else{
      CustomerFormationMasterTabsState.custListBean
          .customerBusinessDetailsBean.mbusseasonalityjun = "0";
    }
    if (!ifNullCheck(CustomerFormationMasterTabsState.custListBean
        .customerBusinessDetailsBean.mbusseasonalityjul)) {
      CustomerFormationMasterTabsState.businessCashFlowRadios[6] =
          int.parse(CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mbusseasonalityjul);
    }
    else{
      CustomerFormationMasterTabsState.custListBean
          .customerBusinessDetailsBean.mbusseasonalityjul = "0";
    }
    if (!ifNullCheck(CustomerFormationMasterTabsState.custListBean
        .customerBusinessDetailsBean.mbusseasonalityaug)) {
      CustomerFormationMasterTabsState.businessCashFlowRadios[7] =
          int.parse(CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mbusseasonalityaug);
    }
    else{
      CustomerFormationMasterTabsState.custListBean
          .customerBusinessDetailsBean.mbusseasonalityaug = "0";
    }
    if (!ifNullCheck(CustomerFormationMasterTabsState.custListBean
        .customerBusinessDetailsBean.mbusseasonalitysep)) {
      CustomerFormationMasterTabsState.businessCashFlowRadios[8] =
          int.parse(CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mbusseasonalitysep);
    }
    else{
      CustomerFormationMasterTabsState.custListBean
          .customerBusinessDetailsBean.mbusseasonalitysep = "0";
    }
    if (!ifNullCheck(CustomerFormationMasterTabsState.custListBean
        .customerBusinessDetailsBean.mbusseasonalityoct)) {
      CustomerFormationMasterTabsState.businessCashFlowRadios[9] =
          int.parse(CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mbusseasonalityoct);
    }
    else{
      CustomerFormationMasterTabsState.custListBean
          .customerBusinessDetailsBean.mbusseasonalityoct = "0";
    }
    if (!ifNullCheck(CustomerFormationMasterTabsState.custListBean
        .customerBusinessDetailsBean.mbusseasonalitynov)) {
      CustomerFormationMasterTabsState.businessCashFlowRadios[10] =
          int.parse(CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mbusseasonalitynov);
    }
    else{
      CustomerFormationMasterTabsState.custListBean
          .customerBusinessDetailsBean.mbusseasonalitynov = "0";
    }
    if (!ifNullCheck(CustomerFormationMasterTabsState.custListBean
        .customerBusinessDetailsBean.mbusseasonalitydec)) {
      CustomerFormationMasterTabsState.businessCashFlowRadios[11] =
          int.parse(CustomerFormationMasterTabsState.custListBean
              .customerBusinessDetailsBean.mbusseasonalitydec);
    }
    else{
      CustomerFormationMasterTabsState.custListBean
          .customerBusinessDetailsBean.mbusseasonalitydec = "0";
    }

    List tempDropDownValues =  new List();
    tempDropDownValues.add(CustomerFormationMasterTabsState.fixedAssetBean.mfixedassets);
    tempDropDownValues.add(CustomerFormationMasterTabsState.currentAssetsBean.mcurrentassets);
    tempDropDownValues.add(CustomerFormationMasterTabsState.longTermLiabilitiesBean.mlngtrmliabilty);
    tempDropDownValues.add(CustomerFormationMasterTabsState.shortTermLiabilitiesBean.mshrttrmliabilty);
    tempDropDownValues.add(CustomerFormationMasterTabsState.equityBean.mequity);
    for (int k = 0;
    k < globals.dropDownCaptionValuesCodeKeysBusiness.length;
    k++) {
      for (int i = 0;
      i < globals.dropDownCaptionValuesCodeKeysBusiness[k].length;
      i++) {
        try {
          if (globals.dropDownCaptionValuesCodeKeysBusiness[k][i].mcode.toString().trim() ==
              tempDropDownValues[k].toString().trim()) {
            setValue(k, globals.dropDownCaptionValuesCodeKeysBusiness[k][i]);
          }
        }catch(_){
          print("Exception Occured");
        }
      }
    }

  }
  showDropDown(LookupBeanData selectedObj, int no) {

    if(selectedObj.mcodedesc.isEmpty){
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          fixedAssets = blankBean;
          CustomerFormationMasterTabsState.fixedAssetBean.mfixedassets = 0;
          break;
        case 1:
          currentAssets = blankBean;
          CustomerFormationMasterTabsState.currentAssetsBean.mcurrentassets = 0;
          break;
        case 2:
          longTermLiabilities = blankBean;
          CustomerFormationMasterTabsState.longTermLiabilitiesBean.mlngtrmliabilty = 0;
          break;
        case 3:
          shortTermLiabilities = blankBean;
          CustomerFormationMasterTabsState.shortTermLiabilitiesBean.mshrttrmliabilty = 0;
          break;
        case 4:
          equity = blankBean;
          CustomerFormationMasterTabsState.equityBean.mequity = 0;
          break;
        default:
          break;
      }
      setState(() {

      });
    }
    else{
      for (int k = 0;
      k < globals.dropDownCaptionValuesCodeKeysBusiness[no].length;
      k++) {
        if (globals.dropDownCaptionValuesCodeKeysBusiness[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropDownCaptionValuesCodeKeysBusiness[no][k]);
        }
      }
    }

  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          fixedAssets = value;
          CustomerFormationMasterTabsState.fixedAssetBean.mfixedassets = int.parse(value.mcode);
          break;
        case 1:
          currentAssets = value;
          CustomerFormationMasterTabsState.currentAssetsBean.mcurrentassets = int.parse(value.mcode);
          break;
        case 2:
          longTermLiabilities = value;
          CustomerFormationMasterTabsState.longTermLiabilitiesBean.mlngtrmliabilty = int.parse(value.mcode);
          break;
        case 3:
          shortTermLiabilities = value;
          CustomerFormationMasterTabsState.shortTermLiabilitiesBean.mshrttrmliabilty = int.parse(value.mcode);
          break;
        case 4:
          equity = value;
          CustomerFormationMasterTabsState.equityBean.mequity = int.parse(value.mcode);
          break;
        default:
          break;
      }
    });
  }


  Widget dummy() => CustomerFormationBusinessCashFlow3._get(new Row(
        children: _makeHead(3, globals.radioCaptionValuesBusinessCashflow, 0),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
      ));

  Widget jan() => CustomerFormationBusinessCashFlow3._get(new Row(
        children: _makeRadios(3, globals.radioCaptionValuesBusinessCashflow, 0),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));

  Widget feb() => CustomerFormationBusinessCashFlow3._get(new Row(
        children: _makeRadios(3, globals.radioCaptionValuesBusinessCashflow, 1),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));

  Widget mar() => CustomerFormationBusinessCashFlow3._get(new Row(
        children: _makeRadios(3, globals.radioCaptionValuesBusinessCashflow, 2),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));

  Widget apr() => CustomerFormationBusinessCashFlow3._get(new Row(
        children: _makeRadios(3, globals.radioCaptionValuesBusinessCashflow, 3),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));

  Widget may() => CustomerFormationBusinessCashFlow3._get(new Row(
        children: _makeRadios(3, globals.radioCaptionValuesBusinessCashflow, 4),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));

  Widget jun() => CustomerFormationBusinessCashFlow3._get(new Row(
        children: _makeRadios(3, globals.radioCaptionValuesBusinessCashflow, 5),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));

  Widget jul() => CustomerFormationBusinessCashFlow3._get(new Row(
        children: _makeRadios(3, globals.radioCaptionValuesBusinessCashflow, 6),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));

  Widget aug() => CustomerFormationBusinessCashFlow3._get(new Row(
        children: _makeRadios(3, globals.radioCaptionValuesBusinessCashflow, 7),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));

  Widget sep() => CustomerFormationBusinessCashFlow3._get(new Row(
        children: _makeRadios(3, globals.radioCaptionValuesBusinessCashflow, 8),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));

  Widget oct() => CustomerFormationBusinessCashFlow3._get(new Row(
        children: _makeRadios(3, globals.radioCaptionValuesBusinessCashflow, 9),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));

  Widget nov() => CustomerFormationBusinessCashFlow3._get(new Row(
        children:
            _makeRadios(3, globals.radioCaptionValuesBusinessCashflow, 10),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));

  Widget dec() => CustomerFormationBusinessCashFlow3._get(new Row(
        children:
            _makeRadios(3, globals.radioCaptionValuesBusinessCashflow, 11),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));

  List<Widget> _makeHead(int numberOfRadios, List textName, int position) {
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
              fontSize: 12.0,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
      ));
    }
    return radios;
  }

  List<Widget> _makeRadios(int numberOfRadios, List textName, int position) {
    List<Widget> radios = new List<Widget>();
    for (int i = 0; i < numberOfRadios; i++) {
      radios.add(new Row(
        children: <Widget>[
          new Radio(
            value: i,
            groupValue:CustomerFormationMasterTabsState.businessCashFlowRadios[position],
            onChanged: (selection) => _onRadioSelected(selection, position),
            activeColor:Color(0xff07426A),
          ),
        ],
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
      ));
    }
    return radios;
  }

  Widget getTextContainer(String textValue) {
    return new Container(
      padding: EdgeInsets.fromLTRB(3.0, 20.0, 0.0, 20.0),
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
    setState(() => CustomerFormationMasterTabsState.businessCashFlowRadios[position] = selection);


    setState(() => CustomerFormationMasterTabsState.businessCashFlowRadios[position] = selection);
    if (position == 0) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusseasonalityjan  =selection.toString();

    } else if (position == 1) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusseasonalityfeb  =selection.toString();

    } else if (position == 2) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusseasonalitymar=selection.toString().trim();

    }else if (position == 3) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusseasonalityapr  =selection.toString().trim();

    } else if (position == 4) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusseasonalitymay=selection.toString().trim();

    }else if (position == 5) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusseasonalityjun  =selection.toString().trim();

    } else if (position == 6) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusseasonalityjul=selection.toString().trim();

    }else if (position == 7) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusseasonalityaug  =selection.toString().trim();

    } else if (position == 8) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusseasonalitysep=selection.toString().trim();

    }else if (position == 9) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusseasonalityoct  =selection.toString().trim();

    } else if (position == 10) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusseasonalitynov=selection.toString().trim();

    } else if (position == 11) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusseasonalitydec=selection.toString().trim();

    }
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
          child:SingleChildScrollView(
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (showAdvance == false) {
                      setState(() {
                        showAdvance = true;
                      });
                    } else if (showAdvance == true) {
                      setState(() {
                        showAdvance = false;
                      });
                    }
                  },
                  child: new Card(
                    child: new ListTile(
                        title: new Text(
                          Translations.of(context).text('cashflow'),
                          style: TextStyle(fontSize: 25.0),
                        ),
                        subtitle: showAdvance == true
                            ? new Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: new Table(children: [
                                new TableRow(
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey, width: 0.1),
                                    ),
                                    children: [
                                      getTextContainer(Translations.of(context).text('month')),
                                      dummy(),
                                    ]),
                                new TableRow(
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey, width: 0.1),
                                    ),
                                    children: [
                                      getTextContainer(globals.radioCaptionBusinessCashflow[0]),
                                      jan(),
                                    ]),
                                new TableRow(
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey, width: 0.1),
                                    ),
                                    children: [
                                      getTextContainer(globals.radioCaptionBusinessCashflow[1]),
                                      feb(),
                                    ]),
                                new TableRow(
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey, width: 0.1),
                                    ),
                                    children: [
                                      getTextContainer(globals.radioCaptionBusinessCashflow[2]),
                                      mar(),
                                    ]),
                                new TableRow(
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey, width: 0.1),
                                    ),
                                    children: [
                                      getTextContainer(globals.radioCaptionBusinessCashflow[3]),
                                      apr(),
                                    ]),
                                new TableRow(
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey, width: 0.1),
                                    ),
                                    children: [
                                      getTextContainer(globals.radioCaptionBusinessCashflow[4]),
                                      may(),
                                    ]),
                                new TableRow(
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey, width: 0.1),
                                    ),
                                    children: [
                                      getTextContainer(globals.radioCaptionBusinessCashflow[5]),
                                      jun(),
                                    ]),
                                new TableRow(
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey, width: 0.1),
                                    ),
                                    children: [
                                      getTextContainer(globals.radioCaptionBusinessCashflow[6]),
                                      jul(),
                                    ]),
                                new TableRow(
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey, width: 0.1),
                                    ),
                                    children: [
                                      getTextContainer(globals.radioCaptionBusinessCashflow[7]),
                                      aug(),
                                    ]),
                                new TableRow(
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey, width: 0.1),
                                    ),
                                    children: [
                                      getTextContainer(globals.radioCaptionBusinessCashflow[8]),
                                      sep(),
                                    ]),
                                new TableRow(
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey, width: 0.1),
                                    ),
                                    children: [
                                      getTextContainer(globals.radioCaptionBusinessCashflow[9]),
                                      oct(),
                                    ]),
                                new TableRow(
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey, width: 0.1),
                                    ),
                                    children: [
                                      getTextContainer(
                                          globals.radioCaptionBusinessCashflow[10]),
                                      nov(),
                                    ]),
                                new TableRow(
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey, width: 0.1),
                                    ),
                                    children: [
                                      getTextContainer(
                                          globals.radioCaptionBusinessCashflow[11]),
                                      dec(),
                                    ]),
                              ]),
                            ),

                          ],
                        )
                            : null,
                        ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (showAssets == false) {
                      setState(() {
                        showAssets = true;
                      });
                    } else if (showAssets == true) {
                      setState(() {
                        showAssets = false;
                      });
                    }
                  },

                  child: new Form(
                      key: _formKey,
                      autovalidate: false,
                      onWillPop: () {
                        return Future(() => true);
                      },
                      onChanged: () async {
                        final FormState form = _formKey.currentState;
                        form.save();
                      },
                     child : new Column(
                          children: <Widget>[
                            new Card(
                              child: new ListTile(
                                title: new Text(
                                  Translations.of(context).text('Bal_Sheet'),
                                  style: TextStyle(fontSize: 25.0),
                                ),
                                subtitle: showAssets == false
                                    ? null
                                    : new Column(
                                  children: <Widget>[
                                    new Card(
                                      child:
                                    new Column(children: <Widget>[
                                      new Card(
                                        child: new Text(Translations.of(context).text('Fixed_Assets')),
                                      ),
                                      new DropdownButtonFormField(
                                        value: fixedAssets,
                                        items: generateDropDown(0),
                                        onChanged: (LookupBeanData newValue) {
                                          showDropDown(newValue, 0);
                                        },
                                        validator: (args) {
                                          print(args);
                                        },
                                        decoration: InputDecoration(labelText: Translations.of(context).text('Fixed_Assets')),
                                        // style: TextStyle(color: Colors.grey),
                                      ),
                                      new Container(
                                        width: 300.0,
                                        height: 10.0,
                                      ),
                                      new Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          new Container(
                                            width: 150.0,
                                            child: new TextFormField(
                                              controller:
                                              CustomerFormationMasterTabsState.fixedAssetBean.mpresentamt != null
                                                  ? TextEditingController(
                                                  text:CustomerFormationMasterTabsState.fixedAssetBean.mpresentamt
                                                      .toString())
                                                  : TextEditingController(
                                                  text: ""),
                                              onSaved: (String value) {
                                                try {
                                                  CustomerFormationMasterTabsState.fixedAssetBean.mpresentamt =
                                                      double.parse(value);
                                                } catch (_) {}

                                              },
                                              keyboardType: TextInputType
                                                  .numberWithOptions(),
                                              decoration: new InputDecoration(
                                                  border: new OutlineInputBorder(
                                                      borderSide: new BorderSide(
                                                          color: Colors.teal)),
                                                  hintText:
                                                  Translations.of(context).text('Enter_Present_Amt'),
                                                  labelText: Translations.of(context).text('Present_Amt'),
                                                  prefixText: '',
                                                  suffixText: '',
                                                  suffixStyle: const TextStyle(
                                                      color: Colors.green)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: new TextFormField(
                                              controller:
                                              CustomerFormationMasterTabsState.fixedAssetBean.mnextmonthamount != null
                                                  ? TextEditingController(
                                                  text:CustomerFormationMasterTabsState.fixedAssetBean.mnextmonthamount
                                                      .toString())
                                                  : TextEditingController(
                                                  text: ""),
                                              onSaved: (String value) {
                                                try {
                                                  CustomerFormationMasterTabsState.fixedAssetBean.mnextmonthamount =
                                                      double.parse(value);
                                                } catch (_) {}

                                              },
                                              keyboardType: TextInputType
                                                  .numberWithOptions(),
                                              decoration: new InputDecoration(
                                                  border: new OutlineInputBorder(
                                                      borderSide: new BorderSide(
                                                          color: Colors.teal)),
                                                  hintText:
                                                  Translations.of(context).text('Enter_Next_Month_Amt '),
                                                  labelText: Translations.of(context).text('Next_Month_Amt'),
                                                  prefixText: '',
                                                  suffixText: '',
                                                  suffixStyle: const TextStyle(
                                                      color: Colors.green)),
                                            ),
                                          )
                                        ],
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
                                                     addToList(context);
                                                  })),
                                        ],
                                      ),
                                      new Container(
                                        width: 300.0,
                                        height: 10.0,
                                      ),
                                    ]),
    ),
                                    new Card(
                                      child:new Column(children: <Widget>[
                                        new Card(
                                          child: new Text(Translations.of(context).text('Curr_Assets')),
                                        ),
                                        new DropdownButtonFormField(
                                          value: currentAssets,
                                          items: generateDropDown(1),
                                          onChanged: (LookupBeanData newValue) {
                                            showDropDown(newValue, 1);
                                          },
                                          validator: (args) {
                                            print(args);
                                          },
                                          decoration: InputDecoration(labelText: Translations.of(context).text('Curr_Assets')),
                                        ),
                                        new Container(
                                          width: 300.0,
                                          height: 10.0,
                                        ),
                                        new Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            new Container(
                                              width: 150.0,
                                              child: new TextFormField(
                                                controller:
                                                CustomerFormationMasterTabsState.currentAssetsBean.mpresentamt != null
                                                    ? TextEditingController(
                                                    text:CustomerFormationMasterTabsState.currentAssetsBean.mpresentamt
                                                        .toString())
                                                    : TextEditingController(
                                                    text: ""),
                                                onSaved: (String value) {
                                                  try {
                                                    CustomerFormationMasterTabsState.currentAssetsBean.mpresentamt =
                                                        double.parse(value);
                                                  } catch (_) {}

                                                },
                                                keyboardType: TextInputType
                                                    .numberWithOptions(),
                                                decoration: new InputDecoration(
                                                    border: new OutlineInputBorder(
                                                        borderSide: new BorderSide(
                                                            color: Colors.teal)),
                                                    hintText:
                                                    Translations.of(context).text('Enter_Present_Amt'),
                                                    labelText: Translations.of(context).text('Present_Amt'),
                                                    prefixText: '',
                                                    suffixText: '',
                                                    suffixStyle: const TextStyle(
                                                        color: Colors.green)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Container(
                                              width: 150.0,
                                              child: new TextFormField(
                                                controller:
                                                CustomerFormationMasterTabsState.currentAssetsBean.mnextmonthamount != null
                                                    ? TextEditingController(
                                                    text:CustomerFormationMasterTabsState.currentAssetsBean.mnextmonthamount
                                                        .toString())
                                                    : TextEditingController(
                                                    text: ""),
                                                onSaved: (String value) {
                                                  try {
                                                    CustomerFormationMasterTabsState.currentAssetsBean.mnextmonthamount =
                                                        double.parse(value);
                                                  } catch (_) {}

                                                },
                                                keyboardType: TextInputType
                                                    .numberWithOptions(),
                                                decoration: new InputDecoration(
                                                    border: new OutlineInputBorder(
                                                        borderSide: new BorderSide(
                                                            color: Colors.teal)),
                                                    hintText:
                                                    Translations.of(context).text('Enter_Next_Month_Amt '),
                                                    labelText: Translations.of(context).text('Next_Month_Amt'),
                                                    prefixText: '',
                                                    suffixText: '',
                                                    suffixStyle: const TextStyle(
                                                        color: Colors.green)),
                                              ),
                                            )
                                          ],
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
                                                  _navigateAndDisplayCurrentAsset(context);
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
                                                      addToListCurrentAsset(context);
                                                    })),
                                          ],
                                        ),
                                        new Container(
                                          width: 300.0,
                                          height: 10.0,
                                        ),
                                        //new Row(children: filterChip),
                                      ]),
                                    ),
                                    new Card(
                                      child:new Column(children: <Widget>[
                                        new Card(
                                          child: new Text(Translations.of(context).text('Long_Term_Liab')),
                                        ),
                                        new DropdownButtonFormField(
                                          value: longTermLiabilities,
                                          items: generateDropDown(2),
                                          onChanged: (LookupBeanData newValue) {
                                            showDropDown(newValue, 2);
                                          },
                                          validator: (args) {
                                            print(args);
                                          },
                                          decoration: InputDecoration(labelText:Translations.of(context).text('Long_Term_Liab')),
                                        ),
                                        new Container(
                                          width: 300.0,
                                          height: 10.0,
                                        ),
                                        new Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            new Container(
                                              width: 150.0,
                                              child: new TextFormField(
                                                controller:
                                                CustomerFormationMasterTabsState.longTermLiabilitiesBean.mpresentamt != null
                                                    ? TextEditingController(
                                                    text:CustomerFormationMasterTabsState.longTermLiabilitiesBean.mpresentamt
                                                        .toString())
                                                    : TextEditingController(
                                                    text: ""),
                                                onSaved: (String value) {
                                                  try {
                                                    CustomerFormationMasterTabsState.longTermLiabilitiesBean.mpresentamt =
                                                        double.parse(value);
                                                  } catch (_) {}

                                                },
                                                keyboardType: TextInputType
                                                    .numberWithOptions(),
                                                decoration: new InputDecoration(
                                                    border: new OutlineInputBorder(
                                                        borderSide: new BorderSide(
                                                            color: Colors.teal)),
                                                    hintText:
                                                    Translations.of(context).text('Enter_Present_Amt'),
                                                    labelText: Translations.of(context).text('Present_Amt'),
                                                    prefixText: '',
                                                    suffixText: '',
                                                    suffixStyle: const TextStyle(
                                                        color: Colors.green)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Container(
                                              width: 150.0,
                                              child: new TextFormField(
                                                controller:
                                                CustomerFormationMasterTabsState.longTermLiabilitiesBean.mnextmonthamount != null
                                                    ? TextEditingController(
                                                    text:CustomerFormationMasterTabsState.longTermLiabilitiesBean.mnextmonthamount
                                                        .toString())
                                                    : TextEditingController(
                                                    text: ""),
                                                onSaved: (String value) {
                                                  try {
                                                    CustomerFormationMasterTabsState.longTermLiabilitiesBean.mnextmonthamount =
                                                        double.parse(value);
                                                  } catch (_) {}

                                                },
                                                keyboardType: TextInputType
                                                    .numberWithOptions(),
                                                decoration: new InputDecoration(
                                                    border: new OutlineInputBorder(
                                                        borderSide: new BorderSide(
                                                            color: Colors.teal)),
                                                    hintText:
                                                    Translations.of(context).text('Enter_Next_Month_Amt '),
                                                    labelText: Translations.of(context).text('Next_Month_Amt'),
                                                    prefixText: '',
                                                    suffixText: '',
                                                    suffixStyle: const TextStyle(
                                                        color: Colors.green)),
                                              ),
                                            )
                                          ],
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
                                                  _navigateAndDisplayLngTrmLiability(context);
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
                                                      addToListLngTrmLiability(context);
                                                    })),
                                          ],
                                        ),
                                        new Container(
                                          width: 300.0,
                                          height: 10.0,
                                        ),
                                        //new Row(children: filterChip),
                                      ]),
                                    ),
                                    new Card(
                                      child:new Column(children: <Widget>[
                                        new Card(
                                          child: new Text(Translations.of(context).text('Short_Term_Liab')),
                                        ),
                                        new DropdownButtonFormField(
                                          value: shortTermLiabilities,
                                          items: generateDropDown(3),
                                          onChanged: (LookupBeanData newValue) {
                                            showDropDown(newValue, 3);
                                          },
                                          validator: (args) {
                                            print(args);
                                          },
                                          decoration: InputDecoration(labelText: Translations.of(context).text('Short_Term_Liab')),
                                        ),
                                        new Container(
                                          width: 300.0,
                                          height: 10.0,
                                        ),
                                        new Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            new Container(
                                              width: 150.0,
                                              child: new TextFormField(
                                                controller:
                                                CustomerFormationMasterTabsState.shortTermLiabilitiesBean.mpresentamt != null
                                                    ? TextEditingController(
                                                    text:CustomerFormationMasterTabsState.shortTermLiabilitiesBean.mpresentamt
                                                        .toString())
                                                    : TextEditingController(
                                                    text: ""),
                                                onSaved: (String value) {
                                                  try {
                                                    CustomerFormationMasterTabsState.shortTermLiabilitiesBean.mpresentamt =
                                                        double.parse(value);
                                                  } catch (_) {}

                                                },
                                                keyboardType: TextInputType
                                                    .numberWithOptions(),
                                                decoration: new InputDecoration(
                                                    border: new OutlineInputBorder(
                                                        borderSide: new BorderSide(
                                                            color: Colors.teal)),
                                                    hintText:
                                                    Translations.of(context).text('Enter_Present_Amt'),
                                                    labelText: Translations.of(context).text('Present_Amt'),
                                                    prefixText: '',
                                                    suffixText: '',
                                                    suffixStyle: const TextStyle(
                                                        color: Colors.green)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Container(
                                              width: 150.0,
                                              child: new TextFormField(
                                                controller:
                                                CustomerFormationMasterTabsState.shortTermLiabilitiesBean.mnextmonthamount != null
                                                    ? TextEditingController(
                                                    text:CustomerFormationMasterTabsState.shortTermLiabilitiesBean.mnextmonthamount
                                                        .toString())
                                                    : TextEditingController(
                                                    text: ""),
                                                onSaved: (String value) {
                                                  try {
                                                    CustomerFormationMasterTabsState.shortTermLiabilitiesBean.mnextmonthamount =
                                                        double.parse(value);
                                                  } catch (_) {}

                                                },
                                                keyboardType: TextInputType
                                                    .numberWithOptions(),
                                                decoration: new InputDecoration(
                                                    border: new OutlineInputBorder(
                                                        borderSide: new BorderSide(
                                                            color: Colors.teal)),
                                                    hintText:
                                                    Translations.of(context).text('Enter_Next_Month_Amt '),
                                                    labelText: Translations.of(context).text('Next_Month_Amt'),
                                                    prefixText: '',
                                                    suffixText: '',
                                                    suffixStyle: const TextStyle(
                                                        color: Colors.green)),
                                              ),
                                            )
                                          ],
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
                                                  _navigateAndDisplayShrtTrmLiability(context);
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
                                                      addToListShrtTrmLiability(context);
                                                    })),
                                          ],
                                        ),
                                        new Container(
                                          width: 300.0,
                                          height: 10.0,
                                        ),
                                        //new Row(children: filterChip),
                                      ]),
                                    ),
                                    new Card(
                                      child:new Column(children: <Widget>[
                                        new Card(
                                          child: new Text(Translations.of(context).text('equity')),
                                        ),
                                        new DropdownButtonFormField(
                                          value: equity,
                                          items: generateDropDown(4),
                                          onChanged: (LookupBeanData newValue) {
                                            showDropDown(newValue, 4);
                                          },
                                          validator: (args) {
                                            print(args);
                                          },
                                          decoration: InputDecoration(labelText: Translations.of(context).text('equity')),
                                          // style: TextStyle(color: Colors.grey),
                                        ),
                                        new Container(
                                          width: 300.0,
                                          height: 10.0,
                                        ),
                                        new Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            new Container(
                                              width: 150.0,
                                              child: new TextFormField(
                                                controller:
                                                CustomerFormationMasterTabsState.equityBean.mpresentamt != null
                                                    ? TextEditingController(
                                                    text:CustomerFormationMasterTabsState.equityBean.mpresentamt
                                                        .toString())
                                                    : TextEditingController(
                                                    text: ""),
                                                onSaved: (String value) {
                                                  try {
                                                    CustomerFormationMasterTabsState.equityBean.mpresentamt =
                                                        double.parse(value);
                                                  } catch (_) {}

                                                },
                                                keyboardType: TextInputType
                                                    .numberWithOptions(),
                                                decoration: new InputDecoration(
                                                    border: new OutlineInputBorder(
                                                        borderSide: new BorderSide(
                                                            color: Colors.teal)),
                                                    hintText:
                                                    Translations.of(context).text('Enter_Present_Amt'),
                                                    labelText: Translations.of(context).text('Present_Amt'),
                                                    prefixText: '',
                                                    suffixText: '',
                                                    suffixStyle: const TextStyle(
                                                        color: Colors.green)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Container(
                                              width: 150.0,
                                              child: new TextFormField(
                                                controller:
                                                CustomerFormationMasterTabsState.equityBean.mnextmonthamount != null
                                                    ? TextEditingController(
                                                    text:CustomerFormationMasterTabsState.equityBean.mnextmonthamount
                                                        .toString())
                                                    : TextEditingController(
                                                    text: ""),
                                                onSaved: (String value) {
                                                  try {
                                                    CustomerFormationMasterTabsState.equityBean.mnextmonthamount =
                                                        double.parse(value);
                                                  } catch (_) {}

                                                },
                                                keyboardType: TextInputType
                                                    .numberWithOptions(),
                                                decoration: new InputDecoration(
                                                    border: new OutlineInputBorder(
                                                        borderSide: new BorderSide(
                                                            color: Colors.teal)),
                                                    hintText:
                                                    Translations.of(context).text('Enter_Next_Month_Amt '),
                                                    labelText: Translations.of(context).text('Next_Month_Amt'),
                                                    prefixText: '',
                                                    suffixText: '',
                                                    suffixStyle: const TextStyle(
                                                        color: Colors.green)),
                                              ),
                                            )
                                          ],
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
                                                  _navigateAndDisplayEquity(context);
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
                                                      addToListEquity(context);
                                                    })),
                                          ],
                                        ),
                                        new Container(
                                          width: 300.0,
                                          height: 10.0,
                                        ),
                                        //new Row(children: filterChip),
                                      ]),
                                    ),
                                  ],
                                ),
                              ),

                            ),

                            //new Card(child: new Text("Income"),)
                          ])
                  ),

                ),

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
          new ViewFixedAssetDetails(),
          fullscreenDialog: true,
        )).then((onValue) {
      setState(() {});
    });
  }

  void addToList(BuildContext context) {
    if (CustomerFormationMasterTabsState.custListBean.fixedAssetsList ==
        null) {
      CustomerFormationMasterTabsState.custListBean.fixedAssetsList =
      new List<FixedAssetsBean>();
    }

    if (CustomerFormationMasterTabsState.fixedAssetBean.mfixedassets != null &&
        CustomerFormationMasterTabsState.fixedAssetBean.mfixedassets != "null") {
      print("adding ${CustomerFormationMasterTabsState.fixedAssetBean}");
      CustomerFormationMasterTabsState.fixedAssetBean.trefno =
          CustomerFormationMasterTabsState.custListBean.trefno;
      if (CustomerFormationMasterTabsState.custListBean.mrefno == null)
        CustomerFormationMasterTabsState.fixedAssetBean.mrefno = 0;
      else
        CustomerFormationMasterTabsState.fixedAssetBean.mrefno =
            CustomerFormationMasterTabsState.custListBean.mrefno;

      CustomerFormationMasterTabsState.fixedAssetBean.mfixedassetrefno = 0;

      CustomerFormationMasterTabsState.fixedAssetBean.tfixedassetrefno =
          CustomerFormationMasterTabsState
              .custListBean.fixedAssetsList.length +
              1;

      print(CustomerFormationMasterTabsState.fixedAssetBean);
      fixedAssets = blankBean;
      /*setState(() {

      });*/
      if(CustomerFormationMasterTabsState.custListBean.fixedAssetsList==null)
        CustomerFormationMasterTabsState.custListBean.fixedAssetsList = new List<FixedAssetsBean>();
      CustomerFormationMasterTabsState.custListBean.fixedAssetsList
          .add(CustomerFormationMasterTabsState.fixedAssetBean);
      print("added List is ${CustomerFormationMasterTabsState.custListBean.fixedAssetsList}");

      fixedAssets = blankBean;
      setState(() {
        print("set state asset");
        CustomerFormationMasterTabsState.fixedAssetBean = new FixedAssetsBean();
      });

    } else {
      globals.Dialog.alertPopup(context, Translations.of(context).text('error'),
          Translations.of(context).text('Pls_Add_Asset_Should_not_be_blank'), Translations.of(context).text('assetDetail'));
    }
  }

  _navigateAndDisplayCurrentAsset(BuildContext context) async {
    final result = Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
          new ViewCurrentAssetDetails(),
          fullscreenDialog: true,
        )).then((onValue) {
      setState(() {});
    });
  }

  void addToListCurrentAsset(BuildContext context) {
    if (CustomerFormationMasterTabsState.custListBean.currentAssetsList ==
        null) {
      CustomerFormationMasterTabsState.custListBean.currentAssetsList =
      new List<CurrentAssetsBean>();
    }

    if (CustomerFormationMasterTabsState.currentAssetsBean.mcurrentassets != null &&
        CustomerFormationMasterTabsState.currentAssetsBean.mcurrentassets != "null") {
      print("adding ${CustomerFormationMasterTabsState.currentAssetsBean}");
      CustomerFormationMasterTabsState.currentAssetsBean.trefno =
          CustomerFormationMasterTabsState.custListBean.trefno;
      if (CustomerFormationMasterTabsState.custListBean.mrefno == null)
        CustomerFormationMasterTabsState.currentAssetsBean.mrefno = 0;
      else
        CustomerFormationMasterTabsState.currentAssetsBean.mrefno =
            CustomerFormationMasterTabsState.custListBean.mrefno;

      CustomerFormationMasterTabsState.currentAssetsBean.mcurrentassetrefno = 0;

      CustomerFormationMasterTabsState.currentAssetsBean.tcurrentassetrefno =
          CustomerFormationMasterTabsState
              .custListBean.currentAssetsList.length +
              1;

      print(CustomerFormationMasterTabsState.currentAssetsBean);
      currentAssets = blankBean;
      /*setState(() {

      });*/
      if(CustomerFormationMasterTabsState.custListBean.currentAssetsList==null)
        CustomerFormationMasterTabsState.custListBean.currentAssetsList = new List<CurrentAssetsBean>();
      CustomerFormationMasterTabsState.custListBean.currentAssetsList
          .add(CustomerFormationMasterTabsState.currentAssetsBean);
      print("added List is ${CustomerFormationMasterTabsState.custListBean.currentAssetsList}");

      currentAssets = blankBean;
      setState(() {
        print("set state asset");
        CustomerFormationMasterTabsState.currentAssetsBean = new CurrentAssetsBean();
      });

    } else {
      globals.Dialog.alertPopup(context,Translations.of(context).text('error'),
          Translations.of(context).text('Pls_Add_Asset_Should_not_be_blank'), Translations.of(context).text('assetDetail'));
    }
  }

  _navigateAndDisplayLngTrmLiability(BuildContext context) async {
    final result = Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
          new ViewLongTermLiabilityDetails(),
          fullscreenDialog: true,
        )).then((onValue) {
      setState(() {});
    });
  }

  void addToListLngTrmLiability(BuildContext context) {
    if (CustomerFormationMasterTabsState.custListBean.longTermLiabilitiesList ==
        null) {
      CustomerFormationMasterTabsState.custListBean.longTermLiabilitiesList =
      new List<LongTermLiabilitiesBean>();
    }

    if (CustomerFormationMasterTabsState.longTermLiabilitiesBean.mlngtrmliabilty != null &&
        CustomerFormationMasterTabsState.longTermLiabilitiesBean.mlngtrmliabilty != "null") {
      print("adding ${CustomerFormationMasterTabsState.longTermLiabilitiesBean}");
      CustomerFormationMasterTabsState.longTermLiabilitiesBean.trefno =
          CustomerFormationMasterTabsState.custListBean.trefno;
      if (CustomerFormationMasterTabsState.custListBean.mrefno == null)
        CustomerFormationMasterTabsState.longTermLiabilitiesBean.mrefno = 0;
      else
        CustomerFormationMasterTabsState.longTermLiabilitiesBean.mrefno =
            CustomerFormationMasterTabsState.custListBean.mrefno;

      CustomerFormationMasterTabsState.longTermLiabilitiesBean.mlngtrmliabiltyrefno = 0;

      CustomerFormationMasterTabsState.longTermLiabilitiesBean.tlngtrmliabiltyrefno =
          CustomerFormationMasterTabsState
              .custListBean.longTermLiabilitiesList.length +
              1;

      print(CustomerFormationMasterTabsState.longTermLiabilitiesBean);
      longTermLiabilities = blankBean;
      /*setState(() {

      });*/
      if(CustomerFormationMasterTabsState.custListBean.longTermLiabilitiesList==null)
        CustomerFormationMasterTabsState.custListBean.longTermLiabilitiesList = new List<LongTermLiabilitiesBean>();
      CustomerFormationMasterTabsState.custListBean.longTermLiabilitiesList
          .add(CustomerFormationMasterTabsState.longTermLiabilitiesBean);
      print("added List is ${CustomerFormationMasterTabsState.custListBean.longTermLiabilitiesList}");

      longTermLiabilities = blankBean;
      setState(() {
        print("set state asset");
        CustomerFormationMasterTabsState.longTermLiabilitiesBean = new LongTermLiabilitiesBean();
      });

    } else {
      globals.Dialog.alertPopup(context, "Error",
          "Please Add Liability, It should not be blank", "AssetDetail");
    }
  }

  _navigateAndDisplayShrtTrmLiability(BuildContext context) async {
    final result = Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
          new ViewShortTermLiabilityDetails(),
          fullscreenDialog: true,
        )).then((onValue) {
      setState(() {});
    });
  }

  void addToListShrtTrmLiability(BuildContext context) {
    if (CustomerFormationMasterTabsState.custListBean.shortTermLiabilitiesList ==
        null) {
      CustomerFormationMasterTabsState.custListBean.shortTermLiabilitiesList =
      new List<ShortTermLiabilitiesBean>();
    }

    if (CustomerFormationMasterTabsState.shortTermLiabilitiesBean.mshrttrmliabilty != null &&
        CustomerFormationMasterTabsState.shortTermLiabilitiesBean.mshrttrmliabilty != "null") {
      print("adding ${CustomerFormationMasterTabsState.shortTermLiabilitiesBean}");
      CustomerFormationMasterTabsState.shortTermLiabilitiesBean.trefno =
          CustomerFormationMasterTabsState.custListBean.trefno;
      if (CustomerFormationMasterTabsState.custListBean.mrefno == null)
        CustomerFormationMasterTabsState.shortTermLiabilitiesBean.mrefno = 0;
      else
        CustomerFormationMasterTabsState.shortTermLiabilitiesBean.mrefno =
            CustomerFormationMasterTabsState.custListBean.mrefno;

      CustomerFormationMasterTabsState.shortTermLiabilitiesBean.mshrttrmliabiltyrefno = 0;

      CustomerFormationMasterTabsState.shortTermLiabilitiesBean.tshrttrmliabiltyrefno =
          CustomerFormationMasterTabsState
              .custListBean.shortTermLiabilitiesList.length +
              1;

      print(CustomerFormationMasterTabsState.shortTermLiabilitiesBean);
      shortTermLiabilities = blankBean;
      /*setState(() {

      });*/
      if(CustomerFormationMasterTabsState.custListBean.shortTermLiabilitiesList==null)
        CustomerFormationMasterTabsState.custListBean.shortTermLiabilitiesList = new List<ShortTermLiabilitiesBean>();
      CustomerFormationMasterTabsState.custListBean.shortTermLiabilitiesList
          .add(CustomerFormationMasterTabsState.shortTermLiabilitiesBean);
      print("added List is ${CustomerFormationMasterTabsState.custListBean.shortTermLiabilitiesList}");

      shortTermLiabilities = blankBean;
      setState(() {
        print("set state asset");
        CustomerFormationMasterTabsState.shortTermLiabilitiesBean = new ShortTermLiabilitiesBean();
      });

    } else {
      globals.Dialog.alertPopup(context, Translations.of(context).text('error'),
          Translations.of(context).text('Pls_Add_Liab_should_not_be_blank'), Translations.of(context).text('assetDetail'));
    }
  }

  _navigateAndDisplayEquity(BuildContext context) async {
    final result = Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
          new ViewEquityDetails(),
          fullscreenDialog: true,
        )).then((onValue) {
      setState(() {});
    });
  }

  void addToListEquity(BuildContext context) {
    if (CustomerFormationMasterTabsState.custListBean.equityList ==
        null) {
      CustomerFormationMasterTabsState.custListBean.equityList =
      new List<EquityBean>();
    }

    if (CustomerFormationMasterTabsState.equityBean.mequity != null &&
        CustomerFormationMasterTabsState.equityBean.mequity != "null") {
      print("adding ${CustomerFormationMasterTabsState.equityBean}");
      CustomerFormationMasterTabsState.equityBean.trefno =
          CustomerFormationMasterTabsState.custListBean.trefno;
      if (CustomerFormationMasterTabsState.custListBean.mrefno == null)
        CustomerFormationMasterTabsState.equityBean.mrefno = 0;
      else
        CustomerFormationMasterTabsState.equityBean.mrefno =
            CustomerFormationMasterTabsState.custListBean.mrefno;

      CustomerFormationMasterTabsState.equityBean.mequityrefno = 0;

      CustomerFormationMasterTabsState.equityBean.tequityrefno =
          CustomerFormationMasterTabsState
              .custListBean.equityList.length +
              1;

      print(CustomerFormationMasterTabsState.equityBean);
      fixedAssets = blankBean;
      /*setState(() {

      });*/
      if(CustomerFormationMasterTabsState.custListBean.equityList==null)
        CustomerFormationMasterTabsState.custListBean.equityList = new List<EquityBean>();
      CustomerFormationMasterTabsState.custListBean.equityList
          .add(CustomerFormationMasterTabsState.equityBean);
      print("added List is ${CustomerFormationMasterTabsState.custListBean.equityList}");

      fixedAssets = blankBean;
      setState(() {
        print("set state asset");
        CustomerFormationMasterTabsState.equityBean = new EquityBean();
      });

    } else {
      globals.Dialog.alertPopup(context, Translations.of(context).text('error'),
          Translations.of(context).text('Pls_Add_Equity_should_not_be_blank'), Translations.of(context).text('assetDetail'));
    }
  }

   getChips(){
    filterChip.add(FilterChip(
      label: Text("text"),
      backgroundColor: Colors.transparent,
      shape: StadiumBorder(side: BorderSide()),
      onSelected: (bool value) {print("selected");},
    ));
    setState(() {

    });
  }


 /* @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
         Center(
              child: new Table(children: [
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer('Month'),
                      dummy(),
                    ]),
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer(globals.radioCaptionBusinessCashflow[0]),
                      jan(),
                    ]),
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer(globals.radioCaptionBusinessCashflow[1]),
                      feb(),
                    ]),
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer(globals.radioCaptionBusinessCashflow[2]),
                      mar(),
                    ]),
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer(globals.radioCaptionBusinessCashflow[3]),
                      apr(),
                    ]),
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer(globals.radioCaptionBusinessCashflow[4]),
                      may(),
                    ]),
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer(globals.radioCaptionBusinessCashflow[5]),
                      jun(),
                    ]),
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer(globals.radioCaptionBusinessCashflow[6]),
                      jul(),
                    ]),
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer(globals.radioCaptionBusinessCashflow[7]),
                      aug(),
                    ]),
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer(globals.radioCaptionBusinessCashflow[8]),
                      sep(),
                    ]),
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer(globals.radioCaptionBusinessCashflow[9]),
                      oct(),
                    ]),
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer(
                          globals.radioCaptionBusinessCashflow[10]),
                      nov(),
                    ]),
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer(
                          globals.radioCaptionBusinessCashflow[11]),
                      dec(),
                    ]),
              ]),
            ),

        ],
      ),
    );
  }*/
}
