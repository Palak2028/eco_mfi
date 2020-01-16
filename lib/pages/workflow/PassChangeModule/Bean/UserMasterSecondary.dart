import 'package:eco_mfi/db/TablesColumnFile.dart';

class UserMasterSecondaryBean {
  String musrcode;
  String musrpass;
  int mstatus;
  String mregdevicemacid;
  DateTime mlastpwdchgdt;
  String newpassword;
  int passExpVal;

  UserMasterSecondaryBean({this.musrcode, this.musrpass, this.mstatus,
      this.mregdevicemacid, this.mlastpwdchgdt,passExpVal});

  @override
  String toString() {
    return 'LoginBean{musrcode: $musrcode,  musrpass: $musrpass, mstatus: $mstatus, '
        'mregdevicemacid: $mregdevicemacid, mlastpwdchgdt: $mlastpwdchgdt}';
  }



  factory UserMasterSecondaryBean.fromMap(Map<String, dynamic> map) {
    return UserMasterSecondaryBean(
      musrcode:map[TablesColumnFile.musrcode] as String,
      mlastpwdchgdt:(map[TablesColumnFile.mlastpwdchgdt]=="null"||map[TablesColumnFile.mlastpwdchgdt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastpwdchgdt]) as DateTime,
      mregdevicemacid:map[TablesColumnFile.mregdevicemacid] as String,
      mstatus:map[TablesColumnFile.mstatus] as int,
      musrpass:map[TablesColumnFile.musrpass] as String,

    );
  }





}