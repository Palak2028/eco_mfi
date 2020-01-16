import 'package:eco_mfi/pages/workflow/InternalBankTransfer/InternalBankTransferService.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/getGLAccountServices.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/bean/GLAccountBean.dart';


import 'package:eco_mfi/translations.dart';

class FullScreenDialogForGLSelection extends StatefulWidget {
  String centerName = "";
  String centerNo = "";
  String type = "";
  FullScreenDialogForGLSelection(this.type);
  @override
  FullScreenDialogForGLSelectionState createState() =>
      new FullScreenDialogForGLSelectionState();
}

class FullScreenDialogForGLSelectionState
    extends State<FullScreenDialogForGLSelection> {
  List<GLAccountBean> items = new List();
  List<GLAccountBean> storedItems = new List();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  GLAccountTransferService gLAccountTransferService;


  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("GL Account List");
  int count = 0;
  @override
  void initState() {
    super.initState();
     gLAccountTransferService = GLAccountTransferService();
    setState(() {});
  }

  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 20.0),
      );
    }
  }

  Widget _getItemUI(BuildContext context, int index) {
    final dateFormat = DateFormat("dd/MM/yyyy");
    return new GestureDetector(
      onTap: () {

        _onTapItem(context, items[index]);
      },
      child: new Card(
        shape: BeveledRectangleBorder(),
        child: new Row(
          children: <Widget>[
            SizedBox(height: 8.0,),
            Expanded(
              child:  new Card(
                  child:new ListTile(
                    leading:Text(
                      '${items[index].mrefno.toString()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 40.0,color: Color(0xff07426A),),
                    ),

                    title:
                    new Text(Translations.of(context).text('long_name')+items[index].mlongname.trim(),              style: TextStyle(

                    ),
                    ),
                    subtitle:new Column(
                      children: <Widget>[

                        new Row(
                          children: <Widget>[
                            new Text(Translations.of(context).text('accountNo')+items[index].mprdacctid,
                              style: new TextStyle(
                                color: Color(0xff07426A),
                                fontSize: 12.0,
                              ), ),
                            //new Text('${items[index].mnextmeetngdt.toString()}')
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            new Text(Translations.of(context).text('balance')+"0",

                              style: new TextStyle(
                                color: Color(0xff07426A),
                                fontSize: 14.0,
                              ), ),
                            //new Text('${items[index].mnextmeetngdt.toString()}')
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            new Text(Translations.of(context).text('Branch_Code')+items[index].mlbrcode.toString(),

                              style: new TextStyle(
                                color: Color(0xff07426A),
                                fontSize: 13.0,
                              ), ),                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.local_atm,
                              color: Colors.green,

                              size: 20.0,
                            ),
                            new Text('${items[index].trefno.toString()}')
                          ],
                        ),

                        new Row(
                          children: <Widget>[
                            new Icon(
                              Icons.present_to_all,
                              color: Colors.yellow,

                              size: 20.0,
                            ),
                            // new Text(" supervisor")
                          ],
                        )


                      ],
                    ),
                    /*trailing:

                   new Column(
                     children: <Widget>[
                       new Text("${items[index].mmeetingday}"),
                       new Text("${items[index].mnextmeetngdt}")
                     ],
                   )*/


                    // trailing: new Text("Pending" +items[index].mcreatedby,style: TextStyle(color: Colors.red),)
                    //,

                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {


    var futureBuilder = new FutureBuilder(
        future:count==0? (gLAccountTransferService.getGLAccountList()
            .then((List<GLAccountBean> response) {
          response.forEach((val){
            storedItems.add(val);
          });
          count++;
          return items = response;
        } )): AppDatabase.get().doNothing().then((val){


          return items;

        }) ,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text('Press button to start');
            case ConnectionState.waiting:
              return new Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  child:
                  new CircularProgressIndicator()); // new Text('Awaiting result...');
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return getHomePageBody(context, snapshot);
          }
        });


    return Scaffold(
      key: _scaffoldHomeState,
      appBar: new AppBar(
          elevation: 3.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          title: /*new Text(
          'Center foundation List',
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),*/

          appBarTitle,
          actions: <Widget>[
            new IconButton(
                icon: actionIcon,
                onPressed: () {
                  setState(() {
                    if (this.actionIcon.icon == Icons.search) {
                      this.actionIcon = new Icon(Icons.close);
                      this.appBarTitle = new TextField(
                        style: new TextStyle(
                          color: Colors.white,
                        ),
                        decoration: new InputDecoration(
                            prefixIcon:
                            new Icon(Icons.search, color: Colors.white),
                            hintText: Translations.of(context).text('Search'),
                            hintStyle: new TextStyle(color: Colors.white)),
                        onChanged: (val) {
                          filterList(val.toLowerCase());
                        },
                      );
                    } else {
                      this.actionIcon = new Icon(Icons.search);
                      this.appBarTitle = new Text(Translations.of(context).text('GL_Account_List')
                      );
                      items.clear();
                      storedItems.forEach((val) {
                        items.add(val);
                      });
                    }
                  });
                }),]
      ),

      body: Center(
        child: futureBuilder,
      ),
    );
  }

  void _onTapItem(
      BuildContext context, GLAccountBean getGlAccount) {

      Navigator.of(context).pop(getGlAccount);
      // Navigator.pop(context);

  }




  void filterList(String val) {
    print("inside filterList");


    items.clear();
    storedItems.forEach((obj) {
      if (obj.mlongname.toString().toLowerCase().contains(val) ||
          obj.mprdacctid.toLowerCase().contains(val)) {
        print("inside contains");
        print(items);
        items.add(obj);
      }
    });

    setState(() {});
  }
}
