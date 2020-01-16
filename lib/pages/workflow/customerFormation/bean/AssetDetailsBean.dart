import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';

class AssetDetailsBean {
  int tassetdetrefno;
  int trefno;
  int massetdetrefno;
  int mrefno;
  int mcustno;
  int mitem;


  @override
  String toString() {
    return 'AssetDetailsBean{tassetdetrefno: $tassetdetrefno, trefno: $trefno, massetdetrefno: $massetdetrefno, mrefno: $mrefno, mcustno: $mcustno, mitem: $mitem}';
  }

  AssetDetailsBean(
      {
        this.tassetdetrefno,
        this.mrefno,
        this.trefno,
        this.massetdetrefno,
        this.mcustno,
        this.mitem
      });



  factory AssetDetailsBean.fromMap(Map<String, dynamic> map) {
    return AssetDetailsBean(
      mrefno : map[TablesColumnFile.mrefno] as int,
      trefno : map[TablesColumnFile.trefno] as int,
      tassetdetrefno : map[TablesColumnFile.tassetdetrefno] as int,
      massetdetrefno:map[TablesColumnFile.massetdetrefno] as int,
      mcustno: map[TablesColumnFile.mcustno]as int,
      mitem: map[TablesColumnFile.mitem]as int
    );
  }
  factory AssetDetailsBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware) {
    print("fromMap");
    return AssetDetailsBean(
        mrefno : map[TablesColumnFile.mrefno] as int,
        trefno : map[TablesColumnFile.trefno] as int,
        tassetdetrefno : map[TablesColumnFile.tassetdetrefno] as int,
        massetdetrefno:map[TablesColumnFile.massetdetrefno] as int,
        mcustno: map[TablesColumnFile.mcustno]as int,
        mitem: map[TablesColumnFile.mitem]as int
    );}

}
