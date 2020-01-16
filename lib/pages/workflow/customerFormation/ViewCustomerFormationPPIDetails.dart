import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;

import '../../../translations.dart';


class ViewCustomerFormationPPIDetails extends StatefulWidget {



  @override
  _ViewCustomerFormationPPIDetailsState createState() =>
      _ViewCustomerFormationPPIDetailsState();
}

class _ViewCustomerFormationPPIDetailsState
    extends State<ViewCustomerFormationPPIDetails> {
  List<DataRow> _sampleDataRows = new List<DataRow>();
  List<DataColumn> _dataColumns = new List<DataColumn>();
  List<int> selectedIndex = new List<int>();
  List<List<String>> ppiList ;
  var rows2;
  var cols2;


  @override
  void initState() {
    super.initState();
    List columnName = [
      "PPI Question",
      "PPI Answer",
      "PPI weightage",
    ];
    if (CustomerFormationMasterTabsState.custListBean.pPIMasterBean == null) {
      CustomerFormationMasterTabsState.custListBean.pPIMasterBean = List();
    }
    if (CustomerFormationMasterTabsState.custListBean.pPIMasterBean != null) {
      if (CustomerFormationMasterTabsState.custListBean.pPIMasterBean
          .isNotEmpty) {
        ppiList = new List<List<String>>();
        for (int l = 0; l <
            CustomerFormationMasterTabsState.custListBean.pPIMasterBean.length;
        l++) {
          List<String> tempList = new List<String>(1);

          for (int k = 0; k < globals.dropdownCaptionsValuePPIDetails.length;
          k++) {
            for (int i = 0; i <
                globals.dropdownCaptionsValuePPIDetails[k].length; i++) {
              if (k == 0) {
                print("for k = 0 codes are ${globals
                    .dropdownCaptionsValuePPIDetails[k][i].mcode}");
                if (globals.dropdownCaptionsValuePPIDetails[k][i].mcode ==
                    CustomerFormationMasterTabsState.custListBean
                        .pPIMasterBean[l].mitem) {
                  tempList[0] =
                      globals.dropdownCaptionsValuePPIDetails[k][i].mcodedesc;
                }
              }
            }


            ppiList.add(tempList);
          }
          print("PPI List is ${ppiList}");
        }
      }
    }
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
          label: const Text("PPI Question"),
        ),
        new DataColumn(
          label: const Text("PPI Answer"),
        ),
        new DataColumn(
          label: const Text("PPI weightage"),
        ),

      ];
    }


  void getRow() {
    rows2 = new List.generate(
        CustomerFormationMasterTabsState.custListBean.pPIMasterBean.length,
            (int a) =>
        new DataRow(
            selected: selectedIndex.contains(a) ? true : false,
            onSelectChanged: (val) {
              getRow();
              if (selectedIndex.contains(a)) {
                print("a is there");
                selectedIndex.remove(a);
              }
              else {
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
                  new Text(ppiList[a][0] == null ? "" : ppiList[a][0])),
              new DataCell(
                  new Text(CustomerFormationMasterTabsState.custListBean
                      .pPIMasterBean[a].mhaveyn.toString() == "0.0" ? "" :
                  CustomerFormationMasterTabsState.custListBean.pPIMasterBean[a]
                      .mhaveyn.toString()
                  )),
              new DataCell(new Text(
                  CustomerFormationMasterTabsState.custListBean.pPIMasterBean[a]
                      .mweightage.toString())),
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
              Translations.of(context).text('PPI_Details'),
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
    void deleteSelected() {
      for (var items in selectedIndex) {
        CustomerFormationMasterTabsState.custListBean.pPIMasterBean.removeAt(
            items);
      }
      selectedIndex.clear();
      setState(() {
        getRow();
      });
    }
  }