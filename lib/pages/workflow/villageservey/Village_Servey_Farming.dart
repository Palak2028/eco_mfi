import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class VillageServeyFarming extends StatefulWidget {
  VillageServeyFarming({Key key}) : super(key: key);

  static Container _get(Widget child,
          [EdgeInsets pad = const EdgeInsets.all(3.0)]) =>
      new Container(
        padding: pad,
        child: child,
        decoration: new BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey),
              right: BorderSide(color: Colors.grey),
            )),
      );

  @override
  _VillageServeyFarmingState createState() => new _VillageServeyFarmingState();
}

class _VillageServeyFarmingState extends State<VillageServeyFarming> {
  @override
  void initState() {
    super.initState();
  }

  int radioValue = 0;
  bool switchValue = false;
  bool isSubmitClicked = false;
  int _selectedRadio = 0;
  int _selectedRadioListTile = 0;
  bool _isChecked = false;

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
    });
  }

  List<String> val = ["Rains", "Canals", "Others"];

  Widget _addRadios() => VillageServeyFarming._get(new Row(
        children: _makeRadios(3, val),
      ));

  List<Widget> _makeRadios(int numberOfRadios, List textName) {
    List<Widget> radios = new List<Widget>();
    for (int i = 0; i < numberOfRadios; i++) {
      radios.add(new Row(
        children: <Widget>[
          new Text(
            textName[i],
            textAlign: TextAlign.right,
            textDirection: TextDirection.ltr,
            /*overflow: TextOverflow.ellipsis,*/
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontSize: 9.0,
            ),
          ),
          new Radio(
            value: i,
            groupValue: _selectedRadio,
            onChanged: (selection) => _onRadioSelected(selection),
            activeColor: Colors.black,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      ));
    }
    return radios;
  }

  _onRadioSelected(int selection) {
    print('Radio button $selection selected');
    setState(() => _selectedRadio = selection);
  }

  //endregion

  Widget getTextContainer(String textValue) {
    return new Container(
      decoration: new BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey),
            right: BorderSide(color: Colors.grey),
          )),
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.person_pin_circle,
                  color: Colors.black,
                ),
                hintText: 'Enter Total Land under clutivation here',
                labelText: 'Total Land under clutivation',
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
                  ? val.isEmpty
                      ? 'Total Land under clutivation is required'
                      : null
                  : "",
              //onSaved: (val) => newCenter.centerName = val,
            ),
            new TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.person_pin_circle,
                  color: Colors.black,
                ),
                hintText: 'Enter Irrigated Land here',
                labelText: 'Irrigated Land',
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
                  ? val.isEmpty ? 'Irrigated Land is required' : null
                  : "",
              //onSaved: (val) => newCenter.centerName = val,
            ),
            Center(
              child: new Table(children: [
                new TableRow(
                    decoration: new BoxDecoration(color: Colors.white),
                    children: [
                      getTextContainer('Major sources of irrigation'),
                      _addRadios(),
                    ]),
                new TableRow(
                    decoration: new BoxDecoration(color: Colors.white),
                    children: [
                      new Text(
                        "Are you a post paid customer",
                        style: new TextStyle(
                          color: Colors.blue,
                          fontSize: 25.0,
                        ),
                      ),
                      new Checkbox(
                          activeColor: Colors.blue,
                          value: _isChecked,
                          onChanged: (val) {
                            setState(() {
                              _isChecked = !_isChecked;
                            });
                          }),
                    ]),
                new TableRow(
                    decoration: new BoxDecoration(color: Colors.white),
                    children: [
                      getTextContainer('Village Type'),
                      _addRadios(),
                    ]),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
