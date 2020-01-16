import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';

import '../../../translations.dart';

class ViewAssetDetails extends StatefulWidget {
  static const String routeName = '/material/data-table';


  @override
  _ViewAssetDetailsState createState() =>
      _ViewAssetDetailsState();
}

class _ViewAssetDetailsState
    extends State<ViewAssetDetails> {
  List<DataRow> _sampleDataRows = new List<DataRow>();
  List<DataColumn> _dataColumns = new List<DataColumn>();
  List<int> selectedIndex = new List<int>();
  List<String> assestDtlList ;
  var rows2;
  var cols2;

  @override
  void initState() {
    super.initState();
    List columnName = [
      "Item",
    ];
    print("1");
    if (CustomerFormationMasterTabsState.custListBean.assetDetailsList ==
        null) {
      CustomerFormationMasterTabsState.custListBean.assetDetailsList = List();
    }

    print("2" + CustomerFormationMasterTabsState.custListBean.assetDetailsList
        .toString());
    if (CustomerFormationMasterTabsState.custListBean.assetDetailsList != null
        && CustomerFormationMasterTabsState.custListBean.assetDetailsList
            .isNotEmpty) {
      print("3");
      assestDtlList = new List<String>();

      for (int l = 0; l <
          CustomerFormationMasterTabsState.custListBean.assetDetailsList
              .length; l++) {
        print("1st loop");
        for (int i = 0; i <
            globals.dropDownCaptionValuesCOdeKeysSocialFinancial[3].length;
        i++) {
          print("2nd loop");
          print(globals.dropDownCaptionValuesCOdeKeysSocialFinancial[3][i].mcode);
          print(CustomerFormationMasterTabsState.custListBean.assetDetailsList[l].mitem);
          if (int.parse(globals.dropDownCaptionValuesCOdeKeysSocialFinancial[3][i].mcode) ==
              CustomerFormationMasterTabsState.custListBean
                  .assetDetailsList[l].mitem) {
            print("matched");
            assestDtlList.add(
                globals.dropDownCaptionValuesCOdeKeysSocialFinancial[3][i]
                    .mcodedesc);
          }
        }








      /*  for (int l = 0; l <
            CustomerFormationMasterTabsState.custListBean.assetDetailsList
                .length; l++) {
          print("4");
          List<String> tempList = new List<String>(3);

          for (int k = 0; k < globals.dropdownCaptionsAssetDetails.length;
          k++) {
            print("5");
            for (int i = 0; i <
                globals.dropDownCaptionValuesCOdeKeysSocialFinancial[k].length; i++) {
              if (k == 3) {
                print("6");
                print("for k = 3 codes are ${globals
                    .dropDownCaptionValuesCOdeKeysSocialFinancial[k][i].mcode}");
                if (globals.dropDownCaptionValuesCOdeKeysSocialFinancial[k][i].mcode ==
                    CustomerFormationMasterTabsState.custListBean
                        .assetDetailsList[0].mitem) {
                  tempList[0] =
                      globals.dropDownCaptionValuesCOdeKeysSocialFinancial[k][i].mcodedesc;
                }
              }
            }
          }
          assestDtlList.add(tempList);
        }*/
        print("Asset List is ${assestDtlList}");
      }
    }

    print("bahar");



    List<DataCell> _dataCells = ['A']
        .map((c) => DataCell(Text(c)))
        .toList();
    _sampleDataRows =
        [0].map((i) => DataRow(cells: _dataCells)).toList();
    _dataColumns = [0]
        .map((i) => DataColumn(label: Text(columnName[i])))
        .toList();
    getRow();
    cols2 = [
      new DataColumn(
        label: const Text('Items'),
      ),
     /* new DataColumn(
        label: const Text('Evaluation'),
      ),*/
    ];
  }
  void getRow(){
    rows2 = new List.generate(
        CustomerFormationMasterTabsState.custListBean.assetDetailsList.length,
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
              new DataCell(new Text(assestDtlList==null?"":assestDtlList[a])),
              /*new DataCell(
                  new Text(CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList[a].mbusinevaluationamt.toString()=="0.0"?"":
                  CustomerFormationMasterTabsState.custListBean.businessExpendDetailsList[a].mbusinevaluationamt.toString()
                  )),*/
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
            Translations.of(context).text('assetDetail'),
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
      CustomerFormationMasterTabsState.custListBean.assetDetailsList.removeAt(items);
    }
    selectedIndex.clear();
    setState(() {
      getRow();
    });
  }
}