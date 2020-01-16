import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';

import '../../../translations.dart';

class ViewCustomerFormationAddressDetails extends StatefulWidget {
  static const String routeName = '/material/data-table';

  @override
  _ViewCustomerFormationAddressDetailsState createState() =>
      _ViewCustomerFormationAddressDetailsState();
}

class _ViewCustomerFormationAddressDetailsState
    extends State<ViewCustomerFormationAddressDetails> {
  List<DataRow> _sampleDataRows = new List<DataRow>();
  List<DataColumn> _dataColumns = new List<DataColumn>();
  var rows2;
  var cols2;
  List<int> selectedIndex = new List<int>();
  List<String> adressList;

  @override
  void initState() {
    super.initState();
    print(globals.addressDetailsList);
    List columnName = [
      "AddressType",
      "CurrentAddressType",
      "District",
      "Pin",
      "Thana",
      "Post",
      "MobileNumber",
      "LandLineNumber"
    ];
    List<DataCell> _dataCells = ['A', 'B', 'C', 'D', 'E', 'F', 'G']
        .map((c) => DataCell(Text(c)))
        .toList();
    _sampleDataRows =
        [0, 1, 2, 3, 4, 5, 6]
            .map((i) => DataRow(cells: _dataCells))
            .toList();
    _dataColumns = [0, 1, 2, 3, 4, 5, 6]
        .map((i) => DataColumn(label: Text(columnName[i])))
        .toList();

    adressList = new List<String>();
    print("Address List");
    print(CustomerFormationMasterTabsState.custListBean.addressDetails);
    if(CustomerFormationMasterTabsState.custListBean.addressDetails == null){
      CustomerFormationMasterTabsState.custListBean.addressDetails =List();
    }

    if(CustomerFormationMasterTabsState.custListBean.addressDetails!= null) {
      if (CustomerFormationMasterTabsState.custListBean.addressDetails
          .isNotEmpty) {
      print(CustomerFormationMasterTabsState.custListBean.addressDetails);
      for(int l = 0;l<CustomerFormationMasterTabsState.custListBean.addressDetails.length;l++){

        for (int k = 0; k < globals.dropdownCaptionsValuesKycDetails2.length; k++) {
          for (int i = 0; i < globals.dropdownCaptionsValuesKycDetails2[k].length; i++) {



              print("for k = 0 codes are ${globals.dropdownCaptionsValuesKycDetails2[k][i].mcode}");
              if (globals.dropdownCaptionsValuesKycDetails2[k][i].mcode.toString().trim() ==
                  CustomerFormationMasterTabsState.custListBean
                      .addressDetails[l].maddrType.toString().trim()) {

                adressList.add(globals.dropdownCaptionsValuesKycDetails2[k][i].mcodedesc);
                print("adding value ${globals.dropdownCaptionsValuesKycDetails2[k][i].mcodedesc}");


              }


  }


}
}
print("Adress List is ${adressList}");
      }
      getRow();
    }

    cols2 = [
      new DataColumn(
        label: const Text('Address Type'),
      ),
      new DataColumn(
        label: const Text('Country'),
      ),
      new DataColumn(
        label: const Text('State'),
      ),
      new DataColumn(
        label: const Text('District'),
      ),
      new DataColumn(
        label: const Text('Sub District'),
      ),
      new DataColumn(
        label: const Text('Area'),
      ),
      new DataColumn(
        label: const Text('Pin'),
      ),
      new DataColumn(
        label: const Text('Thana'),
      ),
      new DataColumn(
        label: const Text('No. of Rooms'),
      ),
      new DataColumn(
        label: const Text('Mobile Number'),
      ),new DataColumn(
        label: const Text('LandLine Number'),
      )
    ];
  }
  Future getRow() async{
    rows2 = new List.generate(
      //adressList.length,
        CustomerFormationMasterTabsState.custListBean.addressDetails.length,

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

                  new Text(adressList[a])),
              new DataCell(
              CustomerFormationMasterTabsState.custListBean.
              addressDetails[a].mcountryCd!="null"&&
                CustomerFormationMasterTabsState.custListBean.
                    addressDetails[a].mcountryCd!=null?
                new Text(CustomerFormationMasterTabsState.custListBean
                    .addressDetails[a].mcountryCd.toString()):new Text(""),),
              new DataCell(
                CustomerFormationMasterTabsState.custListBean.
                addressDetails[a].mState!="null"&&
                CustomerFormationMasterTabsState.custListBean
                    .addressDetails[a].mState!=null?
                new Text(CustomerFormationMasterTabsState.custListBean
                    .addressDetails[a].mState.toString()):new Text(""),),
              new DataCell(
                CustomerFormationMasterTabsState.custListBean
                    .addressDetails[a].mDistCd!=null?
                new Text(CustomerFormationMasterTabsState.custListBean
                    .addressDetails[a].mDistCd.toString()):new Text(""),),
              new DataCell(
                CustomerFormationMasterTabsState.custListBean.
                addressDetails[a].mplacecd!="null"&&
                CustomerFormationMasterTabsState.custListBean
                    .addressDetails[a].mplacecd!=null?
                new Text(CustomerFormationMasterTabsState.custListBean
                    .addressDetails[a].mplacecd.toString()):new Text(""),),
              new DataCell(
                CustomerFormationMasterTabsState.custListBean
                    .addressDetails[a].marea!=null?
                new Text(CustomerFormationMasterTabsState.custListBean
                    .addressDetails[a].marea.toString()):new Text(""),),
              new DataCell(
                  CustomerFormationMasterTabsState.custListBean
                      .addressDetails[a].mpinCd!=null?
                  new Text(CustomerFormationMasterTabsState.custListBean
                      .addressDetails[a].mpinCd.toString()):new Text("")),
              new DataCell(
                  CustomerFormationMasterTabsState.custListBean.
                  addressDetails[a].mThana!="null"&&
                  CustomerFormationMasterTabsState.custListBean
                      .addressDetails[a].mThana!=null?
                  new Text(CustomerFormationMasterTabsState.custListBean
                      .addressDetails[a].mThana):new Text("")),
              new DataCell(
                  CustomerFormationMasterTabsState.custListBean
                  .addressDetails[a].mNoOfRooms!=null?
              new Text(CustomerFormationMasterTabsState.custListBean
                  .addressDetails[a].mNoOfRooms.toString()):new Text("")),

            new DataCell(
                CustomerFormationMasterTabsState.custListBean.
                addressDetails[a].mMobile!="null"&&
                CustomerFormationMasterTabsState.custListBean
                .addressDetails[a].mMobile!=null?
                new Text(CustomerFormationMasterTabsState.custListBean
                .addressDetails[a].mMobile):new Text("")),

            new DataCell(
                CustomerFormationMasterTabsState.custListBean.
                addressDetails[a].mtel1!="null"&&
                CustomerFormationMasterTabsState.custListBean
                .addressDetails[a].mtel1!=null?
                      new Text(CustomerFormationMasterTabsState.custListBean
                      .addressDetails[a].mtel1):new Text("")),
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
            Translations.of(context).text('Contact_details'),
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
      CustomerFormationMasterTabsState.custListBean.addressDetails.removeAt(items);
    }
    selectedIndex.clear();
    setState(() {
      getRow();
    });
  }
}
