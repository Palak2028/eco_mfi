import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_mfi/pages/workflow/villageservey/Village_Servey_Arrangments.dart';
import 'package:eco_mfi/pages/workflow/villageservey/Village_Servey_Basics.dart';
import 'package:eco_mfi/pages/workflow/villageservey/Village_Servey_ExtraInformation.dart';
import 'package:eco_mfi/pages/workflow/villageservey/Village_Servey_Farming.dart';
import 'package:eco_mfi/pages/workflow/villageservey/Village_Servey_MicroEnterprises.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;

class HomeTabsVillageServey extends StatefulWidget {
  HomeTabsVillageServey();

  @override
  HomeTabsVillageServeyState createState() => new HomeTabsVillageServeyState();
}

class HomeTabsVillageServeyState extends State<HomeTabsVillageServey>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 1, length: 5);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Village Servey",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        bottom: new TabBar(
          controller: _tabController,
          indicatorColor: Colors.black,
          tabs: <Widget>[
            new Tab(
                text: "Basics",
                icon: new Icon(
                  Icons.info,
                  color: Colors.black,
                )),
            new Tab(
              icon: new Icon(
                Icons.accessibility,
                color: Colors.black,
              ),
              text: "Arrangments",
            ),
            new Tab(
              icon: new Icon(Icons.business_center, color: Colors.black),
              text: "MicroEnterprises",
            ),
            new Tab(
                text: "Farming",
                icon: new Icon(Icons.spa, color: Colors.black)),
            new Tab(
              icon: new Icon(Icons.info_outline, color: Colors.black),
              text: "ExtraInformation",
            ),
          ],
        ),
        actions: <Widget>[
          /* */ /*  new Card(

            child:*/ /*  new Container(
              padding: EdgeInsets.fromLTRB(0.0, 15.0, 15.0,2.0),
                child: new RaisedButton(
                  child: const Text('Submit'),
                  onPressed: _submitForm,
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0,2.0),
                )),
*/
          //),
          new Icon(
            Icons.search,
            color: Colors.black,
          ),
          new Icon(Icons.search),
          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
          // new Icon(Icons.more_vert,color: Colors.black,),
        ],
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new VillageServeyBasics(),
          new VillageServeyArrangments(),
          new VillageServeyMicroEnterprises(),
          new VillageServeyFarming(),
          new VillageServeyExtraInformation(),
        ],
      ),
    );
  }

  void _submitForm() {
    print('Form save called, newCenter is now up to date...');
    print('0: ${globals.globalRadiListArrangment[0]}');
    print('1: ${globals.globalRadiListArrangment[1]}');
    print('2: ${globals.globalRadiListArrangment[2]}');
    print('3 ${globals.globalRadiListArrangment[3]}');
    print('4 ${globals.globalRadiListArrangment[4]}');
    print('5: ${globals.globalRadiListArrangment[5]}');
    print('6: ${globals.globalRadiListArrangment[6]}');
    print('7: ${globals.globalRadiListArrangment[7]}');
    print('8 ${globals.globalRadiListArrangment[8]}');
    print('9: ${globals.globalRadiListArrangment[9]}');
    print('10: ${globals.globalRadiListArrangment[10]}');
    print('11: ${globals.globalRadiListArrangment[11]}');
    print('12 ${globals.globalRadiListArrangment[12]}');
    print('========================================');
    print('Submitting to back end...');
  }
}
