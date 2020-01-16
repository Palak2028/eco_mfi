import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/app_util.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("About"),
        backgroundColor: Colors.blue,
        brightness: Brightness.light,
      ),
      body: new Container(
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new ListView(
            children: <Widget>[
              new Card(
                child: new Column(
                  children: <Widget>[
                    new ListTile(
                        leading:
                            new Icon(Icons.bug_report, color: Colors.black),
                        title: new Text("Rpeort an Issue"),
                        subtitle: new Text("Having an issue ? Report it here"),
                        onTap: () => launchURL(ISSUE_URL)),
                    new ListTile(
                      leading: new Icon(Icons.update, color: Colors.black),
                      title: new Text("Version"),
                      subtitle: new Text("0.0.1"),
                    )
                  ],
                ),
              ),
              new Card(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: new Text("Author",
                          style: new TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FONT_MEDIUM)),
                    ),
                    new ListTile(
                      leading:
                          new Icon(Icons.perm_identity, color: Colors.black),
                      title: new Text("Shadab siddiqui"),
                      subtitle: new Text("shadabep4372"),
                      onTap: () => launchURL(GITHUB_URL),
                    ),
                    new ListTile(
                        leading:
                            new Icon(Icons.bug_report, color: Colors.black),
                        title: new Text("make a call"),
                        onTap: () => launchURL(PROJECT_URL)),
                    new ListTile(
                        leading: new Icon(Icons.email, color: Colors.black),
                        title: new Text("Send an Email"),
                        subtitle: new Text("someone@mail.com"),
                        onTap: () => launchURL(EMAIL_URL)),
                  ],
                ),
              ),
              new Card(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: new Text("Ask Question ?",
                          style: new TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FONT_MEDIUM)),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new IconButton(
                            icon: new Image.asset(
                              "assets/twitter_logo.png",
                              scale: 8.75,
                            ),
                            onPressed: () => launchURL(TWITTER_URL),
                          ),
                          new IconButton(
                           // icon: new Image.asset("assets/facebook_logo.png"),
                            onPressed: () => launchURL(FACEBOOK_URL),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              new Card(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: new Text("Apache Licenese",
                          style: new TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FONT_MEDIUM)),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new ListTile(
                        subtitle: new Text("Make a copyright"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
