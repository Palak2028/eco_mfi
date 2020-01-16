import 'package:charts_flutter/flutter.dart' as charts;
import 'package:eco_mfi/Utilities/ThemeDesign.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:syncfusion_flutter_charts/charts.dart';

import 'ChartsBean.dart';

class SimpleLineChart extends StatefulWidget {
  SimpleLineChart({Key key, this.title}) : super(key: key);

  static Container _get(Widget child,
          [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );
  final String title;

  @override
  _SimpleLineChartState createState() => new _SimpleLineChartState();
}

class _SimpleLineChartState extends State<SimpleLineChart> {

  int count=1;
  List<ChartsBean> items = new List<ChartsBean>();
  List<ChartsBean> storedItems =  new List<ChartsBean>();
  Widget appBarTitle = new Text("Charts Details");
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  Icon actionIcon = new Icon(Icons.search);
  List chartsList = new List();

  var currentTime = DateFormat('dd/MM/yyyy').format(DateTime.now());
  Map<String, ClicksPerYear> data;
  //String charttype;
  int selection = 0;
  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    //print("caption value : " + globals.dropdownCaptionsPersonalInfo[no]);

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
        k < globals.dropDownCaptionValuesCOdeKeysChartsType[no].length;
        k++) {
      mapData.add(globals.dropDownCaptionValuesCOdeKeysChartsType[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(
          value.mcodedesc,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
      );
    }).toList();
    /*   if(no==0){
      print(mapData);
      testString = mapData;
    }*/
    return _dropDownMenuItems1;
  }

  /*Widget chartType() => SimpleLineChart._get(new Row(
        children: _makeRadios(15, globals.radioCaptionValuesCharttypes[0], 0),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ));*/

