import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/address/FullScreenDialogForAreaSelection.dart';
import 'package:eco_mfi/pages/workflow/address/FullScreenDialogForCountrySelection.dart';
import 'package:eco_mfi/pages/workflow/address/FullScreenDialogForDistrictSelection.dart';
import 'package:eco_mfi/pages/workflow/address/FullScreenDialogForStateSelection.dart';
import 'package:eco_mfi/pages/workflow/address/FullScreenDialogForSubDistrictSelection.dart';
import 'package:eco_mfi/pages/workflow/address/beans/AreaDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/CountryDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/DistrictDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/StateDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/SubDistrictDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/ViewCustomerFormationAddressDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerFormationContactDetails extends StatefulWidget {
  CustomerFormationContactDetails({Key key}) : super(key: key);

  @override
  _CustomerFormationContactDetailsState createState() =>
      new _CustomerFormationContactDetailsState();
}

class _CustomerFormationContactDetailsState
    extends State<CustomerFormationContactDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FullScreenDialogForCountrySelection _myCountryDialog =
  new FullScreenDialogForCountrySelection();
  FullScreenDialogForStateSelection _myStateDialog =
  new FullScreenDialogForStateSelection();
  FullScreenDialogForDistrictSelection _myDistrictDialog =
  new FullScreenDialogForDistrictSelection();
  FullScreenDialogForSubDistrictSelection _mySubDistrictDialog =
  new FullScreenDialogForSubDistrictSelection(false);
  FullScreenDialogForSubDistrictSelection _mySubDistrictDialogDesend =
  new FullScreenDialogForSubDistrictSelection(true);
  FullScreenDialogForAreaSelection _myAreaDialog =
  new FullScreenDialogForAreaSelection();
  final TextEditingController _controller = new TextEditingController();
  static bool isSubmitClicked = false;
  var _focusNode = new FocusNode();
  AddressDetailsBean addressBean = new AddressDetailsBean();
  final List<AddressDetailsBean> addressDetailsList = new List<AddressDetailsBean>();
  LookupBeanData addressType;
  CountryDropDownBean tempContrybean = new CountryDropDownBean();
  StateDropDownList tempStateBean = new StateDropDownList();
  SubDistrictDropDownList tempSubDistrictBean = new SubDistrictDropDownList();
  DistrictDropDownList tempDistrictBean = new DistrictDropDownList();
  AreaDropDownList tempAreaDistrict = new AreaDropDownList();
  SharedPreferences prefs;
  bool isWasasa = false;
  bool isAddDescHercy = false;
  String dialCode = "";
 int currentAddressCode=0;
  String geoLatitude;
  String geoLongitude;
  int isFullerTon=0;


  @override
  void initState() {
    super.initState();
   // getSessionVariables();

    if(CustomerFormationMasterTabsState.addressBean!=null){
      print(CustomerFormationMasterTabsState.addressBean.maddrType);
      for (int k = 0; k < globals.dropdownCaptionsValuesKycDetails2.length; k++) {
        for (int i = 0;
        i < globals.dropdownCaptionsValuesKycDetails2[k].length;
        i++) {
          if (globals.dropdownCaptionsValuesKycDetails2[k][i].mcode ==
              CustomerFormationMasterTabsState.addressBean.maddrType.toString()) {

            print("matched value is ${globals.dropdownCaptionsValuesKycDetails2[k][i].mcode}");
            setValue(k, globals.dropdownCaptionsValuesKycDetails2[k][i]);
          }
        }
      }

    }
    else{

      CustomerFormationMasterTabsState.addressBean= new AddressDetailsBean();
    }

    getSessionVariables();

  }



  Future<Null> getSessionVariables() async {

    prefs = await SharedPreferences.getInstance();

    if(prefs.getInt(TablesColumnFile.isWASASA)==1){
      isWasasa = true ;

    }
    else{
      isWasasa = false;
    }
    if(prefs.getInt(TablesColumnFile.ISADDDESC)==1){
      isAddDescHercy = true ;
    }
    else{
      isAddDescHercy = false;
    }
<<<<<<< .mine

    try {
      isFullerTon = prefs.getInt(TablesColumnFile.ISFULLERTON);

      if(isFullerTon==1) {
        CustomerFormationMasterTabsState.addressBean.mcountryCd = "95";
        CustomerFormationMasterTabsState.addressBean.mcountryname = "Myanmar";
        setState(() {
        });
      }
    }catch(_){}


=======
    try {
      isFullerTon = prefs.getInt(TablesColumnFile.ISFULLERTON);
      if(isFullerTon==1) {
        CustomerFormationMasterTabsState.addressBean.mcountryCd = "95";
        CustomerFormationMasterTabsState.addressBean.mcountryname = "Myanmar";
        setState(() {
        });
      }
    }catch(_){}


>>>>>>> .r1143
    dialCode = prefs.getString(TablesColumnFile.dialCode);
    currentAddressCode = prefs.getInt(TablesColumnFile.currentAddressCode);
    try{
      setState(() {
        geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
        geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();

      });
    }catch(_){}

  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    //print("caption value : " + globals.dropdownCaptionsKycDetails2[no]);

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
    k < globals.dropdownCaptionsValuesKycDetails2[no].length;
    k++) {
      mapData.add(globals.dropdownCaptionsValuesKycDetails2[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      print("data here is of adress Type dropdownwale biayajai " +
          value.mcodedesc);
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc),
      );
    }).toList();

    return _dropDownMenuItems1;
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
  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);


  showDropDown(LookupBeanData selectedObj, int no) {


    if(selectedObj.mcodedesc.isEmpty){
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          addressType = blankBean;
          CustomerFormationMasterTabsState.addressBean.maddrType = 0;
          break;
          break;
      }
      setState(() {

      });
    }else{
      for (int k = 0;
      k < globals.dropdownCaptionsValuesKycDetails2[no].length;
      k++) {
        if (globals.dropdownCaptionsValuesKycDetails2[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesKycDetails2[no][k]);
        }
      }
    }

  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          addressType = value;
          CustomerFormationMasterTabsState.addressBean.maddrType =
              int.parse(value.mcode);
