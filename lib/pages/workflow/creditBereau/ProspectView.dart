//import 'dart:_http';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CbResultBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CreditBereauBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/ProspectViewBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/CreditBereauCallSubmisiion.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/app_constant.dart'
    as constant;
import 'package:eco_mfi/pages/workflow/creditBereau/CreditBereauResult.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/CheckExistingCustomerFromMiddleware.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart' as xml;

class ProspectView extends StatefulWidget {
  @override
  _ProspectView createState() => new _ProspectView();
}

class _ProspectView extends State<ProspectView>
    with SingleTickerProviderStateMixin {
  //List<GroupFormationMasterListViewBean> items = new List();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  String adhaarNo = "";
  Utility obj = new Utility();
  NetworkUtil _netUtil = new NetworkUtil();

  // List<ProspectViewBean> items2 = new List<ProspectViewBean>();
  bool chkFlag = false;
  bool delChoice = false;
  Color _cardColor = Colors.white;
  int count = 1;
  bool longPress = false;

  var url = "http://14.141.164.239:8090/ProspectCreationMaster/getlistOfData";
  /*var urlGetDataByAgentUserName =
      "http://14.141.164.239:8090/ProspectCreationMaster/getDataByAgentUserName/";*/
  var urlGet =
      "http://172.25.3.66:8090/ProspectCreationMaster/getDataByAgentUserNameAndIdAndCenterName";
  var urlAdd = "http://14.141.164.239:8090/ProspectCreationMaster/add/";
  // TabController _tabController;
  List<int> indicesList = new List<int>();
  List<CreditBereauBean> creditBereauList = new List<CreditBereauBean>();
  int _maxIndex = 0;
  TabController _tabController;
  Icon actionIcon = new Icon(Icons.search);
  Icon deleteIcon = new Icon(Icons.delete);
  Widget appBarTitle = new Text("Prospect List");
  var formatter = new DateFormat('dd/MM/yyyy');
  int lbrCode = 0;
  String username;

  SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(tabControllerListener);

    getSessionVariables();

/* setState(() {
_netUtil.getProspectList(url).then(
  (List<CreditBereauBean> response) => items = response);
 });*/
  }

  Future<Null> getSessionVariables()async{
    prefs = await SharedPreferences.getInstance();
    setState(() {
      lbrCode= prefs.getInt(TablesColumnFile.musrbrcode);
    });

  }

  void tabControllerListener() {
    setState(() {});
  }

  List<CreditBereauBean> items = new List<CreditBereauBean>();
  List<CreditBereauBean> items2 = new List<CreditBereauBean>();

  List<CreditBereauBean> storedNonCheckedRecords = new List<CreditBereauBean>();

  List<CreditBereauBean> storedCheckedRecords = new List<CreditBereauBean>();

  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null && items != null) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.all(0.0),
      );
    }
  }

  Widget _getItemUI(BuildContext context, int index) {
    return new GestureDetector(
        onTap: () {
          _navigateCbRsult(items[index]);
        },
        child: items == null
            ? new Text("nothing to display")
            : new Card(
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new ListTile(
                      leading: items[index].mcbcheckstatus.toString() ==
                                  "Pass" ||
                              items[index].mcbcheckstatus.toString() == "pass"
                          ? Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : Icon(
                              Icons.do_not_disturb,
                              color: Colors.red,
                            ),
                      title: new Text(
                        '${items[index].mprospectname}',
                        textScaleFactor: 0.9,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.blueAccent,
                        ),
                      ),
                      subtitle:Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0,),
                          Text('${items[index].mpanno}'),
                      new Text(


                          Translations.of(context).text('Highmrk_Dt')+
                            "${items[index].mhighmarkchkdt==null||items[index].mhighmarkchkdt=="null"?"":formatter.format(items[index].mhighmarkchkdt)}",
                        style: TextStyle(color: Colors.black,fontSize: 10.0),

                      )
                      ]
                      ),
                      trailing: Column(
                        children: <Widget>[
                          Text(
                              "${Constant.getProspectStatus(items[index].mprospectstatus)}"),
                          new Icon(
                            Icons.check,
                            color: items[index].mlastsynsdate==null||
                                items[index].mcreateddt.isAfter(items[index].mlastsynsdate)
                                ||items[index].mlastupdatedt.isAfter(items[index].mlastsynsdate)
                                ?Colors.grey:Colors.green,
                            size: 40.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }

  getHomePageBody2(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null && items2 != null) {
      return ListView.builder(
        itemCount: items2.length,
        itemBuilder: _getItemUI2,
        padding: EdgeInsets.all(0.0),
      );
    }
  }

  Widget _getItemUI2(BuildContext context, int index) {
    return new GestureDetector(
      onLongPress: () {
        setState(() {
          longPress = true;
        });

        _onTapItem(context, items2[index], index);
      },
      onTap: () {
        if (longPress == true)
          _onTapItem(context, items2[index], index);
        else
          editCustomer(context, items2[index]);
      },
      child: new Card(
          shape: BeveledRectangleBorder(),
          color: indicesList.contains(index)
              ? Color.fromRGBO(255, 255, 255, 0.5)
              : Colors.white,
          child: new ListTile(
            title: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.person,
                      color: Colors.yellow,
                      size: 30.0,
                    ),
                    new Text("  ${items2[index].mprospectname.toString()}"),
                  ],
                )
              ],
            ),
            subtitle: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Image(
                      image: new AssetImage("assets/aadhar.png"),
                      alignment: Alignment.center,
                      height: 40.0,
                      width: 30.5,
                    ),
                    new Text("  ${items2[index].mpanno.toString()}"),
                    SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.phone,
                      color: Colors.green,
                      size: 20.0,
                    ),
                    new Text("  ${items2[index].mmobno.toString()}"),
                  ],
                )
              ],
            ),
            trailing: Column(
              children: <Widget>[
                new

                  Text(Translations.of(context).text('Create_Dt')+formatter.format(items2[index].mcreateddt),
                    style: TextStyle(color: Colors.black,fontSize: 10.0),
                ),
                new Icon(
                  Icons.check,
                  color: items2[index].mlastsynsdate==null||
                      items2[index].mcreateddt.isAfter(items2[index].mlastsynsdate)
                      ||items2[index].mlastupdatedt.isAfter(items2[index].mlastsynsdate)
                      ?Colors.grey:Colors.green,
                  size: 40.0,

                ),
              ],
            ),
          )),
    );
  }

  Widget build(BuildContext context) {
    var futureBuilderNotSynced;

    if (count == 1) {
      count++;
      print("credit bereau list is null");
      print(creditBereauList);
      futureBuilderNotSynced = new FutureBuilder(
          future: AppDatabase.get()
              .getAllCbCheckEligibleProspect()
              .then((List<CreditBereauBean> result) {
            if (result != null) {
              result.forEach((obj) {
                storedNonCheckedRecords.add(obj);
                items2.add(obj);
              });

              return items2;
            } else
              return new Container();
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
                else {
                  if (items2 == null) {
                    return new Container(child: new Text(""));
                  } else
                    return getHomePageBody2(context, snapshot);
                }
            }
          });
    } else if (this.mounted == true && items2 != null) {
      print("credit bereau list is not null");
      print(creditBereauList.length);

      futureBuilderNotSynced = ListView.builder(
        itemCount: items2.length,
        itemBuilder: (context, position) {
          return new GestureDetector(
              onLongPress: () {
                setState(() {
                  longPress = true;
                });

                _onTapItem(context, items2[position], position);
              },
              onTap: () {
                if (longPress == true)
                  _onTapItem(context, items2[position], position);
                else
                  editCustomer(context, items2[position]);
              },
              child: new Card(
                  shape: BeveledRectangleBorder(),
                  color: indicesList.contains(position)
                      ? Color.fromRGBO(255, 255, 255, 0.5)
                      : Colors.white,
                  child: new ListTile(
                    title: new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.person,
                              color: Colors.yellow,
                              size: 30.0,
                            ),
                            new Text(
                                "  ${items2[position].mprospectname.toString()}"),
                          ],
                        )
                      ],
                    ),
                    subtitle: new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Image(
                              image: new AssetImage("assets/aadhar.png"),
                              alignment: Alignment.center,
                              height: 40.0,
                              width: 30.5,
                            ),
                            new Text("  ${items2[position].mpanno.toString()}"),
                            SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.phone,
                              color: Colors.green,
                              size: 20.0,
                            ),
                            new Text("  ${items2[position].mmobno.toString()}"),
                          ],
                        )
                      ],
                    ),
                    trailing:
                    Column(
                      children: <Widget>[


                        new  Text(Translations.of(context).text('Create_Dt')+formatter.format(items2[position].mcreateddt),
                          style: TextStyle(color: Colors.black,fontSize: 10.0),


                        ),
                        new Icon(
                          Icons.check,
                          color: items2[position].mlastsynsdate==null||
                          items2[position].mcreateddt.isAfter(items2[position].mlastsynsdate)
                              ||items2[position].mlastupdatedt.isAfter(items2[position].mlastsynsdate)
                              ?Colors.grey:Colors.green,
                          size: 40.0,
                        ),
                      ],
                    ),
                  )));
        },
      );
    } else
      futureBuilderNotSynced = new Text("Nothing to display");

    var futureBuilder;

    if (count == 2) {
      count++;
      futureBuilder = new FutureBuilder(
          future: AppDatabase.get()
              .getAllCreditMasterObjectsSynced()
              .then((List<CreditBereauBean> result) {
            if (result != null) {
              result.forEach((obj) {
                storedCheckedRecords.add(obj);
                items.add(obj);
              });

              return items;
            } else
              return new Container();
          }),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new Text('Press button to start');
              case ConnectionState.waiting:
                return new Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: new CircularProgressIndicator());
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else {
                  if (items == null)
                    return new Container(child: new Text(""));
                  else
                    return getHomePageBody(context, snapshot);
                }
            }
          });
    } else if (items != null) {
      futureBuilder = ListView.builder(
        // Must have an item count equal to the number of items!
        itemCount: items.length,
        // A callback that will return a widget.
        itemBuilder: (context, position) {
          // In our case, a DogCard for each doggo.
          return new GestureDetector(
              onTap: () {
                _navigateCbRsult(items[position]);
              },
              child: new Card(
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new ListTile(
                      leading:
                          items[position].mcbcheckstatus.toString() == "Pass" ||
                                  items[position].mcbcheckstatus.toString() ==
                                      "pass"
                              ? Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.do_not_disturb,
                                  color: Colors.red,
                                ),
                      title: new Text(
                        '${items[position].mprospectname}',
                        textScaleFactor: 0.9,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.blueAccent,
                        ),
                      ),
                      subtitle:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10.0,),
                            Text('${items[position].mpanno}'),
                            new Text(


                              Translations.of(context).text('Highmrk_Dt')+
                                  "${items[position].mhighmarkchkdt==null||items[position].mhighmarkchkdt=="null"?"":formatter.format(items[position].mhighmarkchkdt)}",
                              style: TextStyle(color: Colors.black,fontSize: 10.0),

                            )
                          ]
                      ),
                      trailing: Column(
                        children: <Widget>[
                          Text(
                              "${Constant.getProspectStatus(items[position].mprospectstatus)}"),
                          new Icon(
                            Icons.check,
                            color: items[position].mlastsynsdate==null||
                                items[position].mcreateddt.isAfter(items[position].mlastsynsdate)
                                ||items[position].mlastupdatedt.isAfter(items[position].mlastsynsdate)
                                ?Colors.grey:Colors.green,
                            size: 40.0,
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ));
        },
      );
    } else
      futureBuilder = new Text("nothing to display");

