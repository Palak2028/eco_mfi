import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eco_mfi/Utilities/OpenCamera.dart';
import 'package:eco_mfi/Utilities/app_constant.dart' as constant;
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CbResultBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CreditBereauBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/NOCImageBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/NOCApprovalList.dart';

import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/Utilities/app_constant.dart' as constant;

class NOCApproval extends StatefulWidget {
  final CreditBereauBean CreditBeareauPassedObject;

  NOCApproval({Key key, @required this.CreditBeareauPassedObject})
      : super(key: key);

  @override
  _NOCApproval createState() => new _NOCApproval();
}

class _NOCApproval extends State<NOCApproval> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  CreditBereauBean beanObj = new CreditBereauBean();
  CbResultBean cbResultBean = new CbResultBean();
  List<CbResultBean> items = new List<CbResultBean>();
  List<String> approvedProspect = new List<String>();

  int count = 1;
  bool _isReady = false;

  File _image;

  Future getImage( int index) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 400.0,maxWidth: 400.0);
    String st = image.path;
    print("path"+st.toString());
    items[index].mnocimagestring= image.path;
    setState(() {
      _image = image;
    });
    _isReady = true;
    for(var creditBereauLoanObj in items){
      if(creditBereauLoanObj.mnocimagestring==null||creditBereauLoanObj.mnocimagestring.trim()==""){
        _isReady=true;
      }
    }
    setState(() {
      _image = image;
    });
  }


  void initState() {
    print("xxxxxxxxxxxxxxxinit statexxxxxxxxxxxxxxxx");
    super.initState();
    print(widget.CreditBeareauPassedObject);
    beanObj = widget.CreditBeareauPassedObject;
    getSessionVariables();
  }


  void getSessionVariables() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    globals.agentUserName = prefs.get(TablesColumnFile.musrcode);
  }
  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) {
    print("inside getHomePageBody");
    print(items.length);

    print(snapshot.data);
    if (snapshot.data != null) {
      print(items.length);
      if (items.length == 0) {
        return Center(
          child: new Container(
            child: new Text(constant.noLoansFound),
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
                      ' ${items[index].mnameofmfi}',
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
            trailing: (items[index].mnocimagestring==null||items[index].mnocimagestring.trim()=="")?
            new IconButton(icon: Icon(Icons.camera_alt), onPressed:(){
              getImage(index);
            } ):new IconButton(icon: Icon(Icons.remove_red_eye),
                onPressed: (){
                  showAlert(items[index].mnameofmfi, items[index].mnocimagestring, index);
                }) ,

            /*trailing: items[index].moverdueamount != 0.0
                ? new Container(
                    child: items[index].mnocimagestring == null|| items[index].mnocimagestring.trim() == ""
                        ? new IconButton(
                        tooltip: "Capture NOC",
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          getImage(index);
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
              .getCbResult(beanObj.trefno,beanObj.mrefno)
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
                    new CircularProgressIndicator());
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else
                  return DataTable(rows: [
                    new DataRow(cells: [
                      new DataCell(
                        new Text(
                          "${constant.status} ",
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      new DataCell(new Text(cbResultBean.mcbcheckstatus,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: cbResultBean.mcbcheckstatus == "Pass" ? Colors.green : Colors.red,
                              fontSize: 20.0))),
                      new DataCell(new Text(
                        "${constant.mfiOd}",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      )),
                      new DataCell(new Text("${cbResultBean.mmfitotovrdueamt}",
                          style: TextStyle(
                              color: cbResultBean.mmfitotovrdueamt < 0 ? Colors.green : Colors.red,
                              fontSize: 20.0))),
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
                        "${constant.odAcounts}",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      )),
                      new DataCell(new Text("${cbResultBean.mtotovrdueaccno}",
                          style: TextStyle(
                              color: (cbResultBean.mtotovrdueaccno) < 1 ? Colors.green : Colors.red,
                              fontSize: 20.0))),
                      new DataCell(new Text(
                        Translations.of(context).text('Total_OD'),
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      )),
                      new DataCell(new Text("${cbResultBean.mtotovrdueamt}",
                          style: TextStyle(
                              color: cbResultBean.mtotovrdueamt < 100000 ? Colors.green : Colors.red,
                              fontSize: 20.0))),
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
                        "${constant.expAmt}",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      )),
                      new DataCell(new Text("${cbResultBean.mexpsramt}",
                          style: TextStyle(
                              color: cbResultBean.mexpsramt != 0 ? Colors.green : Colors.red,
                              fontSize: 20.0))),
                      new DataCell(new Text(
                        "${constant.mfiCurrBal}",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      )),
                      new DataCell(new Text("${cbResultBean.mmfitotcurrentbal}",
                          style: TextStyle(
                              color: cbResultBean.mmfitotcurrentbal <= 100000 ? Colors.green : Colors.red,
                              fontSize: 20.0))),
                    ]),
                  ], columns: [
                    new DataColumn(
                      label: const Text('${constant.details}'),
                    ),
                    new DataColumn(
                      label: const Text('${constant.result}'),
                    ),
                    new DataColumn(
                      label: const Text('${constant.details}'),
                    ),
                    new DataColumn(
                      label: const Text('${constant.result}'),
                    ),
                  ]);


            }
          });
    } else {
      cbResultBuilder = TablePicker(
        cbRes: cbResultBean,
      );
    }

    var cbLoanBuilder;

    if (count == 2) {
      count++;

      cbLoanBuilder = new FutureBuilder(
          future: AppDatabase.get()
              .getLoanDetails(beanObj.trefno,beanObj.mrefno)
              .then((List<CbResultBean> listCbres) {
            for (var obj in listCbres) {
              items.add(obj);
            }
            print("length of items " + items.length.toString());
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

                      )
                    ],
                  ),
                  trailing: (items[position].mnocimagestring==null||items[position].mnocimagestring.trim()=="")?
                  new IconButton(icon: Icon(Icons.camera_alt), onPressed: (){
                    getImage(position);
                  }):new IconButton(icon: Icon(Icons.remove_red_eye),
                      onPressed:(){
                        showAlert(items[position].mnameofmfi, items[position].mnocimagestring, position);

                      }) ,


                  /*trailing: items[position].moverdueamount!= 0.0
                      ? new Container(
                          child: items[position].mnocimagestring == null||items[position].mnocimagestring.trim()==""
                              ?  new IconButton(
                      tooltip: "Capture NOC",
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        getImage(position);
                      })
                              : new IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  tooltip: "View Captutred NOC",
                                  color: Color(0xff01579b),
                                  onPressed: () {
                                    showAlert(items[position].mnameofmfi,
                                        items[position].mnocimagestring, position, context);
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
            '${beanObj.mprospectname} NOC Approval ',
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
                  Icons.save,
                  color: Colors.white,
                  size: 44.0,
                ),
                tooltip: "Approve",
                onPressed: () {

                },
                splashColor: Colors.blueAccent),
          ],*/
        ),
        body: SafeArea(
            child: SingleChildScrollView(
              child: new Column(

                  children: <Widget>[


                    cbResultBuilder,

                    SizedBox(
                      height: 20.0,
                    ),

                    Center(
                      child: Container(
                        child: new Text(
                          Translations.of(context).text('Loan_Details'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25.0),
                        ),
                      ),
                    ),

                    new Container(
                      width: 450.0,
                  height: 250.0,
                      child: cbLoanBuilder,
                    ),
                    new SizedBox(height: 10.0,),
                    new Container(
                      child:widget.CreditBeareauPassedObject.mprospectstatus==4&& widget.CreditBeareauPassedObject.mcreatedby!= globals.agentUserName
                          &&_isReady==true
                          ?new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.lightBlueAccent.shade100,
                            elevation: 5.0,
                            child: MaterialButton(
                              minWidth: 150.0,
                              height: 42.0,
                              onPressed: () {
                                //routeNOCResult(6);
				
				double maxRange = 60000.0;

                              double removedNOCAmount = 0.0;
                              for (CbResultBean obj in items) {
                                if(obj.mnocimagestring!= null&&obj.mnocimagestring.trim()!=""
                                    &&obj.mnocimagestring.trim().toLowerCase()!="null"&&obj.mmfiid.substring(0,3)=="MFI"){

                                  removedNOCAmount +=obj.mcurrentbalance;

                                }
                              }
                              switch (widget.CreditBeareauPassedObject.mtier) {
                                case 1:
                                  maxRange = 60000.0;
                                  break;
                                case 2:
                                  maxRange = 60000.0;
                                  break;
                                case 3:
                                  maxRange = 100000.0;
                                  break;
                                case 4:
                                  maxRange = 100000.0;
                                  break;
                                case 5:
                                  maxRange = 100000.0;
                                  break;
                                case 6:
                                  maxRange = 100000.0;
                                  break;
                                case 7:
                                  maxRange = 100000.0;
                                  break;
                                case 8:
                                  maxRange = 100000.0;
                                  break;
                                default:
                                  maxRange = 60000.0;
                              }


                              removedNOCAmount+=cbResultBean.mexpsramt;
                              showConfirmationAlert(6,removedNOCAmount);
                                //showConfirmationAlert(6);
                              },
                              color: Colors.green,
                              child: Text(Translations.of(context).text('Approve'),
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),

                          new SizedBox(width: 10.0,),
                          Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.lightBlueAccent.shade100,
                            elevation: 5.0,
                            child: MaterialButton(
                              minWidth: 150.0,
                              height: 42.0,
                              onPressed: () {
                                //routeNOCResult(5);
                                showConfirmationAlert(5,0.0);
                              },
                              color: Colors.red,
                              child: Text(Translations.of(context).text('Disapprove'),
                                  style: TextStyle(color: Colors.white)),
                            ),
                          )



                        ],
                      ):new Text(""),
                    ),
                  ]),
            )));
  }



  Future<void> routeNOCResult(status) async {






    if(globals.reportingUser==null||globals.reportingUser=="null"||globals.reportingUser.trim()==""){
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content:  Text(Translations.of(context).text('Reporting_User_Not_Set')),
            duration: Duration(milliseconds: 500),
          ));

      return;
    }

    try{
      await saveNOC();
    }catch(_){

    }
    int prospectStatus = status;
    if(prospectStatus==6) {
    
    
    
    double removedNOCAmount = 0.0;
      for (CbResultBean obj in items) {
       if(obj.mnocimagestring!= null&&obj.mnocimagestring.trim()!=""
           &&obj.mnocimagestring.trim().toLowerCase()!="null"&&obj.mmfiid.substring(0,3)=="MFI"){

         removedNOCAmount +=obj.mcurrentbalance;
         
       }
      }
      double maxRange = 60.000;
      switch (widget.CreditBeareauPassedObject.mtier) {
        case 1:
          maxRange = 60000.0;
          break;
        case 2:
          maxRange = 60000.0;
          break;
        case 3:
          maxRange = 100000.0;
          break;
        case 4:
          maxRange = 100000.0;
          break;
        case 5:
          maxRange = 100000.0;
          break;
        case 6:
          maxRange = 100000.0;
          break;
        case 7:
          maxRange = 100000.0;
          break;
        case 8:
          maxRange = 100000.0;
          break;
        default:
          maxRange = 60000.0;
      }
	
	removedNOCAmount+=cbResultBean.mexpsramt;
      await AppDatabase.get().updateExposureFromMrefTref(widget.CreditBeareauPassedObject.trefno,widget.CreditBeareauPassedObject.mrefno,removedNOCAmount);
    }
    await AppDatabase.get().updateCreditBereauMasterProspectStatusFromTrefNo(widget.CreditBeareauPassedObject.trefno,widget.CreditBeareauPassedObject.mrefno,globals.agentUserName,prospectStatus,DateTime.now(),globals.agentUserName);

  //_processSuccessfull();

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
                  Text(Translations.of(context).text('Result_Submitted')),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                onPressed: () {
                  Navigator.of(context).pop();
  /*Navigator.of(context).pop();
  Navigator.of(context).pop();*/
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                          new NOCApprovalList()
                      ));


                },
              ),
            ],
          );
        });
  }



  void saveNOC() async{
    int i = 1;
    for (var obj in items) {
      await AppDatabase.get().updateCreditBereauLoanDetailsWithLoanSeq(obj, i);
      print("Updating for image");
      i++;
    }


    return;
  }


  Future<void> showAlert(String MFIName, var pic, int position) async {
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
                child: beanObj.mprospectstatus == 4
                    ? new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      getImage(position);
                      _isReady = true;
                      for(var creditBereauLoanObj in items){
                        if(creditBereauLoanObj.mnocimagestring==null||creditBereauLoanObj.mnocimagestring.trim()==""){
                          _isReady=false;
                        }
                      }
                      setState(() {

                      });

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
                child: beanObj.mprospectstatus == 4
                    ? new FlatButton(
                    onPressed: () {
                      items[position].mnocimagestring ="";
                      Navigator.of(context).pop();
                      _isReady= false;
                      setState(() {});
                    },
                    child: Text(Translations.of(context).text('Remove')))
                    : null,
              )
            ],
          );
        });
  }


  Future<void> showConfirmationAlert(int prospectStatus, double exposureAmt) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title:new Text(Translations.of(context).text('Confirmation_Alert')),
          content:prospectStatus==5? new Row(
            children: <Widget>[
              new Text(Translations.of(context).text('Are_You_Sure_You_Want_To')),
              new Text(Translations.of(context).text('Disapprove'),style: TextStyle(color: Colors.red),)
            ],
          ):new Row(
            children: <Widget>[
                  new Text("Are you sure you want to "),
                  new Text("Approve   amount $exposureAmt",style: TextStyle(color: Colors.green),),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                Translations.of(context).text('Yes'),
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {

                await routeNOCResult(prospectStatus);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                print("Coming Herer");
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                      new NOCApprovalList()), //When Authorized Navigate to the next screen
                );
              },
            ),
            FlatButton(
              child: Text(
                Translations.of(context).text('No'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}

class TablePicker extends StatelessWidget {
  const TablePicker({this.cbRes});

  final CbResultBean cbRes;

  @override
  Widget build(BuildContext context) {
    return DataTable(rows: [
      new DataRow(cells: [
        new DataCell(
          new Text(
            "${constant.status} ",
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
        ),
        new DataCell(new Text(cbRes.mcbcheckstatus,
            textAlign: TextAlign.end,
            style: TextStyle(
                color: cbRes.mcbcheckstatus == "Pass" ? Colors.green : Colors.red,
                fontSize: 20.0))),
        new DataCell(new Text(
          "${constant.mfiOd}",
          style: TextStyle(
            fontSize: 15.0,
          ),
        )),
        new DataCell(new Text("${cbRes.mmfitotovrdueamt}",
            style: TextStyle(
                color: cbRes.mmfitotovrdueamt < 0 ? Colors.green : Colors.red,
                fontSize: 20.0))),
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
          "${constant.odAcounts}",
          style: TextStyle(
            fontSize: 15.0,
          ),
        )),
        new DataCell(new Text("${cbRes.mtotovrdueaccno}",
            style: TextStyle(
                color: (cbRes.mtotovrdueaccno) < 1 ? Colors.green : Colors.red,
                fontSize: 20.0))),
        new DataCell(new Text(
          Translations.of(context).text('Total_OD'),
          style: TextStyle(
            fontSize: 15.0,
          ),
        )),
        new DataCell(new Text("${cbRes.mtotovrdueamt}",
            style: TextStyle(
                color: cbRes.mtotovrdueamt < 100000 ? Colors.green : Colors.red,
                fontSize: 20.0))),
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
          "${constant.expAmt}",
          style: TextStyle(
            fontSize: 15.0,
          ),
        )),
        new DataCell(new Text("${cbRes.mexpsramt}",
            style: TextStyle(
                color: cbRes.mexpsramt != 0 ? Colors.green : Colors.red,
                fontSize: 20.0))),
        new DataCell(new Text(
          "${constant.mfiCurrBal}",
          style: TextStyle(
            fontSize: 15.0,
          ),
        )),
        new DataCell(new Text("${cbRes.mmfitotcurrentbal}",
            style: TextStyle(
                color: cbRes.mmfitotcurrentbal <= 100000 ? Colors.green : Colors.red,
                fontSize: 20.0))),
      ]),
    ], columns: [
      new DataColumn(
        label: const Text('${constant.details}'),
      ),
      new DataColumn(
        label: const Text('${constant.result}'),
      ),
      new DataColumn(
        label: const Text('${constant.details}'),
      ),
      new DataColumn(
        label: const Text('${constant.result}'),
      ),
    ]);
  }
}
