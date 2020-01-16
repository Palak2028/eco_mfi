import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/address/beans/GetStateSelectionList.dart';
import 'package:eco_mfi/pages/workflow/address/beans/StateDropDownBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';

class FullScreenDialogForStateSelection extends StatefulWidget {
  String stateCd = "";
  String stateDesc = "";

  @override
  FullScreenDialogForStateSelectionState createState() =>
      new FullScreenDialogForStateSelectionState();
}

class FullScreenDialogForStateSelectionState
    extends State<FullScreenDialogForStateSelection> {
  List<StateDropDownList> items = new List();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  static const JsonCodec JSON = const JsonCodec();
  String url =
      'http://14.141.164.239:8090/states/getlistOfData/';
  SharedPreferences prefs;
  String countryCd;

  Future<List<StateDropDownList>> _getSuggestion(String url) async {
    return http.get(url).then((http.Response response) {
      final String res = response.body;
      print(res + " --res ");
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }

      final parsed = json.decode(res).cast<Map<String, dynamic>>();

      return parsed
          .map<GetStateSelectionList>(
              (json) => GetStateSelectionList.fromJson(json))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getPreferences();
    setState(() {});

  }
  getPreferences()async{
    prefs = await SharedPreferences.getInstance();
      countryCd = prefs.getString(TablesColumnFile.mcountryCd);


      print("Country CD  ${countryCd}");
      setState(() {

      });

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
                      '${items[index].stateCd.toString()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 40.0,color: Color(0xff07426A),),
                    ),

                    title: new Text(items[index].stateDesc
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
            .getStateList(countryCd)
            .then((List<StateDropDownList> response) => items = response),
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
        title: new Text(
          Translations.of(context).text('State_List')
          ,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: futureBuilder,
      ),
    );
  }

  void _onTapItem(
      BuildContext context, StateDropDownList getStateList) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(getStateList.stateCd.toString() +
            ' - ' +
            getStateList.stateDesc)));

    widget.stateCd = getStateList.stateCd;
    widget.stateDesc = getStateList.stateDesc.toString();
    globals.stateCd = getStateList.stateCd;
    globals.stateDesc = getStateList.stateDesc.toString();
    Navigator.of(context).pop(getStateList);
  }
}
