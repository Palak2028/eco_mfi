import 'dart:io';

import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/OpenCamera.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CbResultBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CreditBereauBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_mfi/translations.dart';

class CreditBereauResult extends StatefulWidget {
  final CreditBereauBean CreditBeareauPassedObject;

  CreditBereauResult({Key key, @required this.CreditBeareauPassedObject})
      : super(key: key);

  @override
  _CreditBereauResult createState() => new _CreditBereauResult();
}

class TablePicker extends StatelessWidget {
  const TablePicker({this.cbRes, this.result});

  final CbResultBean cbRes;
  final result;

  @override
  Widget build(BuildContext context) {
    return DataTable(rows: [
      new DataRow(cells: [
        new DataCell(
          new Text(
            Translations.of(context).text('Status')
            ,
            style: TextStyle(

            ),
          ),
        ),
        new DataCell(new Text(result,
            textAlign: TextAlign.end,
            style: TextStyle(
                color: result == "Pass" ? Colors.green : Colors.red,
              ))),
        new DataCell(new Text(
          Translations.of(context).text('MFI_OD'),
          style: TextStyle(

          ),
        )),
        new DataCell(new Text("${cbRes.mmfitotovrdueamt}",
            style: TextStyle(
                color: cbRes.mmfitotovrdueamt < 0 ? Colors.green : Colors.red,
                ))),
      ]),
      /* new DataRow(cells: [
        new DataCell(new Text(
          "MFI OD",
          style: TextStyle(
            fontSize: 15.0,
          ),
        )),
        new DataCell(new Text("${cbRes.mmfitotovrdueamt}",
            style: TextStyle(
                color: cbRes.mmfitotovrdueamt < 0 ? Colors.green : Colors.red,
                fontSize: 20.0))),
      ]),*/
      new DataRow(cells: [
        new DataCell(new Text(
          Translations.of(context).text('OD_Acounts')
          ,
          style: TextStyle(

          ),
        )),
        new DataCell(new Text("${cbRes.mtotovrdueaccno}",
            style: TextStyle(
                color: (cbRes.mtotovrdueaccno) < 1 ? Colors.green : Colors.red,
                fontSize: 20.0))),
        new DataCell(new Text(
          Translations.of(context).text('Total_OD')
          ,
          style: TextStyle(

          ),
        )),
        new DataCell(new Text("${cbRes.mtotovrdueamt}",
            style: TextStyle(
                color: cbRes.mtotovrdueamt < 100000 ? Colors.green : Colors.red,
               ))),
      ]),
      /*new DataRow(cells: [
        new DataCell(new Text(
          "Total OD : ",
          style: TextStyle(
            fontSize: 15.0,
          ),
        )),
        new DataCell(new Text("${cbRes.mtotovrdueamt}",
            style: TextStyle(
                color: cbRes.mtotovrdueamt < 100000 ? Colors.green : Colors.red,
                fontSize: 20.0))),
      ]),*/
      new DataRow(cells: [
        new DataCell(new Text(
          Translations.of(context).text('Exp_Amt')
          ,
          style: TextStyle(

          ),
        )),
        new DataCell(new Text("${cbRes.mexpsramt}",
            style: TextStyle(
                color: cbRes.mexpsramt != 0 ? Colors.green : Colors.red,
                ))),
        new DataCell(new Text(
          Translations.of(context).text('MFI_Curr_Bal')
          ,
          style: TextStyle(

          ),
        )),
        new DataCell(new Text("${cbRes.mmfitotcurrentbal}",
            style: TextStyle(
                color: cbRes.mmfitotcurrentbal <= 100000 ? Colors.green : Colors.red,
                ))),
      ]),
    ], columns: [
      new DataColumn(
        label:  Text(Translations.of(context).text('Details')
        ),
      ),
      new DataColumn(
        label:  Text(Translations.of(context).text('Result')
        ),
      ),
      new DataColumn(
        label:  Text(Translations.of(context).text('Details')
        ),
      ),
      new DataColumn(
        label:  Text(Translations.of(context).text('Result')
        ),
      ),
    ]);
  }
}

