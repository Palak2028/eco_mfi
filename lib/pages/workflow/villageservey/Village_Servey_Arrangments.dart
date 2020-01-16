import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:flutter/material.dart';

class VillageServeyArrangments extends StatefulWidget {
  VillageServeyArrangments({Key key}) : super(key: key);

  static Container _get(Widget child,
          [EdgeInsets pad = const EdgeInsets.all(3.0)]) =>
      new Container(
        padding: pad,
        child:
            child, /*decoration: new BoxDecoration(color: Colors.white,border: Border(
    bottom: BorderSide(color: Colors.grey),right: BorderSide(color: Colors.grey),
  )),*/
      );

  @override
  _VillageServeyArrangmentsState createState() =>
      new _VillageServeyArrangmentsState();
}

class _VillageServeyArrangmentsState extends State<VillageServeyArrangments> {
  @override
  void initState() {
    super.initState();
  }

  int radioValue = 0;
  bool switchValue = false;
  bool isSubmitClicked = false;

  int _selectedRadioListTile = 0;

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
    });
  }

  List<String> radValues1 = ["yes", "No"];
  List<String> radValues2 = ["none", "1-3", ">3"];

  //List _selectRadioList = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

  Widget _addRadios() => VillageServeyArrangments._get(new Row(
        children: _makeRadios(2, radValues1, 0),
      ));

  Widget _addRadios1() => VillageServeyArrangments._get(new Row(
        children: _makeRadios(2, radValues1, 1),
      ));

  Widget _addRadios2() => VillageServeyArrangments._get(new Row(
        children: _makeRadios(2, radValues1, 2),
      ));

  Widget _addRadios3() => VillageServeyArrangments._get(new Row(
        children: _makeRadios(2, radValues1, 3),
      ));

  Widget _addRadios4() => VillageServeyArrangments._get(new Row(
        children: _makeRadios(2, radValues1, 4),
      ));

  Widget _addRadios5() => VillageServeyArrangments._get(new Row(
        children: _makeRadios(2, radValues1, 5),
      ));

  Widget _addRadios6() => VillageServeyArrangments._get(new Row(
        children: _makeRadios(2, radValues1, 6),
      ));

  Widget _addRadios7() => VillageServeyArrangments._get(new Row(
        children: _makeRadios(2, radValues1, 7),
      ));

  Widget _addRadios8() => VillageServeyArrangments._get(new Row(
        children: _makeRadios(2, radValues1, 8),
      ));

  Widget _addRadios9() => VillageServeyArrangments._get(new Row(
        children: _makeRadios(2, radValues1, 9),
      ));

  Widget _addRadios10() => VillageServeyArrangments._get(new Row(
        children: _makeRadios(2, radValues1, 10),
      ));

  Widget _addRadios11() => VillageServeyArrangments._get(new Column(
        children: _makeRadios(3, radValues2, 11),
      ));

  Widget _addRadios12() => VillageServeyArrangments._get(new Column(
        children: _makeRadios(3, radValues2, 12),
      ));

  List<Widget> _makeRadios(int numberOfRadios, List textName, int position) {
    List<Widget> radios = new List<Widget>();
    for (int i = 0; i < numberOfRadios; i++) {
      print(i);
      print("I ki postion hai yeh");
      //  print( this._selectRadioList[i]);
      radios.add(new Row(
        children: <Widget>[
          new Text(
            textName[i],
            textAlign: TextAlign.right,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontSize: 12.0,
            ),
          ),
          new Radio(
            value: i,
            groupValue: globals.globalRadiListArrangment[position],
            onChanged: (selection) => _onRadioSelected(selection, position),
            activeColor: Colors.black,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      ));
    }
    return radios;
  }

  _onRadioSelected(int selection, int position) {
    print('Radio button $selection selected');
    setState(() => globals.globalRadiListArrangment[position] = selection);
  }

  //endregion

  Widget getTextContainer(String textValue) {
    return new Container(
      /*decoration: new BoxDecoration(color: Colors.white,border: Border(
        bottom: BorderSide(color: Colors.grey),right: BorderSide(color: Colors.grey),
      )
      ),*/

      padding: EdgeInsets.fromLTRB(5.0, 20.0, 0.0, 20.0),
      child: new Text(
        textValue,
        //textDirection: TextDirection,
        textAlign: TextAlign.start,
        /*overflow: TextOverflow.ellipsis,*/
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontStyle: FontStyle.normal,
            fontSize: 12.0),
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    /*return Scaffold(
      backgroundColor: Colors.white,
    */
    return Card(
      /* elevation: 2.0,
      margin: EdgeInsets.all(6.0),
        shape: Border.all(color: Colors.grey),*/
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          new Card(
            elevation: 5.0,
            color: Colors.white,
            child: Center(
              child: new Table(
                children: [
                  new TableRow(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer('Bus Services'),
                        _addRadios(),
                      ]),
                  new TableRow(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer('Roads Mortable'),
                        _addRadios1(),
                      ]),
                  new TableRow(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer('River Flooding'),
                        _addRadios2(),
                      ]),
                  new TableRow(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer('Alternate travel route'),
                        _addRadios3(),
                      ]),
                  new TableRow(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer('Police station'),
                        _addRadios4(),
                      ]),
                  new TableRow(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer('Primary health center'),
                        _addRadios5(),
                      ]),
                  new TableRow(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer('Hospitals'),
                        _addRadios6(),
                      ]),
                  new TableRow(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer('Internet availability'),
                        _addRadios7(),
                      ]),
                  new TableRow(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer('Petrol pump within 15Km'),
                        _addRadios8(),
                      ]),
                ],
              ),
            ),
          ),
          new Card(
            elevation: 5.0,
            color: Colors.white,
            child: Center(
              child: new Container(
                  padding: EdgeInsets.all(15.0),
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    onPressed: () {},
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          32.0,
                        ),
                        side: BorderSide(color: Colors.grey)),
                    child: Text(
                      "Institution",
                      style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black /*Color(0xFF179CDF)*/),
                    ),
                  )),
            ),
          ),
          new Card(
            elevation: 5.0,
            color: Colors.white,
            child: Center(
              child: new Table(children: [
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer('Post Offices'),
                      _addRadios9(),
                    ]),
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer('Bank Branches'),
                      _addRadios10(),
                    ]),
              ]),
            ),
          ),
          new Card(
            elevation: 5.0,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                new TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(
                      Icons.person_pin_circle,
                      color: Colors.black,
                    ),
                    hintText: 'Enter No Of MFI Operating here',
                    labelText: 'No Of MFI Operating',
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
                      ? val.isEmpty ? 'No Of MFI Operating is required' : null
                      : "",
                  //onSaved: (val) => newCenter.centerName = val,
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(
                      Icons.person_pin_circle,
                      color: Colors.black,
                    ),
                    hintText: 'Enter Negaive area if any here',
                    labelText: 'Negaive area if any',
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
                      ? val.isEmpty ? 'Negaive area if any is required' : null
                      : "",
                  //onSaved: (val) => newCenter.centerName = val,
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(
                      Icons.person_pin_circle,
                      color: Colors.black,
                    ),
                    hintText: 'Enter Reputed MFI here',
                    labelText: 'Reputed MFI',
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
                      ? val.isEmpty ? 'Reputed MFI is required' : null
                      : "",
                  //onSaved: (val) => newCenter.centerName = val,
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(
                      Icons.person_pin_circle,
                      color: Colors.black,
                    ),
                    hintText: 'Enter MFI Active Clients here',
                    labelText: 'MFI Active Clients',
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
                      ? val.isEmpty ? 'MFI Active Clients is required' : null
                      : "",
                  //onSaved: (val) => newCenter.centerName = val,
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(
                      Icons.person_pin_circle,
                      color: Colors.black,
                    ),
                    hintText: 'Enter MFI Overdue Clients here',
                    labelText: 'MFI Overdue Clients',
                    hintStyle: TextStyle(color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.grey),
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 0.5)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                    contentPadding: EdgeInsets.all(20.0),
                  ),

                  inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                  validator: (val) => isSubmitClicked
                      ? val.isEmpty ? 'MFI Overdue Clients is required' : null
                      : "",
                  //onSaved: (val) => newCenter.centerName = val,
                ),
              ],
            ),
          ),
          new Card(
            elevation: 5.0,
            color: Colors.white,
            child: Center(
              child: new Table(children: [
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer('No Of Co-Operative dairy'),
                      _addRadios11(),
                    ]),
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      Center(
                        child: getTextContainer('No of Co-Operative others'),
                        //
                      ),
                      _addRadios12(),
                    ]),
              ]),
            ),
          ),
          new Card(
            child: new Container(
                padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                child: new RaisedButton(
                  child: const Text('Submit'),
                  onPressed: _submitForm,
                )),
          ),
        ],
      ),
    );

    //);
  }

  void _submitForm() {
    print('Form save called, newCenter is now up to date...');
    print('0: ${globals.globalRadiListArrangment[0]}');
    print('1: ${globals.globalRadiListArrangment[1]}');
    print('2: ${globals.globalRadiListArrangment[2]}');
    print('3 ${globals.globalRadiListArrangment[3]}');
    print('4 ${globals.globalRadiListArrangment[4]}');
    print('5: ${globals.globalRadiListArrangment[5]}');
    print('6: ${globals.globalRadiListArrangment[6]}');
    print('7: ${globals.globalRadiListArrangment[7]}');
    print('8 ${globals.globalRadiListArrangment[8]}');
    print('9: ${globals.globalRadiListArrangment[9]}');
    print('10: ${globals.globalRadiListArrangment[10]}');
    print('11: ${globals.globalRadiListArrangment[11]}');
    print('12 ${globals.globalRadiListArrangment[12]}');
    print('========================================');
    print('Submitting to back end...');
  }
}
