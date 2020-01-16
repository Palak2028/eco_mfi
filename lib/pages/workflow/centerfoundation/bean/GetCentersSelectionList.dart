class GetCenterSelectionList {
  int centerNo;
  String centerName;

  GetCenterSelectionList({this.centerNo, this.centerName});

  factory GetCenterSelectionList.fromJson(Map<String, dynamic> json) {
    return GetCenterSelectionList(
      centerNo: json['id'] as int,
      centerName: json['centerName'] as String,
    );
  }
}
