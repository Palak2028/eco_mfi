import 'package:eco_mfi/db/TablesColumnFile.dart';

class SettingsBean {
int trefno;
  String musrcode;
  String musrpass;
  String mipaddress;
  String mportno;
  int yesno;
  int isHttps;
 int isPortRequired;


  SettingsBean({
    this.trefno,
    this.musrcode,
    this.musrpass,
    this.mipaddress,
    this.mportno,
    this.yesno,
    this.isHttps,
    this.isPortRequired
  });

  factory SettingsBean.fromMap(Map<String, dynamic> map) {
    for (var itmes in map.toString().split(",")) {
      print(itmes);
    }
    print("inside map");
    return SettingsBean(
        trefno: map[TablesColumnFile.trefno]as int,
        musrcode: map[TablesColumnFile.musrcode] as String,
        musrpass: map[TablesColumnFile.musrpass] as String,
        mipaddress: map[TablesColumnFile.mipaddress] as String,
        mportno: map[TablesColumnFile.mportno]as String,
        yesno: map[TablesColumnFile.yesno] as int,
       isHttps: map[TablesColumnFile.isHttps] as int,
       isPortRequired: map[TablesColumnFile.isPortRequired] as int



    );
  }

  factory SettingsBean.fromJson(Map<String, dynamic> map) {
    return SettingsBean(
        trefno: map[TablesColumnFile.trefno]as int,
        musrcode: map[TablesColumnFile.musrcode] as String,
        musrpass: map[TablesColumnFile.musrpass] as String,
        mipaddress: map[TablesColumnFile.mipaddress] as String,
        mportno: map[TablesColumnFile.mportno]as String,
        isHttps: map[TablesColumnFile.isHttps] as int,
        isPortRequired: map[TablesColumnFile.isPortRequired] as int,
        yesno: map[TablesColumnFile.yesno] as int
    );
  }

}