  List<Widget> _makeRadios(int numberOfRadios, List textName, int position) {
    List<Widget> radios = new List<Widget>();
    for (int i = 0; i < numberOfRadios; i++) {
      radios.add(Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 10.0),
        child: new Row(
          children: <Widget>[
            new Text(
              textName[i],
              textAlign: TextAlign.right,
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontStyle: FontStyle.normal,
                fontSize: 12.0,
              ),
            ),
            new Radio(
              value: i,
              groupValue: chartsTypeRadios[position],
              onChanged: (selection) => _onRadioSelected(selection, position),
              activeColor: Color(0xff07426A),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ));
    }
    return radios;
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

  static List<int> chartsTypeRadios = new List<int>(1);

  _onRadioSelected(int selection, int position) {
    setState(() => chartsTypeRadios[position] = selection);
    if (position == 0) {
      selection = selection;
    }
  }

  @override
  void initState() {
    super.initState();
    data = {
      '2015': ClicksPerYear('2015', 3, Colors.red),
      '2016': ClicksPerYear('2016', 7, Colors.orange),
      '2017': ClicksPerYear('2017', 42, Colors.yellow),
      '$currentTime': ClicksPerYear('$currentTime', 0, Colors.grey),
    };
  }

  LookupBeanData blankBean =
      new LookupBeanData(mcodedesc: "", mcode: "", mcodetype: 0);
  showDropDown(LookupBeanData selectedObj, int no) {
    if (selectedObj.mcodedesc.isEmpty) {
      switch (no) {
        case 0:
       //   charttype = blankBean;
          //CustomerFormationMasterTabsState.custListBean.mHouse = blankBean.mcode;
          break;
        default:
          break;
      }
      setState(() {});
    } else {
      for (int k = 0;
          k < globals.dropDownCaptionValuesCOdeKeysChartsType[no].length;
          k++) {
        if (globals.dropDownCaptionValuesCOdeKeysChartsType[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropDownCaptionValuesCOdeKeysChartsType[no][k]);
        }
      }
    }
  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      switch (no) {
        case 0:
         // charttype = value;
          //CustomerFormationMasterTabsState.custListBean.mAgricultureType = value.mcode;
          break;
        default:
          break;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    var series = [
      new charts.Series(
          domainFn: (ClicksPerYear clickData, _) => clickData.year,
          measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
          colorFn: (ClicksPerYear clickData, _) => clickData.color,
          id: 'Clicks',
          data: data.values.toList()),
    ];
    var chart = new charts.BarChart(
      series,
      animate: true,
    );

    var chartWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

    var chartsBuilder;

    if (count == 1 || count == 2) {
      count++;
      chartsBuilder = new FutureBuilder(
          future: AppDatabase.get().getChartsDetailsList().then(
                  (List<ChartsBean> chartsBean) async{
                items.clear();
                storedItems.clear();
                chartsBean.forEach((f) async{
                  print("f.mtype "+f.mtype.toString());
                  //if(f.mtype=='1') {
                    await AppDatabase.get().getQuery(f).then((onValue) {
                      f.axisBeanDataList=onValue;
                    }).then((onValue){
                      f.chartType = getCharts(f);
                      setState(() {
                      });
                    });
                 // }
                  f.chartType = getCharts(f);
                  items.add(f);
                  storedItems.add(f);
                });
                return items;
              }).then((onValue){
                setState(() {
                });
          }),

          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new Center(child:new Text('Please wait while list gets load'));
              case ConnectionState.waiting:
                return new Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child:
                    new CircularProgressIndicator()); // new Text('Awaiting result...');
              default:
                if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
                  return new Center(
                    child: new Text("Nothing to display on your filter"),
                  );
                }      else {
                  return getHomePageBody(context, snapshot);
                }
            }
          });
    } else if (storedItems != null) {
      chartsBuilder = ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, position) {
            double c_width = MediaQuery.of(context).size.width * 10;


            return new GestureDetector(
              onTap: () {
                //_onTapItem(items[position],widget.mleadsId,widget.mrefno,widget.trefno);
              },
              child: new Card(
                //color Color(0xff2f1f4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 25.0,
                child: new Padding(
                  padding: new EdgeInsets.only(
                    left: 3.0,
                    right: 3.0,
                  ),
                  child: Column(
                    children: <Widget>[

                      new Container(
                        width: c_width,
                        child: Column(children: <Widget>[
                          items[position].chartType,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                            SizedBox(width: 10.0,),
                            new IconButton(
                              icon:new Icon(
                              FontAwesomeIcons.chartArea,
                              color: Colors.grey,
                                size: 30.0,
                            ),
                            ),
                            new IconButton(
                              icon:new Icon(
                                FontAwesomeIcons.chartPie,
                                color: Colors.grey,
                                size: 30.0,
                              ),
                            ),

                            SizedBox(width: 10.0,),
                            new IconButton(
                              icon:new Icon(
                                FontAwesomeIcons.chartLine,
                                color: Colors.grey,
                                size: 30.0,
                              ),
                            ),
                            SizedBox(width: 10.0,),
                            new IconButton(
                              icon:new Icon(
                                FontAwesomeIcons.chartBar,
                                color: Colors.grey,
                                size: 30.0,
                              ),
                            ),
                            SizedBox(width: 10.0,),
                            new IconButton(
                              icon:new Icon(
                                FontAwesomeIcons.solidChartBar,
                                color: Colors.grey,
                                size: 30.0,
                              ),
                            ),
                          ],),

                        ],)
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }

    // TODO: implement build
    return  chartsBuilder;

   /* return new ListView(
      children: <Widget>[
        *//* Row(children: <Widget>[

          ],),*//*
//          new Center(child: chartWidget),
        Center(
            child: Container(
          child: getCharts(),
        )),
        new DropdownButtonFormField(
          value: charttype,
          items: generateDropDown(0),
          onChanged: (LookupBeanData newValue) {
            showDropDown(newValue, 0);
          },
          validator: (args) {
            print(args);
          },
          //  isExpanded: true,
          //hint:Text("Select"),
          decoration: InputDecoration(labelText: "Chart Type"),
        ),

      *//*  new Table(children: [
          new TableRow(
              decoration: new BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 0.1),
              ),
              children: [
                chartType(),
              ])
        ])
*//*
        *//*  new Container(child: new Expanded(
          child: new Column(
            children: [
              chartType(),
            ],
          ),

        ),
    ),*//*
      ],
    );*/
  }



  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.all(0.0),
      );
    }
  }


  Widget _getItemUI(BuildContext context, int index) {
    double c_width = MediaQuery.of(context).size.width * 10;

    return new GestureDetector(
      onTap: () {
       // _onTapItem(items[index],widget.mleadsId,widget.mrefno,widget.trefno);
      },
      child: new Card(
        //color Color(0xff2f1f4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 25.0,
        child: new Padding(
          padding: new EdgeInsets.only(
            left: 3.0,
            right: 3.0,
          ),
          child: Column(
            children: <Widget>[

              new Container(
                width: c_width,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                        width: c_width,
                        child: Column(children: <Widget>[
                          items[index].chartType,
                          new Text("Something")
                        ],)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void filterList(String val) async {


  }


  Widget getCharts(ChartsBean charttype) {
    if (charttype != null) {
      if (charttype.mtype == '1') {
       /* return Column(children: <Widget>[
          Container(height: 400.0, child: cartesianCHarts()),
        ],);*/
       return Container(height: 400.0, child: cartesianCharts(charttype));
      } else if (charttype.mtype == '2') {
    /* return Column(children: <Widget>[
           Container(height: 400.0, child: getDefaultPieChart(false)),
        ],);*/
      return Container(height: 400.0, child: getDefaultPieChart(false));
      } else if (charttype.mtype == '3') {
       /* return Column(children: <Widget>[
          Container(height: 400.0, child: getElevationDoughnutChart(false)),
        ],);
*/ return  Container(height: 400.0, child: getElevationDoughnutChart(false));
      } else if (charttype.mtype == '4') {
       /* return Column(children: <Widget>[
          Container(height: 400.0, child: getDefaultRadialBarChart(false)),
        ],);*/
        return Container(height: 400.0, child: getDefaultRadialBarChart(false));
      } else if (charttype.mtype == '5') {
        /*return Column(children: <Widget>[
          Container(height: 400.0, child: getDefaultCategoryAxisChart(false)),
        ],);*/
        return Container(
            height: 400.0, child: getDefaultCategoryAxisChart(false,charttype));
      } else if (charttype == '6') {
        return Container(
            height: 400.0, child: getDefaultDateTimeAxisChart(false));
      } else if (charttype == '7') {
        return Container(
            height: 400.0, child: getDefaultNumericAxisChart(true));
      } else if (charttype == '8') {
        return Container(height: 400.0, child: getDefaultBubbleChart(true));
      } else if (charttype == '9') {
        return Container(height: 400.0, child: getDefaultColumnChart(true));
      } else if (charttype == '10') {
        return Container(height: 400.0, child: getDefaultSplineChart(true));
      } else if (charttype == '11') {
        return Container(height: 400.0, child: getDefaultStepLineChart(true));
      } else if (charttype == '12') {
        return Container(height: 400.0, child: getDefaultAreaChart(true));
      } else if (charttype == '13') {
        return Container(height: 400.0, child: getDefaultScatterChart(true));
      } else if (charttype == '14') {
      } else if (charttype == '15') {
      } else {
        return new Text("Select Charts Type");
      }
    } else {
      return new Text("Select Charts Type");
    }
  }
}

Widget cartesianCharts(ChartsBean bean) {
  return SfCartesianChart(

      //primaryXAxis: CategoryAxis(),
      title: ChartTitle(text: bean.mtitle), //Chart title.
     // legend: Legend(isVisible: true), // Enables the legend.
      tooltipBehavior: TooltipBehavior(enable: true), // Enables the tooltip.
      series: <LineSeries<AxisBean, String>>[
        LineSeries<AxisBean, String>(
          xAxisName: bean.mxcatg,
            yAxisName: bean.mycatg,
            dataSource:bean.axisBeanDataList!=null?bean.axisBeanDataList:[],
            xValueMapper: (AxisBean sales, _) => sales.xAxis,
            yValueMapper: (AxisBean sales, _) => sales.yAxis,
            dataLabelSettings:
                DataLabelSettings(isVisible: true) // Enables the data label.
            )
      ]);
}

class ClicksPerYear {
  final String year;
  int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);

  incrementClick() {
    clicks++;
  }
}

class SalesData {
  SalesData(this.year, this.sales);

   String year;
  double sales;
}

Widget getDefaultPieChart(bool isTileView) {
  return SfCircularChart(
    title: ChartTitle(text: isTileView ? '' : 'Sales by sales person'),
    legend: Legend(isVisible: isTileView ? false : true),
    series: getPieSeries(isTileView),
  );
}

List<PieSeries<_PieData, String>> getPieSeries(bool isTileView) {
  final List<_PieData> pieData = <_PieData>[
    _PieData('David', 30, 'David \n 30%'),
    _PieData('Steve', 35, 'Steve \n 35%'),
    _PieData('Jack', 39, 'Jack \n 39%'),
    _PieData('Others', 75, 'Others \n 75%'),
  ];
  return <PieSeries<_PieData, String>>[
    PieSeries<_PieData, String>(
        explode: true,
        explodeIndex: 0,
        explodeOffset: '10%',
        dataSource: pieData,
        xValueMapper: (_PieData data, _) => data.xData,
        yValueMapper: (_PieData data, _) => data.yData,
        dataLabelMapper: (_PieData data, _) => data.text,
        startAngle: 90,
        endAngle: 90,
        dataLabelSettings: DataLabelSettings(isVisible: true)),
  ];
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);
  final String xData;
  final num yData;
  final String text;
}

SfCircularChart getElevationDoughnutChart(bool isTileView) {
  return SfCircularChart(
    annotations: <CircularChartAnnotation>[
      CircularChartAnnotation(
          height: '100%',
          width: '100%',
          child: Container(
              child: PhysicalModel(
                  child: Container(),
                  shape: BoxShape.circle,
                  elevation: 10,
                  shadowColor: Colors.black,
                  color: const Color.fromRGBO(230, 230, 230, 1)))),
      CircularChartAnnotation(
          child: Container(
              child: const Text('62%',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 25))))
    ],
    title: ChartTitle(
        text: isTileView ? '' : 'Progress of a task',
        textStyle: ChartTextStyle(fontSize: 20)),
    series: getDoughnutSeries(isTileView),
  );
}

List<DoughnutSeries<_DoughnutData, String>> getDoughnutSeries(bool isTileView) {
  final List<_DoughnutData> chartData = <_DoughnutData>[
    _DoughnutData('A', 62, null, const Color.fromRGBO(0, 220, 252, 1)),
    _DoughnutData('B', 38, null, const Color.fromRGBO(230, 230, 230, 1))
  ];

  return <DoughnutSeries<_DoughnutData, String>>[
    DoughnutSeries<_DoughnutData, String>(
        dataSource: chartData,
        animationDuration: 0,
        xValueMapper: (_DoughnutData data, _) => data.xData,
        yValueMapper: (_DoughnutData data, _) => data.yData,
        pointColorMapper: (_DoughnutData data, _) => data.color)
  ];
}

class _DoughnutData {
  _DoughnutData(this.xData, this.yData, this.text, this.color);
  final String xData;
  final num yData;
  final String text;
  final Color color;
}

SfCircularChart getDefaultRadialBarChart(bool isTileView) {
  return SfCircularChart(
    title: ChartTitle(text: isTileView ? '' : 'Short put distance'),
    series: getRadialBarDefaultSeries(isTileView),
    tooltipBehavior:
        TooltipBehavior(enable: true, format: 'point.x : point.ym'),
  );
}

List<RadialBarSeries<_RadialData, String>> getRadialBarDefaultSeries(
    bool isTileView) {
  final List<_RadialData> chartData = <_RadialData>[
    _RadialData('John', 10, '100%', Color.fromRGBO(248, 177, 149, 1.0)),
    _RadialData('Almaida', 11, '100%', Color.fromRGBO(246, 114, 128, 1.0)),
    _RadialData('Doe', 12, '100%', Color.fromRGBO(61, 205, 171, 1.0)),
    _RadialData('Tom', 13, '100%', Color.fromRGBO(1, 174, 190, 1.0)),
  ];
  return <RadialBarSeries<_RadialData, String>>[
    RadialBarSeries<_RadialData, String>(
        maximumValue: 15,
        dataLabelSettings: DataLabelSettings(
            isVisible: true, textStyle: ChartTextStyle(fontSize: 10.0)),
        dataSource: chartData,
        cornerStyle: CornerStyle.bothCurve,
        gap: '10%',
        radius: '90%',
        xValueMapper: (_RadialData data, _) => data.xVal,
        yValueMapper: (_RadialData data, _) => data.yVal,
        pointRadiusMapper: (_RadialData data, _) => data.radius,
        pointColorMapper: (_RadialData data, _) => data.color,
        dataLabelMapper: (_RadialData data, _) => data.xVal)
  ];
}

class _RadialData {
  _RadialData(this.xVal, this.yVal, [this.radius, this.color]);
  final String xVal;
  final double yVal;
  final String radius;
  final Color color;
}

SfCartesianChart getDefaultCategoryAxisChart(bool isTileView,ChartsBean bean) {
  return SfCartesianChart(
    title: ChartTitle(text: isTileView ? '' : bean.mtitle),
    plotAreaBorderColor: Colors.transparent,
    /*primaryXAxis: CategoryAxis(
      majorGridLines: MajorGridLines(width: 0),
    ),*/
    primaryYAxis: NumericAxis(
        minimum: 0, maximum: 80, isVisible: false, labelFormat: '{value}M'),
    series: getDefaultCategory(isTileView,bean),
    tooltipBehavior:
        TooltipBehavior(enable: true, header: '', canShowMarker: false),
  );
}

List<ColumnSeries<AxisBean, String>> getDefaultCategory(bool isTileView,ChartsBean bean) {
  /*final List<_CategoryData> chartData = <_CategoryData>[
    _CategoryData('South\nKorea', 39, Colors.teal[300]),
    _CategoryData('India', 20, const Color.fromRGBO(53, 124, 210, 1)),
    _CategoryData('South\nAfrica', 61, Colors.pink),
    _CategoryData('China', 65, Colors.orange),
    _CategoryData('France', 45, Colors.grey),
    _CategoryData('Saudi\nArabia', 10, Colors.pink[300]),
    _CategoryData('Japan', 16, Colors.purple[300]),
    _CategoryData('Mexico', 31, const Color.fromRGBO(127, 132, 232, 1))
  ];*/
  return <ColumnSeries<AxisBean, String>>[
    ColumnSeries<AxisBean, String>(
  xAxisName: bean.mxcatg,
  yAxisName: bean.mycatg,
  dataSource:bean.axisBeanDataList!=null?bean.axisBeanDataList:[],
      xValueMapper: (AxisBean data, _) => data.xAxis,
      yValueMapper: (AxisBean data, _) => data.yAxis,
      //pointColorMapper: (AxisBean data, _) => data.color,
      dataLabelSettings: DataLabelSettings(isVisible: true),
    )
  ];
}

class _CategoryData {
  _CategoryData(this.xVal, this.yVal, this.color);
  final String xVal;
  final int yVal;
  Color color;
}

SfCartesianChart getDefaultDateTimeAxisChart(bool isTileView) {
  return SfCartesianChart(
      plotAreaBorderColor: Colors.transparent,
      title: ChartTitle(
          text: isTileView
              ? ''
              : 'Euro to USD monthly exchange rate - 2015 to 2018'),
      primaryXAxis: DateTimeAxis(majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
        minimum: 1,
        maximum: 1.35,
        interval: 0.05,
        labelFormat: '\${value}',
        title: AxisTitle(text: isTileView ? '' : 'Dollars'),
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(size: 0),
      ),
      series: getLineSeries(isTileView),
      trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          tooltipSettings:
              InteractiveTooltip(format: 'point.x : point.y', borderWidth: 0)));
}

List<LineSeries<_DateTimeData, DateTime>> getLineSeries(bool isTileView) {
  final List<_DateTimeData> chartData = <_DateTimeData>[
    _DateTimeData(DateTime(2015, 1, 1), 1.13),
    _DateTimeData(DateTime(2015, 2, 1), 1.12),
    _DateTimeData(DateTime(2015, 3, 1), 1.08),
    _DateTimeData(DateTime(2015, 4, 1), 1.12),
    _DateTimeData(DateTime(2015, 5, 1), 1.1),
    _DateTimeData(DateTime(2015, 6, 1), 1.12),
    _DateTimeData(DateTime(2015, 7, 1), 1.1),
    _DateTimeData(DateTime(2015, 8, 1), 1.12),
    _DateTimeData(DateTime(2015, 9, 1), 1.12),
    _DateTimeData(DateTime(2015, 10, 1), 1.1),
    _DateTimeData(DateTime(2015, 11, 1), 1.06),
    _DateTimeData(DateTime(2015, 12, 1), 1.09),
    _DateTimeData(DateTime(2016, 1, 1), 1.09),
    _DateTimeData(DateTime(2016, 2, 1), 1.09),
    _DateTimeData(DateTime(2016, 3, 1), 1.14),
    _DateTimeData(DateTime(2016, 4, 1), 1.14),
    _DateTimeData(DateTime(2016, 5, 1), 1.12),
    _DateTimeData(DateTime(2016, 6, 1), 1.11),
    _DateTimeData(DateTime(2016, 7, 1), 1.11),
    _DateTimeData(DateTime(2016, 8, 1), 1.11),
    _DateTimeData(DateTime(2016, 9, 1), 1.12),
    _DateTimeData(DateTime(2016, 10, 1), 1.1),
    _DateTimeData(DateTime(2016, 11, 1), 1.08),
    _DateTimeData(
        DateTime(
          2016,
          12,
        ),
        1.05),
    _DateTimeData(DateTime(2017, 1, 1), 1.08),
    _DateTimeData(DateTime(2017, 2, 1), 1.06),
    _DateTimeData(DateTime(2017, 3, 1), 1.07),
    _DateTimeData(DateTime(2017, 4, 1), 1.09),
    _DateTimeData(DateTime(2017, 5, 1), 1.12),
    _DateTimeData(DateTime(2017, 6, 1), 1.14),
    _DateTimeData(DateTime(2017, 7, 1), 1.17),
    _DateTimeData(DateTime(2017, 8, 1), 1.18),
    _DateTimeData(DateTime(2017, 9, 1), 1.18),
    _DateTimeData(DateTime(2017, 10, 1), 1.16),
    _DateTimeData(DateTime(2017, 11, 1), 1.18),
    _DateTimeData(DateTime(2017, 12, 1), 1.2),
    _DateTimeData(DateTime(2018, 1, 1), 1.25),
    _DateTimeData(DateTime(2018, 2, 1), 1.22),
    _DateTimeData(DateTime(2018, 3, 1), 1.23),
    _DateTimeData(DateTime(2018, 4, 1), 1.21),
    _DateTimeData(DateTime(2018, 5, 1), 1.17),
    _DateTimeData(DateTime(2018, 6, 1), 1.17),
    _DateTimeData(DateTime(2018, 7, 1), 1.17),
    _DateTimeData(DateTime(2018, 8, 1), 1.17),
    _DateTimeData(DateTime(2018, 9, 1), 1.16),
    _DateTimeData(DateTime(2018, 10, 1), 1.13),
    _DateTimeData(DateTime(2018, 11, 1), 1.14),
    _DateTimeData(DateTime(2018, 12, 1), 1.15)
  ];
  return <LineSeries<_DateTimeData, DateTime>>[
    LineSeries<_DateTimeData, DateTime>(
      dataSource: chartData,
      xValueMapper: (_DateTimeData data, _) => data.year,
      yValueMapper: (_DateTimeData data, _) => data.y,
      color: Color.fromRGBO(242, 117, 7, 1),
    )
  ];
}

class _DateTimeData {
  _DateTimeData(this.year, this.y);
  final DateTime year;
  final double y;
}

SfCartesianChart getDefaultNumericAxisChart(bool isTileView) {
  return SfCartesianChart(
    title: ChartTitle(text: isTileView ? '' : 'Australia vs India ODI - 2019'),
    plotAreaBorderColor: Colors.transparent,
    legend: Legend(
        isVisible: isTileView ? false : true, position: LegendPosition.top),
    primaryXAxis: NumericAxis(
        title: AxisTitle(text: isTileView ? '' : 'Match'),
        minimum: 0,
        maximum: 6,
        interval: 1,
        majorGridLines: MajorGridLines(width: 0),
        majorTickLines: MajorTickLines(size: 0),
        edgeLabelPlacement: EdgeLabelPlacement.hide),
    primaryYAxis: NumericAxis(
        title: AxisTitle(text: isTileView ? '' : 'Score'),
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(size: 0)),
    series: getLineNumericSeries(isTileView),
    tooltipBehavior: TooltipBehavior(
        enable: true, format: 'Score: point.y', canShowMarker: false),
  );
}

List<ColumnSeries<_ChartNumeric, num>> getLineNumericSeries(bool isTileView) {
  final List<_ChartNumeric> chartData = <_ChartNumeric>[
    _ChartNumeric(1, 240, 236),
    _ChartNumeric(2, 250, 242),
    _ChartNumeric(3, 281, 313),
    _ChartNumeric(4, 358, 359),
    _ChartNumeric(5, 237, 272)
  ];
  return <ColumnSeries<_ChartNumeric, num>>[
    ColumnSeries<_ChartNumeric, num>(
        enableTooltip: true,
        dataSource: chartData,
        color: Color.fromRGBO(237, 221, 76, 1),
        name: 'Australia',
        xValueMapper: (_ChartNumeric sales, _) => sales.x,
        yValueMapper: (_ChartNumeric sales, _) => sales.y2),
    ColumnSeries<_ChartNumeric, num>(
        enableTooltip: true,
        dataSource: chartData,
        color: Color.fromRGBO(2, 109, 213, 1),
        xValueMapper: (_ChartNumeric sales, _) => sales.x,
        yValueMapper: (_ChartNumeric sales, _) => sales.y,
        name: 'India'),
  ];
}

class _ChartNumeric {
  _ChartNumeric(this.x, this.y, this.y2);
  final double x;
  final double y;
  final double y2;
}

SfCartesianChart getDefaultBubbleChart(bool isTileView) {
  return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: isTileView ? '' : 'World countries details'),
      primaryXAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          title: AxisTitle(text: isTileView ? '' : 'Literacy rate'),
          minimum: 60,
          maximum: 100),
      primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0),
          title: AxisTitle(text: isTileView ? '' : 'GDP growth rate')),
      tooltipBehavior: TooltipBehavior(
          enable: true,
          textAlignment: ChartAlignment.near,
          header: '',
          canShowMarker: false,
          format:
              'point.x\nLiteracy rate : point.x%\nGDP growth rate : point.y\nPopulation : point.sizeB'),
      series: getBubbleSeries(isTileView));
}

