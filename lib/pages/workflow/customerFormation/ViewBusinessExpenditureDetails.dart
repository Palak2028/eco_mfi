import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';

import '../../../translations.dart';

class ViewBusinessExpenditureDetails extends StatefulWidget {
  static const String routeName = '/material/data-table';


  @override
  _ViewBusinessExpenditureDetailsState createState() =>
      _ViewBusinessExpenditureDetailsState();
}

class _ViewBusinessExpenditureDetailsState
    extends State<ViewBusinessExpenditureDetails> {
  List<DataRow> _sampleDataRows = new List<DataRow>();
  List<DataColumn> _dataColumns = new List<DataColumn>();
  List<int> selectedIndex = new List<int>();
  List<List<String>> businExpendList ;
  var rows2;
  var cols2;

  @override
  void initState() {
    super.initState();
    List columnName = [
      "Expenditure",
      "Evaluation"
    ];

    if(CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList == null){
      CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList =List();
    }

    if(CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList!= null) {
      if (CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList
          .isNotEmpty) {
        businExpendList = new List<List<String>>();
        for (int l = 0; l <
            CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList
                .length; l++) {
          List<String> tempList = new List<String>(3);

          for (int k = 0; k < globals.dropdownCaptionsExpenseDetails.length;
          k++) {
            for (int i = 0; i <
                globals.dropdownCaptionsValuesExpenseDetails[k].length; i++) {
              if (k == 0) {
                print("for k = 0 codes are ${globals
                    .dropdownCaptionsValuesExpenseDetails[k][i].mcode}");
                if (globals.dropdownCaptionsValuesExpenseDetails[k][i].mcode ==
                    CustomerFormationMasterTabsState.custListBean
                        .businessExpendDetailsList[l].mbusinexpntype) {
                  tempList[0] =
                      globals.dropdownCaptionsValuesExpenseDetails[k][i].mcodedesc;
                }
              }
            }
          }
          businExpendList.add(tempList);
        }
        print("Business Expenditure List is ${businExpendList}");
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
        CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList.length,
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
              new DataCell(new Text(businExpendList[a][0]==null?"":businExpendList[a][0])),
              new DataCell(
                  new Text(CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList[a].mbusinevaluationamt.toString()=="0.0"?"":
                  CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList[a].mbusinevaluationamt.toString()
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
            Translations.of(context).text('Buss_Exp'),
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
      CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList.removeAt(items);
    }
    selectedIndex.clear();
    calculateBusinessExpense();
    setState(() {
      getRow();
    });
  }


  calculateBusinessExpense(){
    print("in delete calculateBusinessExpense");
    double totalBusinExp = 0.0;
    if (CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList != null ){
      print("in delete business expense list");
      print(CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList);
      for (int l = 0; l < CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList.length; l++) {
        print("in delete business expense");
        print(l);
        print(CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList[l].mbusinevaluationamt);
        totalBusinExp = totalBusinExp + CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList[l].mbusinevaluationamt;
        print("in delete totalBusinExp -" + totalBusinExp.toString());
      }
      CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusinessexpense = totalBusinExp;
      print("in delete custListBean.customerBusinessDetailsBean.mbusinessexpense -- " + CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusinessexpense.toString());

      if (CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mtotalmonthlyincome != null) {
        CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome =
        (CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mtotalmonthlyincome -
            CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mbusinessexpense);
      }
      print("in delete custListBean.customerBusinessDetailsBean.mmonthlyincome -- " + CustomerFormationMasterTabsState.custListBean.customerBusinessDetailsBean.mmonthlyincome.toString());
    }
  }
}