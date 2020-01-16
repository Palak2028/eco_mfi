import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/ThemeDesign.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';

import 'dart:convert';
import 'dart:async';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';
import 'package:eco_mfi/pages/workflow/collection/DailyCollectionSearchScreen.dart';
import 'package:eco_mfi/pages/workflow/collection/bean/CollectionMasterBean.dart';
import 'package:eco_mfi/translations.dart';

class SavingsCollectionList extends StatefulWidget {
  final int mcenterid;
  final int mgroupid;
  final int custNo;
  final int productNo;
  final int paginationCount;
  final int custmrefno;
  final int custtrefno;

  SavingsCollectionList(this.mcenterid, this.mgroupid,this.custNo, this.productNo, this.paginationCount,this.custtrefno,this.custmrefno);

  @override
  _SavingsCollectionList createState() => new _SavingsCollectionList();
}

class _SavingsCollectionList extends State<SavingsCollectionList> {
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  List<SavingsListBean> items = new List<SavingsListBean>();
  List<SavingsListBean> storedItems = new List<SavingsListBean>();
  Widget appBarTitle = new Text("Savings Collection List");
  Icon actionIcon = new Icon(Icons.save);
  int count = 1;
  int cardsCount = 0;
  int pageCount = 0;
  int forwardClicks = 1;
  int paginationCount;
  int lastPagelistCount;
  bool dontIncForwrd = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("widget.paginationCount " + widget.paginationCount.toString());
    paginationCount = widget.paginationCount;
    print("widget.paginationCount " + paginationCount.toString());
    if (paginationCount == null || paginationCount == '') {
      paginationCount = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilderNotSynced;
    if (count == 1) {
      count++;
      try {
        //print(CustomerListBean);
        futureBuilderNotSynced = new FutureBuilder(
            future: AppDatabase.get()
                .selectSavingsList(
                widget.mcenterid,
                widget.mgroupid,
                widget.custNo,
                widget.productNo,
            widget.custtrefno,
            widget.custmrefno)
                .then((List<SavingsListBean> savingsListBean) {
              items.clear();
              storedItems.clear();
              savingsListBean.forEach((f) {
                storedItems.add(f);
              });
              print("storedItems.length"+storedItems.length.toString());
              if(paginationCount>1 && storedItems.length>paginationCount) {
                double tempPagination = storedItems.length / paginationCount;
                pageCount = tempPagination.toInt();
                lastPagelistCount = storedItems.length % paginationCount;
                //  print(" storedItems "+ f.mprdacctid);
                if (lastPagelistCount > 0) {
                  pageCount += 1;
                }

                for (int showItems = 0;
                showItems < paginationCount;
                showItems++) {
                  items.add(storedItems[showItems]);
                }
              }else{
                items.addAll(storedItems);
              }
              setState(() {});
              return storedItems;
            }),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return new Text(Translations.of(context).text('Press_Button_To_Start'));
                case ConnectionState.waiting:
                  return new Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16.0),
                      child:
                      new CircularProgressIndicator()); // new Text('Awaiting result...');
                default:
                  if (snapshot.hasError) {
                    print(Translations.of(context).text('error')+"${snapshot.error}");
                    return new Center(

                      child:  new Text(Translations.of(context).text('Nothing_To_Display_On_Your_Filter')),
                    );
                  }
                  else
                    return getHomePageBody2(context, snapshot);
              }
            });
      } catch (e) {
        futureBuilderNotSynced = new Text(Translations.of(context).text('Nothing_To_Display'));
      }
    } else if (items != null) {
      futureBuilderNotSynced = ListView.builder(
        // Must have an item count equal to the number of items!
        itemCount: items.length,
        // A callback that will return a widget.
        itemBuilder: (context, position) {
          Color color;
          if (position % 2 == 1) {
            color = Colors.grey;
          } else {
            color = Colors.grey;
          }
          int mcustNoInt=0;
          int mprcdAcctIdInt=0;
          String mprdcd="";
          String custNo="";
          String prcdAcctId="";
          if(items[position].mprdacctid!=null && items[position].mprdacctid.trim()!='null' && items[position].mprdacctid.trim()!=''){
             mprdcd = items[position].mprdacctid.substring(0, 8).trim();
             custNo = items[position].mprdacctid.substring(9, 16);
             prcdAcctId = items[position].mprdacctid.substring(17, 24);
          }


          try {
            if (custNo != null && custNo != 'null' && custNo != '') {
              mcustNoInt = int.parse(custNo);
            }
            if (prcdAcctId != null && prcdAcctId != 'null' && prcdAcctId != '') {
              mprcdAcctIdInt = int.parse(prcdAcctId);
            }
          } catch (_) {}
          if(items[position].mrefno!=null && items[position].mrefno!='null' && items[position].mrefno!='') {
            items[position].msvngaccmrefno = items[position].mrefno;
          }
          if(items[position].trefno!=null && items[position].trefno!='null' && items[position].trefno!='') {
            items[position].msvngacctrefno = items[position].trefno;
          }
          /* print("prdcd "+ mprdcd.toString());
          print("custNo "+ custNo.toString());
          print("prcdAcctId "+ prcdAcctId.toString());*/
          // In our case, a DogCard for each doggo.
          return new GestureDetector(
              child: Column(
                children: <Widget>[
                  new Card(
                    //color Color(0xff2f1f4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 25.0,
                    child: new Padding(
                      padding: new EdgeInsets.only(
                        left: 3.0,
                        right: 3.0,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 3.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: new BoxDecoration(
                                gradient: new LinearGradient(
                                    colors: [
                                      ThemeDesign.loginGradientEnd,
                                      ThemeDesign.loginGradientStart,
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(1.0, 1.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              //color: color,
                              child: Column(
                                children: <Widget>[
                                  new Text(
                                    items[position].mlongname.trim(),
                                    overflow: TextOverflow.fade,
                                    style: new TextStyle(
                                        fontSize: 18.0,
                                        fontStyle: FontStyle.normal,
                                        // color: Colors.grey[700]
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      new Text(
                                          mcustNoInt.toString() +
                                              "/" +
                                              mprdcd.toString() +
                                              "/" +
                                              mprcdAcctIdInt.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      Text(
                                          Translations.of(context).text('CNO')+" ${items[position].mcenterid}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        Translations.of(context).text('GNO')+" ${items[position].mgroupcd}",

                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                  Translations.of(context).text('Total_Balance')+"${items[position].macttotbalfcy}" ,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                          Translations.of(context).text('Lien_Amount')+"${items[position].mtotallienfcy}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new Container(
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Row(
                                  children: <Widget>[
                                    new Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        new Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[

                                          ],
                                        ),

                                        new Row(

                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            new Container(
                                              width: 190.0,
                                              child: new TextFormField(
                                                controller:
                                                items[position].mremark != null
                                                    ? TextEditingController(
                                                    text: items[position]
                                                        .mremark)
                                                    : TextEditingController(
                                                    text: ""),
                                                /* initialValue:
                                                items[position].remarks != null
                                                    ? items[position].remarks
                                                    : "",*/
                                                onSaved: (String value) {
                                                  items[position].mremark = value;
                                                },
                                                keyboardType:
                                                TextInputType.multiline,


                                                decoration: new InputDecoration(
                                                    border: new OutlineInputBorder(
                                                        borderSide: new BorderSide(color: Colors.teal)),
                                                    hintText: Translations.of(context).text('Enter_Remarks_Here'),
                                                    //helperText: 'Keep it short, this is just a demo.',
                                                    labelText: Translations.of(context).text('Remarks'),
                                                    /*  prefixIcon: const Icon(
                                                      Icons.person,
                                                      color: Colors.green,
                                                    ),*/
                                                    prefixText: '',
                                                    suffixText: '',
                                                    suffixStyle: const TextStyle(color: Colors.green)),


                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Container(
                                              width: 140.0,
                                              child: new TextFormField(
                                                controller:
                                                items[position].mcollectedamount !=
                                                    null
                                                    ? TextEditingController(
                                                    text: items[position]
                                                        .mcollectedamount
                                                        .toString())
                                                    : TextEditingController(
                                                    text: ""),
                                                /* initialValue:
                                                  items[position].collAmt !=
                                                          null
                                                      ? items[position]
                                                          .collAmt
                                                          .toString()
                                                      : "",*/
                                                onSaved: (String value) {
                                                  try {
                                                    items[position]
                                                        .mcollectedamount =
                                                        double.parse(value);
                                                  }catch(_){

                                                  }

                                                },
                                                keyboardType: TextInputType
                                                    .numberWithOptions(),


                                                decoration: new InputDecoration(
                                                    border: new OutlineInputBorder(
                                                        borderSide: new BorderSide(color: Colors.teal)),
                                                    hintText: Translations.of(context).text('Enter_Collection_Amt_Here'),
                                                    //helperText: 'Keep it short, this is just a demo.',
                                                    labelText: Translations.of(context).text('Collection_Amt'),
                                                    /* prefixIcon: const Icon(
                                                      Icons.person,
                                                      color: Colors.green,
                                                    ),*/
                                                    prefixText: '',
                                                    suffixText: '',
                                                    suffixStyle: const TextStyle(color: Colors.green)),

                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                new ButtonTheme.bar(
                                  padding: new EdgeInsets.all(2.0),
                                  child: new ButtonBar(
                                    children: <Widget>[],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )

            //  ),
          );
        },
      );
    } else
      futureBuilderNotSynced = new Text(Translations.of(context).text('Nothing_To_Display'));
    return WillPopScope(
        onWillPop: () {
          globals.isMemberOfGroupListColl = [0];
          globals.isMemeberOfGroupForSvngColl =true;
          globals.memberOfGroupColl = 'Yes';
          Navigator.of(context).pop();
        },
        child: new Scaffold(
          key: _scaffoldHomeState,
          bottomNavigationBar: Container(
            color: Color(0xff07426A),
            child:paginationCount>1  && storedItems.length>paginationCount?Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new IconButton(
                  icon:
                  new Icon(FontAwesomeIcons.backward, color: Colors.green),
                  onPressed: () {
                    _cardsCountReverse();
                  },
                ),
                Text(forwardClicks.toString() + "/" + pageCount.toString(), style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
                new IconButton(
                  icon: new Icon(FontAwesomeIcons.forward, color: Colors.red),
                  onPressed: () {
                    forwardClicks == pageCount
                        ? _LastClick()
                        : _cardsCountForward();
                    //  _cardsCountForward();
                  },
                ),
              ],
            ):SizedBox(),
          ), //key: _
          appBar: new AppBar(
              elevation: 10.0,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  globals.isMemeberOfGroupForSvngColl =true;
                  globals.memberOfGroupColl = 'Yes';
                  globals.isMemberOfGroupListColl = [0];
                  Navigator.of(context).pop();
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
                    double totalAmtCollect = 0.0;
                    for (int saveData = 0; saveData < storedItems.length; saveData++) {
                      if(storedItems[saveData].mcollectedamount!=null) {
                        totalAmtCollect += storedItems[saveData].mcollectedamount;
                      }
                    }
                    onPop( context,
                        Translations.of(context).text('Are_You_Sure'),
                    Translations.of(context).text('Do_You_Want_Submit_Collection_List_With_Total_Amount_Collected_Is')+"${totalAmtCollect}");
                  },
                ),
                /*new IconButton(icon: new Icon(Icons.delete, color: Colors.white), onPressed: (){
               AppDatabase.get().deletSomeUtil().then((val){
                 setState(() {
                   count=1;
                 });
               });
            })*/
              ]),

          body: new Container(
              color: const Color(0xff07426A),
              child: Form(
                key: _formKey,
                onChanged: () {
                  final FormState form = _formKey.currentState;
                  form.save();
                },
                child: futureBuilderNotSynced,
              )),
        ));
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
    String subs = items[index].mprdacctid.substring(8);
    print("subs " + subs.toString());

    Color color;
    if (index % 2 == 1) {
      // color = Color(0xffe8eaf6);
      //color = Colors.brown[50];
      color = Colors.grey;
    } else {
      //color = Colors.white;
      color = Colors.grey;
    }

    int mcustNoInt =0;
    int mprcdAcctIdInt=0;
    String mprdcd="";
    String custNo="";
    String prcdAcctId="";
    if(items[index].mprdacctid!=null && items[index].mprdacctid.trim()!='null' && items[index].mprdacctid.trim()!=''){
      mprdcd = items[index].mprdacctid.substring(0, 8).trim();
      custNo = items[index].mprdacctid.substring(9, 16);
      prcdAcctId = items[index].mprdacctid.substring(17, 24);
    }


    try {
      if (custNo != null && custNo != 'null' && custNo != '') {
        mcustNoInt = int.parse(custNo);
      }
      if (prcdAcctId != null && prcdAcctId != 'null' && prcdAcctId != '') {
        mprcdAcctIdInt = int.parse(prcdAcctId);
      }
    } catch (_) {}

    print("prdcd " + mprdcd.toString());
    print("custNo " + custNo.toString());
    print("prcdAcctId " + prcdAcctId.toString());

    return new GestureDetector(
        child: Column(
          children: <Widget>[
            new Card(
              //color Color(0xff2f1f4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 25.0,
              child: new Padding(
                padding: new EdgeInsets.only(
                  left: 3.0,
                  right: 3.0,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 3.0),
                      child: Container(
                        /* decoration: new BoxDecoration(borderRadius:
                      BorderRadius.circular(6.0),
                        color: Colors.grey,),*/
                        //color: color,
                        decoration: new BoxDecoration(
                          gradient: new LinearGradient(
                              colors: [
                                ThemeDesign.loginGradientEnd,
                                ThemeDesign.loginGradientStart,
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            new Text(
                              items[index].mlongname.trim(),
                              overflow: TextOverflow.fade,
                              style: new TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.normal,
                                  // color: Colors.grey[700]
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            new Row(
                              children: <Widget>[
                                new Text(
                                    mcustNoInt.toString() +
                                        "/" +
                                        mprdcd.toString() +
                                        "/" +
                                        mprcdAcctIdInt.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                Text(
                                    Translations.of(context).text('CNO')+" ${items[index].mcenterid}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  Translations.of(context).text('GNO')+" ${items[index].mgroupcd}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                Text(
                            Translations.of(context).text('Total_Balance')+"${items[index].macttotbalfcy}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  Translations.of(context).text('Lien_Amount')+"${items[index].mtotallienfcy}",

                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Container(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[


                                  new Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Container(
                                        width: 190.0,
                                        child: new TextFormField(
                                          controller: items[index].mremark != null
                                              ? TextEditingController(
                                              text: items[index]
                                                  .mremark
                                                  .toString())
                                              : TextEditingController(text: ""),
                                          /* initialValue:
                                      items[index].remarks !=
                                          null
                                          ? items[index]
                                          .remarks
                                          .toString()
                                          : "",*/
                                          onSaved: (String value) {
                                            items[index].mremark = value;
                                          },
                                          keyboardType: TextInputType.multiline,

                                          decoration: new InputDecoration(
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(color: Colors.teal)),
                                              hintText: Translations.of(context).text('Enter_Remarks_Here'),
                                              // helperText: 'Keep it short, this is just a demo.',
                                              labelText: Translations.of(context).text('Remarks'),
                                              /* prefixIcon: const Icon(
                                                Icons.person,
                                                color: Colors.green,
                                              ),*/
                                              prefixText: '',
                                              suffixText: '',
                                              suffixStyle: const TextStyle(color: Colors.green)),

                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Container(
                                        width: 140.0,
                                        child: new TextFormField(
                                          controller: items[index].mcollectedamount !=
                                              null
                                              ? TextEditingController(
                                              text: items[index]
                                                  .mcollectedamount
                                                  .toString())
                                              : TextEditingController(text: ""),

                                          /* initialValue:
                                        items[index].collAmt !=
                                            null
                                            ? items[index]
                                            .collAmt
                                            .toString()
                                            : "",*/
                                          onSaved: (String value) {
                                            items[index].mcollectedamount =
                                                double.parse(value);
                                            ;
                                          },
                                          keyboardType:
                                          TextInputType.numberWithOptions(),
                                          decoration: new InputDecoration(
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(color: Colors.teal)),
                                              hintText: Translations.of(context).text('Enter_Collection_Amt_Here'),
                                              //helperText: 'Collected Amount',
                                              labelText: Translations.of(context).text('Collection_Amt'),
                                              /*  prefixIcon: const Icon(
                                                Icons.monetization_on,
                                                color: Colors.green,
                                              ),*/
                                              prefixText: '',
                                              suffixText: '',
                                              suffixStyle: const TextStyle(color: Colors.green)),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          new ButtonTheme.bar(
                            padding: new EdgeInsets.all(2.0),
                            child: new ButtonBar(
                              children: <Widget>[],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void showInSnackBar(String message) {
    _scaffoldHomeState.currentState
        .showSnackBar(SnackBar(content: Text(message)));
    //globals._mockService();
  }

  void _cardsCountForward() {
    if (!dontIncForwrd) {
      forwardClicks += 1;
      cardsCount += paginationCount;
    }

    if (forwardClicks == pageCount) {
      items.clear();
      items.addAll(
          storedItems.getRange(cardsCount, cardsCount + lastPagelistCount));
      if(items.length==0){
        items.clear();
        items.addAll(
            storedItems.getRange(cardsCount, cardsCount + paginationCount));
      }
    } else {
      storedItems.setAll(cardsCount - paginationCount, items);
      items.clear();
      items.addAll(
          storedItems.getRange(cardsCount, cardsCount + paginationCount));
    }
    setState(() {});
  }

  void _cardsCountReverse() {
    dontIncForwrd = false;

    if (cardsCount != 0) {
      print("cardsCOunt " + cardsCount.toString());

      forwardClicks -= 1;
      cardsCount -= paginationCount;
      print("cardsCOunt  cardsCOunt" + cardsCount.toString());
      print("paginationCount  paginationCount" + cardsCount.toString());
      if (!(forwardClicks == pageCount)) {
        storedItems.setAll(cardsCount + paginationCount, items);
      }
      items.clear();
      items.addAll(
          storedItems.getRange(cardsCount, cardsCount + paginationCount));
    } else {}

    setState(() {});
  }

  Future<void> _LastClick() async {
    dontIncForwrd = true;

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.clear,
              color: Colors.red,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(Translations.of(context).text('No_Further_Records_Found')),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                onPressed: () {
                  Navigator.of(context).pop();
                  //Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  success(String message, BuildContext context,bool isPartialSubmitted) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(message)],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                onPressed: () {
                  setState(() {

                  });
                  if(isPartialSubmitted){
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(true);

                }else{
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(true);
                  }

                  /* Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new DailyCollectionSearchScreen()), //When Authorized Navigate to the next screen
                  );*/
                },
              ),
            ],
          );
        });
  }

  Future<bool> callDialog() {
    globals.Dialog.onPop(context, Translations.of(context).text('Are_You_Sure'),
        Translations.of(context).text('Do_You_Want_Submit_Collection_List_A'), Translations.of(context).text('CollectionSubmit'));
  }

  Future<bool> onPop(
      BuildContext context, String agrs1, String args2) {

    TextEditingController(text: "5");
    globals.isMemeberOfGroupForSvngColl =true;
    globals.memberOfGroupColl = 'Yes';
    globals.isMemberOfGroupListColl = [0];
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(agrs1),
        content: new Text(args2),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () async{
              if (forwardClicks == pageCount && paginationCount>1 && storedItems.length>paginationCount  ) {
                storedItems.setAll(cardsCount, items);
              }
              if(!(paginationCount>1 && storedItems.length>paginationCount  )){
                storedItems.clear();
                storedItems.addAll(items);
              }

              String batchcd = DateTime.now().year.toString()+DateTime.now().month.toString()+DateTime.now().
              day.toString()+DateTime.now().minute.
              toString()+DateTime.now().second.toString()+DateTime.now().millisecond.toString();

              int tempTref=0;
              await AppDatabase.get().generateTrefNumber().then((int onValue) {
                print("tempTref "+onValue.toString());
                tempTref=onValue;

              });

              for (int saveData = 0;
              saveData < storedItems.length;
              saveData++) {

                print("storedItems[saveData].trefno"+storedItems[saveData].trefno.toString());
                print("storedItems[saveData].mcollAmt.toString()    " +
                    storedItems[saveData].mcollectedamount.toString());
                print("storedItems[saveData].mremarks.toString()    " +
                    storedItems[saveData].mremark.toString());
                storedItems[saveData].mcreateddt = DateTime.now();
                storedItems[saveData].mdateopen = DateTime.now();
                storedItems[saveData].mcashflow = "C";
                storedItems[saveData].mbatchcd = batchcd;
                storedItems[saveData].mcollectiondate= DateTime.now();
                storedItems[saveData].mentrydate = DateTime.now();
                storedItems[saveData].trefno=tempTref;

                if( storedItems[saveData].mcollectedamount!=null && storedItems[saveData].mcollectedamount>0){
                  AppDatabase.get()
                      .updateSavingsCollectionListMaster(storedItems[saveData]);
                  print("saveData"+saveData.toString());

                }

              }

              success(
                  Translations.of(context).text('Submitted_sucessfully'),

                  context,false);



            },
            child: new Text(Translations.of(context).text('Yes')),
          ),
        ],
      ),
    );
  }
}