List<BubbleSeries<_BubbleData, num>> getBubbleSeries(bool isTileView) {
  final List<_BubbleData> bubbleData = <_BubbleData>[
    _BubbleData('China', 92.2, 7.8, 1.347),
    _BubbleData('India', 74, 6.5, 1.241),
    _BubbleData('Indonesia', 90.4, 6.0, 0.238),
    _BubbleData('US', 99.4, 2.2, 0.312),
    _BubbleData('Germany', 99, 0.7, 0.0818),
    _BubbleData('Egypt', 72, 2.0, 0.0826),
    _BubbleData('Russia', 99.6, 3.4, 0.143),
    _BubbleData('Japan', 99, 0.2, 0.128),
    _BubbleData('Mexico', 86.1, 4.0, 0.115),
    _BubbleData('Philippines', 92.6, 6.6, 0.096),
    _BubbleData('Nigeria', 61.3, 1.45, 0.162),
    _BubbleData('Hong Kong', 82.2, 3.97, 0.7),
    _BubbleData('Netherland', 79.2, 3.9, 0.162),
    _BubbleData('Jordan', 72.5, 4.5, 0.7),
    _BubbleData('Australia', 81, 3.5, 0.21),
    _BubbleData('Mongolia', 66.8, 3.9, 0.028),
    _BubbleData('Taiwan', 78.4, 2.9, 0.231),
  ];
  return <BubbleSeries<_BubbleData, num>>[
    BubbleSeries<_BubbleData, num>(
      enableTooltip: true,
      opacity: 0.7,
      dataSource: bubbleData,
      xValueMapper: (_BubbleData sales, _) => sales.x,
      yValueMapper: (_BubbleData sales, _) => sales.y,
      sizeValueMapper: (_BubbleData sales, _) => sales.size,
    )
  ];
}