class _CreditBereauResult extends State<CreditBereauResult> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  CreditBereauBean beanObj = new CreditBereauBean();
  CbResultBean cbResultBean = new CbResultBean();
  List<CbResultBean> items = new List<CbResultBean>();
  int overDueAccNo = 0;

  bool _isReady = false;

  /* List<String> imageList = new List<String>();*/
  List dum = new List();
  String result;
  int count = 1;
  int cbck = 0;
  int cbck2 = 0;
  int imageCounter = 0;

  void initState() {
    print("xxxxxxxxxxxxxxxinit statexxxxxxxxxxxxxxxx");
    beanObj = widget.CreditBeareauPassedObject;
    print(beanObj);

    result = beanObj.mcbcheckstatus;
  }

  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) {
    print("inside getHomePageBody");
    print(items.length);

    print(snapshot.data);
    if (snapshot.data != null) {
      /* overDueAccNo =  (int.parse(cbResultBean.mprimarynoofodaccs) + int.parse(cbResultBean.msecondarynoofodacs));
      for (var img in imageList) {

        print(img);
        if (img != null && img != "") {
          imageCounter++;
          _isReady = false;
        }
      }
      if(overDueAccNo == imageCounter)_isReady = true;*/

      print(items.length);
      if (items.length == 0) {
        return Center(
          child: new Container(
            child: new Text(Translations.of(context).text('No_Loans_Found')
            ),
          ),
        );
      }

      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.all(0.0),
      );
    } else
      print("Snapshot is null");
  }

  Widget _getItemUI(BuildContext context, int index) {
    if (items[index].mcurrentbalance == "0")
      dum.add(null);
    else
      dum.add(1);
    print(items[index]);
    return Card(
      color: Colors.grey[200],
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                    child: new Text(
                      '${items[index].mnameofmfi}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.black,
                      ),
                    )),
                Flexible(
                    child:
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[new
                          Text(Translations.of(context).text('OD')+items[index].moverdueamount.toString(),
                            style: TextStyle(),
                          ),],
                        ),
                        new Row(
                          children: <Widget>[
                            new
                            Text(Translations.of(context).text('Curr_Bal')+items[index].mcurrentbalance.toString(),
                              style: TextStyle(),
                            ),
                          ],
                        )

                      ],
                    )

                ),
              ],
            ),
            /*trailing: items[index].moverdueamount != 0.0
                ? new Container(
                    child: items[index].mnocimagestring == null||items[index].mnocimagestring.trim() == ""
                        ? new IconButton(
                            tooltip: "Capture NOC",
                            icon: Icon(Icons.camera_alt),
                            onPressed: () {
                              _takePhoto(context, index);
                            })
                        : new IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            tooltip: "View Recapture NOC",
                            color: Color(0xff01579b),
                            onPressed: () {
                              showAlert(items[index].mnameofmfi,
                                  items[index].mnocimagestring, index, context);
                            },
                          ),
                  )
                : new Text("Loans Cleared"),*/
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var cbResultBuilder;
    if (count == 1) {
      count++;

      cbResultBuilder = new FutureBuilder(
          future: AppDatabase.get()
              .getCbResult(beanObj.trefno, beanObj.mrefno)
              .then((CbResultBean cbres) {
            cbResultBean = cbres;
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
                  return DataTable(rows: [
                    new DataRow(cells: [
                      new DataCell(
                        new Text(
                          Translations.of(context).text('Status'),
                          style: TextStyle(

                          ),
                        ),
                      ),
                      new DataCell(new Text(result,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: result == "Pass" ? Colors.green : Colors.red,
                              ))),
                      new DataCell(new Text(
            Translations.of(context).text('MFI_OD'),
                        style: TextStyle(

                        ),
                      )),
                      new DataCell(new Text("${cbResultBean.mmfitotovrdueamt}",
                          style: TextStyle(
                              color: cbResultBean.mmfitotovrdueamt < 0 ? Colors.green : Colors.red,
                              ))),
                    ]),
                    /* new DataRow(cells: [
        new DataCell(new Text(
          "MFI OD",
          style: TextStyle(
            fontSize: 15.0,
          ),
        )),
        new DataCell(new Text("${cbRes.mmfitotovrdueamt}",
            style: TextStyle(
                color: cbRes.mmfitotovrdueamt < 0 ? Colors.green : Colors.red,
                fontSize: 20.0))),
      ]),*/
                    new DataRow(cells: [
                      new DataCell(new Text(
                        Translations.of(context).text('OD_Acc'),
                        style: TextStyle(

                        ),
                      )),
                      new DataCell(new Text("${cbResultBean.mtotovrdueaccno}",
                          style: TextStyle(
                              color: (cbResultBean.mtotovrdueaccno) < 1 ? Colors.green : Colors.red,
                              ))),
                      new DataCell(new Text(
                        Translations.of(context).text('Total_OD'),
                        style: TextStyle(

                        ),
                      )),
                      new DataCell(new Text("${cbResultBean.mtotovrdueamt}",
                          style: TextStyle(
                              color: cbResultBean.mtotovrdueamt < 100000 ? Colors.green : Colors.red,
                              ))),
                    ]),
                    /*new DataRow(cells: [
        new DataCell(new Text(
          "Total OD : ",
          style: TextStyle(
            fontSize: 15.0,
          ),
        )),
        new DataCell(new Text("${cbRes.mtotovrdueamt}",
            style: TextStyle(
                color: cbRes.mtotovrdueamt < 100000 ? Colors.green : Colors.red,
                fontSize: 20.0))),
      ]),*/
                    new DataRow(cells: [
                      new DataCell(new Text(
                        Translations.of(context).text('Exp_Amt'),
                        style: TextStyle(

                        ),
                      )),
                      new DataCell(new Text("${cbResultBean.mexpsramt}",
                          style: TextStyle(
                              color: cbResultBean.mexpsramt != 0 ? Colors.green : Colors.red,
                        ))),
                      new DataCell(
                          new Text(
                            Translations.of(context).text('MFI_Curr_Bal'),

                      )),
                      new DataCell(new Text("${cbResultBean.mmfitotcurrentbal}",
                          style: TextStyle(
                              color: cbResultBean.mmfitotcurrentbal <= 100000 ? Colors.green : Colors.red,
                              ))),
                    ]),
                  ], columns: [
                    new DataColumn(
                      label:  Text(Translations.of(context).text('Details')),
                    ),
                    new DataColumn(
                      label:  Text(Translations.of(context).text('Result')),
                    ),
                    new DataColumn(
                      label:  Text(Translations.of(context).text('Details')),
                    ),
                    new DataColumn(
                      label:  Text(Translations.of(context).text('Result')),
                    ),
                  ]);
            }
          });
    } else {
      cbResultBuilder = TablePicker(
        cbRes: cbResultBean,
        result: beanObj.mcbcheckstatus,
      );
    }

    var cbLoanBuilder;

    if (count == 2) {
      count++;

      cbLoanBuilder = new FutureBuilder(
          future: AppDatabase.get()
              .getLoanDetails(beanObj.trefno, beanObj.mrefno)
              .then((List<CbResultBean> listCbres) {
            for (var obj in listCbres) {
              items.add(obj);
            }

            return items;
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
                  return getHomePageBody(context, snapshot);
            }
          });
      print(dum);
    } else {
      cbLoanBuilder = ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, position) {
          return Card(
            color: Colors.grey[200],
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new ListTile(
                  title: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          child: new Text(
                            ' ${items[position].mnameofmfi}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.black,
                                fontStyle: FontStyle.italic
                            ),
                          )),
                      Flexible(
                          child:
                          new Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              new Row(
                                children: <Widget>[new
                                Text(Translations.of(context).text('OD')+items[position].moverdueamount.toString(),

                                  style: TextStyle(),
                                ),],
                              ),
                              new Row(
                                children: <Widget>[
                                  new
                                  Text(Translations.of(context).text('Curr_Bal')+items[position].mcurrentbalance.toString(),
                                    style: TextStyle(),
                                  ),
                                ],
                              )

                            ],
                          )

                      ),
                    ],
                  ),
                  /*trailing: items[position].moverdueamount != 0.0
                      ? new Container(
                          child: items[position].mnocimagestring == null ||
                                  items[position].mnocimagestring == ""
                              ? new IconButton(
                                  tooltip: "Capture NOC",
                                  icon: Icon(Icons.camera_alt),
                                  onPressed: () {
                                    _takePhoto(context, position);
                                  })
                              : new IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  tooltip: "View Recapture NOC",
                                  color: Color(0xff01579b),
                                  onPressed: () {
                                    showAlert(
                                        items[position].mnameofmfi,
                                        items[position].mnocimagestring,
                                        position,
                                        context);
                                  },
                                ),
                        )
                      : new Text("Loans Cleared"),*/
                ),
              ],
            ),
          );
        },
      );
    }

    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          elevation: 3.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Color(0xff01579b),
          brightness: Brightness.light,
          title: new Text(
            '${beanObj.mprospectname} result : ${beanObj.mcbcheckstatus.toUpperCase()}',
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          /*actions: <Widget>[
            new IconButton(
                padding: EdgeInsets.only(right: 5.0),
                icon: const Icon(
                  Icons.file_upload,
                  color: Colors.white,
                  size: 44.0,
                ),
                tooltip: "Save",
                onPressed: () async{
                  // saveNOC();
                  print(globals.reportingUser);
                  await AppDatabase.get().selectlastFromTab(2);

                  await AppDatabase.get().selectlastFromTab(2);

                  //AppDatabase.get().trialrun(widget.CreditBeareauPassedObject.trefno,widget.CreditBeareauPassedObject.mrefno);

                },
                splashColor: Colors.blueAccent),
          ],*/
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: new Column(children: <Widget>[
            cbResultBuilder,
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Container(
                child: new Text(
                  Translations.of(context).text('Loan_Details'),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
              ),
            ),
            new Container(
              width: 450.0,
              height: 200.0,
              child: cbLoanBuilder,
            ),
            new SizedBox(),
            new Container(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: result == "Fail"&& widget.CreditBeareauPassedObject.mprospectstatus == 3
                          ? Material(
                              borderRadius: BorderRadius.circular(30.0),
                              shadowColor: Colors.lightBlueAccent.shade100,
                              elevation: 5.0,
                              child: MaterialButton(
                                minWidth: 200.0,
                                height: 42.0,
                                onPressed: () {
                                  routeNOC();
                                },
                                color: Color(0xff01579b),
                                child: Text(Translations.of(context).text('Route'),
                                    style: TextStyle(color: Colors.white)),
                              ),
                            )
                          : null),
                  new Container(
                    padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                    child: (result == "Pass" || beanObj.mprospectstatus == 6)
                        ? Material(
                            borderRadius: BorderRadius.circular(30.0),
                            shadowColor: Colors.lightBlueAccent.shade100,
                            elevation: 5.0,
                            child: MaterialButton(
                              minWidth: 200.0,
                              height: 42.0,
                              onPressed: () {
                                navigateToCustomerCreation(beanObj);
                              },
                              color: Color(0xff01579b),
                              child:beanObj.miscustcreated == 1?Text(Translations.of(context).text('Update_Customer'),
                                  style: TextStyle(color: Colors.white)):
                              Text(Translations.of(context).text('Create_Customer'),
                                  style: TextStyle(color: Colors.white)),
                            ),
                          )
                        : new Text(
                            "${Constant.getProspectStatus(beanObj.mprospectstatus)}",
                            style: TextStyle(color: Colors.red),
                          ),
                  ),
                ],
              ),
            ),
          ]),
        )));
  }

  Future<void> navigateToCustomerCreation(CreditBereauBean beanObj) async {
    //in case of repeatat cust we  have to updtae customer if cb check is done


    CustomerListBean bean = new CustomerListBean();
    if(beanObj.mcbcheckstatus.toUpperCase()=="PASS") bean.misCbCheckDone = 1;
    else if(beanObj.mcbcheckstatus.toUpperCase()=="FAIL")bean.misCbCheckDone = 2;


    bean.mcbcheckrprtdt = beanObj.mhighmarkchkdt;



    if(beanObj.mprospectstatus == 6)bean.misCbCheckDone = 1;






    if(beanObj.miscustcreated==1){

      CustomerListBean custObj;
      try{
         custObj =  await AppDatabase.get().custTrefMrefFromId(beanObj.mpanno,beanObj.mid1);
      }catch(_){
        print("exceptionOccured");
      }

      if(custObj!=null){
      AppDatabase.get().updateCustHighRprtDate
        (beanObj.mpanno,beanObj.mid1desc,cbResultBean.mexpsramt,widget.CreditBeareauPassedObject.mhighmarkchkdt,bean.misCbCheckDone);}
      showMessage("Highmark Result updated ");

      return;
    }

    List arr = beanObj.mprospectname.split(" ");
    bean.mfname = arr[0];
    if (arr.length == 3) {
      bean.mmname = arr[1];
      bean.mlname = arr[2];
    } else if (arr.length == 2) {
      bean.mlname = arr[1];
    }
    bean.mhusbandname = beanObj.mspousename;
    bean.mexpsramt = cbResultBean.mexpsramt;
    bean.mcbcheckrprtdt =beanObj.mhighmarkchkdt;
    bean.mpannodesc = beanObj.mpanno;
    bean.mIdDesc = beanObj.mid1desc;

    globals.customerType = "new customer";
    await AppDatabase.get().generateCustomerNumber().then((onValue) {
      bean.trefno = onValue;
    });
    bean.mdob = beanObj.mdob;
    bean.motpvrfdno= beanObj.mmobno.toString();

/*  AddressDetailsBean addBean = new AddressDetailsBean();

    addBean.maddr1 = beanObj.mhouse + beanObj.mstreet;
    addBean.mcityCd = beanObj.mcity;
    addBean.mThana = beanObj.mstreet;
    addBean.mpinCd = beanObj.mpincode;
    bean.imageMaster =   new List<ImageBean>();
    bean.mdob = beanObj.mdob;*/
    // bean.addressDetails[0] = addBean;

    /*globals.tempAddressDetails.mdistcd = beanObj.city;
    globals.tempAddressDetails.pin = beanObj.pinCode.toString();
    globals.tempAddressDetails.mobileNumber = beanObj.contactNo.toString();*/
    /*  globals.applicantDob = beanObj.mdob;*/

    /* globals.addressDetailsList[0].mobileNumber =beanObj.contactNo.toString();
    globals.addressDetailsList[0].pin =beanObj.pinCode.toString();*/
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
          // null//
          new CustomerFormationMasterTabs(null,bean),
        ));
  }

  void saveNOC() {
    int i = 1;
    for (var obj in items) {
      AppDatabase.get().updateCreditBereauLoanDetailsWithLoanSeq(obj, i);
      print("Updating for image");
      i++;
    }

    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content:  Text(Translations.of(context).text('Data_Saved')),
        duration: Duration(milliseconds: 500),
      ),
    );
    return;
  }

  _takePhoto(BuildContext context, int position) async {

    final result = Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new OpenCamera(),
          fullscreenDialog: true,
        )).then((onValue) {
      setState(() {
        print(onValue);
        items[position].mnocimagestring = onValue;
      });
      _isReady = true;

      for(int i=0;i<items.length;i++){
        if(items[i].mnocimagestring==null||items[i].mnocimagestring.trim=="")_isReady= false;
      }

      /*if(int.parse(cbResultBean.mprimarynoofodaccs)+int.parse(cbResultBean.msecondarynoofodacs)==imageCounter){
        print("inside it");
        _isReady= true;
      }*/

      //setState(() {});
    });
  }

  Future<void> showAlert(String MFIName, var pic, int position, context) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("${MFIName} NOC"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  new Image.file(
                    File(pic),
                    height: 400.0,
                    width: 400.0,
                  )
                ],
              ),
            ),
            actions: <Widget>[
              new Container(
                child: beanObj.mrefno == null || beanObj.mrefno == 0
                    ? new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _takePhoto(context, position);
                    },
                    child: Text(Translations.of(context).text('Recapture')))
                    : null,
              ),
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(Translations.of(context).text('Ok'))),
              new Container(
                child: beanObj.mrefno == 0 || beanObj.mrefno == null
                    ? new FlatButton(
                    onPressed: () {
                      items[position].mnocimagestring = null;
                      Navigator.of(context).pop();
                      _isReady = true;
                      for (int i = 0; i < items.length; i++) {
                        if (items[i].mnocimagestring == "" ||
                            items[i].mnocimagestring == "")
                          _isReady = false;
                      }
                      /* for (var img in imageList) {
  if (img == null || img == "") {
  _isReady = false;
  }
  }*/
                      ;
                      setState(() {});
                    },
                    child: Text(Translations.of(context).text('Remove')))
                    : null,
              )
            ],
          );
        });
  }

  routeNOC() {


    if(globals.reportingUser==null||globals.reportingUser=="null"){
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content:  Text(Translations.of(context).text('Reporting_User_Not_Set')),
            duration: Duration(milliseconds: 500),
          ));

      return;
    }


    setState(() {
      beanObj.mprospectstatus = 4;

      //new
      _isReady = false;
    });

   // saveNOC();

    AppDatabase.get()
        .updateCreditBereauMasterProspectStatusFromTrefNo(
        beanObj.trefno,
        beanObj.mrefno,
        globals.reportingUser,
        beanObj.mprospectstatus,
        DateTime.now(),globals.agentUserName)
        .then((val) {
      setState(() {});
      _processSuccessfull();
    });
  }

  Future<void> _processSuccessfull() async {
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
                children: <Widget>[
                  Text(Translations.of(context).text('Data_Routed')),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> showMessage( msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$msg.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(Translations.of(context).text('Ok')),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                      //new CustomerFormationMasterTabs(widget.cameras)), //When Authorized Navigate to the next screen
                      new CustomerList(null,"Customer Creation")),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
