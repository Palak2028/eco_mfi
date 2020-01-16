import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import 'package:eco_mfi/pages/workflow/Savings/bean/MiniStatementBean.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/BluetoothPair.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';

class ViewMinistatementTable extends StatefulWidget {
  final List<MiniStatementBean> ministatemntbean;
  ViewMinistatementTable(this.ministatemntbean);


  @override
  _ViewMinistatementTable createState() =>
      _ViewMinistatementTable();
}

class _ViewMinistatementTable
    extends State<ViewMinistatementTable> {
   List<MiniStatementBean> ministatemntlist=new List<MiniStatementBean>();
  List<DataRow> _sampleDataRows = new List<DataRow>();
  List<DataColumn> _dataColumns = new List<DataColumn>();
  List<int> selectedIndex = new List<int>();
   final dateFormat = DateFormat("yyyy/MM/dd hh:mm:ss");
   SharedPreferences prefs;

   static const platform = const MethodChannel('com.infrasofttech.eco_mfi');

  // double shadowbalance=double.parse(widget.ministatemntbean[0].mtotallienfcy)+double.parse(widget.ministatemntbean[0].macttotballcy);
  var rows2;
  var cols2;

  @override
  void initState() {
    super.initState();
    List columnName = [
      'Date',
      'Amount',
      'DrCr',
      'Remarks'
    ];
  //  print("ministatemntbean"+widget.ministatemntbean.toString());



    if(widget.ministatemntbean!=null){
      ministatemntlist =widget.ministatemntbean;
    }
    getRow();
    cols2 = [
      new DataColumn(
        label:  Text('Date'),

      ),
      new DataColumn(
        label:  Text('Amount'),
      ),
      new DataColumn(
        label: Text('DrCr'),
      ),
      new DataColumn(
        label: Text('Remarks'),
      )
    ];
  }
  void getRow(){
    rows2 = new List.generate(
        ministatemntlist.length,
            (int a) => new DataRow(

            cells: [
              new DataCell(
                  new Text(ministatemntlist[a].mentrydate==null||ministatemntlist[a].mentrydate.toString()=="null"?""
                      :ministatemntlist[a].mentrydate.toString())),
              new DataCell(
                  new Text(ministatemntlist[a].mlcytrnamt==null||ministatemntlist[a].mlcytrnamt.toString()=="null"?"":
                  ministatemntlist[a].mlcytrnamt.toString()
                  )),
              new DataCell(
                  new Text(ministatemntlist[a].mdrcr==null||ministatemntlist[a].mdrcr=="null"?"":
                  ministatemntlist[a].mdrcr.toString()
                  )),
              new DataCell(
                  new Text(ministatemntlist[a].mparticulars==null||ministatemntlist[a].mparticulars=="null"?"":
                  ministatemntlist[a].mparticulars.toString()
                  )),

            ]));

  }

   _callChannel(List<MiniStatementBean> miniStatementBeanList) async{
     String repeatedStringEntryDate = "";

     prefs = await SharedPreferences.getInstance();
     String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
     print("bluetoothAddress $bluetootthAdd");

     for(var items in miniStatementBeanList){
       repeatedStringEntryDate = items.mentrydate.toString()+"~"+repeatedStringEntryDate;
     }
     print("repeatedStringEntryDate"+repeatedStringEntryDate);
     String repeatedStringAmount = "";
     for(var items in miniStatementBeanList){
       repeatedStringAmount = items.mlcytrnamt.toString()+"~"+repeatedStringAmount;
     }
     print("repeatedStringAmount"+repeatedStringAmount);
     String repeatedStringDrCr = "";
     for(var items in miniStatementBeanList){
       repeatedStringDrCr = items.mdrcr.toString()+"~"+repeatedStringDrCr;
     }
     print("repeatedStringDrCr"+repeatedStringDrCr);
     String repeatedStringRemarks = "";
     for(var items in miniStatementBeanList){
       repeatedStringRemarks = items.mparticulars.toString()+"~"+repeatedStringRemarks;
     }
     print("repeatedStringRemarks"+repeatedStringRemarks);
     String mlbrcode=widget.ministatemntbean[0].mlbrcode.toString();
     String mbramchname=widget.ministatemntbean[0].mbramchname.toString();
     String date=dateFormat.format(DateTime.now());
     String prdAccId=int.parse(widget.ministatemntbean[0].mprdacctid.substring(0, 8)).toString()+"/"+
         int.parse(widget.ministatemntbean[0].mprdacctid.substring(8, 16)).toString()+"/"+
         int.parse(widget.ministatemntbean[0].mprdacctid.substring(16, 24)).toString();
     String mlongname=widget.ministatemntbean[0].mlongname.toString();
     String macttotballcy=widget.ministatemntbean[0].macttotballcy.toString();

     try {
       final String  result = await platform.invokeMethod("ministatementPrint",
           {"BluetoothADD": bluetootthAdd,
             "mlbrcode":mlbrcode,
             "mbramchname":mbramchname,
             "date":date,
             "prdAccId":prdAccId,
             "mlongname":mlongname,
             "macttotballcy":macttotballcy,
             "repeatedStringEntryDate":repeatedStringEntryDate,
             "repeatedStringAmount":repeatedStringAmount,
             "repeatedStringDrCr":repeatedStringDrCr,
             "repeatedStringRemarks":repeatedStringRemarks});
       String geTest = 'geTest at $result';
       print("FLutter : "+geTest.toString());
     } on PlatformException catch (e) {
       print("FLutter : "+e.message.toString());
     }

   }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: new AppBar(
          elevation: 3.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {Navigator.of(context).pop(),Navigator.of(context).pop()}
          ),
          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          title: new Text(
            Translations.of(context).text('Mini_Statement'),
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
                  onPressed: () {
                  _callChannel(ministatemntlist);
            }
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
                        child: new Text(widget.ministatemntbean[0].mlbrcode.toString()=="null"||widget.ministatemntbean[0].mlbrcode.toString()==""?"":widget.ministatemntbean[0].mlbrcode.toString(), style: new TextStyle(
                          color: Color(0xff07426A),
                          fontSize: 20.0,
                        ), )
                    )
                  ],
                ),
                Row(
                  children: <Widget>[

                    new Card(color: Constant.semiMandatoryColor,
                        child: new Text(widget.ministatemntbean[0].mbramchname.toString()=="null"||widget.ministatemntbean[0].mbramchname.toString()==""?"":widget.ministatemntbean[0].mbramchname.toString(), style: new TextStyle(
                          color: Color(0xff07426A),
                          fontSize: 20.0,
                        ), )
                    )
                  ],
                ),
                Row(
                  children: <Widget>[

                    new Card(
                      child: new Text(Translations.of(context).text('Date')+dateFormat.format(DateTime.now()), style: new TextStyle(
                        color: Color(0xff07426A),
                        fontSize: 18.0,
                      ), )
                    )
                  ],
                ),
                Row(
                  children: <Widget>[

                    new Card(
                        child: new Text((widget.ministatemntbean[0].mprdacctid.substring(0, 8)).toString()+"/"+
                            (widget.ministatemntbean[0].mprdacctid.substring(8, 16)).toString()+"/"+
                            (widget.ministatemntbean[0].mprdacctid.substring(16, 24)).toString()
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
                        child: new Text(widget.ministatemntbean[0].mlongname.toString(), style: new TextStyle(
                          color: Color(0xff07426A),
                          fontSize: 18.0,
                        ), )
                    )
                  ],
                ), Row(
                  children: <Widget>[

                    new Card(
     // double.parse(widget.ministatemntbean[0].mtotallienfcy)+double.parse(widget.ministatemntbean[0].macttotballcy)
                        child: new Text(widget.ministatemntbean[0].macttotballcy.toString(), style: new TextStyle(
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








