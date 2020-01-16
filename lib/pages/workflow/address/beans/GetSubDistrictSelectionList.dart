class GetSubDistrictSelectionList {
  String placeCd;
  String placeCdDesc;

  GetSubDistrictSelectionList({this.placeCd, this.placeCdDesc});

  factory GetSubDistrictSelectionList.fromJson(Map<String, dynamic> json) {
    return GetSubDistrictSelectionList(
      placeCd: json['placeCd'] as String,
      placeCdDesc: json['placeCdDesc'] as String,
    );
  }
}
