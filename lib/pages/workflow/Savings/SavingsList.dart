import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_mfi/pages/workflow/Savings/SavingsAccountList.dart';
import 'package:eco_mfi/pages/workflow/Savings/SavingsCollectionSearch.dart';
class SavingsList extends StatefulWidget {
  var cameras;

  @override
  SavingsListState createState() {
    return new SavingsListState();
  }


}

class SavingsListState extends State<SavingsList> {
  
  
  GestureDetector gestureDetector(name, image) {
    return new GestureDetector(
      child: new RaisedButton(
          elevation: 2.0,
          highlightColor: Colors.black,
          splashColor: Colors.orange,
          colorBrightness: Brightness.dark,
          color: Colors.white,
          onPressed: () {
            if (name == "New Account Opening") {
              print("New Account Opening");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new SavingsAccountList("Savings Account List")), //When Authorized Navigate to the next screen
              );
            } else if (name == "Savings Collection") {
              print(" Savings Collection");
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new SavingsCollectionSearchScreen()), //When Authorized Navigate to the next screen
              );
            }



          },
          child: new FittedBox(
            alignment: Alignment.center,
            fit: BoxFit.none,
            child: new Column(
              children: <Widget>[
                new Image(
                  image: new AssetImage(image),
                ),
                SizedBox.fromSize(),
                new Center(
                  child: new Text(
                    name,
                    style:
                    new TextStyle(color: Color(0xff07426A), fontSize: 11.0,),
                  ),
                  heightFactor: 4.0,
                )
              ],
            ),
          )),
    );

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Savings account",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,


      ),


      body:new GridView.count(
      primary: true,
      padding: const EdgeInsets.all(1.0),
      crossAxisCount: 2,
      //childAspectRatio: 0.80,
      mainAxisSpacing: 0.1,
      crossAxisSpacing: 0.1,
      children: <Widget>[

        gestureDetector("New Account Opening", "assets/create_centers.png"),
        gestureDetector("Savings Collection", "assets/group_foundation.png"),
        //gestureDetector("Bulk Deposite", "assets/prospect_creation.png"),


      ],
    ),
    );
  }
}
