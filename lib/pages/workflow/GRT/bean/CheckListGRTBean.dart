
import 'package:eco_mfi/db/TablesColumnFile.dart';

class CheckListGRTBean{
  
  int tclgrtrefno;
  int mrefno;
  int trefno;
  int mTableadsid;
  int mclgrtrefno;
  String mleadsid;
  String mquestionid;
  int manschecked;
  String mquestiondesc;

  CheckListGRTBean({this.tclgrtrefno, this.mclgrtrefno, this.mleadsid, this.mquestionid, this.manschecked,this.mrefno,this.trefno,this.mTableadsid});


  @override
  String toString() {
    return 'CheckListGRTBean{tclgrtrefno: $tclgrtrefno, mclgrtrefno: $mclgrtrefno, mleadsid: $mleadsid, mquestionid: $mquestionid, manschecked: $manschecked, mquestiondesc: $mquestiondesc}';
  }

  factory CheckListGRTBean.fromMap(
      Map<String, dynamic> map) {
    print("map data id vala "+map.toString());
    return CheckListGRTBean(
        tclgrtrefno: map[TablesColumnFile.tclgrtrefno] as int,
        mclgrtrefno: map[TablesColumnFile.mclgrtrefno] as int,
        mrefno: map[TablesColumnFile.mrefno] as int,
        trefno: map[TablesColumnFile.trefno]==null?0:map[TablesColumnFile.trefno] as int,
        mleadsid: map[TablesColumnFile.mleadsid] as String,
        mquestionid: map[TablesColumnFile.mquestionid] as String,
        manschecked: map[TablesColumnFile.manschecked] as int,
        mTableadsid:map[TablesColumnFile.mTableadsid] as int
    );
  }

  factory CheckListGRTBean.fromMiddleware(
      Map<String, dynamic> map) {
    print("map data id vala "+map.toString());
    return CheckListGRTBean(
        tclgrtrefno: map[TablesColumnFile.tclgrtrefno] as int,
        mclgrtrefno: map[TablesColumnFile.mclgrtrefno] as int,

        mleadsid: map[TablesColumnFile.mleadsid] as String,
        mquestionid: map[TablesColumnFile.mquestionid] as String,
        manschecked: map[TablesColumnFile.manschecked] as int,
        mTableadsid:map[TablesColumnFile.mTableadsid] as int
    );
  }

}