import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/GroupFormationMasterSubmissionService.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFormationMasterSubmissionBean.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFormationMasterListViewBean.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class GroupFormationMasterSubmission extends StatefulWidget {
  final GroupFormationMasterListViewBean listOfGroupFormationData;

  GroupFormationMasterSubmission(
      {Key key, @required this.listOfGroupFormationData})
      : super(key: key);

  @override
  _GroupFormationMasterSubmissionState createState() =>
      new _GroupFormationMasterSubmissionState();
}

class _GroupFormationMasterSubmissionState
    extends State<GroupFormationMasterSubmission> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _controller = new TextEditingController();
  String userName = "";
  String role = "";
  String loginTime = "";

  GroupFormationMasterSubmissionBean newGroup =
      new GroupFormationMasterSubmissionBean();

  static bool isSubmitClicked = false;

  void getSessionVariables() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.get(TablesColumnFile.usrName);
    role = prefs.get(TablesColumnFile.usrDesignation);
    loginTime = prefs.get(TablesColumnFile.LoginTime);
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;
    isSubmitClicked = true;
    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save();
      getSessionVariables();
      var groupService = new GroupFormationMasterSubmissionService();
      groupService
          .createGroup(newGroup, userName)
          .then((value) => showMessage('New group created for}!', Colors.blue));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        elevation: 1.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.black,
        brightness: Brightness.light,
        title: new Text(
          'Group Fromation',
          //textDirection: TextDirection,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.normal),
        ),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(
                        Icons.add_location,
                        color: Colors.black,
                      ),
                      hintText: 'Enter  BranchCode here',
                      labelText: 'BranchCode',
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
                    initialValue: widget.listOfGroupFormationData != null &&
                            widget.listOfGroupFormationData.branchCode != null
                        ? widget.listOfGroupFormationData.branchCode.toString()
                        : "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => isSubmitClicked
                        ? val.isEmpty ? 'BranchCode  is required' : null
                        : "",
                    onSaved: (val) => newGroup.branchCode = int.tryParse(val),
                  ),
                  new Stack(
                    alignment: const Alignment(1.02, 0.0),
                    children: <Widget>[
                      new TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(
                            Icons.add_location,
                            color: Colors.black,
                          ),
                          hintText: 'Select CenterCode here',
                          labelText: 'CenterCode',
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
                        enabled: false,
                        initialValue: widget.listOfGroupFormationData != null &&
                                widget.listOfGroupFormationData.centerCode !=
                                    null
                            ? widget.listOfGroupFormationData.branchCode
                                .toString()
                            : "",
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(30)
                        ],
                        validator: (val) => isSubmitClicked
                            ? val.isEmpty ? 'CenterCode  is required' : null
                            : "",
                        onSaved: (val) =>
                            newGroup.centerCode = int.tryParse(val),
                      ),
                      new RaisedButton(
                        color: Colors.black,
                        elevation: 20.0,
                        child: new Text(
                          "Select",
                          style: TextStyle(color: Colors.white),
                        ),
                        padding: EdgeInsets.only(bottom: 0.0),
                        onPressed: () =>
                            getData(), /*_openAddEntryDialog(context),*/
                        // child: new Center(child: new Text('Save'))
                      ),
                    ],
                  ),
                  /* new Expanded(child: new Container(
                    margin: new EdgeInsets.only(bottom: 50.0),
                    child: new TextField(
                      maxLines: null,
                      controller: _controller,
                    ),
                    padding: new EdgeInsets.all(8.0),
                  )),
                 */

