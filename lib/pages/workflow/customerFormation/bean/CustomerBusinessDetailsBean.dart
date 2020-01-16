import 'package:eco_mfi/db/TablesColumnFile.dart';

class CustomerBusinessDetailsBean {

  int mbussdetailsrefno;
  int trefno;
  //numeric(8)
  int mrefno;
  int tbussdetailsrefno;
  int mcusactivitytype;
  String mbusinessname;

  @override
  String toString() {
    return 'CustomerBusinessDetailsBean{mbussdetailsrefno: $mbussdetailsrefno, trefno: $trefno, mrefno: $mrefno, tbussdetailsrefno: $tbussdetailsrefno, mcusactivitytype: $mcusactivitytype, mbusinessname: $mbusinessname, mbusaddress1: $mbusaddress1, mbusaddress2: $mbusaddress2, mbusaddress3: $mbusaddress3, mbusaddress4: $mbusaddress4, mbuscity: $mbuscity, mdistcd: $mdistcd, mbusstate: $mbusstate, mbuscountry: $mbuscountry, mbusarea: $mbusarea, mbusvillage: $mbusvillage, mbuslandmark: $mbuslandmark, mbuspin: $mbuspin, mbusyrsmnths: $mbusyrsmnths, mregisteredyn: $mregisteredyn, mregistrationno: $mregistrationno, mbusothtomanageabsyn: $mbusothtomanageabsyn, mbusothmanagername: $mbusothmanagername, mbusothmanagerrel: $mbusothmanagerrel, mbusmonthlyincome: $mbusmonthlyincome, mbusseasonalityjan: $mbusseasonalityjan, mbusseasonalityfeb: $mbusseasonalityfeb, mbusseasonalitymar: $mbusseasonalitymar, mbusseasonalityapr: $mbusseasonalityapr, mbusseasonalitymay: $mbusseasonalitymay, mbusseasonalityjun: $mbusseasonalityjun, mbusseasonalityjul: $mbusseasonalityjul, mbusseasonalityaug: $mbusseasonalityaug, mbusseasonalitysep: $mbusseasonalitysep, mbusseasonalityoct: $mbusseasonalityoct, mbusseasonalitynov: $mbusseasonalitynov, mbusseasonalitydec: $mbusseasonalitydec, mbushighsales: $mbushighsales, mbusmediumsales: $mbusmediumsales, mbuslowsales: $mbuslowsales, mbushighincome: $mbushighincome, mbusmediumincom: $mbusmediumincom, mbuslowincome: $mbuslowincome, mbusmonthlytotaleval: $mbusmonthlytotaleval, mbusmonthlytotalverif: $mbusmonthlytotalverif, mbusincludesurcalcyn: $mbusincludesurcalcyn, mbusnhousesameplaceyn: $mbusnhousesameplaceyn, mbusinesstrend: $mbusinesstrend}';
  }

  String mbusaddress1;
  String mbusaddress2;
  String mbusaddress3;
  String mbusaddress4;
  String mbuscity;
  int mdistcd;
  String mbusstate;
  String mbuscountry;
  int mbusarea;
  int mbusvillage;
  String mbuslandmark;
  int mbuspin;
  int mbusyrsmnths;
  String mregisteredyn;
  String mregistrationno;
  String mbusothtomanageabsyn;
  String mbusothmanagername;
  int mbusothmanagerrel;
  double mbusmonthlyincome;
  String mbusseasonalityjan;
  String mbusseasonalityfeb;
  String mbusseasonalitymar;
  String mbusseasonalityapr;
  String mbusseasonalitymay;
  String mbusseasonalityjun;
  String mbusseasonalityjul;
  String mbusseasonalityaug;
  String mbusseasonalitysep;
  String mbusseasonalityoct;
  String mbusseasonalitynov;
  String mbusseasonalitydec;
  double mbushighsales;
  double mbusmediumsales;
  double mbuslowsales;
  double mbushighincome;
  double mbusmediumincom;
  double mbuslowincome;
  //mbusmonthlytotalEval
  double mbusmonthlytotaleval;
  //mbusmonthlytotalVerif
  double mbusmonthlytotalverif;
  String mbusincludesurcalcyn;
  String mbusnhousesameplaceyn;
  String mbusinesstrend;
  double mmonthlyincome;
  double mtotalmonthlyincome;
  double mbusinessexpense;
  double mhousehldexpense;
  double mmonthlyemi;
  double mincomeemiratio;
  double mnetamount;
  double mpercentage;


