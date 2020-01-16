import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:flutter/material.dart';

class VillageServeyMicroEnterprises extends StatefulWidget {
  VillageServeyMicroEnterprises({Key key}) : super(key: key);

  static Container _get(Widget child,
          [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
        /* decoration: new BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey),
              right: BorderSide(color: Colors.grey),
            )),*/
      );

  @override
  _VillageServeyMicroEnterprisesState createState() =>
      new _VillageServeyMicroEnterprisesState();
}

class _VillageServeyMicroEnterprisesState
    extends State<VillageServeyMicroEnterprises> {
  @override
  void initState() {
    super.initState();
  }

  int radioValue = 0;
  bool switchValue = false;
  bool isSubmitClicked = false;

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
    });
  }

  List<String> radValues1 = ["none", "1-3", ">3"];

  Widget _addRadios() => VillageServeyMicroEnterprises._get(new Column(
        children: _makeRadios(3, radValues1, 0),
      ));

  Widget _addRadios1() => VillageServeyMicroEnterprises._get(new Column(
        children: _makeRadios(3, radValues1, 1),
      ));

  Widget _addRadios2() => VillageServeyMicroEnterprises._get(new Column(
        children: _makeRadios(3, radValues1, 2),
      ));

  Widget _addRadios3() => VillageServeyMicroEnterprises._get(new Column(
        children: _makeRadios(3, radValues1, 3),
      ));

  Widget _addRadios4() => VillageServeyMicroEnterprises._get(new Column(
        children: _makeRadios(3, radValues1, 4),
      ));

  Widget _addRadios5() => VillageServeyMicroEnterprises._get(new Column(
        children: _makeRadios(3, radValues1, 5),
      ));

  Widget _addRadios6() => VillageServeyMicroEnterprises._get(new Column(
        children: _makeRadios(3, radValues1, 6),
      ));

  Widget _addRadios7() => VillageServeyMicroEnterprises._get(new Column(
        children: _makeRadios(3, radValues1, 7),
      ));

  Widget _addRadios8() => VillageServeyMicroEnterprises._get(new Column(
        children: _makeRadios(3, radValues1, 8),
      ));

  Widget _addRadios9() => VillageServeyMicroEnterprises._get(new Column(
        children: _makeRadios(3, radValues1, 9),
      ));

  Widget _addRadios10() => VillageServeyMicroEnterprises._get(new Column(
        children: _makeRadios(3, radValues1, 10),
      ));

  Widget _addRadios11() => VillageServeyMicroEnterprises._get(new Column(
        children: _makeRadios(3, radValues1, 11),
      ));

  Widget _addRadios12() => VillageServeyMicroEnterprises._get(new Column(
        children: _makeRadios(3, radValues1, 12),
      ));

  List<Widget> _makeRadios(int numberOfRadios, List textName, int position) {
    List<Widget> radios = new List<Widget>();
    for (int i = 0; i < numberOfRadios; i++) {
      radios.add(new Row(
        children: <Widget>[
          new Text(
            textName[i],
            textAlign: TextAlign.end,
            textDirection: TextDirection.ltr,
            /*overflow: TextOverflow.ellipsis,*/
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontSize: 12.0,
            ),
          ),
          new Radio(
            value: i,
            groupValue: globals.globalRadiListMicroEnterprises[position],
            onChanged: (selection) => _onRadioSelected(selection, position),
            activeColor: Colors.black,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ));
    }
    return radios;
  }

  _onRadioSelected(int selection, int position) {
    print('Radio button $selection selected');
    setState(
        () => globals.globalRadiListMicroEnterprises[position] = selection);
  }

  //endregionndregion

  Widget getTextContainer(String textValue) {
    return new Container(
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
/*    return Scaffold(
      backgroundColor: Colors.white,*/
    return new Card(
      color: Colors.white,
      /*elevation: 2.0,*/
      margin: EdgeInsets.all(6.0),
      /* shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
            side: BorderSide(color: Colors.grey),
        ),*/
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          new Card(
            elevation: 5.0,
            child: Center(
              child: new Table(
                children: [
                  new TableRow(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer('Grocery Shops'),
                        _addRadios(),
                      ]),
                  new TableRow(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer('Tea Hotel'),
                        _addRadios2(),
                      ]),
                  new TableRow(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer('Tailoring Shops'),
                        _addRadios3(),
                      ]),
                  new TableRow(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer('Electrical Repair shops'),
                        _addRadios4(),
                      ]),
                  new TableRow(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer('Agri input shops'),
                        _addRadios5(),
                      ]),
                  new TableRow(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer('Imitating Jwellery shops'),
                        _addRadios6(),
                      ]),
                  new TableRow(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer('Laundary'),
                        _addRadios7(),
                      ]),
                  new TableRow(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer('Flour Mill'),
                        _addRadios8(),
                      ]),
                  new TableRow(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer('HandLoom Weaver'),
                        _addRadios9(),
                      ]),
                ],
              ),
            ),
          ),
          new Card(
            elevation: 5.0,
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
                      "Other Significance MicroEnterprises",
                      style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black /*Color(0xFF179CDF)*/),
                    ),
                  )),
            ),
          ),
          new Card(
            elevation: 5.0,
            child: Center(
              child: new Table(children: [
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer('Potters'),
                      _addRadios10(),
                    ]),
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer('Bamboo workers'),
                      _addRadios11(),
                    ]),
                new TableRow(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer('Papad Making'),
                      _addRadios12(),
                    ]),
              ]),
            ),
          ),
          new Card(
            elevation: 5.0,
            child: new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.person_pin_circle,
                  color: Colors.black,
                ),
                hintText: 'Enter Others  activities here',
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
          ),
          /* new Card(

            child: new Container(
                padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                child: new RaisedButton(
                  child: const Text('Submit'),
                  onPressed: _submitForm,
                )),

          ),*/
        ],
      ),
      // ),
    );
  }

  void _submitForm() {
    print('Form save called, newCenter is now up to date...');
    print('0: ${globals.globalRadiListMicroEnterprises[0]}');
    print('1: ${globals.globalRadiListMicroEnterprises[1]}');
    print('2: ${globals.globalRadiListMicroEnterprises[2]}');
    print('3 ${globals.globalRadiListMicroEnterprises[3]}');
    print('4 ${globals.globalRadiListMicroEnterprises[4]}');
    print('5: ${globals.globalRadiListMicroEnterprises[5]}');
    print('6: ${globals.globalRadiListMicroEnterprises[6]}');
    print('7: ${globals.globalRadiListMicroEnterprises[7]}');
    print('8 ${globals.globalRadiListMicroEnterprises[8]}');
    print('9: ${globals.globalRadiListMicroEnterprises[9]}');
    print('10: ${globals.globalRadiListMicroEnterprises[10]}');
    print('11: ${globals.globalRadiListMicroEnterprises[11]}');
    print('12 ${globals.globalRadiListMicroEnterprises[12]}');
    print('========================================');
    print('Submitting to back end...');
  }
}
