import 'dart:async';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/LoanLevelScreens.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCashFlowAnalysisBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/LoanLevelService.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';





class CustomerLoanCashFlow extends StatefulWidget {
  final loanCashFlowPassedObject;
  final loanPassedObject;

  CustomerLoanCashFlow(this.loanCashFlowPassedObject,this.loanPassedObject);

  @override
  _CustomerLoanCashFlowState createState() => new _CustomerLoanCashFlowState();
}

class _CustomerLoanCashFlowState extends State<CustomerLoanCashFlow> {
  CustomerLoanCashFlowAnalysisBean loanCashFlowAnalysisBeanBean;
  SharedPreferences prefs;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _businessExpenseForm = new GlobalKey<FormState>();
  final GlobalKey<FormState> _familyExpense = new GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String userCode;
  String  mgeolocation;
  String mgeolatd;
  String mgeologd;
  double totalExp;



  @override
  void initState() {
    super.initState();

    print("Passed CashFlow Object ${widget.loanCashFlowPassedObject}");
    print("Passed Loan Object ${widget.loanPassedObject}");

    if (widget.loanCashFlowPassedObject != null) {

      loanCashFlowAnalysisBeanBean = widget.loanCashFlowPassedObject;
      calculateFamilyIncomeTotal();
      calculateFamilyExpenseTotal();
      calculateBusinessTotalTotal() ;
      calculateSurPlus();
      calculateDBR();




      } else {
      loanCashFlowAnalysisBeanBean = new CustomerLoanCashFlowAnalysisBean();
      loanCashFlowAnalysisBeanBean.mloantrefno = widget.loanPassedObject.trefno;
      loanCashFlowAnalysisBeanBean.mloanmrefno = widget.loanPassedObject.mrefno;
      loanCashFlowAnalysisBeanBean.mcusttrefno = widget.loanPassedObject.mcusttrefno;
      loanCashFlowAnalysisBeanBean.mcustmrefno = widget.loanPassedObject.mcustmrefno;
      loanCashFlowAnalysisBeanBean.mleadsid = widget.loanPassedObject.mleadsid;
    }

    getSessionVariables();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {

      userCode =
          prefs.getString(TablesColumnFile.musrcode);

      mgeolocation=
          prefs.getString(TablesColumnFile.geoLocation);

      try {
        mgeolatd =
            prefs.getDouble(TablesColumnFile.geoLatitude).toString();
        mgeologd =
            prefs.getDouble(TablesColumnFile.geoLongitude).toString();
      } catch (_) {
        print("Exception in getting loangitude");
      }
    });
  }

  Future<bool> callDialog() {
    globals.Dialog.onPop(
        context,
        'Are you sure?',
        'Do you want to Exit without saving data',
        "CreditBereauCallSubmission");
  }

  void calculateFamilyIncomeTotal() {
    print("Cominbg inside");


    if(loanCashFlowAnalysisBeanBean.mfimainbsinc==null){
      loanCashFlowAnalysisBeanBean.mfimainbsinc = 0.0;
    }
    if(loanCashFlowAnalysisBeanBean.mfisubbusinc==null){
      loanCashFlowAnalysisBeanBean.mfisubbusinc = 0.0;
    }
    if(loanCashFlowAnalysisBeanBean.mfirentalinc==null){
      loanCashFlowAnalysisBeanBean.mfirentalinc = 0.0;
    }
    if(loanCashFlowAnalysisBeanBean.mfiotherinc==null){
      loanCashFlowAnalysisBeanBean.mfiotherinc = 0.0;
    }




    if (loanCashFlowAnalysisBeanBean != null &&
        loanCashFlowAnalysisBeanBean.mfimainbsinc != null &&
        loanCashFlowAnalysisBeanBean.mfisubbusinc != null &&
        loanCashFlowAnalysisBeanBean.mfirentalinc != null &&
        loanCashFlowAnalysisBeanBean.mfiotherinc != null) {
      print("Coming inside it also");
      setState(() {
        loanCashFlowAnalysisBeanBean.mfitotalInc =
            loanCashFlowAnalysisBeanBean.mfimainbsinc +
                loanCashFlowAnalysisBeanBean.mfisubbusinc +
                loanCashFlowAnalysisBeanBean.mfirentalinc +
                loanCashFlowAnalysisBeanBean.mfiotherinc;
      });
    } else {
      loanCashFlowAnalysisBeanBean.mfitotalInc = 0.0;
    }
  }

  void calculateBusinessTotalTotal() {

    if(loanCashFlowAnalysisBeanBean.mbepurequipments==null){
      loanCashFlowAnalysisBeanBean.mbepurequipments = 0.0;
    }
    if(loanCashFlowAnalysisBeanBean.mbepetrolcost==null){
      loanCashFlowAnalysisBeanBean.mbepetrolcost = 0.0;
    }
    if(loanCashFlowAnalysisBeanBean.mbewages==null){
      loanCashFlowAnalysisBeanBean.mbewages = 0.0;
    }
    if(loanCashFlowAnalysisBeanBean.mberent==null){
      loanCashFlowAnalysisBeanBean.mberent = 0.0;
    }
    if(loanCashFlowAnalysisBeanBean.mbeeemi==null){
      loanCashFlowAnalysisBeanBean.mbeeemi = 0.0;
    }



    if (loanCashFlowAnalysisBeanBean != null &&
        loanCashFlowAnalysisBeanBean.mbepurequipments != null &&
        loanCashFlowAnalysisBeanBean.mbepetrolcost != null &&
        loanCashFlowAnalysisBeanBean.mbewages != null &&
        loanCashFlowAnalysisBeanBean.mberent != null &&
        loanCashFlowAnalysisBeanBean.mbeeemi != null) {
      print(loanCashFlowAnalysisBeanBean.mbetotalbusexp);
      setState(() {
        loanCashFlowAnalysisBeanBean.mbetotalbusexp =
            loanCashFlowAnalysisBeanBean.mbepurequipments +
                loanCashFlowAnalysisBeanBean.mbepetrolcost +
                loanCashFlowAnalysisBeanBean.mbewages +
                loanCashFlowAnalysisBeanBean.mberent+
                loanCashFlowAnalysisBeanBean.mbeeemi
        ;

      });
    } else {
      print("Going inside else");
      loanCashFlowAnalysisBeanBean.mbetotalbusexp = 0.0;
    }
  }


  void calculateFamilyExpenseTotal() {

    if(loanCashFlowAnalysisBeanBean.mfefoodexp==null){
      loanCashFlowAnalysisBeanBean.mfefoodexp = 0.0;
    }
    if(loanCashFlowAnalysisBeanBean.mfemobileexp==null){
      loanCashFlowAnalysisBeanBean.mfemobileexp = 0.0;
    }
    if(loanCashFlowAnalysisBeanBean.mfemedicalexp==null){
      loanCashFlowAnalysisBeanBean.mfemedicalexp = 0.0;
    }
    if(loanCashFlowAnalysisBeanBean.mfeschoolfees==null){
      loanCashFlowAnalysisBeanBean.mfeschoolfees = 0.0;
    }
    if(loanCashFlowAnalysisBeanBean.mfecollegefees==null){
      loanCashFlowAnalysisBeanBean.mfecollegefees = 0.0;
    }
    if(loanCashFlowAnalysisBeanBean.mfemiscellaneous==null){
      loanCashFlowAnalysisBeanBean.mfemiscellaneous = 0.0;
    }
    if(loanCashFlowAnalysisBeanBean.mfeelectricity==null){
      loanCashFlowAnalysisBeanBean.mfeelectricity = 0.0;
    }
    if(loanCashFlowAnalysisBeanBean.mfesocialcharity==null){
      loanCashFlowAnalysisBeanBean.mfesocialcharity = 0.0;
    }


    print("Calculating Family Total");
    if (loanCashFlowAnalysisBeanBean != null &&
        loanCashFlowAnalysisBeanBean.mfefoodexp != null &&
        loanCashFlowAnalysisBeanBean.mfemobileexp != null &&
        loanCashFlowAnalysisBeanBean.mfemedicalexp != null &&
        loanCashFlowAnalysisBeanBean.mfeschoolfees != null &&
    loanCashFlowAnalysisBeanBean.mfecollegefees != null &&
    loanCashFlowAnalysisBeanBean.mfemiscellaneous != null &&
    loanCashFlowAnalysisBeanBean.mfeelectricity != null &&
        loanCashFlowAnalysisBeanBean.mfesocialcharity != null
    ) {
      setState(() {
        loanCashFlowAnalysisBeanBean.mfetotalexp =
            loanCashFlowAnalysisBeanBean.mfefoodexp +
                loanCashFlowAnalysisBeanBean.mfemobileexp +
                loanCashFlowAnalysisBeanBean.mfemedicalexp +
                loanCashFlowAnalysisBeanBean.mfeschoolfees +
                loanCashFlowAnalysisBeanBean.mfecollegefees +
                loanCashFlowAnalysisBeanBean.mfemiscellaneous +
                loanCashFlowAnalysisBeanBean.mfeelectricity +
                loanCashFlowAnalysisBeanBean.mfesocialcharity ;
      });
    }
    else{
      loanCashFlowAnalysisBeanBean.mfetotalexp = 0.0;
    }
  }

  void calculateSurPlus(){
    if(loanCashFlowAnalysisBeanBean.mfitotalInc==null){
      loanCashFlowAnalysisBeanBean.mfitotalInc =0.0;
    }
    if(loanCashFlowAnalysisBeanBean.mbetotalbusexp==null){
      loanCashFlowAnalysisBeanBean.mbetotalbusexp =0.0;
    }
    if(loanCashFlowAnalysisBeanBean.mfetotalexp==null){
      loanCashFlowAnalysisBeanBean.mfetotalexp =0.0;
    }


    print("Calculating surplus cash");
    if(loanCashFlowAnalysisBeanBean.mfitotalInc!=null&&loanCashFlowAnalysisBeanBean.mbetotalbusexp!=null&&
        loanCashFlowAnalysisBeanBean.mfetotalexp!=null
    ){
      setState(() {
        totalExp =  loanCashFlowAnalysisBeanBean.mbetotalbusexp + loanCashFlowAnalysisBeanBean.mfetotalexp;
        loanCashFlowAnalysisBeanBean.msurpluscash = loanCashFlowAnalysisBeanBean.mfitotalInc-(
            loanCashFlowAnalysisBeanBean.mbetotalbusexp+ loanCashFlowAnalysisBeanBean.mfetotalexp

        );
        print(loanCashFlowAnalysisBeanBean.msurpluscash );
      });

    }
    else{
      setState(() {
        loanCashFlowAnalysisBeanBean.msurpluscash = 0.0;
      });

    }

  }



  void calculateDBR(){

    if(loanCashFlowAnalysisBeanBean.msurpluscash!=null&&loanCashFlowAnalysisBeanBean.msurpluscash>0
    ){

      double frequencyCount = 0.0;
      if(widget.loanPassedObject.mfrequency.trim()=="F"  ) frequencyCount =14;
      else  if(widget.loanPassedObject.mfrequency.trim()=="W"  ) frequencyCount =28;
      else if(widget.loanPassedObject.mfrequency.trim()=="M"  ) frequencyCount =30;
      else if(widget.loanPassedObject.mfrequency.trim()=="L"  ) frequencyCount =28;

      print("misntallment amoungt ${widget.loanPassedObject.mappldloanamt}");
      print("frequency count $frequencyCount");
      print("Surplus amount ${loanCashFlowAnalysisBeanBean.msurpluscash}");

      setState(() {
        loanCashFlowAnalysisBeanBean.mdbr =
            ((widget.loanPassedObject.minstamt/frequencyCount)*30)/(loanCashFlowAnalysisBeanBean.msurpluscash);
        //loanCashFlowAnalysisBeanBean.mdbr = loanCashFlowAnalysisBeanBean.mdbr.roundToDouble();
      });

      try{
        loanCashFlowAnalysisBeanBean.mdbr = double.parse(loanCashFlowAnalysisBeanBean.mdbr.toStringAsFixed(2));
      }
      catch(_){

        loanCashFlowAnalysisBeanBean.mdbr = 0.0;
      }

      //loanCashFlowAnalysisBeanBean.mdbr= loanCashFlowAnalysisBeanBean.mdbr;
    }
    else{
      loanCashFlowAnalysisBeanBean.mdbr = 0.0;
    }

  }

  bool validatFields() {
    bool validatonDone = true;


    if (loanCashFlowAnalysisBeanBean.mfitotalInc == null ||
    loanCashFlowAnalysisBeanBean.mfitotalInc == 0.0) {
    _showAlert(Translations.of(context).text('total_income'),
    Translations.of(context).text('It_Is_Mandatory'));
    //_tabController.animateTo(0);
    return false;
    }
    else if (loanCashFlowAnalysisBeanBean.mfetotalexp == null) {
    _showAlert(Translations.of(context).text('TOTAL_EXPENSES'),
    Translations.of(context).text('It_Is_Mandatory'));
    //_tabController.animateTo(0);
    return false;
    } else if (loanCashFlowAnalysisBeanBean.msurpluscash == null) {
    _showAlert(Translations.of(context).text('SURPLUS_CASH_IN_HAND'),
    Translations.of(context).text('It_Is_Mandatory'));
    //_tabController.animateTo(0);
    return false;
    }


/*
    if (loanCashFlowAnalysisBeanBean.mfimainbsinc == null) {
      _showAlert(Translations.of(context).text('Main_Business_Income'),
          Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    } else if (loanCashFlowAnalysisBeanBean.mfisubbusinc == null) {
      _showAlert(Translations.of(context).text('Sub_Business_Income'),
          Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    } else if (loanCashFlowAnalysisBeanBean.mfirentalinc == null) {
      _showAlert(Translations.of(context).text('Rental_income'),
          Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    } else if (loanCashFlowAnalysisBeanBean.mfiotherinc == null) {
      _showAlert(Translations.of(context).text('Other_Income'),
          Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    } else if (loanCashFlowAnalysisBeanBean.mfitotalInc == null ||
        loanCashFlowAnalysisBeanBean.mfitotalInc == 0.0) {
      _showAlert(Translations.of(context).text('total_income'),
          Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    } else if (loanCashFlowAnalysisBeanBean.mbepurequipments == null) {
      _showAlert(Translations.of(context).text('Purchase_Goods_Equipment'),
          Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    } else if (loanCashFlowAnalysisBeanBean.mbepetrolcost == null) {
      _showAlert(Translations.of(context).text('Petrol_cost'),
          Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    } else if (loanCashFlowAnalysisBeanBean.mbewages == null) {
      _showAlert(Translations.of(context).text('Wages'),
          Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    } else if (loanCashFlowAnalysisBeanBean.mberent == null) {
      _showAlert(Translations.of(context).text('fRent/Utility'),
          Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    } else if (loanCashFlowAnalysisBeanBean.mbeeemi == null) {
      _showAlert(Translations.of(context).text('Loan_obligations – EMI'),
          Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    } else if (loanCashFlowAnalysisBeanBean.mbetotalbusexp == null) {
      _showAlert(Translations.of(context).text('Total_Business_Expenses'),
          Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    } else if (loanCashFlowAnalysisBeanBean.mfeschoolfees == null) {
      _showAlert(Translations.of(context).text('School_Fees'),
          Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    } else if (loanCashFlowAnalysisBeanBean.mfecollegefees == null) {
      _showAlert(Translations.of(context).text('College_Fees'),
          Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    } else if (loanCashFlowAnalysisBeanBean.mfemiscellaneous == null) {
      _showAlert(Translations.of(context).text('Miscellaneous'),
          Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    } else if (loanCashFlowAnalysisBeanBean.mfeelectricity == null) {
      _showAlert(Translations.of(context).text('Electricity'),
          Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    } else if (loanCashFlowAnalysisBeanBean.mfesocialcharity == null) {
      _showAlert(Translations.of(context).text('Social_Charity'),
          Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    } *//*else if (loanCashFlowAnalysisBeanBean.mfetotalfaminc == null) {
      _showAlert(Translations.of(context).text('Total_Family_Expenses'),
          Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    }*//* else if (loanCashFlowAnalysisBeanBean.mfetotalexp == null) {
      _showAlert(Translations.of(context).text('TOTAL_EXPENSES'),
          Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    } else if (loanCashFlowAnalysisBeanBean.msurpluscash == null) {
      _showAlert(Translations.of(context).text('SURPLUS_CASH_IN_HAND'),
          Translations.of(context).text('It_Is_Mandatory'));
      //_tabController.animateTo(0);
      return false;
    }*/
    else return true;
  }



  Future<void> _successfulSubmit() async {
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
                  Text(Translations.of(context).text('submit_Successful')),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                onPressed: () async {
                  // CustomerLoanDetailsList.count = 1;
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();

                },
              ),
            ],
          );
        });
  }



  Future<void> _showAlert(arg, error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$arg" + Translations.of(context).text('error')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$error'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(Translations.of(context).text('Ok')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                  Navigator.of(context).pop();
                },
              ),
              backgroundColor: Color(0xff01579b),
              brightness: Brightness.light,
              title: new Text(
                Translations.of(context).text('Loan_cashFlow'),
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
                    icon: const Icon(
                      Icons.save,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: () async {
                      //Save Command
                      bool validate = validatFields();
                      if (validate) {

                        await AppDatabase.get().getMaxtrefNumber().then((int onValue)async {

                          print("returned trefno ${onValue}");


                          loanCashFlowAnalysisBeanBean.mrefno = 0;
                          if(widget.loanCashFlowPassedObject==null){

                            loanCashFlowAnalysisBeanBean.mcreateddt = DateTime.now();
                            loanCashFlowAnalysisBeanBean.mcreatedby = userCode;
                            loanCashFlowAnalysisBeanBean.trefno = onValue;
                          }

                          loanCashFlowAnalysisBeanBean.mlastupdatedt = DateTime.now();
                          loanCashFlowAnalysisBeanBean.missynctocoresys = 0;

                          loanCashFlowAnalysisBeanBean.mlastupdateby = userCode;
                          loanCashFlowAnalysisBeanBean.mgeolocation = mgeolocation;
                          loanCashFlowAnalysisBeanBean.mgeologd = mgeologd;
                          loanCashFlowAnalysisBeanBean.mgeolatd = mgeolatd;


                          await AppDatabase.get()
                              .updateCustomerLoanCashFlowMaster(
                              loanCashFlowAnalysisBeanBean)
                              .then((val) {


                            _successfulSubmit();


                          });

                        });

                      }
                    }),
              ],
            ),
           bottomNavigationBar: BottomAppBar(
             clipBehavior: Clip.antiAlias,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 new Container(
                   color: Colors.white,
                   width: 200.0
                   ,child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: new TextField(


                       controller: new TextEditingController(text:loanCashFlowAnalysisBeanBean.msurpluscash==null?"":
                       loanCashFlowAnalysisBeanBean.msurpluscash.toString()),
                     enabled: false,
                       decoration: new InputDecoration(
                           border: new OutlineInputBorder(
                               borderSide: new BorderSide(color: Colors.teal)),
                           hintText: Translations.of(context)
                               .text('SURPLUS_CASH_IN_HAND',),
                           labelText: Translations.of(context)
                               .text('SURPLUS_CASH_IN_HAND'),
                           hintStyle: TextStyle(fontStyle: FontStyle.italic),
                           prefixText: '',
                           suffixText: '',
                           suffixStyle: const TextStyle(color: Colors.green))



                 ),
                   ),
                 ),

                 new Container(
                   color: Colors.white,
                     width: 200.0,
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: new TextField(

                         enabled: false,

                         controller: new TextEditingController(text:loanCashFlowAnalysisBeanBean.mdbr==null?"":
                         loanCashFlowAnalysisBeanBean.mdbr.toString()),
                         decoration: new InputDecoration(
                             border: new OutlineInputBorder(
                                 borderSide: new BorderSide(color: Colors.teal)),
                             hintText: Translations.of(context)
                                 .text('DBR'),
                             labelText: Translations.of(context)
                                 .text('DBR'),
                             prefixText: '',
                             suffixText: '',
                             suffixStyle: const TextStyle(color: Colors.green))


                     ),
                   ),
                 )
               ],
             ),
           ),



            body: new SafeArea(
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  SizedBox(height: 10.0,)
                  ,new TextField(
                    controller: new TextEditingController(
                        text:

                        "${loanCashFlowAnalysisBeanBean.mloantrefno == null? "0" : loanCashFlowAnalysisBeanBean.mloantrefno}"
                            "/${loanCashFlowAnalysisBeanBean.mloanmrefno == null? "0" : loanCashFlowAnalysisBeanBean.mloanmrefno}"
                            "/${loanCashFlowAnalysisBeanBean.mleadsid == null||loanCashFlowAnalysisBeanBean.mleadsid.trim()=="null" ? "0" : loanCashFlowAnalysisBeanBean.mleadsid}"),
                    enabled: false,
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        hintText: Translations.of(context)
                            .text('Leads_Id_Leads_Refno'),
                        labelText: Translations.of(context)
                            .text('Leads_Id_Leads_Refno'),
                        prefixText: '',
                        suffixText: '',
                        suffixStyle: const TextStyle(color: Colors.green)),
                  ),
                  new Container(
                      child: new Form(
                          key: _formKey,
                          autovalidate: false,
                          onChanged: () {
                            final FormState _form1 = _formKey.currentState;
                            _form1.save();
                            calculateFamilyIncomeTotal();
                            calculateSurPlus();
                            calculateDBR();
                          },

                          /*onWillPop: () {
                    return Future(() => true);
                  },*/
                          child:
                              /*new Table(
                            children: [TableRow(), TableRow()],
                          )*/
                              new Column(children: <Widget>[
                            Container(
                              decoration:
                                  BoxDecoration(color: Constant.mandatoryColor),
                              child: new Row(
                                children: <Widget>[
                                  Text(
                                    Translations.of(context)
                                        .text('family_income'),
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 25.0),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("a. " +
                                          Translations.of(context)
                                              .text('Main_Business_Income')),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      onSaved: (String value) {
                                        try {
                                          loanCashFlowAnalysisBeanBean
                                                  .mfimainbsinc =
                                              double.parse(value);
                                        } catch (_) {}
                                      },
                                      initialValue:loanCashFlowAnalysisBeanBean.mfimainbsinc==null?"":loanCashFlowAnalysisBeanBean.mfimainbsinc.toString(),
                                      /*controller: new TextEditingController(
                                          text: loanCashFlowAnalysisBeanBean
                                                      .mfimainbsinc ==
                                                  null
                                              ? ""
                                              : loanCashFlowAnalysisBeanBean
                                                  .mfimainbsinc
                                                  .toString()),*/
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('Amount'),
//                                          labelText: Translations.of(context)
//                                              .text('Amount'),
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("b. " +
                                          Translations.of(context)
                                              .text('Sub_Business_Income')),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      onSaved: (String value) {
                                        try {
                                          loanCashFlowAnalysisBeanBean
                                                  .mfisubbusinc =
                                              double.parse(value);
                                        } catch (_) {}
                                      },
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      initialValue: loanCashFlowAnalysisBeanBean
                                                  .mfisubbusinc ==
                                              null
                                          ? ""
                                          : loanCashFlowAnalysisBeanBean
                                              .mfisubbusinc
                                              .toString(),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('Amount'),
                                          /*labelText: Translations.of(context)
                                              .text('Amount'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("c. " +
                                          Translations.of(context)
                                              .text('Rental_income')),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      onSaved: (String value) {
                                        try {
                                          loanCashFlowAnalysisBeanBean
                                                  .mfirentalinc =
                                              double.parse(value);
                                        } catch (_) {}
                                      },
                                      initialValue:  loanCashFlowAnalysisBeanBean
                                          .mfirentalinc ==
                                          null
                                          ? ""
                                          : loanCashFlowAnalysisBeanBean
                                          .mfirentalinc
                                          .toString(),
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('Amount'),
                                          /*labelText: Translations.of(context)
                                              .text('Amount'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("d. " +
                                          Translations.of(context)
                                              .text('Other_Income')),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      onSaved: (String value) {
                                        try {
                                          loanCashFlowAnalysisBeanBean
                                                  .mfiotherinc =
                                              double.parse(value);
                                        } catch (_) {}
                                      },

                                      initialValue:  loanCashFlowAnalysisBeanBean
                                          .mfiotherinc ==
                                          null
                                          ? ""
                                          : loanCashFlowAnalysisBeanBean
                                          .mfiotherinc
                                          .toString(),
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('Amount'),
                                         /* labelText: Translations.of(context)
                                              .text('Amount'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("A. " +
                                          Translations.of(context)
                                              .text('total_income'),style: TextStyle(fontWeight: FontWeight.bold),),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      controller: loanCashFlowAnalysisBeanBean
                                                  .mfitotalInc ==
                                              null
                                          ? new TextEditingController(text: "")
                                          : new TextEditingController(
                                              text:
                                                  "${loanCashFlowAnalysisBeanBean.mfitotalInc}"),
                                      enabled: false,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('total_income'),
                                          /*labelText: Translations.of(context)
                                              .text('total_income'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]))),
                  new Container(
                      child: new Form(
                          key: _businessExpenseForm,
                          autovalidate: false,
                          onChanged: () {
                            final FormState _form2 = _businessExpenseForm.currentState;
                            _form2.save();
                            calculateBusinessTotalTotal();
                            calculateSurPlus();
                            calculateDBR();
                          },

                          /*onWillPop: () {
                    return Future(() => true);
                  },*/
                          child:
                              /*new Table(
                            children: [TableRow(), TableRow()],
                          )*/
                              new Column(children: <Widget>[
                            Container(
                              decoration:
                                  BoxDecoration(color: Constant.mandatoryColor),
                              child: new Row(
                                children: <Widget>[
                                  Text(
                                    Translations.of(context)
                                        .text('Business_Expenses'),
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 25.0),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("a. " +
                                          Translations.of(context).text(
                                              'Purchase_Goods_Equipment')),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      onSaved: (String value) {
                                        try {
                                          loanCashFlowAnalysisBeanBean
                                                  .mbepurequipments =
                                              double.parse(value);
                                        } catch (_) {}
                                      },
                                      initialValue:  loanCashFlowAnalysisBeanBean
                                          .mbepurequipments ==
                                          null
                                          ? ""
                                          : loanCashFlowAnalysisBeanBean
                                          .mbepurequipments
                                          .toString(),
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('Amount'),
                                          /*labelText: Translations.of(context)
                                              .text('Amount'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("b. " +
                                          Translations.of(context)
                                              .text('Petrol_cost')),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      onSaved: (String value) {
                                        try {
                                          loanCashFlowAnalysisBeanBean
                                                  .mbepetrolcost =
                                              double.parse(value);
                                        } catch (_) {}
                                      },
                                      initialValue:  loanCashFlowAnalysisBeanBean
                                          .mbepetrolcost ==
                                          null
                                          ? ""
                                          : loanCashFlowAnalysisBeanBean
                                          .mbepetrolcost
                                          .toString(),
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('Amount'),
                                          /*labelText: Translations.of(context)
                                              .text('Amount'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("c. " +
                                          Translations.of(context)
                                              .text('Wages')),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      onSaved: (String value) {
                                        try {
                                          loanCashFlowAnalysisBeanBean
                                              .mbewages = double.parse(value);
                                        } catch (_) {}
                                      },
                                      initialValue:  loanCashFlowAnalysisBeanBean
                                          .mbewages ==
                                          null
                                          ? ""
                                          : loanCashFlowAnalysisBeanBean
                                          .mbewages
                                          .toString(),
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('Amount'),
                                          /*labelText: Translations.of(context)
                                              .text('Amount'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("d. " +
                                          Translations.of(context)
                                              .text('Rent/Utility')),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      onSaved: (String value) {
                                        try {
                                          loanCashFlowAnalysisBeanBean.mberent =
                                              double.parse(value);
                                        } catch (_) {}
                                      },
                                      initialValue:  loanCashFlowAnalysisBeanBean
                                          .mberent ==
                                          null
                                          ? ""
                                          : loanCashFlowAnalysisBeanBean
                                          .mberent
                                          .toString(),
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('Amount'),
                                          /*labelText: Translations.of(context)
                                              .text('Amount'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("e. " +
                                          Translations.of(context)
                                              .text('Loan_obligations  EMI')),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      onSaved: (String value) {
                                        try {
                                          loanCashFlowAnalysisBeanBean.mbeeemi =
                                              double.parse(value);
                                        } catch (_) {}
                                      },
                                      initialValue:  loanCashFlowAnalysisBeanBean
                                          .mbeeemi ==
                                          null
                                          ? ""
                                          : loanCashFlowAnalysisBeanBean
                                          .mbeeemi
                                          .toString(),
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('Amount'),
                                          /*labelText: Translations.of(context)
                                              .text('Amount'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("B. " +
                                          Translations.of(context)
                                              .text('Total_Business_Expenses'),style: TextStyle(fontWeight: FontWeight.bold),),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      controller: new TextEditingController(
                                          text:
                                              "${loanCashFlowAnalysisBeanBean.mbetotalbusexp==null?"":loanCashFlowAnalysisBeanBean.mbetotalbusexp}"),
                                      enabled: false,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('total_income'),
                                          /*labelText: Translations.of(context)
                                              .text('total_income'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]))),
                  new Container(
                      child: new Form(
                          key: _familyExpense,
                          autovalidate: false,
                          onChanged: () {
                            final FormState _form3 = _familyExpense.currentState;
                            _form3.save();
                            calculateFamilyExpenseTotal();
                            calculateSurPlus();
                            calculateDBR();
                          },
                          /*onWillPop: () {
                    return Future(() => true);
                  },*/
                          child:
                              /*new Table(
                            children: [TableRow(), TableRow()],
                          )*/
                              new Column(children: <Widget>[
                            Container(
                              decoration:
                                  BoxDecoration(color: Constant.mandatoryColor),
                              child: new Row(
                                children: <Widget>[
                                  Text(
                                    Translations.of(context)
                                        .text('Family_Expenses'),
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 25.0),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("a. " +
                                          Translations.of(context)
                                              .text('Food_expenses')),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      initialValue: loanCashFlowAnalysisBeanBean.mfefoodexp==null?"":
                                      loanCashFlowAnalysisBeanBean.mfefoodexp.toString(),
                                      onSaved: (String val){
                                        try{
                                          loanCashFlowAnalysisBeanBean.mfefoodexp= double.parse(val);
                                        }catch(_){

                                        }


                                      },
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('Amount'),
                                         /* labelText: Translations.of(context)
                                              .text('Amount'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("b. " +
                                          Translations.of(context)
                                              .text('Mobile_expenses')),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      initialValue: loanCashFlowAnalysisBeanBean.mfemobileexp==null?"":
                                      loanCashFlowAnalysisBeanBean.mfemobileexp.toString(),
                                      onSaved: (String val){
                                        try{
                                          loanCashFlowAnalysisBeanBean.mfemobileexp= double.parse(val);
                                        }catch(_){

                                        }


                                      },
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('Amount'),
                                          /*labelText: Translations.of(context)
                                              .text('Amount'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("c. " +
                                          Translations.of(context)
                                              .text('Medical_expenses')),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      initialValue: loanCashFlowAnalysisBeanBean.mfemedicalexp==null?"":
                                      loanCashFlowAnalysisBeanBean.mfemedicalexp.toString(),
                                      onSaved: (String val){
                                        try{
                                          loanCashFlowAnalysisBeanBean.mfemedicalexp= double.parse(val);
                                        }catch(_){

                                        }


                                      },
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('Amount'),
                                          /*labelText: Translations.of(context)
                                              .text('Amount'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("d. " +
                                          Translations.of(context)
                                              .text('School_Fees')),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      initialValue: loanCashFlowAnalysisBeanBean.mfeschoolfees==null?"":
                                      loanCashFlowAnalysisBeanBean.mfeschoolfees.toString(),
                                      onSaved: (String val){
                                        try{
                                          loanCashFlowAnalysisBeanBean.mfeschoolfees= double.parse(val);
                                        }catch(_){

                                        }


                                      },
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('Amount'),
                                          /*labelText: Translations.of(context)
                                              .text('Amount'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("e. " +
                                          Translations.of(context)
                                              .text('College_Fees')),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      initialValue: loanCashFlowAnalysisBeanBean.mfecollegefees==null?"":
                                      loanCashFlowAnalysisBeanBean.mfecollegefees.toString(),
                                      onSaved: (String val){
                                        try{
                                          loanCashFlowAnalysisBeanBean.mfecollegefees= double.parse(val);
                                        }catch(_){

                                        }


                                      },

                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('Amount'),
                                          /*labelText: Translations.of(context)
                                              .text('Amount'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("f " +
                                          Translations.of(context)
                                              .text('Miscellaneous')),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(

                                      initialValue: loanCashFlowAnalysisBeanBean.mfemiscellaneous==null?"":
                                      loanCashFlowAnalysisBeanBean.mfemiscellaneous.toString(),
                                      onSaved: (String val){
                                        try{
                                          loanCashFlowAnalysisBeanBean.mfemiscellaneous = double.parse(val);
                                        }catch(_){

                                        }


                                      },


                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('Amount'),
                                          /*labelText: Translations.of(context)
                                              .text('Amount'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("g. " +
                                          Translations.of(context)
                                              .text('Electricity')),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      //controller: new TextEditingController(text:"${loanCashFlowAnalysisBeanBean.mfitotalInc}"),
                                      initialValue: loanCashFlowAnalysisBeanBean.mfeelectricity==null?"":
                                      loanCashFlowAnalysisBeanBean.mfeelectricity.toString(),
                                      onSaved: (String val){
                                        try{
                                          loanCashFlowAnalysisBeanBean.mfeelectricity = double.parse(val);
                                        }catch(_){

                                        }


                                      },
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('Amount'),
                                          /*labelText: Translations.of(context)
                                              .text('Amount'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("h. " +
                                          Translations.of(context)
                                              .text('Social_Charity')),
                                    )),


                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      //controller: new TextEditingController(text:"${loanCashFlowAnalysisBeanBean.mfitotalInc}"),
                                      initialValue: loanCashFlowAnalysisBeanBean.mfesocialcharity==null?"":
                                      loanCashFlowAnalysisBeanBean.mfesocialcharity.toString(),
                                      onSaved: (String val){
                                        try{
                                          loanCashFlowAnalysisBeanBean.mfesocialcharity = double.parse(val);
                                        }catch(_){

                                        }


                                      },
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('Amount'),
                                          /*labelText: Translations.of(context)
                                              .text('Amount'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text("B " +
                                          Translations.of(context)
                                              .text('Total_Family_Expenses'),style: TextStyle(fontWeight: FontWeight.bold)),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      controller: new TextEditingController(
                                          text:
                                              "${loanCashFlowAnalysisBeanBean.mfetotalexp == null?"":loanCashFlowAnalysisBeanBean.mfetotalexp}"),
                                      enabled: false,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('total_income'),
                                          /*labelText: Translations.of(context)
                                              .text('total_income'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Container(
                                      width: 200,
                                      child: new Text(Translations.of(context)
                                          .text('TOTAL_EXPENSES'),style: TextStyle(fontWeight: FontWeight.bold),),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: new Container(
                                    width: 200.0,
                                    child: new TextFormField(
                                      controller: new TextEditingController(
                                          text:
                                              "${totalExp==null?"":
                                              totalExp.toString()}"),
                                      enabled: false,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          hintText: Translations.of(context)
                                              .text('total_income'),
                                          /*labelText: Translations.of(context)
                                              .text('total_income'),*/
                                          prefixText: '',
                                          suffixText: '',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ])))
                ]),
              ),
            )));
  }





}
