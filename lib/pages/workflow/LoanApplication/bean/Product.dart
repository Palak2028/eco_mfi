import 'package:eco_mfi/db/TablesColumnFile.dart';

class ProductBean {
  final int mrefno;
  final int mlbrcode;
  final String mprdCd;
  final String mname;
  final double mintrate;
  final int mmoduletype;
  final String mcurCd;
  final String mdivisiontype;
  final DateTime mlastsynsdate;
  final int mnoofguaranter;

  ProductComposieEntity productComposieEntity;
  ProductBean(
      {
        this.mrefno,
        this.mlbrcode,
        this.mprdCd,
        this.mname,
        this.mintrate,
        this.mmoduletype,
        this.mcurCd,
        this.mdivisiontype,
        this.mlastsynsdate,
        this.mnoofguaranter,
      this.productComposieEntity});

  factory ProductBean.fromJson(Map<String, dynamic> map) {
    return ProductBean(
        mlbrcode:map[TablesColumnFile.mlbrcode] as int,
        mprdCd:map[TablesColumnFile.mprdCd] as String,
        mname:map[TablesColumnFile.mname] as String,
        mintrate: map[TablesColumnFile.mintrate] as double,
        mmoduletype:map[TablesColumnFile.mmoduletype] as int,
        mcurCd:map[TablesColumnFile.mcurCd] as String,
      mdivisiontype:map[TablesColumnFile.mdivisiontype] as String,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      mnoofguaranter:map[TablesColumnFile.mnoofguaranter] as int,
    );
  }
  factory ProductBean.fromMap(Map<String, dynamic> map/*,bool isFromMiddleware*/) {

    return ProductBean(
        productComposieEntity: ProductComposieEntity.fromJson(map[TablesColumnFile.productComposieEntity]),
        mname:map[TablesColumnFile.mname] as String,
        mintrate: map[TablesColumnFile.mintrate] as double,
        mmoduletype:map[TablesColumnFile.mmoduletype] as int,
        mcurCd:map[TablesColumnFile.mcurCd] as String,
        mdivisiontype:map[TablesColumnFile.mdivisiontype] as String,
        mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      mnoofguaranter:map[TablesColumnFile.mnoofguaranter] as int,
    );
  }
}



class ProductComposieEntity{
  int mlbrcode;
  String mprdcd;
  ProductComposieEntity({this.mlbrcode, this.mprdcd});

  factory ProductComposieEntity.fromJson(Map<String, dynamic> json) {
    return ProductComposieEntity(
      mlbrcode : json[TablesColumnFile.mlbrcode]!=null && json[TablesColumnFile.mlbrcode]!='null'?json[TablesColumnFile.mlbrcode] as int:0,
      mprdcd : json[TablesColumnFile.mprdcd] as String,

    );
  }
}