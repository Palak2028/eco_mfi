class GetGroupSelectionList {
  int groupNo;
  String groupName;

  GetGroupSelectionList({this.groupNo, this.groupName});

  factory GetGroupSelectionList.fromJson(Map<String, dynamic> json) {
    return GetGroupSelectionList(
      groupNo: json['groupNumber'] as int,
      groupName: json['groupName'] as String,
    );
  }
}
