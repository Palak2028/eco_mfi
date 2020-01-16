

import 'package:eco_mfi/Utilities/GetSubLookupAsMis.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:intl/intl.dart';
import '../../../translations.dart';
import '../LookupMasterBean.dart';
import 'bean/UtilityBillPaymentBean.dart';


class UtilityBillPayment extends StatefulWidget {
  UtilityBillPayment();


  @override
  _UtilityBillPaymentState createState() =>
      new _UtilityBillPaymentState();
}

class _UtilityBillPaymentState
    extends State<UtilityBillPayment> {
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UtilityBillPaymentBean utilityBillPaymentBean = new UtilityBillPaymentBean();
  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);
  LookupBeanData mutilitymode;
  LookupBeanData mutilitytype;
  LookupBeanData minquirytype;
  LookupBeanData mutilityprovider;
  bool isInquryHidden = false;
  final formatDouble = new NumberFormat("#,##0.00", "en_US");
  GetSubLookupAsMis getMisProvider = new GetSubLookupAsMis();



  showDropDown(LookupBeanData selectedObj, int no) {

    if(selectedObj.mcodedesc.isEmpty){
      //   print("inside  code Desc is null");
      switch (no) {
        case 0:
          mutilitymode = blankBean;
          utilityBillPaymentBean.mutilitymode = blankBean.mcode;
          break;
        case 1:
          mutilitytype = blankBean;
          utilityBillPaymentBean.mutilitytype = blankBean.mcode;
          break;
        case 2:
          minquirytype = blankBean;
          utilityBillPaymentBean.minquirytype= blankBean.mcode;
          break;
        case 3:
          mutilityprovider = blankBean;
          utilityBillPaymentBean.mutilityprovider =blankBean.mcode;
          break;
        default:
          break;
      }
      setState(() {

      });
    }
    else{
      bool isBreak = false;
      for (int k = 0;
      k < globals.dropDownCaptionUtilityBillPayment[no].length;
      k++) {
        if (globals.dropDownCaptionUtilityBillPayment[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropDownCaptionUtilityBillPayment[no][k]);
          isBreak=true;
          break;
        }
        if(isBreak){
          break;
        }
      }

    }


  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      // print("coming here");
      switch (no) {
        case 0:
          mutilitymode = value;
          utilityBillPaymentBean.mutilitymode = value.mcode;
          if(utilityBillPaymentBean.mutilitymode=='2') {
            isInquryHidden = true;

          }else{
            isInquryHidden = false;
          }
          setState(() {
          });
          break;
        case 1:
          mutilitytype = value;
          utilityBillPaymentBean.mutilitytype = value.mcode;
          break;
        case 2:
          minquirytype = value;
          utilityBillPaymentBean.minquirytype= value.mcode;
          break;
        case 3:
          mutilityprovider = value;
          utilityBillPaymentBean.mutilityprovider =value.mcode;
          break;
        default:
          break;
      }
    });
  }

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
    k < globals.dropDownCaptionUtilityBillPayment[no].length;
    k++) {
      mapData.add(globals.dropDownCaptionUtilityBillPayment[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      //   print("data here is of  dropdownwale biayajai " + value.mcodedesc);
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc),

      );
    }).toList();
    /*   if(no==0){
      print(mapData);
      testString = mapData;
    }*/
    return _dropDownMenuItems1;
  }


  @override
  Widget build(BuildContext context) {


    return new WillPopScope(
      onWillPop: () {
        callDialog();
      },
      child: new Scaffold(
        key: _scaffoldKey,

        appBar: new AppBar(
          elevation: 1.0,
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                callDialog();

              }
          ),
          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          title: new Text(
            'UtilityBillPayment',
            //textDirection: TextDirection,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontStyle: FontStyle.normal),
          ),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.send,
                color: Colors.white,
                size: 40.0,
              ),
              onPressed: () {
                proceed();
              },
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
            ),
          ],
        ),
        body: new Form(
          key: _formKey,
          autovalidate: false,
          onChanged: () async {
            final FormState form = _formKey.currentState;
            form.save();
            //await calculate();

          },
          child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              children: <Widget>[
                SizedBox(height: 16.0),
                Center(
                  child: new Column(children: [
                    //occupationRadio(),

                    Container(
                      child:new DropdownButtonFormField(
                        value: mutilitymode,
                        items: generateDropDown(0),
                        onChanged: (LookupBeanData newValue) {
                          showDropDown(newValue, 0);
                        },
                        validator: (args) {
                          print(args);
                        },
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),

                          labelText: "Utility Mode",
                          hintText: "Enter Utility Mode",
                        ),

                      ),)


                  ]),
                ),
                SizedBox(height: 10.0,),
                Center(
                  child: new Column(children: [
                    //occupationRadio(),

                    !isInquryHidden?Container(
                      child:new DropdownButtonFormField(
                        value: mutilitytype,
                        items: generateDropDown(1),
                        onChanged: (LookupBeanData newValue) {
                          showDropDown(newValue, 1);
                        },
                        validator: (args) {
                          print(args);
                        },
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),

                          labelText: "Utility Type",
                          hintText: "Enter Utility Type",
                        ),

                        // style: TextStyle(color: Colors.grey),
                      ),):Container()


                  ]),
                ),
                SizedBox(height: 10.0,),
                Center(
                  child: new Column(children: [
                    //occupationRadio(),

                    isInquryHidden? Container(
                      child:new DropdownButtonFormField(
                        value: minquirytype,
                        items: generateDropDown(2),
                        onChanged: (LookupBeanData newValue) {
                          showDropDown(newValue, 2);
                        },
                        validator: (args) {
                          print(args);
                        },
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),

                          labelText: "Inquiry Type",
                          hintText: "Enter Inquiry Type",
                        ),

                        // style: TextStyle(color: Colors.grey),
                      ),):Container()


                  ]),
                ),

                SizedBox(height: 10.0,),
                /*Center(
                  child: new Column(children: [
                    //occupationRadio(),

                   !isInquryHidden? Container(
                      child:new DropdownButtonFormField(
                        value: mutilityprovider,
                        items: generateDropDown(3),
                        onChanged: (LookupBeanData newValue) {
                          showDropDown(newValue, 3);
                        },
                        validator: (args) {
                          print(args);
                        },
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),

                          labelText: "Utility Provider",
                          hintText: "Enter Utility Provider",
                        ),
                        //decoration: InputDecoration(labelText: "Utility Provider"),
                        // style: TextStyle(color: Colors.grey),
                      ),):Container
                  ]),
                ),*/
                !isInquryHidden?new Card(
                  child: new ListTile(
                      title: new Text("Utility Provider"),
                      subtitle: utilityBillPaymentBean.mutilityprovider== null
                          ? new Text("")
                          : new Text("Industry : ${utilityBillPaymentBean.mutilityprovider}   And Code : ${utilityBillPaymentBean.mutilityproviderdesc}"),
                      onTap: () => getProviderOnMisBases()),
                ):Container(),

                SizedBox(height: 16.0),
                isInquryHidden?new Container(
                  child: new TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        hintText: 'Enter Customer No',
                        labelText: 'Customer No',
                      ),
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(50),
                        globals.onlyCharacter
                      ],
                      initialValue:
                      utilityBillPaymentBean.mcustno != null ? utilityBillPaymentBean.mcustno : "",
                      onSaved: (String value) {
                        /*globals.firstName = value;*/
                        utilityBillPaymentBean.mcustno =
                            value;
                      }),
                ):Container(),
                //  SizedBox(height: 16.0),
                !(isInquryHidden)?new Container(
                  child: new TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        hintText: 'Enter Nic',
                        labelText: 'Nic',
                      ),
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(50),
                        globals.onlyCharacter
                      ],
                      initialValue:
                      utilityBillPaymentBean.mnic != null ? utilityBillPaymentBean.mnic : "",
                      onSaved: (String value) {
                        /*globals.firstName = value;*/
                        utilityBillPaymentBean.mnic =
                            value;
                      }),
                ):Container(),
                SizedBox(height: 16.0),
                !isInquryHidden?new Container(
                  child: new TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        hintText: 'Enter Mobile',
                        labelText: 'Mobile',
                      ),
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(50),
                        globals.onlyCharacter
                      ],
                      initialValue:
                      utilityBillPaymentBean.mmobile != null ? utilityBillPaymentBean.mmobile : "",
                      onSaved: (String value) {
                        /*globals.firstName = value;*/
                        utilityBillPaymentBean.mmobile =
                            value;
                      }),
                ):Container(),
                SizedBox(height: 16.0),
                !isInquryHidden?new Container(
                  child: new TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        hintText: 'Enter Refrence Number',
                        labelText: ' Refrence Number',
                      ),

                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(50),
                        globals.onlyCharacter
                      ],
                      initialValue:
                      utilityBillPaymentBean.mrefrenceno != null ? utilityBillPaymentBean.mrefrenceno : "",
                      onSaved: (String value) {
                        /*globals.firstName = value;*/
                        utilityBillPaymentBean.mrefrenceno =
                            value;
                      }),
                ):Container(),
                SizedBox(height: 16.0),
                !isInquryHidden?new Container(
                  child: new TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        hintText: 'Enter Confirm Refrence Number',
                        labelText: 'Confirm Refrence Number',
                      ),

                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(50),
                        globals.onlyCharacter
                      ],
                      initialValue:
                      utilityBillPaymentBean.mrefrencecnfrm != null ? utilityBillPaymentBean.mrefrencecnfrm : "",
                      onSaved: (String value) {
                        /*globals.firstName = value;*/
                        utilityBillPaymentBean.mrefrencecnfrm =
                            value;
                      }),
                ):Container(),
                SizedBox(height: 10.0,),
                !isInquryHidden?new TextFormField(
                  controller: utilityBillPaymentBean.mamount !=
                      null &&
                      utilityBillPaymentBean.mamount !=
                          null
                      ? TextEditingController(
                      text: formatDouble.format(utilityBillPaymentBean.mamount))
                      : TextEditingController(text: "0.0"),
                  onSaved: (String value) {
                    try {
                      utilityBillPaymentBean.mamount = double.parse(value);
                      //addToList(context,0);
                    } catch (_) {}
                  },
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: Translations.of(context).text('amthint'),
                      labelText: Translations.of(context).text('amtlabel'),
                      prefixText: '',
                      suffixText: '',
                      suffixStyle: const TextStyle(color: Colors.green)),
                ):Container(),
              ]
          ),
        ),
      ),
    );
  }

  Future getProviderOnMisBases() async {
    int selectedPosition;
    if(utilityBillPaymentBean.mutilitytype!=null){
      try{
        selectedPosition= int.parse(utilityBillPaymentBean.mutilitytype);
      }catch(_){

      }
    }
    await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              GetSubLookupAsMis(codetype: 11111111,position: selectedPosition,selectionType: "Get Utility Provider",),
          fullscreenDialog: true,
        )).then<SubLookupForSubPurposeOfLoan>((val) {

      utilityBillPaymentBean.mutilityproviderdesc = val.codeDesc;
      utilityBillPaymentBean.mutilityprovider = (val.code.trim());
    });

  }

  Future<bool> callDialog() {
    globals.Dialog.onPop(
        context,
        'Are you sure?',
        'Do you want to Go To Dashboard without saving data',
        "Will");
  }

  void proceed() {
    _ShowCircInd();
    Future.delayed(const Duration(seconds: 5),()=>Navigator.of(context).pop());
    showMessageWithoutProgress("Please Try Submitting Later");
    // Navigator.of(context).pop();

  }


  Future<void> _ShowCircInd() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Billing'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[CircularProgressIndicator()],
            ),
          ),
        );
      },
    );
  }

  void showMessageWithoutProgress(String message,
      [MaterialColor color = Colors.red]) {
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

}