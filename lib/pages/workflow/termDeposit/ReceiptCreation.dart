import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/NewTermDeposit.dart';


class ReceiptCreation extends StatefulWidget {
  @override
  _ReceiptCreation createState()=> _ReceiptCreation();

}

class _ReceiptCreation extends State<ReceiptCreation>{

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold( appBar: new AppBar(
      elevation: 1.0,
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: Color(0xff07426A),
      brightness: Brightness.light,
      title: new Text(
        'Receipt Creation',
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
                  title: new Text("Amount"),
                  subtitle:
//                  new Text("${customerName} ${customerNo}"),
                  new Text("1000"),
                  //onTap: () => getCustomerNumber()
              ),
            ),
            Card(
              color: Constant.mandatoryColor,
              child: new ListTile(
                  title: new Text("Tenure"),
                  subtitle:
//                  new Text("${productName} ${productNo}"),
                  new Text("5 months"),
                  //onTap: () => getProduct()
              ),
            ),
            _searchIcon(),
          ],
        ),
      ),
    );
  }


  Widget _searchIcon() {
    return Column(
      children: <Widget>[
        // MulticityInput(),
        // Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
          child: FloatingActionButton.extended(
            backgroundColor: Color(0xff12D6F4),
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  // builder: (context) => new LoanCollectionFilteredList()),
                    builder: (context) => new NewTermDeposit()),
              );},
            icon: Icon(Icons.add),
            label: Text("Open New Account"),
           // child: Icon(Icons.add, size: 36.0,color: Colors.white,),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),

          ),
        ),
      ],
    );
  }
}


