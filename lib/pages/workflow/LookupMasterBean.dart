
import 'package:eco_mfi/db/TablesColumnFile.dart';

class LookupMasterBean{

  String mcodedesc;
  String mfield1value;
  int mcodedatatype;
  int mcodedatalen;
  DateTime mlastsynsdate;
  LookUpComposite lookUpComposite;

  LookupMasterBean(
      {

        this.mcodedesc,
        this.mfield1value,
        this.mcodedatatype,
        this.mcodedatalen,
        this.mlastsynsdate,
        this.lookUpComposite
      });

  factory LookupMasterBean.fromJson(Map<String, dynamic> json) {
    return LookupMasterBean(

        mcodedesc : json[TablesColumnFile.mcodedesc] as String,
        mfield1value:json[TablesColumnFile.mfield1value] as String,
        mcodedatatype: json[TablesColumnFile.mcodedatatype]as int,
        mcodedatalen: json[TablesColumnFile.mcodedatalen]as int,
        mlastsynsdate:(json[TablesColumnFile.mlastsynsdate]=="null"||json[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(json[TablesColumnFile.mlastsynsdate]) as DateTime,
        lookUpComposite: LookUpComposite.fromJson(json[TablesColumnFile.lookupComposite])
    );
  }

  factory LookupMasterBean.fromJsonSubLookup(Map<String, dynamic> json) {
    return LookupMasterBean(

        mcodedesc : json[TablesColumnFile.mcodedesc] as String,
        mfield1value:json[TablesColumnFile.mfield1value] as String,
        mcodedatatype: json[TablesColumnFile.mcodedatatype]as int,
        mcodedatalen: json[TablesColumnFile.mcodedatalen]as int,
        mlastsynsdate:(json[TablesColumnFile.mlastsynsdate]=="null"||json[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(json[TablesColumnFile.mlastsynsdate]) as DateTime,
        lookUpComposite: LookUpComposite.fromJson(json[TablesColumnFile.sublookupComposite])
    );
  }

}



class LookUpComposite{
  int mcodetype;
  String mcode;
  LookUpComposite({this.mcodetype, this.mcode});

  factory LookUpComposite.fromJson(Map<String, dynamic> json) {
    return LookUpComposite(
      mcodetype : json[TablesColumnFile.mcodetype]!=null && json[TablesColumnFile.mcodetype]!='null'?json[TablesColumnFile.mcodetype] as int:0,
      mcode : json[TablesColumnFile.mcode] as String,

    );
  }
}


class LookupBeanData{

  int mcodetype;
   String mcode;
  String mcodedesc;
  String mfield1value;
  int mcodedatatype;
  int mcodedatalen;
  DateTime mlastsynsdate;


  @override
  String toString() {
    return 'LookupBeanData{mcodetype: $mcodetype, mcode: $mcode, mcodedesc: $mcodedesc, mfield1value: $mfield1value, mcodedatatype: $mcodedatatype, mcodedatalen: $mcodedatalen, mlastsynsdate: $mlastsynsdate}';
  }

  LookupBeanData(
      {
        this.mcodetype,
        this.mcode,
        this.mcodedesc,
        this.mfield1value,
        this.mcodedatatype,
        this.mcodedatalen,
        this.mlastsynsdate
      });


  factory LookupBeanData.fromJson(Map<String, dynamic> map) {
    return LookupBeanData(
        mcodetype : map[TablesColumnFile.mcodetype] as int,
        mcode : map[TablesColumnFile.mcode] as String,
        mcodedesc : map[TablesColumnFile.mcodedesc] as String,
        mfield1value:map[TablesColumnFile.mfield1value] as String,
        mcodedatatype: map[TablesColumnFile.mcodedatatype]as int,
        mcodedatalen: map[TablesColumnFile.mcodedatalen]as int,
        mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime
    );
  }
}
