import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterFormationMasterListViewBean.dart';
import 'dart:async';

import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterFormationMasterSubmissionBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/CenterFormationSubmissionService.dart';
import 'package:eco_mfi/translations.dart';

class CenterFormationMasterSubmission extends StatefulWidget {
  final CenterFormationMasterListViewBean listOfCenterFoundationData;

  CenterFormationMasterSubmission(
      {Key key, @required this.listOfCenterFoundationData})
      : super(key: key);

  @override
  _CenterFormationMasterSubmissionState createState() =>
      new _CenterFormationMasterSubmissionState();
}

class _CenterFormationMasterSubmissionState
    extends State<CenterFormationMasterSubmission> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  CenterFormationMasterSubmissionBean newCenter =
      new CenterFormationMasterSubmissionBean();
  final TextEditingController _controller = new TextEditingController();
  static bool isSubmitClicked = true;

  Future<Null> _chooseDate(
      BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());

    if (result == null) return;

    setState(() {
      _controller.text = new DateFormat.yMd().format(result);
    });
  }

  bool isValidDob(String dob) {
    if (dob.isEmpty) return true;
    var d = convertToDate(dob);
    return d != null && d.isBefore(new DateTime.now());
  }

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  bool isValidPhoneNumber(String input) {
    final RegExp regex = new RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');
    return regex.hasMatch(input);
  }

  bool isValidEmail(String input) {
    final RegExp regex = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(input);
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
      form.save(); //This invokes each onSaved event

      print('Form save called, newCenter is now up to date...');
      print('id: ${newCenter.id}');
      print('centerName: ${newCenter.centerName}');
      print('distanceFromBranch: ${newCenter.distanceFromBranch}');
      print('EsubDistrictsmail: ${newCenter.subDistricts}');
      print('villagePopulation: ${newCenter.villagePopulation}');
      print('========================================');
      print('Submitting to back end...');
      var centerService = new CenterFormationSubmissionService();
      centerService.createCenter(newCenter).then(
          (value) => showMessage('New center created for}!', Colors.blue));
    }
  }

  @override
  Widget build(BuildContext context) {
    //final ListOfCenterFoundationData listOfCenterFoundationData = widget.listOfCenterFoundationData;
    //print("Data for printing data here is data adata data : "+ "${widget.listOfCenterFoundationData.centerName}"+" here is " + "${widget.listOfCenterFoundationData.agentUserName}");
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        elevation: 1.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: new Text(

          Translations.of(context).text('Center_Formation')
,
          //textDirection: TextDirection,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
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
                  /*new Text(
                    'Center Formation',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: new TextStyle(fontWeight: FontWeight.bold,height: 1.0,fontSize: 24.00,fontStyle: FontStyle.normal),
                  ),*/
                  new TextFormField(
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.business_center,
                        color: Colors.black,
                      ),
                      hintText: Translations.of(context).text('Enter_Center_Name_Here'),
                      labelText: Translations.of(context).text('Center_Name'),
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
                    initialValue: widget.listOfCenterFoundationData != null &&
                            widget.listOfCenterFoundationData.centerName != null
                        ? widget.listOfCenterFoundationData.centerName.trim()
                        : "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => isSubmitClicked
                        ? val.isEmpty ? Translations.of(context).text('Center_Name_Is_Required') : null
                        : "",
                    onSaved: (val) => newCenter.centerName = val,
                  ),
                  new TextFormField(
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.add_location,
                        color: Colors.black,
                      ),
                      hintText: Translations.of(context).text('Enter_Branch_Name_Here'),
                      labelText: Translations.of(context).text('Branch_Name'),
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
                    initialValue: widget.listOfCenterFoundationData != null &&
                            widget.listOfCenterFoundationData.branch != null
                        ? widget.listOfCenterFoundationData.branch.trim()
                        : "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => isSubmitClicked
                        ? val.isEmpty ? Translations.of(context).text('Branch_Is_Required') : null
                        : "",
                    onSaved: (val) => newCenter.branch = val,
                  ),
                  new TextFormField(
                    decoration:  InputDecoration(
                      icon: const Icon(
                        Icons.my_location,
                        color: Colors.black,
                      ),
                      hintText: Translations.of(context).text('Enter_State_Name_Here'),
                      labelText: Translations.of(context).text('State_Name'),
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
                    initialValue: widget.listOfCenterFoundationData != null &&
                            widget.listOfCenterFoundationData.state != null
                        ? widget.listOfCenterFoundationData.state.trim()
                        : "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => isSubmitClicked
                        ? val.isEmpty ? Translations.of(context).text('State_Is_Required') : null
                        : "",
                    onSaved: (val) => newCenter.state = val,
                  ),
                  new TextFormField(
                    decoration:  InputDecoration(
                      icon: const Icon(
                        Icons.my_location,
                        color: Colors.black,
                      ),
                      hintText: Translations.of(context).text('Enter_District_Name_Here'),
                      labelText: Translations.of(context).text('District_Name'),
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
                    initialValue: widget.listOfCenterFoundationData != null &&
                            widget.listOfCenterFoundationData.districts != null
                        ? widget.listOfCenterFoundationData.districts.trim()
                        : "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => isSubmitClicked
                        ? val.isEmpty ? Translations.of(context).text('District_Is_Required') : null
                        : "",
                    onSaved: (val) => newCenter.districts = val,
                  ),
                  new TextFormField(
                    decoration:  InputDecoration(
                      icon: const Icon(
                        Icons.my_location,
                        color: Colors.black,
                      ),
                      hintText: Translations.of(context).text('Enter_Sub-District_Name_Here'),
                      labelText: Translations.of(context).text('Sub-District_Name'),
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
                    initialValue: widget.listOfCenterFoundationData != null &&
                            widget.listOfCenterFoundationData.subDistricts !=
                                null
                        ? widget.listOfCenterFoundationData.subDistricts.trim()
                        : "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => isSubmitClicked
                        ? val.isEmpty ? Translations.of(context).text('Sub-District_Is_Required') : null
                        : "",
                    onSaved: (val) => newCenter.subDistricts = val,
                  ),
                  new TextFormField(
                    decoration:  InputDecoration(
                      icon: const Icon(
                        Icons.my_location,
                        color: Colors.black,
                      ),
                      hintText: Translations.of(context).text('Enter_Village_Name_Here'),
                      labelText: Translations.of(context).text('Village_Name'),
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
                    initialValue: widget.listOfCenterFoundationData != null &&
                            widget.listOfCenterFoundationData.villageName !=
                                null
                        ? widget.listOfCenterFoundationData.villageName.trim()
                        : "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => isSubmitClicked
                        ? val.isEmpty ? Translations.of(context).text('Village_Is_Required'): null
                        : "",
                    onSaved: (val) => newCenter.villageName = val,
                  ),
                  new TextFormField(
                    decoration:  InputDecoration(
                      icon: const Icon(
                        Icons.people,
                        color: Colors.black,
                      ),
                      hintText: Translations.of(context).text('Enter_Village_population_Here'),
                      labelText: Translations.of(context).text('Village_population'),
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
                    initialValue: widget.listOfCenterFoundationData != null
                        ? widget.listOfCenterFoundationData.villagePopulation
                            .toString()
                        : "",
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(30),
                    ],
                    validator: (val) => isSubmitClicked
                        ? val.isEmpty ? Translations.of(context).text('Village_population_Is_Required'): null
                        : "",
                    onSaved: (val) =>
                        newCenter.villagePopulation = int.tryParse(val),
                  ),
                  new TextFormField(
                    decoration:  InputDecoration(
                      icon: const Icon(
                        Icons.directions_subway,
                        color: Colors.black,
                      ),
                      hintText: Translations.of(context).text('Enter_Distance_From_Branch_Here'),
                      labelText: Translations.of(context).text('Distance_From_Branch'),
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
                    initialValue: widget.listOfCenterFoundationData != null
                        ? widget.listOfCenterFoundationData.distanceFromBranch
                            .toString()
                        : "",
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(30),
                    ],
                    validator: (val) => isSubmitClicked
                        ? val.isEmpty
                            ? Translations.of(context).text('Distance_From_Branch_Is_Required')
                            : null
                        : "",
                    onSaved: (val) =>
                        newCenter.distanceFromBranch = int.tryParse(val),
                  ),
                  new TextFormField(
                    decoration:  InputDecoration(
                      icon: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      hintText: Translations.of(context).text('Enter_Assign_To_Here'),
                      labelText: Translations.of(context).text('Assign_To'),
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
                    initialValue: widget.listOfCenterFoundationData != null &&
                            widget.listOfCenterFoundationData.assignedTo != null
                        ? widget.listOfCenterFoundationData.assignedTo.trim()
                        : "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => isSubmitClicked
                        ? val.isEmpty ? Translations.of(context).text('Assign_To_Is_Required') : null
                        : "",
                    onSaved: (val) => newCenter.assignedTo = val,
                  ),
                  new Row(children: <Widget>[
                    new Expanded(
                        child: new TextFormField(
                      decoration: new InputDecoration(
                        icon: const Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                        ),
                        hintText: Translations.of(context).text('Enter_Assigning_Date_Here'),
                        labelText: Translations.of(context).text('Assigning_Date'),
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
                      controller: _controller,
                      keyboardType: TextInputType.datetime,
                      validator: (val) =>
                          isValidDob(val) ? null : Translations.of(context).text('Not_A_Valid_Date'),
                      onSaved: (val) =>
                          newCenter.serveyDate = convertToDate(val),
                    )),
                    new IconButton(
                      icon: new Icon(Icons.more_horiz),
                      tooltip: 'Choose date',
                      onPressed: (() {
                        _chooseDate(context, _controller.text);
                      }),
                    )
                  ]),
                  new TextFormField(
                    decoration:  InputDecoration(
                      icon: const Icon(
                        Icons.merge_type,
                        color: Colors.black,
                      ),
                      hintText: Translations.of(context).text('Enter_Servey_Type_Here'),
                      labelText: Translations.of(context).text('Servey_Type'),
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
                    initialValue: widget.listOfCenterFoundationData != null &&
                            widget.listOfCenterFoundationData.serVeyType != null
                        ? widget.listOfCenterFoundationData.serVeyType.trim()
                        : "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => isSubmitClicked
                        ? val.isEmpty ?Translations.of(context).text('Servey_Type_Is_Required') : null
                        : "",
                    onSaved: (val) => newCenter.serVeyType = val,
                  ),
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Submit'),
                        onPressed: _submitForm,
                      )),
                ],
              ))),
    );
  }
}
