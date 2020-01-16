class GetStateSelectionList {
  String stateCd;
  String stateDesc;

  GetStateSelectionList({this.stateCd, this.stateDesc});

  factory GetStateSelectionList.fromJson(Map<String, dynamic> json) {
    return GetStateSelectionList(
      stateCd: json['stateCd'] as String,
      stateDesc: json['stateDesc'] as String,
    );
  }
}
