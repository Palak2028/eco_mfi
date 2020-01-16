import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';

import '../../../translations.dart';

class ViewHouseholdExpenditureDetails extends StatefulWidget {
  static const String routeName = '/material/data-table';


  @override
  _ViewHouseholdExpenditureDetailsState createState() =>
      _ViewHouseholdExpenditureDetailsState();
}

class _ViewHouseholdExpenditureDetailsState
    extends State<ViewHouseholdExpenditureDetails> {
  List<DataRow> _sampleDataRows = new List<DataRow>();
  List<DataColumn> _dataColumns = new List<DataColumn>();
  List<int> selectedIndex = new List<int>();
  List<List<String>> houshldExpendList ;
  var rows2;
  var cols2;

  @override
  void initState() {
    super.initState();
    List columnName = [
      "Expenditure",
      "Evaluation"
    ];

    if(CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList == null){
      CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList =List();
    }

    print("household expense");
    print(CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList);

    if(CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList!= null) {
      if (CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList
          .isNotEmpty) {
        houshldExpendList = new List<List<String>>();
        for (int l = 0; l <
            CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList
                .length; l++) {
          List<String> tempList = new List<String>(3);

          for (int k = 0; k < globals.dropdownCaptionsExpenseDetails.length;
          k++) {
            for (int i = 0; i <
                globals.dropdownCaptionsValuesExpenseDetails[k].length; i++) {
              if (k == 1) {
                print("for k = 0 codes are ${globals
                    .dropdownCaptionsValuesExpenseDetails[k][i].mcode}");
                if (globals.dropdownCaptionsValuesExpenseDetails[k][i].mcode ==
                    CustomerFormationMasterTabsState.custListBean
                        .householdExpendDetailsList[l].mhoushldexpntype) {
                  tempList[0] =
                      globals.dropdownCaptionsValuesExpenseDetails[k][i].mcodedesc;
                }
              }
            }
          }
          houshldExpendList.add(tempList);
        }
        print("Household Expenditure List is ${houshldExpendList}");
      }
    }

    List<DataCell> _dataCells = ['A', 'B']
        .map((c) => DataCell(Text(c)))
        .toList();
    _sampleDataRows =
        [0, 1].map((i) => DataRow(cells: _dataCells)).toList();
    _dataColumns = [0, 1]
        .map((i) => DataColumn(label: Text(columnName[i])))
        .toList();
    getRow();
    cols2 = [
      new DataColumn(
        label: const Text('Expenditure'),
      ),
      new DataColumn(
        label: const Text('Evaluation'),
      ),
    ];
  }
  void getRow(){
    rows2 = new List.generate(
        CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList.length,
            (int a) => new DataRow(
            selected:selectedIndex.contains(a)?true:false,
            onSelectChanged: (val){
              getRow();
              if(selectedIndex.contains(a)){
                print("a is there");
                selectedIndex.remove(a);
              }
              else{
                print("adding a");
                selectedIndex.add(a);
              }
              print("${a}  bool is ${val}");
              setState(() {
                getRow();
              });
            },
            cells: [
              new DataCell(new Text(houshldExpendList[a][0]==null?"":houshldExpendList[a][0])),
              new DataCell(
                  new Text(CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList[a].mhoushldevaluationamt.toString()=="0.0"?"":
                  CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList[a].mhoushldevaluationamt.toString()
                  )),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          elevation: 3.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          title: new Text(
            Translations.of(context).text('Household_Exp'),
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            new IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 22.0,
                ),
                onPressed: deleteSelected),
          ],
        ),
        body: ListView(padding: EdgeInsets.all(20.0), children: <Widget>[
          SingleChildScrollView(

            scrollDirection: Axis.horizontal,
            child: DataTable(
              rows: rows2,
              columns: cols2,
            ),
          ),
        ]),
      ),
    );
  }
  void deleteSelected(){

    for( var items in selectedIndex){
      CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList.removeAt(items);
    }
    selectedIndex.clear();
    calculateHouseholdExpense();
    setState(() {
      getRow();
    });
  }

  calculateHouseholdExpense(){
    double totalHoushldExp =0.0;
    print("in delete calculateHouseholdExpense");
    if (CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList != null ){
      print("in delete household expense list");
      print(CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList);
      for (int l = 0; l < CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList.length; l++) {
        print("in delete household expense");
        print(l);
        print(CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList[l].mhoushldevaluationamt);
        totalHoushldExp = totalHoushldExp + CustomerFormationMasterTabsState.custListBean.householdExpendDetailsList[l].mhoushldevaluationamt;
        print("in delete totalHoushldExp -" + totalHoushldExp.toString());
      }
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mhousehldexpense = totalHoushldExp;
      print("in delete custListBean.customerBusinessDetailsBean.mhousehldexpense -- " + CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mhousehldexpense.toString());
    }

    if (CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome != null) {
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mnetamount =
      (CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome -
          CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mhousehldexpense);
    }
    print("in delete custListBean.customerBusinessDetailsBean.mnetamount -- " + CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mnetamount.toString());
  }

}
