import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/ReadXmlCost.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/GRT/GRTQuestions.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'dart:convert';
import 'package:eco_mfi/Utilities/initializer.dart'
    as initializer;
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';




class GRTDocumentVerification extends StatefulWidget {
  final laonLimitPassedObject;
  GRTDocumentVerification(this.laonLimitPassedObject);

  @override
  _GRTDocumentVerificationState createState() =>
      new _GRTDocumentVerificationState();
}

class _GRTDocumentVerificationState extends State<GRTDocumentVerification> {
  List<String> questions;
  List<ImageBean> bean = new List<ImageBean>();
  List<String> filteredBean = new List<String>();
  CustomerListBean custBean;
  String idDesc = "";
  String idType = "";

  bool isId1 = false;
  void initState() {
    super.initState();
    setImages();
  }

  Future setImages() async {
    await AppDatabase.get()
        .selectSingleCustomer(widget.laonLimitPassedObject.mcusttrefno,
            widget.laonLimitPassedObject.mcustmrefno)
        .then((CustomerListBean customerListBean) {
      custBean = customerListBean;
    });
    await AppDatabase.get()
        .selectSingleCustomerImages(custBean.trefno, custBean.mrefno)
        .then((List<ImageBean> imageBean) {
      bean = imageBean;
    });
    setState(() {});
  }

  int _showImages = 0;
  List<DropdownMenuItem<String>> generateDropDown(int no) {
    List<DropdownMenuItem<String>> _dropDownMenuItems1;
    List mapData = List();
    for (int i = 0;
        i < globals.dropdownCaptionsGRTDocumentVerification.length;
        i++) {
      mapData.add(globals.dropdownCaptionsGRTDocumentVerification[i]);
    }

    mapData.add(" ");

    _dropDownMenuItems1 = mapData.map((value) {
      return new DropdownMenuItem<String>(
        value: value,
        child: new Text(value),
      );
    }).toList();

    return _dropDownMenuItems1;
  }

  void changedDropDownItem(String id, int position) async {
    print(
        "Selected Id  $id, $position position  we are going to refresh the UI");
    print(position);
    idType = id;
    await addFilteredOnSelectedId(id);
    setState(() {});
  }