  CustomerBusinessDetailsBean(
      {this.tbussdetailsrefno,
      this.mbussdetailsrefno,
      this.trefno,
      this.mrefno,
      this.mcusactivitytype,
      this.mbusinessname,
      this.mbusaddress1,
      this.mbusaddress2,
      this.mbusaddress3,
      this.mbusaddress4,
      this.mbuscity,
      this.mdistcd,
      this.mbusstate,
      this.mbuscountry,
      this.mbusarea,
      this.mbusvillage,
      this.mbuslandmark,
      this.mbuspin,
      this.mbusyrsmnths,
      this.mregisteredyn,
      this.mregistrationno,
      this.mbusothtomanageabsyn,
      this.mbusothmanagername,
      this.mbusothmanagerrel,
      this.mbusmonthlyincome,
      this.mbusseasonalityjan,
      this.mbusseasonalityfeb,
      this.mbusseasonalitymar,
      this.mbusseasonalityapr,
      this.mbusseasonalitymay,
      this.mbusseasonalityjun,
      this.mbusseasonalityjul,
      this.mbusseasonalityaug,
      this.mbusseasonalitysep,
      this.mbusseasonalityoct,
      this.mbusseasonalitynov,
      this.mbusseasonalitydec,
      this.mbushighsales,
      this.mbusmediumsales,
      this.mbuslowsales,
      this.mbushighincome,
      this.mbusmediumincom,
      this.mbuslowincome,
      //mbusmonthlytotalEval
      this.mbusmonthlytotaleval,
      //mbusmonthlytotalVerif
      this.mbusmonthlytotalverif,
      this.mbusincludesurcalcyn,
      this.mbusnhousesameplaceyn,
      this.mbusinesstrend,
      this.mmonthlyincome,
      this.mtotalmonthlyincome,
      this.mbusinessexpense,
      this.mhousehldexpense,
      this.mincomeemiratio,
      this.mmonthlyemi,
      this.mnetamount,
      this.mpercentage
      });

