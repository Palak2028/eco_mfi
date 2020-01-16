import 'package:eco_mfi/db/TablesColumnFile.dart';

class InternalBankTransferBean {

  int mcashtr;
  String mcrdr;
  String mremark;
  String mnarration;
  double mamt;
  String maccid;
  String mdraccid;
  String mcraccid;
  int mstatus;
  String merrormessage;
  int mlbrcode;
  String mcreatedby;

  InternalBankTransferBean({this.mcashtr, this.mcrdr, this.mremark,
      this.mnarration, this.mamt, this.maccid, this.mdraccid, this.mcraccid,
  this.merrormessage,
    this.mstatus,
    this.mlbrcode,
    this.mcreatedby

  });

  @override
  String toString() {
    return 'InternalBankTransferBean{mcashtr: $mcashtr, mcrdr: $mcrdr, mremark: $mremark, mnarration: $mnarration, mamt: $mamt, maccid: $maccid, mdraccid: $mdraccid, mcraccid: $mcraccid}';
  }

  factory InternalBankTransferBean.fromMap(Map<String, dynamic> map) {
    print(map);
    return InternalBankTransferBean(
      mcashtr: map[TablesColumnFile.mcashtr] as int,
      mcrdr: map[TablesColumnFile.mcrdr] as String,
      mremark:map[TablesColumnFile.mremark] as String,
      mnarration: map[TablesColumnFile.mnarration] as String,
      mamt:map[TablesColumnFile.mamt] as double,
      maccid:map[TablesColumnFile.maccid] as String,
      mdraccid:map[TablesColumnFile.mdraccid] as String,
      mcraccid:map[TablesColumnFile.mcraccid] as String,
      mstatus:map[TablesColumnFile.mstatus] as int,
      merrormessage:map[TablesColumnFile.merrormessage] as String,
    );
  }

  factory InternalBankTransferBean.fromMapMiddleware(Map<String, dynamic> map){
    print("fromMapMiddleware");
    print("Receiver String is $map");
    return InternalBankTransferBean(
      mcashtr: map[TablesColumnFile.mcashtr] as int,
      mcrdr: map[TablesColumnFile.mcrdr] as String,
      mremark:map[TablesColumnFile.mremark] as String,
      mnarration: map[TablesColumnFile.mnarration] as String,
      mamt:map[TablesColumnFile.mamt] as double,
      maccid:map[TablesColumnFile.maccid] as String,
      mdraccid:map[TablesColumnFile.mdraccid] as String,
      mcraccid:map[TablesColumnFile.mcraccid] as String,
      mstatus:map[TablesColumnFile.mstatus] as int,
      merrormessage:map[TablesColumnFile.merrormessage] as String,
    );}
}
