class CustomMultiSelectModel {
  static const TITLE_KEY = 'title';

  String id;
  String title;
  bool isChecked = false;

  void setIsChecked(bool isChecked) {
    this.isChecked = isChecked;
  }

  bool getIsChecked() {
    return isChecked;
  }

  CustomModel(String ex) {
    title = ex;
  }
}