  factory CustomerBusinessDetailsBean.fromMap(Map<String, dynamic> map) {
    return CustomerBusinessDetailsBean(
      mbussdetailsrefno: map[TablesColumnFile.mbussdetailsrefno] as int,
      trefno: map[TablesColumnFile.trefno] as int,
      mrefno: map[TablesColumnFile.mrefno] as int,
      tbussdetailsrefno: map[TablesColumnFile.tbussdetailsrefno] as int,
      mcusactivitytype: map[TablesColumnFile.mcusactivitytype] as int,
      mbusinessname: map[TablesColumnFile.mbusinessname] as String,
      mbusaddress1: map[TablesColumnFile.mbusaddress1] as String,
      mbusaddress2: map[TablesColumnFile.mbusaddress2] as String,
      mbusaddress3: map[TablesColumnFile.mbusaddress3] as String,
      mbusaddress4: map[TablesColumnFile.mbusaddress4] as String,
      mbuscity: map[TablesColumnFile.mbuscity] as String,
      mdistcd: map[TablesColumnFile.mdistcd] as int,
      mbusstate: map[TablesColumnFile.mbusstate] as String,
      mbuscountry: map[TablesColumnFile.mbuscountry] as String,
      mbusarea: map[TablesColumnFile.mbusarea] as int,
      mbusvillage: map[TablesColumnFile.mbusvillage] as int,
      mbuslandmark: map[TablesColumnFile.mbuslandmark] as String,
      mbuspin: map[TablesColumnFile.mbuspin] as int,
      mbusyrsmnths: map[TablesColumnFile.mbusyrsmnths] as int,
      mregisteredyn: map[TablesColumnFile.mregisteredyn] as String,
      mregistrationno: map[TablesColumnFile.mregistrationno] as String,
      mbusothtomanageabsyn:
          map[TablesColumnFile.mbusothtomanageabsyn] as String,
      mbusothmanagername: map[TablesColumnFile.mbusothmanagername] as String,
      mbusothmanagerrel: map[TablesColumnFile.mbusothmanagerrel] != null &&
              map[TablesColumnFile.mbusothmanagerrel] != 'null'
          ? map[TablesColumnFile.mbusothmanagerrel] as int
          : 0,
      mbusmonthlyincome: map[TablesColumnFile.mbusmonthlyincome] != null &&
              map[TablesColumnFile.mbusmonthlyincome] != 'null'
          ? map[TablesColumnFile.mbusmonthlyincome] as double
          : 0.0,
      mbusseasonalityjan: map[TablesColumnFile.mbusseasonalityjan] as String,
      mbusseasonalityfeb: map[TablesColumnFile.mbusseasonalityfeb] as String,
      mbusseasonalitymar: map[TablesColumnFile.mbusseasonalitymar] as String,
      mbusseasonalityapr: map[TablesColumnFile.mbusseasonalityapr] as String,
      mbusseasonalitymay: map[TablesColumnFile.mbusseasonalitymay] as String,
      mbusseasonalityjun: map[TablesColumnFile.mbusseasonalityjun] as String,
      mbusseasonalityjul: map[TablesColumnFile.mbusseasonalityjul] as String,
      mbusseasonalityaug: map[TablesColumnFile.mbusseasonalityaug] as String,
      mbusseasonalitysep: map[TablesColumnFile.mbusseasonalitysep] as String,
      mbusseasonalityoct: map[TablesColumnFile.mbusseasonalityoct] as String,
      mbusseasonalitynov: map[TablesColumnFile.mbusseasonalitynov] as String,
      mbusseasonalitydec: map[TablesColumnFile.mbusseasonalitydec] as String,
      mbushighsales: map[TablesColumnFile.mbushighsales] != null &&
              map[TablesColumnFile.mbushighsales] != 'null'
          ? map[TablesColumnFile.mbushighsales] as double
          : 0.0,
      mbusmediumsales: map[TablesColumnFile.mbusmediumsales] != null &&
              map[TablesColumnFile.mbusmediumsales] != 'null'
          ? map[TablesColumnFile.mbusmediumsales] as double
          : 0.0,
      mbuslowsales: map[TablesColumnFile.mbuslowsales] as double,
      mbushighincome: map[TablesColumnFile.mbushighincome] as double,
      mbusmediumincom: map[TablesColumnFile.mbusmediumincom] as double,
      mbuslowincome: map[TablesColumnFile.mbuslowincome] as double,
      //mbusmonthlytotalEval
      mbusmonthlytotaleval:
          map[TablesColumnFile.mbusmonthlytotaleval] as double,
      //mbusmonthlytotalVerif
      mbusmonthlytotalverif:
          map[TablesColumnFile.mbusmonthlytotalverif] as double,
      mbusincludesurcalcyn:
          map[TablesColumnFile.mbusincludesurcalcyn] as String,
      mbusnhousesameplaceyn:
          map[TablesColumnFile.mbusnhousesameplaceyn] as String,
      mbusinesstrend: map[TablesColumnFile.mbusinesstrend] as String,
      mmonthlyincome: map[TablesColumnFile.mmonthlyincome]as double,
      mtotalmonthlyincome : map[TablesColumnFile.mtotalmonthlyincome]as double,
      mbusinessexpense: map[TablesColumnFile.mbusinessexpense]as double,
      mhousehldexpense: map[TablesColumnFile.mhousehldexpense]as double,
      mincomeemiratio: map[TablesColumnFile.mincomeemiratio]as double,
      mmonthlyemi: map[TablesColumnFile.mmonthlyemi]as double,
      mnetamount: map[TablesColumnFile.mnetamount]as double,
      mpercentage: map[TablesColumnFile.mpercentage]as double,
    );
  }

