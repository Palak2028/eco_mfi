import 'package:flutter/material.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';




class PPIMasterBean {
  int tPpirefno;
  //numeric(8)
  int trefno;
  //numeric(8)
  int mPpirefno;
  int mrefno;
  //numeric(8)
  int mcustno;
  //NVarChar(4)
  String mitem;
  //NVarChar(8)
  String  mhaveyn;
  //NVarChar(4)
  int mnoofitems;
  double mweightage;


  PPIMasterBean(
      {this.tPpirefno,
        this.trefno,
        this.mPpirefno,
        this.mrefno,
        this.mcustno,
        this.mitem,
        this.mhaveyn,
        this.mnoofitems,
        this.mweightage,
      });

  factory PPIMasterBean.fromMap(Map<String, dynamic> map) {
    print("inside map");
    return PPIMasterBean(

      tPpirefno		: map[TablesColumnFile.tPpirefno] as int,
      trefno: map[TablesColumnFile.trefno] as int,
      mPpirefno		: map[TablesColumnFile.mPpirefno] as int,
      mrefno 		: map[TablesColumnFile.mrefno] as int,
      mcustno 		: map[TablesColumnFile.mcustno] as int,
      mitem 		: map[TablesColumnFile.mitem] as String,
      mhaveyn 		: map[TablesColumnFile.mhaveyn] as String,
      mnoofitems 		: map[TablesColumnFile.mnoofitems] as int,
      mweightage 		: map[TablesColumnFile.mweightage] as double,

    );
  }

}

class TempPPIDisplayBean{

  String quetionDesc;
  String answerDesc;
  double weitage;



  TempPPIDisplayBean(
      {this.quetionDesc,
        this.answerDesc,
        this.weitage,
      });


}