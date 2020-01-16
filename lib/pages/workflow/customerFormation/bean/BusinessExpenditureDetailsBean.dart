import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';

class BusinessExpenditureDetailsBean {
  int tbusinexpendrefno;
  int trefno;
  int mbusinexpenrefno;
  int mrefno;
  int mcustno;
  String mbusinexpntype;
  double mbusinevaluationamt;

  BusinessExpenditureDetailsBean(
      {
        this.tbusinexpendrefno,
        this.mrefno,
        this.trefno,
        this.mbusinexpenrefno,
        this.mcustno,
        this.mbusinexpntype,
        this.mbusinevaluationamt
      });



  factory BusinessExpenditureDetailsBean.fromMap(Map<String, dynamic> map) {
    return BusinessExpenditureDetailsBean(
      mrefno : map[TablesColumnFile.mrefno] as int,
      trefno : map[TablesColumnFile.trefno] as int,
      tbusinexpendrefno : map[TablesColumnFile.tbusinexpendrefno] as int,
      mbusinexpenrefno:map[TablesColumnFile.mbusinexpenrefno] as int,
      mcustno: map[TablesColumnFile.mcustno]as int,
      mbusinexpntype: map[TablesColumnFile.mbusinexpntype]as String,
      mbusinevaluationamt: map[TablesColumnFile.mbusinevaluationamt]as double
    );
  }
  factory BusinessExpenditureDetailsBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware) {
    print("fromMap");
    return BusinessExpenditureDetailsBean(
        mrefno : map[TablesColumnFile.mrefno] as int,
        trefno : map[TablesColumnFile.trefno] as int,
        tbusinexpendrefno : map[TablesColumnFile.tbusinexpendrefno] as int,
        mbusinexpenrefno:map[TablesColumnFile.mbusinexpenrefno] as int,
        mcustno: map[TablesColumnFile.mcustno]as int,
        mbusinexpntype: map[TablesColumnFile.mbusinexpntype]as String,
        mbusinevaluationamt: map[TablesColumnFile.mbusinevaluationamt]as double
    );}

}
