library initializer;

import 'dart:io';
import 'package:eco_mfi/Utilities/ReadXmlCost.dart';
import 'package:xml/xml.dart' as xml;
import 'package:flutter/services.dart';

List CGT2Questions = new List();
List GRTQuestions = new List();
List CGT1Questions = new List();
List GRTDropdown = new List();

class Initializer {
  static Future<void> addCGT2Questions() {
   /* print("inside questions");
    CGT2Questions = ReadXmlConst.readNode("List", "CGT2Questions").split(",");
    print(CGT2Questions);
    GRTQuestions = ReadXmlConst.readNode("List", "GRTQuestions").split(",");
    CGT1Questions = ReadXmlConst.readNode("List", "CGT1Questions").split(",");
    GRTDropdown = ReadXmlConst.readNode("List", "GRTDropdown").split(",");*/
  }
}
