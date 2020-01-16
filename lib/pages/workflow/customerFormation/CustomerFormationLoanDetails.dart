import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/ViewBorrowingDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/BorrowingDetailsBean.dart';

import '../../../translations.dart';

class CustomerFormationLoanDetails extends StatefulWidget {
  CustomerFormationLoanDetails({Key key}) : super(key: key);

  static Container _get(Widget child,
          [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );

  @override
  _CustomerFormationLoanDetails createState() =>
      new _CustomerFormationLoanDetails();
}

class _CustomerFormationLoanDetails
    extends State<CustomerFormationLoanDetails> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();


  String tempLoanDay;
  String tempLoanMonth;
  String tempLoanYear;
  String tempRepaymentDay;
  String tempRepaymentMonth;
  String tempRepaymentYear;
  FocusNode loanMonthFocus;
  FocusNode loanYearFocus;
  FocusNode repaymentMonthFocus;
  FocusNode repaymentYearFocus;
  var formatter = new DateFormat('dd-MM-yyyy');


  //BorrowingDetailsBean borrowingDetailsBean = new BorrowingDetailsBean();

  bool chkLoanFromOtherBank =true;
  final dateFormat = DateFormat("yyyy, MM, dd");
  Widget otherLoan() => CustomerFormationLoanDetails._get(new Row(
        children: _makeRadios(2, globals.radioCaptionValues, 0),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));

  @override
  void initState() {


    loanMonthFocus= new FocusNode();
    loanYearFocus= new FocusNode();
    repaymentMonthFocus = new FocusNode();
    repaymentYearFocus = new FocusNode();
    print(CustomerFormationMasterTabsState.loanDate);
    if(!CustomerFormationMasterTabsState.loanDate.contains("_")){
      try{
        print("inside try");

        String tempLoanDate = CustomerFormationMasterTabsState.loanDate;
        print(tempLoanDate.substring(6)+"-"+tempLoanDate.substring(3,5)+"-"+tempLoanDate.substring(0,2));
       DateTime  formattedDate =  DateTime.parse(tempLoanDate.substring(6)+"-"+tempLoanDate.substring(3,5)+"-"+tempLoanDate.substring(0,2));
        print(formattedDate);

       tempLoanDay = formattedDate.day.toString();
       if(tempLoanDay.length ==1)tempLoanDay = "0"+tempLoanDay;
       print(tempLoanDay);
       tempLoanMonth = formattedDate.month.toString();
        if(tempLoanMonth.length ==1)tempLoanMonth= "0"+tempLoanMonth;
        print(tempLoanMonth);
       tempLoanYear = formattedDate.year.toString();
        if(tempLoanMonth.length ==1)tempLoanMonth= "0"+tempLoanMonth;
        print(tempLoanMonth);
        setState(() {

        });

      }catch(e){

        print("Exception Occupred");
      }
    }

    if(!CustomerFormationMasterTabsState.repaymentDate.contains("_")){
      try{
        print("inside try");

        String tempRepaymentDate = CustomerFormationMasterTabsState.repaymentDate;
        print(tempRepaymentDate.substring(6)+"-"+tempRepaymentDate.substring(3,5)+"-"+tempRepaymentDate.substring(0,2));
        DateTime  formattedDate =  DateTime.parse(tempRepaymentDate.substring(6)+"-"+tempRepaymentDate.substring(3,5)+"-"+tempRepaymentDate.substring(0,2));
        print(formattedDate);
        tempRepaymentDay = formattedDate.day.toString();
        if(tempRepaymentDay.length==1)tempRepaymentDay="0"+tempRepaymentDay;
        print(tempRepaymentDay);
            tempRepaymentMonth = formattedDate.month.toString();
        if(tempRepaymentMonth.length==1)tempRepaymentMonth="0"+tempRepaymentMonth;
        print(tempLoanMonth);
        tempRepaymentYear = formattedDate.year.toString();
        if(tempRepaymentYear.length==1)tempRepaymentYear="0"+tempRepaymentYear;
        print(tempRepaymentYear);
        setState(() {

        });

    }catch(e){

        print("Exception Occupred");
      }
    }


  }

