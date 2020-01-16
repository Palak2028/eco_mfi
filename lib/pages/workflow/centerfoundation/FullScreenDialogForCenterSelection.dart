import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/CenterFormationMaster.dart';

import 'package:eco_mfi/pages/workflow/centerfoundation/bean/GetCentersSelectionList.dart';
import 'package:eco_mfi/translations.dart';

class FullScreenDialogForCenterSelection extends StatefulWidget {
  String centerName = "";
  String centerNo = "";
  String type = "";
  FullScreenDialogForCenterSelection(this.type);
  @override
  FullScreenDialogForCenterSelectionState createState() =>
      new FullScreenDialogForCenterSelectionState();
}

class FullScreenDialogForCenterSelectionState
    extends State<FullScreenDialogForCenterSelection> {
  List<CenterDetailsBean> items = new List();
  List<CenterDetailsBean> storedItems = new List();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();


  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Center List");
  int count = 0;
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
    final dateFormat = DateFormat("dd/MM/yyyy");
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
                      '${items[index].mCenterId.toString()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 40.0,color: Color(0xff07426A),),
                    ),

                    title:
                      new Text(Translations.of(context).text('Center_Name')+items[index].mcentername.trim(),              style: TextStyle(

              ),
            ),
                    subtitle:new Column(
                      children: <Widget>[

                        new Row(
                          children: <Widget>[
                        new Text(Translations.of(context).text('Next_Meeting_Date')+dateFormat.format(items[index].mnextmeetngdt),
                              style: new TextStyle(
                              color: Color(0xff07426A),
                              fontSize: 12.0,
                            ), ),
                            //new Text('${items[index].mnextmeetngdt.toString()}')
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            new Text(Translations.of(context).text('Meeting_Day')+items[index].mmeetingday.toString(),

                              style: new TextStyle(
                              color: Color(0xff07426A),
                              fontSize: 14.0,
                            ), ),
                            //new Text('${items[index].mnextmeetngdt.toString()}')
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            new Text(Translations.of(context).text('Meeting_Frequency')+items[index].mmeetingfreq,

                              style: new TextStyle(
                              color: Color(0xff07426A),
                              fontSize: 13.0,
                            ), ),                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.local_atm,
                              color: Colors.green,

                              size: 20.0,
              ),
                            new Text('${items[index].trefno.toString()}')
                          ],
                        ),

                        new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.present_to_all,
                              color: Colors.yellow,

                              size: 20.0,
                            ),
                           // new Text(" supervisor")
                          ],
                        )


                      ],
                    ),
                   /*trailing:

                   new Column(
                     children: <Widget>[
                       new Text("${items[index].mmeetingday}"),
                       new Text("${items[index].mnextmeetngdt}")
                     ],
                   )*/

                    
                   // trailing: new Text("Pending" +items[index].mcreatedby,style: TextStyle(color: Colors.red),)
                    //,

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
          future:count==0? (AppDatabase.get()
              .getCenterFoundationList()
              .then((List<CenterDetailsBean> response) {
            response.forEach((val){
              storedItems.add(val);
            });
            count++;
            return items = response;
          } )):(AppDatabase.get()
        .getCenterFoundationList()
        .then((List<CenterDetailsBean> response) {
          return items ;
    } )),
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
        title: /*new Text(
          'Center foundation List',
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),*/

        appBarTitle,
          actions: <Widget>[
      new IconButton(
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
                      hintText: Translations.of(context).text('Search'),
                      hintStyle: new TextStyle(color: Colors.white)),
                  onChanged: (val) {
                    filterList(val.toLowerCase());
                  },
                );
              } else {
                this.actionIcon = new Icon(Icons.search);
                this.appBarTitle = new Text(Translations.of(context).text('Prospect_List')
                );
                items.clear();
                storedItems.forEach((val) {
                  items.add(val);
                });
              }
            });
          }),]
      ),
      floatingActionButton:
          widget.type != "Center Creation"
          ? null
        :new FloatingActionButton(
          child: new Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: Colors.green,
          onPressed: () {
            //if (widget.routeType == "Loan Application") {
              _addNewCenter();
            //}
            /*else if(widget.routeType=="CGT1"){
              _addNewCGT1();
            }else if(widget.routeType=="CGT2"){
              _addNewCGT2();
            }*/
          }),
      body: Center(
        child: futureBuilder,
      ),
    );
  }

  void _onTapItem(
      BuildContext context, CenterDetailsBean getCenterFoundationList) {

    if (widget.type == "Center Creation") {
      print("inside on tap gau det");
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new CenterFormationMaster(getCenterFoundationList)), //When Authorized Navigate to the next screen
      );
    }else{
      Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text(getCenterFoundationList.mCenterId.toString() +
              ' - ' +
              getCenterFoundationList.mcentername)));

      widget.centerName = getCenterFoundationList.mcentername;
      widget.centerNo = getCenterFoundationList.mCenterId.toString();
      globals.centerName = getCenterFoundationList.mcentername;
      globals.centerNo = getCenterFoundationList.mCenterId.toString();
      Navigator.of(context).pop(getCenterFoundationList);
      // Navigator.pop(context);
    }
  }

  void _addNewCenter() {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new CenterFormationMaster(null)) //When Authorized Navigate to the next screen
    );
  }


  void filterList(String val) {
    print("inside filterList");


      items.clear();
      storedItems.forEach((obj) {
        if (obj.mCenterId.toString().toLowerCase().contains(val) ||
            obj.mcentername.toLowerCase().contains(val)) {
          print("inside contains");
          print(items);
          items.add(obj);
        }
      });

    setState(() {});
  }
}
