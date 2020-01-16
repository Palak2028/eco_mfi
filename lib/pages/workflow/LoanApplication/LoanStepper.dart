
import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class LoanStepper extends StatefulWidget {
  @override
  LoanStepperState createState() => new LoanStepperState();
}

class LoanStepperState extends State<LoanStepper> {
  int _currentStep = 0;

  List<TimelineModel> items = [
    TimelineModel(Placeholder(),
        position: TimelineItemPosition.random,
        iconBackground: Colors.redAccent,
        icon: Icon(Icons.blur_circular)),
    TimelineModel(Placeholder(),
        position: TimelineItemPosition.random,
        iconBackground: Colors.redAccent,
        icon: Icon(Icons.blur_circular)),
    TimelineModel(Placeholder(),
        position: TimelineItemPosition.random,
        iconBackground: Colors.redAccent,
        icon: Icon(Icons.blur_circular)),
    TimelineModel(Placeholder(),
        position: TimelineItemPosition.random,
        iconBackground: Colors.redAccent,
        icon: Icon(Icons.blur_circular)),
    TimelineModel(Placeholder(),
        position: TimelineItemPosition.random,
        iconBackground: Colors.redAccent,
        icon: Icon(Icons.blur_circular)),
    TimelineModel(Placeholder(),
        position: TimelineItemPosition.random,
        iconBackground: Colors.redAccent,
        icon: Icon(Icons.blur_circular)),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85),
      body: Timeline(children: items, position: TimelinePosition.Left),

    );
  }
}