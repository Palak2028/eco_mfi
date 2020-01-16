import 'package:eco_mfi/db/TablesColumnFile.dart';

class BranchMasterBean {
  int mpbrcode;
  String mname;
  String mshortname;
  String madd1;
  String madd2;
  String madd3;
  String mcitycd;
  int mpincode;
  String mcountrycd;
  int mbranchtype;
  String mtele1;
  String mtele2;
  String mfaxno1;
  String mswiftaddr;
  String mpostcode;
  int mweekoff1;
  int mweekoff2;
  int mparentbrcode;
  int mbranchtype1;
  int mbranchcat;
  DateTime mformatndt;
  String mdistrict;
  String mbrnmanager;
  String mstate;
  int mmaxgroupmembers;
  int mmingroupmembers;
  int msector;
  String mbranchemailid;
  String mbiccode;
  String mlegacybrncd;
  double mlatitude;
  double mlongitude;
  DateTime mlastopendate;

  BranchMasterBean({
    this.mpbrcode,
    this.mname,
    this.mshortname,
    this.madd1,
    this.madd2,
    this.madd3,
    this.mcitycd,
    this.mpincode,
    this.mcountrycd,
    this.mbranchtype,
    this.mtele1,
    this.mtele2,
    this.mfaxno1,
    this.mswiftaddr,
    this.mpostcode,
    this.mweekoff1,
    this.mweekoff2,
    this.mparentbrcode,
    this.mbranchtype1,
    this.mbranchcat,
    this.mformatndt,
    this.mdistrict,
    this.mbrnmanager,
    this.mstate,
    this.mmaxgroupmembers,
    this.mmingroupmembers,
    this.msector,
    this.mbranchemailid,
    this.mbiccode,
    this.mlegacybrncd,
    this.mlatitude,
    this.mlongitude,
    this.mlastopendate,
  });

