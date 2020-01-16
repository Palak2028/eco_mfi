import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFRepayScheduleBean.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewRepaymentSchedule extends StatefulWidget {
  final List<CIFRepayScheduleBean> cifRepayScheduleBean;
  String mprdaccid;
  ViewRepaymentSchedule(this.cifRepayScheduleBean , this.mprdaccid);

  @override
  _ViewRepaymentSchedule createState() =>
      _ViewRepaymentSchedule();
}

class _ViewRepaymentSchedule
    extends State<ViewRepaymentSchedule> {
   List<CIFRepayScheduleBean> cifRepayScheduleList=new List<CIFRepayScheduleBean>();
   List<int> selectedIndex = new List<int>();
   final dateFormat = DateFormat("yyyy/MM/dd hh:mm:ss");
   SharedPreferences prefs;
   var rows2;
   var cols2;
   List<String> repaySchList ;

  @override
  void initState() {
    super.initState();
    List columnName = [
      'SrNo',
      'Date',
      'Principal',
      'Interest',
      'Installment',
      'Balance'
    ];

    print("cifRepayScheduleBean"+widget.cifRepayScheduleBean.toString());
    if(widget.cifRepayScheduleBean!=null){
      cifRepayScheduleList =widget.cifRepayScheduleBean;
    }

    if (widget.cifRepayScheduleBean != null && widget.cifRepayScheduleBean.isNotEmpty) {
      repaySchList = new List<String>();
      for (int l = 0; l < cifRepayScheduleList.length; l++) {
        double minstallment = cifRepayScheduleList[l].mwseffcontractamt + cifRepayScheduleList[l].mwsintamount;
        repaySchList.add(minstallment.toString());
      }
    }
    getRow();
    cols2 = [
      new DataColumn(
        label:  Text('SrNo'),
      ),
      new DataColumn(
        label:  Text('Date'),
      ),
      new DataColumn(
        label:  Text('Principal'),
      ),
      new DataColumn(
        label: Text('Interest'),
      ),
      new DataColumn(
        label: Text('Installment'),
      ),
      new DataColumn(
      label: Text('Balance'),
      )
    ];
  }
  void getRow(){
    rows2 = new List.generate(
        cifRepayScheduleList.length,
            (int a) => new DataRow(

            cells: [
              new DataCell(
                  new Text(cifRepayScheduleList[a].msrno==null||cifRepayScheduleList[a].msrno.toString()=="null"?""
                      :cifRepayScheduleList[a].msrno.toString())),
              new DataCell(
                  new Text(cifRepayScheduleList[a].mwsenddate==null||cifRepayScheduleList[a].mwsenddate.toString()=="null"?""
                      :cifRepayScheduleList[a].mwsenddate.substring(0, 4).toString()+"-"+
                       cifRepayScheduleList[a].mwsenddate.substring(4, 6).toString()+"-"+
                       cifRepayScheduleList[a].mwsenddate.substring(6, 8).toString())),
              new DataCell(
                  new Text(cifRepayScheduleList[a].mwseffcontractamt==null||cifRepayScheduleList[a].mwseffcontractamt.toString()=="null"?"":
                  cifRepayScheduleList[a].mwseffcontractamt.toString()
                  )),
              new DataCell(
                  new Text(cifRepayScheduleList[a].mwsintamount==null||cifRepayScheduleList[a].mwsintamount=="null"?"":
                  cifRepayScheduleList[a].mwsintamount.toString()
                  )),
              new DataCell(new Text(repaySchList==null?"":repaySchList[a])),
              new DataCell(
                  new Text(cifRepayScheduleList[a].mwsidealbal==null||cifRepayScheduleList[a].mwsidealbal=="null"?"":
                  cifRepayScheduleList[a].mwsidealbal.toString()
                  )),
            ]));

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
          title:
            new Text(Translations.of(context).text('Repayment_Schedule'),
           // textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: ListView(padding: EdgeInsets.all(20.0), children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Text("PrdAccId : "+widget.mprdaccid.substring(0, 8).toString()+"/"+
                        int.parse(widget.mprdaccid.substring(8, 16)).toString()+"/"+
                        int.parse(widget.mprdaccid.substring(16, 24)).toString()
                      , style: new TextStyle(
                        color: Color(0xff07426A),
                        fontSize: 20.0,
                      ), )
                  ],
                ),
                new Row(
                  children: <Widget>[
                  Container(
                  //height: 1000.0,
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








