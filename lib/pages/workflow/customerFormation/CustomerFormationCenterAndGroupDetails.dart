import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/pages/workflow/FPSPages/AgentFingureCapture.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eco_mfi/Utilities/Helper.dart';
import 'package:eco_mfi/Utilities/OpenCamera.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/FullScreenDialogForGroupSelection.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFoundation.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/FullScreenDialogForCenterSelection.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_format/date_format.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';


var docListView=new List<PhotoViewGalleryPageOptions>();

class CustomerFormationCenterAndGroupDetails extends StatefulWidget {
  var cameras;
  CustomerListBean bean;
  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );

  CustomerFormationCenterAndGroupDetails(this.cameras, {Key key})
      : super(key: key);

  @override
  _CustomerFormationCenterAndGroupDetailsState createState() =>
      new _CustomerFormationCenterAndGroupDetailsState();
}

class _CustomerFormationCenterAndGroupDetailsState
    extends State<CustomerFormationCenterAndGroupDetails> {
  FullScreenDialogForCenterSelection _myCenterDialog =
  new FullScreenDialogForCenterSelection("");
  FullScreenDialogForGroupSelection _myGroupDialog =
  new FullScreenDialogForGroupSelection("");
  CenterDetailsBean centerBean = new CenterDetailsBean();
  LookupBeanData profileind;
  LookupBeanData custType;
  String custImage;
  static const JsonCodec JSON = const JsonCodec();
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  int ageValidationMinParams=0;
  int ageValidationMaxParams=0;


  DateTime selectedDate = DateTime.now();

  String tempDate = "----/--/--";
  String tempYear ;
  String tempDay ;
  String tempMonth;
  String tempDateH = "----/--/--";
  String tempYearH ;
  String tempDayH ;
  String tempMonthH;
  DateTime date;
  var formatter = new DateFormat('dd-MM-yyyy');
  //To Display member of croup field for selection
  bool isHideMemberGrp=false;


  String showCustCategory = "";
  File f;
  /*LookupBeanData custCategory;*/
  LookupBeanData custStatus;
  LookupBeanData dropOutReason;

  SystemParameterBean sysBean = new SystemParameterBean();
  File _image;

  Future getImage(imageNo) async {
    if (CustomerFormationMasterTabsState.custListBean.imageMaster == null) {
      CustomerFormationMasterTabsState.custListBean.imageMaster =
      new List<ImageBean>();
      for (int i = 0; i < 23; i++) {
        CustomerFormationMasterTabsState.custListBean.imageMaster
            .add(new ImageBean());
      }
    }
    var image = await ImagePicker.pickImage(

        source: ImageSource.camera);
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
 /*     ratioX: 1.0,
      ratioY: 1.5,
      maxWidth: 512,
      maxHeight: 512,*/

    );
    //String st = croppedFile.path;
    print("path" +
        CustomerFormationMasterTabsState.custListBean.imageMaster.length
            .toString());
    CustomerFormationMasterTabsState.custListBean.imageMaster[imageNo].imgString =
        croppedFile.path;
    CustomerFormationMasterTabsState.custListBean.imageMaster[imageNo].desc =
    "Customer Picture";


   f =   File(croppedFile.path);
    print("image picture is "+CustomerFormationMasterTabsState
        .custListBean.imageMaster[0].imgString);
    print("Custimage is  custImage");
    setState(() {
      _image = croppedFile;
    });
  }


  Future getImageFromGallery(int imageNo) async {
    if (CustomerFormationMasterTabsState.custListBean.imageMaster == null) {
      CustomerFormationMasterTabsState.custListBean.imageMaster =
      new List<ImageBean>();
      for (int i = 0; i < 23; i++) {
        CustomerFormationMasterTabsState.custListBean.imageMaster
            .add(new ImageBean());
      }
    }
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery);

    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,

    );
    String st = croppedFile.path;
    print("path" +
        CustomerFormationMasterTabsState.custListBean.imageMaster.length
            .toString());
    CustomerFormationMasterTabsState.custListBean.imageMaster[imageNo].imgString =
        croppedFile.path;
    CustomerFormationMasterTabsState.custListBean.imageMaster[imageNo].desc =
    "Customer Picture";

    setState(() {
      _image = croppedFile;
    });
  }
    /*Future showImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {

    });
    String st = image.path;
    print("path"+st.toString());
    CustomerFormationMasterTabsState.custListBean.imageMaster[0].imgPath= image.path;

    setState(() {
      return _image = image;
    });
  }*/

    //final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

    SharedPreferences prefs;
    String loginTime;
    int usrGrpCode = 0;
    String username;
    int branch = 0;
    String usrRole;
    ImageBean imgBean = new ImageBean();
    String _base64;
    int isBiometricNeeded = 0;

  FocusNode monthFocus;
  FocusNode yearFocus;
  FocusNode monthFocusH;
  FocusNode yearFocusH;
  bool isEnabled = true;

  @override
  void initState() {
    super.initState();
    imageCache.clear();
    monthFocus = new FocusNode();
    yearFocus = new FocusNode();
    if (mounted) {
      getSessionVariables();
    }

      if(!CustomerFormationMasterTabsState.applicantDob.contains("_")){
        try{

          String tempApplicantdob = CustomerFormationMasterTabsState.applicantDob;
          //print(tempApplicantdob.substring(6)+"-"+tempApplicantdob.substring(3,5)+"-"+tempApplicantdob.substring(0,2));
          DateTime  formattedDate =  DateTime.parse(tempApplicantdob.substring(6)+"-"+tempApplicantdob.substring(3,5)+"-"+tempApplicantdob.substring(0,2));
          //print(formattedDate);
          tempDay = formattedDate.day.toString();
          //print(tempDay);
          tempMonth = formattedDate.month.toString();
          //print(tempMonth);
          tempYear = formattedDate.year.toString();
          //print(tempYear);
          setState(() {

          });

        }catch(e){

          print("Exception Occupred");
        }
      }
      //Setting Cust status For new Customer
      if (CustomerFormationMasterTabsState.custListBean == null ||
          CustomerFormationMasterTabsState.custListBean.mcustno == null ||
          CustomerFormationMasterTabsState.custListBean.mcustno == 0) {
        CustomerFormationMasterTabsState.custListBean.mcuststatus = 3;
      }
      List tempDropDownValues = new List();
      //Setting Lookup values on load
      tempDropDownValues
          .add(CustomerFormationMasterTabsState.custListBean.mprofileind);
      tempDropDownValues
          .add(CustomerFormationMasterTabsState.custListBean.mcusttype);
      tempDropDownValues
          .add(CustomerFormationMasterTabsState.custListBean.mcuststatus);
      tempDropDownValues
          .add(CustomerFormationMasterTabsState.custListBean.mdropoutreason);
      print(CustomerFormationMasterTabsState.custListBean.mcusttype);
      for (int k = 0;
      k < globals.dropdownCaptionsValuesProfileDetails.length;
      k++) {
        for (int i = 0;
        i < globals.dropdownCaptionsValuesProfileDetails[k].length;
        i++) {
          print("k and i is $k $i");
          print(globals.dropdownCaptionsValuesProfileDetails[k][i].mcode.length);

          try {
            if (globals.dropdownCaptionsValuesProfileDetails[k][i].mcode
                .toString() ==
                tempDropDownValues[k].toString().trim()) {
              print("matched $k");
              setValue(k, globals.dropdownCaptionsValuesProfileDetails[k][i]);
            }
          } catch (_) {
            print("Exception in dropdown");
          }
        }
      }

      //Setting Showing Customer Category
      if (CustomerFormationMasterTabsState.custListBean.mcustcategory != null ||
          CustomerFormationMasterTabsState.custListBean.mcustcategory != 0) {
        setShowCustCategory(
            CustomerFormationMasterTabsState.custListBean.mcustcategory);
      }

      //Setting application date
      if (globals.applicationDate == null)
        globals.applicationDate = DateTime.now();

      if (CustomerFormationMasterTabsState.custListBean.mIsMbrGrp == null) {
        if (CustomerFormationMasterTabsState.custListBean.mgroupcd != null) {
          CustomerFormationMasterTabsState.custListBean.mIsMbrGrp = 0;
          globals.isMemberOfGroup = true;
        }
      } else if (CustomerFormationMasterTabsState.custListBean.mIsMbrGrp == 1) {
        globals.isMemberOfGroup = false;
        print(
            "Value of ${CustomerFormationMasterTabsState.custListBean.mcusttype}");
      }
      setState(() {});
    }

    showDropDown(LookupBeanData selectedObj, int no) {
      if (selectedObj.mcodedesc.isEmpty) {
        print("inside  code Desc is null");
        switch (no) {
          case 0:
            profileind = blankBean;
            CustomerFormationMasterTabsState.custListBean.mprofileind =
                blankBean.mcode;
            break;
          case 1:
            custType = blankBean;
            CustomerFormationMasterTabsState.custListBean.mcusttype =
                blankBean.mcode;
            break;
          case 2:
            custStatus = blankBean;
            CustomerFormationMasterTabsState.custListBean.mcuststatus =
                int.parse(blankBean.mcode);
            break;
          case 3:
            dropOutReason = blankBean;
            CustomerFormationMasterTabsState.custListBean.mdropoutreason =
                blankBean.mcode;
            break;
          default:
            break;
        }
        setState(() {});
      } else {
        for (int k = 0;
        k < globals.dropdownCaptionsValuesProfileDetails[no].length;
        k++) {
          if (globals.dropdownCaptionsValuesProfileDetails[no][k].mcodedesc ==
              selectedObj.mcodedesc) {
            setValue(no, globals.dropdownCaptionsValuesProfileDetails[no][k]);
          }
        }
      }
    }

    setValue(int no, LookupBeanData value) {
      setState(() {
        print("coming here");
        switch (no) {
          case 0:
            profileind = value;
            CustomerFormationMasterTabsState.custListBean.mprofileind =
                value.mcode;
            break;
          case 1:
            custType = value;
            CustomerFormationMasterTabsState.custListBean.mcusttype = value.mcode;
            print(
                "setting Custtype ${CustomerFormationMasterTabsState.custListBean.mcusttype}");
            break;
          case 2:
            custStatus = value;
            print(custStatus);
            print("Value Settled ${value.mcode}");
            CustomerFormationMasterTabsState.custListBean.mcuststatus =
                int.parse(value.mcode);
            break;
          case 3:
            dropOutReason = value;
            CustomerFormationMasterTabsState.custListBean.mdropoutreason = value.mcode;
            print(
                "setting DropOut Reason ${CustomerFormationMasterTabsState.custListBean.mdropoutreason}");
            break;
          default:
            break;
        }
      });
    }

    /* _changed(String filePath, String str) {
    if (filePath != null && !(filePath == "")) {
      globals.imageVisibilityDetalsTagCustomer = true;
      globals.imageFilePathGlobalCustomerprofilePic = filePath;
      imgBean.imgString = filePath;
      imgBean.imgSubType = 'customerPicture';
      imgBean.imgType = str;
      globals.listImgBean.add(imgBean);
      //globals.listImgBean.insert(0,imgBean);
    }
  }*/

    Widget otherLoan() => CustomerFormationCenterAndGroupDetails._get(new Row(
      children: _makeRadios(2, globals.radioCaptionValuesIsMemberOfGroup, 0),
      mainAxisAlignment: MainAxisAlignment.spaceAround,
    ));

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
              groupValue: CustomerFormationMasterTabsState.custListBean.mIsMbrGrp,
              onChanged: (selection) {

                if (sysBean.mcodevalue != null &&
                    sysBean.mcodevalue.toUpperCase() == 'N') {
                  return null;
                }

                return _onRadioSelected(selection, position);
              },
              activeColor: Color(0xff07426A),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
        ));
      }
      return radios;
    }

    _onRadioSelected(int selection, int position) {
      setState(() => globals.isMemberOfGroupList[position] = selection);
      CustomerFormationMasterTabsState.custListBean.mIsMbrGrp = selection;
      if (position == 0) {
        globals.memberOfGroup =
        globals.radioCaptionValuesIsMemberOfGroup[selection];
        if (globals.memberOfGroup == 'Yes') {
          globals.isMemberOfGroup = true;
          print("Thats why getting null");
          CustomerFormationMasterTabsState.custListBean.mcusttype = null;
          custType = null;
        } else {
          globals.isMemberOfGroup = false;

          CustomerFormationMasterTabsState.custListBean.mgroupcd = null;
          CustomerFormationMasterTabsState.custListBean.mcenterid = null;
          profileind = null;
          CustomerFormationMasterTabsState.custListBean.mcustcategory = null;
          centerBean = null;
          //groupBean = null;
          CustomerFormationMasterTabsState.custListBean.mgroupname = null;
          CustomerFormationMasterTabsState.custListBean.mcentername = null;
        }
      }
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

    Future<Null> getSessionVariables() async {
      prefs = await SharedPreferences.getInstance();

<<<<<<< .mine
=======

>>>>>>> .r1143
      try{
        setState(() {
          CustomerFormationMasterTabsState.custListBean.mlbrcode =
              prefs.get(TablesColumnFile.musrbrcode);
          username = prefs.getString(TablesColumnFile.usrCode);
          usrRole = prefs.getString(TablesColumnFile.usrDesignation);
          usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
          loginTime = prefs.getString(TablesColumnFile.LoginTime);
          // CustomerFormationMasterTabsState.custListBean.mlbrcode = branch;
          globals.agentUserName = username;
          isBiometricNeeded = prefs.getInt(TablesColumnFile.ISBIOMETRICNEEDED);
        });
      }catch(_){

      }

<<<<<<< .mine
      sysBean = await AppDatabase.get().getSystemParameter('11', 0);

      List strIlo;
      if(prefs.getString(TablesColumnFile.ISINDONUSERCD) !=null) {
        strIlo = prefs.getString(TablesColumnFile.ISINDONUSERCD).split(",");
      }

      print("strIlo ${strIlo}");
      List strGlo;
      if(prefs.getString(TablesColumnFile.ISGLOONUSERCD) !=null) {
        strGlo = prefs.getString(TablesColumnFile.ISGLOONUSERCD).split(",");
      }

      if (sysBean.mcodevalue != null &&  sysBean.mcodevalue.trim().toUpperCase() == 'Y') {

        if(strIlo !=null &&  strIlo.contains(usrGrpCode.toString())){
          CustomerFormationMasterTabsState.custListBean.mIsMbrGrp=1;
          globals.isMemberOfGroup = false;
          isHideMemberGrp=true;
        }else if(strGlo !=null &&  strGlo.contains(usrGrpCode.toString())){
          CustomerFormationMasterTabsState.custListBean.mIsMbrGrp=0;
          globals.isMemberOfGroup = true;
          isHideMemberGrp=true;
        }
      }else{
        globals.isMemberOfGroup = false;
        isHideMemberGrp=true;
      }


=======
      sysBean = await AppDatabase.get().getSystemParameter('11', 0);
      List strIlo;
      if(prefs.getString(TablesColumnFile.ISINDONUSERCD) !=null) {
        strIlo = prefs.getString(TablesColumnFile.ISINDONUSERCD).split(",");
      }
      print("strIlo ${strIlo}");
      List strGlo;
      if(prefs.getString(TablesColumnFile.ISGLOONUSERCD) !=null) {
        strGlo = prefs.getString(TablesColumnFile.ISGLOONUSERCD).split(",");
      }
      if (sysBean.mcodevalue != null &&  sysBean.mcodevalue.trim().toUpperCase() == 'Y') {
        if(strIlo !=null &&  strIlo.contains(usrGrpCode.toString())){
          CustomerFormationMasterTabsState.custListBean.mIsMbrGrp=1;
        globals.isMemberOfGroup = false;
          isHideMemberGrp=true;
        }else if(strGlo !=null &&  strGlo.contains(usrGrpCode.toString())){
          CustomerFormationMasterTabsState.custListBean.mIsMbrGrp=0;
          globals.isMemberOfGroup = true;
          isHideMemberGrp=true;
        }
      }else{
          globals.isMemberOfGroup = false;
        isHideMemberGrp=true;
      }

    try {
      ageValidationMinParams = prefs.getInt(TablesColumnFile.AGEVALIDATIONMIN);
    }catch(_){}
    try {
      ageValidationMaxParams = prefs.getInt(TablesColumnFile.AGEVALIDATIONMAX);
    }catch(_){}

>>>>>>> .r1143
    }

    LookupBeanData blankBean =
    new LookupBeanData(mcodedesc: "", mcode: "", mcodetype: 0);
    List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
      //print("caption value : " + globals.dropdownCaptionsPersonalInfo[no]);

      List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
      List<LookupBeanData> mapData = List<LookupBeanData>();
      LookupBeanData bean = new LookupBeanData();
      bean.mcodedesc = "";
      mapData.add(blankBean);
      for (int k = 0;
      k < globals.dropdownCaptionsValuesProfileDetails[no].length;
      k++) {
        mapData.add(globals.dropdownCaptionsValuesProfileDetails[no][k]);
      }
      _dropDownMenuItems1 = mapData.map((value) {
        //print("data here is of  dropdownwale biayajai " + value.mcodedesc);
        return new DropdownMenuItem<LookupBeanData>(
          value: value,
          child: new Text(
            value.mcodedesc,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
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


      return Card(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            new ListTile(
                leading: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(Translations.of(context).text("BRANCH"),
                        style: TextStyle(color: Color(0xff795548))),
                    new Text(
                        CustomerFormationMasterTabsState.custListBean.mlbrcode
                            .toString(),
                        style: TextStyle(color: Color(0xff12D6F4)))
                  ],
                ),
                trailing: new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      Translations.of(context).text("custNumOfTab"),
                      style: TextStyle(color: Color(0xff795548)),
                    ),
                    new Text(
                      "${CustomerFormationMasterTabsState.custListBean.trefno}",
                      style: TextStyle(color: Color(0xff12D6F4)),
                    ),
                  ],
                )
              // trailing: new Text("Customer Number of Tab : " + "123456789"),


            ),


          SizedBox(height: 10.0),
          new Card(
            elevation: 5.0,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 4.0),
                /*    new Text(
                    Translations.of(context).text("customerPicture"),
                    textAlign: TextAlign.center,
                  ),*/

                /*new Container(
                     // color: Constant.mandatoryColor,
                      decoration: new BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      height: 250.0,
                      child: new Column(
                        children: <Widget>[
                          new ListTile(
                            title: new ListTile(
                              title: CustomerFormationMasterTabsState
                                  .custListBean.imageMaster !=
                                  null &&
                                  CustomerFormationMasterTabsState
                                      .custListBean
                                      .imageMaster[0]
                                      .imgString !=
                                      null &&
                                  CustomerFormationMasterTabsState
                                      .custListBean.imageMaster !=
                                      null &&
                                  CustomerFormationMasterTabsState
                                      .custListBean
                                      .imageMaster[0]
                                      .imgString !=
                                      ""
                                  ? new Image.file(
                                File(CustomerFormationMasterTabsState
                                    .custListBean.imageMaster[0].imgString),
                                height: 200.0,
                                width: 200.0,
                              )
                           *//* Container(
                                height: 200.0,
                                width: 200.0,
                                child: PhotoView(
                                  imageProvider: MemoryImage(base64Decode(custImage))
                                )
                            )*//*
                                  : new Image(
                                  image:
                                  new AssetImage("assets/AddImage.png"),
                                  width: 100,
                                  height: 200.0),
                              subtitle: new Text(
                                Translations.of(context)
                                    .text("Click_Here_To_Take_A_Picture"),
                                textAlign: TextAlign.center,
                              ),
                              onTap: () {
                              //getImage();
                              _PickImage(0);
                                *//*_navigateAndDisplaySelection(
                                  context, 'customer picture')*//*
                                ;
                              },
                            ),
                          ),
                        ],
                      )),*/

                new Center(
                  child: new Stack(
                    children: <Widget>[
                      getCircleContainer(),

                      /*new Positioned(
                          child:

                          top: 200.0,
                         // left: 130.0,
                          right: 30.0,
                        ),*/


                      new Positioned(
                        child: new GestureDetector(
                          onTap: () {
                            _PickImage(0);
                          },
                          child:IconButton(icon: new Icon(Icons.camera_alt, color: Color(0xff07426A),size: 80.0,),
                          /*onPressed: () {

                          }*/
                      ),
                ),
                        top: 200.0,
                        left: 230.0,
                      ),
                    ],
                  ),
                ),

                Container(
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          height: 80.0, width: 60.00),
                    )),

                new Container(
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: commentWidgets)),
              ],
            ),
          ),

          isBiometricNeeded==0?new Container(): Card(
            child: Container(
                child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        height: 150.0, width: 90.00),
                    // for positioning of icon of scanner
                    child: FlatButton(
                      onPressed: () async {
                        prefs = await SharedPreferences.getInstance();
                        prefs.setString(TablesColumnFile.userType, "CUSTOMER");
                        Navigator.push(context, SlideRightRoute(page: new AgentFingureCapture())).then((onVal) {
                          print("fpsdataaaa $onVal");

                        });
                      },
                      child:
                      Image.asset("assets/fpsImages/security_bnr_fp.gif",width: 150.0,height: 200.0),))),

          ),

            Container(
              child: isHideMemberGrp
                  ? null
                  : new Table(children: [
                new TableRow(
                    decoration: new BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer(
                          globals.radioCaptionCenterGroupDetails[0]),
                      otherLoan(),
                    ]),
              ]),
            ),
            SizedBox(height: 16.0),
            globals.isMemberOfGroup
                ? Card(
              color: Constant.mandatoryColor,
              child: new ListTile(
                title:
                new Text(Translations.of(context).text("centerNameNo")),
                subtitle: CustomerFormationMasterTabsState
                    .custListBean.mcentername ==
                    null ||
                    CustomerFormationMasterTabsState
                        .custListBean.mcentername ==
                        "null"
                    ? new Text("")
                    : new Text(
                    "${CustomerFormationMasterTabsState.custListBean.mcentername.trim()} / ${CustomerFormationMasterTabsState.custListBean.mcenterid}"),
                onTap: () async {
                  centerBean = await Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (BuildContext context) => _myCenterDialog,
                        fullscreenDialog: true,
                      ));
                  if (centerBean != null) {
                    CustomerFormationMasterTabsState
                        .custListBean.mcentername = centerBean.mcentername;
                    if (centerBean.mCenterId != null)
                      CustomerFormationMasterTabsState
                          .custListBean.mcenterid = centerBean.mCenterId;
                    else
                      CustomerFormationMasterTabsState
                          .custListBean.mcenterid = 0;

                    if (centerBean.mrefno != null)
                      CustomerFormationMasterTabsState.custListBean.mrefcenterid=centerBean.mrefno;
                    else
                      CustomerFormationMasterTabsState.custListBean.mrefcenterid=0;

                    if (centerBean.trefno != null)
                      CustomerFormationMasterTabsState.custListBean.trefcenterid=centerBean.trefno;
                    else
                      CustomerFormationMasterTabsState.custListBean.trefcenterid=0;
                  }

                  setState(() {});
                },
              ),
            )
                : Container(),
            SizedBox(height: 16.0),
            globals.isMemberOfGroup
                ? Card(
              color: Constant.mandatoryColor,
              child: new ListTile(
                title: new Text(
                    Translations.of(context).text("Group_Name/No")),
                subtitle: CustomerFormationMasterTabsState
                    .custListBean.mgroupname ==
                    null ||
                    CustomerFormationMasterTabsState
                        .custListBean.mgroupname ==
                        "null"
                    ? new Text("")
                    : new Text(
                    "${CustomerFormationMasterTabsState.custListBean.mgroupname.trim()} / ${CustomerFormationMasterTabsState.custListBean.mgroupcd}"),
                onTap: () async {
                  GroupFoundationBean bean = await Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        _myGroupDialog,
                        fullscreenDialog: true,
                      ))
                  ;

                  if (centerBean != null) {
                    CustomerFormationMasterTabsState.custListBean.mgroupcd =
                        bean.mgroupid;
                    CustomerFormationMasterTabsState
                        .custListBean.mgroupname = bean.mgroupname;
                    CustomerFormationMasterTabsState.custListBean
                        .mcustcategory = int.parse(bean.mgrouptype.trim());
                    await setShowCustCategory(
                        CustomerFormationMasterTabsState
                            .custListBean.mcustcategory);
                  }

                  setState(() {});
                },
              ),
            )
                : Container(),

            //------------Role of member
            globals.isMemberOfGroup
                ? Container(
              color: Constant.mandatoryColor,
              child: new DropdownButtonFormField(
                value: profileind,
                items: generateDropDown(0),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 0);
                },
                validator: (args) {
                  print(args);
                },
                //  isExpanded: true,
                //hint:Text("Select"),
                decoration: InputDecoration(
                    labelText:
                    Translations.of(context).text("roleOfMember")),
                // style: TextStyle(color: Colors.grey),
              ),
            )
                : Container(),

            //-----------customer Type

            globals.isMemberOfGroup == false
                ? Container(
              child: new DropdownButtonFormField(
                value: custType,
                items: generateDropDown(1),
                onChanged: (LookupBeanData newValue) {
                  print("for institution ${newValue.mcode}");
                  showDropDown(newValue, 1);
                  //to disable gender and spouse name etc if cust type = institution
                  if (newValue.mcode == "INS") {
                    //setting for cust category
                    CustomerFormationMasterTabsState
                        .custListBean.mcustcategory = 5;

                    //variables on personal info page
                    CustomerFormationMasterTabsState.custListBean.mgender =
                    null;
                    CustomerFormationMasterTabsState
                        .custListBean.mhusbandname = null;
                    CustomerFormationMasterTabsState
                        .custListBean.mrelegion = null;
                    CustomerFormationMasterTabsState
                        .custListBean.mmaritialStatus = null;
                    CustomerFormationMasterTabsState.custListBean.mhusdob =
                    null;

                    //variables on center page
                    CustomerFormationMasterTabsState
                        .custListBean.mcustcategory = null;
                    CustomerFormationMasterTabsState.custListBean.mgroupcd =
                    null;
                    CustomerFormationMasterTabsState
                        .custListBean.mcenterid = null;
                  } else if (newValue.mcode == "IND") {
                    CustomerFormationMasterTabsState
                        .custListBean.mcustcategory = 5;
                  }
                },
                validator: (args) {
                  print(args);
                },
                //  isExpanded: true,
                //hint:Text("Select"),
                decoration: InputDecoration(
                    labelText: globals.dropdownCaptionsProfileDetails[1]),
                // style: TextStyle(color: Colors.grey),
              ),
            )
                : Container(),

            //------------Group Type

            globals.isMemberOfGroup
                ? Card(
              color: Constant.mandatoryColor,
              child: new ListTile(
                title: new Text(Translations.of(context).text("grpType")),
                subtitle:
                showCustCategory == null || showCustCategory == "null"
                    ? new Text("")
                    : new Text("${showCustCategory}"),
              ),
            )
                : Container(),

            SizedBox(height: 16.0),

            //-----------Customer Status
            Container(
              child: new DropdownButtonFormField(
                value: custStatus,
                items: generateDropDown(2),
                onChanged:
                /*CustomerFormationMasterTabsState.custListBean==null||
                  CustomerFormationMasterTabsState.custListBean.mcustno==0?null:*/
                    (LookupBeanData newValue) {
                  if (CustomerFormationMasterTabsState.custListBean.mcustno !=
                      0 &&
                      CustomerFormationMasterTabsState.custListBean.mcustno !=
                          null) showDropDown(newValue, 2);
                },
                validator: (args) {
                  print(args);
                },
                //  isExpanded: true,
                //hint:Text("Select"),
                decoration: InputDecoration(
                    labelText: globals.dropdownCaptionsProfileDetails[2]),
                // style: TextStyle(color: Colors.grey),
              ),
            ),
            Container(
              child: new DropdownButtonFormField(
                value: dropOutReason,
                items: generateDropDown(3),
                onChanged:
                    (LookupBeanData newValue) {

                  if(CustomerFormationMasterTabsState.custListBean.mcuststatus == 2)
                    showDropDown(newValue, 3);
                },
                validator: (args) {
                  print(args);
                },
                decoration: InputDecoration(
                    labelText: Translations.of(context).text("drpOutRsn")),
                // style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 10.0),

            new Form(
                key: _formKey,

                onWillPop: () {
                  return Future(() => true);
                },
                onChanged: () {
                  final FormState form = _formKey.currentState;
                  form.save();
                },
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0,),
                    Container(
                      decoration: BoxDecoration(color: Constant.mandatoryColor),
                      child: new Row(

                        children: <Widget>[

                          isEnabled==true?Text(Constant.applicantDOB):Text(Constant.institutionEstablishmntDate)

                        ],
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
                                    hintText: "DD"
                                ),
                                inputFormatters: [
                                  new LengthLimitingTextInputFormatter(2),
                                  globals.onlyIntNumber
                                ],
                                controller: tempDay == null?null:new TextEditingController(text: tempDay),
                                keyboardType: TextInputType.numberWithOptions(),

                                onChanged: (val){

                                  if(val!="0"){
                                    tempDay = val;


                                    if(int.parse(val)<=31&&int.parse(val)>0){



                                      if(val.length==2){
                                        CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(0, 2, val);
                                        FocusScope.of(context).requestFocus(monthFocus);
                                      }
                                      else{
                                        CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(0, 2, "0"+val);
                                      }


                                    }
                                    else {
                                      setState(() {
                                        tempDay ="";
                                      });

                                    }


                                  }
                                }

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
                                hintText: "MM",


                              ),

                              keyboardType: TextInputType.numberWithOptions(),
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(2),
                                globals.onlyIntNumber
                              ],
                              focusNode: monthFocus,
                              controller: tempMonth == null?null:new TextEditingController(text: tempMonth),
                              onChanged: (val){
                                if(val!="0"){
                                  tempMonth = val;
                                  if(int.parse(val)<=12&&int.parse(val)>0){

                                    if(val.length==2){
                                      CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(3, 5, val);

                                      FocusScope.of(context).requestFocus(yearFocus);
                                    }
                                    else{
                                      CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(3, 5, "0"+val);
                                    }
                                  }
                                  else {
                                    setState(() {
                                      tempMonth ="";
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
                                hintText: "YYYY",

                              ),

                              keyboardType: TextInputType.numberWithOptions(),
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(4),
                                globals.onlyIntNumber
                              ],


                              focusNode: yearFocus,
                              controller: tempYear == null?null:new TextEditingController(text: tempYear),
                              onChanged: (val){
                                tempYear = val;
                                if(val.length==4) CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(6, 10,val);

                              },
                            ),)
                          ,

                          SizedBox(
                            width: 50.0,
                          ),

                          IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                            _selectDate(context);
                          } )
                        ],


                      ),

                    ),
                    SizedBox(height: 20.0,),
                    Container(
                        decoration: BoxDecoration(color: Constant.mandatoryColor),
                        child: new Stack(
                          alignment: const Alignment(1.02, 0.0),
                          children: <Widget>[
                            new TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  hintText: "National ID",
                                  labelText: "National ID",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, decorationColor: Colors.grey),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.green,
                                      )),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      )),
                                  contentPadding: EdgeInsets.all(20.0),
                                  fillColor: Colors.red,
                                ),
                                controller: CustomerFormationMasterTabsState
                                    .custListBean.mpannodesc ==
                                    null
                                    ? TextEditingController(text: "")
                                    : TextEditingController(
                                    text: CustomerFormationMasterTabsState
                                        .custListBean.mpannodesc
                                        .toString()),
                                /*focusNode: _focusNode,*/
                                onSaved: (val) {
                                  if (val == null || val == "") {
                                  } else {
                                    try {
                                      globals.isDedupDone= false;
                                      CustomerFormationMasterTabsState
                                          .custListBean.mpannodesc = val;
                                    } catch (e) {
                                      print("Exception ");
                                    }
                                  }
                                }),
                            new RaisedButton(
                                color: Color(0xff01579b),
                                elevation: 20.0,
                                child: new Text(
                                  "Dedup",
                                  style: TextStyle(color: Colors.white),
                                ),
                                padding: EdgeInsets.only(bottom: 0.0),
                                onPressed: () async {

                                  await _DedupOnNationalID();
                                }),
                          ],
                        )),


                  ],
                )
            ),
            //---Applicant Date
            Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text("appDt")),
                subtitle: CustomerFormationMasterTabsState
                    .custListBean.mcreateddt ==
                    null ||
                    CustomerFormationMasterTabsState
                        .custListBean.mcreateddt ==
                        ""
                    ? new Text("")
                    : new Text(
                    "${CustomerFormationMasterTabsState.custListBean.mcreateddt}"),
              ),
            ),

            SizedBox(height: 16.0),
            Card(
              child: new ListTile(
                title:
                new Text(Translations.of(context).text("custNumFrmCoreSys")),
                subtitle: new Text(
                    CustomerFormationMasterTabsState.custListBean.mcustno == 0 ||
                        CustomerFormationMasterTabsState
                            .custListBean.mcustno ==
                            null
                        ? Translations.of(context).text("syncToGetFrmCore")
                        : CustomerFormationMasterTabsState.custListBean.mcustno
                        .toString()),
              ),
            ),
          ],
        ),
      );
    }

    Future<Null> setShowCustCategory(int custCategory) async {
      for (int i = 0; i < globals.mGroupType.length; i++) {
        if (globals.mGroupType[i].mcode.toString().trim() ==
            CustomerFormationMasterTabsState.custListBean.mcustcategory
                .toString()
                .trim()) {
          showCustCategory = globals.mGroupType[i].mcodedesc;
        }
      }
    }




    Future<void> _PickImage(int imageNo) async {
      return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title:new Text(Translations.of(context).text("Choose Image From"),style:TextStyle(fontWeight:FontWeight.bold)  ,),
                content:new SingleChildScrollView(
                  padding: const EdgeInsets.all(12.0),
                  child:new Column(
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly
                        ,children: <Widget>[

                        new GestureDetector(
                          child: new Image(
                            image: new AssetImage("assets/galleries.png"),
                            alignment: Alignment.center,
                            height: 100.0,
                            width: 100.5,
                          ),

                          onTap:(){


                            Navigator.of(context).pop();
                            getImageFromGallery(imageNo);

                          } ,

                        ),

                        SizedBox(width: 10.0,),



                        GestureDetector(
                          child: new ClipRect(

                            child: new Image(
                              image: new AssetImage("assets/cameras.png"),
                              alignment: Alignment.center,
                              height: 100.0,
                              width: 100.5,
                            ),
                          ),

                        onTap: (){
                          Navigator.of(context).pop();
                          getImage(imageNo);

                        },
                      ),

                      SizedBox(width: 10.0,),



                      /*       GestureDetector(
                          child: new ClipRect(

                            child: new Image(
                              image: new AssetImage("assets/cameras.png"),
                              alignment: Alignment.center,
                              height: 100.0,
                              width: 100.5,
                            ),
                          ),

                          onTap: (){



                          },
                        )*/


                      ],

                      )


                    ],
                  ) ,
                )

            );
          });
    }


  _DedupOnNationalID() async {

    try {
      CustomerFormationMasterTabsState.custListBean.mdob = DateTime.parse(CustomerFormationMasterTabsState.applicantDob.substring(6) +
          "-" +
          CustomerFormationMasterTabsState.applicantDob.substring(3, 5) +
          "-" +
          CustomerFormationMasterTabsState.applicantDob.substring(0, 2));
    } catch (e) {
        _showAlert(Translations.of(context).text("applicantDOB"), Translations.of(context).text("itIsMand"),1);
        return;
      }

    try {
      CustomerFormationMasterTabsState.custListBean.mdob = DateTime.parse(CustomerFormationMasterTabsState.applicantDob.substring(6) +
          "-" +
          CustomerFormationMasterTabsState.applicantDob.substring(3, 5) +
          "-" +
          CustomerFormationMasterTabsState.applicantDob.substring(0, 2));
      int age=0;
      try {
        age = DateTime
            .now()
            .year - CustomerFormationMasterTabsState.custListBean.mdob.year;

        if(age < ageValidationMinParams){
          _showAlert(Translations.of(context).text("minDob"),
              Translations.of(context).text("mandtory"),1);

          return ;
        }else if(age > ageValidationMaxParams){
          _showAlert(Translations.of(context).text("maxDob"),
              Translations.of(context).text("mandtory"),1);

          return;
        }
      }catch(_){}
    } catch (e) {

        _showAlert(Translations.of(context).text("applicantDOB"),
            Translations.of(context).text("itIsMand"),1);
      return ;
    }

    if (CustomerFormationMasterTabsState.custListBean.mdob == ""|| CustomerFormationMasterTabsState.custListBean.mdob == null||
        CustomerFormationMasterTabsState.custListBean.mdob.isAfter(DateTime.now().subtract(Duration(days: 1)))
    ) {
        _showAlert(
            Translations.of(context).text("dateOfBirth"),
            Translations.of(context).text("Date Of Birth not Correct"),1);

      return ;
    }


    if (CustomerFormationMasterTabsState.custListBean.mpannodesc ==
        null ||
        CustomerFormationMasterTabsState.custListBean.mpannodesc == '' || CustomerFormationMasterTabsState.custListBean.mpannodesc.length<6) {
      _showAlert(
<<<<<<< .mine
          "Please fill National ID And Atlest 6 Digit of NRC", "This field is Mandatory for Dedup");
=======
          "Please fill National ID And atlest 6 Digit of NRC", "This field is Mandatory for Dedup",1);
>>>>>>> .r1143
    } else{
      bool isNetworkAvailable;
      bool isNetworkAvailablegoogle;
      isNetworkAvailable = await Utility.checkIntCon();

      //TODO check data in offline case for dedup if present them break here otherwise go online

      await AppDatabase.get().getDedupCustomerIfPresent(CustomerFormationMasterTabsState.custListBean.mpannodesc, CustomerFormationMasterTabsState.custListBean.mdob).then((onValue) async{
        if(onValue!=null &&(CustomerFormationMasterTabsState.custListBean.mcustno == null || CustomerFormationMasterTabsState.custListBean.mcustno == 0
            || CustomerFormationMasterTabsState.custListBean.mcustno != onValue.mcustno)){


          String message = "${onValue.mlongname.toString()} is already present with Customer No ${onValue.mcustno.toString()} , Customer Belongs to User : ${onValue.mcreatedby!=null && onValue.mcreatedby!='null'?onValue.mcreatedby:""}";
          _showAlert("Cannot create customer with this id", message,1);
          globals.isDedupDone= true;
          isCustFoundInDedup=true;
          return;
        }else{
          if (isNetworkAvailable) {

            _ShowCircInd();
            getMiddleWareData();

          } else {
            globals.isDedupDone= true;
            _showAlert("Please check your Network", "This Should only be done Online",1);
          }
        }
      });


    }
  }

  Future<void> _showAlert(arg, error,forwhat) async {
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
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                if(forwhat==0){
                  Navigator.of(context).pop();
                }


              },
            ),
          ],
        );
      },
    );
  }

 /* getMiddleWareData() async {
    Utility obj = new Utility();
    final _headers = {'Content-Type': 'application/json'};
    var urlGetCustomerDetails = "customerData/getCustomerDedup/";

    //try {
      String json = _toJson();
      String bodyValue = await NetworkUtil.callPostService(
          json.toString(),
          Constant.apiURL.toString() + urlGetCustomerDetails.toString(),
          _headers);
      if (bodyValue == "404") {
        return null;
      } else {
        print(bodyValue);
        //final parsed = JSON.decode(bodyValue).cast<String, dynamic>();
        Map<String, dynamic> map = JSON.decode(bodyValue);
        if(map==null){
          _showAlert("Customer Not Present With ID", "");
        }
        var obj =null;
        try{
          obj = CustomerListBean.fromMapMiddlewareDedup(map, true);
        } catch (_) {
          _showAlert("Customer Not Present With ID", "");
        }
        print(obj.toString());
        String message = obj.mfname.toString()+" "+obj.mmname.toString()+" is Already present with Customer Number "+obj.mcustno.toString() +" Customer Belongs to User : "+obj.mcreatedby.toString();
        _showAlert(message, "You cannot create customer with this id");
      }
    *//*} catch (_) {
      _showAlert("Something went wrong", "Please contact support team");
    }*//*
  }
*/

  getMiddleWareData() async {
    Utility obj = new Utility();
    final _headers = {'Content-Type': 'application/json'};
    var urlGetCustomerDetails = "customerData/getCustomerDedup/";

    try {
      String json = _toJson();
      String bodyValue = await NetworkUtil.callPostService(
          json.toString(),
          Constant.apiURL.toString() + urlGetCustomerDetails.toString(),
          _headers);
      if (bodyValue == "404") {
        return null;
      } else {
        print(bodyValue);
        //final parsed = JSON.decode(bodyValue).cast<String, dynamic>();
        Map<String, dynamic> map = JSON.decode(bodyValue);
        if(map==null){
<<<<<<< .mine
          globals.isDedupDone= true;
          //TODO Put this in resource file
          _showAlert("Customer Not Present With ID", "You can proceed with Creating new customer");
          isCustFoundInDedup=false;
=======
          globals.isDedupDone= true;
          //TODO Put this in resource file
          _showAlert("Customer Not Present With ID", "You can proceed with Creating new customer",0);
          isCustFoundInDedup=false;
>>>>>>> .r1143
        }
        var obj =null;
        try{
          obj = CustomerListBean.fromMapMiddlewareDedup(map, true);
          globals.isDedupDone= true;
        } catch (_) {
<<<<<<< .mine
          globals.isDedupDone= true;
          //TODO Put this in resource file
          _showAlert("Customer Not Present With ID", "You can proceed with Creating new customer");
          isCustFoundInDedup=false;
=======
          globals.isDedupDone= true;
          //TODO Put this in resource file
          _showAlert("Customer Not Present With ID", "You can proceed with Creating new customer",0);
          isCustFoundInDedup=false;
>>>>>>> .r1143
        }
<<<<<<< .mine

        String message = "${obj.mlongname.toString()} is already present with Customer Number ${obj.mcustno.toString()} Customer Belongs to User : ${obj.mcreatedby!=null && obj.mcreatedby!='null'?obj.mcreatedby.toString():""}";
        _showAlert(message, "You cannot create customer with this id");
=======
if(CustomerFormationMasterTabsState.custListBean.mcustno == null || CustomerFormationMasterTabsState.custListBean.mcustno == 0
    || CustomerFormationMasterTabsState.custListBean.mcustno != obj.mcustno) {
  String message = "${obj.mlongname
      .toString()} is already present with Customer No ${obj.mcustno
      .toString()} , Customer Belongs to User : ${obj.mcreatedby != null &&
      obj.mcreatedby != 'null' ? obj.mcreatedby : ""}";
  _showAlert("Cannot create customer with this id", message, 0);
  isCustFoundInDedup = true;
}else{
  _showAlert("You Can proceed With customer Edit", "National Id  Belongs to same customer", 0);
}
>>>>>>> .r1143
        isCustFoundInDedup=true;
      }
    } catch (_) {
<<<<<<< .mine
      isCustFoundInDedup=false;
      globals.isDedupDone= true;
      _showAlert("Customer Not Present With ID", "You can proceed with Creating new customer");
=======
      isCustFoundInDedup=false;
      globals.isDedupDone= true;
      _showAlert("Customer Not Present With ID", "You can proceed with Creating new customer",0);
>>>>>>> .r1143
    }
  }

  String _toJson() {
    var mapData = new Map();
    mapData["mnationalid"] =
        CustomerFormationMasterTabsState.custListBean.mpannodesc.trim();
    mapData[TablesColumnFile.mdob] = CustomerFormationMasterTabsState.custListBean.mdob != null
        ? CustomerFormationMasterTabsState.custListBean.mdob.toIso8601String()
        : null;

<<<<<<< .mine
    print(" mapData mapData ${mapData}");
=======
    print(mapData);
>>>>>>> .r1143
    String json = JSON.encode(mapData);
    return json;
  }
  
     var commentWidgets = List<Widget>();


  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now().subtract(Duration(days: 1)),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now().subtract(Duration(days: 1)));
    if (picked != null && picked != CustomerFormationMasterTabsState
        .custListBean.mdob)
      setState(() {
        CustomerFormationMasterTabsState.custListBean.mdob= picked;
        tempDate = formatter.format(picked);
        if(picked.day.toString().length==1){
          tempDay = "0"+picked.day.toString();

        }
        else tempDay = picked.day.toString();
        CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(0, 2, tempDay);
        tempYear = picked.year.toString();
        CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(6, 10,tempYear);
        if(picked.month.toString().length==1){
          tempMonth = "0"+picked.month.toString();
        }
        else
          tempMonth = picked.month.toString();
        CustomerFormationMasterTabsState.applicantDob = CustomerFormationMasterTabsState.applicantDob.replaceRange(3, 5, tempMonth);

      });
  }

  Future<void> _ShowCircInd() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deduping online'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Center(widthFactor: 30.0,heightFactor: 3.0,child:CircularProgressIndicator())],
            ),
          ),
        );
      },
    );
  }


  Future<void> _showImage() async {

    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) =>
            ViewImageScreen()));
  }

  Widget getCircleContainer() {
    imageCache.clear();
    try {
      return
        new GestureDetector(
          onTap: () {
            print("Container clicked");
            imageCache.clear();
            docListView = new List<PhotoViewGalleryPageOptions>();
           
            if (CustomerFormationMasterTabsState
                .custListBean
                .imageMaster[0]
                .imgString !=
                null &&
                CustomerFormationMasterTabsState
                    .custListBean.imageMaster !=
                    null &&
                CustomerFormationMasterTabsState
                    .custListBean
                    .imageMaster[0]
                    .imgString !=
                    "") {
              docListView = new List<PhotoViewGalleryPageOptions>();
              docListView.add(PhotoViewGalleryPageOptions(
                  imageProvider: MemoryImage(
                      File(CustomerFormationMasterTabsState
                          .custListBean.imageMaster[0].imgString)
                          .readAsBytesSync())));
              _showImage();
            } else {
              _PickImage(0);
            }
          },
          child:
          new Container(
            width: 300.0,
            height: 300.0,
            decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xff07426A), width: 0.5),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  //repeat: ImageRepeat.noRepeat,
                  image:
                  CustomerFormationMasterTabsState
                      .custListBean.imageMaster !=
                      null &&
                      CustomerFormationMasterTabsState
                          .custListBean
                          .imageMaster[0]
                          .imgString !=
                          null &&
                      CustomerFormationMasterTabsState
                          .custListBean.imageMaster !=
                          null &&
                      CustomerFormationMasterTabsState
                          .custListBean
                          .imageMaster[0]
                          .imgString !=
                          ""
                      ?
                  MemoryImage(File(CustomerFormationMasterTabsState
                      .custListBean.imageMaster[0].imgString).readAsBytesSync())

                      : new ExactAssetImage('assets/AddImage.png'),

              )

            ),
          ),
        );
    }catch(_){
      return
        new GestureDetector(
          onTap: () {
            print("Container clicked");
            imageCache.clear();
            docListView = new List<PhotoViewGalleryPageOptions>();
            print(
                "CustomerFormationMasterTabsState.custListBean.imageMaster[0].imgString ${CustomerFormationMasterTabsState
                    .custListBean.imageMaster[0].imgString}");
            if (CustomerFormationMasterTabsState
                .custListBean
                .imageMaster[0]
                .imgString !=
                null &&
                CustomerFormationMasterTabsState
                    .custListBean.imageMaster !=
                    null &&
                CustomerFormationMasterTabsState
                    .custListBean
                    .imageMaster[0]
                    .imgString !=
                    "") {
              docListView.add(PhotoViewGalleryPageOptions(
                  imageProvider: MemoryImage(
                      File(CustomerFormationMasterTabsState
                          .custListBean.imageMaster[0].imgString)
                          .readAsBytesSync())));
              _showImage();
            } else {
              _PickImage(0);
            }
          },
          child:
          new Container(
            width: 300.0,
            height: 300.0,
            decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xff07426A), width: 0.5),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  //repeat: ImageRepeat.noRepeat,
                  image: new ExactAssetImage('assets/AddImage.png'),

                )

            ),
          ),
        );
    }

  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}



class ViewImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.

      body: PhotoViewGallery( pageOptions:docListView),
    );
  }
}