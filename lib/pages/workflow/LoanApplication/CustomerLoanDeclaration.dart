

import 'package:eco_mfi/Utilities/Helper.dart';
import 'package:eco_mfi/Utilities/SignaturePainter.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanDetailsMasterTab.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanImageBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';


class CustomerLoanDeclaration extends StatefulWidget {

  /*CustomerLoanDetailsBean laonLimitPassedObject;
  CustomerLoanDeclaration({Key key, this.laonLimitPassedObject}) : super(key: key);*/







  @override
  _CustomerLoanDeclarationState createState() =>
      new _CustomerLoanDeclarationState();
}

class _CustomerLoanDeclarationState
    extends State<CustomerLoanDeclaration> {

  File _image;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  new ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
    children: <Widget>[


      SizedBox(
        height: 5.0,

      ),



      Container(
        color: Colors.white,
        child: new TextField(

            textCapitalization: TextCapitalization.sentences,
            decoration:  InputDecoration(

              hintText: Translations.of(context).text('entrSpouseNam_Loan'),
              labelText: Translations.of(context).text('SpouseName_Loan'),
              hintStyle: TextStyle(color: Colors.grey),
              /*labelStyle: TextStyle(color: Colors.grey),*/
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  )),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff07426A),
                  )),
              contentPadding: EdgeInsets.all(20.0),
            ),
            inputFormatters: [
              new LengthLimitingTextInputFormatter(100),
              globals.onlyCharacter
            ],

            controller: new TextEditingController(text:"${CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mspouserelname
                == null||
                CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mspouserelname.trim()
                    == 'null'
                ?"":CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mspouserelname}"),

            onChanged : (String value) {


              print("COmimg here value ${value}");

              if(value!=null){
                CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mspouserelname = value;
              }

            }),
      ),
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
                        &&CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[2]
                            .mimagestring !=
                            null &&
                        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans!=null
                        &&CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.
                        loanimageBeans[2].mimagestring !=
                            ""
                        ? new Image.file(
                      File( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[2]
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
                     // await _PickImage(2);

                      await _PickImageDialog(2);
                      /*if( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans!=null
                          && CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[2]
                              .mimagestring!=null&&
                          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans!=null
                          && CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[2]
                              .mimagestring!=""
                      ){
                        *//* _changed(CustomerFormationMasterTabsState
                              .custListBean
                              .imageMaster[1]
                              .imgString,"");*//*
                      }*/

                      /*_navigateAndDisplaySelection(
                                  context, 'customer picture')*/

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
                        &&CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[3]
                            .mimagestring !=
                            null &&
                        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans!=null
                        &&CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.
                        loanimageBeans[3].mimagestring !=
                            ""
                        ? new Image.file(
                      File( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[3]
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
                      await _PickImageDialog(3);


                    },
                  ),
                ),
              ],
            ),
          ),

        ],
      ),

      SizedBox(
        height: 5.0,
      ),

      new CheckboxListTile(subtitle: new Text("I agree to support my spouse / relative in repaying all the loans she takes under the SG")
          ,value:  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcheckspouserepay!=null
              &&CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcheckspouserepay==1?true:false, onChanged: (val){

            setState(() {
              if(val==true)CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcheckspouserepay = 1;
              else CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcheckspouserepay = 0;

            });

          }),

      SizedBox(
        height: 5.0,

      ),



      new Card(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Text(
              Translations.of(context).text('Spouse_Sign'),
              textAlign: TextAlign.center,
            ),

            new Container(
                height: 250.0,
                child: new Column(
                  children: <Widget>[
                    new ListTile(
                      title: CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans!=null

                          &&CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[4].mimagestring!=""
                          &&CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[4].mimagestring!=null
                          ? new ListTile(
                        title: new Image.memory(
                          Base64Decoder().convert(CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[4].mimagestring),
                          height: 200.0,
                          width: 200.0,
                        ),
                        subtitle: new Text(
                          Translations.of(context).text('Click_for_Digi_sign'),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          _navigateAndDisplaySignatureSelection(
                              context);
                        },
                      )
                          : new ListTile(
                        title: new Image(
                            image: new AssetImage(
                                "assets/signature.png"),
                            height: 200.0),
                        subtitle: new Text(
                          Translations.of(context).text('Click_to_take_pic'),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          _navigateAndDisplaySignatureSelection(
                              context);
                        },
                      ),
                    ),
                  ],
                )),
          ],
        ),
        elevation: 5.0,
      ),




      SizedBox(
        height: 15.0,
      ),

      new CheckboxListTile(subtitle: new Text("Borrower is allowed to pay the installment in advance; however, FFMCL shall not be liable to pay any interest on the installment paid in advance." 
    "Borrower is not allowed to share loan amount with anyone and strictly use the loan for the purpose intended in the application."
    "Borrower is not allowed to sell or handover the property which will be purchased from the loan amount till the loan is fully paid off."
    "FFMCL may use borrower’s personal data to be used for the purposes of loan approval & management Regulatory requirements and Related party or Third-party requirement"),value: true, onChanged: (val){

        setState(() {
          if(val==true)CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcheckspouserepay = 1;
          else CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcheckspouserepay = 1;

        });

      })
    ]);
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
    if(no==2){
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[no].mimagetype=  "Spouse1";
    }else if(no==3){
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[no].mimagetype=  "Spouse2";
    }

    setState(() {
      _image = croppedFile;
    });
  }






  Future getImageFromGallery(int no) async {
    if(CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans==null){
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans= new  List<CustomerLoanImageBean>();
      for(int i =0;i<5;i++){
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
    if(no==2){
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[no].mimagetype=  "Address1";
    }else if(no==3){
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[no].mimagetype=  "Address2";
    }

    setState(() {
      _image = croppedFile;
    });
  }



  _navigateAndDisplaySignatureSelection(
      BuildContext context) async {

    if( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans==null){
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans= new  List<CustomerLoanImageBean>();
      for(int i =0;i<5;i++){
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans.add(new CustomerLoanImageBean());
      }
    }
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new SignApp(),
        fullscreenDialog: true,
      ),
    ).then((onValue) {
      setState(() {
        _changed(onValue);
      });
      setState(() {

      });
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("$onValue")));
    });
  }




  void _changed(ByteData filePath) {
    setState(() {

          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[4].mimagestring =
              base64.encode(filePath.buffer.asUint8List());
          debugPrint(
              "shadab aread " + base64.encode(filePath.buffer.asUint8List()));

          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[4].mimagetype = 'Signature';
        // globals.listImgBean.insert(11,imgBean);
        Helper helper = new Helper();
        helper.mockService();

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