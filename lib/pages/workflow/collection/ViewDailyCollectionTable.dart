import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:eco_mfi/pages/workflow/Savings/bean/MiniStatementBean.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/pages/workflow/collection/bean/CollectionMasterBean.dart';


class ViewDailyCollectionTable extends StatefulWidget {
  final List<CollectionMasterBean> collectionMasterBean;
  ViewDailyCollectionTable(this.collectionMasterBean);


  @override
  _ViewDailyCollectionTable createState() =>
      _ViewDailyCollectionTable();
}

class _ViewDailyCollectionTable
    extends State<ViewDailyCollectionTable> {
   List<CollectionMasterBean> collectionMasterBeanList=new List<CollectionMasterBean>();
  List<DataRow> _sampleDataRows = new List<DataRow>();
  List<DataColumn> _dataColumns = new List<DataColumn>();
  List<int> selectedIndex = new List<int>();
   final dateFormat = DateFormat("yyyy/MM/dd hh:mm:ss");

  // double shadowbalance=double.parse(widget.ministatemntbean[0].mtotallienfcy)+double.parse(widget.ministatemntbean[0].macttotballcy);
  var rows2;
  var cols2;

  @override
  void initState() {
    super.initState();
    List columnName = [
      "Account ID",
      "Amount",
      "DrCr",
      "Remarks"
    ];
  //  print("ministatemntbean"+widget.ministatemntbean.toString());



    if(widget.collectionMasterBean!=null){
      collectionMasterBeanList =widget.collectionMasterBean;
    }
    getRow();
    cols2 = [
      new DataColumn(
        label: const Text('Date'),

      ),
      new DataColumn(
        label: const Text('Amount'),
      ),
      new DataColumn(
        label: const Text('DrCr'),
      ),
      new DataColumn(
        label: const Text('Remarks'),
      )
    ];
  }
  void getRow(){
    rows2 = new List.generate(
        collectionMasterBeanList.length,
            (int a) => new DataRow(

            cells: [
              new DataCell(
                  new Text(collectionMasterBeanList[a].mprdacctid==null||collectionMasterBeanList[a].mprdacctid.toString()=="null"?""
                      :collectionMasterBeanList[a].mprdacctid.toString())),
              new DataCell(
                  new Text(collectionMasterBeanList[a].mcollAmt==null||collectionMasterBeanList[a].mcollAmt.toString()=="null"?"":
                  collectionMasterBeanList[a].mcollAmt.toString()
                  )),
              new DataCell(
                  new Text(collectionMasterBeanList[a].mbatchcd==null||collectionMasterBeanList[a].mbatchcd=="null"?"":
                  collectionMasterBeanList[a].mbatchcd.toString()
                  )),
              new DataCell(
                  new Text(collectionMasterBeanList[a].mcustno==null||collectionMasterBeanList[a].mcustno=="null"?"":
                  collectionMasterBeanList[a].mcustno.toString()
                  )),

            ]));

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          elevation: 3.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          title: new Text(
            'Daily Collection History',
           // textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

            actions: <Widget>[

              new IconButton(
                icon: const Icon(
                  Icons.print,
                  color: Colors.white,
                ),
              ),
            ]
        ),
        body: ListView(padding: EdgeInsets.all(20.0), children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[

                    new Card(color: Constant.semiMandatoryColor,
                        child: new Text(widget.collectionMasterBean.length>0 && widget.collectionMasterBean[0].mlbrcode.toString()==null || widget.collectionMasterBean[0].mlbrcode.toString()=="null"||widget.collectionMasterBean[0].mlbrcode.toString()==""?"":widget.collectionMasterBean[0].mlbrcode.toString(), style: new TextStyle(
                          color: Color(0xff07426A),
                          fontSize: 20.0,
                        ), )
                    )
                  ],
                ),
                Row(
                  children: <Widget>[

                    new Card(color: Constant.semiMandatoryColor,
                        child: new Text(widget.collectionMasterBean[0].mcustno.toString()=="null"||widget.collectionMasterBean[0].mcustno.toString()==""?"":widget.collectionMasterBean[0].mcustno.toString(), style: new TextStyle(
                          color: Color(0xff07426A),
                          fontSize: 20.0,
                        ), )
                    )
                  ],
                ),
                Row(
                  children: <Widget>[

                    new Card(
                      child: new Text('Date :'+dateFormat.format(DateTime.now()), style: new TextStyle(
                        color: Color(0xff07426A),
                        fontSize: 18.0,
                      ), )
                    )
                  ],
                ),
                Row(
                  children: <Widget>[

                    new Card(
                        child: new Text(widget.collectionMasterBean[0].mprdacctid.substring(0, 8).trim()+"/"+
                            widget.collectionMasterBean[0].mprdacctid.substring(8, 16).trim()+"/"+
                            widget.collectionMasterBean[0].mprdacctid.substring(16, 24).trim()
                          , style: new TextStyle(
                          color: Color(0xff07426A),
                          fontSize: 20.0,
                        ), )
                    )
                  ],
                ),
                Row(
                  children: <Widget>[

                    new Card(
                        child: new Text(widget.collectionMasterBean[0].mlongname.toString(), style: new TextStyle(
                          color: Color(0xff07426A),
                          fontSize: 18.0,
                        ), )
                    )
                  ],
                ), Row(
                  children: <Widget>[

                    new Card(
     // double.parse(widget.ministatemntbean[0].mtotallienfcy)+double.parse(widget.ministatemntbean[0].macttotballcy)
                        child: new Text(widget.collectionMasterBean[0].mcollAmt.toString(), style: new TextStyle(
                          color: Color(0xff07426A),
                          fontSize: 18.0,
                        ), )
                    )
                  ],
                ),
                new Row(
                  children: <Widget>[
                  Container(
                  height: 600.0,
                  child: DataTable(
                    rows: rows2,
                    columns: cols2,
                  ),
                ),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}








