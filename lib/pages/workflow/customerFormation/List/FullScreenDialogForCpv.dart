import 'dart:convert';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';
import 'package:flutter/material.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';



class FullScreenDialogForCpv extends StatefulWidget {
  final position;
  final String type;
  final  int basicCode;
  FullScreenDialogForCpv( {this.type,this.position,this.basicCode});
  @override
  _FullScreenDialogForCpvState createState() =>
      new _FullScreenDialogForCpvState();
}

class _FullScreenDialogForCpvState
    extends State<FullScreenDialogForCpv> {
  List<SubLookupForSubPurposeOfLoan> items = new List();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  static const JsonCodec JSON = const JsonCodec();
  String multiplePurpose = "";
  bool longPress = false;
  List<SubLookupForSubPurposeOfLoan> listToAddRemove = new List<SubLookupForSubPurposeOfLoan>();
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle =  new Text(
    'Purpose Selection List',
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: new TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );
  List<SubLookupForSubPurposeOfLoan> storedCheckedRecords = new List<SubLookupForSubPurposeOfLoan>();
  //String url = 'http://14.141.164.239:8090/purposeData/getlistOfPurposes/';

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
    return new GestureDetector(
      /*  onLongPress: () {
        setState(() {
          longPress = true;
        });

        _onTapItem(context, items[index], index);
      },*/
      onTap: (){
        _onTapItem(context, items[index], index);
        setState(() {

        });
      },
      child: new Card(
        shape: BeveledRectangleBorder(),
        color: checkIfContains(items[index])
            ? Color.fromRGBO(255, 255, 255, 0.5)
            : Colors.white,
        child:   new Container (
          height: 75.0,
          child: new Row (
            children: [
              new Expanded(
                child: new Text (items[index].codeDesc.toString()!=null&& items[index].codeDesc.toString()!="" && items[index].codeDesc.toString()!="null"?items[index].codeDesc.toString():'',
                  style: TextStyle(
                      fontSize: 20.0, color: Colors.red[500]),
                ),
              ),
            ],
          ),
          decoration: new BoxDecoration (
            // backgroundColor: Colors.grey[300],
          ),
          width: 400.0,
        ),
      ),
    );

  }
  int count = 1;
  Widget build(BuildContext context) {
    var futureBuilder;

    if (count == 1) {
      count++;
      futureBuilder = new FutureBuilder(
          future: AppDatabase.get()
              .getSunPurposeOfLoanListFromSubLookpTable(widget.basicCode, 0)
              .then((List<SubLookupForSubPurposeOfLoan> response) =>
          items = response),
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
    } else if (this.mounted == true && items != null) {
      futureBuilder = ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, position) {
            return new GestureDetector(
              /*   onLongPress: () {
              setState(() {
                longPress = true;
              });

              _onTapItem(context, items[position], position);
            },*/
              onTap: (){
                _onTapItem(context, items[position], position);
                setState(() {

                });
              },
              child: new Card(
                shape: BeveledRectangleBorder(),
                color: checkIfContains(items[position])
                    ? Color.fromRGBO(255, 255, 255, 0.5)
                    : Colors.white,
                child:   new Container (
                  height: 75.0,
                  child: new Row (
                    children: [
                      new Expanded(
                        child: new Text (items[position].codeDesc.toString()!=null&& items[position].codeDesc.toString()!="" && items[position].codeDesc.toString()!="null"?items[position].codeDesc.toString():'',
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.red[500]),
                        ),
                      ),
                    ],
                  ),
                  decoration: new BoxDecoration (
                    // backgroundCo4or: Colors.grey[300],
                  ),
                  width: 400.0,
                ),
              ),
            );

          });
    }
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
          'Purpose Selection List',
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        //  title: appBarTitle,
        actions: <Widget>[
          /*   new IconButton(
      icon: actionIcon,
          onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(Icons.close);
                this.appBarTitle = new TextField(
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                  decoration: new InputDecoration(
                      prefixIcon:
                      new Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: new TextStyle(color: Colors.white)),
                  onChanged: (val) {
                    filterList(val.toLowerCase());
                  },
                );
              } else {
                this.actionIcon = new Icon(Icons.search);
                this.appBarTitle = new Text("Prospect List");
                items.clear();
                storedCheckedRecords.forEach((val) {
                  items.add(val);
                });
              }
            });
          }),*/
          new IconButton(
              icon: const Icon(
                Icons.file_upload,
                color: Colors.black,
                size: 44.0,
              ),
              onPressed: () {
                Navigator.of(context).pop(listToAddRemove);
              },
              splashColor: Colors.blueAccent),],
      ),
      /*  floatingActionButton: new FloatingActionButton(
        child: new Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        onPressed: () async {
          bool isDataChanged = await Navigator.push(
            context,
            new MaterialPageRoute<bool>(
                builder: (context) => new CustomerFormationBasicDetails()),
          );

        },
      ),*/
      body: Center(
        child: futureBuilder,
      ),
    );
  }

  void _onTapItem(BuildContext context, SubLookupForSubPurposeOfLoan getPurposeOfLoanList, int index) {
    bool isAlreadyAdded=false;
    for(int itemsToAddOrRemove =0;itemsToAddOrRemove<listToAddRemove.length;itemsToAddOrRemove++) {
      if(listToAddRemove[itemsToAddOrRemove].code == getPurposeOfLoanList.code){
        listToAddRemove.removeAt(itemsToAddOrRemove);
        isAlreadyAdded= true;
        break;
      }
    }
    if(!isAlreadyAdded) {
      listToAddRemove.add(getPurposeOfLoanList);
    }
    multiplePurpose = multiplePurpose!=null && multiplePurpose!=""?multiplePurpose +","+getPurposeOfLoanList.code+"~"+getPurposeOfLoanList.codeDesc:getPurposeOfLoanList.code+"~"+getPurposeOfLoanList.codeDesc;

    print(multiplePurpose+" toxxxxxxxxxxxxxx");
    /* Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(getPurposeOfLoanList.code.toString() +
            ' - ' +
            getPurposeOfLoanList.codeDesc)));*/

    // Navigator.of(context).pop(getPurposeOfLoanList);

  }

  checkIfContains(SubLookupForSubPurposeOfLoan item) {
    bool isAlreadyAdded=false;
    for(int itemAdded =0;itemAdded<listToAddRemove.length;itemAdded++){
      if(listToAddRemove[itemAdded].code == item.code){
        isAlreadyAdded= true;
        break;
      }
    }

    return isAlreadyAdded;
  }
}
