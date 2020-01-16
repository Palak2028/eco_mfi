import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/ViewBusinessExpenditureDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/ViewHouseholdExpenditureDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/BusinessExpenditureDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerBusinessDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/FamilyDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/HouseholdExpenditureDetailsBean.dart';

import '../../../translations.dart';

class CustomerFormationExpenditureDetails extends StatefulWidget {
  CustomerFormationExpenditureDetails({Key key}) : super(key: key);

  static Container _get(Widget child,
          [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );

  @override
  _CustomerFormationExpenditureDetailsState createState() =>
      new _CustomerFormationExpenditureDetailsState();
}

class _CustomerFormationExpenditureDetailsState
    extends State<CustomerFormationExpenditureDetails> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  LookupBeanData businexpntype;
  LookupBeanData houshldexpntype;

  int count = 0;
  double totalIncome = 0.0;
  double totalBusinExp = 0.0;
  double totalHoushldExp = 0.0;
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
    super.initState();
    if( CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean==null){
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean= new CustomerBusinessDetailsBean();
    }



    if (CustomerFormationMasterTabsState.custListBean.familyDetailsList != null ){
      print("family list");
      print(CustomerFormationMasterTabsState.custListBean.familyDetailsList);
      for (int l = 0; l < CustomerFormationMasterTabsState.custListBean.familyDetailsList.length; l++) {
        print("income");
        print(l);
        //print(CustomerFormationMasterTabsState.custListBean.familyDetailsList[l].mincome);
        if(CustomerFormationMasterTabsState.custListBean.familyDetailsList[l].mincome==null){
          CustomerFormationMasterTabsState.custListBean.familyDetailsList[l].mincome =0;
        }
        totalIncome = totalIncome + CustomerFormationMasterTabsState.custListBean.familyDetailsList[l].mincome;
        //print("totalIncome -" + totalIncome.toString());
      }
      //fatrahai, getsync


      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mtotalmonthlyincome = totalIncome;
     // print("custListBean.customerBusinessDetailsBean.mtotalmonthlyincome -- " + CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mtotalmonthlyincome.toString());
    }

   /* print("andar121");
    print(CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mtotalmonthlyincome);
    print("andar122");*/
    //print(CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusinessexpense);
    if (CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mtotalmonthlyincome != 0.0 && CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mtotalmonthlyincome != null
    && CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusinessexpense != null) {
      print("andar11");
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome =
      (CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mtotalmonthlyincome -
          CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusinessexpense);
    }
    print("custListBean.customerBusinessDetailsBean.mmonthlyincome -- " + CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome.toString());

    print("andar131");
   // print(CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome);
    print("andar133");
    //print(CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mhousehldexpense);
    if (CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome != 0.0 && CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome != null
        && CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mhousehldexpense != null) {
      print("andar11");
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mnetamount =
      (CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome -
          CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mhousehldexpense);
    }

    //calculateBusinessExpense();
    //calculateHouseholdExpense();

    if (!isBool) {
      isBool = true;
    }

