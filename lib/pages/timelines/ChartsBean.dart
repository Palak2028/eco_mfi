import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:flutter/cupertino.dart';

class ChartsBean{

  int trefno;
  int mrefno;
  String mchartid;
  String mtitle;
  String mxcatg;
  String mycatg;
  String mquery;
  String mtype;
  Widget chartType;
  List<AxisBean> axisBeanDataList;


  ChartsBean({this.trefno, this.mrefno, this.mchartid, this.mtitle, this.mxcatg,
    this.mycatg,this.mquery,  this.mtype,this.chartType,this.axisBeanDataList});

  factory ChartsBean.fromMap(
      Map<String, dynamic> map) {
    return ChartsBean(
      trefno: map[TablesColumnFile.trefno] as int,
      mrefno: map[TablesColumnFile.mrefno]!=null?map[TablesColumnFile.mrefno] as int:0,
      mchartid: map[TablesColumnFile.mchartid] as String,
      mtitle: map[TablesColumnFile.mtitle] as String,
      mxcatg: map[TablesColumnFile.mxcatg] as String,
      mycatg: map[TablesColumnFile.mycatg] as String,
      mquery: map[TablesColumnFile.mquery] as String,
      mtype: map[TablesColumnFile.mtype] as String,

    );
  }


  factory ChartsBean.fromMiddleware(Map<String, dynamic> map) {

    print("inside cgt1 ");
    return ChartsBean(
      trefno: map[TablesColumnFile.trefno] as int,
      mrefno: map[TablesColumnFile.mrefno]!=null?map[TablesColumnFile.mrefno] as int:0,
      mchartid: map[TablesColumnFile.mchartid] as String,
      mtitle: map[TablesColumnFile.mtitle] as String,
      mxcatg: map[TablesColumnFile.mxcatg] as String,
      mycatg: map[TablesColumnFile.mycatg] as String,
      mquery: map[TablesColumnFile.mquery] as String,
      mtype: map[TablesColumnFile.mtype] as String,
    );
  }
}


class AxisBean{

  AxisBean(this.xAxis, this.yAxis);

  @override
  String toString() {
    return 'AxisBean{xAxis: $xAxis, yAxis: $yAxis}';
  }

  String xAxis;
  int yAxis;
}