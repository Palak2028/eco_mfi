import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/ReadXmlCost.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT2Bean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';

import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/initializer.dart' as initializer;
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CGT2 extends StatefulWidget {
  final laonLimitPassedObject;
  CGT2({Key key, this.laonLimitPassedObject}) : super(key: key);
  
  @override
  _CGT2 createState() => new _CGT2();
}

class _CGT2 extends State<CGT2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<bool> questionCheck;
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String branch = "";
  String mreportinguser;
  CGT2Bean cgt2bean = new CGT2Bean();
  DateTime startTime = DateTime.now();
  final dateFormat = DateFormat("yyyy, mm, dd");
  DateTime date;
  TimeOfDay time;
  String approvalAmtLimit="0.0";
  //bool isRouted = false;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    questionCheck = new List<bool>(globals.questionCGT2.length);
    getSessionVariables();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(()  {
      branch = prefs.get(TablesColumnFile.musrbrcode).toString();
      username = prefs.getString(TablesColumnFile.musrcode);
      mreportinguser = prefs.getString(TablesColumnFile.mreportinguser);
      usrRole = prefs.getString(TablesColumnFile.musrdesignation);
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
      /*approvalAmtLimit="50000.0";*/
      print("prefs.getString(TablesColumnFile.mLoanApprovalLimit)");
      cgt2bean.mstarttime = DateTime.now();


    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        bottomNavigationBar:  Container(
          color: Color(0xff07426A),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround
            ,
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.beenhere, color: Colors.green),
                onPressed: () {

                  /*if(isRouted==false&&usrGrpCode == 16){

                    _showAlert("NotAuthorized", 0);

                  }*/
                  //else{
                    print(usrGrpCode);
/*                    _submitData(1);*/

                        _showAlert("Confirm",1);





                  //}

                 // _submitData(1);
                },
              ),

              new IconButton(
                icon: new Icon(Icons.clear, color: Colors.red),
                onPressed: () {
                  _showAlert("Confirm",2);
                  //_submitData(2);
                },
              ),

            ],
          ),
        ),
        appBar: new AppBar(
          elevation: 3.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();



            } ,
          ),
          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          title: new Text(
            Translations.of(context).text('CGT2_Check')
            ,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: <Widget>[

            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
            ),
          ],
        ),
        body: new WillPopScope(
          onWillPop: (){
            Navigator.of(context).pop();
          },
            child: SingleChildScrollView(
                child: new Column(
                  children: getCard(),
                ))));
  }



  List<Widget> getCard() {
    List<Widget> listCard = new List<Widget>();
    print(globals.questionCGT2.length);
    for (int i = 0; i < globals.questionCGT2.length; i++) {
      print("here");
      listCard.add(new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
              child: CheckboxListTile(
                  value: globals.questionCGT2[i].manschecked == null ||
                      globals.questionCGT2[i].manschecked == 0
                      ? false
                      : true,
                  title: new Text(
                    globals.questionCGT2[i].mquestiondesc,
                    textAlign: TextAlign.left,
                  ),
                  onChanged: (val) {
                    setState(() {
                      globals.questionCGT2[i].manschecked = val == false ? 0 : 1;
                    });
                  })),
        ],
      ));
    }
    /*listCard.add(new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
    Flexible(
    child: CheckboxListTile(
        value: isRouted,
        title: new Text(
              "Route to Super User",
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight:FontWeight.bold),
        ),
        onChanged: (val) {
          setState(() {

            isRouted = !isRouted;
            print("is Routed ${isRouted}");
          });
        })),
        ],
    ));*/

    listCard.add(
        new Form(
          key: formKey,
          onChanged: () {
            final FormState form = formKey.currentState;
            form.save();
          },
          child: new TextFormField(
      keyboardType: TextInputType.text,
      decoration:  InputDecoration(
        hintText: Translations.of(context).text('Enter_Remarks_Here'),
        labelText: Translations.of(context).text('Remarks'),
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

      controller: cgt2bean.mremarks != null
            ? TextEditingController(text: cgt2bean.mremarks)
            : TextEditingController(text: ""),
      inputFormatters: [
          new LengthLimitingTextInputFormatter(60),
          globals.onlyAphaNumeric
      ],
      onSaved: (val) {
          //  if(val!=null) {
          cgt2bean.mremarks = val;
          // }
      },
    ),
        ));
    return listCard;
  }



  Future<Null> _submitData(int approval) async {
    int loanTrefno = widget.laonLimitPassedObject.trefno;
    int loanMrefno = widget.laonLimitPassedObject.mrefno;
    int cgt2Trefno = widget.laonLimitPassedObject.trefno;
    for (int i = 0; i < globals.questionCGT2.length; i++) {
      int id = widget.laonLimitPassedObject.trefno + i;
      globals.questionCGT2[i].mtabletleadid ="0";
      globals.questionCGT2[i].mrefno = 0;
      globals.questionCGT2[i].trefno = cgt2Trefno;
      globals.questionCGT2[i].mclcgt2refno = 0;
      await AppDatabase.get().updateCgt2QaMaster(globals.questionCGT2[i], id);
    }
    print("remarks " + cgt2bean.mremarks.toString());
    cgt2bean.trefno = widget.laonLimitPassedObject.trefno ;
    cgt2bean.mrefno = 0;
    cgt2bean.mcreatedby = username;
    cgt2bean.mendtime = DateTime.now();
    cgt2bean.mlastupdatedt = DateTime.now();
    cgt2bean.mgeologd = geoLongitude;
    cgt2bean.mgeolatd = geoLatitude;
    cgt2bean.mgeolocation = geoLocation;
    cgt2bean.loanmrefno = loanMrefno;
    cgt2bean.loantrefno =loanTrefno;
    cgt2bean.mlastupdateby = username;
    cgt2bean.mcgt2doneby= username;
    cgt2bean.mcreateddt = DateTime.now();
    if(widget.laonLimitPassedObject.mleadsid ==null||widget.laonLimitPassedObject.mleadsid.toString().trim() == 'null'){
      cgt2bean.mleadsid = "0";
    }
    else{
      cgt2bean.mleadsid = widget.laonLimitPassedObject.mleadsid;
    }

    CustomerLoanDetailsBean custLoanBean = new CustomerLoanDetailsBean();
    //custLoanBean.distbursmentStatus = "CGT1";
    custLoanBean.mleadstatus = 6;
    custLoanBean.mlastupdateby = username;
    custLoanBean.mapprovaldesc = cgt2bean.mremarks;
    if(approval==1) {
      custLoanBean.mleadstatus = 6;
        cgt2bean.mroutefrom = username;
        cgt2bean.mrouteto = mreportinguser;

      await AppDatabase.get().updateCGT2Master(cgt2bean);
      await AppDatabase.get().updateLoanDetailsStatus(
            widget.laonLimitPassedObject.trefno,
            widget.laonLimitPassedObject.mrefno, custLoanBean,DateTime.now(),cgt2bean.mrouteto,
       cgt2bean.mroutefrom,username);
     
    }else if(approval==2) {
      custLoanBean.mleadstatus = 99;
      await AppDatabase.get().updateLoanDetailsStatus(
          widget.laonLimitPassedObject.trefno, widget.laonLimitPassedObject.mrefno, custLoanBean,DateTime.now(),"","",username);
    }
    _showAlert("Submit",0);
  }

/*

  Future<bool> callDialog() async{
     //TODO this method calling twice , call it one only
    await AppDatabase.get().getLoanApprovalLimit(widget.laonLimitPassedObject.mprdcd,username).then((onValue)async{
      print(" apprvLimt "+onValue.toString());
      if(onValue >= widget.laonLimitPassedObject.mapprvdloanamt) {
        _showAlert("Confirm",1);
             }else

               {
        await onPop(
            context,
            'You Are exceeding your approval limit?',
            'Your approval limit is lesser than loan approved amount, Your approval limit is ${onValue}, '
                'Press ok to route to you supervisor for CGT2',
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
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () {
              _submitData(1);
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }

*/


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
                  alertType== "Submit"?
                  Text("Submitted Successfully !")
                      :(alertType=="Confirm"?
                  Text("Are You Sure You Want To Confirm !"):
                  Text("Please Route it as your limit ${confirmStatus}/GRP is below approval Limit !")
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
}
