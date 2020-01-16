import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';

import '../../../translations.dart';

class ViewEquityDetails extends StatefulWidget {
  static const String routeName = '/material/data-table';


  @override
  _ViewEquityDetailsState createState() =>
      _ViewEquityDetailsState();
}

class _ViewEquityDetailsState
    extends State<ViewEquityDetails> {
  List<DataRow> _sampleDataRows = new List<DataRow>();
  List<DataColumn> _dataColumns = new List<DataColumn>();
  List<int> selectedIndex = new List<int>();
  List<String> equityDtlList ;
  var rows2;
  var cols2;

  @override
  void initState() {
    super.initState();
    List columnName = [
      "Equity",
      "Present Amt",
      "Next Month Amt"
    ];
    print("1");
    if (CustomerFormationMasterTabsState.custListBean.equityList ==
        null) {
      CustomerFormationMasterTabsState.custListBean.equityList = List();
    }

    print("2" + CustomerFormationMasterTabsState.custListBean.equityList
        .toString());
    if (CustomerFormationMasterTabsState.custListBean.equityList != null
        && CustomerFormationMasterTabsState.custListBean.equityList
            .isNotEmpty) {
      print("3");
      equityDtlList = new List<String>();

      for (int l = 0; l <
          CustomerFormationMasterTabsState.custListBean.equityList
              .length; l++) {
        print("1st loop");
        for (int i = 0; i <
            globals.dropDownCaptionValuesCodeKeysBusiness[0].length;
        i++) {
          print("2nd loop");

          if (int.parse(globals.dropDownCaptionValuesCodeKeysBusiness[0][i].mcode) ==
              CustomerFormationMasterTabsState.custListBean
                  .equityList[l].mequity) {
            print("matched");
            equityDtlList.add(
                globals.dropDownCaptionValuesCodeKeysBusiness[0][i]
                    .mcodedesc);
          }
        }
     print("Asset List is ${equityDtlList}");
      }
    }

    print("bahar");



    List<DataCell> _dataCells = ['A', 'B', 'C']
        .map((c) => DataCell(Text(c)))
        .toList();
    _sampleDataRows =
        [0, 1, 2].map((i) => DataRow(cells: _dataCells)).toList();
    _dataColumns = [0, 1, 2]
        .map((i) => DataColumn(label: Text(columnName[i])))
        .toList();
    getRow();
    cols2 = [
      new DataColumn(
        label: const Text('Equity'),
      ),
      new DataColumn(
        label: const Text('Present'),
      ),
      new DataColumn(
        label: const Text('Next Month'),
      ),
    ];
  }
  void getRow(){
    rows2 = new List.generate(
        CustomerFormationMasterTabsState.custListBean.equityList.length,
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
              new DataCell(new Text(equityDtlList==null?"":equityDtlList[a])),
              new DataCell(
                  new Text(CustomerFormationMasterTabsState.custListBean.equityList[a].mpresentamt.toString())),
              new DataCell(new Text(CustomerFormationMasterTabsState.custListBean.equityList[a].mnextmonthamount
                  .toString())),

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
            Translations.of(context).text('Equity_Detail'),
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
      CustomerFormationMasterTabsState.custListBean.equityList.removeAt(items);
    }
    selectedIndex.clear();
    setState(() {
      getRow();
    });
  }
}