  factory BranchMasterBean.fromMap(Map<String, dynamic> map) {
    print("map data id vala " + map.toString());
    return BranchMasterBean(
      mpbrcode: map[TablesColumnFile.mpbrcode] as int,
      mname: map[TablesColumnFile.mname] as String,
      mshortname: map[TablesColumnFile.mshortname] as String,
      madd1: map[TablesColumnFile.madd1] as String,
      madd2: map[TablesColumnFile.madd2] as String,
      madd3: map[TablesColumnFile.madd3] as String,
      mcitycd: map[TablesColumnFile.mcitycd] as String,
      mpincode: map[TablesColumnFile.mpincode] as int,
      mcountrycd: map[TablesColumnFile.mcountrycd] as String,
      mbranchtype: map[TablesColumnFile.mbranchtype] as int,
      mtele1: map[TablesColumnFile.mtele1] as String,
      mtele2: map[TablesColumnFile.mtele2] as String,
      mfaxno1: map[TablesColumnFile.mfaxno1] as String,
      mswiftaddr: map[TablesColumnFile.mswiftaddr] as String,
      mpostcode: map[TablesColumnFile.mpostcode] as String,
      mweekoff1: map[TablesColumnFile.mweekoff1] as int,
      mweekoff2: map[TablesColumnFile.mweekoff2] as int,
      mparentbrcode: map[TablesColumnFile.mparentbrcode],
      mbranchtype1: map[TablesColumnFile.mbranchtype1] as int,
      mbranchcat: map[TablesColumnFile.mbranchcat] as int,
      mformatndt: (map[TablesColumnFile.mformatndt] == "null" ||
              map[TablesColumnFile.mformatndt] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mformatndt]) as DateTime,
      mdistrict: map[TablesColumnFile.mdistrict] as String,
      mbrnmanager: map[TablesColumnFile.mbrnmanager] as String,
      mstate: map[TablesColumnFile.mstate] as String,
      mmaxgroupmembers: map[TablesColumnFile.mmaxgroupmembers] as int,
      mmingroupmembers: map[TablesColumnFile.mmingroupmembers] as int,
      msector: map[TablesColumnFile.msector] as int,
      mbranchemailid: map[TablesColumnFile.mbranchemailid] as String,
      mbiccode: map[TablesColumnFile.mbiccode] as String,
      mlegacybrncd: map[TablesColumnFile.mlegacybrncd] as String,
      mlatitude: map[TablesColumnFile.mlatitude] as double,
      mlongitude: map[TablesColumnFile.mlongitude] as double,
      mlastopendate: (map[TablesColumnFile.mlastopendate] == "null" ||
              map[TablesColumnFile.mlastopendate] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mlastopendate]) as DateTime,
    );
  }

  factory BranchMasterBean.fromMiddleware(Map<String, dynamic> map) {
    print("map data id vala " + map.toString());
    return BranchMasterBean(
        mpbrcode: map[TablesColumnFile.mpbrcode] as int,
        mname: map[TablesColumnFile.mname] as String,
        mshortname: map[TablesColumnFile.mshortname] as String,
        madd1: map[TablesColumnFile.madd1] as String,
        madd2: map[TablesColumnFile.madd2] as String,
        madd3: map[TablesColumnFile.madd3] as String,
        mcitycd: map[TablesColumnFile.mcitycd] as String,
        mpincode: map[TablesColumnFile.mpincode] as int,
        mcountrycd: map[TablesColumnFile.mcountrycd] as String,
        mbranchtype: map[TablesColumnFile.mbranchtype] as int,
        mtele1: map[TablesColumnFile.mtele1] as String,
        mtele2: map[TablesColumnFile.mtele2] as String,
        mfaxno1: map[TablesColumnFile.mfaxno1] as String,
        mswiftaddr: map[TablesColumnFile.mswiftaddr] as String,
        mpostcode: map[TablesColumnFile.mpostcode] as String,
        mweekoff1: map[TablesColumnFile.mweekoff1] as int,
        mweekoff2: map[TablesColumnFile.mweekoff2] as int,
        mparentbrcode: map[TablesColumnFile.mparentbrcode],
        mbranchtype1: map[TablesColumnFile.mbranchtype1] as int,
        mbranchcat: map[TablesColumnFile.mbranchcat] as int,
        mformatndt: (map[TablesColumnFile.mformatndt] == "null" ||
                map[TablesColumnFile.mformatndt] == null)
            ? null
            : DateTime.parse(map[TablesColumnFile.mformatndt]) as DateTime,
        mdistrict: map[TablesColumnFile.mdistrict] as String,
        mbrnmanager: map[TablesColumnFile.mbrnmanager] as String,
        mstate: map[TablesColumnFile.mstate] as String,
        mmaxgroupmembers: map[TablesColumnFile.mmaxgroupmembers] as int,
        mmingroupmembers: map[TablesColumnFile.mmingroupmembers] as int,
        msector: map[TablesColumnFile.msector] as int,
        mbranchemailid: map[TablesColumnFile.mbranchemailid] as String,
        mbiccode: map[TablesColumnFile.mbiccode] as String,
        mlegacybrncd: map[TablesColumnFile.mlegacybrncd] as String,
        mlatitude: map[TablesColumnFile.mlatitude] as double,
        mlongitude: map[TablesColumnFile.mlongitude] as double,
        mlastopendate: (map[TablesColumnFile.mlastopendate] == "null" ||
                map[TablesColumnFile.mlastopendate] == null)
            ? null
            : DateTime.parse(map[TablesColumnFile.mlastopendate]) as DateTime);
  }

  @override
  String toString() {
    return 'BranchMasterBean{mpbrcode: $mpbrcode, mname: $mname, mshortname: $mshortname, madd1: $madd1, madd2: $madd2, madd3: $madd3, mcitycd: $mcitycd, mpincode: $mpincode, mcountrycd: $mcountrycd, mbranchtype: $mbranchtype, mtele1: $mtele1, mtele2: $mtele2, mfaxno1: $mfaxno1, mswiftaddr: $mswiftaddr, mpostcode: $mpostcode, mweekoff1: $mweekoff1, mweekoff2: $mweekoff2, mparentbrcode: $mparentbrcode, mbranchtype1: $mbranchtype1, mbranchcat: $mbranchcat, mformatndt: $mformatndt, mdistrict: $mdistrict, mbrnmanager: $mbrnmanager, mstate: $mstate, mmaxgroupmembers: $mmaxgroupmembers, mmingroupmembers: $mmingroupmembers, msector: $msector, mbranchemailid: $mbranchemailid, mbiccode: $mbiccode, mlegacybrncd: $mlegacybrncd, mlatitude: $mlatitude, mlongitude: $mlongitude, mlastopendate: $mlastopendate}';
  }
}