class _BubbleData {
  _BubbleData(this.text, this.x, [this.y, this.size]);
  final String text;
  final double x;
  final double y;
  final double size;
}

SfCartesianChart getDefaultColumnChart(bool isTileView) {
  return SfCartesianChart(
    plotAreaBorderWidth: 0,
    title: ChartTitle(
        text: isTileView ? '' : 'Population growth of various countries'),
    primaryXAxis: CategoryAxis(
      majorGridLines: MajorGridLines(width: 0),
    ),
    primaryYAxis: NumericAxis(
        axisLine: AxisLine(width: 0),
        labelFormat: '{value}%',
        majorTickLines: MajorTickLines(size: 0)),
    series: getColumnSeries(isTileView),
    tooltipBehavior:
        TooltipBehavior(enable: true, header: '', canShowMarker: false),
  );
}

List<ColumnSeries<_ChartData, String>> getColumnSeries(bool isTileView) {
  final List<_ChartData> chartData = <_ChartData>[
    _ChartData('China', 0.541),
    _ChartData('Brazil', 0.818),
    _ChartData('Bolivia', 1.51),
    _ChartData('Mexico', 1.302),
    _ChartData('Egypt', 2.017),
    _ChartData('Mongolia', 1.683),
  ];
  return <ColumnSeries<_ChartData, String>>[
    ColumnSeries<_ChartData, String>(
      enableTooltip: true,
      dataSource: chartData,
      xValueMapper: (_ChartData sales, _) => sales.x,
      yValueMapper: (_ChartData sales, _) => sales.y,
      dataLabelSettings: DataLabelSettings(
          isVisible: true, textStyle: ChartTextStyle(fontSize: 10)),
    )
  ];
}

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final double y;
}

