import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';

import 'package:eco_mfi/pages/workflow/termDeposit/ReceiptCreation.dart';

class CustTDAccList extends StatefulWidget {
  @override
  _CustTDAccList createState() => _CustTDAccList();
}

class _CustTDAccList extends State<CustTDAccList> {
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
          'Customer Accounts List',
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
                  title: new Text("Accont No:"),
                  subtitle:
//                  new Text("${customerName} ${customerNo}"),
                      new Text("45612547898745"),
                  onTap: () => callReceiptCreation()),
            ),
            Card(
              color: Constant.mandatoryColor,
              child: new ListTile(
                title: new Text("Account No:"),
                subtitle:
//                  new Text("${productName} ${productNo}"),
                    new Text("65122541245745"),
                onTap: () => callReceiptCreation(),
              ),
            ),
            Card(
              color: Constant.mandatoryColor,
              child: new ListTile(
                title: new Text("Accont No:"),
                subtitle:
//                  new Text("${customerName} ${customerNo}"),
                    new Text("45612547898745"),
                onTap: () => callReceiptCreation(),
              ),
            ),
            Card(
              color: Constant.mandatoryColor,
              child: new ListTile(
                  title: new Text("Account No:"),
                  subtitle:
//                  new Text("${productName} ${productNo}"),
                      new Text("65122541245745"),
                  onTap: () => callReceiptCreation()),
            ),
            Card(
              color: Constant.mandatoryColor,
              child: new ListTile(
                title: new Text("Accont No:"),
                subtitle:
//                  new Text("${customerName} ${customerNo}"),
                    new Text("45612547898745"),
                onTap: () => callReceiptCreation(),
              ),
            ),
            Card(
              color: Constant.mandatoryColor,
              child: new ListTile(
                title: new Text("Account No:"),
                subtitle:
//                  new Text("${productName} ${productNo}"),
                    new Text("65122541245745"),
                onTap: () => callReceiptCreation(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future callReceiptCreation() async {
    Navigator.push(
      context,
      new MaterialPageRoute(
          // builder: (context) => new LoanCollectionFilteredList()),
          builder: (context) => new ReceiptCreation()),
    );
  }
}
