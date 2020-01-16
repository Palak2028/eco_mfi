import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';

import '../../../translations.dart';

class ViewCustomerFormationFamilyDetails extends StatefulWidget {
  static const String routeName = '/material/data-table';


  @override
  _ViewCustomerFormationFamilyDetailsState createState() =>
      _ViewCustomerFormationFamilyDetailsState();
}

class _ViewCustomerFormationFamilyDetailsState
    extends State<ViewCustomerFormationFamilyDetails> {
  List<DataRow> _sampleDataRows = new List<DataRow>();
  List<DataColumn> _dataColumns = new List<DataColumn>();
  List<int> selectedIndex = new List<int>();
  List<List<String>> familyList ;
  var rows2;
  var cols2;

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
    if(CustomerFormationMasterTabsState.custListBean.familyDetailsList == null){
      CustomerFormationMasterTabsState.custListBean.familyDetailsList =List();
    }
    if(CustomerFormationMasterTabsState.custListBean.familyDetailsList!= null) {
if(CustomerFormationMasterTabsState.custListBean.familyDetailsList.isNotEmpty){
  familyList = new List<List<String>>();
  for(int l = 0;l<CustomerFormationMasterTabsState.custListBean.familyDetailsList.length;l++){

    List<String> tempList = new List<String>(3);

    for (int k = 0; k < globals.dropdownCaptionsValuesFamilyDetails.length; k++) {
      for (int i = 0; i < globals.dropdownCaptionsValuesFamilyDetails[k].length; i++) {


        if (k == 0) {
          print("for k = 0 codes are ${globals.dropdownCaptionsValuesFamilyDetails[k][i].mcode}");
          if (globals.dropdownCaptionsValuesFamilyDetails[k][i].mcode.toString().trim() ==
              CustomerFormationMasterTabsState.custListBean
                  .familyDetailsList[l].meducation.toString().trim()) {

            tempList[0] = globals.dropdownCaptionsValuesFamilyDetails[k][i].mcodedesc;


          }
        }

         if (k == 1) {
           print(" for k = 1 codes are ${globals.dropdownCaptionsValuesFamilyDetails[k][i].mcode}");
           print(CustomerFormationMasterTabsState.custListBean
               .familyDetailsList[l].mrelationwithcust);
          if (globals.dropdownCaptionsValuesFamilyDetails[k][i].mcode.toString().trim() ==
              CustomerFormationMasterTabsState.custListBean
                  .familyDetailsList[l].mrelationwithcust.toString().trim()) {

            tempList[1] = globals.dropdownCaptionsValuesFamilyDetails[k][i].mcodedesc;


          }



        }

         if (k == 2) {
           print(" for k = 2 codes are ${globals.dropdownCaptionsValuesFamilyDetails[k][i].mcode}");
          if (globals.dropdownCaptionsValuesFamilyDetails[k][i].mcode.toString().trim() ==
              CustomerFormationMasterTabsState.custListBean
                  .familyDetailsList[l].moccuptype.toString().trim()) {
            tempList[2] = globals.dropdownCaptionsValuesFamilyDetails[k][i].mcodedesc;
          }
        }
      }


    }


    familyList.add(tempList);


  }
  print("family List is ${familyList}");
}
  }




    List<DataCell> _dataCells = ['A', 'B', 'C', 'D', 'E', 'F', 'G']
        .map((c) => DataCell(Text(c)))
        .toList();
    _sampleDataRows =
        [0, 1, 2, 3, 4, 5, 6].map((i) => DataRow(cells: _dataCells)).toList();
    _dataColumns = [0, 1, 2, 3, 4, 5, 6]
        .map((i) => DataColumn(label: Text(columnName[i])))
        .toList();
   getRow();
    cols2 = [
      new DataColumn(
        label: const Text('Family Member'),
      ),
      new DataColumn(
        label: const Text('Age'),
      ),
      new DataColumn(
        label: const Text('Education'),
      ),
      new DataColumn(
        label: const Text('RelationShip'),
      ),
      new DataColumn(
        label: const Text('Occupation'),
      ),
      new DataColumn(
        label: const Text('income'),
      ),
      new DataColumn(
        label: const Text('Dependant'),
      )
    ];
  }
  void getRow(){
    rows2 = new List.generate(
        CustomerFormationMasterTabsState.custListBean.familyDetailsList.length,
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
          new DataCell(new Text(CustomerFormationMasterTabsState.custListBean.familyDetailsList[a].mname)),
          new DataCell(
              new Text(CustomerFormationMasterTabsState.custListBean.familyDetailsList[a].mage.toString()=="0"?""
              :CustomerFormationMasterTabsState.custListBean.familyDetailsList[a].mage.toString())),
          new DataCell(new Text(familyList[a][0]==null?"":familyList[a][0])),
          new DataCell(new Text(familyList[a][1]==null?"":familyList[a][1])),
          new DataCell(new Text(familyList[a][2]==null?"":familyList[a][2])),
          new DataCell(
              new Text(CustomerFormationMasterTabsState.custListBean.familyDetailsList[a].mincome.toString()=="0.0"?"":
              CustomerFormationMasterTabsState.custListBean.familyDetailsList[a].mincome.toString()
              )),
          /*new DataCell(
              new Text(CustomerFormationMasterTabsState.custListBean.familyDetailsList[a].mmemberno)),*/
          new DataCell(
              CustomerFormationMasterTabsState.custListBean.familyDetailsList[a].mmemberno=="null"||
                  CustomerFormationMasterTabsState.custListBean.familyDetailsList[a].mmemberno==null||
                  CustomerFormationMasterTabsState.custListBean.familyDetailsList[a].mmemberno=="0" ||
                  CustomerFormationMasterTabsState.custListBean.familyDetailsList[a].mmemberno== ""?
                  new Text("Y"):new Text("N")),
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
            Translations.of(context).text('Family_details'),
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
      CustomerFormationMasterTabsState.custListBean.familyDetailsList.removeAt(items);
    }
    selectedIndex.clear();
    setState(() {
      getRow();
    });
  }
}
