

import 'package:eco_mfi/db/TablesColumnFile.dart';

class CheckListCGT2Bean{

  int mrefno;
  int trefno;
  int tclcgt2refno;
  int mclcgt2refno;
  String mtabletleadid;
  String mquestionid;
  int manschecked;
  String mquestiondesc;

  CheckListCGT2Bean({this.tclcgt2refno, this.mclcgt2refno, this.mtabletleadid, this.mquestionid, this.manschecked,this.trefno,this.mrefno});

  @override
  String toString() {
    return 'CheckListCGT2Bean{tclcgt2refno: $tclcgt2refno, mclcgt2refno: $mclcgt2refno, mleadsid: $mtabletleadid, mquestionid: $mquestionid, manschecked: $manschecked}';
  }

  factory CheckListCGT2Bean.fromMap(
      Map<String, dynamic> map) {
    print("map data id vala "+map.toString());
    return CheckListCGT2Bean(
        trefno: map[TablesColumnFile.trefno]==null?0:map[TablesColumnFile.trefno] as int,
        mrefno: map[TablesColumnFile.mrefno] as int,
        tclcgt2refno: map[TablesColumnFile.tclcgt2refno] as int,
        mclcgt2refno: map[TablesColumnFile.mclcgt2refno] as int,
        mtabletleadid: map[TablesColumnFile.mleadsid] as String,
        mquestionid: map[TablesColumnFile.mquestionid] as String,
        manschecked: map[TablesColumnFile.manschecked] as int
    );
  }

  factory CheckListCGT2Bean.frommiddleware(
      Map<String, dynamic> map) {
    print("map data id vala "+map.toString());
    return CheckListCGT2Bean(


        tclcgt2refno: map[TablesColumnFile.tclcgt2refno] as int,
        mclcgt2refno: map[TablesColumnFile.mclcgt2refno] as int,
        mtabletleadid: map[TablesColumnFile.mleadsid] as String,
        mquestionid: map[TablesColumnFile.mquestionid] as String,
        manschecked: map[TablesColumnFile.manschecked] as int
    );
  }

}