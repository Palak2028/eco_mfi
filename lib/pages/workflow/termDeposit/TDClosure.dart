import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/TDClosureDetail.dart';

class TDClosure extends StatefulWidget {
  _TDClosure createState() => _TDClosure();
}

class _TDClosure extends State<TDClosure> {

  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Term Deposit Closure",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
      ),
      body: Card(
        elevation: 4.0,
        // color: Constant.mandatoryColor,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            new Text("Account Number"),

        Padding(
          padding: const EdgeInsets.only(left: 0.0,top: 20.0,bottom: 20.0,right: 0.0),
          child:   new TextField(
            controller: myController,
            textAlign: TextAlign.center,


            decoration: new InputDecoration(

              hintText: 'Please Enter your account Number',
              //errorText: _validate ? 'Value Can\'t Be Empty' : null,
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(5.0),
                  ),
                borderSide: new BorderSide(
                  color: Colors.black,
                  width: 1.0,
                  ),
                ),
              ),
            ),
          ),


            OutlineButton(
                borderSide: BorderSide(color: Colors.indigo),

                child: Text("Confirm"),
                textColor: Colors.indigo,
                onPressed: () {

                  if (!validateSubmit()) {

                  } else {
                    proceed();
                  }
                },
                shape: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                )
                ),
          ],
        ),
      ),
    );
  }

  proceed() {

    Navigator.push(
      context,
      new MaterialPageRoute(

        builder: (context) => new TDClosureDetail(),
        ), //When Authorized Navigate to the next screen
      );
  }

  bool validateSubmit() {
    if (myController.text.toString().isEmpty){
      _showAlert("Please enter Account Number", "It is Mandatory");
      return false;
    }
    return true;
  }

  Future<void> _showAlert(arg, error) async {
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
              child: Text('ok'),
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
