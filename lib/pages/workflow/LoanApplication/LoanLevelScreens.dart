import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/Guarantor/GuarantorDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

import 'List/CustomerLoanDetailsList.dart';
import 'bean/CustomerLoanDetailsBean.dart';

class LoaneLevelScreensList extends ModalRoute<void> {
  LoaneLevelScreensList();

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.canvas,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _LoanLevelScreenStepper(context),
      ),
    );
  }

  Widget _LoanLevelScreenStepper(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title: Text("Loan Data Flow"),
        actions: <Widget>[],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          /*  Text(
            'Data Entry WorkFlow',
            style: TextStyle(color: Colors.white, fontSize: 24.0),
          ),*/
          /* IconButton(
            icon: Icon(
              (Icons.clear),
            ),
            onPressed: ,
          ),
          */
          FloatingActionButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(
              (Icons.clear),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white.withOpacity(0.85),
      body: Timeline(
          children: Constant.listWorkflow, position: TimelinePosition.Left),
    );
  }
}
