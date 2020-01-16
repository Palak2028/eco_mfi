
class DistrictDropDownList {
  final int districtsID;
  final String districtsName;

  DistrictDropDownList({this.districtsID, this.districtsName});

  factory DistrictDropDownList.fromJson(Map<String, dynamic> json) {
    return DistrictDropDownList(
        districtsID: json['districtsID'] as int,
        districtsName: json['districtsName'] as String);
  }
}
