import 'package:eco_mfi/pages/workflow/disbursment/list/DisbursmentList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/app_constant.dart' as oonstant;
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eco_mfi/Utilities/app_constant.dart' as labels;
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/FullScreenDialogForGroupSelection.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFoundation.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/FullScreenDialogForProductSelection.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/Savings/SavingsCollection.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/FullScreenDialogForCenterSelection.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisbursmentListSearch extends StatefulWidget {
  final String  routeType;
  DisbursmentListSearch(this.routeType);

  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );
  @override
  _DisbursmentListSearch createState() => new _DisbursmentListSearch();
}

class _DisbursmentListSearch extends State<DisbursmentListSearch> {
  TextEditingController branchController = new TextEditingController();
  TextEditingController pagesRequiredForPagination = new TextEditingController(text: "1");
  TextEditingController loanOfficerController = new TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SystemParameterBean sysBean = new SystemParameterBean();
  //AnimationController textInputAnimationController;
  FullScreenDialogForCenterSelection _myCenterDialog =
  new FullScreenDialogForCenterSelection("");
  FullScreenDialogForGroupSelection _myGroupDialog =
  new FullScreenDialogForGroupSelection("");
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  int branch = 0;
  String usrRole ="";
  String centerName="";
  String centerNo="";
  String groupName="";
  String groupNo="";
  String customerName="";
  String customerNo="";
  String productName="";
  String productNo="";
  String requiredPages="5";
  String mIsGroupNeeded = "Y";
  final dateFormat = DateFormat("yyyy/MM/dd hh:mm:ss");
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  static String FromDate = "__-__-____";
  static String ToDate = "__-__-____";
  String tempYear ;
  String tempDay ;
  String tempMonth;
  String tempYearT ;
  String tempDayT ;
  String tempMonthT;
  FocusNode monthFocus;
  FocusNode yearFocus;
  DateTime mFromDate = DateTime.now();
  DateTime mToDate = DateTime.now();
  String TodayDate=DateTime.now().toString();
  bool isHideMemberGrp = false;


  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode);
      username = prefs.getString(TablesColumnFile.musrcode);
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      if (prefs.getString(TablesColumnFile.mIsGroupLendingNeeded) != null &&
          prefs.getString(TablesColumnFile.mIsGroupLendingNeeded).trim() !=
              "") {
        mIsGroupNeeded =
            prefs.getString(TablesColumnFile.mIsGroupLendingNeeded);

        if (mIsGroupNeeded != null &&
            mIsGroupNeeded.trim().toUpperCase() == 'N') {
          globals.isMemeberOfGroupForColl = false;
        }
        List strIlo;
        if (prefs.getString(TablesColumnFile.ISINDONUSERCD) != null) {
          strIlo = prefs.getString(TablesColumnFile.ISINDONUSERCD).split(",");
        }

        print("strIlo ${strIlo}");
        List strGlo;
        if (prefs.getString(TablesColumnFile.ISGLOONUSERCD) != null) {
          strGlo = prefs.getString(TablesColumnFile.ISGLOONUSERCD).split(",");
        }
        if (mIsGroupNeeded != null &&
            mIsGroupNeeded.trim().toUpperCase() == 'Y') {
          if (strIlo != null && strIlo.contains(usrGrpCode.toString())) {
            globals.isMemeberOfGroupForDisbursed = false;
            isHideMemberGrp = true;
          } else if (strGlo != null && strGlo.contains(usrGrpCode.toString())) {
            globals.isMemeberOfGroupForDisbursed = true;
            isHideMemberGrp = true;
          }
        } else {
          globals.isMemeberOfGroupForDisbursed = false;
          isHideMemberGrp = true;
        }
      }

      branchController.value = TextEditingValue(text: branch.toString());
      loanOfficerController.value = TextEditingValue(
        text: username.toString(),
      );
      pagesRequiredForPagination.value =
          TextEditingValue(text: requiredPages.toString());
    });
    print("TodayDate"+TodayDate);
  }


  Widget otherLoan() => DisbursmentListSearch._get(new Row(
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
            groupValue: globals.isMemberOfGroupListDisbursment[position],
            onChanged: (selection) {

              if(sysBean.mcodevalue!=null&&sysBean.mcodevalue.toUpperCase() == 'N'){
                return null;
              }
              return _onRadioSelected(selection, position);

            } ,
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
    setState(() => globals.isMemberOfGroupListDisbursment[position] = selection);
    if (position == 0) {
      globals.memberOfGroupDisbursed =
      globals.radioCaptionValuesIsMemberOfGroup[selection];
      if (globals.memberOfGroupDisbursed == 'Yes') {
        globals.isMemeberOfGroupForDisbursed = true;
      } else {
        centerName = "";
        centerNo = "";
        groupName = "";
        groupNo = "";
        globals.isMemeberOfGroupForDisbursed = false;
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

  @override
  void initState() {
    super.initState();
    TextEditingController(text: "5");
    globals.isMemeberOfGroupForDisbursed =true;
    globals.memberOfGroupDisbursed = 'Yes';
    globals.isMemberOfGroupListDisbursment = [0];
    if (mounted) {
      getSessionVariables();
    }
    /*textInputAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));*/
  }

  @override
  void dispose() {
    //textInputAnimationController.dispose();
    super.dispose();
  }
  Widget appBarTitle = new Text("Disbursment Search");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();

          },
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title: appBarTitle,
      ),
      body: Form(
        key: _formKey,
        /*onWillPop: () {
            return Future(() => true);
          },*/
        onChanged: () {
          final FormState form = _formKey.currentState;
          form.save();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: TextFormField(
                        controller: branchController,
                        //initialValue: branch.toString(),
                        enabled: false,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 16.0,
                            color: Colors.black),
                        decoration: InputDecoration(
                          icon: Icon(FontAwesomeIcons.codeBranch,
                            color: Colors.amber.shade500,),
                          hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          labelText: labels.BRANCH,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: TextFormField(
                        controller: loanOfficerController,
                        enabled: false,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 16.0,
                            color: Colors.black),
                        decoration: InputDecoration(
                          icon: Icon(FontAwesomeIcons.centercode,
                            color: Colors.amber.shade500,),
                          hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          labelText: labels.LOANOFFICER,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              !isHideMemberGrp
                  ? new Table(children: [
                new TableRow(
                    decoration: new BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.1),
                    ),
                    children: [
                      getTextContainer(
                          globals.radioCaptionCenterGroupDetails[0]),
                      otherLoan(),
                    ]),
              ])
                  : Container(),
              SizedBox(height: 5.0),

           /*   new TextFormField(
                  decoration: const InputDecoration(
                    hintText:  "Enter number of records you want to see in one page",
                    labelText:  "Number of records you want to see in one page",
                    hintStyle: TextStyle(color: Colors.grey),
                    *//*labelStyle: TextStyle(color: Colors.grey),*//*
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    contentPadding: EdgeInsets.all(1.0),
                  ),
                  controller: pagesRequiredForPagination,
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(2),
                    globals.onlyIntNumber
                  ],
                  onSaved: (String value) {
                    requiredPages =
                        value;
                  }),*/
              /*globals.isMemberOfGroup*/
              SizedBox(height: 5.0),
              globals.isMemeberOfGroupForDisbursed && mIsGroupNeeded == "Y"
                  ? Card(
                color: Constant.mandatoryColor,
                child: new ListTile(
                    title: new Text(Translations.of(context).text('centerNameNo')),
                    subtitle:
                    new Text("${centerName} ${centerNo}"),
                    onTap: getCenter/*() {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  _myCenterDialog,
                              fullscreenDialog: true,
                            ));
                      },*/
                ),
              )
                  : Container(),
              SizedBox(height: 5.0),
              globals.isMemeberOfGroupForDisbursed && mIsGroupNeeded == "Y"
                  ? Card(
                color: Constant.mandatoryColor,
                child: new ListTile(
                    title: new Text(Translations.of(context).text('Group_Name/No')),
                    subtitle:
                    new Text("${groupName} ${groupNo}"),
                    onTap: getGroup/*() {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (BuildContext context) => _myGroupDialog,
                              fullscreenDialog: true,
                            ));
                      },*/
                ),
              )
                  : Container(),
              Card(
                color: Constant.mandatoryColor,
                child: new ListTile(
                    title: new Text(Translations.of(context).text('Cutomer_Name/No')),
                    subtitle:
                    new Text("${customerName} ${customerNo}"),
                    onTap: () => getCustomerNumber()),
              ),
           /*   Card(
                color: Constant.mandatoryColor,
                child: new ListTile(
                    title: new Text(Translations.of(context).text('Product_Name/No')),
                    subtitle:
                    new Text("${productName} ${productNo}"),
                    onTap: () => getProduct()),
              ),
*/

              SizedBox(height: 20.0,),
              Container(
                decoration: BoxDecoration(color: Constant.mandatoryColor),
                child: new Row(

                  children: <Widget>[

                   Text("From Date")

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

                          controller: tempDay == null?new TextEditingController(text: TodayDate.substring(8,10)):new TextEditingController(text: tempDay),
                          keyboardType: TextInputType.numberWithOptions(),

                          onChanged: (val){

                            if(val!="0"){
                              tempDay = val;


                              if(int.parse(val)<=31&&int.parse(val)>0){



                                if(val.length==2){
                                  FromDate = FromDate.replaceRange(0, 2, val);
                                  FocusScope.of(context).requestFocus(monthFocus);
                                }
                                else{
                                  FromDate= FromDate.replaceRange(0, 2, "0"+val);
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
                        controller: tempMonth == null?new TextEditingController(text: TodayDate.substring(5,7)):new TextEditingController(text: tempMonth),
                        onChanged: (val){
                          if(val!="0"){
                            tempMonth = val;
                            if(int.parse(val)<=12&&int.parse(val)>0){

                              if(val.length==2){
                                FromDate =FromDate.replaceRange(3, 5, val);

                                FocusScope.of(context).requestFocus(yearFocus);
                              }
                              else{
                                FromDate= FromDate.replaceRange(3, 5, "0"+val);
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
                        controller: tempYear == null?new TextEditingController(text: TodayDate.substring(0,4)):new TextEditingController(text: tempYear),
                        onChanged: (val){
                          tempYear = val;
                          if(val.length==4) FromDate = FromDate.replaceRange(6, 10,val);

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
                child: new Row(

                  children: <Widget>[

                    Text("To Date")

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
                          controller: tempDayT == null?new TextEditingController(text: TodayDate.substring(8,10)):new TextEditingController(text: tempDayT),
                          keyboardType: TextInputType.numberWithOptions(),

                          onChanged: (val){

                            if(val!="0"){
                              tempDayT = val;


                              if(int.parse(val)<=31&&int.parse(val)>0){



                                if(val.length==2){
                                  ToDate = ToDate.replaceRange(0, 2, val);
                                  FocusScope.of(context).requestFocus(monthFocus);
                                }
                                else{
                                  ToDate= ToDate.replaceRange(0, 2, "0"+val);
                                }


                              }
                              else {
                                setState(() {
                                  tempDayT ="";
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
                        controller: tempMonthT == null?new TextEditingController(text: TodayDate.substring(5,7)):new TextEditingController(text: tempMonthT),
                        onChanged: (val){
                          if(val!="0"){
                            tempMonthT = val;
                            if(int.parse(val)<=12&&int.parse(val)>0){

                              if(val.length==2){
                                ToDate =ToDate.replaceRange(3, 5, val);

                                FocusScope.of(context).requestFocus(yearFocus);
                              }
                              else{
                                ToDate= ToDate.replaceRange(3, 5, "0"+val);
                              }
                            }
                            else {
                              setState(() {
                                tempMonthT ="";
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
                        controller: tempYearT == null?new TextEditingController(text: TodayDate.substring(0,4)):new TextEditingController(text: tempYearT),
                        onChanged: (val){
                          tempYearT = val;
                          if(val.length==4) ToDate = ToDate.replaceRange(6, 10,val);

                        },
                      ),)
                    ,

                    SizedBox(
                      width: 50.0,
                    ),

                    IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                      _selectDateT(context);
                    } )
                  ],


                ),

              ),

              SizedBox(height: 5.0),
              new TextFormField(
                  decoration: const InputDecoration(
                    hintText: labels.ENTERPAGESCOUNT,
                    labelText:  labels.PAGESCOUNT,
                    hintStyle: TextStyle(color: Colors.grey),
                    /*labelStyle: TextStyle(color: Colors.grey),*/
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  controller: pagesRequiredForPagination,
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(2),
                    globals.onlyIntNumber
                  ],
                  onSaved: (String value) {
                    requiredPages = value;
                  }),

              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: OutlineButton(
                            borderSide:
                            BorderSide(color: Colors.amber.shade500),
                            child: Text(oonstant.searchList),
                            textColor: Colors.amber.shade500,
                            onPressed: () {
                              if(globals.isMemeberOfGroupForDisbursed==true&&(groupNo==null || groupNo.trim()=='null'&& groupNo.trim()=='')){
                                _showAlert(Translations.of(context).text('GROUPID'), Translations.of(context).text('itIsMand'));
                                return;
                              }


                              int mcenterid;
                              int mgroupid ;
                              int custNo;
                              int prcdNo;
                              int paginationCount;
                              DateTime fromdate;
                              DateTime todate;
                              print("Sending from date $mFromDate");
                              print("Sending to date $mToDate");

                        try{
                          mcenterid =  centerNo!=null && centerNo.trim()!='null'&& centerNo.trim()!=''?int.parse(centerNo.trim()):0;
                          mgroupid =groupNo!=null && groupNo.trim()!='null'&& groupNo.trim()!=''?int.parse(groupNo.trim()):0;
                          custNo =customerNo!=null && customerNo.trim()!='null'&& customerNo.trim()!=''?int.parse(customerNo.trim()):0;
                          prcdNo =productNo!=null && productNo.trim()!='null'&& productNo.trim()!=''?int.parse(productNo.trim()):0;
                          paginationCount =requiredPages!=null && requiredPages.trim()!='null'&& requiredPages.trim()!=''?int.parse(requiredPages.trim()):0;
                          fromdate=mFromDate;
                          todate=mToDate;

                        }catch(_){
                          print("Exception while parsing int in serach screen crieteria");
                        }

                              if (/*globals.isMemberOfGroup*/ globals.isMemeberOfGroupForSvngColl= /*true*/false) {
                                mcenterid=0;
                                mgroupid=0;

                        }

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DisbursmentList(mcenterid,mgroupid,custNo,fromdate,todate,widget.routeType)));
                            },
                            shape: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                      ),
                    /*  Container(
                        alignment: Alignment.center,
                        child: OutlineButton(
                            borderSide:
                            BorderSide(color: Colors.amber.shade500),
                            child: Text("Select Type To Print"),
                            textColor: Colors.amber.shade500,
                            onPressed: (){
                              int mcenterid;
                              int mgroupid ;
                              int custNo;


                              try{
                                mcenterid =  centerNo!=null && centerNo.trim()!='null'&& centerNo.trim()!=''?int.parse(centerNo.trim()):0;
                                mgroupid =groupNo!=null && groupNo.trim()!='null'&& groupNo.trim()!=''?int.parse(groupNo.trim()):0;
                                custNo =customerNo!=null && customerNo.trim()!='null'&& customerNo.trim()!=''?int.parse(customerNo.trim()):0;
                              }catch(_){
                                print("Exception while parsing int in serach screen crieteria");
                              }

                              if ( globals.isMemeberOfGroupForSvngColl= false) {
                                mcenterid=0;
                                mgroupid=0;

                              }

                              _TypesOfPrint(
                                  mcenterid,mgroupid,custNo);
                            },

                            shape: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                      ),*/
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

/*
  Future<void> _TypesOfPrint(int mcenterid, int mgroupid, int custNo) async {
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
                        title: new Text(('On The Basis Of Center')),
                        subtitle:
                        new Text(mcenterid.toString()!="0"?mcenterid.toString():"",style: TextStyle(color: Colors.blue[800])),
                        onTap: () =>  IsCenterPresent(mcenterid)),),

                  Card(
                    child: new ListTile(
                        title: new Text(('On The Basis Of Group')),
                        subtitle:
                        new Text(mgroupid.toString()!="0"?mgroupid.toString():"",style: TextStyle(color: Colors.blue[800])),
                        onTap: () =>  IsGroupPresent(mgroupid)),),

                  Card(
                    child: new ListTile(
                        title: new Text(('On The Basis Of Customer')),
                        subtitle:
                        new Text(custNo.toString()!="0"?custNo.toString():"",style: TextStyle(color: Colors.blue[800])),
                        onTap: () =>  IsCustNoPresent(custNo)),),
                  Card(
                    child: new ListTile(
                        title: new Text(("Today's Records")),
                        subtitle:
                        new Text(DateTime.now().toString().substring(0,11),style: TextStyle(color: Colors.blue[800])),
                        onTap: () => TodaysRecords()),
                  ),
                ],
              ),
            ),
          );
        });
  }*/
/*  IsCenterPresent(int mcenterid)  async{
    if (!centerPresent(mcenterid)) {
      return;
    }
    await AppDatabase.get()
        .getSavingListOnCenter(mcenterid)
        .then((List<SavingsListBean> savingsListBean) {
      print("val here is " + savingsListBean.toString());
      if(savingsListBean.isEmpty){
        _CheckIfThere();
      }
      else {
        _callChannelSvngCollCenter(savingsListBean);
      }

    });
  }*/
 /* Future<void> _CheckIfThere() async {

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.cancel,
              color: Colors.red,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Text(
                          Translations.of(context).text('No_Records_Found')),
                    ],
                  ),
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
        });
  }
*/
/*  IsGroupPresent(int mgroupid)  async{
    if (!groupPresent(mgroupid)) {
      return;
    }
    await AppDatabase.get()
        .getSavingListOnGroup(mgroupid)
        .then((List<SavingsListBean> savingsListBean) {
      print("val here is " + savingsListBean.toString());
      if(savingsListBean.isEmpty){
        _CheckIfThere();
      }
      else {
        _callChannelSvngCollGroup(savingsListBean);
      }
    });
  }*/
 /* IsCustNoPresent(int custNo)  async{
    if (!custNoPresent(custNo)) {
      return;
    }
    await AppDatabase.get()
        .getSavingListOnCustNo(custNo)
        .then((List<SavingsListBean> savingsListBean) {
      print("val here is " + savingsListBean.toString());
      if(savingsListBean.isEmpty){
        _CheckIfThere();
      }
      else {
        _callChannelSvngCollCustNo(savingsListBean);
      }
    });
  }*/
 /* TodaysRecords() async{
    await AppDatabase.get()
        .getTodaysSavingList()
        .then((List<SavingsListBean> savingsListBean) {
      print("val here is " + savingsListBean.toString());
      if(savingsListBean.isEmpty){
        _CheckIfThere();
      }
      else {
        _callChannelSvngCollToday(savingsListBean);
      }
    });
  }*/
 /* _callChannelSvngCollCenter(List<SavingsListBean> savingsListBeanList) async{
    String repeatedStringAmount = "";
print("savingsListBeanList"+savingsListBeanList.toString());
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    print("bluetoothAddress $bluetootthAdd");
if(savingsListBeanList!=null&&savingsListBeanList!="") {
  for (var items in savingsListBeanList) {
    repeatedStringAmount =
        items.mcollectedamount.toString() +"~"+ repeatedStringAmount;
  }
  print("repeatedStringAmount" + repeatedStringAmount);
  String repeatedStringEntryDate = "";
  for (var items in savingsListBeanList) {
    repeatedStringEntryDate = items.mentrydate.toString()+"~"+repeatedStringEntryDate;
  }
  print("repeatedStringEntryDate" + repeatedStringEntryDate);

  String repeatedStringprdAccId = "";
  for (var items in savingsListBeanList) {
    print("items.mprdacctid"+items.mprdacctid.toString());
    if(items.mprdacctid.trim()!='') {
      repeatedStringprdAccId =
          int.parse(items.mprdacctid.substring(0, 8)).toString() +
              "/" +
              int.parse(items.mprdacctid.substring(8, 16)).toString() +
              "/" +
              int.parse(items.mprdacctid.substring(16, 24)).toString() +
              "~" +
              repeatedStringprdAccId;
    }
    if(items.mprdacctid.trim()==''){
      repeatedStringprdAccId="AccId Not Found"+"~"+
          repeatedStringprdAccId;
    }
  }
  print("repeatedStringprdAccId"+repeatedStringprdAccId.toString());
  String mlbrcode = savingsListBeanList[0].mlbrcode.toString()!=""?savingsListBeanList[0].mlbrcode.toString():"";
  String mcenterid = savingsListBeanList[0].mcenterid.toString();
  String date = dateFormat.format(DateTime.now());
 // String mlongname = savingsListBeanList[0].mlongname.toString();

  try {
    final String result = await platform.invokeMethod("svngcollcenterprint",
        {"BluetoothADD": bluetootthAdd,
          "mlbrcode": mlbrcode,
          "date": date,
          "mcenterid": mcenterid,
          "repeatedStringAmount": repeatedStringAmount,
          "repeatedStringprdAccId": repeatedStringprdAccId,
          "repeatedStringEntryDate": repeatedStringEntryDate
        });
    String geTest = 'geTest at $result';
    print("FLutter : " + geTest.toString());
  } on PlatformException catch (e) {
    print("FLutter : " + e.message.toString());
  }
}
  }*/

/*  _callChannelSvngCollGroup(List<SavingsListBean> savingsListBeanList) async{
    String repeatedStringAmount = "";
    print("savingsListBeanList"+savingsListBeanList.toString());
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    print("bluetoothAddress $bluetootthAdd");
    if(savingsListBeanList!=null&&savingsListBeanList!="") {
      for (var items in savingsListBeanList) {
        repeatedStringAmount =
            items.mcollectedamount.toString() +"~"+ repeatedStringAmount;
      }
      print("repeatedStringAmount" + repeatedStringAmount);
      String repeatedStringEntryDate = "";
      for (var items in savingsListBeanList) {
        repeatedStringEntryDate = items.mentrydate.toString()+"~"+repeatedStringEntryDate;
      }
      print("repeatedStringEntryDate" + repeatedStringEntryDate);

      String repeatedStringprdAccId = "";
      for (var items in savingsListBeanList) {
        print("items.mprdacctid"+items.mprdacctid.toString());
        if(items.mprdacctid.trim()!='') {
          repeatedStringprdAccId =
              int.parse(items.mprdacctid.substring(0, 8)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(8, 16)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(16, 24)).toString() +
                  "~" +
                  repeatedStringprdAccId;
        }
        if(items.mprdacctid.trim()==''){
          repeatedStringprdAccId="AccId Not Found"+"~"+
              repeatedStringprdAccId;
        }
      }
      print("repeatedStringprdAccId"+repeatedStringprdAccId.toString());
      String mlbrcode = savingsListBeanList[0].mlbrcode.toString()!=""?savingsListBeanList[0].mlbrcode.toString():"";
      String mgroupcd = savingsListBeanList[0].mgroupcd.toString();
      String date = dateFormat.format(DateTime.now());
      // String mlongname = savingsListBeanList[0].mlongname.toString();

      try {
        final String result = await platform.invokeMethod("svngcollgroupprint",
            {"BluetoothADD": bluetootthAdd,
              "mlbrcode": mlbrcode,
              "date": date,
              "mgroupcd": mgroupcd,
              "repeatedStringAmount": repeatedStringAmount,
              "repeatedStringprdAccId": repeatedStringprdAccId,
              "repeatedStringEntryDate": repeatedStringEntryDate
            });
        String geTest = 'geTest at $result';
        print("FLutter : " + geTest.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }
  }*/



/*  _callChannelSvngCollCustNo(List<SavingsListBean> savingsListBeanList) async{
    String repeatedStringAmount = "";
    print("savingsListBeanList"+savingsListBeanList.toString());
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    print("bluetoothAddress $bluetootthAdd");
    if(savingsListBeanList!=null&&savingsListBeanList!="") {
      for (var items in savingsListBeanList) {
        repeatedStringAmount =
            items.mcollectedamount.toString() +"~"+ repeatedStringAmount;
      }
      print("repeatedStringAmount" + repeatedStringAmount);
      String repeatedStringEntryDate = "";
      for (var items in savingsListBeanList) {
        repeatedStringEntryDate = items.mentrydate.toString()+"~"+repeatedStringEntryDate;
      }
      print("repeatedStringEntryDate" + repeatedStringEntryDate);

      String repeatedStringprdAccId = "";
      for (var items in savingsListBeanList) {
        print("items.mprdacctid"+items.mprdacctid.toString());
        if(items.mprdacctid.trim()!='') {
          repeatedStringprdAccId =
              int.parse(items.mprdacctid.substring(0, 8)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(8, 16)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(16, 24)).toString() +
                  "~" +
                  repeatedStringprdAccId;
        }
       if(items.mprdacctid.trim()==''){
          repeatedStringprdAccId="AccId Not Found"+"~"+
              repeatedStringprdAccId;
        }
      }
      print("repeatedStringprdAccId"+repeatedStringprdAccId.toString());
      String mlbrcode = savingsListBeanList[0].mlbrcode.toString()!=""?savingsListBeanList[0].mlbrcode.toString():"";
      String mcustno = savingsListBeanList[0].mcustno.toString();
      String date = dateFormat.format(DateTime.now());
      // String mlongname = savingsListBeanList[0].mlongname.toString();

      try {
        final String result = await platform.invokeMethod("svngcollcustnoprint",
            {"BluetoothADD": bluetootthAdd,
              "mlbrcode": mlbrcode,
              "date": date,
              "mcustno": mcustno,
              "repeatedStringAmount": repeatedStringAmount,
              "repeatedStringprdAccId": repeatedStringprdAccId,
              "repeatedStringEntryDate": repeatedStringEntryDate
            });
        String geTest = 'geTest at $result';
        print("FLutter : " + geTest.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }
  }*/
 /* _callChannelSvngCollToday(List<SavingsListBean> savingsListBeanList) async{
    String repeatedStringAmount = "";
    print("savingsListBeanList"+savingsListBeanList.toString());
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    print("bluetoothAddress $bluetootthAdd");
    if(savingsListBeanList!=null&&savingsListBeanList!="") {
      for (var items in savingsListBeanList) {
        repeatedStringAmount =
            items.mcollectedamount.toString() +"~"+ repeatedStringAmount;
      }
      print("repeatedStringAmount" + repeatedStringAmount);


      String repeatedStringprdAccId = "";
      for (var items in savingsListBeanList) {
        print("items.mprdacctid"+items.mprdacctid.toString());
        if(items.mprdacctid.trim()!='') {
          repeatedStringprdAccId =
              int.parse(items.mprdacctid.substring(0, 8)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(8, 16)).toString() +
                  "/" +
                  int.parse(items.mprdacctid.substring(16, 24)).toString() +
                  "~" +
                  repeatedStringprdAccId;
        }
        if(items.mprdacctid.trim()==''){
          repeatedStringprdAccId="AccId Not Found"+"~"+
              repeatedStringprdAccId;
        }
      }
      String repeatedStringCustNo = "";
      for (var items in savingsListBeanList) {
        repeatedStringCustNo = items.mcustno.toString()+"~"+repeatedStringCustNo;
      }
      print("repeatedStringprdAccId"+repeatedStringprdAccId.toString());
      String mlbrcode = savingsListBeanList[0].mlbrcode.toString()!=""?savingsListBeanList[0].mlbrcode.toString():"";
      String mcustno = savingsListBeanList[0].mcustno.toString();
      String date = dateFormat.format(DateTime.now());
      // String mlongname = savingsListBeanList[0].mlongname.toString();

      try {
        final String result = await platform.invokeMethod("svngcolltodaysprint",
            {"BluetoothADD": bluetootthAdd,
              "mlbrcode": mlbrcode,
              "date": date,
              "repeatedStringAmount": repeatedStringAmount,
              "repeatedStringprdAccId": repeatedStringprdAccId,
              "repeatedStringCustNo": repeatedStringCustNo
            });
        String geTest = 'geTest at $result';
        print("FLutter : " + geTest.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }

  }
*/
/*  bool centerPresent(int mcenterid) {
    print("inside center Present");
    print("mcenterid"+mcenterid.toString());
    if(mcenterid==""||mcenterid==null||mcenterid==0){
      _showAlert("Center Id ","It Is Mandatory");
      return false;
    }
    return true;

  }*/
 /* bool groupPresent(int mgroupid) {
    print("inside group Present");
    print("mgroupid"+mgroupid.toString());
    if(mgroupid==""||mgroupid==null||mgroupid==0){
      _showAlert("Group Id ","It Is Mandatory");
      return false;
    }
    return true;

  }*/
 /* bool custNoPresent(int custNo) {
    print("inside custNo Present");
    print("custNo"+custNo.toString());
    if(custNo==""||custNo==null||custNo==0){
      _showAlert("Customer Id ","It Is Mandatory");
      return false;
    }
    return true;

  }*/

  Future<void> _showAlert(arg, error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$arg"+Translations.of(context).text('error')),
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
  Future getCustomerNumber() async {
    var customerdata;
    customerdata = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                CustomerList(/*globals.isMemberOfGroup*/globals.isMemeberOfGroupForDisbursed,"Loan collection")));
    if (customerdata != null) {
      customerNo =
      customerdata.mcustno != null ? customerdata.mcustno.toString() : "0";
      customerName = customerdata.mlongname;

    }
  }

  Future getProduct() async {
    ProductBean prodObj =    await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForProductSelection(11,0),
          fullscreenDialog: true,
        ));

    productName = prodObj.mname;
    productNo = prodObj.mprdCd.toString();

  }
  Future getCenter() async{
    CenterDetailsBean getCenterFoundationList = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
          _myCenterDialog,
          fullscreenDialog: true,
        ))/*.then<CenterDetailsBean>((onValue){
    centerName = onValue.centerName;
    centerNo = onValue.id.toString();
  });*/;
    centerName = getCenterFoundationList!=null && getCenterFoundationList.mcentername!=null?getCenterFoundationList.mcentername:"";
    centerNo = getCenterFoundationList!=null && getCenterFoundationList.mCenterId!=null?getCenterFoundationList.mCenterId.toString():"";
  }

  Future getGroup() async{
    GroupFoundationBean groupFoundationBean = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
          _myGroupDialog,
          fullscreenDialog: true,
        ))/*.then<GroupFoundationBean>((onValue){
      groupName = onValue.groupName;
      groupNo = onValue.groupNumber.toString();
    })*/;
    groupName = groupFoundationBean!=null && groupFoundationBean.mgroupname !=null ?  groupFoundationBean.mgroupname:"";
    groupNo = groupFoundationBean!=null && groupFoundationBean.mgroupid !=null ?  groupFoundationBean.mgroupid.toString():"";
  }
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now().subtract(Duration(days: 1)),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now().subtract(Duration(days: 1)));
    if (picked != null )
      setState(() {
        mFromDate= picked;
        FromDate = dateFormat.format(picked);
        if(picked.day.toString().length==1){
          tempDay = "0"+picked.day.toString();

        }
        else tempDay = picked.day.toString();
        FromDate = FromDate.replaceRange(0, 2, tempDay);
        tempYear = picked.year.toString();
        FromDate = FromDate.replaceRange(6, 10,tempYear);
        if(picked.month.toString().length==1){
          tempMonth = "0"+picked.month.toString();
        }
        else
          tempMonth = picked.month.toString();
        FromDate = FromDate.replaceRange(3, 5, tempMonth);

      });
  }
  Future<Null> _selectDateT(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now().subtract(Duration(days: 1)),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now().subtract(Duration(days: 1)));
    if (picked != null )
      setState(() {
        mToDate= picked;
        ToDate = dateFormat.format(picked);
        if(picked.day.toString().length==1){
          tempDayT = "0"+picked.day.toString();

        }
        else tempDayT = picked.day.toString();
        ToDate = ToDate.replaceRange(0, 2, tempDayT);
        tempYearT = picked.year.toString();
        ToDate = ToDate.replaceRange(6, 10,tempYearT);
        if(picked.month.toString().length==1){
          tempMonthT = "0"+picked.month.toString();
        }
        else
          tempMonthT = picked.month.toString();
        ToDate = ToDate.replaceRange(3, 5, tempMonthT);

      });
  }
}
