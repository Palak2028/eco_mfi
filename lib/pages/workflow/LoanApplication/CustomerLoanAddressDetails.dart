
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanDetailsMasterTab.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanImageBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/AreaDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/DistrictDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/StateDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/SubDistrictDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerLoanAddressDetails extends StatefulWidget {

  /*CustomerLoanDetailsBean laonLimitPassedObject;
  CustomerLoanAddressDetails({Key key, this.laonLimitPassedObject}) : super(key: key);*/






  @override
  _CustomerLoanAddressDetailsState createState() =>
      new _CustomerLoanAddressDetailsState();
}

class _CustomerLoanAddressDetailsState
    extends State<CustomerLoanAddressDetails> {


  String countryCd = "";
  String countryName = "";
  int distCd ;
  String distName = "";
  String stateCd = "";
  String stateName = "";
  String cityCd = "";
  String cityName= "";
  String placeCd;
  String placeName = "";
  int areaCd;
  String areaName = "";
  String addr1 = "";
  String addr2 = "";
  SharedPreferences prefs;
  int residentialCode;


  File _image;


  @override
  void initState() {
    super.initState();
    // getSessionVariables();

    getAdressDetails();

  }



  void getAdressDetails() async{



    prefs = await SharedPreferences.getInstance();
    residentialCode = await prefs.getInt(TablesColumnFile.resAddCode);



  if( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj!=null&& CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcusttrefno!=null
      && CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustmrefno!=null)
  {
    await AppDatabase.get()
        .selectCustomerAddressDetailsListIsDataSynced(
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcusttrefno,  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustmrefno)
        .then((List<AddressDetailsBean> addressDetails) async {

          if(addressDetails!=null&&addressDetails.isNotEmpty){


            for (int i = 0; i < addressDetails.length; i++) {

              print("adress type ${addressDetails[i].maddrType}" );
              print("residential code e ${residentialCode}" );
              if(addressDetails[i].maddrType==residentialCode){
                countryCd = addressDetails[i].mcountryCd;

                if(countryCd!=null&&countryCd.trim!=''){
                  await AppDatabase.get().getCountryNameViaCountryCode(countryCd).then((val){


                    countryName = val.countryName;

                  });



                }


                stateCd= addressDetails[i].mState;
                if(stateCd!=null&&stateCd.trim!=''){
                  await AppDatabase.get().getStateNameViaStateCode( stateCd).then(( StateDropDownList val){


                    stateName = val.stateDesc;

                  });



                }

                distCd= addressDetails[i].mDistCd;
                if(distCd!=null&&distCd!=0){
                  await AppDatabase.get().getDistrictNameViaDistrictCode( distCd.toString()).then(( DistrictDropDownList val){


                    distName = val.distDesc;

                  });



                }



                cityCd = addressDetails[i].mcityCd;
                if(cityCd!=null&&cityCd.trim()!=''&&cityCd.trim()!='null'){
                  await AppDatabase.get().getPlaceNameViaPlaceCode( cityCd.toString()).then(( SubDistrictDropDownList val){


                    cityName = val.placeCdDesc;

                  });



                }


                placeCd =  addressDetails[i].mplacecd;

                if(placeCd!=null&&placeCd.trim()!=''&&placeCd.trim()!='null'){
                  await AppDatabase.get().getPlaceNameViaPlaceCode( placeCd.toString()).then(( SubDistrictDropDownList val){


                    placeName = val.placeCdDesc;

                  });



                }

                areaCd = addressDetails[i].marea;


                if(areaCd!=null&&areaCd!=0){
                  await AppDatabase.get().getAreaNameViaAreaCode( areaCd.toString()).then(( AreaDropDownList val){
                    areaName = val.areaDesc;
                  });



                }


                addr1 = addressDetails[i].maddr1;
                addr2 = addressDetails[i].maddr2;


              }

            }

          }

    });




  }
  try{
    setState(() {

    });
  }catch(_){


  }




  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: <Widget>[
      SizedBox(
      height: 16.0,
      ),



    Container(
    color: Constant.mandatoryColor,
        child:new ListTile(

          title: new Text( Translations.of(context).text("Country")),
          subtitle: countryCd == null ||
              countryCd  == "null"
              ? new Text("")
              : new Text("${countryCd } ${countryName==null||countryName.trim()=='null'?'':countryName}"),

        )
    ),
        SizedBox(
          height: 5.0,
        ),

    Container(
    color: Constant.mandatoryColor,
    child:
        new ListTile(
          title: new Text(Translations.of(context).text("State")),
          subtitle: stateCd == null ||
              stateCd  == "null"
              ? new Text("")
              : new Text("${stateCd } ${stateName==null||stateName.trim()=='null'?'':stateName}"),

        ),),
        SizedBox(
          height: 5.0,
        ),

    Container(
    color: Constant.mandatoryColor,
    child:new ListTile(
          title: new Text(Translations.of(context).text('zone')),
          subtitle: cityCd == null ||
              cityCd  == "null"
              ? new Text("")
              : new Text("${cityCd } ${cityName==null||cityName.trim()=='null'?'':cityName}"),

        )),
        SizedBox(
          height: 5.0,
        ),

    /*Container(
    color: Constant.mandatoryColor,
      child:new ListTile(
            title: new Text(Translations.of(context).text('zone')),
            subtitle: distCd == null ||
                distCd  == "null"
                ? new Text("")
                : new Text("${distCd}  ${distName==null||distName.trim()=='null'?'':distName}"),

          )),*/

        SizedBox(
          height: 5.0,
        ),



    Container(
    color: Constant.mandatoryColor,
    child:new ListTile(
          title: new Text(Translations.of(context).text('area')),
          subtitle: areaCd == null ||
              areaCd  == "null"||areaCd==0
              ? new Text("")
              : new Text("${areaCd} ${areaName==null||areaName.trim()=='null'?'':areaName}"),

        )),
        SizedBox(
          height: 5.0,
        ),
        Container(
            color: Constant.mandatoryColor,
            child:new ListTile(
              title: new Text(Translations.of(context).text('Address_Line_1')),
              subtitle: addr1 == null ||
                  addr1  == "null"
                  ? new Text("")
                  : new Text("${addr1} , ${addr2}"),

            )),



        new CheckboxListTile(
    subtitle: new Text(Translations.of(context).text('residentialAddressChanged'))
    ,value:  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj!=null&& CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcheckresaddchng==1?true:false, onChanged: (bool val){

          setState(() {

            if(val==true) CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcheckresaddchng = 1;
            else  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcheckresaddchng = 0;

          });


        }),




        new Container(
          padding: new EdgeInsets.all(8.0),
          child:Center(
    child:Text(
      Translations.of(context).text('Click_Below_for_pic'),
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    )



        ),
        new Row(
          children: <Widget>[
            new Flexible(
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    title: new ListTile(
                      title: CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans!=null
                          &&CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[0]
                          .mimagestring !=
                          null &&
                          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans!=null
                          &&CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.
                          loanimageBeans[0].mimagestring !=
                          ""
                          ? new Image.file(
                        File( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[0]
                            .mimagestring),
                        height: 200.0,
                        width: 200.0,
                      )
                          : new Icon(
                        Icons.camera_alt,
                        size: 40.0,
                        color: Color(0xff07426A),
                      ),
                      onTap: () async {


                        await _PickImageDialog(0);



                      },
                    ),
                  ),
                ],
              ),
            ),
            new Flexible(
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    title: new ListTile(
                      title: CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans!=null
                          &&CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[1]
                              .mimagestring !=
                              null &&
                          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans!=null
                          &&CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.
                          loanimageBeans[1].mimagestring !=
                              ""
                          ? new Image.file(
                        File( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[1]
                            .mimagestring),
                        height: 200.0,
                        width: 200.0,
                      )
                          : new Icon(
                        Icons.camera_alt,
                        size: 40.0,
                        color: Color(0xff07426A),
                      ),
                      onTap: () async {
                        //await _PickImage(1);

                        await _PickImageDialog(1);
                        /*if( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans!=null
                            && CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[1].mimagestring!=null&&
                            CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans!=null
                            && CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[1]
                                .mimagestring!=""
                        ){
                          *//* _changed(CustomerFormationMasterTabsState
                              .custListBean
                              .imageMaster[1]
                              .imgString,"");*//*
                        }
*/
                        /*_navigateAndDisplaySelection(
                                  context, 'customer picture')*/

                      },
                    ),
                  ),
                ],
              ),
            ),

          ],
        )
    ]
    );
  }







  Future<void> _PickImage(int imageNo) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.touch_app,
              color: Colors.blue[800],
              size: 40.0,
            ),
            content: SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[

                  Card(
                    child: new ListTile(
                        title: new Text(('Take Picture From Camera')),
                        onTap: () {

                          Navigator.of(context).pop();
                          getImage(imageNo);

                        }),),

                  Card(
                    child: new ListTile(
                        title: new Text(('Choose From Gallery')),
                        onTap: () {

                          Navigator.of(context).pop();
                          getImageFromGallery(imageNo);

                        }),),


                ],
              ),
            ),
          );
        });
  }




  Future getImage(int no) async {

    if(CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans==null){
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans= new  List<CustomerLoanImageBean>();
      for(int i =0;i<5;i++){
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans.add(new CustomerLoanImageBean());
      }
    }
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 200.0, maxWidth: 200.0);
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      ratioX: 1.5,
      ratioY: 1.0,
      maxWidth: 512,
      maxHeight: 512,
    );
    String st = croppedFile.path;
    print("path" + st.toString());
    CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[no].mimagestring =
        croppedFile.path;
    if(no==0){
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[no].mimagetype=  "Address1";
    }else if(no==1){
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[no].mimagetype=  "Address2";
    }

    setState(() {
      _image = croppedFile;
    });
  }






  Future getImageFromGallery(int no) async {
    if(CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans==null){
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans= new  List<CustomerLoanImageBean>();
      for(int i =0;i<=5;i++){
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans.add(new CustomerLoanImageBean());
      }
    }
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 200.0, maxWidth: 200.0);
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      ratioX: 1.5,
      ratioY: 1.0,
      maxWidth: 512,
      maxHeight: 512,
    );
    String st = croppedFile.path;
    print("path" + st.toString());
    CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[no].mimagestring =
        croppedFile.path;
    if(no==0){
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[no].mimagetype=  "Address1";
    }else if(no==1){
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[no].mimagetype=  "Address2";
    }

    setState(() {
      _image = croppedFile;
    });
  }





  Future<void> _PickImageDialog(int imageNo) async {
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
                      )


                    ],

                    )


                  ],
                ) ,
              )

          );
        });
  }










}
