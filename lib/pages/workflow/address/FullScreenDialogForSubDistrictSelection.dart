import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/address/beans/GetSubDistrictSelectionList.dart';
import 'package:eco_mfi/pages/workflow/address/beans/SubDistrictDropDownBean.dart';
import 'package:eco_mfi/translations.dart';

class FullScreenDialogForSubDistrictSelection extends StatefulWidget {
  String placeCd = "";
  String placeCdDesc = "";
  final bool decendingAddrss;
  FullScreenDialogForSubDistrictSelection(this.decendingAddrss);
  @override
  FullScreenDialogForSubDistrictSelectionState createState() =>
      new FullScreenDialogForSubDistrictSelectionState();
}

class FullScreenDialogForSubDistrictSelectionState
    extends State<FullScreenDialogForSubDistrictSelection> {
  List<SubDistrictDropDownList> items = new List();
<<<<<<< .mine
  List<SubDistrictDropDownList> storedItems = new List<SubDistrictDropDownList>();

=======
  List<SubDistrictDropDownList> storedItems = new List<SubDistrictDropDownList>();
>>>>>>> .r1143
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  static const JsonCodec JSON = const JsonCodec();
  String url =
      'http://14.141.164.239:8090/subdistricts/getlistOfData/';
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Sub District List");


  Future<List<SubDistrictDropDownList>> _getSuggestion(String url) async {
    return http.get(url).then((http.Response response) {
      final String res = response.body;
      print(res + " --res ");
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }

      final parsed = json.decode(res).cast<Map<String, dynamic>>();

      return parsed
          .map<GetSubDistrictSelectionList>(
              (json) => GetSubDistrictSelectionList.fromJson(json))
          .toList();
    });
  }

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
      onTap: () {

        _onTapItem(context, items[index]);
      },
      child: new Card(
        shape: BeveledRectangleBorder(),
        child: new Row(
        children: <Widget>[
            SizedBox(height: 8.0,),
            Expanded(
              child:  new Card(
                  child:new ListTile(
                    leading:Text(
                      '${items[index].placeCd.toString()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 40.0,color: Color(0xff07426A),),
                    ),

                    title:new Text(items[index].placeCdDesc
                      ,
              style: TextStyle(

              ),
            ),

          )
              ),
            ),
        ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
        future: AppDatabase.get()
            .getSubDistrictList(widget.decendingAddrss)
<<<<<<< .mine
            .then((List<SubDistrictDropDownList> response) async{
          items.clear();
          storedItems.clear();
          items.addAll(response);
          storedItems.addAll(response);
          return storedItems;
        }),

=======
            .then((List<SubDistrictDropDownList> response) async{
          items.clear();
          storedItems.clear();
          items.addAll(response);
          storedItems.addAll(response);
          return storedItems;
        }),
>>>>>>> .r1143
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
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title: appBarTitle,/*new Text(
          Translations.of(context).text('SubDistrict_List')
          ,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
<<<<<<< .mine
        ),*/
        actions: <Widget>[

          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                String custListLeng = items != null &&
                    items.length != null &&
                    items.length > 0
                    ? "/" + items.length.toString()
                    : "";
                this.appBarTitle =
                new Text("Sub District List" + custListLeng);
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
                  String custListLeng = items != null &&
                      items.length != null &&
                      items.length > 0
                      ? "/" + items.length.toString()
                      : "";
                  this.actionIcon = new Icon(Icons.search);
                  // this.actionIcon = new Icon(Icons.mic);
                  this.appBarTitle =
                  new Text("Sub District List" + custListLeng.toString());
                  items = new List<SubDistrictDropDownList>();
                  items.clear();
                  storedItems.forEach((val) {
                    items.add(val);
                  });
                }
              });
            },
          ),
        ],
=======
        ),*/
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                String custListLeng = items != null &&
                    items.length != null &&
                    items.length > 0
                    ? "/" + items.length.toString()
                    : "";
                this.appBarTitle =
                new Text("Sub District List" + custListLeng);
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close);
                  this.appBarTitle = new TextField(
                    style: new TextStyle(
                      color: Colors.white,
        ),
>>>>>>> .r1143
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
                  String custListLeng = items != null &&
                      items.length != null &&
                      items.length > 0
                      ? "/" + items.length.toString()
                      : "";
                  this.actionIcon = new Icon(Icons.search);
                  // this.actionIcon = new Icon(Icons.mic);
                  this.appBarTitle =
                  new Text("Sub District List" + custListLeng.toString());
                  items = new List<SubDistrictDropDownList>();
                  items.clear();
                  storedItems.forEach((val) {
                    items.add(val);
                  });
                }
              });
            },
          ),
        ],
      ),
      body: Center(
        child: futureBuilder,
      ),
    );
  }

  void _onTapItem(
      BuildContext context, SubDistrictDropDownList getSubDistrictList) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(getSubDistrictList.placeCd.toString() +
            ' - ' +
            getSubDistrictList.placeCdDesc)));

    widget.placeCd = getSubDistrictList.placeCd;
    widget.placeCdDesc = getSubDistrictList.placeCdDesc.toString();
    globals.placeCd = getSubDistrictList.placeCd;
    globals.placeCdDesc = getSubDistrictList.placeCdDesc.toString();
    Navigator.of(context).pop(getSubDistrictList);
    /*Navigator.pop(context);*/
  }
<<<<<<< .mine


  void filterList(String val) async {
    items.clear();
    items = new List<SubDistrictDropDownList>();
    storedItems.forEach((obj) {
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxx   "+  val  + obj.placeCdDesc.trim().toString().toLowerCase() );
      if (obj.placeCd.toString().contains(val) | obj.placeCdDesc.trim().toString().toLowerCase().contains(val)) {
      items.add(obj);
      }
    });
    setState(() {});
  }
=======
  void filterList(String val) async {
    items.clear();
    items = new List<SubDistrictDropDownList>();
    storedItems.forEach((obj) {
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxx   "+  val  + obj.placeCdDesc.trim().toString().toLowerCase() );
      if (obj.placeCd.toString().contains(val) | obj.placeCdDesc.trim().toString().toLowerCase().contains(val)) {
      items.add(obj);
      }
    });
    setState(() {});
  }
>>>>>>> .r1143
}
