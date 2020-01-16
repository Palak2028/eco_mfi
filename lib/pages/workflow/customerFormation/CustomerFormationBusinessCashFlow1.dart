import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterFormationMasterListViewBean.dart';
import 'dart:async';

import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterFormationMasterSubmissionBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/CenterFormationSubmissionService.dart';




class CustomerFormationBusinessCashFlow1 extends StatefulWidget {
  CustomerFormationBusinessCashFlow1({Key key}) : super(key: key);


  @override
  _CustomerFormationBusinessCashFlow1State createState() =>
      new _CustomerFormationBusinessCashFlow1State();
}

class _CustomerFormationBusinessCashFlow1State
    extends State<CustomerFormationBusinessCashFlow1> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();


  CenterFormationMasterSubmissionBean newCenter = new CenterFormationMasterSubmissionBean();
  final TextEditingController _controller = new TextEditingController();
  static  bool isSubmitClicked=false;

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
    isSubmitClicked=true;
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
      centerService.createCenter(newCenter).then((value) =>
          showMessage('New center created for}!', Colors.blue));
    }
  }

  @override
  Widget build(BuildContext context) {
    //final ListOfCenterFoundationData listOfCenterFoundationData = widget.listOfCenterFoundationData;
    //print("Data for printing data here is data adata data : "+ "${widget.listOfCenterFoundationData.centerName}"+" here is " + "${widget.listOfCenterFoundationData.agentUserName}");
    return new Scaffold(
      key: _scaffoldKey,

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
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.business_center,color: Colors.black,),
                      hintText: 'Enter Current Address here',
                      labelText: 'Current Address',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.grey),
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      contentPadding: EdgeInsets.all(20.0),

                    ),
                    initialValue: "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) =>isSubmitClicked? val.isEmpty ? 'Current Address is required' : null:"",
                    onSaved: (val) => newCenter.centerName = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.add_location,color: Colors.black,),
                      hintText: 'Enter District here',
                      labelText: 'District',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.grey),
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      contentPadding: EdgeInsets.all(20.0),

                    ),
                    initialValue: "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) =>isSubmitClicked?  val.isEmpty ? 'District  is required' : null:"",
                    onSaved: (val) => newCenter.branch = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.my_location,color: Colors.black,),
                      hintText: 'Enter Thana here',
                      labelText: 'Thana',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.grey),
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      contentPadding: EdgeInsets.all(20.0),

                    ),
                    initialValue: "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) =>isSubmitClicked? val.isEmpty ? 'Thana is required' : null:"",
                    onSaved: (val) => newCenter.state = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.my_location,color: Colors.black,),
                      hintText: 'Enter Pin here',
                      labelText: 'Pin ',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.grey),
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      contentPadding: EdgeInsets.all(20.0),

                    ),
                    initialValue: "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) =>isSubmitClicked? val.isEmpty ? 'Pin  is required' : null:"",
                    onSaved: (val) => newCenter.districts = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.my_location,color: Colors.black,),
                      hintText: 'Enter Post here',
                      labelText: 'Post',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.grey),
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      contentPadding: EdgeInsets.all(20.0),

                    ),
                    initialValue: "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) =>isSubmitClicked? val.isEmpty ? 'Post is required' : null:"",
                    onSaved: (val) => newCenter.subDistricts = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.my_location,color: Colors.black,),
                      hintText: 'Enter Mobile Number here',
                      labelText: 'Mobile Number',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.grey),
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      contentPadding: EdgeInsets.all(20.0),

                    ),
                    initialValue: "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) =>isSubmitClicked?val.isEmpty ? 'landLine number  is required' : null:"",
                    onSaved: (val) => newCenter.villageName = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.my_location,color: Colors.black,),
                      hintText: 'Enter LandLine Number here',
                      labelText: 'Mobile Number',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.grey),
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      contentPadding: EdgeInsets.all(20.0),

                    ),
                    initialValue: "",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) =>isSubmitClicked?val.isEmpty ? 'landLine number  is required' : null:"",
                    onSaved: (val) => newCenter.villageName = val,
                  ),

                ],
              ))),
    );
  }
}