  int getPosition() {
    return idType == 'idType1'
        ? 0
        : idType == 'idType2' ? 1 : idType == 'IdType3' ? 2 : 0;
  }

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      /*color: Colors.transparent,
      elevation: 4.0,*/
      child: new Container(
        decoration: new BoxDecoration(
          color: Colors.white,
        ),
        child: new Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 270,
                  // height: MediaQuery.of(context).size.height,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                  ),
                ),
                Positioned(
                  top: 5.0,
                  left: 30.0,
                  right: 30.0,
                  child: ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      width: 200.0,
                      height: 450.0,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 120.0,
                                  height: 25.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    border: Border.all(
                                        width: 1.0, color: Colors.green),
                                  ),
                                  child: Center(
                                    child: Text(
                                      Translations.of(context).text('GRT'),
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                Translations.of(context).text('Disibursment'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Container(
                                width: 300.0,
                                height: 1.0,
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                children: <Widget>[
                                  displayDetailsWidget(
                                      'Tablet Loan ',
                                      '',
                                      'RefNo',
                                      widget.laonLimitPassedObject.trefno
                                          .toString()),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, right: 20.0),
                                    child: displayDetailsWidget(
                                        'Name ',
                                        '',
                                        custBean == null ||
                                                custBean.mfname == null ||
                                                custBean.mlname == null
                                            ? ""
                                            : custBean.mfname +
                                                " " +
                                                custBean.mlname,
                                        ''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, right: 20.0),
                                    child: displayDetailsWidget(
                                        ' Appr Amount',
                                        '',
                                        widget.laonLimitPassedObject
                                            .mapprvdloanamt
                                            .toString(),
                                        ''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, right: 20.0),
                                    child: displayDetailsWidget(
                                        'Created Date',
                                        '',
                                        DateFormat("yyyy, mm, dd").format(
                                            DateTime.parse(widget
                                                .laonLimitPassedObject
                                                .mcreateddt
                                                .toString())),
                                        ''),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            new Divider(),
            new Text(
              Translations.of(context).text('House_Verification_Image'),
              textAlign: TextAlign.center,
            ),
            new Container(
                color: Constant.mandatoryColor,
                // height: 250.0,
                child: new Column(
                  children: <Widget>[
                    new ListTile(
                      title: new ListTile(
                        title: globals.grtBean != null &&
                                globals.grtBean.mhouseVerifiImg != null &&
                                globals.grtBean.mhouseVerifiImg != ""
                            ? new Image.memory(
                                Base64Decoder()
                                    .convert(globals.grtBean.mhouseVerifiImg),
                                height: 200.0,
                                width: 200.0,
                              )
                            : /*new Image(
                                image: new AssetImage("assets/AddImage.png"),
                                width: 100,
                                height: 200.0),*/
                            new Icon(Icons.add, color: Colors.red),
                        subtitle: new Text(
                          Translations.of(context).text('Click_Here_To_Take_A_Picture'),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          getImage();
                          /*_navigateAndDisplaySelection(
                                  context, 'customer picture')*/
                          ;
                        },
                      ),
                    ),
                  ],
                )),
            new Text(
              Translations.of(context).text('Document_Verification'),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  Translations.of(context).text('Select_Id_Type'),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                new DropdownButton(
                  value: idType == "" || idType == null ? null : idType,
                  items: generateDropDown(0),
                  onChanged: (String val) => changedDropDownItem(val, 0),
                ),
                new FlatButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: new Text(
                    Translations.of(context).text('View_Image'),
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                )
              ],
            ),
            new TextFormField(
                enabled: false,
                decoration:  InputDecoration(
                  hintText: Translations.of(context).text('Id_Desc'),
                  labelText: Translations.of(context).text('Id_Desc'),
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
                  contentPadding: EdgeInsets.all(20.0),
                ),
                controller: idDesc != null
                    ? TextEditingController(text: idDesc)
                    : TextEditingController(text: ""),
                //initialValue: idDesc!=null && idDesc!='null'?idDesc:"",
                //CustomerFormationMasterTabsState.custListBean.mfname != null ? CustomerFormationMasterTabsState.custListBean.mfname : "",
                onSaved: (String value) {
                  /*globals.firstName = value;*/
                  // CustomerFormationMasterTabsState.custListBean.mfname =
                  //  value;
                }),
            Divider(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              height: 300.0,
              child: _showImages == 0
                  ? new Text(Translations.of(context).text('Click_To_Show_Image'))
                  : /*PhotoView(
                            imageProvider: MemoryImage(Base64Decoder()
                                .convert(globals.kyc1AppId1PicTagCustomer)),
                          )
*/
                  new PhotoViewGallery(
                      pageOptions: <PhotoViewGalleryPageOptions>[
                        filteredBean.length > 0
                            ? PhotoViewGalleryPageOptions(
                                imageProvider: MemoryImage(
                                    Base64Decoder().convert(filteredBean[0])),

                              )
                            : PhotoViewGalleryPageOptions(
                                imageProvider: MemoryImage(Base64Decoder().convert(
                                    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg=='))),
                        filteredBean.length > 1
                            ? PhotoViewGalleryPageOptions(
                                imageProvider: MemoryImage(
                                    Base64Decoder().convert(filteredBean[1])),
                                //maxScale: PhotoViewComputedScale.contained * 0.3
                              )
                            : PhotoViewGalleryPageOptions(
                                imageProvider: MemoryImage(Base64Decoder().convert(
                                    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg=='))),
                        filteredBean.length > 2
                            ? PhotoViewGalleryPageOptions(
                                imageProvider: MemoryImage(
                                    Base64Decoder().convert(filteredBean[2])),
                                initialScale:
                                    PhotoViewComputedScale.contained * 0.98,

                              )
                            : PhotoViewGalleryPageOptions(
                                imageProvider: MemoryImage(Base64Decoder().convert(
                                    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg=='))),
                        filteredBean.length > 3
                            ? PhotoViewGalleryPageOptions(
                                imageProvider: MemoryImage(
                                    Base64Decoder().convert(filteredBean[3])),
                                initialScale:
                                    PhotoViewComputedScale.contained * 0.98,

                              )
                            : PhotoViewGalleryPageOptions(
                                imageProvider: MemoryImage(Base64Decoder().convert(
                                    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg=='))),
                      ],
                      //backgroundColor: Colors.black87,
                    ),
            )
          ],
        ),
      ),
      // ),

      //)
    );
  }

  Future addFilteredOnSelectedId(String id) async {
    print("id type here2 " + id.toString());
    filteredBean.clear();
    if (id == 'IdType1') {
      print("coming in this this is op");
      idDesc = custBean.mpannodesc != null && custBean.mpannodesc != 'null'
          ? custBean.mpannodesc
          : "";

      print("coming in this this is op" + bean.length.toString());
      for (int i = 0; i < bean.length; i++) {
        print("coming in this this is op" + bean[i].tImgrefno.toString());
        if (bean[i].tImgrefno == 1 || bean[i].tImgrefno == 2) {
          _showImages = 1;
          print("image path here is " + i.toString() + " " + bean[i].imgString);
          filteredBean.add(base64
              .encode(File(bean[i].imgString).readAsBytesSync())
              .toString());
        }
      }
      /*  if(!(filteredBean.length<=4 )|| !(filteredBean.length>0) ){
        for (int i = 0; i < 4; i++) {
          filteredBean.insert(filteredBean.length + i, "");
        }
      }*/
    } else if (id == 'IdType2') {
      print("coming in this this is op");
      _showImages = 1;
      idDesc = custBean.mIdDesc != null && custBean.mIdDesc != 'null'
          ? custBean.mIdDesc
          : "";

      print("coming in this this is op" + idDesc.toString());

      isId1 = false;
      for (int i = 0; i < bean.length; i++) {
        if (bean[i].tImgrefno > 2 && bean[i].tImgrefno < 7) {
          filteredBean.add(base64
              .encode(File(bean[i].imgString).readAsBytesSync())
              .toString());
          // filteredBean[i].imgString = base64.encode(File(bean[i].imgString).readAsBytesSync()).toString();
        }
      }
      /*   if(!(filteredBean.length<=4 )|| !(filteredBean.length>0) ){
        for(int i = 0;i<4;i++){
          filteredBean.insert(filteredBean.length+i,"");
        }

      }*/
    } else if (id == 'IdType3') {
      _showImages = 1;
      print("bean[i].imgSubType " + bean.toString() + " " + id.toString());
      for (int i = 0; i < bean.length; i++) {
        print("bean[i].imgSubType " +
            bean[i].imgSubType.toString() +
            " " +
            id.toString());
        if (bean[i].tImgrefno > 6 && bean[i].tImgrefno < 11) {
          filteredBean.add(base64
              .encode(File(bean[i].imgString).readAsBytesSync())
              .toString());
          //filteredBean[i].imgString = base64.encode(File(bean[i].imgString).readAsBytesSync()).toString();
        }
      }
      setState(() {});
      /*  print("length of fliterd"+filteredBean.length.toString());
      if(filteredBean.length<=4 || !(filteredBean.length>0) ){
        filteredBean.setAll(filteredBean.length , ["","","",""]);
      }
    }*/

    }
  }

  Widget displayDetailsWidget(String firstTitle, String firstDesc,
      String secondTitle, String secondDesc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                firstTitle,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  firstDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                secondTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  secondDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 200.0, maxWidth: 200.0);
    List<int> imageBytes = image.readAsBytesSync();
    String base64Image = base64.encode(imageBytes);
    globals.grtBean.mhouseVerifiImg = base64Image;
    setState(() {});
    print(globals.grtBean.mhouseVerifiImg.toString());
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.addOval(Rect.fromCircle(
        center: Offset(0.0, size.height / 2 + 50.0), radius: 20.0));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height / 2 + 50.0), radius: 20.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
