

import 'package:eco_mfi/db/TablesColumnFile.dart';

class MenuMasterBean{

  int menuid ;
  String menuDesc ;
  String menutype ;
  String parenttype ;
  String murl ;


  MenuMasterBean(
      {this.menuid,
        this.menuDesc,
        this.menutype,
        this.parenttype,
        this.murl,

      });




  factory MenuMasterBean.fromMap(Map<String, dynamic> map) {
    return MenuMasterBean(
      menuid : map[TablesColumnFile.menuid] as int,
      menuDesc  : map[TablesColumnFile.menuDesc] as String,
      menutype    : map[TablesColumnFile.menutype] as String,
      parenttype    : map[TablesColumnFile.parenttype] as String,
      murl    : map[TablesColumnFile.murl] as String,

    );
  }

}