SfCartesianChart getDefaultSplineChart(bool isTileView) {
  return SfCartesianChart(
    plotAreaBorderWidth: 0,
    title: ChartTitle(
        text: isTileView ? '' : 'Average high/low temperature of London'),
    legend: Legend(isVisible: isTileView ? false : true),
    primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        labelPlacement: LabelPlacement.onTicks),
    primaryYAxis: NumericAxis(
        minimum: 30,
        maximum: 80,
        axisLine: AxisLine(width: 0),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        labelFormat: '{value}°F',
        majorTickLines: MajorTickLines(size: 0)),
    series: getSplineSeries(isTileView),
    tooltipBehavior: TooltipBehavior(enable: true),
  );
}

List<SplineSeries<_ChartDataSpline, String>> getSplineSeries(bool isTileView) {
  final List<_ChartDataSpline> chartData = <_ChartDataSpline>[
    _ChartDataSpline('Jan', 43, 37, 41),
    _ChartDataSpline('Feb', 45, 37, 45),
    _ChartDataSpline('Mar', 50, 39, 48),
    _ChartDataSpline('Apr', 55, 43, 52),
    _ChartDataSpline('May', 63, 48, 57),
    _ChartDataSpline('Jun', 68, 54, 61),
    _ChartDataSpline('Jul', 72, 57, 66),
    _ChartDataSpline('Aug', 70, 57, 66),
    _ChartDataSpline('Sep', 66, 54, 63),
    _ChartDataSpline('Oct', 57, 48, 55),
    _ChartDataSpline('Nov', 50, 43, 50),
    _ChartDataSpline('Dec', 45, 37, 45)
  ];
  return <SplineSeries<_ChartDataSpline, String>>[
    SplineSeries<_ChartDataSpline, String>(
      enableTooltip: true,
      dataSource: chartData,
      xValueMapper: (_ChartDataSpline sales, _) => sales.x,
      yValueMapper: (_ChartDataSpline sales, _) => sales.high,
      markerSettings: MarkerSettings(isVisible: true),
      name: 'High',
    ),
    SplineSeries<_ChartDataSpline, String>(
      enableTooltip: true,
      dataSource: chartData,
      name: 'Low',
      markerSettings: MarkerSettings(isVisible: true),
      xValueMapper: (_ChartDataSpline sales, _) => sales.x,
      yValueMapper: (_ChartDataSpline sales, _) => sales.low,
    )
  ];
}

