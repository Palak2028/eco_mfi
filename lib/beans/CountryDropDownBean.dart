import 'package:eco_mfi/beans/StateDropDown.dart';

class CountryDropDownList {
  //static final CountryDropDownList _singleton = new CountryDropDownList._internal();
  String countryName;
  List<StateDropDownList> stateDropDownList = new List();

  CountryDropDownList({this.countryName, this.stateDropDownList});

  factory CountryDropDownList.fromJson(Map<String, dynamic> json) {
    return CountryDropDownList(
      countryName: json['countryName'] as String,
      // stateDropDownList: json['states'].cast<StateDropDownList>(),
      stateDropDownList: json['states']
          .map<StateDropDownList>((i) => StateDropDownList.fromJson(i))
          .toList(),
    );
  }
}
