library read_xml_const;

import 'dart:io';
import 'package:xml/xml.dart' as xml;
import 'package:flutter/services.dart';

class ReadXmlConst {
  static String constString;
  static var storeDocument;

  static getFileData(String path) async {
   /* print("Elemets  1 ");
    constString = await rootBundle.loadString(path);
    printData();*/
  }

  static printData() {
    print("Elemets   2");
    storeDocument = xml.parse(constString);
  }

 static String readNode(String parentNode,String childNode){
    //print("Elemets   "+ storeDocument.toString());
/*   var xmlValue =  xml.parse(storeDocument.toString());
    String xmlValueRet = xmlValue
        .findElements(parentNode)
        .toList()[0]
        .findElements(childNode)
        .first
        .text;
    print("Elemets   "+ xmlValueRet);*/
   // return xmlValueRet;
   return null;
}

}
