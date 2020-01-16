

import 'package:eco_mfi/db/TablesColumnFile.dart';

class InterestSlabBean implements Comparable<InterestSlabBean> {
   String mprdcd;
   String mcurcd;
   DateTime minteffdt;
   int msrno;
   double mtoamt;
   double mintrate;
   DateTime mmlastsynsdate;
   IntrestSlabComposite intrestSlabComposite;


    compareTo(InterestSlabBean interestSlabBean) {
         minteffdt.compareTo(interestSlabBean.minteffdt);

   }

  InterestSlabBean(
      {
        this.mprdcd,
        this.mcurcd,
        this.minteffdt,
        this.msrno,
        this.mtoamt,
        this.mintrate,
        this.mmlastsynsdate,
        this.intrestSlabComposite
      });
  factory InterestSlabBean.fromMap(Map<String, dynamic> map) {
    return InterestSlabBean(
        intrestSlabComposite: IntrestSlabComposite.fromMap(map[TablesColumnFile.interestSlabCompositeEntity]),
        mtoamt: map[TablesColumnFile.mtoamt]as double,
        mintrate: map[TablesColumnFile.mintrate]as double,
        mmlastsynsdate:(map[TablesColumnFile.mmlastsynsdate]=="null"||map[TablesColumnFile.mmlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mmlastsynsdate]) as DateTime
    );
  }

  factory InterestSlabBean.fromMapWitoutComposite(Map<String, dynamic> map) {
    print("fromMap");
    print(map[TablesColumnFile.mtoamt].toString());
    print(map[TablesColumnFile.minteffdt].toString());

    return InterestSlabBean(
        mprdcd : map[TablesColumnFile.mprdcd] as String,
        mcurcd : map[TablesColumnFile.mcurcd] as String,
        minteffdt : (map[TablesColumnFile.minteffdt]=="null"||map[TablesColumnFile.minteffdt]==null)?null:DateTime.parse(map[TablesColumnFile.minteffdt]) as DateTime,
        msrno:map[TablesColumnFile.msrno] as int,
        mtoamt: map[TablesColumnFile.mtoamt]as double,
        mintrate: map[TablesColumnFile.mintrate]as double,
        mmlastsynsdate:(map[TablesColumnFile.mmlastsynsdate]=="null"||map[TablesColumnFile.mmlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mmlastsynsdate]) as DateTime
    );}


}

class IntrestSlabComposite{
  String mprdcd;
  String mcurcd;
  DateTime minteffdt;
  int msrno;


  IntrestSlabComposite(
      {
        this.mprdcd,
        this.mcurcd,
        this.minteffdt,
        this.msrno,
      });

  factory IntrestSlabComposite.fromMap(Map<String, dynamic> map) {
    return IntrestSlabComposite(
    mprdcd : (map[TablesColumnFile.mprdcd]=="null"||map[TablesColumnFile.mprdcd]==null)?"0":map[TablesColumnFile.mprdcd]  as String,
        mcurcd : map[TablesColumnFile.mcurcd] as String,
        minteffdt : (map[TablesColumnFile.minteffdt]=="null"||map[TablesColumnFile.minteffdt]==null)?null:DateTime.parse(map[TablesColumnFile.minteffdt]) as DateTime,
        msrno:map[TablesColumnFile.msrno] as int
    );
  }

}



