import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/SpeedoMeter/SpeedoMeter.dart';
import 'package:eco_mfi/pages/workflow/SpeedoMeter/bean/SpeedoMeterBean.dart';
import 'package:intl/intl.dart';

class SpeedoMeterList extends StatefulWidget {
 // final cameras;

  SpeedoMeterList();

  @override
  _SpeedoMeterList createState() => new _SpeedoMeterList();
}

class _SpeedoMeterList extends State<SpeedoMeterList> {
  String usrName = "";
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();

  Future<bool> callDialog() {
    globals.Dialog.onPop(context, 'Are you sure?',
        'Do you want to Go To DashBoard',"SpeedoMeterList");
  }

  List<int> indicesList = new List<int>();
  List<SpeedoMeterBean> speedoMeterBean = new List<SpeedoMeterBean>();
  Widget appBarTitle = new Text("SpeedoMeter List");
  Icon actionIcon = new Icon(Icons.search);
  int count=1;

  @override
  void initState() {
    items.clear();
    super.initState();
  }

  List<SpeedoMeterBean> items = new List<SpeedoMeterBean>();
  List<SpeedoMeterBean> storedItems = new List<SpeedoMeterBean>();

  void filterList(String val) async{
    print("inside filterList");
    items.clear();
    items = new List<SpeedoMeterBean>();

    storedItems.forEach((obj) {
      if (obj.usrName.toString().contains(val) ||
          obj.effDate.toString().contains(val)
      ) {
        print("inside contains");
        print("items --" +items.toString());
        items.add(obj);
      }
    });

    setState(() {});
  }