/*


*/

                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(
                        Icons.my_location,
                        color: Colors.black,
                      ),
                      hintText: 'Enter Group Type  here',
                      labelText: 'Group Type ',
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
                    initialValue: widget.listOfGroupFormationData != null &&
                            widget.listOfGroupFormationData.groupType != null
                        ? widget.listOfGroupFormationData.groupType.toString()
                        : "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => isSubmitClicked
                        ? val.isEmpty ? 'Group Type  is required' : null
                        : "",
                    onSaved: (val) => newGroup.groupType = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(
                        Icons.my_location,
                        color: Colors.black,
                      ),
                      hintText: 'Enter Group Recognition Test Date Name here',
                      labelText: 'Group Recognition Test Date',
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
                    initialValue: widget.listOfGroupFormationData != null &&
                            widget.listOfGroupFormationData
                                    .groupRecognitionTestDate !=
                                null
                        ? widget
                            .listOfGroupFormationData.groupRecognitionTestDate
                        : "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => isSubmitClicked
                        ? val.isEmpty
                            ? 'GroupRecognitionTestDate  is required'
                            : null
                        : "",
                    onSaved: (val) => newGroup.groupRecognitionTestDate =
                        DateTime.tryParse(val),
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(
                        Icons.my_location,
                        color: Colors.black,
                      ),
                      hintText: 'Enter GRT Approved By here',
                      labelText: 'GRT Approved By',
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
                    initialValue: widget.listOfGroupFormationData != null &&
                            widget.listOfGroupFormationData.GRTApprovedBy !=
                                null
                        ? widget.listOfGroupFormationData.GRTApprovedBy
                            .toString()
                        : "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => isSubmitClicked
                        ? val.isEmpty ? 'GRT Approved By is required' : null
                        : "",
                    onSaved: (val) => newGroup.GRTApprovedBy = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(
                        Icons.people,
                        color: Colors.black,
                      ),
                      hintText: 'Enter MeetingDay here',
                      labelText: 'MeetingDay',
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
                    initialValue: widget.listOfGroupFormationData != null
                        ? widget.listOfGroupFormationData.meetingDay.toString()
                        : "",
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(30),
                    ],
                    validator: (val) => isSubmitClicked
                        ? val.isEmpty ? 'MeetingDay is required' : null
                        : "",
                    onSaved: (val) => newGroup.meetingDay = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(
                        Icons.directions_subway,
                        color: Colors.black,
                      ),
                      hintText: 'Enter LoanAmountLimit here',
                      labelText: 'LoanAmountLimit',
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
                    initialValue: widget.listOfGroupFormationData != null
                        ? widget.listOfGroupFormationData.loanAmountLimit
                            .toString()
                        : "",
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(30),
                    ],
                    validator: (val) => isSubmitClicked
                        ? val.isEmpty ? 'LoanAmountLimit is required' : null
                        : "",
                    onSaved: (val) =>
                        newGroup.loanAmountLimit = int.tryParse(val),
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      hintText: 'Enter GroupName here',
                      labelText: 'GroupName',
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
                    initialValue: widget.listOfGroupFormationData != null &&
                            widget.listOfGroupFormationData.groupName != null
                        ? widget.listOfGroupFormationData.groupName.trim()
                        : "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => isSubmitClicked
                        ? val.isEmpty ? 'GroupName is required' : null
                        : "",
                    onSaved: (val) => newGroup.groupName = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(
                        Icons.merge_type,
                        color: Colors.black,
                      ),
                      hintText: 'Enter GroupSize here',
                      labelText: 'GroupSize',
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
                    initialValue: widget.listOfGroupFormationData != null &&
                            widget.listOfGroupFormationData.groupSize != null
                        ? widget.listOfGroupFormationData.groupSize.toString()
                        : "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => isSubmitClicked
                        ? val.isEmpty ? 'GroupSize is required' : null
                        : "",
                    onSaved: (val) => newGroup.groupSize = int.tryParse(val),
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(
                        Icons.merge_type,
                        color: Colors.black,
                      ),
                      hintText: 'Enter BranchGroupID here',
                      labelText: 'BranchGroupID',
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
                    initialValue: widget.listOfGroupFormationData != null &&
                            widget.listOfGroupFormationData.branchGroupID !=
                                null
                        ? widget.listOfGroupFormationData.branchGroupID
                            .toString()
                        : "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => isSubmitClicked
                        ? val.isEmpty ? 'BranchGroupID is required' : null
                        : "",
                    onSaved: (val) =>
                        newGroup.branchGroupID = int.tryParse(val),
                  ),
                  new Container(
                      padding: const EdgeInsets.only(
                          left: 80.0, top: 20.0, right: 80.0, bottom: 20.0),
                      child: new RaisedButton(
                        elevation: 20.0,
                        colorBrightness: Brightness.light,
                        color: Colors.black,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        child: const Text('Submit',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        onPressed: _submitForm,
                      )),
                ],
              ))),
    );
  }

  void getData() {}
/*  Future _openAddEntryDialog(BuildContext context) async {
    var save = await Navigator.of(context).push(new MaterialPageRoute<String>(
        builder: (context) {
          return new AddEntryDialog();
        },
        fullscreenDialog: true
    ));
    if (save != null) {

    }
  }*/

}

/*

class AddEntryDialog extends StatefulWidget {
  @override
  AddEntryDialogState createState() => new AddEntryDialogState();
}

class AddEntryDialogState extends State<AddEntryDialog> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('New entry'),
        actions: [
          new FlatButton(
           */ /*   onPressed: () {
                Navigator
                    .of(context)
                    .pop(new WeightSave(new DateTime.now(), new Random().nextInt(100).toDouble()));
              },*/ /*
              child: new Text('SAVE',
                  style: Theme
                      .of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.white))),
        ],
      ),
      body: new Text("Foo"),
    );
  }
}*/
