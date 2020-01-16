import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/InternalBankTransferService.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/bean/GLAccountBean.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/bean/InternalBankTransferBean.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eco_mfi/Utilities/app_constant.dart'as labels;
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;

import 'FullScreenDialofForGLSelection.dart';

class InternalBankTransfer extends StatefulWidget {
  InternalBankTransfer();

  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );
  @override
  _Transactions createState() => new _Transactions();
}

class _Transactions extends State<InternalBankTransfer> {
  TextEditingController branchController = new TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SharedPreferences prefs;
  String username;
  int branch = 0;
  bool circInd = false;
  InternalBankTransferBean transactionBeanObj = new InternalBankTransferBean();
  bool isDataSynced = false;
  bool circIndicatorIsDatSynced = false;
  FullScreenDialogForGLSelection _myGLDialog =
  new FullScreenDialogForGLSelection("");
  Utility obj = new Utility();
  //List<InternalBankTransferBean> closureBean;
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  LookupBeanData cashtr;
  LookupBeanData crdr;
  LookupBeanData narration;

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode);
      username = prefs.getString(TablesColumnFile.musrcode);
      transactionBeanObj.mcreatedby = username;
      transactionBeanObj.mlbrcode = branch;

      branchController.value = TextEditingValue(text: branch.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    getSessionVariables();
    List tempDropDownValues =  new List();
    tempDropDownValues.add(transactionBeanObj.mcashtr);
    tempDropDownValues.add(transactionBeanObj.mcrdr);
    //print(transactionBeanObj.mcashtr);
    for (int k = 0;
    k < globals.dropdownCaptionsValuesTransaction.length;
    k++) {
      for (int i = 0;
      i < globals.dropdownCaptionsValuesTransaction[k].length;
      i++) {
        print("k and i is $k $i");
        print(globals.dropdownCaptionsValuesTransaction[k][i].mcode.length);
        try{
          if (globals.dropdownCaptionsValuesTransaction[k][i].mcode.toString() ==
              tempDropDownValues[k].toString().trim()) {

            print("matched $k");
            setValue(k, globals.dropdownCaptionsValuesTransaction[k][i]);
          }
        }catch(_){
          print("Exception in dropdown");
        }
      }
    }

  }

  showDropDown(LookupBeanData selectedObj, int no) {

    if(selectedObj.mcodedesc.isEmpty){
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          cashtr = blankBean;
          transactionBeanObj.mcashtr = 0;
          break;
        case 1:
          crdr = blankBean;
          transactionBeanObj.mcrdr = blankBean.mcode;;
          break;
        case 2:
          narration = blankBean;
          transactionBeanObj.mnarration = blankBean.mcode;
          break;
        default:
          break;
      }
      setState(() {
      });
    }
    else{
      for (int k = 0;
      k < globals.dropdownCaptionsValuesTransaction[no].length;
      k++) {
        if (globals.dropdownCaptionsValuesTransaction[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesTransaction[no][k]);
        }
      }
    }
  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          cashtr = value;
          transactionBeanObj.mcashtr = int.parse(value.mcode);
          break;
        case 1:
          crdr = value;
          transactionBeanObj.mcrdr = value.mcode;
          break;
        case 2:
          narration = value;
          transactionBeanObj.mnarration = value.mcode;
          break;
        default:
          break;
      }
    });
  }

  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);
  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
    k < globals.dropdownCaptionsValuesTransaction[no].length;
    k++) {
      mapData.add(globals.dropdownCaptionsValuesTransaction[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc,overflow: TextOverflow.ellipsis,maxLines: 3,),
      );
    }).toList();
    return _dropDownMenuItems1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: new Text(Translations.of(context).text('Internal_Bank_Transfer')),
      ),
      body: Form(
        key: _formKey,
        onChanged: () {
          final FormState form = _formKey.currentState;
          form.save();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                        controller: branchController,
                        enabled: false,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 16.0,
                            color: Colors.black),
                        decoration: InputDecoration(
                          icon: Icon(
                            FontAwesomeIcons.codeBranch,
                            color: Colors.amber.shade500,
                          ),
                          hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          labelText: labels.BRANCH,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                child: new DropdownButtonFormField(
                  value: cashtr,
                  items: generateDropDown(0),
                  onChanged: (LookupBeanData newValue) {
                    showDropDown(newValue, 0);
                  },
                  validator: (args) {
                    print(args);
                  },
                  decoration: InputDecoration(labelText: Translations.of(context).text('Transaction_Type')),
                ),
              ),
              SizedBox(height: 5.0),
              transactionBeanObj.mcashtr == 1?
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                child: new DropdownButtonFormField(
                  value: crdr,
                  items: generateDropDown(1),
                  onChanged: (LookupBeanData newValue) {
                    showDropDown(newValue, 1);
                  },
                  validator: (args) {
                    print(args);
                  },
                  decoration: InputDecoration(labelText: Translations.of(context).text('CR/DR')),
                ),
              ): transactionBeanObj.mcashtr == 2?

              Card(
                child: new ListTile(
                  title:
                  new Text(Translations.of(context).text("Debit  Account Number")),
                  subtitle: transactionBeanObj.mdraccid ==
                      null ||
                      transactionBeanObj.mdraccid ==
                          "null"
                      ? new Text("")
                      : new Text(
                      "${transactionBeanObj.mdraccid} "),
                  onTap: () async {
                    GLAccountBean glBean ;
                    glBean = await Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) => _myGLDialog,
                          fullscreenDialog: true,
                        ));
                    if (glBean != null) {
                      transactionBeanObj.mdraccid = glBean.mprdacctid;

                    }

                    setState(() {});
                  },
                ),
              )













             /* Card(
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'DR Account ID',
                        labelText: 'DR Account ID',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.grey),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            )),
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                      initialValue: transactionBeanObj.mdraccid == null
                          ? ""
                          : "${transactionBeanObj.mdraccid}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          try{
                            transactionBeanObj.mdraccid = (value);
                          }
                          catch (_){}
                        }
                      }
                  )
              )*/: new Text(""),
              transactionBeanObj.mcashtr == 1?
              Card(
                child: new ListTile(
                  title:
                  new Text(Translations.of(context).text("Account Number")),
                  subtitle: transactionBeanObj.maccid ==
                      null ||
                      transactionBeanObj.maccid ==
                          "null"
                      ? new Text("")
                      : new Text(
                      "${transactionBeanObj.maccid} "),
                  onTap: () async {
                    GLAccountBean glBean ;
                    glBean = await Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) => _myGLDialog,
                          fullscreenDialog: true,
                        ));
                    if (glBean != null) {
                      transactionBeanObj.maccid = glBean.mprdacctid;

                    }

                    setState(() {});
                  },
                ),
              ):transactionBeanObj.mcashtr == 2?
              Card(
                child: new ListTile(
                  title:
                  new Text(Translations.of(context).text("Credit Account Number")),
                  subtitle: transactionBeanObj.mcraccid ==
                      null ||
                      transactionBeanObj.mcraccid ==
                          "null"
                      ? new Text("")
                      : new Text(
                      "${transactionBeanObj.mcraccid} "),
                  onTap: () async {
                    GLAccountBean glBean ;
                    glBean = await Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) => _myGLDialog,
                          fullscreenDialog: true,
                        ));
                    if (glBean != null) {
                      transactionBeanObj.mcraccid = glBean.mprdacctid;

                    }

                    setState(() {});
                  },
                ),
              ): new Text(""),
              Card(
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Amount',
                        labelText: 'Amount',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.grey),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            )),
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                      initialValue: transactionBeanObj.mamt == null
                          ? ""
                          : "${transactionBeanObj.mamt}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          try{
                            transactionBeanObj.mamt = double.parse(value);
                          }
                          catch (_){}
                        }
                      }
                  )
              ),
              SizedBox(height: 5.0),
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                child: new DropdownButtonFormField(
                  value: narration,
                  items: generateDropDown(2),
                  onChanged: (LookupBeanData newValue) {
                    showDropDown(newValue, 2);
                  },
                  validator: (args) {
                    print(args);
                  },
                  decoration: InputDecoration(labelText: Translations.of(context).text('Narration')),
                ),
              ),
              SizedBox(height: 5.0),
              Card(
                  child:
                  new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'User Narration',
                        labelText: 'User Narration',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.grey),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            )),
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                      initialValue: transactionBeanObj.mremark == null
                          ? ""
                          : "${transactionBeanObj.mremark}",
                      onSaved: (String value) {
                        if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                          transactionBeanObj.mremark = value;
                        }
                      }
                  )
              ),
              new Container(
                height: 20.0,
              ),
              FloatingActionButton.extended(
                  icon: Icon(Icons.assignment_turned_in),
                  backgroundColor: Color(0xff07426A),
                  label: Text("Post Transaction"),
                  onPressed: ()async{
                    //proceed(cifBeanObj);

                    if(validateTransaction()){
                      _ShowProgressInd(context);
                      _postInternalTransaction();

                    }




                  }
              ),


            ],
          ),
        ),
      ),
    );
  }

  Future<void> _ShowProgressInd(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translations.of(context).text('Please_Wait')),
          content: SingleChildScrollView(
              child: SpinKitCircle(color: Colors.amber.shade500)
          ),
        );
      },
    );
  }


  Future<Null> _postInternalTransaction()async{

    InternalBankTransferService internalBankTransferService= new InternalBankTransferService();

    await internalBankTransferService.postInternalBanktransfer(transactionBeanObj).then((InternalBankTransferBean interbanktransferBean){

      if(interbanktransferBean==null){
        Navigator.of(context).pop();
        _CheckIfThere("No Account Found");

      }
      else if(interbanktransferBean.mstatus==0){
        Navigator.of(context).pop();

        _CheckIfThere(interbanktransferBean.merrormessage);

      }

      else{
        Navigator.of(context).pop();
        _showAlert(interbanktransferBean.merrormessage);

      }




    });


  }

 /* Future<void> loadBulkLoanClosurePage(int groupcd) async {

    if(transactionBeanObj.mcenterid == 0 || transactionBeanObj.mcenterid == "null" || transactionBeanObj.mcenterid == null  ){
      _showAlert("Please Select Center Code");
      return false;
    }
    if(transactionBeanObj.mgroupcd == 0 || transactionBeanObj.mgroupcd == "null" || transactionBeanObj.mgroupcd == null  ){
      _showAlert("Please Select Group Code");
      return false;
    }

    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    GetBulkClosureAccFromOmni getBulkClosureAccFromOmni = new GetBulkClosureAccFromOmni();
    await getBulkClosureAccFromOmni.trySave(groupcd).then((List<InternalBankTransferBean> closureBean) async {
      this.closureBean = closureBean;
      print("closureBean" + closureBean.toString());

      bool netAvail = false;
      netAvail = await obj.checkIfIsconnectedToNetwork();
      if (netAvail == false) {
        showMessageWithoutProgress("Network Not available");
        return;
      }
      else {
        if (closureBean.isEmpty) {
          _CheckIfThere();
        }
        else
        {
          print('success');
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new BulkLoanPreClosureList(closureBean)),
            // When Authorized Navigate to the next screen
          );
        }
      }
      setState(() {
      });
    });
  }*/

  Future<void> _showAlert(arg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$arg'),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showMessageWithoutProgress(String message,
      [MaterialColor color = Colors.red]) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  Future<void> _CheckIfThere(String msg) async {

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.cancel,
              color: Colors.red,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Text(msg),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                onPressed: () {
                  Navigator.of(context).pop();
                //  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }


  bool validateTransaction(){

    if(transactionBeanObj==null){
      _showAlertWithError(Translations.of(context).text(''), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(transactionBeanObj.mlbrcode == 0||transactionBeanObj.mlbrcode==null){
      _showAlertWithError(Translations.of(context).text('BRANCH'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(transactionBeanObj.mcashtr==0||transactionBeanObj.mcashtr==null){

      _showAlertWithError(Translations.of(context).text('cashtr'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(transactionBeanObj.mcashtr== 1&&(transactionBeanObj.mcrdr==null||transactionBeanObj.mcrdr.trim()==""||

        transactionBeanObj.mcrdr.trim()=="null"
    )){
      _showAlertWithError(Translations.of(context).text('cr_deb'), Translations.of(context).text("itIsMand"));
      return false;
    }

    if(transactionBeanObj.mcashtr== 2&&(transactionBeanObj.mdraccid==null||transactionBeanObj.mdraccid.trim()==""||

        transactionBeanObj.mdraccid.trim()=="null"
    )){
      _showAlertWithError(Translations.of(context).text('draccid'), Translations.of(context).text("itIsMand"));
      return false;
    }

    if(transactionBeanObj.mcashtr== 2&&(transactionBeanObj.mcraccid==null||transactionBeanObj.mcraccid.trim()==""||

        transactionBeanObj.mcraccid.trim()=="null"
    )){
      _showAlertWithError(Translations.of(context).text('craccid'), Translations.of(context).text("itIsMand"));
      return false;
    }


    if(transactionBeanObj.mamt== 0||transactionBeanObj.mamt==null){
      _showAlertWithError(Translations.of(context).text('Amount'), Translations.of(context).text("itIsMand"));
      return false;
    }


    if(transactionBeanObj.mnarration== null||transactionBeanObj.mnarration.trim()==""||
        transactionBeanObj.mnarration.trim()=="null"){
      _showAlertWithError(Translations.of(context).text('narr'), Translations.of(context).text("itIsMand"));
      return false;
    }


    if(transactionBeanObj.mremark== null||transactionBeanObj.mremark.trim()==""||
        transactionBeanObj.mremark.trim()=="null"){
      _showAlertWithError(Translations.of(context).text('Remarks'), Translations.of(context).text("itIsMand"));
      return false;
    }


    return true;


  }



  Future<void> _showAlertWithError(arg, error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$arg'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$error'),
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
      },
    );
  }



}
