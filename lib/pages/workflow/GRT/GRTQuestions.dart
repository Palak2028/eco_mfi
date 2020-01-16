import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/ReadXmlCost.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT1Bean.dart';
import 'package:eco_mfi/pages/workflow/GRT/bean/GRTBean.dart';

import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/initializer.dart' as initializer;
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GRTQuestions extends StatefulWidget {
  @override
  _GRTQuestions createState() => new _GRTQuestions();
}

class _GRTQuestions extends State<GRTQuestions> {

  final formKey = new GlobalKey<FormState>();
  List<bool> questionCheck;


  @override
  void initState() {
    super.initState();
    initializeQuestions();
    //GRTQuestions = initializer.GRTQuestions;
   // questionCheck = new List(GRTQuestions.length);
  }

  Future<Null> initializeQuestions() async {
    questionCheck = new List<bool>(globals.questionGRT.length);
  }

  DateTime endTime;

  @override
  Widget build(BuildContext context) {
    return  new SafeArea(
            child: SingleChildScrollView(
                child: new Column(
          children: getCard(),
        )));
  }

  List<Widget> getCard() {
    List<Widget> listCard = new List<Widget>();
    print(globals.questionCGT1.length);
    for (int i = 0; i < globals.questionGRT.length; i++) {
      print("here");
      listCard.add(new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
              child: CheckboxListTile(
                  value: globals.questionGRT[i].manschecked == null ||
                      globals.questionGRT[i].manschecked == 0
                      ? false
                      : true,
                  title: new Text(
                    globals.questionGRT[i].mquestiondesc,
                    textAlign: TextAlign.left,
                  ),
                  onChanged: (val) {
                    setState(() {

                      globals.questionGRT[i].manschecked = val==false? 0 : 1;
                    });
                  })),
        ],
      ));

    }
    listCard.add(new Form(
      key: formKey,
      onChanged: () {
        final FormState form = formKey.currentState;
        form.save();
      },
      child: new TextFormField(
          keyboardType: TextInputType.text,
          decoration:  InputDecoration(
            hintText: Translations.of(context).text('Enter_Remarks_Here'),
            labelText: Translations.of(context).text('Remarks'),
            hintStyle: TextStyle(color: Colors.grey),
            /*labelStyle: TextStyle(color: Colors.grey),*/
            border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                )),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff5c6bc0),
                )),
            contentPadding: EdgeInsets.all(20.0),
          ),
          /* controller: cgt1bean.mremarks != null
            ? TextEditingController(text: cgt1bean.mremarks)
            : TextEditingController(text: ""),
       */ inputFormatters: [
        new LengthLimitingTextInputFormatter(60),
        globals.onlyAphaNumeric
      ],
          initialValue:
          globals.grtBean.mremarks != null ? globals.grtBean.mremarks : "",
          onSaved: (String value) {
            /*globals.firstName = value;*/
            globals.grtBean.mremarks =
                value;
          }
      ),),);
    return listCard;
  }


}
