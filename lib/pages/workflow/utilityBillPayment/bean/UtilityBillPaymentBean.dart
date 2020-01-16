import 'package:eco_mfi/db/TablesColumnFile.dart';

class UtilityBillPaymentBean {
  int trefno;
  int mrefno;
  String mutilitymode;
  String mutilitytype;
  String minquirytype;
  String mcustno;
  String mutilityprovider;
  String mutilityproviderdesc;
  String	mnic ;
  String	mmobile ;
  String	mrefrenceno ;
  String	mrefrencecnfrm ;
  double	mamount ;


  UtilityBillPaymentBean(
      {
        this.trefno,
        this.mrefno,
        this.mutilitymode,
        this.mutilitytype,
        this.minquirytype,
        this.mcustno,
        this.mutilityprovider,
        this.mnic,
        this.mmobile,
        this.mrefrenceno,
        this.mrefrencecnfrm,
        this.mamount,
        this.mutilityproviderdesc
      });



  factory UtilityBillPaymentBean.fromMap(Map<String, dynamic> map) {
    print("inside for map");
    return UtilityBillPaymentBean(
      trefno:	map[TablesColumnFile.trefno] as int,
      mrefno:	map[TablesColumnFile.mrefno] as int,
      mutilitymode:	map[TablesColumnFile.mutilitymode] as String,
      mutilitytype:	map[TablesColumnFile.mutilitytype] as String,
      minquirytype:	map[TablesColumnFile.minquirytype] as String,
      mcustno:	map[TablesColumnFile.mcustno] as String,
      mutilityprovider:	map[TablesColumnFile.mutilityprovider] as String,
      mnic:	map[TablesColumnFile.mnic] as String,
      mmobile:	map[TablesColumnFile.mmobile] as String,
      mrefrenceno:	map[TablesColumnFile.mrefrenceno] as String,
      mrefrencecnfrm:	map[TablesColumnFile.mrefrencecnfrm] as String,
      mamount:	map[TablesColumnFile.mamount] as double,
      mutilityproviderdesc:	map[TablesColumnFile.mutilityproviderdesc] as String,
    );

  }
  factory UtilityBillPaymentBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap");
    return UtilityBillPaymentBean(
      trefno:	map[TablesColumnFile.trefno] as int,
      mrefno:	map[TablesColumnFile.mrefno] as int,
      mutilitymode:	map[TablesColumnFile.mutilitymode] as String,
      mutilitytype:	map[TablesColumnFile.mutilitytype] as String,
      minquirytype:	map[TablesColumnFile.minquirytype] as String,
      mcustno:	map[TablesColumnFile.mcustno] as String,
      mutilityprovider:	map[TablesColumnFile.mutilityprovider] as String,
      mnic:	map[TablesColumnFile.mnic] as String,
      mmobile:	map[TablesColumnFile.mmobile] as String,
      mrefrenceno:	map[TablesColumnFile.mrefrenceno] as String,
      mrefrencecnfrm:	map[TablesColumnFile.mrefrencecnfrm] as String,
      mamount:	map[TablesColumnFile.mamount] as double,
      mutilityproviderdesc:	map[TablesColumnFile.mutilityproviderdesc] as String,
    );
  }

}

