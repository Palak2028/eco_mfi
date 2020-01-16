import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:flutter/material.dart';

class VillageServeyBasics extends StatefulWidget {
  VillageServeyBasics({Key key}) : super(key: key);

  @override
  _VillageServeyBasicsState createState() => new _VillageServeyBasicsState();
}

class _VillageServeyBasicsState extends State<VillageServeyBasics> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool isSubmitClicked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*  return new Scaffold(
      key: _scaffoldKey,
      */ /*appBar: new AppBar(
        elevation: 1.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title:    new Text(
          'Village servey Basic entries',
          //textDirection: TextDirection,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontStyle: FontStyle.normal),

        ),
      ),*/ /*
      body: new SafeArea(
          top: false,
          bottom: false,*/

    return new Card(
        margin: EdgeInsets.all(6.0),
        elevation: 2.0,
        color: Colors.white,
        key: _formKey,
        //autovalidate: true,
        child: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: <Widget>[
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.person_pin_circle,
                  color: Colors.black,
                ),
                hintText: 'Enter Pincode here',
                labelText: 'Pincode',
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

              inputFormatters: [new LengthLimitingTextInputFormatter(30)],
              validator: (val) => isSubmitClicked
                  ? val.isEmpty ? 'Pincode is required' : null
                  : "",
              //onSaved: (val) => newCenter.centerName = val,
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.near_me,
                  color: Colors.black,
                ),
                hintText: 'Enter nearest active village here',
                labelText: 'Nearest active village',
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
              // initialValue: widget.listOfCenterFoundationData!=null && widget.listOfCenterFoundationData.branch!=null?widget.listOfCenterFoundationData.branch.trim():"",
              inputFormatters: [new LengthLimitingTextInputFormatter(30)],
              validator: (val) => isSubmitClicked
                  ? val.isEmpty ? 'Nearest active village  is required' : null
                  : "",
              // onSaved: (val) => newCenter.branch = val,
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                hintText: 'Enter Distance Frome Main Road here',
                labelText: 'Distance Frome Main Road ',
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
              // initialValue: widget.listOfCenterFoundationData!=null && widget.listOfCenterFoundationData.state!=null?widget.listOfCenterFoundationData.state.trim():"",
              inputFormatters: [new LengthLimitingTextInputFormatter(30)],
              validator: (val) => isSubmitClicked
                  ? val.isEmpty ? 'Distance Frome Main Road  is required' : null
                  : "",
              // onSaved: (val) => newCenter.state = val,
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.show_chart,
                  color: Colors.black,
                ),
                hintText: 'Enter Demographics here',
                labelText: 'Demographics ',
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
              //initialValue: widget.listOfCenterFoundationData!=null && widget.listOfCenterFoundationData.districts!=null?widget.listOfCenterFoundationData.districts.trim():"",
              inputFormatters: [new LengthLimitingTextInputFormatter(30)],
              validator: (val) => isSubmitClicked
                  ? val.isEmpty ? 'Demographics  is required' : null
                  : "",
              //  onSaved: (val) => newCenter.districts = val,
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                hintText: 'Enter No of households here',
                labelText: 'No of households',
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
              //initialValue: widget.listOfCenterFoundationData!=null && widget.listOfCenterFoundationData.subDistricts!=null?widget.listOfCenterFoundationData.subDistricts.trim():"",
              inputFormatters: [new LengthLimitingTextInputFormatter(30)],
              validator: (val) => isSubmitClicked
                  ? val.isEmpty ? 'No of households  is required' : null
                  : "",
              //onSaved: (val) => newCenter.subDistricts = val,
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.low_priority,
                  color: Colors.black,
                ),
                hintText: 'Enter Sc here',
                labelText: 'SC',
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
              // initialValue: widget.listOfCenterFoundationData!=null && widget.listOfCenterFoundationData.villageName!=null?widget.listOfCenterFoundationData.villageName.trim():"",
              inputFormatters: [new LengthLimitingTextInputFormatter(30)],
              validator: (val) =>
                  isSubmitClicked ? val.isEmpty ? 'SC is required' : null : "",
              // onSaved: (val) => newCenter.villageName = val,
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.low_priority,
                  color: Colors.black,
                ),
                hintText: 'Enter ST here',
                labelText: 'ST',
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
              // initialValue: widget.listOfCenterFoundationData!=null?widget.listOfCenterFoundationData.villagePopulation.toString():"",
              keyboardType: TextInputType.number,
              inputFormatters: [
                new LengthLimitingTextInputFormatter(30),
              ],
              validator: (val) =>
                  isSubmitClicked ? val.isEmpty ? 'ST is required' : null : "",
              // onSaved: (val) => newCenter.villagePopulation = int.tryParse(val) ,
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.low_priority,
                  color: Colors.black,
                ),
                hintText: 'Enter OBC here',
                labelText: 'OBC',
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
              //initialValue: widget.listOfCenterFoundationData!=null ?widget.listOfCenterFoundationData.distanceFromBranch.toString():"",
              keyboardType: TextInputType.number,
              inputFormatters: [
                new LengthLimitingTextInputFormatter(30),
              ],
              validator: (val) =>
                  isSubmitClicked ? val.isEmpty ? 'OBC is required' : null : "",
              // onSaved: (val) => newCenter.distanceFromBranch = int.tryParse(val) ,
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                hintText: 'Enter Other Minorities here',
                labelText: 'Other Minorities',
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
              // initialValue: widget.listOfCenterFoundationData!=null && widget.listOfCenterFoundationData.assignedTo!=null?widget.listOfCenterFoundationData.assignedTo.trim():"",
              inputFormatters: [new LengthLimitingTextInputFormatter(30)],
              validator: (val) => isSubmitClicked
                  ? val.isEmpty ? 'Other Minorities required' : null
                  : "",
              // onSaved: (val) => newCenter.assignedTo = val,
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.format_strikethrough,
                  color: Colors.black,
                ),
                hintText: 'Enter OHRC here',
                labelText: 'OHRC',
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

              inputFormatters: [new LengthLimitingTextInputFormatter(30)],
              validator: (val) => isSubmitClicked
                  ? val.isEmpty ? 'OHRC is required' : null
                  : "",
              // onSaved: (val) => newCenter.serVeyType = val,
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.strikethrough_s,
                  color: Colors.black,
                ),
                hintText: 'Enter HRD here',
                labelText: 'HRD',
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

              inputFormatters: [new LengthLimitingTextInputFormatter(30)],
              validator: (val) =>
                  isSubmitClicked ? val.isEmpty ? 'HRD is required' : null : "",
              // onSaved: (val) => newCenter.serVeyType = val,
            ),
            gestureDetector('proceed'),
            /*new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Submit'),
                        onPressed: _submitForm,
                      )),*/
          ],
        )); //),
    // );
  }

  GestureDetector gestureDetector(name) {
    return new GestureDetector(
      child: new Card(
          elevation: 2.0,
          color: Colors.white,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Center(
                child: new Text(
                  name,
                  style: new TextStyle(color: Colors.black),
                ),
                heightFactor: 6.00,
              )
            ],
          )),
      onTap: () {},
    );
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;
    isSubmitClicked = true;
  }
}