  getHomePageBody2(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI2,
        padding: EdgeInsets.all(0.0),
      );
    }
  }

  Widget _getItemUI2(BuildContext context, int index) {
    print(items);
    String startingPoint= items[index].startingPoint.toString()!=null && items[index].startingPoint.toString()!='null'?items[index].startingPoint.toString():"";
    String endingPoint= items[index].endingPoint.toString()!=null && items[index].endingPoint.toString()!='null'?items[index].endingPoint.toString():"";
    String totMeterReading= items[index].totMeterReading.toString()!=null && items[index].totMeterReading.toString()!='null'?items[index].totMeterReading.toString():"";

    return new GestureDetector(
      onTap: () {
        _onTapItem(context, items[index]);
      },
      child: new Card(

        shape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0))),
          color: indicesList.contains(index)
              ? Color.fromRGBO(255, 255, 255, 0.5)
              : Colors.white,
          child:new ListTile(
            title: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.date_range,
                      color: Colors.green,
                      size: 20.0,
                    ),
                    new Text(
                        DateFormat("yyyy-MM-dd , hh:mm").format(items[index].effDate)
                        )
                  ],
                )
              ],
            ),
            subtitle: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.person,
                      color: Colors.yellow,
                      size: 30.0,
                    ),
                    Text(
                      "${items[index].usrName.toString()}\n",
                      style: TextStyle(
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[

                  ],
                )
              ],
            ),
            trailing: new Column(
              children: <Widget>[
                new Text(
                    "Start: ${startingPoint}"
                ),
                SizedBox(
                  height: 5.0,
                ),
                new Text(
                    "End: ${endingPoint}"
                ),
                SizedBox(
                    height: 5.0
                ),
                new Text(
                    "Distance: ${totMeterReading}"
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget build(BuildContext context) {
    var futureBuilderNotSynced;
    if(count == 1){
      count++;
      try {


        print(SpeedoMeterBean);
        futureBuilderNotSynced = new FutureBuilder(
            future: AppDatabase.get().selectSpeedoMeterList().then(
                    (List<SpeedoMeterBean> speedoMeterData){
                  items.clear();
                  storedItems.clear();
                  speedoMeterData.forEach((f){
                    items.add(f);
                    storedItems.add(f);
                  });
                  return storedItems;
                }),
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
                    return getHomePageBody2(context, snapshot);
              }
            });

      } catch (e) {
        futureBuilderNotSynced = new Text("Nothing To display");
      }
    }
    else if (items!=null) {
      futureBuilderNotSynced = ListView.builder(
        // Must have an item count equal to the number of items!
        itemCount: items.length,
        // A callback that will return a widget.
        itemBuilder: (context, position) {
          String startingPoint= items[position].startingPoint.toString()!=null && items[position].startingPoint.toString()!='null'?items[position].startingPoint.toString():"";
          String endingPoint= items[position].endingPoint.toString()!=null && items[position].endingPoint.toString()!='null'?items[position].endingPoint.toString():"";
          String totMeterReading= items[position].totMeterReading.toString()!=null && items[position].totMeterReading.toString()!='null'?items[position].totMeterReading.toString():"";
          // In our case, a DogCard for each doggo.
          return new GestureDetector(
            onTap: () {
              //usrName = items[position].usrName.toString();
              _onTapItem(context, items[position]);
            },
            child: new Card(
              shape: BeveledRectangleBorder(),
                color: indicesList.contains(position)
                    ? Color.fromRGBO(255, 255, 255, 0.5)
                    : Colors.white,
              child:new ListTile(
                title: new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Icon(
                          Icons.date_range,
                          color: Colors.green,
                          size: 20.0,
                        ),
                        new Text(
                            DateFormat("yyyy-MM-dd , hh:mm").format(items[position].effDate)
                           )
                      ],
                    )
                  ],
                ),
                subtitle: new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Icon(
                          Icons.person,
                          color: Colors.yellow,
                          size: 30.0,
                        ),
                        Text(
                          "${items[position].usrName.toString()}\n",
                          style: TextStyle(
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: new Column(
                  children: <Widget>[
                    new Text(
                        "Start: ${startingPoint}"
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    new Text(
                        "End: ${endingPoint}"
                    ),
                    SizedBox(
                        height: 5.0
                    ),
                    new Text(
                        "Distance: ${totMeterReading}"
                    ),
                  ],
                ),
              )
            ),
          );
        },
      );
    }else futureBuilderNotSynced = new Text("nothing to display");
    return WillPopScope(
        onWillPop: (){
          Navigator.of(context).pop();
        },
        child: new Scaffold(
          key: _scaffoldHomeState,
          appBar: new AppBar(
              elevation: 3.0,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              backgroundColor: Color(0xff07426A),
              brightness: Brightness.light,
              title: appBarTitle,
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
                              prefixIcon: new Icon(Icons.search, color: Colors.white),
                              hintText: "Search...",
                              hintStyle: new TextStyle(color: Colors.white)),
                          onChanged: (val) {
                            items = new List<SpeedoMeterBean>();
                            items.clear();
                            filterList(val.toLowerCase());
                          },
                        );
                      } else {
                        this.actionIcon = new Icon(Icons.search);
                        this.appBarTitle = new Text("SpeedoMeter List");
                        items = new List<SpeedoMeterBean>();
                        items.clear();
                        storedItems.forEach((val) {
                          items.add(val);
                        });
                      }
                    });
                  },
                ),
              ]
          ),
          floatingActionButton:new FloatingActionButton(
              child: new Icon(
                Icons.add,
                color: Colors.black,
              ),
              backgroundColor: Colors.green,
              onPressed: //_insertDummies
              loadNewSpeedoMeterRequestPage),
          body: futureBuilderNotSynced,
        )
    );}

  void loadNewSpeedoMeterRequestPage() async {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) =>
          new SpeedoMeter(
              SpeedoMeterPassedObject: null)
          //new SpeedoMeter(widget.cameras) //When Authorized Navigate to the next screen
      ),
    );
  }

  void printIt(String ab) {
    print(ab);
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Row(
        children: <Widget>[
          const CircularProgressIndicator(),
          new Text(message)
        ],
      ),
      duration: Duration(seconds: 20),
    ));
  }

  void showMessageWithoutProgress(String message,
      [MaterialColor color = Colors.red]) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  void _onTapItem(BuildContext context, SpeedoMeterBean obj) async
  {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
            new SpeedoMeter(
                SpeedoMeterPassedObject: obj)
          //new SpeedoMeter(widget.cameras),
        ));
  }

}