  factory CustomerBusinessDetailsBean.fromMapMiddleware(
      Map<String, dynamic> map) {
    print("fromMaBuisnessp" + map.toString());
    //  print(map[TablesColumnFile.mbussdetailsrefno]);

    return CustomerBusinessDetailsBean(
      /* tbussdetailsrefno: map[TablesColumnFile.tbussdetailsrefno] != null &&
            map[TablesColumnFile.tbussdetailsrefno] != 'null'
            ? map[TablesColumnFile.tbussdetailsrefno] as int
            : 0,*/
      mbussdetailsrefno:
              /*map[TablesColumnFile.mbussdetailsrefno] != null &&
            map[TablesColumnFile.mbussdetailsrefno] != 'null'
            ?*/
              map[TablesColumnFile.mbussdetailsrefno] as int
          /*: 0*/,
      trefno: map[TablesColumnFile.trefno] as int,
      // mrefno: map[TablesColumnFile.mrefno] as int,
      //tbussdetailsrefno: map[TablesColumnFile.tbussdetailsrefno] as int,
      mcusactivitytype: map[TablesColumnFile.mcusactivitytype] != null &&
              map[TablesColumnFile.mcusactivitytype] != 'null' &&
              map[TablesColumnFile.mcusactivitytype] != ''
          ? map[TablesColumnFile.mcusactivitytype] as int
          : 0,
      mbusinessname: map[TablesColumnFile.mbusinessname] != null &&
          map[TablesColumnFile.mbusinessname] != 'null' &&
          map[TablesColumnFile.mbusinessname] != ''?map[TablesColumnFile.mbusinessname] as String:"",
      mbusaddress1: map[TablesColumnFile.mbusaddress1] as String,
      mbusaddress2: map[TablesColumnFile.mbusaddress2] as String,
      mbusaddress3: map[TablesColumnFile.mbusaddress3] as String,
      mbusaddress4: map[TablesColumnFile.mbusaddress4] as String,
      mbuscity: map[TablesColumnFile.mbuscity] as String,
      mdistcd: map[TablesColumnFile.mdistcd] != null &&
              map[TablesColumnFile.mdistcd] != 'null' &&
              map[TablesColumnFile.mdistcd] != ''
          ? map[TablesColumnFile.mdistcd] as int
          : 0,
      mbusstate: map[TablesColumnFile.mbusstate] as String,
      mbuscountry: map[TablesColumnFile.mbuscountry] as String,
      mbusarea: map[TablesColumnFile.mbusarea] != null &&
              map[TablesColumnFile.mbusarea] != 'null' &&
              map[TablesColumnFile.mbusarea] != ''
          ? map[TablesColumnFile.mbusarea] as int
          : 0,
      mbusvillage: map[TablesColumnFile.mbusvillage] != null &&
              map[TablesColumnFile.mbusvillage] != 'null' &&
              map[TablesColumnFile.mbusvillage] != ''
          ? map[TablesColumnFile.mbusvillage] as int
          : 0,
      mbuslandmark: map[TablesColumnFile.mbuslandmark] as String,
      mbuspin: map[TablesColumnFile.mbuspin] != null &&
              map[TablesColumnFile.mbuspin] != 'null' &&
              map[TablesColumnFile.mbuspin] != ''
          ? map[TablesColumnFile.mbuspin] as int
          : 0,
      mbusyrsmnths: map[TablesColumnFile.mbusyrsmnths] != null &&
              map[TablesColumnFile.mbusyrsmnths] != 'null' &&
              map[TablesColumnFile.mbusyrsmnths] != ''
          ? map[TablesColumnFile.mbusyrsmnths] as int
          : 0,
      mregisteredyn: map[TablesColumnFile.mregisteredyn] as String,
      mregistrationno: map[TablesColumnFile.mregistrationno] as String,
      mbusothtomanageabsyn:
          map[TablesColumnFile.mbusothtomanageabsyn] as String,
      mbusothmanagername: map[TablesColumnFile.mbusothmanagername] as String,
      mbusothmanagerrel: map[TablesColumnFile.mbusothmanagerrel] != null &&
              map[TablesColumnFile.mbusothmanagerrel] != 'null' &&
              map[TablesColumnFile.mbusothmanagerrel] != ''
          ? map[TablesColumnFile.mbusothmanagerrel] as int
          : 0,
      mbusmonthlyincome: map[TablesColumnFile.mbusmonthlyincome] != null &&
              map[TablesColumnFile.mbusmonthlyincome] != 'null' &&
              map[TablesColumnFile.mbusmonthlyincome] != ''
          ? map[TablesColumnFile.mbusmonthlyincome] as double
          : 0.0,
      mbusseasonalityjan: map[TablesColumnFile.mbusseasonalityjan] as String,
      mbusseasonalityfeb: map[TablesColumnFile.mbusseasonalityfeb] as String,
      mbusseasonalitymar: map[TablesColumnFile.mbusseasonalitymar] as String,
      mbusseasonalityapr: map[TablesColumnFile.mbusseasonalityapr] as String,
      mbusseasonalitymay: map[TablesColumnFile.mbusseasonalitymay] as String,
      mbusseasonalityjun: map[TablesColumnFile.mbusseasonalityjun] as String,
      mbusseasonalityjul: map[TablesColumnFile.mbusseasonalityjul] as String,
      mbusseasonalityaug: map[TablesColumnFile.mbusseasonalityaug] as String,
      mbusseasonalitysep: map[TablesColumnFile.mbusseasonalitysep] as String,
      mbusseasonalityoct: map[TablesColumnFile.mbusseasonalityoct] as String,
      mbusseasonalitynov: map[TablesColumnFile.mbusseasonalitynov] as String,
      mbusseasonalitydec: map[TablesColumnFile.mbusseasonalitydec] as String,
      mbushighsales: map[TablesColumnFile.mbushighsales] != null &&
              map[TablesColumnFile.mbushighsales] != 'null' &&
              map[TablesColumnFile.mbushighsales] != ''
          ? map[TablesColumnFile.mbushighsales] as double
          : 0,
      mbusmediumsales: map[TablesColumnFile.mbusmediumsales] != null &&
              map[TablesColumnFile.mbusmediumsales] != 'null' &&
              map[TablesColumnFile.mbusmediumsales] != ''
          ? map[TablesColumnFile.mbusmediumsales] as double
          : 0,
      mbuslowsales: map[TablesColumnFile.mbuslowsales] != null &&
              map[TablesColumnFile.mbuslowsales] != 'null' &&
              map[TablesColumnFile.mbuslowsales] != ''
          ? map[TablesColumnFile.mbuslowsales] as double
          : 0,
      mbushighincome: map[TablesColumnFile.mbushighincome] != null &&
              map[TablesColumnFile.mbushighincome] != 'null' &&
              map[TablesColumnFile.mbushighincome] != ''
          ? map[TablesColumnFile.mbushighincome] as double
          : 0,
      mbusmediumincom: map[TablesColumnFile.mbusmediumincom] != null &&
              map[TablesColumnFile.mbusmediumincom] != 'null' &&
              map[TablesColumnFile.mbusmediumincom] != ''
          ? map[TablesColumnFile.mbusmediumincom] as double
          : 0,
      mbuslowincome: map[TablesColumnFile.mbuslowincome] != null &&
              map[TablesColumnFile.mbuslowincome] != 'null' &&
              map[TablesColumnFile.mbuslowincome] != ''
          ? map[TablesColumnFile.mbuslowincome] as double
          : 0,
      //mbusmonthlytotalEval

      mbusmonthlytotaleval:
          map[TablesColumnFile.mbusmonthlytotaleval] != null &&
                  map[TablesColumnFile.mbusmonthlytotaleval] != 'null' &&
                  map[TablesColumnFile.mbusmonthlytotaleval] != ''
              ? map[TablesColumnFile.mbusmonthlytotaleval] as double
              : 0,
      //mbusmonthlytotalVerif
      mbusmonthlytotalverif:
          map[TablesColumnFile.mbusmonthlytotalverif] != null &&
                  map[TablesColumnFile.mbusmonthlytotalverif] != 'null' &&
                  map[TablesColumnFile.mbusmonthlytotalverif] != ''
              ? map[TablesColumnFile.mbusmonthlytotalverif] as double
              : 0,
      mbusincludesurcalcyn:
          map[TablesColumnFile.mbusincludesurcalcyn] as String,
      mbusnhousesameplaceyn:
          map[TablesColumnFile.mbusnhousesameplaceyn] as String,
      mbusinesstrend: map[TablesColumnFile.mbusinesstrend] as String,
      mmonthlyincome:
      map[TablesColumnFile.mmonthlyincome] != null &&
          map[TablesColumnFile.mmonthlyincome] != 'null' &&
          map[TablesColumnFile.mmonthlyincome] != ''
          ? map[TablesColumnFile.mmonthlyincome] as double
          : 0,
      mtotalmonthlyincome:
      map[TablesColumnFile.mtotalmonthlyincome] != null &&
          map[TablesColumnFile.mtotalmonthlyincome] != 'null' &&
          map[TablesColumnFile.mtotalmonthlyincome] != ''
          ? map[TablesColumnFile.mtotalmonthlyincome] as double
          : 0,
      mhousehldexpense:
      map[TablesColumnFile.mhousehldexpense] != null &&
          map[TablesColumnFile.mhousehldexpense] != 'null' &&
          map[TablesColumnFile.mhousehldexpense] != ''
          ? map[TablesColumnFile.mhousehldexpense] as double
          : 0,
      mbusinessexpense:
      map[TablesColumnFile.mbusinessexpense] != null &&
          map[TablesColumnFile.mbusinessexpense] != 'null' &&
          map[TablesColumnFile.mbusinessexpense] != ''
          ? map[TablesColumnFile.mbusinessexpense] as double
          : 0,
      mnetamount:
      map[TablesColumnFile.mnetamount] != null &&
          map[TablesColumnFile.mnetamount] != 'null' &&
          map[TablesColumnFile.mnetamount] != ''
          ? map[TablesColumnFile.mnetamount] as double
          : 0,
      mmonthlyemi:
      map[TablesColumnFile.mmonthlyemi] != null &&
          map[TablesColumnFile.mmonthlyemi] != 'null' &&
          map[TablesColumnFile.mmonthlyemi] != ''
          ? map[TablesColumnFile.mmonthlyemi] as double
          : 0,
      mincomeemiratio:
      map[TablesColumnFile.mincomeemiratio] != null &&
          map[TablesColumnFile.mincomeemiratio] != 'null' &&
          map[TablesColumnFile.mincomeemiratio] != ''
          ? map[TablesColumnFile.mincomeemiratio] as double
          : 0,
      mpercentage:
      map[TablesColumnFile.mpercentage] != null &&
          map[TablesColumnFile.mpercentage] != 'null' &&
          map[TablesColumnFile.mpercentage] != ''
          ? map[TablesColumnFile.mpercentage] as double
          : 0,
    );
  }
}
