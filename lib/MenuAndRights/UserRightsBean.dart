import 'package:eco_mfi/db/TablesColumnFile.dart';



class UserRightBean{

  int mgrpcd ;
  String musrcode ;
  int  menuId ;
  int mchartid ;
  int create ;
  int  modify ;
  int browse ;
  int authority ;
  int delete ;
  int menuid ;
  String menuDesc ;
  String menutype ;
  String parenttype ;
  String murl ;
  UserAccressRightsCompositeEntity userAccressRightsCompositeEntity;

  UserRightBean(
      {this.mgrpcd,
        this.musrcode,
        this.menuId,
        this.mchartid,
        this.create,
        this.modify,
        this.browse,
        this.authority,
        this.delete,
        this.menuid,
        this.menuDesc,
        this.menutype,
        this.parenttype,
        this.murl,
        this.userAccressRightsCompositeEntity

  });


  @override
  String toString() {
    return 'UserRightBean{mgrpcd: $mgrpcd, musrcode: $musrcode, menuId: $menuId, mchartid: $mchartid, create: $create, modify: $modify, browse: $browse, authority: $authority, delete: $delete, menuid: $menuid, menuDesc: $menuDesc, menutype: $menutype, parenttype: $parenttype, murl: $murl}';
  }

  factory UserRightBean.fromMap(Map<String, dynamic> map) {
    return UserRightBean(
      mgrpcd : map[TablesColumnFile.mgrpcd] as int,
      musrcode  : map[TablesColumnFile.musrcode] as String,
      menuId    : map[TablesColumnFile.menuId] as int,
      mchartid    : map[TablesColumnFile.mchartid] as int,
      create    : map[TablesColumnFile.create] as int,
      modify   : map[TablesColumnFile.modify] as int,
      browse   : map[TablesColumnFile.browse] as int,
      authority   : map[TablesColumnFile.authority] as int,
      delete   : map[TablesColumnFile.delete] as int,

    );
  }

  factory UserRightBean.fromJoinMap(Map<String, dynamic> map) {
    return UserRightBean(
      mgrpcd : map[TablesColumnFile.mgrpcd] as int,
      musrcode  : map[TablesColumnFile.musrcode] as String,
      menuId    : map[TablesColumnFile.menuId] as int,
      mchartid    : map[TablesColumnFile.mchartid] as int,
      create    : map[TablesColumnFile.create] as int,
      modify   : map[TablesColumnFile.modify] as int,
      browse   : map[TablesColumnFile.browse] as int,
      authority   : map[TablesColumnFile.authority] as int,
      delete   : map[TablesColumnFile.delete] as int,
      menuid : map[TablesColumnFile.menuid] as int,
      menuDesc  : map[TablesColumnFile.menuDesc] as String,
      menutype    : map[TablesColumnFile.menutype] as String,
      parenttype    : map[TablesColumnFile.parenttype] as String,
      murl    : map[TablesColumnFile.murl] as String,


    );
  }


  factory UserRightBean.fromMiddlewareMap(Map<String, dynamic> map) {
    return UserRightBean(
      userAccressRightsCompositeEntity: UserAccressRightsCompositeEntity.fromJson(map[TablesColumnFile.userAccressRightsCompositeEntity]),
      mchartid    : map[TablesColumnFile.mchartid] as int,
      create    : map[TablesColumnFile.create] as int,
      modify   : map[TablesColumnFile.modify] as int,
      browse   : map[TablesColumnFile.browse] as int,
      authority   : map[TablesColumnFile.authority] as int,
      delete   : map[TablesColumnFile.delete] as int,
      menuid : map[TablesColumnFile.menuid] as int,
      menuDesc  : map[TablesColumnFile.menuDesc] as String,
      menutype    : map[TablesColumnFile.menutype] as String,
      parenttype    : map[TablesColumnFile.parenttype] as String,
      murl    : map[TablesColumnFile.murl] as String,


    );
  }



}

class UserAccressRightsCompositeEntity{
  int mgrpcd;
  String usrcode;
  int menuid;

  UserAccressRightsCompositeEntity({this.mgrpcd, this.usrcode,this.menuid});

  factory UserAccressRightsCompositeEntity.fromJson(Map<String, dynamic> json) {
    return UserAccressRightsCompositeEntity(
      mgrpcd : json[TablesColumnFile.mgrpcd]!=null && json[TablesColumnFile.mgrpcd]!='null'?json[TablesColumnFile.mgrpcd] as int:0,
      usrcode : json[TablesColumnFile.usrcd] as String,
      menuid : json[TablesColumnFile.menuid]!=null && json[TablesColumnFile.menuid]!='null'?json[TablesColumnFile.menuid] as int:0,

    );
  }
}