class _ChartDataSpline {
  _ChartDataSpline(this.x, this.high, this.low, this.average);
  final String x;
  final double high;
  final double low;
  final double average;
}

SfCartesianChart getDefaultStepLineChart(bool isTileView) {
  return SfCartesianChart(
    plotAreaBorderWidth: 0,
    title: ChartTitle(text: isTileView ? '' : 'Electricity-Production'),
    primaryXAxis: NumericAxis(majorGridLines: MajorGridLines(width: 0)),
    primaryYAxis: NumericAxis(
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(size: 0),
        title: AxisTitle(text: isTileView ? '' : 'Production (kWh)'),
        labelFormat: '{value}B'),
    legend: Legend(isVisible: isTileView ? false : true),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: getStepLineSeries(isTileView),
  );
}

List<StepLineSeries<_StepLineData, num>> getStepLineSeries(bool isTileView) {
  final List<_StepLineData> chartData = <_StepLineData>[
    _StepLineData(2000, 416, 180),
    _StepLineData(2001, 490, 240),
    _StepLineData(2002, 470, 370),
    _StepLineData(2003, 500, 200),
    _StepLineData(2004, 449, 229),
    _StepLineData(2005, 470, 210),
    _StepLineData(2006, 437, 337),
    _StepLineData(2007, 458, 258),
    _StepLineData(2008, 500, 300),
    _StepLineData(2009, 473, 173),
    _StepLineData(2010, 520, 220),
    _StepLineData(2011, 509, 309)
  ];
  return <StepLineSeries<_StepLineData, num>>[
    StepLineSeries<_StepLineData, num>(
        dataSource: chartData,
        xValueMapper: (_StepLineData sales, _) => sales.xData,
        yValueMapper: (_StepLineData sales, _) => sales.yData,
        name: 'Renewable'),
    StepLineSeries<_StepLineData, num>(
        dataSource: chartData,
        xValueMapper: (_StepLineData sales, _) => sales.xData,
        yValueMapper: (_StepLineData sales, _) => sales.yData2,
        name: 'Non-Renewable')
  ];
}

