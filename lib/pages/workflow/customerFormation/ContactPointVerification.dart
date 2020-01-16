import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

import 'package:intl/intl.dart';

import '../../../translations.dart';
import 'FullScreenDialogForSubOccupationSelection.dart';
import 'List/FullScreenDialogForCpv.dart';
import 'bean/ContactPointVerificationBean.dart';


class ContactPointVerification extends StatefulWidget {
  ContactPointVerification();


  @override
  _ContactPointVerificationState createState() =>
      new _ContactPointVerificationState();
}

class _ContactPointVerificationState extends State<ContactPointVerification> {

  SubLookupForSubPurposeOfLoan purposeObj = new SubLookupForSubPurposeOfLoan();
  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  LookupBeanData maddmatch;
  LookupBeanData mhouseprptystatus;
  LookupBeanData mhousestructure;
  LookupBeanData mhousewall;
  LookupBeanData mhouseroof;
  var formatter = new DateFormat('yyyy');
  String assetsDesc = "";
  String assetsCode = "";

  showDropDown(LookupBeanData selectedObj, int no) {
    if(selectedObj.mcodedesc.isEmpty){
      print("inside code Desc is null");
      switch (no) {
        case 0:
          maddmatch = blankBean;
          CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.maddmatch= blankBean.mcode;
          break;
        case 1:
          mhouseprptystatus = blankBean;
          CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.mhouseprptystatus = blankBean.mcode;
          break;
        case 2:
          mhousestructure = blankBean;
          CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.mhousestructure= blankBean.mcode;
          break;
        case 3:
          mhousewall = blankBean;
          CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.mhousewall = blankBean.mcode;
          break;
        case 4:
          mhouseroof = blankBean;
          CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.mhouseroof =blankBean.mcode;
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
      k < globals.dropdownCaptionsValuesCpv[no].length;
      k++) {
        if (globals.dropdownCaptionsValuesCpv[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesCpv[no][k]);
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
      print("coming here");
      switch (no) {
        case 0:
          maddmatch = value;
          CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.maddmatch = value.mcode;
          break;
        case 1:
          mhouseprptystatus = value;
          CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.mhouseprptystatus = value.mcode;
          break;
        case 2:
          mhousestructure = value;
          CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.mhousestructure = value.mcode;
          break;
        case 3:
          mhousewall = value;
          CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.mhousewall = value.mcode;
          break;
        case 4:
          mhouseroof = value;
          CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.mhouseroof = value.mcode;
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
    k < globals.dropdownCaptionsValuesCpv[no].length;
    k++) {
      mapData.add(globals.dropdownCaptionsValuesCpv[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      print("data here is of  dropdownwale biayajai " + value.mcodedesc);
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc),
      );
    }).toList();
    return _dropDownMenuItems1;
  }



  @override
  void initState() {

    if(CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean==null){
      CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean = new ContactPointVerificationBean();
    }
    List<String> tempDropDownValues = new List<String>();

    tempDropDownValues
        .add(CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.maddmatch);
    tempDropDownValues
        .add(CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.mhouseprptystatus);
    tempDropDownValues
        .add(CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.mhousestructure);
    tempDropDownValues
        .add(CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.mhousewall);
    tempDropDownValues
        .add(CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.mhouseroof);


    for (int k = 0;
    k < globals.dropdownCaptionsValuesCpv.length;
    k++) {
      for (int i = 0;
      i < globals.dropdownCaptionsValuesCpv[k].length;
      i++) {
        try{
          if (globals.dropdownCaptionsValuesCpv[k][i].mcode.toString().trim() ==
              tempDropDownValues[k].toString().trim()) {
            print("Matched");
            setValue(k, globals.dropdownCaptionsValuesCpv[k][i]);
          }
        }catch(_){
          print("Exception Occured");
        }
      }
    }

  }






  @override
  Widget build(BuildContext context) {
    return    new Form(
      key: _formKey,
      autovalidate: false,

      onChanged: () {
        final FormState form = _formKey.currentState;
        form.save();
      },
      child: Container(
        child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Constant.mandatoryColor),
                child: new DropdownButtonFormField(
                  value:maddmatch==null?null: maddmatch,
                  items: generateDropDown(0),
                  onChanged: (LookupBeanData newValue) {
                    showDropDown(newValue, 0);
                  },
                  validator: (args) {
                    print(args);
                  },
                  decoration: InputDecoration(labelText: "Does the address match with the address in HH Certificate"),
                ),),
              Center(child: Text(
                Translations.of(context)
                    .text('Assets_Vissible'),
                style: TextStyle(
                    color: Colors.blue, fontSize: 20.0),
              ),),
              SingleChildScrollView(
                  child: new Column(
                    children: getCard(),
                  )),


        Container(
          width:80,

          child:new TextField(
            enabled: false,
            decoration: InputDecoration(
              hintText: "YYYY",
            ),

            keyboardType: TextInputType.numberWithOptions(),
            inputFormatters: [
              new LengthLimitingTextInputFormatter(4),
              globals.onlyIntNumber
            ],
           // focusNode: yearFocus,
            controller: CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.myrsmovdin == null?null:new TextEditingController(text:  CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.myrsmovdin.toString() ),

          ),)
        ,

        SizedBox(
          width: 50.0,
        ),

        IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
          _selectDate(context);
        } ),

              Container(
                decoration: BoxDecoration(color: Constant.mandatoryColor),
                child: new DropdownButtonFormField(
                  value:mhouseprptystatus==null?null: mhouseprptystatus,
                  items: generateDropDown(1),
                  onChanged: (LookupBeanData newValue) {
                    showDropDown(newValue, 1);
                  },
                  validator: (args) {
                    print(args);
                  },
                  decoration: InputDecoration(labelText: "House Property Status"),
                ),),
              Container(
                decoration: BoxDecoration(color: Constant.mandatoryColor),
                child: new DropdownButtonFormField(
                  value:mhousestructure==null?null: mhousestructure,
                  items: generateDropDown(2),
                  onChanged: (LookupBeanData newValue) {
                    showDropDown(newValue, 2);
                  },
                  validator: (args) {
                    print(args);
                  },
                  decoration: InputDecoration(labelText: "House Structure"),
                ),),
              Container(
                decoration: BoxDecoration(color: Constant.mandatoryColor),
                child: new DropdownButtonFormField(
                  value:mhousewall==null?null: mhousewall,
                  items: generateDropDown(3),
                  onChanged: (LookupBeanData newValue) {
                    showDropDown(newValue,3);
                  },
                  validator: (args) {
                    print(args);
                  },
                  decoration: InputDecoration(labelText: "House Wall"),
                ),),
              Container(
                decoration: BoxDecoration(color: Constant.mandatoryColor),
                child: new DropdownButtonFormField(
                  value:mhouseroof==null?null: mhouseroof,
                  items: generateDropDown(4),
                  onChanged: (LookupBeanData newValue) {
                    showDropDown(newValue, 4);
                  },
                  validator: (args) {
                    print(args);
                  },
                  decoration: InputDecoration(labelText: "House Roof"),
                ),),


            ]),
      ),

    );


  }



  List<Widget> getCard() {
    List<Widget> listCard = new List<Widget>();
    print(globals.dropdownCaptionsValuesCpvMuliselect.toString());
    for (int i = 0; i < globals.dropdownCaptionsValuesCpvMuliselect.length; i++) {
      print("here         XXXXXXXXXXXXXXXXX "+ globals.dropdownCaptionsValuesCpvMuliselect[i].manschecked.toString());
      listCard.add(new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
              child: CheckboxListTile(
                  value: globals.dropdownCaptionsValuesCpvMuliselect[i].manschecked == null ||
                      globals.dropdownCaptionsValuesCpvMuliselect[i].manschecked == 0
                      ? false
                      : true,
                  title: new Text(
                    globals.dropdownCaptionsValuesCpvMuliselect[i].mquestiondesc,
                    textAlign: TextAlign.left,
                  ),
                  onChanged: (val) {
                    setState(() {
                      globals.dropdownCaptionsValuesCpvMuliselect[i].manschecked =
                      val == false ? 0 : 1;
                    });
                  })),
        ],
      ));
    }

    return listCard;
  }
