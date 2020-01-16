import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/pages/workflow/BulkLoanPreClosure/bean/BulkLoanPreClosureBean.dart';
import 'package:eco_mfi/pages/workflow/BulkLoanPreClosure/list/BulkLoanPreClosureList.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetBulkClosureAccFromOmni.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/app_constant.dart' as constant;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eco_mfi/Utilities/app_constant.dart'as labels;
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/FullScreenDialogForGroupSelection.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFoundation.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/FullScreenDialogForCenterSelection.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BulkLoanPreClosure extends StatefulWidget {
  BulkLoanPreClosure();

  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );
  @override
  _BulkLoanPreClosure createState() => new _BulkLoanPreClosure();
}

class _BulkLoanPreClosure extends State<BulkLoanPreClosure> {
  TextEditingController branchController = new TextEditingController();
  TextEditingController loanOfficerController = new TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FullScreenDialogForCenterSelection _myCenterDialog =
  new FullScreenDialogForCenterSelection("");
  FullScreenDialogForGroupSelection _myGroupDialog =
  new FullScreenDialogForGroupSelection("");
  SharedPreferences prefs;
  String username;
  int branch = 0;
  bool circInd = false;
  BulkLoanPreClosureBean closureBeanObj = new BulkLoanPreClosureBean();
  CenterDetailsBean centerBean = new CenterDetailsBean();
  bool isDataSynced = false;
  bool circIndicatorIsDatSynced = false;
  Utility obj = new Utility();
  List<BulkLoanPreClosureBean> closureBean;
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode);
      username = prefs.getString(TablesColumnFile.musrcode);

      branchController.value = TextEditingValue(text: branch.toString());
      loanOfficerController.value = TextEditingValue(
        text: username.toString(),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getSessionVariables();
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
        title: new Text(Translations.of(context).text('Bulk_Loan_Pre-Closure')),
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: TextFormField(
                        controller: loanOfficerController,
                        enabled: false,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 16.0,
                            color: Colors.black),
                        decoration: InputDecoration(
                          icon: Icon(
                            FontAwesomeIcons.centercode,
                            color: Colors.amber.shade500,
                          ),
                          hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          labelText: labels.LOANOFFICER,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
             SizedBox(height: 5.0),
              Card(
                color: Constant.mandatoryColor,
                child: new ListTile(
                  title:
                  new Text(Translations.of(context).text("centerNameNo")),
                  subtitle: closureBeanObj.mcentername ==
                      null ||
                      closureBeanObj.mcentername ==
                          "null"
                      ? new Text("")
                      : new Text(
                      "${closureBeanObj.mcentername.trim()} / ${closureBeanObj.mcenterid}"),
                  onTap: () async {
                    centerBean = await Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) => _myCenterDialog,
                          fullscreenDialog: true,
                        ));
                    if (centerBean != null) {
                      closureBeanObj.mcentername = centerBean.mcentername;
                      closureBeanObj.mcenterid = centerBean.mCenterId;
                    }
                    setState(() {});
                  },
                ),
              ),
              SizedBox(height: 5.0),
              Card(
                color: Constant.mandatoryColor,
                child: new ListTile(
                  title: new Text(
                      Translations.of(context).text("Group_Name/No")),
                  subtitle: closureBeanObj.mgroupname ==
                      null ||
                      closureBeanObj.mgroupname ==
                          "null"
                      ? new Text("")
                      : new Text(
                      "${closureBeanObj.mgroupname.trim()} / ${closureBeanObj.mgroupcd}"),
                  onTap: () async {
                    GroupFoundationBean bean = await Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          _myGroupDialog,
                          fullscreenDialog: true,
                        ));

                    if (closureBeanObj.mcenterid != null) {
                      closureBeanObj.mgroupcd =
                          bean.mgroupid;
                      closureBeanObj.mgroupname = bean.mgroupname;
                    }
                    setState(() {});
                  },
                ),
              ),
              SizedBox(height: 5.0),
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: OutlineButton(
                            borderSide:
                            BorderSide(color: Colors.amber.shade500),
                            child: Text(constant.viewList),
                            textColor: Colors.amber.shade500,
                            onPressed: () async {
                              circInd = true;
                              _ShowProgressInd(context);
                              loadBulkLoanClosurePage(closureBeanObj.mgroupcd);
                            },
                            shape: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                      ),
                    ],
                  )),



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

  Future<void> loadBulkLoanClosurePage(int groupcd) async {

    if(closureBeanObj.mcenterid == 0 || closureBeanObj.mcenterid == "null" || closureBeanObj.mcenterid == null  ){
      _showAlert("Please Select Center Code");
      return false;
    }
    if(closureBeanObj.mgroupcd == 0 || closureBeanObj.mgroupcd == "null" || closureBeanObj.mgroupcd == null  ){
      _showAlert("Please Select Group Code");
      return false;
    }

    setState(() {
      isDataSynced = true;
      circIndicatorIsDatSynced = true;
    });

    GetBulkClosureAccFromOmni getBulkClosureAccFromOmni = new GetBulkClosureAccFromOmni();
    await getBulkClosureAccFromOmni.trySave(groupcd).then((List<BulkLoanPreClosureBean> closureBean) async {
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
  }

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

  Future<void> _CheckIfThere() async {

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
                      new Text(" No Record Found "),
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
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
