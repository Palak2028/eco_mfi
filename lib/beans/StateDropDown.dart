

import 'package:eco_mfi/beans/DistrictDropDownList.dart';

class StateDropDownList {
  final int statesID;
  final String statesName;
  List<DistrictDropDownList> districtDropDownList;

  StateDropDownList(
      {this.statesID, this.statesName, this.districtDropDownList});

  // {this.statesID, this.statesName});
  factory StateDropDownList.fromJson(Map<String, dynamic> json) {
    return StateDropDownList(
      statesID: json['statesID'] as int,
      statesName: json['statesName'] as String,
      //districtDropDownList: json['districts'].cast<DistrictDropDownList>(),
      districtDropDownList: json['districts']
          .map<DistrictDropDownList>((i) => DistrictDropDownList.fromJson(i))
          .toList(),
    );
  }
}
