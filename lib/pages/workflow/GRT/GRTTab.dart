import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/GRT/GRTDocumentVerification.dart';
import 'package:eco_mfi/pages/workflow/GRT/GRTQuestions.dart';
import 'package:eco_mfi/pages/workflow/GRT/bean/GRTBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/villageservey/Village_Servey_Arrangments.dart';
import 'package:eco_mfi/pages/workflow/villageservey/Village_Servey_Basics.dart';
import 'package:eco_mfi/pages/workflow/villageservey/Village_Servey_ExtraInformation.dart';
import 'package:eco_mfi/pages/workflow/villageservey/Village_Servey_Farming.dart';
import 'package:eco_mfi/pages/workflow/villageservey/Village_Servey_MicroEnterprises.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GRTTab extends StatefulWidget {
  final laonLimitPassedObject;
  GRTTab({Key key, this.laonLimitPassedObject}) : super(key: key);


  @override
  GRTabState createState() => new GRTabState();
}

class GRTabState extends State<GRTTab>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String branch = "";
  DateTime startTime = DateTime.now();
  final dateFormat = DateFormat("yyyy, mm, dd");
  DateTime date;
  TimeOfDay time;
  String approvalAmtLimit="0.0";
  String mreportinguser= "";

  int tabState = 2;
  static const List<String> tabNames = const <String>[
    'Documents Verification',
    'GRT Question'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 0, length: 2);
    getSessionVariables();
  }




  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode).toString();
      username = prefs.getString(TablesColumnFile.musrcode).trim();
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.geoLocation);
      try{
        geoLatitude = prefs.getDouble(TablesColumnFile.geoLatitude).toString();
        geoLongitude = prefs.getDouble(TablesColumnFile.geoLongitude).toString();
      }catch(_){
        print("Exception in getting loangitude");
      }
      approvalAmtLimit=prefs.getString(TablesColumnFile.mLoanApprovalLimit);
      mreportinguser = prefs.getString(TablesColumnFile.mreportinguser);
      /*approvalAmtLimit="50000.0";*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        //callDialog();
        Navigator.of(context).pop();
        globals.grtBean = GRTBean();
        print("Clear Image");
      },
      child: new Scaffold(
           bottomNavigationBar:  Container(
             color: Color(0xff07426A),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround
               ,
             children: <Widget>[
               new IconButton(
                 icon: new Icon(Icons.beenhere, color: Colors.green),
                 onPressed: () async {

                   callDialog();
                   //Navigator.of(context).pop();
                   //_submitData(1);
                 },
               ),

               new IconButton(
                 icon: new Icon(Icons.clear, color: Colors.red),
                 onPressed: () {
                   // callDialog();
                  // Navigator.of(context).pop();

                   _showAlert(Translations.of(context).text('Confirm'), 2);
                 },
               ),

             ],
           ),
           ),//key: _scaffoldKeyMaster,
        appBar: new AppBar(
          title: new Text(
            Translations.of(context).text('GRT'),
            style: TextStyle(color: Colors.white),
          ),
          elevation: 3.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
             // callDialog();
             Navigator.of(context).pop();
            },
          ),
          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          bottom: new TabBar(
            controller: _tabController,
            indicatorColor: Colors.black,
            isScrollable: true,
            tabs: new List.generate(tabNames.length, (index) {
              return new Tab(text: tabNames[index].toUpperCase());
            }),
          ),
      /*    actions: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.save,
                color: Colors.white,
                size: 40.0,
              ),
              onPressed: () {
                _submitData();
              },
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
            ),
          ],*/
        ),
        body: new TabBarView(
          controller: _tabController,
          children: <Widget>[
            new GRTDocumentVerification(widget.laonLimitPassedObject),
            new GRTQuestions(),
          ],
        ),
      ),
    );
  }

  Future<Null> _submitData(int approval) async {
    int id = 0;
    int loanTrefno = widget.laonLimitPassedObject.trefno;
    int loanMrefno = widget.laonLimitPassedObject.mrefno;
    int GRTTrefno = widget.laonLimitPassedObject.trefno;
    for (int i = 0; i < globals.questionCGT1.length; i++) {
      id = widget.laonLimitPassedObject.trefno+i;
      globals.questionGRT[i].mleadsid = "0";
      globals.questionGRT[i].trefno = GRTTrefno;
      globals.questionGRT[i].mrefno = 0;
      globals.questionGRT[i].mclgrtrefno = 0;
        print("xxxxxxxxxxxxxx"+globals.questionGRT[i].toString());
            await AppDatabase.get().updateGrtQaMaster(globals.questionGRT[i],id);
    }
    globals.grtBean.trefno =  GRTTrefno;
    globals.grtBean.mrefno  = 0;
    globals.grtBean.mcreatedby = username;
    globals.grtBean.mendtime= DateTime.now();
    globals.grtBean.mlastupdatedt = DateTime.now();
    globals.grtBean.mgeologd = geoLongitude;
    globals.grtBean.mgeolatd = geoLatitude;
    globals.grtBean.mgeolocation = geoLocation;
    globals.grtBean.mcreateddt = DateTime.now();
    if(widget.laonLimitPassedObject.mleadsid ==null||widget.laonLimitPassedObject.mleadsid.toString().trim() == 'null'){
      globals.grtBean.mleadsid = "0";
    }
    else{
      globals.grtBean.mleadsid= widget.laonLimitPassedObject.mleadsid;
    }
    if(widget.laonLimitPassedObject.mrefno==null){
      globals.grtBean.loanmrefno = 0;
    }else{
      globals.grtBean.loanmrefno = widget.laonLimitPassedObject.mrefno;
    }
    globals.grtBean.loantrefno = widget.laonLimitPassedObject.trefno;
    CustomerLoanDetailsBean custLoanBean = new CustomerLoanDetailsBean();
    custLoanBean.mapprovaldesc =  globals.grtBean.mremarks;
    if(approval==1) {
      await AppDatabase.get().getLoanApprovalLimit(widget.laonLimitPassedObject.mprdcd,username).then((onValue){
        print(" apprvLimt "+onValue.toString());
        if(onValue >= widget.laonLimitPassedObject.mapprvdloanamt) {
          custLoanBean.mleadstatus = 7;
          globals.grtBean.mrouteto = "";
          globals.grtBean.mroutefrom = "";

        }else {
          custLoanBean.mleadstatus = 6;
          globals.grtBean.mrouteto = mreportinguser;
          globals.grtBean.mroutefrom = username;
        }
      });

      await AppDatabase.get().updateGRTMaster(globals.grtBean);

      await AppDatabase.get().updateLoanDetailsStatus(
            widget.laonLimitPassedObject.trefno, widget.laonLimitPassedObject.mrefno, custLoanBean,DateTime.now(),mreportinguser,username,username);


      _showAlert(Translations.of(context).text('Submit'),custLoanBean.mleadstatus);
    }else if(approval==2) {
      custLoanBean.mleadstatus = 99;
      await AppDatabase.get().updateLoanDetailsStatus(
          widget.laonLimitPassedObject.trefno, widget.laonLimitPassedObject.mrefno, custLoanBean,DateTime.now(),"",globals.grtBean.mroutefrom,username);


      showConfrmAlrt();
    }



  }

