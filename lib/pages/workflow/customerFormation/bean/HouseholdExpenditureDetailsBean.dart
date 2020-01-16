import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';

class HouseholdExpenditureDetailsBean {
  int thoushldexpendrefno;
  int trefno;
  int mhoushldexpenrefno;
  int mrefno;
  int mcustno;
  String mhoushldexpntype;
  double mhoushldevaluationamt;

  HouseholdExpenditureDetailsBean(
      {
        this.thoushldexpendrefno,
        this.mrefno,
        this.trefno,
        this.mhoushldexpenrefno,
        this.mcustno,
        this.mhoushldexpntype,
        this.mhoushldevaluationamt
      });



  factory HouseholdExpenditureDetailsBean.fromMap(Map<String, dynamic> map) {
    return HouseholdExpenditureDetailsBean(
      mrefno : map[TablesColumnFile.mrefno] as int,
      trefno : map[TablesColumnFile.trefno] as int,
      thoushldexpendrefno : map[TablesColumnFile.thoushldexpendrefno] as int,
      mhoushldexpenrefno:map[TablesColumnFile.mhoushldexpenrefno] as int,
      mcustno: map[TablesColumnFile.mcustno]as int,
      mhoushldexpntype: map[TablesColumnFile.mhoushldexpntype]as String,
      mhoushldevaluationamt: map[TablesColumnFile.mhoushldevaluationamt]as double
    );
  }
  factory HouseholdExpenditureDetailsBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware) {
    print("fromMap");
    return HouseholdExpenditureDetailsBean(
        mrefno : map[TablesColumnFile.mrefno] as int,
        trefno : map[TablesColumnFile.trefno] as int,
        thoushldexpendrefno : map[TablesColumnFile.thoushldexpendrefno] as int,
        mhoushldexpenrefno:map[TablesColumnFile.mhoushldexpenrefno] as int,
        mcustno: map[TablesColumnFile.mcustno]as int,
        mhoushldexpntype: map[TablesColumnFile.mhoushldexpntype]as String,
        mhoushldevaluationamt: map[TablesColumnFile.mhoushldevaluationamt]as double
    );}

}
