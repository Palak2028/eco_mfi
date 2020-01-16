import 'dart:typed_data';
import 'package:eco_mfi/pages/workflow/FPSPages/AgentFingureCapture.dart';
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/Helper.dart';
import 'package:eco_mfi/Utilities/SignaturePainter.dart';
import 'dart:ui' as ui;
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/CGT/CGT1.dart';

import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationSocialFinancialDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../translations.dart';

class   CustomerFormationDeclarationForm extends StatefulWidget {
  CustomerFormationDeclarationForm({Key key}) : super(key: key);

  @override
  _CustomerFormationDeclarationFormState createState() =>
      new _CustomerFormationDeclarationFormState();
}

class _CustomerFormationDeclarationFormState
    extends State<CustomerFormationDeclarationForm> {
  List<CustomModel> customModelsDeclarations = [];

      bool isCalled = false;
      SharedPreferences prefs;
      String usercd;
      String username;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionVariables();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      usercd = prefs.getString(TablesColumnFile.musrcode);
      username = prefs.getString(TablesColumnFile.musrname);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new ListView(
        children: <Widget>[
          new Card(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Text(
                  Translations.of(context).text('Cust_Sign'),
                    textAlign: TextAlign.center,
                  ),

                new Container(
                    height: 250.0,
                    child: new Column(
                      children: <Widget>[
                        new ListTile(
                          title:
                          CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState.custListBean
                              .imageMaster[11].imgString!=""&&CustomerFormationMasterTabsState.custListBean
                              .imageMaster[11].imgString!=null
                                  ? new ListTile(
                                      title: new Image.memory(
                                        Base64Decoder().convert(CustomerFormationMasterTabsState.custListBean
                                            .imageMaster[11].imgString),
                                        height: 200.0,
                                        width: 200.0,
                                      ),
                                      subtitle: new Text(
                                        Translations.of(context).text('Click_for_Digi_sign'),
                                        textAlign: TextAlign.center,
                                      ),
                                      onTap: () {
                                        _navigateAndDisplaySignatureSelection(
                                            context, 'customer');
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
                                            context, 'customer');
                                      },
                                    ),
                        ),
                      ],
                    )),
              ],
            ),
            elevation: 5.0,
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
                          title: CustomerFormationMasterTabsState.custListBean.imageMaster!=null&&CustomerFormationMasterTabsState.custListBean
                              .imageMaster[12].imgString!=""&&CustomerFormationMasterTabsState.custListBean
                              .imageMaster[12].imgString!=null
                              ? new ListTile(
                                  title: new Image.memory(
                                    Base64Decoder().convert(CustomerFormationMasterTabsState.custListBean
                                        .imageMaster[12].imgString),
                                    height: 200.0,
                                    width: 200.0,
                                  ),
                                  subtitle: new Text(
                                    Translations.of(context).text('Click_for_Digi_sign'),
                                    textAlign: TextAlign.center,
                                  ),
                                  onTap: () {
                                    _navigateAndDisplaySignatureSelection(
                                        context, 'spouse');
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
                                        context, 'spouse');
                                  },
                                ),
                        ),
                      ],
                    )),
              ],
            ),
            elevation: 5.0,
          ),
          new Text(

    "\n\n"+Translations.of(context).text('Date') +"${DateTime.now().toIso8601String()}",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
          new Text(
            "\n"+Translations.of(context).text('Agent_Name') +"${username}",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
          new Text(
            "\n\n"+Translations.of(context).text('Agent_Id ') +"${usercd}",

            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
          new CheckboxListTile(
            title: new Text(
              "\n\n"+Translations.of(context).text('Declaration'),
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontSize: 10.0,
              ),
            ),
            onChanged: changedDropDownItem,
            activeColor: Color(0xff07426A),
            value: globals.accepted,
          ),
          new Container(
            height: 20.0,
          ),
          new Container(
            height: 20.0,
          )
        ],
      ),
    );
  }

  void changedDropDownItem(bool id) {
    print("Selected Id  $id, we are going to refresh the UI");
    setState(() {
      globals.accepted = id;
      isCalled=true;
    });
  }

  void _changed(ByteData filePath, String forWhat) {
    setState(() {
      if (forWhat == "spouse") {


        if(filePath!=null&&filePath!=""){

          CustomerFormationMasterTabsState.custListBean
            .imageMaster[12].imgString =
             base64.encode(filePath.buffer.asUint8List());
        debugPrint(
            "shadab aread " + base64.encode(filePath.buffer.asUint8List()));

        CustomerFormationMasterTabsState.custListBean
            .imageMaster[12].imgSubType = 'Signature';
        CustomerFormationMasterTabsState.custListBean
            .imageMaster[12].imgType = forWhat;}
       // globals.listImgBean.insert(11,imgBean);
        Helper helper = new Helper();
        helper.mockService();
      } else if (forWhat == "customer") {
        globals.imageVisibilityDeclarationFormTagCustomer = true;
        if(filePath!=null&&filePath!=""){
          CustomerFormationMasterTabsState.custListBean
              .imageMaster[11].imgString =
              base64.encode(filePath.buffer.asUint8List());
          debugPrint(
              "shadab aread " + base64.encode(filePath.buffer.asUint8List()));
          CustomerFormationMasterTabsState.custListBean
              .imageMaster[11].imgSubType = 'Signature';
          CustomerFormationMasterTabsState.custListBean
              .imageMaster[11].imgType = forWhat;
        }

        //globals.listImgBean.insert(12,imgBean);

      }
    });
  }

  _navigateAndDisplaySignatureSelection(
      BuildContext context, String str) async {

    if(CustomerFormationMasterTabsState.custListBean.imageMaster==null){
      CustomerFormationMasterTabsState.custListBean.imageMaster= new  List<ImageBean>();
      for(int i =0;i<23;i++){
        CustomerFormationMasterTabsState.custListBean.imageMaster.add(new ImageBean());
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
        _changed(onValue, str);
      });
      setState(() {

      });
     // Scaffold.of(context).showSnackBar(SnackBar(content: Text("$onValue")));
    });
  }























}