    if (CustomerFormationMasterTabsState.fdb != null) {
      for (int k = 0;
          k < globals.dropdownCaptionsValuesExpenseDetails.length;
          k++) {
        for (int i = 0;
            i < globals.dropdownCaptionsValuesExpenseDetails[k].length;
            i++) {
          if (k == 0) {
            print(
                "for k = 0 codes are ${globals.dropdownCaptionsValuesExpenseDetails[k][i].mcode}");
            if (globals.dropdownCaptionsValuesExpenseDetails[k][i].mcode ==
                CustomerFormationMasterTabsState.busiExpnBean.mbusinexpntype) {
              setValue(k, globals.dropdownCaptionsValuesExpenseDetails[k][i]);
            }
          }

          if (k == 1) {
            print(
                "for k = 1 codes are ${globals.dropdownCaptionsValuesExpenseDetails[k][i].mcode}");
            if (globals.dropdownCaptionsValuesExpenseDetails[k][i].mcode ==
                CustomerFormationMasterTabsState.hhExpnBean.mhoushldexpntype) {
              setValue(k, globals.dropdownCaptionsValuesExpenseDetails[k][i]);
            }
          }
        }
      }
    } else {
      CustomerFormationMasterTabsState.fdb = new FamilyDetailsBean();
    }
  }

  calculateBusinessExpense(){
    print("calculateBusinessExpense");
    totalBusinExp = 0.0;
    if (CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList != null ){
      print("business expense list");
      print(CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList);
      for (int l = 0; l < CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList.length; l++) {
        print("business expense");
        print(l);
        print(CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList[l].mbusinevaluationamt);
        totalBusinExp = totalBusinExp + CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList[l].mbusinevaluationamt;
        print("totalBusinExp -" + totalBusinExp.toString());
      }

      print("custListBean.customerBusinessDetailsBean.mbusinessexpense -- " + CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusinessexpense.toString());

      if (CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mtotalmonthlyincome != null) {
        double tempMonthlyIncome = (CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mtotalmonthlyincome -
            totalBusinExp);
        if(tempMonthlyIncome>0){
          CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusinessexpense = totalBusinExp;
          CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome = tempMonthlyIncome;
        }
        else{
          CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList.removeLast();
          globals.Dialog.alertPopup(context, "Error",
              "Expenditure should not be greater then income", "BusinessExpenditure");
          return;
        }
      /*CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome =
      (CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mtotalmonthlyincome -
          CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusinessexpense);*/
      }
      print("custListBean.customerBusinessDetailsBean.mmonthlyincome -- " + CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome.toString());
    }
  }

  calculateHouseholdExpense(){
    totalHoushldExp =0.0;
    print("calculateHouseholdExpense");
    if (CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList != null ){
      print("household expense list");
      print(CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList);
      for (int l = 0; l < CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList.length; l++) {
        print("household expense");
        print(l);
        print(CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList[l].mhoushldevaluationamt);
        totalHoushldExp = totalHoushldExp + CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList[l].mhoushldevaluationamt;
        print("totalHoushldExp -" + totalHoushldExp.toString());
      }

      print("custListBean.customerBusinessDetailsBean.mhousehldexpense -- " + CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mhousehldexpense.toString());
    }

    if (CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome != null) {
      double tempNetAmount =  (CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome -
          totalHoushldExp);
      if(tempNetAmount>0){
        CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mhousehldexpense = totalHoushldExp;
        CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mnetamount =
        (CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome -
            CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mhousehldexpense);

      }else{
        CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList.removeLast();
        globals.Dialog.alertPopup(context, "Error",
            "Expenditure should not be greater then income", "BusinessExpenditure");
        return;
      }
    }
    print("custListBean.customerBusinessDetailsBean.mnetamount -- " + CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mnetamount.toString());
  }

  Widget getTextContainer(String textValue) {
    return new Container(
      padding: EdgeInsets.fromLTRB(5.0, 20.0, 0.0, 20.0),
      child: new Text(
        textValue,
        textAlign: TextAlign.start,
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
    if (selectedObj.mcodedesc.isEmpty) {
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          businexpntype = blankBean;
          CustomerFormationMasterTabsState.busiExpnBean.mbusinexpntype = selectedObj.mcode;
          break;
        case 1:
          houshldexpntype = blankBean;
          CustomerFormationMasterTabsState.hhExpnBean.mhoushldexpntype =
              selectedObj.mcode;
          break;
        default:
          break;
      }
      setState(() {});
    } else {
      bool isBreak = false;
      for (int k = 0;
          k < globals.dropdownCaptionsValuesExpenseDetails[no].length;
          k++) {
        if (globals.dropdownCaptionsValuesExpenseDetails[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesExpenseDetails[no][k]);
          isBreak = true;
          break;
        }
        if (isBreak) {
          break;
        }
      }
    }
  }

  LookupBeanData blankBean =
      new LookupBeanData(mcodedesc: "", mcode: "", mcodetype: 0);

  setValue(int no, LookupBeanData value) {
    print("value is ${value}");
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          businexpntype = value;
          CustomerFormationMasterTabsState.busiExpnBean.mbusinexpntype = value.mcode;
          break;
        case 1:
          houshldexpntype = value;
          CustomerFormationMasterTabsState.hhExpnBean.mhoushldexpntype = value.mcode;
          break;
        default:
          break;
      }
    });
  }

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    print("caption value : " + globals.dropdownCaptionsExpenseDetails[no]);

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    bean.mcode = "";
    bean.mcodetype = 0;
    mapData.add(blankBean);
    for (int k = 0;
        k < globals.dropdownCaptionsValuesExpenseDetails[no].length;
        k++) {
      mapData.add(globals.dropdownCaptionsValuesExpenseDetails[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      print("data here is of  dropdownwale biayajai " + value.mcodedesc);
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc),
      );
    }).toList();
    return _dropDownMenuItems1;
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
            key: _formKey,
            onChanged: () {
              final FormState form = _formKey.currentState;
              form.save();
            },
            autovalidate: true,
            child: new ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[

                new Card(
                  child:new Column(children: <Widget>[
                    new Card(
                      child: new Text(Translations.of(context).text('Buss_Expense_Details')),
                    ),
                    new DropdownButtonFormField(
                      value: businexpntype == null ? null : businexpntype,
                      items: generateDropDown(0),
                      onChanged: (LookupBeanData newValue) {
                        print("new Value is ${newValue}");
                        showDropDown(newValue, 0);
                      },
                      validator: (args) {
                        print(args);
                      },
                      decoration: InputDecoration(
                          labelText: globals.dropdownCaptionsExpenseDetails[0]),
                    ),
                    new TextFormField(
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('Enter_Expense'),
                        labelText: Translations.of(context).text('Buss_Exp'),
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
                      controller:
                      CustomerFormationMasterTabsState.busiExpnBean.mbusinevaluationamt != null
                      &&CustomerFormationMasterTabsState.busiExpnBean.mbusinevaluationamt!=0.0&&
                          CustomerFormationMasterTabsState.busiExpnBean.mbusinevaluationamt!=00
                          ? TextEditingController(
                          text: CustomerFormationMasterTabsState.busiExpnBean.mbusinevaluationamt
                              .toString())
                          : TextEditingController(text: ""),
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(10),
                        globals.onlyDoubleNumber
                      ],
                      onSaved: (val) {
                        if (val != null && val != "") {
                          globals.income = double.parse(val);
                          CustomerFormationMasterTabsState.busiExpnBean.mbusinevaluationamt =
                              double.parse(val);
                        } else {
                          CustomerFormationMasterTabsState.busiExpnBean.mbusinevaluationamt = 0.0;
                        }
                      },
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
                new Container(
                  width: 300.0,
                  height: 10.0,
                ),
                new Card(
                  child:new Column(children: <Widget>[
                    new Card(
                      child: new Text(Translations.of(context).text('HouseHold_Expense_Details')),
                    ),
                    new DropdownButtonFormField(
                      value: houshldexpntype == null ? null : houshldexpntype,
                      items: generateDropDown(1),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue, 1);
                      },
                      validator: (args) {
                        print(args);
                      },
                      decoration: InputDecoration(
                          labelText: globals.dropdownCaptionsExpenseDetails[1]),
                    ),
                    new TextFormField(
                      decoration:  InputDecoration(
                        hintText: Translations.of(context).text('Enter_Expense'),
                        labelText: Translations.of(context).text('Household_Exp'),
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
                      controller:
                      CustomerFormationMasterTabsState.hhExpnBean.mhoushldevaluationamt != null
                          ? TextEditingController(
                          text: CustomerFormationMasterTabsState.hhExpnBean.mhoushldevaluationamt
                              .toString())
                          : TextEditingController(text: ""),
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(10),
                        globals.onlyDoubleNumber
                      ],
                      onSaved: (val) {
                        if (val != null && val != "") {
                          globals.income = double.parse(val);
                          CustomerFormationMasterTabsState.hhExpnBean.mhoushldevaluationamt =
                              double.parse(val);
                        } else {
                          CustomerFormationMasterTabsState.hhExpnBean.mhoushldevaluationamt = 0.0;
                        }
                      },
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
                              _navigateAndDisplaySelectionH(context);
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
                                  addToHouseholdList();
                                })),
                      ],
                    ),
                    new Container(
                      width: 300.0,
                      height: 10.0,
                    ),
                  ]),
                ),
                new Container(
                  width: 300.0,
                  height: 10.0,
                ),

                new Card(
                  child:new Column(children: <Widget>[

                    new Card(
                    child: new ListTile(
                    title: new Text(Translations.of(context).text('Monthly_Income_(A)')),
                    subtitle: CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mtotalmonthlyincome == null
                    ? new Text("")
                        : new Text("${CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mtotalmonthlyincome}"),
                    ),
                    ),
                    new Container(
                      width: 300.0,
                      height: 10.0,
                    ),
                    new Card(
                      child: new ListTile(
                        title: new Text(Translations.of(context).text('Buss_Exp_(B)')),
                        subtitle: CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusinessexpense == null
                            ? new Text("")
                            : new Text("${CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusinessexpense}"),
                      ),
                    ),
                    new Container(
                      width: 300.0,
                      height: 10.0,
                    ),
                    new Card(
                      child: new ListTile(
                        title: new Text(Translations.of(context).text('Household_Exp_(C)')),
                        subtitle: CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mhousehldexpense == null
                            ? new Text("")
                            : new Text("${CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mhousehldexpense}"),
                      ),
                    ),
                    new Container(
                      width: 300.0,
                      height: 10.0,
                    ),
                    new Card(
                      child: new ListTile(
                        title: new Text(Translations.of(context).text('Monthly_Income_(A-B)')),
                        subtitle: CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome == null
                            ? new Text("")
                            : new Text("${CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome}"),
                      ),
                    ),
                    new Container(
                      width: 300.0,
                      height: 10.0,
                    ),
                    new TextFormField(
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('Enter_Monthly_EMI'),
                        labelText: Translations.of(context).text('Monthly_EMI'),
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
                      controller:
                      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyemi != null
                          ? TextEditingController(
                          text: CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyemi
                              .toString())
                          : TextEditingController(text: ""),
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(10),
                        globals.onlyDoubleNumber
                      ],
                      onSaved: (val) {
                        if (val != null && val != "") {
                          globals.income = double.parse(val);
                          CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyemi =
                              double.parse(val);
                        } else {
                          CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyemi = 0.0;
                        }
                        print("Ratio");
                        print("mmonthlyemi-"+CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyemi.toString());
                        print("mmonthlyincome-"+CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome.toString());
                        if (CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome !=null && CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean
                            .mmonthlyemi != null) {

                          double tempincomeRatio =  double.parse(CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyemi.toStringAsFixed(2));

                          print("khatrre ki value from 1 ${CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyemi.toStringAsFixed(2)}" );
                          print("tempincomeratio ${tempincomeRatio}");
                          if(tempincomeRatio>0){
                            CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mincomeemiratio =
                                double.parse((CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome /
                                    CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyemi).toStringAsFixed(2));
                          }else{
                            CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mincomeemiratio =0;
                          }


                        }
                        print("mincomeemiratio-"+CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mincomeemiratio.toString());
                        print("mnetamount-"+CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mnetamount.toString());
                        if (CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mnetamount != null) {
                          print("khatrre ki value ${CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyemi.toStringAsFixed(2)}" );

                          CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mpercentage =
                              double.parse(((CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyemi /
                              CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mnetamount) * 100).toStringAsFixed(2));
                        }
                      },
                    ),
                    new Container(
                      width: 300.0,
                      height: 10.0,
                    ),
                    new Card(
                      child: new ListTile(
                        title: new Text(Translations.of(context).text('Income_EMI')),
                        subtitle: CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mincomeemiratio == null
                            ? new Text("")
                            : new Text("${CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mincomeemiratio}"),
                      ),
                    ),
                    new Container(
                      width: 300.0,
                      height: 10.0,
                    ),
                    new Card(
                      child: new ListTile(
                        title: new Text(Translations.of(context).text('Net_Amt')),
                        subtitle: CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mnetamount == null
                            ? new Text("")
                            : new Text("${CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mnetamount}"),
                      ),
                    ),
                    new Container(
                      width: 300.0,
                      height: 10.0,
                    ),
                    new Card(
                      child: new ListTile(
                        title: new Text(Translations.of(context).text('EMI_Amt')),
                        subtitle: CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mpercentage == null
                            ? new Text("")
                            : new Text("${CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mpercentage}"),
                      ),
                    ),
                  ]),
                ),
       ],
            )));
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              new ViewBusinessExpenditureDetails(),
          fullscreenDialog: true,
        )).then((onValue) {
      setState(() {});
    });
  }

  void addToList() {
    if (CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList ==
        null) {
      CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList =
          new List<BusinessExpenditureDetailsBean>();
    }

    if (CustomerFormationMasterTabsState.busiExpnBean.mbusinexpntype != null &&
        CustomerFormationMasterTabsState.busiExpnBean.mbusinexpntype != "null") {
      print("adding ${CustomerFormationMasterTabsState.busiExpnBean}");
      CustomerFormationMasterTabsState.busiExpnBean.trefno =
          CustomerFormationMasterTabsState.custListBean.trefno;
      if (CustomerFormationMasterTabsState.custListBean.mrefno == null)
        CustomerFormationMasterTabsState.busiExpnBean.mrefno = 0;
      else
        CustomerFormationMasterTabsState.busiExpnBean.mrefno =
            CustomerFormationMasterTabsState.custListBean.mrefno;

      CustomerFormationMasterTabsState.busiExpnBean.mbusinexpenrefno = 0;

      CustomerFormationMasterTabsState.busiExpnBean.tbusinexpendrefno =
          CustomerFormationMasterTabsState
                  .custListBean.businessExpendDetailsList.length +
              1;

      CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList
          .add(CustomerFormationMasterTabsState.busiExpnBean);

      businexpntype = blankBean;
      setState(() {
        print("set state business");
        CustomerFormationMasterTabsState.busiExpnBean = new BusinessExpenditureDetailsBean();
        calculateBusinessExpense();
      });
    } else {
      globals.Dialog.alertPopup(context, Translations.of(context).text('error'),
          Translations.of(context).text('Add_Exp'), Translations.of(context).text('Buss_Exp'));
    }
  }

  _navigateAndDisplaySelectionH(BuildContext context) async {
    final result = Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
          new ViewHouseholdExpenditureDetails(),
          fullscreenDialog: true,
        )).then((onValue) {
      setState(() {});
    });
  }

  void addToHouseholdList() {
    if (CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList ==
        null) {
      CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList =
      new List<HouseholdExpenditureDetailsBean>();
    }

    if (CustomerFormationMasterTabsState.hhExpnBean.mhoushldexpntype != null &&
        CustomerFormationMasterTabsState.hhExpnBean.mhoushldexpntype != "null") {
      print("adding ${CustomerFormationMasterTabsState.hhExpnBean}");
      CustomerFormationMasterTabsState.hhExpnBean.trefno =
          CustomerFormationMasterTabsState.custListBean.trefno;
      if (CustomerFormationMasterTabsState.custListBean.mrefno == null)
        CustomerFormationMasterTabsState.hhExpnBean.mrefno = 0;
      else
        CustomerFormationMasterTabsState.hhExpnBean.mrefno =
            CustomerFormationMasterTabsState.custListBean.mrefno;

      CustomerFormationMasterTabsState.hhExpnBean.mhoushldexpenrefno = 0;

      CustomerFormationMasterTabsState.hhExpnBean.thoushldexpendrefno =
          CustomerFormationMasterTabsState
              .custListBean.householdExpendDetailsList.length +
              1;

      CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList
          .add(CustomerFormationMasterTabsState.hhExpnBean);

      houshldexpntype = blankBean;

      setState(() {
        print("set state household");
        CustomerFormationMasterTabsState.hhExpnBean = new HouseholdExpenditureDetailsBean();
        calculateHouseholdExpense();
      });

    } else {
      globals.Dialog.alertPopup(context, Translations.of(context).text('error'),
          Translations.of(context).text('Add_Exp'), Translations.of(context).text('Buss_Exp'));
    }
  }

}