<<<<<<< .mine

          if(CustomerFormationMasterTabsState.custListBean.addressDetails.length>0&&CustomerFormationMasterTabsState.custListBean.addressDetails[0].maddrType!=currentAddressCode ){
            _showAlert("First Address Type" , "Should be current Address Type").then((onValue){

                CustomerFormationMasterTabsState.addressBean.maddrType =
                    currentAddressCode;

            });
            return;
          }

          if(CustomerFormationMasterTabsState.custListBean.addressDetails.length>0){
=======
          //TODO below if condition not in use
   /*       if(CustomerFormationMasterTabsState.custListBean.addressDetails.length>0&&CustomerFormationMasterTabsState.custListBean.addressDetails[0].maddrType!=currentAddressCode ){
            _showAlert("First Address Type" , "Should be current Address Type").then((onValue){
                CustomerFormationMasterTabsState.addressBean.maddrType =
                    currentAddressCode;
            });
            return;
          }*/


          if(CustomerFormationMasterTabsState.custListBean.addressDetails.length>0 && CustomerFormationMasterTabsState.addressBean.maddrType != currentAddressCode){
>>>>>>> .r1143
            LookupBeanData tempBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);
<<<<<<< .mine

            for(int getName=0;getName<globals.dropdownCaptionsValuesKycDetails2[no].length;getName++){
              print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
              print(currentAddressCode);
              print(globals.dropdownCaptionsValuesKycDetails2[no][getName].mcode);
              if(globals.dropdownCaptionsValuesKycDetails2[no][getName].mcode == currentAddressCode.toString() ){
                onSelectAddress(context,"Address","Is this address is same as ${globals.dropdownCaptionsValuesKycDetails2[no][getName].mcodedesc}");
              }
            }

=======
            for(int getName=0;getName<globals.dropdownCaptionsValuesKycDetails2[no].length;getName++){
              if(globals.dropdownCaptionsValuesKycDetails2[no][getName].mcode == currentAddressCode.toString() ){
                onSelectAddress(context,"Address","Is this address is same as ${globals.dropdownCaptionsValuesKycDetails2[no][getName].mcodedesc}");
              }
            }
          }else{

>>>>>>> .r1143
          }
          break;
        default:
          break;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
            key: _formKey,
            autovalidate: false,
            onWillPop: () {
              return Future(() => true);
            },
            onChanged: () {
              final FormState form = _formKey.currentState;
              form.save();
            },
            child: new ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                SizedBox(
                  height: 16.0,
                ),
            Container(
              color: Constant.mandatoryColor,
              child: new DropdownButtonFormField(
                  value: addressType,
                  items: generateDropDown(0),
                  onChanged: (LookupBeanData newValue) {
                    showDropDown(newValue, 0);
                    if(CustomerFormationMasterTabsState.addressBean.maddrType==1){
                      CustomerFormationMasterTabsState.resAddPresent  =true;
                      print("On Changfes Called");

                    }
                  },
                  validator: (args) {
                    print(args);
                 },
                  decoration: InputDecoration(
                      labelText: globals.dropdownCaptionsKycDetails2[0]),
                ),),

                SizedBox(height: 16.0),
          isAddDescHercy==false?  Column(
                children: <Widget>[
                Container(
                  color:  Constant.semiMandatoryColor,
                  child: new ListTile(
                    title: new Text("Country"),
                    subtitle: CustomerFormationMasterTabsState.addressBean.mcountryCd == null ||
                        CustomerFormationMasterTabsState.addressBean.mcountryCd == "null"
                        ? new Text("")
                        : new Text("${CustomerFormationMasterTabsState.addressBean.mcountryCd} ${CustomerFormationMasterTabsState.addressBean.mcountryname}"),
                    onTap: () async {

                    tempContrybean = await
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) => _myCountryDialog,
                          fullscreenDialog: true,
                        ));

                    if(tempContrybean!=null){
                      CustomerFormationMasterTabsState.addressBean.mcountryCd = tempContrybean.cntryCd;
                      CustomerFormationMasterTabsState.addressBean.mcountryname = tempContrybean.countryName;
                    }
                  },
                ),
                ),
                new Divider(),//),
                SizedBox(height: 16.0),
                Container(
                  color: Constant.semiMandatoryColor,
                  child: new ListTile(

                     title: new Text(Translations.of(context).text("State")),
                    subtitle:
                    CustomerFormationMasterTabsState.addressBean.mState == null || CustomerFormationMasterTabsState.addressBean.mState == "null"
                        ? new Text("")
                        : new Text("${CustomerFormationMasterTabsState.addressBean.mState} ${CustomerFormationMasterTabsState.addressBean.mstatedesc}"),
                    onTap: () async {

                    tempStateBean = await
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) => _myStateDialog,
                          fullscreenDialog: true,
                        ));

                    if(tempStateBean!=null){
                      CustomerFormationMasterTabsState.addressBean.mState = tempStateBean.stateCd;
                      CustomerFormationMasterTabsState.addressBean.mstatedesc  = tempStateBean.stateDesc;
                    }
                    setState(() {

                    });
                  },
                ),
                ),

                new Divider(),
                SizedBox(height: 16.0),


                Container(
                  color: Constant.semiMandatoryColor,
                  child: new ListTile(

                  title:isWasasa==true? new Text(Translations.of(context).text('zone')):
                  new Text(Translations.of(context).text('district')),
                  subtitle:
                  CustomerFormationMasterTabsState.addressBean.mDistCd == null || CustomerFormationMasterTabsState.addressBean.mDistCd == "null"
                      ? new Text("")
                      : new Text("${CustomerFormationMasterTabsState.addressBean.mDistCd} ${CustomerFormationMasterTabsState.addressBean.mdistdesc}"),
                  onTap: () async  {

                    tempDistrictBean =  await
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) => _myDistrictDialog,
                          fullscreenDialog: true,
                        ));


                    if(tempDistrictBean!=null){
                      try{
                        CustomerFormationMasterTabsState.addressBean.mDistCd = tempDistrictBean.distCd;
                        CustomerFormationMasterTabsState.addressBean.mdistdesc = tempDistrictBean.distDesc;
                      }catch(e){
                        print("District code exception");
                      }
                    }




                  },
                  ),
                ),

                new Divider(),
                SizedBox(height: 16.0),
                Container(
                  color: Constant.mandatoryColor,
                  child: new ListTile(

                    title: isWasasa==true? new Text(Translations.of(context).text('woreda')):
                    new Text(Translations.of(context).text('subDistrict')),
                    subtitle: CustomerFormationMasterTabsState.addressBean.mplacecd == null ||
                        CustomerFormationMasterTabsState.addressBean.mplacecd == "null"
                        ? new Text("")
                        : new Text("${CustomerFormationMasterTabsState.addressBean.mplacecd} ${CustomerFormationMasterTabsState.addressBean.mplacedesc}"),
                    onTap: () async{

                      tempSubDistrictBean = await
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (BuildContext context) =>
                            _mySubDistrictDialog,
                            fullscreenDialog: true,
                          ));
                      /*CustomerFormationMasterTabsState.addressBean.mP= int.parse(tempDistrictBean.distCd);*/
                      if(tempSubDistrictBean!=null){
                        CustomerFormationMasterTabsState.addressBean.mplacecd= tempSubDistrictBean.placeCd;
                        CustomerFormationMasterTabsState.addressBean.mplacedesc = tempSubDistrictBean.placeCdDesc;
                      }
                    },
                  ),
                ),

                new Divider(),
                SizedBox(height: 16.0),
                new ListTile(
                  title: isWasasa==true? new Text(Translations.of(context).text('kebele')):
                  new Text(Translations.of(context).text('area')),
                  subtitle:
                  CustomerFormationMasterTabsState.addressBean.marea == null || CustomerFormationMasterTabsState.addressBean.marea == "null"
                      ? new Text("")
                      : new Text("${CustomerFormationMasterTabsState.addressBean.marea} ${CustomerFormationMasterTabsState.addressBean.mareadesc}"),
                  onTap: () async {

                    tempAreaDistrict = await

                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) => _myAreaDialog,
                          fullscreenDialog: true,
                        ));

                    if(tempAreaDistrict!=null){
                      try{
                        CustomerFormationMasterTabsState.addressBean.marea= tempAreaDistrict.areaCd;
                        CustomerFormationMasterTabsState.addressBean.mareadesc = tempAreaDistrict.areaDesc;
                      }catch(e){
                        print("area code exception");
                      }
                    }
                    },
                  ),
                ],
              ):

                Column(
                  children: <Widget>[

<<<<<<< .mine
=======




>>>>>>> .r1143
                new Divider(),
                    SizedBox(height: 16.0),
                    Container(
                      color: Constant.mandatoryColor,
                      child: new ListTile(

                        title: isWasasa==true? new Text(Translations.of(context).text('woreda')):
                        new Text(Translations.of(context).text('subDistrict')),
                        subtitle: CustomerFormationMasterTabsState.addressBean.mplacecd == null ||
                            CustomerFormationMasterTabsState.addressBean.mplacecd == "null"
                            ? new Text("")
                            : new Text("${CustomerFormationMasterTabsState.addressBean.mplacecd} ${CustomerFormationMasterTabsState.addressBean.mplacedesc}"),
                        onTap: () async{

                          tempSubDistrictBean = await
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                _mySubDistrictDialogDesend,
                                fullscreenDialog: true,
                              ));
                          await setAddressInDesc();
                          if(tempSubDistrictBean!=null){
                            CustomerFormationMasterTabsState.addressBean.mplacecd= tempSubDistrictBean.placeCd;
                            CustomerFormationMasterTabsState.addressBean.mplacedesc = tempSubDistrictBean.placeCdDesc;
                          }
                        },
                      ),
                    ),


                    new Divider(),
                    SizedBox(height: 16.0),


                    Container(
                      color: Constant.semiMandatoryColor,
                      child: new ListTile(

                        title:isWasasa==true? new Text(Translations.of(context).text('zone')):
                        new Text(Translations.of(context).text('district')),
                        subtitle:
                        CustomerFormationMasterTabsState.addressBean.mDistCd == null || CustomerFormationMasterTabsState.addressBean.mDistCd == "null"
                            ? new Text("")
                            : new Text("${CustomerFormationMasterTabsState.addressBean.mDistCd} ${CustomerFormationMasterTabsState.addressBean.mdistdesc}"),
                        onTap: () async  {

<<<<<<< .mine
=======






>>>>>>> .r1143
                        },
                      ),
                  ),


                    new Divider(),//),
                    SizedBox(height: 16.0),
                    Container(
                      color: Constant.semiMandatoryColor,
                      child: new ListTile(

                        title: new Text(Translations.of(context).text("State")),
                        subtitle:
                        CustomerFormationMasterTabsState.addressBean.mState == null || CustomerFormationMasterTabsState.addressBean.mState == "null"
                            ? new Text("")
                            : new Text("${CustomerFormationMasterTabsState.addressBean.mState} ${CustomerFormationMasterTabsState.addressBean.mstatedesc}"),
                        onTap: () async {

                  },
                      ),
                    ),

                    new Divider(),
                    SizedBox(height: 16.0),

                    Container(
                      color:  Constant.semiMandatoryColor,
                      child: new ListTile(
                        title: new Text("Country"),
                        subtitle: CustomerFormationMasterTabsState.addressBean.mcountryCd == null ||
                            CustomerFormationMasterTabsState.addressBean.mcountryCd == "null"
                            ? new Text("")
                            : new Text("${CustomerFormationMasterTabsState.addressBean.mcountryCd} ${CustomerFormationMasterTabsState.addressBean.mcountryname}"),
                        onTap: () async {

<<<<<<< .mine
=======
                  },
                      ),
                    ),
                    new ListTile(
                      title: isWasasa==true? new Text(Translations.of(context).text('kebele')):
                      new Text(Translations.of(context).text('area')),
                      subtitle:
                      CustomerFormationMasterTabsState.addressBean.marea == null || CustomerFormationMasterTabsState.addressBean.marea == "null"
                          ? new Text("")
                          : new Text("${CustomerFormationMasterTabsState.addressBean.marea} ${CustomerFormationMasterTabsState.addressBean.mareadesc}"),
                      onTap: () async {
                        tempAreaDistrict = await
                        await Navigator.push(
                              context,
                              new MaterialPageRoute(
                              builder: (BuildContext context) => _myAreaDialog,
                                fullscreenDialog: true,
                              ));

                        if(tempAreaDistrict!=null){
                          try{
                            CustomerFormationMasterTabsState.addressBean.marea= tempAreaDistrict.areaCd;
                            CustomerFormationMasterTabsState.addressBean.mareadesc = tempAreaDistrict.areaDesc;
                          }catch(e){
                            print("area code exception");
                          }
>>>>>>> .r1143
                        }
                  },
                      ),


                    new ListTile(
                      title: isWasasa==true? new Text(Translations.of(context).text('kebele')):
                      new Text(Translations.of(context).text('area')),
                      subtitle:
                      CustomerFormationMasterTabsState.addressBean.marea == null || CustomerFormationMasterTabsState.addressBean.marea == "null"
                          ? new Text("")
                          : new Text("${CustomerFormationMasterTabsState.addressBean.marea} ${CustomerFormationMasterTabsState.addressBean.mareadesc}"),
                      onTap: () async {

                        tempAreaDistrict = await

                        await Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (BuildContext context) => _myAreaDialog,
                              fullscreenDialog: true,
                            ));
                        if(tempAreaDistrict!=null){
                          try{
                            CustomerFormationMasterTabsState.addressBean.marea= tempAreaDistrict.areaCd;
                            CustomerFormationMasterTabsState.addressBean.mareadesc = tempAreaDistrict.areaDesc;
                          }catch(e){
                            print("area code exception");
                          }
                        }
                      },
                    ),

                  ],
                ),
                new Divider(),
                Container(
                  color: Constant.semiMandatoryColor ,
                  child: new TextFormField(
                    decoration: InputDecoration(

                      hintText: Translations.of(context).text('Enter_Address_Line_1'),
                      labelText: Translations.of(context).text('Address_Line_1'),
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
                  controller: CustomerFormationMasterTabsState.addressBean.maddr1 != null
                      ? TextEditingController(text: CustomerFormationMasterTabsState.addressBean.maddr1)
                      : TextEditingController(text: ""),
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(50)/*,
                    globals.onlyCharacter*/
                  ],
                  onSaved: (val) {
                    //  if(val!=null) {
                    CustomerFormationMasterTabsState.addressBean.maddr1 = val;
                    // }
                  },
                  ),
                ),Container(
                  color:isFullerTon==0 ? Constant.semiMandatoryColor:Colors.white,
                  child: new TextFormField(
                    decoration: InputDecoration(
                      hintText: Translations.of(context).text('Enter_Address_Line_2'),
                      labelText: Translations.of(context).text('Address_Line_2'),
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
                    controller: CustomerFormationMasterTabsState.addressBean.maddr2 != null
                        ? TextEditingController(text: CustomerFormationMasterTabsState.addressBean.maddr2)
                        : TextEditingController(text: ""),
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(50)/*,
                      globals.onlyCharacter*/
                    ],
                    onSaved: (val) {
                      //  if(val!=null) {
                      CustomerFormationMasterTabsState.addressBean.maddr2 = val;
                      // }
                    },
                  ),
                ),new TextFormField(
                  decoration: InputDecoration(
                    hintText: Translations.of(context).text('entrAddLine3'),
                    labelText: Translations.of(context).text('addLin3'),
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
                  controller: CustomerFormationMasterTabsState.addressBean.maddr3 != null
                      ? TextEditingController(text: CustomerFormationMasterTabsState.addressBean.maddr3)
                      : TextEditingController(text: ""),
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(50)/*,
                    globals.onlyCharacter*/
                  ],
                  onSaved: (val) {
                    //  if(val!=null) {
                    CustomerFormationMasterTabsState.addressBean.maddr3 = val;
                    // }
                  },
                )
                ,
                isFullerTon!=1?new TextFormField(
                  decoration: InputDecoration(
                    hintText: Translations.of(context).text('entrLndMrkHere'),
                    labelText: Translations.of(context).text('LandMark'),
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
                  controller: CustomerFormationMasterTabsState.addressBean.mLandmark != null
                      ? TextEditingController(text: CustomerFormationMasterTabsState.addressBean.mLandmark)
                      : TextEditingController(text: ""),
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(80),
                    globals.onlyCharacter
                  ],
                  onSaved: (val) {
                    //  if(val!=null) {
                    CustomerFormationMasterTabsState.addressBean.mLandmark = val;
                    // }
                  },
                ):new Container(),

                isWasasa==true || isFullerTon==1?new Container():
                new TextFormField(
                  decoration: InputDecoration(
                    hintText: Translations.of(context).text('enThanahere'),
                    labelText: Translations.of(context).text('Thana'),
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
                  controller: CustomerFormationMasterTabsState.addressBean.mThana != null
                      ? TextEditingController(text: CustomerFormationMasterTabsState.addressBean.mThana)
                      : TextEditingController(text: ""),
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(30),
                    globals.onlyCharacter
                  ],
                  onSaved: (val) {
                    //  if(val!=null) {
                    CustomerFormationMasterTabsState.addressBean.mThana = val;
                    // }
                  },
                ),
                isFullerTon==0?Container(
                  color: isWasasa==true?Colors.white:Constant.semiMandatoryColor,
                  child: new TextFormField(
                    decoration: InputDecoration(
                      hintText: Translations.of(context).text('entrPin'),
                      labelText: Translations.of(context).text('Pin '),
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
                    keyboardType: TextInputType.number,
                    controller: CustomerFormationMasterTabsState.addressBean.mpinCd != null
                        ? TextEditingController(text: CustomerFormationMasterTabsState.addressBean.mpinCd.toString())
                        : TextEditingController(text: ""),
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(6),
                      globals.onlyIntNumber
                    ],
                    onSaved: (val) {
                      if(val!=null&&val!=""){
                        try{
                          CustomerFormationMasterTabsState.addressBean.mpinCd = int.parse(val);
                        }catch(e){

                      }
                    }

                  },
                  ),
                ):new Container(),
            isFullerTon==0? new TextFormField(
                  decoration: InputDecoration(
                    hintText: Translations.of(context).text('entrYrOfStayHere'),
                    labelText: Translations.of(context).text('yrOfStay'),
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
                  keyboardType: TextInputType.number,
                  controller: CustomerFormationMasterTabsState.addressBean.mYearStay != null&&CustomerFormationMasterTabsState.addressBean.mYearStay != 0
                      ? TextEditingController(text: CustomerFormationMasterTabsState.addressBean.mYearStay.toString())
                      : TextEditingController(text: ""),
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(3),
                    globals.onlyIntNumber
                  ],
                  onSaved: (val) {
                    if(val!=null&&val!="") {
                      try{
                        CustomerFormationMasterTabsState.addressBean.mYearStay = int.parse(val);
                      }catch(e){

                      }

                    }
                    else {
                      CustomerFormationMasterTabsState.addressBean.mYearStay = 0;
                    }
                  },
                ):new Container(),
                isFullerTon==0?Container(

                  color: CustomerFormationMasterTabsState.addressBean.maddrType==1?Constant.mandatoryColor:Colors.white,
                  child: new TextFormField(
                    decoration: InputDecoration(

                      //hintText: 'Enter Post here',
                      //labelText: 'Post',
                      hintText: Translations.of(context).text('entrNoOfRoom'),//changed to no.of rooms from post
                      labelText: Translations.of(context).text('noOfRoom'),
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
                    keyboardType: TextInputType.number,
                    controller: CustomerFormationMasterTabsState.addressBean.mNoOfRooms != null
                        ? TextEditingController(text: CustomerFormationMasterTabsState.addressBean.mNoOfRooms.toString())
                        : TextEditingController(text: ""),
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(1),
                      globals.onlyIntNumber
                    ],
                    onSaved: (val) {
                      if(val!=null&&val!="") {
                        try{
                          CustomerFormationMasterTabsState.addressBean.mNoOfRooms = int.parse(val);
                        }catch(e){

                      }

                    }
                  },
                  ),
                ):new Container(),
                Container(
                  color: Constant.semiMandatoryColor,
                  child: new TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: Translations.of(context).text('entrMobHere'),
                      labelText: Translations.of(context).text('mobNum'),
                      prefixText: "+"+dialCode,
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
                    controller: CustomerFormationMasterTabsState.addressBean.mMobile != null
                        ? TextEditingController(text: CustomerFormationMasterTabsState.addressBean.mMobile)
                        : TextEditingController(text: ""),
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(isFullerTon==0?10:11),
                      globals.onlyIntNumber
                    ],
                    onSaved: (val) {
                      //  if(val!=null) {
                      CustomerFormationMasterTabsState.addressBean.mMobile = val;
                      // }
                    },
                  ),
                ),
                new TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: Translations.of(context).text('entrLandNumHere'),
                    labelText: Translations.of(context).text('landlinneNum'),
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
                  controller: CustomerFormationMasterTabsState.addressBean.mtel1!= null
                      ? TextEditingController(text: CustomerFormationMasterTabsState.addressBean.mtel1)
                      : TextEditingController(text: ""),
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(isFullerTon==0?15:11),
                    globals.onlyIntNumber
                  ],
                  onSaved: (val) {
                    //  if(val!=null) {
                    CustomerFormationMasterTabsState.addressBean.mtel1 = val;
                    // }
                  },
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: new IconButton(
                        icon: new Icon(
                          Icons.format_list_bulleted,
                          color: Color(0xff07426A),
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
                              color: Color(0xff07426A),
                              size: 50.0,
                            ),
                            splashColor: Colors.red,
                            onPressed: () {
                              bool temp = true;

                              if(CustomerFormationMasterTabsState.custListBean!=null&&CustomerFormationMasterTabsState.custListBean.addressDetails!=null){
                                for(int i =0;i<CustomerFormationMasterTabsState.custListBean.addressDetails.length;i++){

                                  if(CustomerFormationMasterTabsState.addressBean.maddrType==
                                      CustomerFormationMasterTabsState.custListBean.addressDetails[i].maddrType){

                                    temp= false;
                                  }

                                }

                              }

                              if(temp==false){

                                _showAlert(
                                    Translations.of(context).text("Address Type"),

                                    Translations.of(context).text("an address type can be added only once"));
                              }
                              else if(temp==true){
                              if (CustomerFormationMasterTabsState.addressBean.maddrType== "" ||
                                  CustomerFormationMasterTabsState.addressBean.maddrType == null) {
                                  _showAlert(
                                      Translations.of(context).text("Address Type"),
                                      Translations.of(context).text("Must Be Specified"));
                                }
                                else if(CustomerFormationMasterTabsState.addressBean.mcountryCd==null||CustomerFormationMasterTabsState.addressBean.mcountryCd.toString().trim()==""){
                                  _showAlert(Translations.of(context).text("Country"),
                                      Translations.of(context).text("Cannot be Empty"));
                                  return;
                                }
                                else if(CustomerFormationMasterTabsState.addressBean.mState==null||CustomerFormationMasterTabsState.addressBean.mState.trim()==""){
                                  _showAlert(Translations.of(context).text("State"),
                                      Translations.of(context).text("Cannot be Empty"));
                                  return;
                              }
                              else if(CustomerFormationMasterTabsState.addressBean.mDistCd==null||CustomerFormationMasterTabsState.addressBean.mDistCd.toString().trim()==""){

                                if(isWasasa==true){
                                  _showAlert(Translations.of(context).text('zone'), "Cannot be Empty");
                                }else{
                                  _showAlert(Translations.of(context).text('district'), "Cannot be Empty");
                                }

                                return;
                              }
                              else if(CustomerFormationMasterTabsState.addressBean.mplacecd==null||CustomerFormationMasterTabsState.addressBean.mplacecd.toString().trim()==""){

                                if(isWasasa==true){
                                  _showAlert(Translations.of(context).text('woreda'), "Cannot be Empty");
                                }else{
                                  _showAlert(Translations.of(context).text('subDistrict'), "Cannot be Empty");
                                }
                                return;
                              }
                                else if(CustomerFormationMasterTabsState.addressBean.maddr1==null||CustomerFormationMasterTabsState.addressBean.maddr1.length<2){
                                  _showAlert(Translations.of(context).text("Adress 1 "),
                                      Translations.of(context).text("Must be more then 2 char"));
                                  return;
                              }
                                else if(isFullerTon==0 && (CustomerFormationMasterTabsState.addressBean.maddr2==null||CustomerFormationMasterTabsState.addressBean.maddr2.length<2)){
                                  _showAlert(Translations.of(context).text("adress 2"),
                                      Translations.of(context).text("must be more than 2 char"));
                                  return;
                                }
                                else if(isWasasa==false&& isFullerTon==0 && (CustomerFormationMasterTabsState.addressBean.mpinCd==null||CustomerFormationMasterTabsState.addressBean.mpinCd.toString().length!=6)){
                                  _showAlert(Translations.of(context).text("Pin "),
                                      Translations.of(context).text("Must be 6 char long"));
                                  return;
                                }
                                else if(isFullerTon==0 && CustomerFormationMasterTabsState.addressBean.maddrType==1&&(CustomerFormationMasterTabsState.addressBean.mNoOfRooms==null||CustomerFormationMasterTabsState.addressBean.mNoOfRooms==0)){
                                  _showAlert(Translations.of(context).text("Number Of Rooms"),
                                      Translations.of(context).text("Must Not be 0/Empty"));
                                  return;
                                }
<<<<<<< .mine
                                else if(isFullerTon==0 &&(CustomerFormationMasterTabsState.addressBean.mMobile==null||CustomerFormationMasterTabsState.addressBean.mMobile.length!=10)){
=======

                                else if(isFullerTon==0 &&(CustomerFormationMasterTabsState.addressBean.mMobile==null||CustomerFormationMasterTabsState.addressBean.mMobile.length!=10)){
>>>>>>> .r1143
                                  _showAlert(Translations.of(context).text("Mobile"),
                                      Translations.of(context).text("Must be 10 char long"));
                                  return;
<<<<<<< .mine
                                } else if(isFullerTon==1 &&( CustomerFormationMasterTabsState.addressBean.mMobile==null||CustomerFormationMasterTabsState.addressBean.mMobile.length!=11)){
                                _showAlert(Translations.of(context).text("Mobile"),
                                    Translations.of(context).text("Must be 11 char long"));
                                return;
                              }
=======
                                } else if(isFullerTon==1 &&( CustomerFormationMasterTabsState.addressBean.mMobile==null||CustomerFormationMasterTabsState.addressBean.mMobile.length!=11)){
                                _showAlert(Translations.of(context).text("Mobile"),
                                    Translations.of(context).text("Must be 11 char long"));
                                  return;
                                }
>>>>>>> .r1143
                              else
                                addToList();
                              }
                            })),
                  ],
                ),


                SizedBox(height: 30.0,)
              ],
            )));
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
          new ViewCustomerFormationAddressDetails(),
          fullscreenDialog: true,
        )).then((onValue) {
      setState(() {});
      //Scaffold.of(context).showSnackBar(SnackBar(content: Text("$onValue")));
    });
  }

  void addToList() {
   /* for (var items in globals.addressDetailsList) {
      print(items);
    }
*/
   bool tempVar = true;
if(CustomerFormationMasterTabsState.custListBean.addressDetails==null){
  CustomerFormationMasterTabsState.custListBean.addressDetails= new  List<AddressDetailsBean>();
}

print("CustomerFormationMasterTabsState.addressBean.maddrType "+CustomerFormationMasterTabsState.addressBean.maddrType.toString());
if(CustomerFormationMasterTabsState.custListBean.addressDetails.isEmpty && CustomerFormationMasterTabsState.addressBean.maddrType!=currentAddressCode){
  _showAlert("First Address Type" , "Should be current Address Type");
  return;
}
for(int i =0;i< CustomerFormationMasterTabsState.custListBean.addressDetails.length;i++){
  if(CustomerFormationMasterTabsState.addressBean.maddrType==CustomerFormationMasterTabsState.custListBean.addressDetails[i].maddrType){
    tempVar =false;
  }

}

if(tempVar==false){
    _showAlert("Address Type", "One Type of address can be added only once");
    return;

}else{
    CustomerFormationMasterTabsState.addressBean.trefno = CustomerFormationMasterTabsState.custListBean.trefno;
    if(CustomerFormationMasterTabsState.addressBean.mrefno==null) CustomerFormationMasterTabsState.addressBean.mrefno = 0;
    else CustomerFormationMasterTabsState.addressBean.mrefno = CustomerFormationMasterTabsState.custListBean.mrefno;

    CustomerFormationMasterTabsState.addressBean.maddressrefno = 0;

    CustomerFormationMasterTabsState.addressBean.taddrefno= CustomerFormationMasterTabsState.custListBean.addressDetails.length + 1;
    CustomerFormationMasterTabsState.addressBean.mgeolatd= geoLatitude;
    CustomerFormationMasterTabsState.addressBean.mgeologd=geoLongitude;


    CustomerFormationMasterTabsState.custListBean.addressDetails
        .add(CustomerFormationMasterTabsState.addressBean);

    print("adding");
    addressType = blankBean;

    setState(() {
      CustomerFormationMasterTabsState.addressBean = new AddressDetailsBean();
    });


    print("local");
}

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

  Future<void> setAddressInDesc() async{
    await AppDatabase.get().getAddressHererchyInDescOrder(CustomerFormationMasterTabsState.addressBean.mplacecd).then((onValue) async{
      CustomerFormationMasterTabsState.addressBean.mcountryCd = onValue.cuntryBean.cntryCd;
      CustomerFormationMasterTabsState.addressBean.mcountryname = onValue.cuntryBean.countryName;
      CustomerFormationMasterTabsState.addressBean.mState = onValue.stateDropDownBean.stateCd;
      CustomerFormationMasterTabsState.addressBean.mstatedesc  = onValue.stateDropDownBean.stateDesc;
      CustomerFormationMasterTabsState.addressBean.mDistCd = onValue.districtDropDownBean.distCd;
      CustomerFormationMasterTabsState.addressBean.mdistdesc = onValue.districtDropDownBean.distDesc;
      CustomerFormationMasterTabsState.addressBean.mplacecd= onValue.subDistrictDropDownBean.placeCd;
      CustomerFormationMasterTabsState.addressBean.mplacedesc = onValue.subDistrictDropDownBean.placeCdDesc;
      setState(() {
      });
    });
  }


  Future<bool> onSelectAddress(
      BuildContext context, String agrs1, String args2) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(agrs1),
        content: new Text(args2),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => setAddress(),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }

  setAddress() {
    //int addressListFrom = CustomerFormationMasterTabsState.custListBean.addressDetails.length-1;
    int addressListFrom = 0;
    CustomerFormationMasterTabsState.addressBean.maddr1= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].maddr1;
    CustomerFormationMasterTabsState.addressBean.maddr2= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].maddr2;
    CustomerFormationMasterTabsState.addressBean.maddr3= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].maddr3;
    CustomerFormationMasterTabsState.addressBean.mpinCd= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mpinCd;
    CustomerFormationMasterTabsState.addressBean.mtel1= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mtel1;
    CustomerFormationMasterTabsState.addressBean.mtel2= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mtel2;
    CustomerFormationMasterTabsState.addressBean.mcityCd= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mcityCd;
    CustomerFormationMasterTabsState.addressBean.mfax1= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mfax1;
    CustomerFormationMasterTabsState.addressBean.mfax2= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mfax2;


    CustomerFormationMasterTabsState.addressBean.mcountryCd= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mcountryCd;
    CustomerFormationMasterTabsState.addressBean.marea= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].marea;
    CustomerFormationMasterTabsState.addressBean.mHouseType= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mHouseType;
    CustomerFormationMasterTabsState.addressBean.mRntLeasAmt= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mRntLeasAmt;
    CustomerFormationMasterTabsState.addressBean.mRntLeasDep= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mRntLeasDep;
    CustomerFormationMasterTabsState.addressBean.mContLeasExp= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mContLeasExp;
    CustomerFormationMasterTabsState.addressBean.mRoofCond= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mRoofCond;


    CustomerFormationMasterTabsState.addressBean.mUtils= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mUtils;
    CustomerFormationMasterTabsState.addressBean.mAreaType= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mAreaType;
    CustomerFormationMasterTabsState.addressBean.mState= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mState;
    CustomerFormationMasterTabsState.addressBean.mYearStay= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mYearStay;
    CustomerFormationMasterTabsState.addressBean.mWardNo= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mWardNo;
    CustomerFormationMasterTabsState.addressBean.mMobile= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mMobile;
    CustomerFormationMasterTabsState.addressBean.mEmail= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mEmail;



    CustomerFormationMasterTabsState.addressBean.mDistCd= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mDistCd;
    CustomerFormationMasterTabsState.addressBean.mvillage= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mvillage;
    CustomerFormationMasterTabsState.addressBean.mSecMobile= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mSecMobile;
    CustomerFormationMasterTabsState.addressBean.mcountryname= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mcountryname;
    CustomerFormationMasterTabsState.addressBean.mstatedesc= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mstatedesc;
    CustomerFormationMasterTabsState.addressBean.mdistdesc= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mdistdesc;
    CustomerFormationMasterTabsState.addressBean.mplacecd= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mplacecd;

    CustomerFormationMasterTabsState.addressBean.mplacedesc= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mplacedesc;
    CustomerFormationMasterTabsState.addressBean.mareadesc= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mareadesc;
    //CustomerFormationMasterTabsState.addressBean.mownership= CustomerFormationMasterTabsState.custListBean.addressDetails[addressListFrom].mownership;

    addToList();
    Navigator.of(context).pop(true);
  }
}

