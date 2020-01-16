import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/FullScreenDialogForProductSelection.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/CustTDAccList.dart';

class CustTDAccSearch extends StatefulWidget {
  @override
  _CustTDAccSearch createState() => _CustTDAccSearch();
}


class _CustTDAccSearch extends State<CustTDAccSearch> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(

      appBar: new AppBar(
        elevation: 1.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title: new Text(
          'New Term Deposit',
          //textDirection: TextDirection,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.normal),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.save,
              color: Colors.white,
              size: 40.0,
            ),
            onPressed: () {
              // proceed();
              Navigator.of(context).pop();
            },
          ),
          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
        ],
      ),
      body: new Form(
        key: _formKey,
        autovalidate: false,
        onWillPop: () {
          return Future(() => true);
        },
        child: ListView(

          shrinkWrap: true,
          padding: EdgeInsets.all(0.0),

          children: <Widget>[


            Card(
              color: Constant.mandatoryColor,
              child: new ListTile(
                  title: new Text("Cutomer Name/No"),
                  subtitle:
//                  new Text("${customerName} ${customerNo}"),
                  new Text("Abhay singh"),
                  onTap: () => getCustomerNumber()),
            ),
            Card(
              color: Constant.mandatoryColor,
              child: new ListTile(
                  title: new Text("Product Name/No"),
                  subtitle:
//                  new Text("${productName} ${productNo}"),
                  new Text("Individual Fixed deposit"),
                  onTap: () => getProduct()),
            ),
            _searchIcon(),
          ],
        ),
      ),
    );
  }

  Future getCustomerNumber() async {
    var customerdata;
    customerdata = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                CustomerList(null, "Loan Application")));
    /* if (customerdata != null) {
    customerdata = customerdata.toString().split("~~");
    customerNo = customerdata[0];
    print("customer name " + customerdata[1]);
    customerName = customerdata[1];

  }*/


  }
  Future getProduct() async {
    ProductBean prodObj =    await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForProductSelection(30,0),//TODO for mergin ..passing 30
          fullscreenDialog: true,
        ));

   // productName = prodObj.mname;
   // productNo = prodObj.mprdCd.toString();

  }

  Widget _searchIcon() {
    return Column(
      children: <Widget>[
       // MulticityInput(),
        // Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
          child: FloatingActionButton(
            backgroundColor: Color(0xff12D6F4),
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  // builder: (context) => new LoanCollectionFilteredList()),
                    builder: (context) => new CustTDAccList()),
              );},
            child: Icon(Icons.search, size: 36.0,color: Colors.white,),
          ),
        ),
      ],
    );
  }

}