/*Future getAssetsVisible(String purposeMode, int selectedPosition) async {
    purposeObj = (await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForCpv(type: "Assets Visible",basicCode: 909141,position: 0),
          fullscreenDialog: true,
        )).then<List<SubLookupForSubPurposeOfLoan>>((purposeObjVal) {

      for(int itemsToAddOrRemove =0;itemsToAddOrRemove<purposeObjVal.length;itemsToAddOrRemove++) {
        assetsDesc = assetsDesc!=null && assetsDesc!=""?assetsDesc +"~"+purposeObjVal[itemsToAddOrRemove].codeDesc:purposeObjVal[itemsToAddOrRemove].codeDesc;
        assetsCode = assetsCode!=null && assetsCode!=""?assetsCode +"~"+purposeObjVal[itemsToAddOrRemove].code:purposeObjVal[itemsToAddOrRemove].code;
      }

      CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.massetvissibledesc = assetsDesc;
      CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.massetvissiblecode= assetsCode;
    })) as SubLookupForSubPurposeOfLoan;

  }*/

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(

        context: context,
        initialDate: DateTime.now().subtract(Duration(days: 1)),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now().subtract(Duration(days: 1)));
    if (picked != null && picked != CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.myrsmovdin)
      setState(() {
        CustomerFormationMasterTabsState.custListBean.contactPointVerificationBean.myrsmovdin  = formatter.format(picked);

      });
  }

}




class CheckBoxesChecked{
  String mquestionid;
  int manschecked;
  String mquestiondesc;


  @override
  String toString() {
    return 'CheckBoxesChecked{mquestionid: $mquestionid, manschecked: $manschecked, mquestiondesc: $mquestiondesc}';
  }

  CheckBoxesChecked({this.mquestionid, this.manschecked,this.mquestiondesc});

  factory CheckBoxesChecked.fromMap(
      Map<String, dynamic> map) {
    return CheckBoxesChecked(
      mquestionid: map[TablesColumnFile.mquestionid] as String,
      manschecked: map[TablesColumnFile.manschecked] as int,
      mquestiondesc: map[TablesColumnFile.mquestiondesc] as String,
    );
  }


  factory CheckBoxesChecked.frommiddleware(
      Map<String, dynamic> map) {
    return CheckBoxesChecked(
      mquestionid: map[TablesColumnFile.mquestionid] as String,
      manschecked: map[TablesColumnFile.manschecked] as int,
      mquestiondesc: map[TablesColumnFile.mquestiondesc] as String,

    );
  }




}
