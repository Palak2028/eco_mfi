import 'dart:async';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFoundation.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/RepaymentFrequency.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/TransactionMode.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';
import 'package:xml/xml.dart' as xml;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/globals.dart';

class QrScanner extends StatefulWidget {
  @override
  QrScannerState createState() {
    return new QrScannerState();
  }
}

class QrScannerState extends State<QrScanner> {
  String result = "";
  String uidNumber = "";
  String personName = "";
  String gender = "";
  String yearOfBirth = "";
  String co = "";
  String house = "";
  String street = "";
  String landMark = "";
  String loc = "";
  String vtc = "";
  String po = "";
  String dist = "";
  String subdist = "";
  String state = "";
  String pinCode = "";
  String dob = "";
  String addressFinal = "";
  Utility obj = new Utility();
  static const JsonCodec JSON = const JsonCodec();
  static final _headers = {'Content-Type': 'application/json'};
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
/*
  var urlGetGroupInfo =
      "http://14.141.164.239:8090/createGroupsFoundations/getGroupDataByAgentUserName/";
*/

  var urlGetGroupInfo =
      "http://14.141.164.239:8090/createGroupsFoundations/getGroupDataByAgentUserName/";
/*
  var urlGetCenterInfo =
      "http://14.141.164.239:8090/createCentersFoundations/getDataByAgentUserName/";
*/
  var urlGetCenterInfo =
      "http://14.141.164.239:8090/createCentersFoundations/getDataByAgentUserName/";
  /*var urlGetPurposeInfo =
      "http://14.141.164.239:8090//purposeData/getlistOfPurposes/";*/
  var urlGetPurposeInfo =
      "http://14.141.164.238:8090//purposeData/getlistOfPurposes/";
  /*var urlGetTransactionModeInfo =
      "http://14.141.164.239:8090//transactionModeData//getlistOfTransactionMode//";*/
var urlGetTransactionModeInfo =
      "http://14.141.164.238:8090/transactionModeData/getlistOfTransactionMode/";
  /*var urlGetProductInfo =
      "http://14.141.164.239:8090/productData/getlistOfproduct/";*/
  var urlGetProductInfo=
      "productData/getlistOfproduct/";
  /*var urlGetRepaymentFrequencyInfo =
      "http://14.141.164.239:8090/repaymentFrequencyData/getlistOfrepaymentFrequency/";
*/
  var urlGetRepaymentFrequencyInfo =
      "http://14.141.164.238:8090/repaymentFrequencyData/getlistOfrepaymentFrequency/";
  var urlUpdateCustomerLoanMaster =
      "http://14.141.164.239:8090/customerLoanData/add/";
  /*var urlGetRepaymentFrequencyInfo =
      "http://14.141.164.238:8090/repaymentFrequencyData/getlistOfRepaymentFrequenc/";*/
  Future _scanQR() async {
    try {
      var qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
        var document = xml.parse(result);
        var textual = document.descendants
            .where((node) => node is xml.XmlText && !node.text.trim().isEmpty)
            .join('\n');
        print("Data here ois " + textual);
        int atrributeLength = document
            .findElements("PrintLetterBarcodeData")
            .elementAt(0)
            .attributes
            .length;
        for (var i = 0; i < atrributeLength; i++) {
          String value = document
              .findElements("PrintLetterBarcodeData")
              .elementAt(0)
              .attributes
              .elementAt(i)
              .toString();
          if (value.contains("uid")) {
            uidNumber =
                value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("name")) {
            personName =
                value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("gender")) {
            gender = value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("yob")) {
            yearOfBirth =
                value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("co")) {
            co = value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("house")) {
            house = value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("street")) {
            street = value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("lm")) {
            landMark =
                value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("loc")) {
            loc = value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("vtc")) {
            vtc = value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("po")) {
            po = value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("dist")) {
            dist = value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("subdist")) {
            subdist =
                value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("state")) {
            state = value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("pc")) {
            pinCode =
                value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
          if (value.contains("dob")) {
            dob = value.substring(value.indexOf("\"") + 1, value.length - 1);
          }
        }
        addressFinal = co +
            ", " +
            house +
            ", " +
            street +
            ", " +
            landMark +
            ", " +
            loc +
            ", " +
            vtc +
            ", " +
            po +
            ", " +
            dist +
            ", " +
            subdist +
            ", " +
            state +
            ", " +
            pinCode;
        print("Data here UID is  " +
            uidNumber +
            " " +
            personName +
            " " +
            gender +
            " " +
            yearOfBirth +
            " " +
            co +
            " " +
            house +
            " " +
            street +
            " " +
            landMark +
            " " +
            loc +
            " " +
            vtc +
            " " +
            po +
            " " +
            dist +
            " " +
            subdist +
            " " +
            state +
            " " +
            pinCode +
            " " +
            dob);
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      /* appBar: AppBar(
        title: Text("QR Scanner"),
        style: new TextStyle(color: Colors.black),),
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      ),*/
      appBar: new AppBar(
        elevation: 1.0,
        title: new Text(
          'QR Scanner',
          style: new TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: Center(
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Text(
              "\n\nUid Number :  " + uidNumber,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            new Text(
              "\n\nName :  " + personName,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            new Text(
              "\n\ngender :  " + gender,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            new Text(
              "\n\nBirth Year :  " + yearOfBirth,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            /* new TextFormField(
              decoration:
              new InputDecoration(labelText: 'UID Number'),
              initialValue: uidNumber,
              validator: (val) =>
              val.length < 1 ? 'UID Number is Required ' : null,
              onSaved: (val) => val = uidNumber,
              obscureText: false,
              keyboardType: TextInputType.text,
              autocorrect: false,
            ),
            new TextFormField(
              decoration:
              new InputDecoration(labelText: 'Name'),
              initialValue: personName,
              validator: (val) =>
              val.length < 1 ? 'Name is Required ' : null,
              onSaved: (val) => val = personName,
              obscureText: false,
              keyboardType: TextInputType.text,
              autocorrect: false,
            ),
            new TextFormField(
              decoration:
              new InputDecoration(labelText: 'Gender'),
              initialValue: gender,
              validator: (val) =>
              val.length < 1 ? 'Gender is Required ' : null,
              onSaved: (val) => val = gender,
              obscureText: false,
              keyboardType: TextInputType.text,
              autocorrect: false,
            ),
            new TextFormField(
              decoration:
              new InputDecoration(labelText: 'Birth Year'),
             // initialValue: yearOfBirth,
              validator: (val) =>
              val.length < 1 ? 'Birth Year is Required ' : null,
              onSaved: (val) => val = yearOfBirth,
              obscureText: false,
              keyboardType: TextInputType.text,
              autocorrect: false,
            ),*/
            new Text(
              "\n\nAddress :\n" + addressFinal,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            new Text(
              "\n \n Date Of Birth :   " + dob,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),

            /* new TextFormField(
              decoration:
              new InputDecoration(labelText: 'Address'),
              initialValue: co +" "+  house +" "+  street +" "+  landMark +" "+  loc +" "+  vtc +" "+  po +" "+  dist +" "+ subdist +" "+  state  +" "+  pinCode,
              validator: (val) =>
              val.length < 1 ? 'Address is Required ' : null,
              onSaved: (val) => val = co +" "+  house +" "+  street +" "+  landMark +" "+  loc +" "+  vtc +" "+  po +" "+  dist +" "+ subdist +" "+  state  +" "+  pinCode,
              obscureText: false,
              keyboardType: TextInputType.text,
              autocorrect: false,
            ),*/
            /* new TextFormField(
              decoration:
              new InputDecoration(labelText: 'Date of Birth'),
              initialValue: dob,
              validator: (val) =>
              val.length < 1 ? 'Date of Birth is Required ' : null,
              onSaved: (val) => dob = val,
              obscureText: false,
              keyboardType: TextInputType.text,
              autocorrect: false,
            ),*/
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.camera_alt),
          backgroundColor: Colors.black,
          label: Text("Scan"),
          onPressed: () {
            _performSyncingProduct();
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _performSyncingProduct() {
    showInSnackBar("Sending  online");
    _trySaveProduct();
    _scaffoldKey.currentState.hideCurrentSnackBar();
  }
  Future<Null> _trySaveProduct() async {
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      showInSnackBar("saving From online");
      await saveOnlineProduct(agentUserName).then((value) {
      });
    }
  }
  Future<List<TransactionMode>> saveOnlineProduct(agentUserName) async {
    try {

      final bodyValue = await NetworkUtil.callGetService(Constant.apiURL+"userDetailsMaster/loginValidation");
      if(bodyValue == "404" ){
        return null;
      }
      final parsed = json.decode(bodyValue).cast<Map<String, dynamic>>();
      List<ProductBean> obj =
          parsed.map<ProductBean>((json) => ProductBean.fromMap(json)).toList();
      for (ProductBean items in obj) {
        await AppDatabase.get().updateProductMaster(items);
      }
    } catch (e) {
      print('Server Exception!!!');
    }
  }
  Future<String> _toJsonCustomerLoan( CustomerLoanDetailsBean   customerLoan) async {
    var map = new Map();
    var mapId = new Map();
    print("Mapping Data");
    /*mapId[TablesColumnFile.loanNumberOfTab] =customerLoan.loanNumber;
    mapId[TablesColumnFile.customerNumberOfTab]=  customerLoan.customerNumber ;
    mapId['usrCode'] = 'shadab';
    map['compositeLoanId'] = mapId;



    map[TablesColumnFile.productId]=  customerLoan.productId ;
    map[TablesColumnFile.productName] = customerLoan.productName.trim();
    map[TablesColumnFile.purposeId]=  customerLoan.purposeId;
    map[TablesColumnFile.purpose]  = customerLoan.purpose;
    map[TablesColumnFile.subPurposeId]=  customerLoan.subPurposeId ;
    map[TablesColumnFile.subPurpose] =  customerLoan.subPurpose ;
    map[TablesColumnFile.appliedAmount]=  customerLoan.appliedAmount ;
    map[TablesColumnFile.disbursmentDate]=  customerLoan.disbursmentDate.toIso8601String() ;
    map[TablesColumnFile.ROI]=  customerLoan.roi ;
    map[TablesColumnFile.repaymentFrequencyId]=  customerLoan.repaymentFrequencyId ;
    map[TablesColumnFile.repaymentFrequency] =  customerLoan.repaymentFrequency.trim() ;
    map[TablesColumnFile.numOfInstallment]=  customerLoan.numOfInstallment ;
    map[TablesColumnFile.endDate]=  customerLoan.endDate.toIso8601String() ;
    map[TablesColumnFile.interestAmount]=  customerLoan.interestAmount ;
    map[TablesColumnFile.installmentStartDate]=  customerLoan.installmentStartDate.toIso8601String() ;
    map[TablesColumnFile.installmentAmount]=  customerLoan.installmentAmount ;
    map[TablesColumnFile.approvedAmount]=  customerLoan.approvedAmount ;
    map[TablesColumnFile.customerNumberOfCore] =  customerLoan.omniCustomerNumber ;
    map[TablesColumnFile.disbursmentAmount]=  customerLoan.disbursmentAmount ;
    map[TablesColumnFile.ModeOfCollectionId]=  customerLoan.modeOfCollectionId ;
    map[TablesColumnFile.ModeOfCollection] =  customerLoan.modeOfCollection ;
    map[TablesColumnFile.ModeOfDisbursmentId]=  customerLoan.modeOfDisbursmentId ;
    map[TablesColumnFile.ModeOfDisbursment] =  customerLoan.modeOfDisbursment ;
    map[TablesColumnFile.isDataSyncedToCoreSystem]=  1  ;*/

    String json = JSON.encode(map);
    print("Mapping Data Complete");
    return json;
  }
  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }
}