// }

    return new Scaffold(
      key: _scaffoldHomeState,
      appBar: new AppBar(
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            //callDialog();
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xff01579b),
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
                          prefixIcon:
                              new Icon(Icons.search, color: Colors.white),
                          hintText: Translations.of(context).text('Search'),
                          hintStyle: new TextStyle(color: Colors.white)),
                      onChanged: (val) {
                        filterList(val.toLowerCase(), _tabController.index);
                      },
                    );
                  } else {
                    this.actionIcon = new Icon(Icons.search);
                    this.appBarTitle = new Text(Translations.of(context).text('Prospect_List'));
                    items.clear();
                    items2.clear();
                    storedCheckedRecords.forEach((val) {
                      items.add(val);
                    });
                    storedNonCheckedRecords.forEach((val) {
                      items2.add(val);
                    });
                  }
                });
              }),
          new IconButton(
              icon: const Icon(
                Icons.file_upload,
                color: Colors.white,
                size: 44.0,
              ),
              onPressed: () {
                getHighmark(creditBereauList);
              },
              splashColor: Colors.blueAccent),
          new IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 44.0,
              ),
              onPressed: () {
                if (indicesList != null && indicesList.length != 0) {
                  deleteSelected();
                } else
                  showMessageWithoutProgress("Select some item to delete");
              },
              splashColor: Colors.blueAccent),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: new Container(
            child: new TabBar(
              controller: _tabController,
              indicatorColor: Colors.black,
              tabs: <Widget>[
                new Tab(
                  icon: new Icon(
                    Icons.add_circle,
                    color: Colors.white,
                    size: 22.0,
                  ),
                ),
                new Tab(
                    //text: "Stat TimeLine",
                    icon: new Icon(
                  Icons.verified_user,
                  color: Colors.white,
                  size: 22.0,
                )),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _tabController.index == 1
          ? null
          : longPress == true
              ? Center(
                  heightFactor: 1.0,
                  child: new FloatingActionButton(
                      child: new Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.grey,
                      onPressed: () {
                        setState(() {
                          indicesList.clear();
                          longPress = false;
                        });
                      }))
              : new FloatingActionButton(
                  child: new Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.green,
                  onPressed: () {
                    loadPage();
                  }),
      body: new TabBarView(controller: _tabController, children: <Widget>[
        Container(
          child: futureBuilderNotSynced,
        ),
        Container(
          child: futureBuilder,
        ),
      ]),
    );
  }

  void loadPage() {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new CreditBereauCallSubmisiion(
                CreditBeareauPassedObject: null,
              )),
    );
  }

  Future<bool> checkConnection() async {
    print("inside check Connection");
    var flag = await obj.checkIfIsconnectedToNetwork();
    _scaffoldHomeState.currentState.showSnackBar(new SnackBar(
        content:
            new Text(flag == true ? "You Are Online" : "You Are Offline")));
    print(flag);
    return flag;
  }

  void printIt(String ab) {
    print(ab);
  }

  void _onTapItem(BuildContext context, CreditBereauBean cbb, index) {
    bool isMatched = false;
    if (creditBereauList.length > 0 && creditBereauList.length > 0) {
      for (int i = 0; i < creditBereauList.length; i++) {
        print("inside for");
        if (!((creditBereauList[i].trefno == cbb.trefno) &&
            (creditBereauList[i].mrefno == cbb.mrefno))) {
          print("Checking");
        } else {
          print("xxxxxxxxxxxxxxxxxMatch Foundxxxxxxx");
          creditBereauList.removeAt(i);
          isMatched = true;
          print(creditBereauList);
          break;
        }
      }
      if (!isMatched) {
        print("XXXXXXXXXXXXXXmatch Not FOUND ADDINGxxxxxxxxxxxxxxxxx");
        creditBereauList.add(cbb);
        print(creditBereauList);
      }
    } else if (creditBereauList.length == 0) {
      print("Adding FOR tHE FIRST TIME");
      creditBereauList.add(cbb);
      print(creditBereauList);
    }

    setState(() {
      if (indicesList.contains(index)) {
        print("already have this index");
        indicesList.remove(index);
        print(creditBereauList);
      } else
        indicesList.add(index);
    });
  }

  void editCustomer(BuildContext context, CreditBereauBean obj) {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) =>
              new CreditBereauCallSubmisiion(CreditBeareauPassedObject: obj)),
    );
  }

  String headerSegment(String parmFor) {
    var builder = new xml.XmlBuilder();

    return builder.toString();
  }

  String fetchXmlData(CreditBereauBean cbb) {
    String tempadd = cbb.mhouse.toString() + " " + cbb.mstreet.toString();
    Duration dur = DateTime.now().difference(cbb.mdob);
    String age = (dur.inDays / 365).floor().toString();
    var formatter = new DateFormat('dd/MM/yyyy');
    String todayDate = formatter.format(DateTime.now());
    var dateformatter = new DateFormat('dd-MM-yyyy HH:mm:ss');

    print("inside getXml DATA");
    var builder = new xml.XmlBuilder();

    builder.element('REQUEST-REQUEST-FILE', nest: () {
      builder.element('HEADER-SEGMENT', nest: () {
        builder.element("SUB-MBR-ID", nest: constant.subMbrId);
        builder.element("INQ-DT-TM",
            nest: dateformatter.format(DateTime.now()));
        builder.element("REQ-VOL-TYP", nest: "C01");
        builder.element("REQ-ACTN-TYP", nest: "SUBMIT");
        builder.element("TEST-FLG", nest: "N");
        builder.element("AUTH-FLG", nest: "Y");
        builder.element("AUTH-TITLE", nest: "USER");
        builder.element("RES-FRMT", nest: "XML");
        builder.element("MEMBER-PRE-OVERRIDE", nest: "N");
        builder.element("RES-FRMT-EMBD", nest: "Y");

        builder.element("LOS-NAME", nest: "OMNI");
        builder.element("LOS-VENDER", nest: "INFRA");
        builder.element("LOS-VERSION", nest: "A102");

        builder.element("MFI", nest: () {
          builder.element("INDV", nest: "true");
          builder.element("SCORE", nest: "false");
          builder.element("GROUP", nest: "true");
        });
        /*builder.element("CONSUMER", nest: () {
          builder.element("INDV", nest: "false");
          builder.element("SCORE", nest: "false");
        });*/
        builder.element("IOI", nest: "false");
      });
      builder.element("INQUIRY", nest: () {
        builder.element("APPLICANT-SEGMENT", nest: () {
          builder.element("APPLICANT-NAME", nest: () {
            builder.element("NAME1", nest: cbb.mprospectname);
            builder.element("NAME2", nest: "");
            builder.element("NAME3", nest: "");
            builder.element("NAME4", nest: "");
            builder.element("NAME5", nest: "");
          });

          builder.element("DOB", nest: () {
            if (cbb.mdob != null)
              builder.element("DOB-DATE",
                  nest: "${formatter.format(cbb.mdob).toString()}");
            /*builder.element("AGE", nest: "${age.toString()}");
            builder.element("AGE-AS-ON", nest: "${todayDate}");*/
          });
          builder.element("IDS", nest: () {
            builder.element("ID", nest: () {
              builder.element("TYPE", nest: "ID03");
              builder.element("VALUE", nest: cbb.mpanno);
            });
            builder.element("ID", nest: () {
              builder.element("TYPE", nest: getIdCode(cbb.mid1));
              builder.element("VALUE", nest: cbb.mid1desc);
            });
          });
          builder.element("RELATIONS", nest: () {
            builder.element("RELATION", nest: () {
              builder.element("TYPE",
                  nest: getNomineeRelationship(cbb.mnomineerelation));
              builder.element("NAME", nest: cbb.mnomineename);
            });
          });
          builder.element("KEY-PERSON", nest: () {
            builder.element("TYPE",
                nest: getNomineeRelationship(cbb.mnomineerelation));
            builder.element("NAME", nest: cbb.mnomineename);
          });
          builder.element("NOMINEE", nest: () {
            builder.element("TYPE",
                nest: getNomineeRelationship(cbb.mnomineerelation));
            builder.element("NAME", nest: cbb.mnomineename);
          });

          builder.element("PHONES", nest: () {
            builder.element("PHONE", nest: () {
              builder.element("TELE-NO-TYPE", nest: "P03");
              // builder.element("TELE-NO", nest: cbb.mmobno.toString());
              builder.element("TELE-NO", nest: "8769387697");
            });
          });
        });
        builder.element("ADDRESS-SEGMENT", nest: () {
          builder.element("ADDRESS", nest: () {
            builder.element("TYPE", nest: "D01");
            builder.element("ADDRESS-1", nest: tempadd);
            builder.element("CITY", nest: cbb.mcity);
            builder.element("STATE", nest: getStateCode(cbb.mstate));
            builder.element("PIN", nest: cbb.mpincode);
          });
        });

        //builder.element('EMAIL', nest: "XXX");
        builder.element("APPLICATION-SEGMENT", nest: () {
          builder.element("INQUIRY-UNIQUE-REF-NO",
              nest: getInqUniqueRefNo(cbb));
          builder.element("CREDT-RPT-ID", nest: "CRDRQINQR");
          builder.element("CREDT-REQ-TYP", nest: "INDV");
          builder.element("CREDT-RPT-TRN-ID", nest: "XXXX");
          builder.element("CREDT-INQ-PURPS-TYP",
              nest: constant.creditInquiryPurposeTypeVal);
          builder.element("CREDT-INQ-PURPS-TYP-DESC", nest: "NOT REQUIRED");
          builder.element("CREDIT-INQUIRY-STAGE",
              nest: constant.creditInquiryStageVal);
          builder.element("CREDT-RPT-TRN-DT-TM",
              nest: dateformatter.format(DateTime.now()));

          builder.element("MBR-ID", nest: cbb.mcreatedby);
          builder.element("KENDRA-ID", nest: "k102");
          builder.element("BRANCH-ID", nest: cbb.mlbrcode);
          builder.element("LOS-APP-ID", nest: "a0Yf0000003fL7xEA456");
          builder.element("LOAN-AMOUNT", nest: "200000");
        });
      });
    });
    var bookshelfXml = builder.build();
    debugPrint(bookshelfXml.toXmlString(pretty: true, indent: '\t'));
    return bookshelfXml.toString();
  }

  String getNomineeRelationship(String relation) {
    print("inside getNomnee Relationship");
    String relationId = null;

    switch (relation.trim()) {
      case '7':
        relationId = "K01";
        break;
      case '21':
        relationId = "K02";
        break;
      case '6':
        relationId = "K03";
        break;
      case '9':
        relationId = "K04";
        break;
      case '8':
        relationId = "K05";
        break;
      case '22':
        relationId = "K06";
        break;
      case '2':
        relationId = "K07";
        break;
      case 'Mother-In-law':
        relationId = "K08";
        break;
      case '16':
        relationId = "K09";
        break;
      case '17':
        relationId = "K10";
        break;
      case 'Sister-In-Law':
        relationId = "K11";
        break;
      case 'Son-In-Law':
        relationId = "K12";
        break;

      case 'Brother-In-law':
        relationId = "K13";
        break;
      case 'Others':
        relationId = "K15";
        break;
      default:
        relationId = "K15";
    }

    return relationId;
  }

  /*String getNomineeRelationship(String relation) {
    print("inside getNomnee Relationship");
    String relationId = null;

    switch (relation) {
      case 'Father':
        relationId = "K01";
        break;
      case 'Husband':
        relationId = "K02";
        break;
      case 'Mother':
        relationId = "K03";
        break;
      case 'Son':
        relationId = "K04";
        break;
      case 'Daughter':
        relationId = "K05";
        break;
      case 'Wife':
        relationId = "K06";
        break;
      case 'Brother':
        relationId = "K07";
        break;
      case 'Mother-In-law':
        relationId = "K08";
        break;
      case 'Father-In-law':
        relationId = "K09";
        break;
      case 'Daughter-In-law':
        relationId = "K10";
        break;
      case 'Sister-In-Law':
        relationId = "K11";
        break;
      case 'Son-In-Law':
        relationId = "K12";
        break;

      case 'Brother-In-law':
        relationId = "K13";
        break;
      case 'Others':
        relationId = "K15";
        break;
      default:
        relationId = "K15";
    }

    return relationId;
  }*/

  Future<void> postTest(CreditBereauBean cbb) async {
    print("inside Post Test");
    print(constant.productType);
    var httpclient = new HttpClient();
    await httpclient.postUrl(Uri.parse(
        /* "https://test.crifhighmark.com/Inquiry/doGet.service/requestResponse"))*/
        constant.highmarkUrl)).then((HttpClientRequest request) {
      request.headers.set("requestXML", fetchXmlData(cbb));
      request.headers.set("Content-Type", "application/xml");
      /*request.headers.set("userId", "chmuat@saija.in");*/
      request.headers.set("userId", constant.highmarkUserId);
      /* request.headers
          .set("password", "ACA9F2284300A98B40524076DDA38290BEE3DDDF");*/
      request.headers.set("password", constant.highmarkPass);
      request.headers.set("mbrid", constant.mfiId);
      request.headers.set("SUB-MBR-ID", constant.subMbrId);
      request.headers.set("productType", 'INDV');
      request.headers.set("productVersion", '1.0');

      request.headers.set("reqVolType", "INDV");
      return request.close();
    }).then((HttpClientResponse response) async {
      /*print(response.statusCode);
      print(response.headers);*/
      String reply = await response.transform(utf8.decoder).join();
      print(reply);

      //var document =xml.parse(reply);

      var document;
      try {
        document = xml.parse(reply);
      } catch (_) {
        showMessageWithoutProgress(reply);
        return;
      }

      // try {
      var textual = document.descendants
          .where((node) => node is xml.XmlText && !node.text.trim().isEmpty)
          .join('\n');
      print("Data here ois " + textual);

      String inqUniqueRefNumber = document
          .findElements("REPORT-FILE")
          .first
          .findElements("INQUIRY-STATUS")
          .first
          .findElements("INQUIRY")
          .toList()[0]
          .findElements('INQUIRY-UNIQUE-REF-NO')
          .first
          .text;
      String responseDate = document
          .findElements("REPORT-FILE")
          .first
          .findElements("INQUIRY-STATUS")
          .first
          .findElements("INQUIRY")
          .toList()[0]
          .findElements('REQUEST-DT-TM')
          .first
          .text;

      String responseType = document
          .findElements("REPORT-FILE")
          .first
          .findElements("INQUIRY-STATUS")
          .first
          .findElements("INQUIRY")
          .toList()[0]
          .findElements('RESPONSE-TYPE')
          .first
          .text;

      if (responseType == "ERROR") {
        try {
          _scaffoldHomeState.currentState.hideCurrentSnackBar();
        } catch (_) {}
        String error = document
            .findElements("REPORT-FILE")
            .first
            .findElements("INQUIRY-STATUS")
            .first
            .findElements("INQUIRY")
            .toList()[0]
            .findElements('ERRORS')
            .toList()[0]
            .findElements('ERROR')
            .first
            .findElements('DESCRIPTION')
            .first
            .text;

        print("error");
        showMessageWithoutProgress("${error}");
        return;
      }

      String reportId = document
          .findElements("REPORT-FILE")
          .first
          .findElements("INQUIRY-STATUS")
          .first
          .findElements("INQUIRY")
          .toList()[0]
          .findElements('REPORT-ID')
          .first
          .text;

      print("xxxxxxx");
      print(reportId + inqUniqueRefNumber + responseDate);

      await createIndvIssuereq(reportId, inqUniqueRefNumber, responseDate, cbb);
      /* } catch (e) {
        try {
          String error = document
              .findElements("REPORT-FILE")
              .first
              .findElements("INQUIRY-STATUS")
              .first
              .findElements("INQUIRY")
              .toList()[0]
              .findElements('ERRORS')
              .toList()[0]
              .findElements('ERROR')
              .first
              .findElements('DESCRIPTION')
              .first
              .text;

          print("error");
          try {
            _scaffoldHomeState.currentState.hideCurrentSnackBar();
          } catch (_) {}
          showMessageWithoutProgress("${error}");
          return;
        } catch (e) {
          showMessageWithoutProgress("Something went Wrong");
        }
      }*/
    });
  }

  String getInqUniqueRefNo(CreditBereauBean cbb) {
    var formatter = new DateFormat('ddMMyyyyhhmmss');
    String formatted = formatter.format(DateTime.now());

    var rng = new Random();
    var randomNo = (rng.nextDouble() * 90000 + 10000).toInt();

    return constant.mfiId +
        formatted +
        cbb.trefno.toString() +
        cbb.mrefno.toString() +
        randomNo.toString();
  }

  Future<String> createIndvIssuereq(String reportId, String inqUniqueRefNumber,
      String responseDate, CreditBereauBean cbb) async {
    print("inside Create Indv Req");

    var builder = new xml.XmlBuilder();
    var dateformatter = new DateFormat('dd-MM-yyyy HH:mm:ss');

    builder.element('REQUEST-REQUEST-FILE', nest: () {
      builder.element('HEADER-SEGMENT', nest: () {
        builder.element("SUB-MBR-ID", nest: constant.subMbrId);
        builder.element("INQ-DT-TM",
            nest: dateformatter.format(DateTime.now()));
        builder.element("REQ-VOL-TYP", nest: "C01");
        // builder.element("REQ-ACTN-TYP", nest: "AT02");
        builder.element("REQ-ACTN-TYP", nest: "AT02");
        builder.element("TEST-FLG", nest: "N");
        builder.element("AUTH-FLG", nest: "Y");
        builder.element("AUTH-TITLE", nest: "USER");
        builder.element("RES-FRMT", nest: "XML");
        builder.element("MEMBER-PRE-OVERRIDE", nest: "N");
        builder.element("RES-FRMT-EMBD", nest: "Y");
      });

      builder.element('INQUIRY', nest: () {
        builder.element("INQUIRY-UNIQUE-REF-NO", nest: inqUniqueRefNumber);
        builder.element("REQUEST-DT-TM",
            nest: dateformatter.format(DateTime.now()));
        builder.element("REPORT-ID", nest: reportId);
      });
    });
    var bookshelfXml = builder.build();
    debugPrint("coming" + bookshelfXml.toString());
    debugPrint(bookshelfXml.toXmlString(pretty: true, indent: '\t'));
    await _mockService();
    await postTest2(bookshelfXml.toString(), cbb);
  }

  postTest2(String data, CreditBereauBean cbb) async {
    print("inside post2");
    var httpclient = new HttpClient();

    await httpclient.postUrl(Uri.parse(
        /*"https://test.crifhighmark.com/Inquiry/doGet.service/requestResponse"))*/
        constant.highmarkUrl)).then((HttpClientRequest request) {
      /*request.headers.set("userId", "chmuat@saija.in");*/
      request.headers.set("userId", constant.highmarkUserId);

      /* request.headers
          .set("password", "ACA9F2284300A98B40524076DDA38290BEE3DDDF");*/
      request.headers.set("password", constant.highmarkPass);
      request.headers.set("reqVolType", "INDV");
      request.headers.set("mbrid", constant.mfiId);
      request.headers.set("SUB-MBR-ID", constant.subMbrId);
      request.headers.set("productType", constant.productType);
      request.headers.set("productVersion", constant.productVersion);
      request.headers.set("requestXML", data.toString());
      print(data);
      return request.close();
    }).then((HttpClientResponse response) async {
      print("xxxxxxxxFinal Response");
      /*print(response.statusCode);//200 pass
      print(response.headers);*/
      String reply = await response.transform(utf8.decoder).join();
      var document = xml.parse(reply);
      debugPrint(document.toXmlString(pretty: true, indent: '\t'));

      await checkResponse(document, cbb);
    });
    return;
  }

  Future _mockService([dynamic error]) {
    print("Waiting");
    return new Future.delayed(const Duration(seconds: 30), () {
      if (error != null) {
        throw error;
      }
    });
  }

  Future<void> checkResponse(
      xml.XmlDocument document, CreditBereauBean cbb) async {
    String indvResponseStatus = "";
    String grpResponseStatus = "";
    List statusList = new List();
    List indvResponseList = new List();
    List grpResponseList = new List();
    int overdueAccountCounter = 0;
    int noOfOtherMfi = 0;
    /*String primaryOutstandingAmount = "0.0";
    String primarySanctionedAmount = "0.0";
    String secondaryOutstandingAmount = "0.0";
    String secondarySanctionedAmount = "0.0";
    String primaryCurrentBalance = "0.0";
    String secondaryCurrentBalance = "0.0";*/
    int prospectStatus;

    CbResultBean cbResult = new CbResultBean();
    List unqOthrMfiIdList = new List();
    List totalMfiList = new List();

    cbResult.mothrmficurbal = 0;
    cbResult.mothrmfiovrdueamt = 0.0;
    cbResult.mothrmfidisbamt = 0.0;
    cbResult.mmfitotovrdueamt = 0.0;
    cbResult.mmfitotcurrentbal = 0.0;
    cbResult.mmfitotdisbamt = 0.0;
    cbResult.mothrmficnt = 0;
    cbResult.mtotovrdueamt = 0.0;
    cbResult.mtotdisbamt = 0.0;
    cbResult.mtotcurrentbal = 0.0;
    cbResult.mtotovrdueaccno = 0;
    cbResult.mloancycle = 1;
    String cbBlob = document.toString().replaceAll("'" , "" );
    cbResult.mcbresultblob = cbBlob;
    //cbResult.mcbresultblob= " ";

    List<String> mfiIdList = new List<String>();
    var textual = document.descendants
        .where((node) => node is xml.XmlText && !node.text.trim().isEmpty)
        .join('\n');

    print("Data here ois " + textual);

    try {
      String responseType = document
          .findElements("INDV-REPORT-FILE")
          .first
          .findElements("INQUIRY-STATUS")
          .first
          .findElements("INQUIRY")
          .first
          .findElements("RESPONSE-TYPE")
          .first
          .text;

      if (responseType == "INPROCESS") {
        showMessageWithoutProgress("No Result from Highmark");
        return;
      }
    } catch (e) {
      print("Response found");
    }

    String dateOfReq = document
        .findElements("INDV-REPORT-FILE")
        .first
        .findElements("INDV-REPORTS")
        .first
        .findElements("INDV-REPORT")
        .first
        .findElements("HEADER")
        .first
        .findElements("DATE-OF-REQUEST")
        .first
        .text;
    String dateOfIssue = document
        .findElements("INDV-REPORT-FILE")
        .first
        .findElements("INDV-REPORTS")
        .first
        .findElements("INDV-REPORT")
        .first
        .findElements("HEADER")
        .first
        .findElements("DATE-OF-ISSUE")
        .first
        .text;

    String reportId = document
        .findElements("INDV-REPORT-FILE")
        .first
        .findElements("INDV-REPORTS")
        .first
        .findElements("INDV-REPORT")
        .first
        .findElements("HEADER")
        .first
        .findElements("REPORT-ID")
        .first
        .text;
    String preparedFor = document
        .findElements("INDV-REPORT-FILE")
        .first
        .findElements("INDV-REPORTS")
        .first
        .findElements("INDV-REPORT")
        .first
        .findElements("HEADER")
        .first
        .findElements("PREPARED-FOR")
        .first
        .text;

    try {
      String error = document
          .findElements("INDV-REPORT-FILE")
          .first
          .findElements("INDV-REPORTS")
          .first
          .findElements("INDV-REPORT")
          .first
          .findElements("INDV-RESPONSES")
          .first
          .findElements("SUMMARY")
          .first
          .findElements("ERRORS")
          .first
          .text;

      if (error != null) {
        showMessageWithoutProgress(error);
        return;
      }
    } catch (_) {}

    statusList = document
        .findElements("INDV-REPORT-FILE")
        .first
        .findElements("INDV-REPORTS")
        .first
        .findElements("INDV-REPORT")
        .first
        .findElements("STATUS-DETAILS")
        .first
        .findElements("STATUS")
        .toList();

    print("status List is $statusList");

    statusList.forEach((status) {
      if (status.findElements("OPTION").first.text == "MFI-INDV") {
        indvResponseStatus = status.findElements("OPTION-STATUS").first.text;
        print(status.findElements("OPTION-STATUS").first.text);
      }

      if (status.findElements("OPTION").first.text == "MFI-GRP") {
        grpResponseStatus = status.findElements("OPTION-STATUS").first.text;
        print(status.findElements("OPTION-STATUS").first.text);
      }
    });
/*

    int indvResponsesNo = int.parse(document
        .findElements("INDV-REPORT-FILE")
        .first
        .findElements("INDV-REPORTS")
        .first
        .findElements("INDV-REPORT")
        .first
        .findElements("INDV-RESPONSES")
        .first
        .findElements("SUMMARY")
        .first
        .findElements("TOTAL-RESPONSES")
        .first
        .text);

    int indvNoOfActAcc = int.parse(document
        .findElements("INDV-REPORT-FILE")
        .first
        .findElements("INDV-REPORTS")
        .first
        .findElements("INDV-REPORT")
        .first
        .findElements("INDV-RESPONSES")
        .first
        .findElements("SUMMARY")
        .first
        .findElements("NO-OF-ACTIVE-ACCOUNTS")
        .first
        .text);

    int indvDefault = int.parse(document
        .findElements("INDV-REPORT-FILE")
        .first
        .findElements("INDV-REPORTS")
        .first
        .findElements("INDV-REPORT")
        .first
        .findElements("INDV-RESPONSES")
        .first
        .findElements("SUMMARY")
        .first
        .findElements("NO-OF-DEFAULT-ACCOUNTS")
        .first
        .text);





int indvOtherMfiNo = int.parse(document
    .findElements("INDV-REPORT-FILE")
    .first
    .findElements("INDV-REPORTS")
    .first
    .findElements("INDV-REPORT")
    .first
    .findElements("INDV-RESPONSES")
    .first
    .findElements("SUMMARY")
    .first
    .findElements("NO-OF-OTHER-MFIS")
    .first
    .text );


    int grpOtherMfiNo = int.parse(document
        .findElements("INDV-REPORT-FILE")
        .first
        .findElements("INDV-REPORTS")
        .first
        .findElements("INDV-REPORT")
        .first
        .findElements("GRP-RESPONSES")
        .first
        .findElements("SUMMARY")
        .first
        .findElements("NO-OF-OTHER-MFIS")
        .first
        .text);


    int  grpResponsesNo = int.parse(document
        .findElements("INDV-REPORT-FILE")
        .first
        .findElements("INDV-REPORTS")
        .first
        .findElements("INDV-REPORT")
        .first
        .findElements("GRP-RESPONSES")
        .first
        .findElements("SUMMARY")
        .first
        .findElements("TOTAL-RESPONSES")
        .first
        .text);

     int grpNoOfActAcc = int.parse(document
         .findElements("INDV-REPORT-FILE")
         .first
         .findElements("INDV-REPORTS")
         .first
         .findElements("INDV-REPORT")
         .first
         .findElements("GRP-RESPONSES")
         .first
         .findElements("SUMMARY")
         .first
         .findElements("NO-OF-ACTIVE-ACCOUNTS")
         .first
         .text);

    String grpDefault = document
        .findElements("INDV-REPORT-FILE")
        .first
        .findElements("INDV-REPORTS")
        .first
        .findElements("INDV-REPORT")
        .first
        .findElements("GRP-RESPONSES")
        .first
        .findElements("SUMMARY")
        .first
        .findElements("NO-OF-DEFAULT-ACCOUNTS")
        .first
        .text;
*/

    print("xxxxxxxxx" +
        dateOfReq +
        "xxxxxxxxx" +
        dateOfIssue +
        "xxxxxxxxx" +
        reportId);

    List nameOfMFI = new List();
    List accountNumber = new List();
    List<double> disbursedAmount = new List<double>();
    List disbursedDate = new List();
    List<double> overdueAmount = new List<double>();
    List<double> currentBalance = new List<double>();
    List<double> writeOffAmount = new List<double>();
    List accountType = new List();
    List dateReported = new List();
    List totMfiIdList = new List();
   // List response = new List();





    if (indvResponseStatus == "SUCCESS") {
      indvResponseList = document
          .findElements("INDV-REPORT-FILE")
          .first
          .findElements("INDV-REPORTS")
          .first
          .findElements("INDV-REPORT")
          .first
          .findElements("INDV-RESPONSES")
          .first
          .findElements("INDV-RESPONSE-LIST")
          .first
          .findElements("INDV-RESPONSE")
          .toList();

      /* double indvOthrCurBal = double.parse(document
          .findElements("INDV-REPORT-FILE")
          .first
          .findElements("INDV-REPORTS")
          .first
          .findElements("INDV-REPORT")
          .first
          .findElements("INDV-RESPONSES")
          .first
          .findElements("SUMMARY")
          .first
          .findElements("TOTAL-OTHER-CURRENT-BALANCE")
          .first
          .text);

        double indvDisbAmt =  await double.parse(document
          .findElements("INDV-REPORT-FILE")
          .first
          .findElements("INDV-REPORTS")
          .first
          .findElements("INDV-REPORT")
          .first
          .findElements("INDV-RESPONSES")
          .first
          .findElements("SUMMARY")
          .first
          .findElements("TOTAL-OTHER-DISBURSED-AMOUNT")
          .first
          .text);*/

      for (int j = 0; j < indvResponseList.length; j++) {
        try {
          double overdueamt;
          double currBal;
          double disbAmt;
          String status;
          try {
            overdueamt = double.parse(indvResponseList[j]
                .findElements("LOAN-DETAIL")
                .first
                .findElements("OVERDUE-AMT")
                .first
                .text);
          } catch (_) {
            overdueamt = 0.0;
          }

          try {
            currBal = double.parse(indvResponseList[j]
                .findElements("LOAN-DETAIL")
                .first
                .findElements("CURRENT-BAL")
                .first
                .text);
          } catch (_) {
            currBal = 0.0;
          }
          try {
            disbAmt = double.parse(indvResponseList[j]
                .findElements("LOAN-DETAIL")
                .first
                .findElements("DISBURSED-AMT")
                .first
                .text);
          } catch (_) {
            disbAmt = 0.0;
          }

          String mfiId = indvResponseList[j].findElements("MFI-ID").first.text;

          status = indvResponseList[j]
              .findElements("LOAN-DETAIL")
              .first
              .findElements("STATUS")
              .first
              .text;

          print("response----------------");
          print(mfiId);

          cbResult.mtotovrdueamt += overdueamt;
          cbResult.mtotdisbamt += disbAmt;
          cbResult.mtotcurrentbal += currBal;

          if (mfiId.substring(0, 3) == "MFI") {
            cbResult.mmfitotovrdueamt += overdueamt;
            cbResult.mmfitotcurrentbal += currBal;
            cbResult.mmfitotdisbamt += disbAmt;

            if (mfiId != constant.mfiId) {
              cbResult.mothrmficurbal += currBal;
              cbResult.mothrmfiovrdueamt += overdueamt;
              cbResult.mothrmfidisbamt += disbAmt;
              if (!unqOthrMfiIdList.contains(mfiId) &&
                  (indvResponseList[j]
                              .findElements("LOAN-DETAIL")
                              .first
                              .findElements("STATUS")
                              .first
                              .text)
                          .toString()
                          .toLowerCase() ==
                      "active") {
                cbResult.mothrmficnt++;
                unqOthrMfiIdList.add(mfiId);
              }
            }
          }

          if (overdueamt > 0.0 || currBal > 0.0) {
            mfiIdList
                .add(indvResponseList[j].findElements("MFI-ID").first.text);
            nameOfMFI.add(indvResponseList[j].findElements("MFI").first.text);
            accountNumber.add(indvResponseList[j]
                .findElements("LOAN-DETAIL")
                .first
                .findElements("ACCT-NUMBER")
                .first
                .text);
            dateReported.add(indvResponseList[j]
                .findElements("LOAN-DETAIL")
                .first
                .findElements("INFO-AS-ON")
                .first
                .text);
            try {
              disbursedAmount.add(disbAmt);
            } catch (e) {
              disbursedAmount.add(0.0);
            }
	    totMfiIdList.add(mfiId);

            disbursedDate.add(indvResponseList[j]
                .findElements("LOAN-DETAIL")
                .first
                .findElements("DISBURSED-DT")
                .first
                .text);
            try {
              overdueAmount.add(overdueamt);
            } catch (e) {
              overdueAmount.add(0.0);
            }

            currentBalance.add(currBal);
            writeOffAmount.add(double.parse(indvResponseList[j]
                .findElements("LOAN-DETAIL")
                .first
                .findElements("WRITE-OFF-AMT")
                .first
                .text));
            accountType.add(indvResponseList[j]
                .findElements("LOAN-DETAIL")
                .first
                .findElements("ACCT-TYPE")
                .first
                .text);
            /*cbResult.mtotovrdueamt +=overdueAmount.last;
            cbResult.mtotdisbamt +=disbursedAmount.last;
            cbResult.mtotcurrentbal +=currentBalance.last;*/

            if (overdueamt > 0.0) cbResult.mtotovrdueaccno++;
          }
        } catch (e) {
          print("Indv Loop exception");
        }
      }
    }
    if (grpResponseStatus == "SUCCESS") {
      grpResponseList = document
          .findElements("INDV-REPORT-FILE")
          .first
          .findElements("INDV-REPORTS")
          .first
          .findElements("INDV-REPORT")
          .first
          .findElements("GRP-RESPONSES")
          .first
          .findElements("GRP-RESPONSE-LIST")
          .first
          .findElements("GRP-RESPONSE")
          .toList();

      /*secondaryOutstandingAmount = document
          .findElements("INDV-REPORT-FILE")
          .first
          .findElements("INDV-REPORTS")
          .first
          .findElements("INDV-REPORT")
          .first
          .findElements("GRP-RESPONSES")
          .first
          .findElements("SUMMARY")
          .first
          .findElements("TOTAL-OTHER-CURRENT-BALANCE")
          .first
          .text;*/

      for (int j = 0; j < grpResponseList.length; j++) {
        try {
          double overdueamt = 0.0;
          double currBal = 0.0;
          double disbAmt = 0.0;
          String status;

          try {
            overdueamt = double.parse(grpResponseList[j]
                .findElements("LOAN-DETAIL")
                .first
                .findElements("OVERDUE-AMT")
                .first
                .text);
          } catch (_) {
            overdueamt = 0.0;
          }

          try {
            currBal = double.parse(grpResponseList[j]
                .findElements("LOAN-DETAIL")
                .first
                .findElements("CURRENT-BAL")
                .first
                .text);
          } catch (_) {
            currBal = 0.0;
          }

          try {
            disbAmt = double.parse(grpResponseList[j]
                .findElements("LOAN-DETAIL")
                .first
                .findElements("DISBURSED-AMT")
                .first
                .text);
          } catch (_) {
            disbAmt = 0.0;
          }

          status = indvResponseList[j]
              .findElements("LOAN-DETAIL")
              .first
              .findElements("STATUS")
              .first
              .text();

          String mfiId = grpResponseList[j].findElements("MFI-ID").first.text;

          cbResult.mtotovrdueamt += overdueamt;
          cbResult.mtotdisbamt += disbAmt;
          cbResult.mtotcurrentbal += currBal;

          if (mfiId.substring(0, 3) == "MFI") {
            cbResult.mmfitotovrdueamt += overdueamt;
            cbResult.mmfitotcurrentbal += currBal;
            cbResult.mmfitotdisbamt += disbAmt;

            if (mfiId != constant.mfiId) {
              cbResult.mothrmficurbal += currBal;
              cbResult.mothrmfiovrdueamt += overdueamt;
              cbResult.mothrmfidisbamt += disbAmt;
              if (!unqOthrMfiIdList.contains(mfiId) &&
                  (indvResponseList[j]
                              .findElements("LOAN-DETAIL")
                              .first
                              .findElements("STATUS")
                              .first
                              .text)
                          .toString()
                          .toLowerCase() ==
                      "active") {
                cbResult.mothrmficnt++;
                unqOthrMfiIdList.add(mfiId);
              }
            }
          }
          if (overdueamt > 0.0 || currBal > 0.0) {
            mfiIdList.add(grpResponseList[j].findElements("MFI-ID").first.text);
            nameOfMFI.add(mfiId);
	    totMfiIdList.add(mfiId);
            accountNumber.add(grpResponseList[j]
                .findElements("LOAN-DETAIL")
                .first
                .findElements("ACCT-NUMBER")
                .first
                .text);
            dateReported.add(grpResponseList[j]
                .findElements("LOAN-DETAIL")
                .first
                .findElements("INFO-AS-ON")
                .first
                .text);
            disbursedAmount.add(disbAmt);
            disbursedDate.add(grpResponseList[j]
                .findElements("LOAN-DETAIL")
                .first
                .findElements("DISBURSED-DT")
                .first
                .text);
            overdueAmount.add(overdueamt);
            currentBalance.add(currBal);
            writeOffAmount.add(double.parse(grpResponseList[j]
                .findElements("LOAN-DETAIL")
                .first
                .findElements("WRITE-OFF-AMT")
                .first
                .text));
            accountType.add(grpResponseList[j]
                .findElements("LOAN-DETAIL")
                .first
                .findElements("ACCT-TYPE")
                .first
                .text);

            if (overdueamt > 0.0) cbResult.mtotovrdueaccno++;
          }
        } catch (_) {
          print("group Loop exception");
        }
      }
    }

/*    for(int mfiCount=0;mfiCount>mfiIdList.length;mfiCount++){
        //MfiSpecific
      if(mfiIdList[mfiCount].substring(0,3)=="MFI"){

        cbResult.mmfitotovrdueamt +=  overdueAmount[mfiCount];
        cbResult.mmfitotcurrentbal+= currentBalance[mfiCount];
        cbResult.mmfitotdisbamt+= disbursedAmount[mfiCount];

        if(unqOthrMfiIdList.contains(mfiIdList[mfiCount])&&mfiIdList[mfiCount]!=constant.mfiId){
          cbResult.mothrmficnt++;
          unqOthrMfiIdList.add(mfiIdList[mfiCount]);

        }

        if(mfiIdList[mfiCount]!=constant.mfiId){
          cbResult.mothrmficurbal+=currentBalance[mfiCount];
          cbResult.mothrmfiovrdueamt+=overdueAmount[mfiCount];
          cbResult.mothrmfidisbamt+=disbursedAmount[mfiCount];

        }
      }

    }*/

    double maxRange;
    switch (cbb.mtier) {
      case 1:
        maxRange = 60000.0;
        break;
      case 2:
        maxRange = 80000.0;
        break;
      case 3:
        maxRange = 80000.0;
        break;
      case 4:
        maxRange = 80000.0;
        break;
      case 5:
        maxRange = 80000.0;
        break;
      case 6:
        maxRange = 80000.0;
        break;
      case 7:
        maxRange = 80000.0;
        break;
      case 8:
        maxRange = 80000.0;
        break;
      default:
        maxRange = 80000.0;
    }
    if(cbResult.mothrmficurbal<maxRange){
      cbResult.mexpsramt = maxRange-cbResult.mothrmficurbal;
    } else
      cbResult.mexpsramt = 0.0;

    int noOfReqMfi = 1;

    try{
      if(lbrCode!=0&&lbrCode!=null){
        SystemParameterBean sysBean = await AppDatabase.get().getSystemParameter('20',lbrCode);
        if(sysBean!=null&&sysBean.mcodevalue!=null&&sysBean.mcodevalue!=0
            &&sysBean.mcodevalue.trim()!="0"){
          noOfReqMfi = int.parse(sysBean.mcodevalue);
        }

      }



    }catch(_){

    }
    String cbCheckStatus;
    if (cbResult.mothrmficurbal > 100000.0 ||
        unqOthrMfiIdList.length > noOfReqMfi||
        cbResult.mtotovrdueamt >0.0||
        (cbResult.mtotovrdueamt>0||
            cbResult.mexpsramt<3000.0
	    )) {
      cbCheckStatus = "Fail";
    } else
      cbCheckStatus = "Pass";

    /*print(nameOfMFI);
    print(accountNumber);
        print(disbursedAmount );
    print(disbursedDate);
    print("required--------");
        print(overdueAmount);
    print(currentBalance );
        print(writeOffAmount);
    print(accountType);
        print(dateReported);*/

    cbResult.trefno = cbb.trefno;
    cbResult.mrefno = cbb.mrefno;

    cbResult.mcbcheckstatus = cbCheckStatus;
    cbResult.mdateofrequest = dateOfReq;
    cbResult.mpreparedfor = preparedFor;
    cbResult.mdateofissue = dateOfIssue;
    cbResult.mreportid = reportId;
    cbResult.mcreateddt = DateTime.now();

    print(cbResult);
/*
    cbResult.mprimarynoofaccounts = noOfPrimaryLoanAccounts;
    cbResult.mprimarynoofactiveacs = noOfPrimaryActiveAccounts;
    cbResult.mprimarynoofodaccs = noOfPrimaryOverdueAccounts;
    cbResult.mprimaryoverdueamount = primaryOutstandingAmount;
    cbResult.mprimarycurrentbal = primaryCurrentBalance;
    cbResult.msecondarynoofaccs = noOfSecondaryAccounts;
    cbResult.msecondaryoverdueamount = secondaryOutstandingAmount;
    cbResult.msecondarynoofactiveaccs = noOfSecondaryActiveAccounts;
    cbResult.msecondarynoofodacs = noOfSecondaryOverdueAccounts;
    cbResult.msecondarycurrentbalance = secondaryCurrentBalance;
    cbResult.msecondarysanctionedamt = secondarySanctionedAmount;
*/

    await AppDatabase.get().updateCreditBereauResult(cbResult).then((val) {

      //if(cbCheckStatus=="Fail"){
      if(nameOfMFI.isNotEmpty){

        print("updating loan");

        for (int i = 0; i < nameOfMFI.length; i++) {
          cbResult.maccountNumber = accountNumber[i];
          cbResult.mnameofmfi = nameOfMFI[i];
          cbResult.mdatereported = dateReported[i];
          cbResult.mdisbursedamount = disbursedAmount[i];
          cbResult.moverdueamount = overdueAmount[i];
          cbResult.mcurrentbalance = currentBalance[i];
          cbResult.mwriteoffamount = writeOffAmount[i];
          cbResult.maccounttype = accountType[i];
          cbResult.mnocimagestring = "";
          cbResult.mmfiid =  totMfiIdList[i];
          AppDatabase.get()
              .updateCreditBereauLoanDetailsWithLoanSeq(cbResult, i + 1);
        }
      }
    });

    if (cbCheckStatus == "Pass")
      prospectStatus = 2;
    else
      prospectStatus = 3;

    AppDatabase.get().updateCreditBereauMasterFromtTrefNo(
        cbb.trefno,
        cbb.mrefno,
        cbCheckStatus,
        prospectStatus,
        DateTime.now(),
        cbResult.mcreateddt);

    showMessageWithoutProgress("CB Check done");
  }

  void deleteCbResultData() {
    AppDatabase.get().deleteCbResultData();
  }

  Future<void> getHighmark(List<CreditBereauBean> creditList) async {
    print("xxxxxxxinside higmark");

    if (indicesList.length == 0) {
      showMessageWithoutProgress("Select Prospect to upload");
      return;
    }

    bool netAvail = false;
    netAvail = await obj.checkIfIsconnectedToNetwork();
    if (netAvail == false) {
      showMessageWithoutProgress("Network Not available");
      return;
    }

    if (creditList != null) {
      ChkExstngCustFrmMiddleware checkList = new ChkExstngCustFrmMiddleware();

      for (int i = 0; i < creditList.length; i++) {
        print(creditList[i]);

        try {
          _scaffoldHomeState.currentState.hideCurrentSnackBar();
        } catch (e) {}

        if (creditList[i].miscustcreated == null ||
            creditList[i].miscustcreated == 0) {
          showMessage(
              "Checking if ID alredy registred for ${creditList[i].mprospectname}");
          CustomerCheckBean custBean =
              await checkList.checkExistingCustomer(creditList[i]);

          if (custBean != null) {
            showMessageWithoutProgress(
                "Customer Exist with name ${custBean.mlongname}");
          } else {
            showMessageWithoutProgress("No Customer with speccified Id");
            showMessage(
                "  Getting highmark call for ${creditList[i].mprospectname}");
            await postTest(creditList[i]);
          }
        } else {
          showMessage(
              "  Getting highmark call for ${creditList[i].mprospectname}");
          await postTest(creditList[i]);
        }
      }

      if (this.mounted == true) {
        setState(() {
          indicesList.clear();
          creditBereauList.clear();
          items.clear();
          items2.clear();
          count = 1;
        });
      }
    }
  }

  String getMonthCode() {}

  String getStateCode(String state) {
    String stateCode = "";

    switch (state.trim()) {
      case ('Andhra Pradesh'):
        stateCode = 'AP';
        break;

      case ('Arunachal Pradesh'):
        stateCode = 'AR';
        break;
      case ('Assam'):
        stateCode = 'AS';
        break;
      case ('Bihar'):
        stateCode = 'BR';
        break;
      case ('Chattisgarh'):
        stateCode = 'CG';
        break;
      case ('Goa'):
        stateCode = 'GA';
        break;
      case ('Gujarat'):
        stateCode = 'GJ';
        break;
      case ('Haryana'):
        stateCode = 'HR';
        break;
      case ('Himachal Pradesh'):
        stateCode = 'HP';
        break;
      case ('Jammu & Kashmir'):
        stateCode = 'JK';
        break;
      case ('Jharkhand'):
        stateCode = 'JH';
        break;
      case ('Karnataka'):
        stateCode = 'KA';
        break;
      case ('Kerala'):
        stateCode = 'KL';
        break;
      case ('Madhya Pradesh'):
        stateCode = 'MP';
        break;
      case ('Maharashtra'):
        stateCode = 'MH';
        break;
      case ('Manipur'):
        stateCode = 'MN';
        break;
      case ('Meghalaya'):
        stateCode = 'ML';
        break;
      case ('Mizoram'):
        stateCode = 'MZ';
        break;
      case ('Nagaland'):
        stateCode = 'NL';
        break;
      case ('Orissa'):
        stateCode = 'OR';
        break;
      case ('Punjab'):
        stateCode = 'PB';
        break;
      case ('Rajasthan'):
        stateCode = 'RJ';
        break;
      case ('Sikkim'):
        stateCode = 'SK';
        break;
      case ('Tamil Nadu'):
        stateCode = 'TN';
        break;
      case ('Telangana'):
        stateCode = 'TS';
        break;
      case ('Tripura'):
        stateCode = 'TR';
        break;
      case ('Uttarakhand'):
        stateCode = 'UK';
        break;
      case ('Uttar Pradesh'):
        stateCode = 'UP';
        break;
      case ('West Bengal'):
        stateCode = 'WB';
        break;
      case ('Andaman & Nicobar'):
        stateCode = 'AN';
        break;
      case ('Chandigarh'):
        stateCode = 'CH';
        break;
      case ('Dadra and Nagar Haveli'):
        stateCode = 'DN';
        break;
      case ('Daman & Diu'):
        stateCode = 'DD';
        break;
      case ('Delhi'):
        stateCode = 'DL';
        break;
      case ('Lakshadweep'):
        stateCode = 'LD';
        break;
      case ('Pondicherry'):
        stateCode = 'PY';
        break;
        default:stateCode = 'BR';
        break;
    }
    return stateCode;
  }

  String getIdCode(String id) {
    String idCode = "";

    switch (id.trim()) {
      case ('Passport'):
        idCode = 'ID01';
        break;
      case ('2'):
        idCode = 'ID02';
        break;
      case ('1'):
        idCode = 'ID03';
        break;
      case ('Others'):
        idCode = 'ID04';
        break;
      case ('6'):
        idCode = 'ID05';
        break;
      case ('3'):
        idCode = 'ID06';
        break;
      case ('Pan'):
        idCode = 'ID07';
        break;
      default:
        idCode = 'D04';
    }
    return idCode;
  }

