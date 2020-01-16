import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';

import '../../../translations.dart';

class ViewBorrowingDetails extends StatefulWidget {
  static const String routeName = '/material/data-table';

  @override
  _ViewBorrowingDetailsState createState() => _ViewBorrowingDetailsState();
}

class _ViewBorrowingDetailsState extends State<ViewBorrowingDetails> {
  List<DataRow> _sampleDataRows = new List<DataRow>();
  List<DataColumn> _dataColumns = new List<DataColumn>();
  var rows2;
  var cols2;
  List<int> selectedIndex = new List<int>();

  @override
  void initState() {
    super.initState();
    List columnName = [
      "Family Member",
      "Age",
      "Education",
      "RelationShip",
      "Occupation",
      "income",
      "Dependant"
    ];
    if(CustomerFormationMasterTabsState.custListBean.borrowingDetailsBean == null){
      CustomerFormationMasterTabsState.custListBean.borrowingDetailsBean =List();
    }
    List<DataCell> _dataCells = ['A', 'B', 'C', 'D', 'E', 'F', 'G']
        .map((c) => DataCell(Text(c)))
        .toList();
    _sampleDataRows =
        [0, 1, 2, 3, 4, 5, 6].map((i) => DataRow(cells: _dataCells)).toList();
    _dataColumns = [0, 1, 2, 3, 4, 5, 6]
        .map((i) => DataColumn(label: Text(columnName[i])))
        .toList();
    for (var items in CustomerFormationMasterTabsState.custListBean.borrowingDetailsBean) {}
    getRow();
    cols2 = [
      new DataColumn(
        label: const Text('Loan Number'),
      ),
      new DataColumn(
        label: const Text('Name'),
      ),
      new DataColumn(
        label: const Text('Loan Amount'),
      ),
      new DataColumn(
        label: const Text('Loan Date'),
      ),
      new DataColumn(
        label: const Text('Oustanding amount'),
      ),
      new DataColumn(
        label: const Text('Current loan with us'),
      ),
      new DataColumn(
        label: const Text('Repayment date'),
      )
    ];
  }

  getRow(){
    rows2 = new List.generate(
        CustomerFormationMasterTabsState.custListBean.borrowingDetailsBean.length,
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
              new DataCell(
            CustomerFormationMasterTabsState.custListBean.borrowingDetailsBean[a].mloancycle!=null?
                  new Text(
            CustomerFormationMasterTabsState.custListBean.borrowingDetailsBean[a].mloancycle.toString()):new Text("")),
              new DataCell(
                  new Text(CustomerFormationMasterTabsState.custListBean.borrowingDetailsBean[a].mnameofborrower.toString())),
              new DataCell(new Text(
                  CustomerFormationMasterTabsState.custListBean.borrowingDetailsBean[a].mamount.toString())),
              new DataCell(new Text("${CustomerFormationMasterTabsState.custListBean.borrowingDetailsBean[a].mloanDate}")),
              new DataCell(
                  new Text(CustomerFormationMasterTabsState.custListBean.borrowingDetailsBean[a].moutstandingamt.toString())),
              new DataCell(new Text(CustomerFormationMasterTabsState.custListBean.borrowingDetailsBean[a].mloanwthUs
                  .toString())),
              new DataCell(CustomerFormationMasterTabsState.custListBean.borrowingDetailsBean[a].mrepaymentDate!=null?
                  new Text(CustomerFormationMasterTabsState.custListBean.borrowingDetailsBean[a].mrepaymentDate.toString()):new Text("")),
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
              Translations.of(context).text('Borrow_Loan_list'),
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
            child:
            DataTable(
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
      CustomerFormationMasterTabsState.custListBean.borrowingDetailsBean.removeAt(items);
  }

  selectedIndex.clear();


  setState(() {
    getRow();
  });

  }
}
