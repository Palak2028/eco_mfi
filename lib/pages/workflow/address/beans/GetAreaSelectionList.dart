class GetAreaSelectionList {
  String areaCd;
  String areaDesc;

  GetAreaSelectionList({this.areaCd, this.areaDesc});

  factory GetAreaSelectionList.fromJson(Map<String, dynamic> json) {
    return GetAreaSelectionList(
      areaCd: json['areaCd'] as String,
      areaDesc: json['areaDesc'] as String,
    );
  }
}