class _StepLineData {
  _StepLineData(this.xData, this.yData, this.yData2);
  final double xData;
  final double yData;
  final double yData2;
}

SfCartesianChart getDefaultAreaChart(bool isTileView) {
  return SfCartesianChart(
    legend: Legend(isVisible: isTileView ? false : true, opacity: 0.7),
    title: ChartTitle(text: isTileView ? '' : 'Average sales comparison'),
    plotAreaBorderColor: Colors.transparent,
    primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat.y(),
        interval: 1,
        intervalType: DateTimeIntervalType.years,
        majorGridLines: MajorGridLines(width: 0),
        edgeLabelPlacement: EdgeLabelPlacement.shift),
    primaryYAxis: NumericAxis(
        labelFormat: '{value}M',
        title: AxisTitle(text: isTileView ? '' : 'Revenue in millions'),
        interval: 1,
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(size: 0)),
    series: getAreaSeries(isTileView),
    tooltipBehavior: TooltipBehavior(enable: true),
  );
}

List<AreaSeries<_DefaultArea, DateTime>> getAreaSeries(bool isTileView) {
  final List<_DefaultArea> chartData = <_DefaultArea>[
    _DefaultArea(DateTime(2000, 1, 1), 4, 2.6),
    _DefaultArea(DateTime(2001, 1, 1), 3.0, 2.8),
    _DefaultArea(DateTime(2002, 1, 1), 3.8, 2.6),
    _DefaultArea(DateTime(2003, 1, 1), 3.4, 3),
    _DefaultArea(DateTime(2004, 1, 1), 3.2, 3.6),
    _DefaultArea(DateTime(2005, 1, 1), 3.9, 3),
  ];
  return <AreaSeries<_DefaultArea, DateTime>>[
    AreaSeries<_DefaultArea, DateTime>(
      dataSource: chartData,
      opacity: 0.7,
      name: 'Product A',
      xValueMapper: (_DefaultArea sales, _) => sales.x,
      yValueMapper: (_DefaultArea sales, _) => sales.y1,
    ),
    AreaSeries<_DefaultArea, DateTime>(
      dataSource: chartData,
      opacity: 0.7,
      name: 'Product B',
      xValueMapper: (_DefaultArea sales, _) => sales.x,
      yValueMapper: (_DefaultArea sales, _) => sales.y2,
    )
  ];
}

