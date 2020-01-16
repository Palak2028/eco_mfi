class GetCountrySelectionList {
  String cntryCd;
  String countryName;

  GetCountrySelectionList({this.cntryCd, this.countryName});

  factory GetCountrySelectionList.fromJson(Map<String, dynamic> json) {
    return GetCountrySelectionList(
      cntryCd: json['cntryCd'] as String,
      countryName: json['countryName'] as String,
    );
  }
}
