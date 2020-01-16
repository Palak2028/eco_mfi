

import 'package:eco_mfi/db/TablesColumnFile.dart';

class CheckListCGT1Bean{

  int mrefno;
  int trefno;
  int tclcgt1refno;
  int mclcgt1refno;
  String mleadsid;
  String mquestionid;
  int manschecked;
  String mquestiondesc;




  CheckListCGT1Bean({this.tclcgt1refno, this.mclcgt1refno, this.mleadsid, this.mquestionid, this.manschecked,this.mrefno,this.trefno,/*,
    this.mproctype, this.mcreateddt, this.mcreatedby,this.mlastupdatedt,this.mlastupdateby,this.mgeolocation,
    this.mgeolatd,this.mgeologd,this.missync,this.mlastsynsdate*/});


  @override
  String toString() {
    return 'CheckListCGT1Bean{tclcgt1refno: $tclcgt1refno, mclcgt1refno: $mclcgt1refno, mleadsid: $mleadsid, mquestionid: $mquestionid, manschecked: $manschecked, mquestiondesc: $mquestiondesc}';
  }

  factory CheckListCGT1Bean.fromMap(
      Map<String, dynamic> map) {
    print("map data id vala "+map.toString());
    return CheckListCGT1Bean(
        trefno: map[TablesColumnFile.trefno]==null?0:map[TablesColumnFile.trefno] as int,
        mrefno: map[TablesColumnFile.mrefno] as int,
        tclcgt1refno: map[TablesColumnFile.tclcgt1refno] as int,
        mclcgt1refno: map[TablesColumnFile.mclcgt1refno] as int,
        mleadsid: map[TablesColumnFile.mleadsid] as String,
        mquestionid: map[TablesColumnFile.mquestionid] as String,
        manschecked: map[TablesColumnFile.manschecked] as int/*,
        mproctype: map[TablesColumnFile.mproctype] as String,
        mcreateddt:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
        mcreatedby: map[TablesColumnFile.mcreatedby] as String,
        mlastupdatedt:  DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
        mlastupdateby: map[TablesColumnFile.mlastupdateby] as String,
        mgeolocation: map[TablesColumnFile.mgeolocation] as String,
        mgeolatd: map[TablesColumnFile.mgeolatd] as String,
        mgeologd: map[TablesColumnFile.mgeologd] as String,
        missync: map[TablesColumnFile.missync] as String,
        mlastsynsdate: DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime*/
    );
  }


  factory CheckListCGT1Bean.frommiddleware(
      Map<String, dynamic> map) {
    print("map data id vala "+map.toString());
    return CheckListCGT1Bean(

       /* "tclcgt1refno": 0,
        "mclcgt1refno": 12,
        "mleadsid": null,
        "mquestionid": "7",
        "manschecked": 0*/

        tclcgt1refno: map[TablesColumnFile.tclcgt1refno] as int,
        mclcgt1refno: map[TablesColumnFile.mclcgt1refno] as int,
        mleadsid: map[TablesColumnFile.mleadsid] as String,
        mquestionid: map[TablesColumnFile.mquestionid] as String,
        manschecked: map[TablesColumnFile.manschecked] as int

    );
  }

}