class _DefaultArea {
  _DefaultArea(this.x, this.y1, this.y2);
  final DateTime x;
  final double y1;
  final double y2;
}

SfCartesianChart getDefaultScatterChart(bool isTileView) {
  return SfCartesianChart(
    plotAreaBorderWidth: 0,
    title: ChartTitle(text: isTileView ? '' : 'Export growth rate'),
    legend: Legend(isVisible: isTileView ? false : true),
    primaryXAxis: DateTimeAxis(
      labelIntersectAction: AxisLabelIntersectAction.multipleRows,
      majorGridLines: MajorGridLines(width: 0),
    ),
    primaryYAxis: NumericAxis(
        labelFormat: '{value}%',
        axisLine: AxisLine(width: 0),
        minorTickLines: MinorTickLines(size: 0)),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: getScatterSeries(isTileView),
  );
}

List<ScatterSeries<_ScatterData, DateTime>> getScatterSeries(bool isTileView) {
  final List<_ScatterData> chartData = <_ScatterData>[
    _ScatterData(new DateTime(2006, 1, 1), 0.01, -0.03, 0.10),
    _ScatterData(new DateTime(2007, 1, 1), 0.03, -0.02, 0.08),
    _ScatterData(new DateTime(2008, 1, 1), -0.06, -0.13, -0.03),
    _ScatterData(new DateTime(2009, 1, 1), -0.03, -0.04, 0.04),
    _ScatterData(new DateTime(2010, 1, 1), 0.09, 0.07, 0.19),
    _ScatterData(new DateTime(2011, 1, 1), 0, 0.04, 0),
    _ScatterData(new DateTime(2012, 1, 1), 0.01, -0.01, -0.09),
    _ScatterData(new DateTime(2013, 1, 1), 0.05, 0.05, 0.10),
    _ScatterData(new DateTime(2014, 1, 1), 0, 0.08, 0.05),
    _ScatterData(new DateTime(2015, 1, 1), 0.1, 0.01, -0.04),
    _ScatterData(new DateTime(2016, 1, 1), 0.08, 0, 0.02),
  ];
  return <ScatterSeries<_ScatterData, DateTime>>[
    ScatterSeries<_ScatterData, DateTime>(
        enableTooltip: true,
        dataSource: chartData,
        opacity: 0.7,
        xValueMapper: (_ScatterData sales, _) => sales.year,
        yValueMapper: (_ScatterData sales, _) => sales.y,
        markerSettings: MarkerSettings(height: 15, width: 15),
        name: 'Brazil'),
    ScatterSeries<_ScatterData, DateTime>(
        enableTooltip: true,
        opacity: 0.7,
        dataSource: chartData,
        xValueMapper: (_ScatterData sales, _) => sales.year,
        yValueMapper: (_ScatterData sales, _) => sales.y1,
        markerSettings: MarkerSettings(height: 15, width: 15),
        name: 'Canada'),
    ScatterSeries<_ScatterData, DateTime>(
      enableTooltip: true,
      dataSource: chartData,
      color: Color.fromRGBO(0, 168, 181, 1),
      xValueMapper: (_ScatterData sales, _) => sales.year,
      yValueMapper: (_ScatterData sales, _) => sales.y2,
      name: 'India',
      markerSettings: MarkerSettings(height: 15, width: 15),
    )
  ];
}

class _ScatterData {
  _ScatterData(this.year, this.y, this.y1, this.y2);
  final DateTime year;
  final double y;
  final double y1;
  final double y2;
}
