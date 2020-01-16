import 'package:flutter/material.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';

import '../../../translations.dart';

class FullScreenDialogPPIAnswerPickList  extends StatefulWidget{

  final position;
  FullScreenDialogPPIAnswerPickList( {this.position});
  @override
  _FullScreenDialogPPIAnswerPickListState createState() =>
      new _FullScreenDialogPPIAnswerPickListState();
}

class _FullScreenDialogPPIAnswerPickListState
    extends State<FullScreenDialogPPIAnswerPickList> {
  List<SubLookupForSubPurposeOfLoan> items = new List();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 20.0),
      );
    }
  }

  Widget _getItemUI(BuildContext context, int index) {
    return new SizedBox(
      child: new Card(
          child: new Column(
            children: <Widget>[
              new ListTile(
                leading: new Text(
                  '${items[index].codeDesc}',
                  //textScaleFactor: 1.2,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),

                title: new Text(
                  '${items[index].fieldValue1}',
                  //textScaleFactor: 0.9,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blueAccent,
                  ),
                ),

                //trailing: ,
                onTap: () {
                  _onTapItem(context, items[index]);
                },
              )
            ],
          )),
    );
  }

  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
        future: AppDatabase.get()
            .getSunPurposeOfLoanListFromSubLookpTable(70771,widget.position)
            .then((List<SubLookupForSubPurposeOfLoan> response) => items = response),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text('Press button to start');
            case ConnectionState.waiting:
              return new Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  child:
                  new CircularProgressIndicator()); // new Text('Awaiting result...');
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return getHomePageBody(context, snapshot);
          }
        });
    return Scaffold(
      key: _scaffoldHomeState,
      appBar: new AppBar(
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: new Text(
          Translations.of(context).text('PPI_Ans_List'),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      body: Center(
        child: futureBuilder,
      ),
    );
  }

  void _onTapItem(BuildContext context, SubLookupForSubPurposeOfLoan getPurposeOfLoanList) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(getPurposeOfLoanList.code.toString() +
            ' - ' +
            getPurposeOfLoanList.codeDesc)));

    Navigator.of(context).pop(getPurposeOfLoanList);

  }
}