/*  Future<void> _successfulSubmit() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('GRT done sucesfully'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  globals.grtBean = GRTBean();
                },
              ),
            ],
          );
        });
  }*/


  Future<bool> callDialog() async{

    await AppDatabase.get().getLoanApprovalLimit(widget.laonLimitPassedObject.mprdcd,username).then((onValue)async{
      print(" apprvLimt "+onValue.toString());
      if(onValue >= widget.laonLimitPassedObject.mapprvdloanamt) {
        _showAlert(Translations.of(context).text('Confirm'),1);

      }else {
        await onPop(
          context,
          Translations.of(context).text('You_Are_Exceeding_Your_Approval_Limit'),
          Translations.of(context).text('Your_Approval_Limit_Is_Lesser_Than_Loan_Approved_Amount_Your_Approval_Limit_Is') +"${onValue}"+
              Translations.of(context).text('Press_Ok_To_Route_To_You_Supervisor_For_GRT'),
        );


      }
    });


  }


  Future<bool> onPop(BuildContext context, String agrs1, String args2) async{
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(agrs1),
        content: new Text(args2),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text(Translations.of(context).text('No')),
          ),
          new FlatButton(
            onPressed: () {
              _submitData(1);
            },
            child: new Text(Translations.of(context).text('Yes')),
          ),
        ],
      ),
    ) ??
        false;
  }



  Future<void> _showAlert(String alertType,int confirmStatus) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:alertType== "Submit"? new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 60.0,
            ):(alertType=="Confirm"?
            new Icon(
              Icons.info,
              color: Colors.yellow
              ,
              size: 60.0,):
            new Icon(
              Icons.warning,
              color: Colors.red,
              size: 60.0,)
            )
            ,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  alertType== "Submit"&&confirmStatus==6?
                  Text(Translations.of(context).text('It_Is_Routed_To_Your') +"${mreportinguser}"):
                  alertType== "Submit"&&confirmStatus==7?
                  Text(Translations.of(context).text('GRT_Submitted_Successfully'))
                      :(alertType=="Confirm"?
                  Text(Translations.of(context).text('Are_You_Sure_You_Want_To_Confirm')):
                  Text(Translations.of(context).text('Please_Route_It_As_Your_Limit')+"${confirmStatus}"+Translations.of(context).text('GRP_Is_Below_Approval_Limit'))
                  ) ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                onPressed: () {
                  if(alertType =="Submit" ){
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    globals.grtBean = GRTBean();

                  }
                  else if(alertType =="Confirm" && confirmStatus ==1){
                    Navigator.of(context).pop();
                    _submitData(1);

                  }
                  else if(alertType =="Confirm"&& confirmStatus ==2){
                    Navigator.of(context).pop();
                    _submitData(2);

                  }
                  else{
                    Navigator.of(context).pop();
                  }
                },
              ),

              alertType=="Confirm"?FlatButton(
                child: Text(Translations.of(context).text('Cancel')),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ):null
            ],
          );
        });






  }



  Future<void> showConfrmAlrt() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(Translations.of(context).text('GRT_Rejected')),


                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  globals.grtBean = GRTBean();


                },
              ),
            ],
          );
        });
  }

  
}
