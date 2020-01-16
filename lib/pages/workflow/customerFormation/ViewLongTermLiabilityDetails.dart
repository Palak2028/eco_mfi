import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';

import '../../../translations.dart';

class ViewLongTermLiabilityDetails extends StatefulWidget {
  static const String routeName = '/material/data-table';


  @override
  _ViewLongTermLiabilityDetailsState createState() =>
      _ViewLongTermLiabilityDetailsState();
}

class _ViewLongTermLiabilityDetailsState
    extends State<ViewLongTermLiabilityDetails> {
  List<DataRow> _sampleDataRows = new List<DataRow>();
  List<DataColumn> _dataColumns = new List<DataColumn>();
  List<int> selectedIndex = new List<int>();
  List<String> liabilityDtlList ;
  var rows2;
  var cols2;

  @override
  void initState() {
    super.initState();
    List columnName = [
      "Liability",
      "Present Amt",
      "Next Month Amt"
    ];
    print("1");
    if (CustomerFormationMasterTabsState.custListBean.longTermLiabilitiesList ==
        null) {
      CustomerFormationMasterTabsState.custListBean.longTermLiabilitiesList = List();
    }

    print("2" + CustomerFormationMasterTabsState.custListBean.longTermLiabilitiesList
        .toString());
    if (CustomerFormationMasterTabsState.custListBean.longTermLiabilitiesList != null
        && CustomerFormationMasterTabsState.custListBean.longTermLiabilitiesList
            .isNotEmpty) {
      print("3");
      liabilityDtlList = new List<String>();

      for (int l = 0; l <
          CustomerFormationMasterTabsState.custListBean.longTermLiabilitiesList
              .length; l++) {
        print("1st loop");
        for (int i = 0; i <
            globals.dropDownCaptionValuesCodeKeysBusiness[2].length;
        i++) {
          print("2nd loop");

          if (int.parse(globals.dropDownCaptionValuesCodeKeysBusiness[2][i].mcode) ==
              CustomerFormationMasterTabsState.custListBean
                  .longTermLiabilitiesList[l].mlngtrmliabilty) {
            print("matched");
            liabilityDtlList.add(
                globals.dropDownCaptionValuesCodeKeysBusiness[2][i]
                    .mcodedesc);
          }
        }
     print("Asset List is ${liabilityDtlList}");
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
        label: const Text('Liability'),
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
        CustomerFormationMasterTabsState.custListBean.longTermLiabilitiesList.length,
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
              new DataCell(new Text(liabilityDtlList==null?"":liabilityDtlList[a])),
              new DataCell(
                  new Text(CustomerFormationMasterTabsState.custListBean.longTermLiabilitiesList[a].mpresentamt.toString())),
              new DataCell(new Text(CustomerFormationMasterTabsState.custListBean.longTermLiabilitiesList[a].mnextmonthamount
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
            Translations.of(context).text('Lng_Trm_Lblty_Dtl'),
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
      CustomerFormationMasterTabsState.custListBean.longTermLiabilitiesList.removeAt(items);
    }
    selectedIndex.clear();
    setState(() {
      getRow();
    });
  }
}