/*

  String getIdCode(String id) {
    String idCode = "";

    switch (id) {
      case ('Passport'):
        idCode= 'ID01';
        break;
      case ('Voter ID'):
        idCode= 'ID02';
        break;
      case ('UID'):
        idCode= 'ID03';
        break;
      case ('Others'):
        idCode= 'ID04';
        break;
      case ('Ration Card'):
        idCode= 'ID05';
        break;
      case ('Driving License No'):
        idCode= 'ID06';
        break;
      case ('Pan'):
        idCode= 'ID07';
        break;
    }
    return idCode;
  }
*/

  Future deleteSelected() async {
    if (creditBereauList != null && creditBereauList != []) {
      print(creditBereauList);
      _neverSatisfied().then((val) {
        if (delChoice == false) {
          return;
        }
        for (int i = 0; i < creditBereauList.length; i++) {
          AppDatabase.get().deleteSelected(creditBereauList[i]).then((val) {
            if (!mounted) return;
            setState(() {
              count = 1;
              indicesList.clear();

              creditBereauList.clear();
              delChoice = false;
              items.clear();
              items2.clear();
            });
          });
        }
      });
    } else {
      showMessage("Please Select  some to delete");
    }
  }

  /*Future<CreditBereauBean> futureObject() async {
    if (count == 1) {
      await AppDatabase.get()
          .getAllCreditMasterObjectsNotSynced()
          .then((List<CreditBereauBean> afterLogin) => items2 = afterLogin);

      print(items2);
    }
  }*/

  Widget _navigateCbRsult(CreditBereauBean cbb) {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new CreditBereauResult(
                CreditBeareauPassedObject: cbb,
              )),
    );
  }

  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Selected'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete the selected item')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                delChoice = true;
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'Cancel',
              ),
              onPressed: () {
                delChoice = false;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void navigateToResult() {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new CreditBereauCallSubmisiion(
                CreditBeareauPassedObject: null,
              )),
    );
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
      duration: Duration(seconds: 35),
    ));
  }

  void showMessageWithoutProgress(
    String message,
  ) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    if (this.mounted == true) {
      _scaffoldHomeState.currentState
          .showSnackBar(new SnackBar(content: Container(
          height: 30.0,
          child: new Column(children: <Widget>[new Text(message)]))));
    }
  }

  Future<bool> callDialog() async {
    print("this is ${this.mounted}");
    await globals.Dialog.onWillPop(
      context,
      'Are you sure?',
      'Do you want to Go To DashBoard without saving data',
      'Dashboard',
    );
    print("this is ${this.mounted}");
  }

  void filterList(String val, int index) {
    print("inside filterList");

    print("index is" + index.toString());

    if (index == 1) {
      items.clear();
      storedCheckedRecords.forEach((obj) {
        if (obj.mprospectname.toLowerCase().contains(val) ||
            obj.mpanno.contains(val)) {
          print("inside contains");
          print(items);
          items.add(obj);
        }
      });
    } else if (index == 0) {
      items2.clear();
      storedNonCheckedRecords.forEach((obj) {
        print(obj.mprospectname);
        if (obj.mprospectname.toLowerCase().contains(val) ||
            obj.mpanno.toString().contains(val)) {
          print("inside contains");
          items2.add(obj);
        }
      });
    }

    setState(() {});
  }
}
