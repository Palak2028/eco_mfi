
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CreditBereauBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/NOCApproval.dart';
import 'package:eco_mfi/translations.dart';

class NOCApprovalList extends StatefulWidget {
  @override
  _NOCApprovalList createState() => new _NOCApprovalList();
}


class _NOCApprovalList extends State<NOCApprovalList> {
  List<CreditBereauBean> items2 = new List<CreditBereauBean>();
  int count =1;
  Icon actionIcon = new Icon(Icons.search);
  Icon deleteIcon = new Icon(Icons.delete);
  Widget appBarTitle = new Text("NOC Approval List");
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();

  getHomePageBody2(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null&&items2!=null) {
      return ListView.builder(
        itemCount: items2.length,
        itemBuilder: _getItemUI2,
        padding: EdgeInsets.all(0.0),
      );
    }
  }

  Widget _getItemUI2(BuildContext context, int index) {
    return new GestureDetector(


      onTap: () {
        editCustomer(context, items2[index]);
      },
      child: new Card(
          shape: BeveledRectangleBorder(),
          child:new ListTile(
            title: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.person,
                      color: Colors.yellow,
                      size: 30.0,
                    ),
                    new Text("  ${items2[index].mprospectname.toString()}"),
                  ],
                )
              ],
            )
            ,
            subtitle: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Image(
                      image: new AssetImage("assets/aadhar.png"),
                      alignment: Alignment.center,
                      height: 40.0,
                      width: 30.5,
                    ),
                    new Text("  ${items2[index].mpanno}"),
                    SizedBox(
                      width: 10.0,
                    ),

                  ],
                ),


                new Row(
                  children: <Widget>[

                    new Icon(
                      Icons.phone,
                      color: Colors.green,
                      size: 20.0,
                    ),
                    new Text(
                        "  ${items2[index].mmobno.toString()}"),


                  ],
                )

              ],
            ),
            trailing: new Text(
              "${Constant.getProspectStatus(items2[index].mprospectstatus)}",
              style: TextStyle(color: Colors.green),
            ),
          )
      ),
    );
  }

  void editCustomer(BuildContext context, CreditBereauBean obj) {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new NOCApproval(
              CreditBeareauPassedObject:
              obj)),
    );
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilderNotSynced;

    if (count == 1 ) {
      count++;
      print("credit bereau list is null");
      futureBuilderNotSynced = new FutureBuilder(
          future: AppDatabase.get().getCreditBereauMasterFromProspectStatus(4).then(
                  (List<CreditBereauBean> result) {

                    print(result);

                if(result!=null){

                  result.forEach((obj){
                    items2.add(obj);

                  });


                  return items2;
                }
                else return new Container();




              } ),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new Text('Press button to start');
              case ConnectionState.waiting:
                return new Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child:
                    new CircularProgressIndicator());
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');

                else {
                  if(items2==null){
                    return new Container(
                        child:new Text("")
                    );
                  }
                  else
                    return getHomePageBody2(context, snapshot);
                }
            }
          });
    } else if (this.mounted == true&& items2!=null) {
      print("credit bereau list is not null");

      futureBuilderNotSynced = ListView.builder(
        itemCount: items2.length,

        itemBuilder: (context, position) {
          return new GestureDetector(

              onTap: () {
                editCustomer(context, items2[position]);
              },
              child: new Card(
                  shape: BeveledRectangleBorder(),
                  child:new ListTile(
                    title: new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.person,
                              color: Colors.yellow,
                              size: 30.0,
                            ),
                            new Text("  ${items2[position].mprospectname.toString()}"),
                          ],
                        )
                      ],
                    )
                    ,
                    subtitle: new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Image(
                              image: new AssetImage("assets/aadhar.png"),
                              alignment: Alignment.center,
                              height: 40.0,
                              width: 30.5,
                            ),
                            new Text("  ${items2[position].mpanno}"),
                            SizedBox(
                              width: 10.0,
                            ),

                          ],
                        ),

                        new Row(
                          children: <Widget>[

                            new Icon(
                              Icons.phone,
                              color: Colors.green,
                              size: 20.0,
                            ),
                            new Text(
                                "  ${items2[position].mmobno.toString()}"),


                          ],
                        )

                      ],


                    ),

                    trailing: new Text(
                      "${Constant.getProspectStatus(items2[position].mprospectstatus)}",
                      style: TextStyle(color: Colors.green),
                    ),
                  )

              ));
        },
      );
    }
    else
      futureBuilderNotSynced = new Text("Nothing to display");

    // TODO: implement build
    return new Scaffold(
      key: _scaffoldHomeState,
      appBar: new AppBar(
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xff01579b),
        brightness: Brightness.light,
        title: appBarTitle,
        actions: <Widget>[

          new IconButton(icon: actionIcon,onPressed:(){
            setState(() {
              if ( this.actionIcon.icon == Icons.search){
                this.actionIcon = new Icon(Icons.close);
                this.appBarTitle = new TextField(
                  style: new TextStyle(
                    color: Colors.white,

                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search,color: Colors.white),
                      hintText: Translations.of(context).text('Search'),
                      hintStyle: new TextStyle(color: Colors.white)
                  ),
                  onChanged: (val){
                  },
                );}
              else {
                this.actionIcon = new Icon(Icons.search);
                this.appBarTitle = new Text(Translations.of(context).text('NOC_Aproval_List'));
                items2.clear();


              }


            });
          })
          ,

        ],



      ),
      body: Container(
        child: futureBuilderNotSynced,
      )
    );
  }



}
