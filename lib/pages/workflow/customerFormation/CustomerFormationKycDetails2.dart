import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;



class CustomerFormationKycDetails2 extends StatefulWidget {
  CustomerFormationKycDetails2({Key key}) : super(key: key);


  @override
  _CustomerFormationKycDetails2State createState() =>
      new _CustomerFormationKycDetails2State();
}

class _CustomerFormationKycDetails2State
    extends State<CustomerFormationKycDetails2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  final TextEditingController _controller = new TextEditingController();
  static  bool isSubmitClicked=false;
  var _focusNode = new FocusNode();


  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
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
              onChanged: (){

                final FormState form = _formKey.currentState;
                form.save();
              },
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[

                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.business_center,color: Colors.black,),
                      hintText: 'Enter Current Address here',
                      labelText: 'Current Address',
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.grey),*/
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue,)),
                      contentPadding: EdgeInsets.all(20.0),
                    ),

                    focusNode: _focusNode,
                    initialValue: globals.currentAddress !=null?globals.currentAddress:"",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                  //  validator: (val) =>isSubmitClicked? val.isEmpty ? 'Current Address is required' : null:"",
                    onSaved: (val) => globals.currentAddress= val,
                  ),
                  new TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.add_location,color: Colors.black,),
                      hintText: 'Enter District here',
                      labelText: 'District',
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.grey),*/
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue,)),
                      contentPadding: EdgeInsets.all(20.0),

                    ),
                    onFieldSubmitted:  (v){
                      final FormState form = _formKey.currentState;
                      form.save();
                    },
                    initialValue: globals.district !=null?globals.district:"",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                   // validator: (val) =>isSubmitClicked?  val.isEmpty ? 'District  is required' : null:"",
                    onSaved: (val) => globals.district = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.my_location,color: Colors.black,),
                      hintText: 'Enter Thana here',
                      labelText: 'Thana',
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.grey),*/
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue,)),
                      contentPadding: EdgeInsets.all(20.0),

                    ),

                    initialValue: globals.thana !=null?globals.thana:"",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                  //  validator: (val) =>isSubmitClicked? val.isEmpty ? 'Thana is required' : null:"",
                    onSaved: (val) => globals.thana= val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.my_location,color: Colors.black,),
                      hintText: 'Enter Pin here',
                      labelText: 'Pin ',
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.grey),*/
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue,)),
                      contentPadding: EdgeInsets.all(20.0),

                    ),
                    initialValue: globals.pin !=null?globals.pin:"",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    //validator: (val) =>isSubmitClicked? val.isEmpty ? 'Pin  is required' : null:"",
                    onSaved: (val) => globals.pin = val,
                  ),

                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.my_location,color: Colors.black,),
                      hintText: 'Enter Post here',
                      labelText: 'Post',
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.grey),*/
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue,)),
                      contentPadding: EdgeInsets.all(20.0),

                    ),

                    initialValue: globals.post !=null?globals.post:"",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                  //  validator: (val) =>isSubmitClicked? val.isEmpty ? 'Post is required' : null:"",
                    onSaved: (val) => globals.post = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.my_location,color: Colors.black,),
                      hintText: 'Enter Mobile Number here',
                      labelText: 'Mobile Number',
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.grey),*/
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue,)),
                      contentPadding: EdgeInsets.all(20.0),

                    ),

                    initialValue: globals.mobileNumber !=null?globals.mobileNumber:"",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                   // validator: (val) =>isSubmitClicked?val.isEmpty ? 'Mobile number  is required' : null:"",
                    onSaved: (val) => globals.mobileNumber = val,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.my_location,color: Colors.black,),
                      hintText: 'Enter LandLine Number here',
                      labelText: 'LandLine Number',
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.grey),*/
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue,)),
                      contentPadding: EdgeInsets.all(20.0),

                    ),

                    initialValue: globals.landLineNumber !=null?globals.landLineNumber:"",
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    //validator: (val) =>isSubmitClicked?val.isEmpty ? 'landLine number  is required' : null:"",
                    onSaved: (val) =>globals.landLineNumber = val,
                  ),

                ],
              )
          )
  );

  }
}

class KycBean2{
  String currentAddress;
  String district;
  String thana;
  String pin;
  String post;
  String mobileNumber;
  String landLineNumber;

  KycBean2({this.currentAddress,this.district,this.landLineNumber,this.mobileNumber,this.pin,this.post,this.thana});
}