  List<Widget> _makeRadios(int numberOfRadios, List textName, int position) {
    List<Widget> radios = new List<Widget>();
    for (int i = 0; i < numberOfRadios; i++) {
      radios.add(new Row(
        children: <Widget>[
          new Text(
            textName[i],
            textAlign: TextAlign.right,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontStyle: FontStyle.normal,
              fontSize: 10.0,
            ),
          ),
          new Radio(
            value: i,
            groupValue: globals.borrowingDetails[position],
            onChanged: (selection) {
              if(selection ==0) chkLoanFromOtherBank = true;
              else chkLoanFromOtherBank = false;
              return _onRadioSelected(selection, position);
            } ,
            activeColor:  Color(0xff07426A),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      ));
    }
    return radios;
  }

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
            color: Colors.grey,
            fontStyle: FontStyle.normal,
            fontSize: 12.0),
      ),
    );
  }

  _onRadioSelected(int selection, int position) {
    setState(() => globals.borrowingDetails[position] = selection);
    if (position == 0) {
      globals.loanDetailsloanFromOthers = globals.radioCaptionValues[selection];
      print("Selcetion of construction here " +
          globals.loanDetailsloanFromOthers);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _formKey,
      onWillPop: () {
        return Future(() => true);
      },
      onChanged: () {
        final FormState form = _formKey.currentState;
        form.save();
      },
      autovalidate: true,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        children: <Widget>[
          SizedBox(height: 16.0),/*
          Center(
              child: new Table(children: [
                new TableRow(
                    decoration: new BoxDecoration(

                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer(globals.radioCaptionBorrowingDetails[0]),
                      otherLoan(),
                    ]),
              ]),
            ),*/

          new Container(

            child: new Column(
              children: <Widget>[

                Container(color:Constant.semiMandatoryColor,child:

                new TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(

                      hintText: Translations.of(context).text('Enter_Bank_Name'),
                      labelText: Translations.of(context).text('Name_of_Bank'),
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
                    //enabled:  chkLoanFromOtherBank,
                    controller: CustomerFormationMasterTabsState.borrowingDetailsBean.mnameofborrower != null
                        ? TextEditingController(
                        text: CustomerFormationMasterTabsState.borrowingDetailsBean.mnameofborrower.toString())
                        : TextEditingController(text: ""),
                    inputFormatters: [new LengthLimitingTextInputFormatter(50),globals.onlyCharacter],
                    onSaved: (val) {
                      CustomerFormationMasterTabsState.borrowingDetailsBean.mnameofborrower = val;
                    }),
                ),

            Container(color:Constant.semiMandatoryColor,child:
              new TextFormField(
                      keyboardType: TextInputType.number,
                      decoration:  InputDecoration(

                        hintText: Translations.of(context).text('Enter_Loan_Amt'),
                        labelText: Translations.of(context).text('Loan_Amt'),
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
                  //enabled:  chkLoanFromOtherBank,
                  inputFormatters: [new LengthLimitingTextInputFormatter(20),globals.onlyDoubleNumber],
                  controller: CustomerFormationMasterTabsState.borrowingDetailsBean.mamount != null
                          ? TextEditingController(
                              text: CustomerFormationMasterTabsState.borrowingDetailsBean.mamount.toString())
                          : TextEditingController(text: ""),
                      onSaved: (val) {
                        if(val!=""&&val!=null)
                          CustomerFormationMasterTabsState.borrowingDetailsBean.mamount = double.parse(val);
                      }),),


                Container(
                  decoration: BoxDecoration(color: Constant.mandatoryColor),
                  child: new Row(

                    children: <Widget>[Text(Constant.loanDate)],
                  ),
                ),

                new Container(
                  decoration: BoxDecoration(color: Constant.mandatoryColor,),



                  child: new Row(
                    children: <Widget>[
                      new Container(
                        width: 50.0,
                        child: new TextField(
                          decoration:
                          InputDecoration(
                              hintText: Translations.of(context).text('DD')
                          ),
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(2),
                            globals.onlyIntNumber
                          ],
                          controller: tempLoanDay == null?null:new TextEditingController(text: tempLoanDay),
                          keyboardType: TextInputType.numberWithOptions(),

                          onChanged: (val){

                            if(val!="0"){
                              tempLoanDay = val;


                              if(int.parse(val)<=31&&int.parse(val)>0){



                                if(val.length==2){
                                  CustomerFormationMasterTabsState.loanDate = CustomerFormationMasterTabsState.loanDate.replaceRange(0, 2, val);
                                  FocusScope.of(context).requestFocus(loanMonthFocus);
                                }
                                else{
                                  CustomerFormationMasterTabsState.loanDate = CustomerFormationMasterTabsState.loanDate.replaceRange(0, 2, "0"+val);
                                }


                              }
                              else {
                                setState(() {
                                  tempLoanDay ="";
                                });

                              }
                            }



                          },
                        ),

                      )
                      ,


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text("/"),
                      ),
                      new Container(
                        width: 50.0,
                        child: new TextField(
                          decoration: InputDecoration(
                            hintText: Translations.of(context).text('MM'),


                          ),

                          keyboardType: TextInputType.numberWithOptions(),
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(2),
                            globals.onlyIntNumber
                          ],
                          focusNode: loanMonthFocus,
                          controller: tempLoanMonth== null?null:new TextEditingController(text: tempLoanMonth),
                          onChanged: (val){

                            if(val!="0"){
                              tempLoanMonth = val;
                              if(int.parse(val)<=12&&int.parse(val)>0){

                                if(val.length==2){
                                  CustomerFormationMasterTabsState.loanDate = CustomerFormationMasterTabsState.loanDate.replaceRange(3, 5, val);

                                  FocusScope.of(context).requestFocus(loanYearFocus);

                                }
                                else{
                                  CustomerFormationMasterTabsState.loanDate = CustomerFormationMasterTabsState.loanDate.replaceRange(3, 5, "0"+val);
                                }
                              }
                              else {
                                setState(() {
                                  tempLoanMonth ="";
                                });

                              }
                            }


                          },

                        ),
                      )
                      ,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text("/"),
                      ),

                      Container(
                        width:80,

                        child:new TextField(


                          decoration: InputDecoration(
                            hintText: Translations.of(context).text('YYYY'),

                          ),

                          keyboardType: TextInputType.numberWithOptions(),
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(4),
                            globals.onlyIntNumber
                          ],


                          focusNode: loanYearFocus,
                          controller: tempLoanYear== null?null:new TextEditingController(text: tempLoanYear),
                          onChanged: (val){
                            tempLoanYear = val;
                            if(val.length==4){
                              CustomerFormationMasterTabsState.loanDate = CustomerFormationMasterTabsState.loanDate.replaceRange(6, 10,val);
                              print(CustomerFormationMasterTabsState.loanDate);
                            }

                          },
                        ),)
                      ,

                      SizedBox(
                        width: 50.0,
                      ),
                      IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                        _selectLoanDate(context);
                      } )
                    ],



                  ),

                ),



                /*new Container(color:Constant.semiMandatoryColor , child:  DateTimePickerFormField(
                  format: dateFormat,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        )),
                    hintText: 'Enter Loan Date',
                    labelText: 'Loan Date',
                    hintStyle: TextStyle(color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.grey),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        )),

                    contentPadding: EdgeInsets.all(20.0),
                  ),
                  dateOnly: true,

                  //enabled:  chkLoanFromOtherBank,
                    editable: false,
                  controller: borrowingDetailsBean.loanDate != null&&borrowingDetailsBean.loanDate != ""
                      ? TextEditingController(
                      text: borrowingDetailsBean.loanDate.toString())
                      : TextEditingController(text: ""),
                  onChanged: (dt) => setState(() {
                    if(dt!=null){
                      borrowingDetailsBean.loanDate = dt;
                    }

                  }),
                ),),*/
            
            /*
            Container(color:Constant.semiMandatoryColor,child:

              new TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(

                        hintText: 'Enter Loan Date',
                        labelText: 'Loan Date',
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
                  //enabled:  chkLoanFromOtherBank,
                      controller: borrowingDetailsBean.loanDate != null
                          ? TextEditingController(
                              text: borrowingDetailsBean.loanDate.toString())
                          : TextEditingController(text: ""),
                      onSaved: (val) {
                        borrowingDetailsBean.loanDate = val;
                      }),),*/

            Container(/*color:Constant.semiMandatoryColor,*/child:
              new TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(

                        hintText: Translations.of(context).text('Enter_Outstanding_Amt'),
                        labelText: Translations.of(context).text('Outstanding_Amt'),
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
                  //enabled:  chkLoanFromOtherBank,
                      controller: CustomerFormationMasterTabsState.borrowingDetailsBean.moutstandingamt != null
                          ? TextEditingController(
                              text: CustomerFormationMasterTabsState.borrowingDetailsBean.moutstandingamt
                                  .toString())
                          : TextEditingController(text: ""),
                  inputFormatters: [new LengthLimitingTextInputFormatter(30),globals.onlyDoubleNumber],
                      onSaved: (val) {

                        if(val!=null&&val!=""){
                          try{
                            CustomerFormationMasterTabsState.borrowingDetailsBean.moutstandingamt = double.parse(val);
                          }catch(e){
                        }

                      }}),),
              new TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(

                        hintText: Translations.of(context).text('Enter_Current_Loan_Amt'),
                        labelText: Translations.of(context).text('Current_Loan_Amt'),
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
                  //enabled:  chkLoanFromOtherBank,
                      controller:CustomerFormationMasterTabsState.borrowingDetailsBean.mloanwthUs != null
                          ? TextEditingController(
                              text: CustomerFormationMasterTabsState.borrowingDetailsBean.mloanwthUs
                                  .toString())
                          : TextEditingController(text: ""),
                  inputFormatters: [new LengthLimitingTextInputFormatter(30),globals.onlyDoubleNumber],
                      onSaved: (val) {
                        CustomerFormationMasterTabsState.borrowingDetailsBean.mloanwthUs = val;
                      }),


                SizedBox(height: 20.0,),



                 /*new Container(child:  DateTimePickerFormField(
                   format: dateFormat,
                   decoration: const InputDecoration(
                     focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(
                           color: Colors.blue,
                         )),
                     hintText: 'Enter Repayment Date',
                     labelText: 'Repayment Date',
                     hintStyle: TextStyle(color: Colors.grey),
                     labelStyle: TextStyle(color: Colors.grey),
                     border: UnderlineInputBorder(
                         borderSide: BorderSide(
                           color: Colors.black,
                         )),

                     contentPadding: EdgeInsets.all(20.0),
                   ),
                   editable: false,

                   dateOnly: true,
                   //enabled:  chkLoanFromOtherBank,
                   controller: borrowingDetailsBean.repayMentDate != null
                       ? TextEditingController(
                       text:
                       borrowingDetailsBean.repayMentDate)
                       : TextEditingController(text: ""),
                   onChanged: (dt) => setState(() {
                     if(dt!=null){
                       borrowingDetailsBean.repayMentDate = dt.toIso8601String();
                     }

                   }),
                 ),),*/

             /*new TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(

                        hintText: 'Enter Repayment Date',
                        labelText: 'Repayment Date',
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
                 //enabled:  chkLoanFromOtherBank,
                      controller: borrowingDetailsBean.repayMentDate != null
                          ? TextEditingController(
                              text:
                                  borrowingDetailsBean.repayMentDate.toString())
                          : TextEditingController(text: ""),
                      onSaved: (val) {
                        borrowingDetailsBean.repayMentDate = val;
                      }),*/

                Container(
                  child: new Row(

                    children: <Widget>[Text(Constant.repaymentDate)],
                  ),
                ),

                new Container(
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        width: 50.0,
                        child: new TextField(
                          decoration:
                          InputDecoration(
                              hintText: Translations.of(context).text('DD')
                          ),
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(2),
                            globals.onlyIntNumber
                          ],
                          controller: tempRepaymentDay == null?null:new TextEditingController(text: tempRepaymentDay),
                          keyboardType: TextInputType.numberWithOptions(),

                          onChanged: (val){

                            if(val!="0"){
                              tempRepaymentDay = val;


                              if(int.parse(val)<=31&&int.parse(val)>0){



                                if(val.length==2){
                                  CustomerFormationMasterTabsState.repaymentDate = CustomerFormationMasterTabsState.repaymentDate.replaceRange(0, 2, val);
                                  FocusScope.of(context).requestFocus(repaymentMonthFocus);
                                }
                                else{
                                  CustomerFormationMasterTabsState.repaymentDate = CustomerFormationMasterTabsState.repaymentDate.replaceRange(0, 2, "0"+val);
                                }


                              }
                              else {
                                setState(() {
                                  tempRepaymentDay ="";
                                });

                              }
                            }




                          },
                        ),

                      )
                      ,


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text("/"),
                      ),
                      new Container(
                        width: 50.0,
                        child: new TextField(
                          decoration: InputDecoration(
                            hintText: Translations.of(context).text('MM'),


                          ),

                          keyboardType: TextInputType.numberWithOptions(),
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(2),
                            globals.onlyIntNumber
                          ],
                          focusNode: repaymentMonthFocus,
                          controller: tempRepaymentMonth== null?null:new TextEditingController(text: tempRepaymentMonth),
                          onChanged: (val){
                            if(val!="0"){
                              tempRepaymentMonth = val;
                              if(int.parse(val)<=12&&int.parse(val)>0){

                                if(val.length==2){
                                  CustomerFormationMasterTabsState.repaymentDate = CustomerFormationMasterTabsState.repaymentDate.replaceRange(3, 5, val);
                                  print("repaymrnt Date is "+CustomerFormationMasterTabsState.repaymentDate);
                                  FocusScope.of(context).requestFocus(repaymentYearFocus);
                                }
                                else{
                                  CustomerFormationMasterTabsState.repaymentDate = CustomerFormationMasterTabsState.repaymentDate.replaceRange(3, 5, "0"+val);
                                  print("repaymrnt Date is "+CustomerFormationMasterTabsState.repaymentDate);
                                }
                              }
                              else {
                                setState(() {
                                  tempRepaymentMonth ="";
                                });

                              }
                            }



                          },

                        ),
                      )
                      ,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text("/"),
                      ),

                      Container(
                        width:80,

                        child:new TextField(


                          decoration: InputDecoration(
                            hintText: Translations.of(context).text('YYYY'),

                          ),

                          keyboardType: TextInputType.numberWithOptions(),
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(4),
                            globals.onlyIntNumber
                          ],


                          focusNode: repaymentYearFocus,
                          controller: tempRepaymentYear== null?null:new TextEditingController(text: tempRepaymentYear),
                          onChanged: (val){
                            tempRepaymentYear = val;
                            if(val.length==4) CustomerFormationMasterTabsState.repaymentDate = CustomerFormationMasterTabsState.repaymentDate.replaceRange(6, 10,val);

                          },
                        ),)
                      ,

                      SizedBox(
                        width: 50.0,
                      ),

                      IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                        _selectRepaymentDate(context);
                      } )
                    ],


                  ),

                ),

              new TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(

                        hintText: Translations.of(context).text('Enter_Loan_Cycle'),
                        labelText: Translations.of(context).text('Loan_Cycle'),
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
                  //enabled:  chkLoanFromOtherBank,
                      controller: CustomerFormationMasterTabsState.borrowingDetailsBean.mborrowingrefno != null
                          ? TextEditingController(
                              text: CustomerFormationMasterTabsState.borrowingDetailsBean.mborrowingrefno.toString())
                          : TextEditingController(text: ""),
                  inputFormatters: [new LengthLimitingTextInputFormatter(2),globals.onlyIntNumber],
                  onSaved: (val) {
                    if(val!=null&&val!="") CustomerFormationMasterTabsState.borrowingDetailsBean.mborrowingrefno = int.parse(val);
                      }),

              ],
            ),
          ),
          new Container(
            width: 300.0,
            height: 10.0,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: new IconButton(
                  icon: new Icon(
                    Icons.format_list_bulleted,
                    color:Color(0xff07426A),
                    size: 50.0,

                  ),
                  onPressed: () {
                    _navigateAndDisplaySelection(context);
                  },
                ),
              ),
              Flexible(
                  child: new IconButton(
                      padding: EdgeInsets.only(right: 30.0),
                      icon: new Icon(
                        Icons.add,
                        color:Color(0xff07426A),
                        size: 50.0,
                      ),
                      splashColor: Colors.red,
                      onPressed: () {

                        if(!CustomerFormationMasterTabsState.loanDate.contains("_")){
                          try{

                            String tempLoanDate = CustomerFormationMasterTabsState.loanDate;
                            print(tempLoanDate.substring(6)+"-"+tempLoanDate.substring(3,5)+"-"+tempLoanDate.substring(0,2));
                            CustomerFormationMasterTabsState.borrowingDetailsBean.mloanDate =  DateTime.parse(tempLoanDate.substring(6)+"-"+tempLoanDate.substring(3,5)+"-"+tempLoanDate.substring(0,2));
                          }catch( e){
                            _showAlert(Translations.of(context).text('Loan_Dt'), Translations.of(context).text('Loan_Dt_Error'));
                            return;
                          }
                        }

                        if(!CustomerFormationMasterTabsState.repaymentDate.contains("_")){
                          try{
                            String tempRepaymentDate = CustomerFormationMasterTabsState.repaymentDate;
                            print(tempRepaymentDate.substring(6)+"-"+tempRepaymentDate.substring(3,5)+"-"+tempRepaymentDate.substring(0,2));
                            CustomerFormationMasterTabsState.borrowingDetailsBean.mrepaymentDate=  DateTime.parse(tempRepaymentDate.substring(6)+"-"+tempRepaymentDate.substring(3,5)+"-"+tempRepaymentDate.substring(0,2));
                          }catch( e){
                            _showAlert(Translations.of(context).text('Repay_Dt'), Translations.of(context).text('Repay_Dt_Error'));
                          }
                        }


                        if(CustomerFormationMasterTabsState.borrowingDetailsBean.mnameofborrower==""||CustomerFormationMasterTabsState.borrowingDetailsBean.mnameofborrower==null){
                          _showAlert(Translations.of(context).text('name'), Translations.of(context).text('Cannot_be_Empty'));
                          return;
                        }
                        else if(CustomerFormationMasterTabsState.borrowingDetailsBean.mamount==0||CustomerFormationMasterTabsState.borrowingDetailsBean.mamount==null){
                          _showAlert(Translations.of(context).text('Loan_Amt'), Translations.of(context).text('Cannot_be_Empty'));
                          return;
                        }
                        else if(CustomerFormationMasterTabsState.borrowingDetailsBean.mloanDate==""||CustomerFormationMasterTabsState.borrowingDetailsBean.mloanDate==null){
                          _showAlert(Translations.of(context).text('Loan_Dt'), Translations.of(context).text('Cannot_be_Empty'));
                          return;
                        }
                        /*else if(CustomerFormationMasterTabsState.borrowingDetailsBean.moutstandingamt==""||CustomerFormationMasterTabsState.borrowingDetailsBean.moutstandingamt==null){
                          _showAlert("outstanding amount", "Cannot be Empty");
                          return;
                        }*/

                        else addToList();

                      })),
            ],
          ),
        ],
      ),
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new ViewBorrowingDetails(),
          fullscreenDialog: true,
        )).then((onValue) {
      setState(() {});
      //Scaffold.of(context).showSnackBar(SnackBar(content: Text("$onValue")));
    });
  }

  void addToList() {


    if(CustomerFormationMasterTabsState.custListBean.borrowingDetailsBean==null){
      CustomerFormationMasterTabsState.custListBean.borrowingDetailsBean= new  List<BorrowingDetailsBean>();
    }


    print("adding");
    int listLength = CustomerFormationMasterTabsState.custListBean.borrowingDetailsBean.length;
    print(listLength);
    print("adding");
    print("Converting");


    CustomerFormationMasterTabsState.borrowingDetailsBean.trefno = CustomerFormationMasterTabsState.custListBean.trefno;
    if(CustomerFormationMasterTabsState.borrowingDetailsBean.mrefno==null) CustomerFormationMasterTabsState.borrowingDetailsBean.mrefno = 0;
    else CustomerFormationMasterTabsState.borrowingDetailsBean.mrefno = CustomerFormationMasterTabsState.custListBean.mrefno;

    CustomerFormationMasterTabsState.borrowingDetailsBean.mborrowingrefno =0;

    CustomerFormationMasterTabsState.borrowingDetailsBean.mborrowingrefno= CustomerFormationMasterTabsState.custListBean.borrowingDetailsBean.length + 1;


    CustomerFormationMasterTabsState.custListBean.borrowingDetailsBean.add(CustomerFormationMasterTabsState.borrowingDetailsBean);

    setState(() {

      tempLoanDay = "";
      tempLoanMonth= "";
      tempLoanYear= "";
      tempRepaymentDay= "";
      tempRepaymentMonth= "";
       tempRepaymentYear= "";
      CustomerFormationMasterTabsState.loanDate= "__-__-____";
      CustomerFormationMasterTabsState.repaymentDate= "__-__-____";
      CustomerFormationMasterTabsState.borrowingDetailsBean = new  BorrowingDetailsBean();

    });

  }
  Future<Null> _selectLoanDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now());
    if (picked != null )
      setState(() {
        CustomerFormationMasterTabsState
            .loanDate=formatter.format(picked);
        if(picked.day.toString().length==1){
          tempLoanDay= "0"+picked.day.toString();
        }
        else tempLoanDay= picked.day.toString();
        tempLoanYear= picked.year.toString();
        if(picked.month.toString().length==1){
          tempLoanMonth= "0"+picked.month.toString();
        }
        else
          tempLoanMonth= picked.month.toString();

      });
  }

  Future<Null> _selectRepaymentDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime(2101));
    if (picked != null )
      setState(() {
        CustomerFormationMasterTabsState
            .repaymentDate= formatter.format(picked);
        print(CustomerFormationMasterTabsState
            .repaymentDate);
        if(picked.day.toString().length==1){
          tempRepaymentDay= "0"+picked.day.toString();
        }
        else tempRepaymentDay= picked.day.toString();
        tempRepaymentYear= picked.year.toString();
        if(picked.month.toString().length==1){
          tempRepaymentMonth= "0"+picked.month.toString();
        }
        else
          tempRepaymentMonth= picked.month.toString();

      });
  }

  Future<void> _showAlert(String error, String message) async {
  return showDialog<void>(
  context: context,
  builder: (BuildContext context) {
  return AlertDialog(
  title: Text("${error} error"),
  content: SingleChildScrollView(
  child: ListBody(
  children: <Widget>[
  new Text("${error} error"),
  new Text("${message}"),
  ],
  ),
  ),
  actions: <Widget>[
  new FlatButton(
  onPressed: () {
  Navigator.of(context).pop();
  },
  child: Text(Translations.of(context).text('Ok'))),
  ],
  );
  });
  }
}

