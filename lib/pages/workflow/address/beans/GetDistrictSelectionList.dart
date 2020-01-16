class GetDistrictSelectionList {
  String distCd;
  String distDesc;

  GetDistrictSelectionList({this.distCd, this.distDesc});

  factory GetDistrictSelectionList.fromJson(Map<String, dynamic> json) {
    return GetDistrictSelectionList(
      distCd: json['distCd'] as String,
      distDesc: json['distDesc'] as String,
    );
  }
}
