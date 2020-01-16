
import 'package:eco_mfi/beans/BaseBean.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationSocialFinancialDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AssetDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/BorrowingDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/BusinessExpenditureDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CurrentAssetsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerBusinessDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/EquityBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/FamilyDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/FixedAssetsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/HouseholdExpenditureDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/LongTermLiabilitiesBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/PPIBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ShortTermLiabilitiesBean.dart';

import 'ContactPointVerificationBean.dart';
class CustomerListBean {//extends BaseBean{
  //numeric(8)
  int trefno;
  //numeric(8)
  int mrefno;
  //numeric(8)
  int mcustno;
  //numeric(8)
  int mlbrcode;
  //numeric(8)
  int mcenterid;
  //numeric(8)
  int mgroupcd;
  //nvarchar(4)
  String mnametitle;
  //nvarchar(250)
  String mlongname;
  //nvarchar(4)
  String mfathertitle;
  //nvarchar(100)
  String mfathername;
  //nvarchar(4)
  String mspousetitle;
  //nvarchar(100)
  String mhusbandname;
  DateTime mdob;
  //numeric(2)
  int mage;
  //make this string as this is navarchar in middleware
  //nvarchar(20)
  String mbankacno;
  //nvarchar(1)
  String mbankacyn;
  //nvarchar(10)
  String mbankifsc;
  //nvarchar(25)
  String mbanknamelk;
  //nvarchar(25)
  String mbankbranch;
  //numeric(1)
  int mcuststatus;
  DateTime mdropoutdate;
  //nvarchar(12)
  String mmobno;
  //numeric(2)
  int mpanno;
  //nvarchar(25)
  String mpannodesc;
  //nvarchar(1)
  String mtdsyn;
  //numeric (2)
  int mtdsreasoncd;
  DateTime mtdsfrm15subdt;
  //nvarchar(50)
  String memailId;
  //numeric(2)
  int mcustcategory;
  //numeric(1)
  int mtier;
  //nvarchar(75)
  String mAdd1;
  //nvarchar(75)
  String mAdd2;
  //nvarchar(75)
  String mAdd3;
  //numeric(6)
  int mArea;
  //nvarchar(8)
  String mPinCode;
  //nvarchar(3)
  String mCounCd;
  //nvarchar(15)
  String mCityCd;
  //nvarchar(50)
  String mfname;
  //nvarchar(50)
  String mmname;
  //nvarchar(50)
  String mlname;
  //nvarchar(1)
  String mgender;
  //nvarchar(1)
  String mrelegion;
  //numeric(2)
  int mRuralUrban;
  //nvarchar(4)
  String mcaste;
  //nvarchar(15)
  String mqualification;
  //numeric(4)
  int moccupation;
  //nvarchar(4)
  String mLandType;
  //nvarchar(4)
  String mLandMeasurement;
  //numeric(2)
  int mmaritialStatus;
  //numeric(1)
  int mTypeOfId;
  //nvarchar(25)
  String mIdDesc;
  //nvarchar(1)
  String mInsuranceCovYN;
  //numeric(4)
  int mTypeofCoverage;

  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  int missynctocoresys;
  DateTime mlastsynsdate;
  List<FamilyDetailsBean> familyDetailsList  ;
  List<BorrowingDetailsBean> borrowingDetailsBean ;
  List<AddressDetailsBean> addressDetails ;
  List<ImageBean> imageMaster ;
  CustomerBusinessDetailsBean customerBusinessDetailsBean;
  //List<CustomModel> assetDetailsList;
  //List<CustomModel> savingDetailsList;
  String mcentername;
  String mgroupname;

  String ifYesThen;
  //String mifyesthen;
  String mOccBuisness;
  String mShopName;
  String mShpAdd;
  int mYrsInBz;
  String mregNum;
  //String mid1;
  //String mid2;
  String mHouse;
  String mAgricultureType;
  int mIsMbrGrp;
  //nvarchar(1)
  int mLoanAgreed;
  //nvarchar(1)
  int mGend;
  //nvarchar(1)
  int mInsurance;
  //int mRegion;
  int mConstruct;
  int mToilet;
  //int mBankAccYN;
  int mhousBizSp;
  int mBzRegs;
  int mBzTrnd;
  int misCbCheckDone;
  String merrormessage;
  double mexpsramt;
  DateTime mcbcheckrprtdt;
  String motpvrfdno ;
  String mcusttype;

  String mid1placeofissue;

  DateTime mid1issuedate;
  DateTime mid1expdate;

  String mid2placeofissue;
  DateTime mid2issuedate;
  DateTime mid2expdate;
  List<BusinessExpenditureDetailsBean> businessExpendDetailsList;
  List<HouseholdExpenditureDetailsBean> householdExpendDetailsList;
  List<AssetDetailsBean> assetDetailsList;
  List<FixedAssetsBean> fixedAssetsList;
  List<CurrentAssetsBean> currentAssetsList;
  List<LongTermLiabilitiesBean> longTermLiabilitiesList;
  List<ShortTermLiabilitiesBean> shortTermLiabilitiesList;
  List<EquityBean> equityList;
  String mprofileind;
  DateTime mhusdob;
  List<PPIMasterBean> pPIMasterBean;
  String mlangofcust;
  String mmainoccupn;
  String msuboccupn;
  int msecoccupatn;
  String mmainoccupndesc;
  String msuboccupndesc;
  String mdropoutreason;

  DateTime mmobilelastsynsdate;
  int mutils;
  int mrefcenterid;
  int trefcenterid;
  int mrefgroupid;
  int trefgroupid;
  ContactPointVerificationBean contactPointVerificationBean;
  //NVarChar(15)
  String meducation;
  //numeric(4)
  int mmemberno;
  //NVarChar(30)
  String designation;
  //NVarChar(30)
  String orgName;
  //NVarChar(30)
  String yearsInOrg;


  CustomerListBean(
      {
        this.trefno,
        this.mrefno,
        this.mcustno,
        this.mlbrcode,
        this.mcenterid,
        this.mgroupcd,
        this.mnametitle,
        this.mlongname,
        this.mfathertitle,
        this.mfathername,
        this.mspousetitle,
        this.mhusbandname,
        this.mdob,
        this.mage,
        this.mbankacno,
        this.mbankacyn,
        this.mbankifsc,
        this.mbanknamelk,
        this.mbankbranch,
        this.mcuststatus,
        this.mdropoutdate,
        this.mmobno,
        this.mpanno,
        this.mpannodesc,
        this.mtdsyn,
        this.mtdsreasoncd,
        this.mtdsfrm15subdt,
        this.memailId,
        this.mcustcategory,
        this.mtier,
        this.mAdd1,
        this.mAdd2,
        this.mAdd3,
        this.mArea,
        this.mPinCode,
        this.mCounCd,
        this.mCityCd,
        this.mfname,
        this.mmname,
        this.mlname,
        this.mgender,
        this.mrelegion,
        this.mRuralUrban,
        this.mcaste,
        this.mqualification,
        this.moccupation,
        this.mLandType,
        this.mLandMeasurement,
        this.mmaritialStatus,
        this.mTypeOfId,
        this.mIdDesc,
        this.mInsuranceCovYN,
        this.mTypeofCoverage,
        this.mcreateddt,
        this.mcreatedby,
        this.mlastupdatedt,
        this.mlastupdateby,
        this.mgeolocation,
        this.mgeolatd,
        this.mgeologd,
        this.missynctocoresys,
        this.mlastsynsdate,
        this.familyDetailsList,
        this.borrowingDetailsBean,
        this.addressDetails,
        this.imageMaster,
        this.customerBusinessDetailsBean,
        this.mcentername,
        this.mgroupname,

        this.ifYesThen,
        this.mOccBuisness,
        this.mShopName,
        this.mShpAdd,
        this.mYrsInBz,
        this.mregNum,
        //this.mid1,
        //this.mid2,
        this.mHouse,
        this.mAgricultureType,
        this.mIsMbrGrp,
        this.mLoanAgreed,
        this.mGend,
        this.mInsurance,
        //this.mRegion,
        this.mConstruct,
        this.mToilet,
        //this.mBankAccYN,
        this.mhousBizSp,
        this.mBzRegs,
        this.mBzTrnd,
        this.misCbCheckDone,
        this.merrormessage,
        this.businessExpendDetailsList,
        this.householdExpendDetailsList,
        this.assetDetailsList,
        this.pPIMasterBean,
        this.mexpsramt,
        this.mcbcheckrprtdt,
        this.motpvrfdno,
        this.mhusdob,
        this.mprofileind,
        this.mlangofcust,
        this.mmainoccupn,
        this.msecoccupatn,
        this.msuboccupn,
        this.mmainoccupndesc,
        this.msuboccupndesc,
        this.fixedAssetsList,
        this.currentAssetsList,
        this.longTermLiabilitiesList,
        this.shortTermLiabilitiesList,
        this.equityList,
        this.mcusttype,
        this.mid1placeofissue,
        this.mid1expdate,
        this.mid1issuedate,
        this.mid2placeofissue,
        this.mid2expdate,
        this.mid2issuedate,
        this.mdropoutreason,
        this.mmobilelastsynsdate,
        this.mutils,
        this.mrefcenterid,
        this.trefcenterid,
        this.mrefgroupid,
        this.trefgroupid,
<<<<<<< .mine
        this.contactPointVerificationBean,
        this.meducation,
        this.mmemberno,
        this.designation,
        this.orgName,
        this.yearsInOrg,

=======
        this.contactPointVerificationBean,
        this.meducation,
        this.mmemberno,
        this.designation,
        this.orgName,
        this.yearsInOrg,
>>>>>>> .r1143
      });

  /* @override
  String toString() {
    return 'FamilyDetailsBean{name: $name, age: $age, education: $education, relationship: $relationship, occupation: $occupation, income: $income, dependent: $dependent}';
  }*/


  factory CustomerListBean.fromMap(Map<String, dynamic> map,bool isTrue) {
    return CustomerListBean(
      trefno: map[TablesColumnFile.trefno] as int,
      mrefno: map[TablesColumnFile.mrefno] as int,
      mcustno: map[TablesColumnFile.mcustno] as int,
      mlbrcode: map[TablesColumnFile.mlbrcode] as int,
      mcenterid: map[TablesColumnFile.mcenterid] as int,
      mgroupcd: map[TablesColumnFile.mgroupcd] as int,
      mnametitle: map[TablesColumnFile.mnametitle] as String,
      mlongname: map[TablesColumnFile.mlongname] as String,
      mfathertitle: map[TablesColumnFile.mfathertitle] as String,
      mfathername: map[TablesColumnFile.mfathername] as String,
      mspousetitle: map[TablesColumnFile.mspousetitle] as String,
      mhusbandname: map[TablesColumnFile.mhusbandname] as String,
      mdob:(map[TablesColumnFile.mdob]=="null"||map[TablesColumnFile.mdob]==null)?null:DateTime.parse(map[TablesColumnFile.mdob]) as DateTime,
      mage: map[TablesColumnFile.mage] as int,
      mbankacno: map[TablesColumnFile.mbankacno] as String,
      mbankacyn: map[TablesColumnFile.mbankacyn] as String,
      mbankifsc: map[TablesColumnFile.mbankifsc] as String,
      mbanknamelk: map[TablesColumnFile.mbanknamelk] as String,
      mbankbranch: map[TablesColumnFile.mbankbranch] as String,
      mcuststatus: map[TablesColumnFile.mcuststatus] as int,
      mdropoutdate:(map[TablesColumnFile.mdropoutdate]=="null"||map[TablesColumnFile.mdropoutdate]==null)?null:DateTime.parse(map[TablesColumnFile.mdropoutdate]) as DateTime,
      mmobno: map[TablesColumnFile.mmobno] as String,
      mpanno: map[TablesColumnFile.mpanno] as int,
      mpannodesc: map[TablesColumnFile.mpannodesc] as String,
      mtdsyn: map[TablesColumnFile.mtdsyn] as String,
      mtdsreasoncd: map[TablesColumnFile.mtdsreasoncd] as int,
      mtdsfrm15subdt:(map[TablesColumnFile.mtdsfrm15subdt]=="null"||map[TablesColumnFile.mtdsfrm15subdt]==null)?null:DateTime.parse(map[TablesColumnFile.mtdsfrm15subdt]) as DateTime,
      memailId: map[TablesColumnFile.memailId] as String,
      mcustcategory: map[TablesColumnFile.mcustcategory] as int,
      merrormessage:			map[TablesColumnFile.merrormessage] as String,
      mtier: map[TablesColumnFile.mtier] as int,
      mAdd1: map[TablesColumnFile.mAdd1] as String,
      mAdd2: map[TablesColumnFile.mAdd2] as String,
      mAdd3: map[TablesColumnFile.mAdd3] as String,
      mArea: map[TablesColumnFile.marea] as int,
      mPinCode: map[TablesColumnFile.mPinCode] as String,
      mCounCd: map[TablesColumnFile.mCounCd] as String,
      mCityCd: map[TablesColumnFile.mCityCd] as String,
      mfname: map[TablesColumnFile.mfname] as String,
      mmname: map[TablesColumnFile.mmname] as String,
      mlname: map[TablesColumnFile.mlname] as String,
      mgender: map[TablesColumnFile.mgender] as String,
      mrelegion: map[TablesColumnFile.mrelegion] as String,
      mRuralUrban: map[TablesColumnFile.mRuralUrban] as int,
      mcaste: map[TablesColumnFile.mcaste] as String,
      mqualification: map[TablesColumnFile.mqualification] as String,
      moccupation: map[TablesColumnFile.moccupation] as int,
      mLandType: map[TablesColumnFile.mLandType] as String,
      mLandMeasurement: map[TablesColumnFile.mLandMeasurement] as String,
      mmaritialStatus: map[TablesColumnFile.mmaritialStatus] as int,
      mTypeOfId: map[TablesColumnFile.mTypeOfId] as int,
      mIdDesc: map[TablesColumnFile.mIdDesc] as String,
      mInsuranceCovYN: map[TablesColumnFile.mInsuranceCovYN] as String,
      mTypeofCoverage: map[TablesColumnFile.mTypeofCoverage] as int,
      mcreateddt: (map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby],
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby],
      mgeolocation:map[TablesColumnFile.mgeolocation],
      mgeolatd:map[TablesColumnFile.mgeolatd],
      mgeologd:map[TablesColumnFile.mgeologd],
      missynctocoresys:(map[TablesColumnFile.missynctocoresys]=="null"||map[TablesColumnFile.missynctocoresys]==null)?0:map[TablesColumnFile.missynctocoresys] as int,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,

      ifYesThen:			map[TablesColumnFile.ifYesThen] as String,
      mOccBuisness:			map[TablesColumnFile.mOccBuisness] as String,
      mShopName:			map[TablesColumnFile.mShopName] as String,
      mShpAdd:			map[TablesColumnFile.mShpAdd] as String,
      mYrsInBz:			map[TablesColumnFile.mYrsInBz] as int,
      mregNum:			map[TablesColumnFile.mregNum] as String,
      //mid1:			map[TablesColumnFile.mid1] as String,
      //mid2:			map[TablesColumnFile.mid2] as String,
      mHouse:			map[TablesColumnFile.mhouse] as String,
      mAgricultureType:			map[TablesColumnFile.mAgricultureType] as String,
      mIsMbrGrp:			map[TablesColumnFile.mIsMbrGrp] as int,
      mLoanAgreed:			map[TablesColumnFile.mLoanAgreed] as int,
      mGend:			map[TablesColumnFile.mGend] as int,
      mInsurance:			map[TablesColumnFile.mInsurance] as int,
      //mRegion:			map[TablesColumnFile.mRegion] as int,
      mConstruct:			map[TablesColumnFile.mConstruct] as int,
      mToilet:			map[TablesColumnFile.mToilet] as int,
      //mBankAccYN:			map[TablesColumnFile.mBankAccYN] as int,
      mhousBizSp:			map[TablesColumnFile.mhousBizSp] as int,
      mBzRegs:			map[TablesColumnFile.mBzRegs] as int,
      mBzTrnd:			map[TablesColumnFile.mBzTrnd] as int,
      misCbCheckDone:			map[TablesColumnFile.misCbCheckDone] as int,
      //errorMessage:			map[TablesColumnFile.merrormessage] as String,
      mcentername : map[TablesColumnFile.mcentername] as String,
      mgroupname : map[TablesColumnFile.mgroupname] as String,
      mexpsramt : map[TablesColumnFile.mexpsramt] as double,
      mcbcheckrprtdt : (map[TablesColumnFile.mcbcheckrprtdt]=="null"||
          map[TablesColumnFile.mcbcheckrprtdt]==null)?null:DateTime.parse(map[TablesColumnFile.mcbcheckrprtdt]) as DateTime,

        motpvrfdno:map[TablesColumnFile.motpvrfdno] as String,
        mhusdob:(map[TablesColumnFile.mhusdob]=="null"||map[TablesColumnFile.mhusdob]==null)?null:DateTime.parse(map[TablesColumnFile.mhusdob]) as DateTime,
        mprofileind : map[TablesColumnFile.mprofileind] as String,
      mcusttype :map[TablesColumnFile.mcusttype] as String,
	mlangofcust : map[TablesColumnFile.mlangofcust] as String,
        mmainoccupn : map[TablesColumnFile.mmainoccupn] as String,
        msuboccupn : map[TablesColumnFile.msuboccupn] as String,
        msecoccupatn : map[TablesColumnFile.msecoccupatn] as int,
        mmainoccupndesc : map[TablesColumnFile.mmainoccupndesc] as String,
        msuboccupndesc : map[TablesColumnFile.msuboccupndesc] as String,

        mid1placeofissue: map[TablesColumnFile.mid1placeofissue] as String,
        mid1expdate:(map[TablesColumnFile.mid1expdate]=="null"||map[TablesColumnFile.mid1expdate]==null)
            ?null
        :DateTime.parse(map[TablesColumnFile.mid1expdate]) as DateTime,



        mid1issuedate:(map[TablesColumnFile.mid1issuedate]=="null"||
            map[TablesColumnFile.mid1issuedate]==null)
    ?null:DateTime.parse(map[TablesColumnFile.mid1issuedate]) as DateTime,

        mid2placeofissue:map[TablesColumnFile.mid2placeofissue] as String,

        mid2expdate:(map[TablesColumnFile.mid2expdate]=="null"||map[TablesColumnFile.mid2expdate]
            ==null)?null:DateTime.parse(map[TablesColumnFile.mid2expdate]) as DateTime,

        mid2issuedate:(map[TablesColumnFile.mid2issuedate]=="null"||map[TablesColumnFile.mid2issuedate]
            ==null)?null:DateTime.parse(map[TablesColumnFile.mid2issuedate]) as DateTime,

        mdropoutreason: map[TablesColumnFile.mdropoutreason] as String,
      mmobilelastsynsdate:(map[TablesColumnFile.mmobilelastsynsdate]=="null"||
          map[TablesColumnFile.mmobilelastsynsdate]==null)
          ?null:DateTime.parse(map[TablesColumnFile.mmobilelastsynsdate]) as DateTime,

      mutils: map[TablesColumnFile.mutils] as int,
        mrefcenterid: map[TablesColumnFile.mrefcenterid] as int,
        trefcenterid: map[TablesColumnFile.trefcenterid] as int,
        mrefgroupid: map[TablesColumnFile.mrefgroupid] as int,
        trefgroupid: map[TablesColumnFile.trefgroupid] as int,

<<<<<<< .mine
      meducation: map[TablesColumnFile.meducation] as String,
      mmemberno: map[TablesColumnFile.mmemberno] as int,
      designation: map[TablesColumnFile.designation] as String,
      orgName: map[TablesColumnFile.orgName] as String,
      yearsInOrg: map[TablesColumnFile.yearsInOrg] as String,


=======
      meducation: map[TablesColumnFile.meducation] as String,
      mmemberno: map[TablesColumnFile.mmemberno] as int,
      designation: map[TablesColumnFile.designation] as String,
      orgName: map[TablesColumnFile.orgName] as String,
      yearsInOrg: map[TablesColumnFile.yearsInOrg] as String,
>>>>>>> .r1143
    );
  }
  factory CustomerListBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware) {
    print("fromMap");
    print(map[TablesColumnFile.merrormessage]);
    print("mrefno");
    print(map[TablesColumnFile.mrefno]);

    return CustomerListBean(

      trefno: map[TablesColumnFile.trefno] as int,
      mrefno: map[TablesColumnFile.mrefno] as int,
      mcustno: map[TablesColumnFile.mcustno] as int,
      mlbrcode: map[TablesColumnFile.mlbrcode] as int,
      mcenterid: map[TablesColumnFile.mcenterid] as int,
      mgroupcd: map[TablesColumnFile.mgroupcd] as int,
      mnametitle: map[TablesColumnFile.mnametitle] as String,
      mlongname: map[TablesColumnFile.mlongname] as String,
      mfathertitle: map[TablesColumnFile.mfathertitle] as String,
      mfathername: map[TablesColumnFile.mfathername] as String,
      mspousetitle: map[TablesColumnFile.mspousetitle] as String,
      mhusbandname: map[TablesColumnFile.mhusbandname] as String,
      mdob: (map[TablesColumnFile.mdob]=="null"||map[TablesColumnFile.mdob]==null)?null:DateTime.parse(map[TablesColumnFile.mdob]) as DateTime,
      mage: map[TablesColumnFile.mage] as int,
      mbankacno: map[TablesColumnFile.mbankacno] as String,
      mbankacyn: map[TablesColumnFile.mbankacyn] as String,
      mbankifsc: map[TablesColumnFile.mbankifsc] as String,
      mbanknamelk: map[TablesColumnFile.mbanknamelk] as String,
      mbankbranch: map[TablesColumnFile.mbankbranch] as String,
      mcuststatus: map[TablesColumnFile.mcuststatus] as int,
      mdropoutdate:  (map[TablesColumnFile.mdropoutdate]=="null"||map[TablesColumnFile.mdropoutdate]==null)?null:DateTime.parse(map[TablesColumnFile.mdropoutdate]) as DateTime,
      mmobno: map[TablesColumnFile.mmobno] as String,
      mpanno: map[TablesColumnFile.mpanno] as int,
      mpannodesc: map[TablesColumnFile.mpannodesc] as String,
      mtdsyn: map[TablesColumnFile.mtdsyn] as String,
      mtdsreasoncd: map[TablesColumnFile.mtdsreasoncd] as int,
      mtdsfrm15subdt:  (map[TablesColumnFile.mtdsfrm15subdt]=="null"||map[TablesColumnFile.mtdsfrm15subdt]==null)?null:DateTime.parse(map[TablesColumnFile.mtdsfrm15subdt]) as DateTime,
      memailId: map[TablesColumnFile.memailId] as String,
      mcustcategory: map[TablesColumnFile.mcustcategory] as int,
      mtier: map[TablesColumnFile.mtier] as int,
      mAdd1: map[TablesColumnFile.mAdd1] as String,
      mAdd2: map[TablesColumnFile.mAdd2] as String,
      mAdd3: map[TablesColumnFile.mAdd3] as String,
      mArea: map[TablesColumnFile.marea] as int,
      mPinCode: map[TablesColumnFile.mPinCode] as String,
      mCounCd: map[TablesColumnFile.mCounCd] as String,
      mCityCd: map[TablesColumnFile.mCityCd] as String,
      mfname: map[TablesColumnFile.mfname] as String,
      mmname: map[TablesColumnFile.mmname] as String,
      mlname: map[TablesColumnFile.mlname] as String,
      mgender: map[TablesColumnFile.mgender] as String,
      mrelegion: map[TablesColumnFile.mrelegion] as String,
      mRuralUrban: map[TablesColumnFile.mRuralUrban] as int,
      mcaste: map[TablesColumnFile.mcaste] as String,
      mqualification: map[TablesColumnFile.mqualification] as String,
      moccupation: map[TablesColumnFile.moccupation] as int,
      mLandType: map[TablesColumnFile.mLandType] as String,
      mLandMeasurement: map[TablesColumnFile.mLandMeasurement] as String,
      mmaritialStatus: map[TablesColumnFile.mmaritialStatus] as int,
      mTypeOfId: map[TablesColumnFile.mTypeOfId] as int,
      mIdDesc: map[TablesColumnFile.mIdDesc] as String,
      mInsuranceCovYN: map[TablesColumnFile.mInsuranceCovYN] as String,
      mTypeofCoverage: map[TablesColumnFile.mTypeofCoverage] as int,

      mcreateddt: (map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby],
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby],
      mgeolocation:map[TablesColumnFile.mgeolocation],
      mgeolatd:map[TablesColumnFile.mgeolatd],
      mgeologd:map[TablesColumnFile.mgeologd],
      missynctocoresys:(map[TablesColumnFile.missynctocoresys]=="null"||map[TablesColumnFile.missynctocoresys]==null)?0:map[TablesColumnFile.missynctocoresys] as int,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,


      ifYesThen:			map[TablesColumnFile.ifYesThen] as String,
      mOccBuisness:			map[TablesColumnFile.mOccBuisness] as String,
      mShopName:			map[TablesColumnFile.mShopName] as String,
      mShpAdd:			map[TablesColumnFile.mShpAdd] as String,
      mYrsInBz:			map[TablesColumnFile.mYrsInBz] as int,
      mregNum:			map[TablesColumnFile.mregNum] as String,
      //mid1:			map[TablesColumnFile.mid1] as String,
      //mid2:			map[TablesColumnFile.mid2] as String,
      mHouse:			map[TablesColumnFile.mhouse] as String,
      mAgricultureType:			map[TablesColumnFile.mAgricultureType] as String,
      mIsMbrGrp:			map[TablesColumnFile.mIsMbrGrp] as int,
      mLoanAgreed:			map[TablesColumnFile.mLoanAgreed] as int,
      mGend:			map[TablesColumnFile.mGend] as int,
      mInsurance:			map[TablesColumnFile.mInsurance] as int,
      //mRegion:			map[TablesColumnFile.mRegion] as int,
      mConstruct:			map[TablesColumnFile.mConstruct] as int,
      mToilet:			map[TablesColumnFile.mToilet] as int,
      //mBankAccYN:			map[TablesColumnFile.mBankAccYN] as int,
      mhousBizSp:			map[TablesColumnFile.mhousBizSp] as int,
      mBzRegs:			map[TablesColumnFile.mBzRegs] as int,
      mBzTrnd:			map[TablesColumnFile.mBzTrnd] as int,
      misCbCheckDone:			map[TablesColumnFile.misCbCheckDone] as int,
      merrormessage:			map[TablesColumnFile.merrormessage] as String,
      mcentername : map[TablesColumnFile.mcentername] as String,
      mgroupname : map[TablesColumnFile.mgroupname] as String,
      mexpsramt : map[TablesColumnFile.mexpsramt] as double,
      mcbcheckrprtdt:(map[TablesColumnFile.mcbcheckrprtdt]=="null"||map[TablesColumnFile.mcbcheckrprtdt]==null)?null:DateTime.parse(map[TablesColumnFile.mcbcheckrprtdt]) as DateTime,
      // : map[TablesColumnFile.mcbcheckrprtdt] as DateTime,
      motpvrfdno:map[TablesColumnFile.motpvrfdno] as String,
      mhusdob:(map[TablesColumnFile.mhusdob]=="null"||map[TablesColumnFile.mhusdob]==null)?null:DateTime.parse(map[TablesColumnFile.mhusdob]) as DateTime,
      mprofileind : map[TablesColumnFile.mprofileind] as String,
      mcusttype:map[TablesColumnFile.mcusttype] as String,
	mlangofcust : map[TablesColumnFile.mlangofcust] as String,
      mmainoccupn : map[TablesColumnFile.mmainoccupn] as String,
      msuboccupn : map[TablesColumnFile.msuboccupn] as String,
      msecoccupatn : map[TablesColumnFile.msecoccupatn] as int,



      mid1placeofissue: map[TablesColumnFile.mid1placeofissue] as String,
      mid1expdate:(map[TablesColumnFile.mid1expdate]=="null"||map[TablesColumnFile.mid1expdate]==null)
          ?null
          :DateTime.parse(map[TablesColumnFile.mid1expdate]) as DateTime,



      mid1issuedate:(map[TablesColumnFile.mid1issuedate]=="null"||
          map[TablesColumnFile.mid1issuedate]==null)
          ?null:DateTime.parse(map[TablesColumnFile.mid1issuedate]) as DateTime,

      mid2placeofissue:map[TablesColumnFile.mid2placeofissue] as String,

      mid2expdate:(map[TablesColumnFile.mid2expdate]=="null"||map[TablesColumnFile.mid2expdate]
          ==null)?null:DateTime.parse(map[TablesColumnFile.mid2expdate]) as DateTime,

      mid2issuedate:(map[TablesColumnFile.mid2issuedate]=="null"||map[TablesColumnFile.mid2issuedate]
          ==null)?null:DateTime.parse(map[TablesColumnFile.mid2issuedate]) as DateTime,

      mdropoutreason:map[TablesColumnFile.mdropoutreason] as String,
      mmobilelastsynsdate:(map[TablesColumnFile.mmobilelastsynsdate]=="null"||
          map[TablesColumnFile.mmobilelastsynsdate]==null)
          ?null:DateTime.parse(map[TablesColumnFile.mmobilelastsynsdate]) as DateTime,
      mutils: map[TablesColumnFile.mutils] as int,
      mrefcenterid: map[TablesColumnFile.mrefcenterid] as int,
      trefcenterid: map[TablesColumnFile.trefcenterid] as int,
      mrefgroupid: map[TablesColumnFile.mrefgroupid] as int,
      trefgroupid: map[TablesColumnFile.trefgroupid] as int,


      familyDetailsList: map[TablesColumnFile.familyDetails].map<FamilyDetailsBean>((i) => FamilyDetailsBean.fromMap(i))
          .toList(),
      borrowingDetailsBean: map[TablesColumnFile.borrowingDetails].map<BorrowingDetailsBean>((i) => BorrowingDetailsBean.fromMap(i))
          .toList(),
      addressDetails : map[TablesColumnFile.addressDetails].map<AddressDetailsBean>((i) => AddressDetailsBean.fromMap(i))
          .toList(),
      customerBusinessDetailsBean:map[TablesColumnFile.customerBussDetails]==null?null:CustomerBusinessDetailsBean.fromMapMiddleware(map[TablesColumnFile.customerBussDetails]),
      imageMaster:  map[TablesColumnFile.imageMaster].map<ImageBean>((i) => ImageBean.fromMapFromMiddleWare(i))
          .toList(),
      businessExpendDetailsList: map[TablesColumnFile.businessExpendDetails].map<BusinessExpenditureDetailsBean>((i) => BusinessExpenditureDetailsBean.fromMap(i))
          .toList(),
      householdExpendDetailsList: map[TablesColumnFile.householdExpendDetails].map<HouseholdExpenditureDetailsBean>((i) => HouseholdExpenditureDetailsBean.fromMap(i))
          .toList(),
      assetDetailsList: map[TablesColumnFile.assetDetailsList].map<AssetDetailsBean>((i) => AssetDetailsBean.fromMap(i))
          .toList(),
      pPIMasterBean:  map[TablesColumnFile.ppiDetails].map<PPIMasterBean>((i) => PPIMasterBean.fromMap(i))
          .toList(),
      contactPointVerificationBean: map[TablesColumnFile.contactPointVerification]==null?null:ContactPointVerificationBean.fromMapMiddleware(map[TablesColumnFile.contactPointVerification]),
      //businessDetailsList:  map[TablesColumnFile.customerBussDetails].map<CustomerBusinessDetailsBean>((i) => CustomerBusinessDetailsBean.fromMapMiddleware(i))
      //  .toList(),
      /*fixedAssetsList: map[TablesColumnFile.fixedAssetsList].map<FixedAssetsBean>((i) => FixedAssetsBean.fromMap(i))
          .toList(),
      currentAssetsList: map[TablesColumnFile.currentAssetsList].map<CurrentAssetsBean>((i) => CurrentAssetsBean.fromMap(i))
          .toList(),
      longTermLiabilitiesList: map[TablesColumnFile.longTermLiabilitiesList].map<LongTermLiabilitiesBean>((i) => LongTermLiabilitiesBean.fromMap(i))
          .toList(),
      shortTermLiabilitiesList: map[TablesColumnFile.shortTermLiabilitiesList].map<ShortTermLiabilitiesBean>((i) => ShortTermLiabilitiesBean.fromMap(i))
          .toList(),
      equityList: map[TablesColumnFile.equityList].map<EquityBean>((i) => EquityBean.fromMap(i))
          .toList(),
*/
<<<<<<< .mine

      meducation: map[TablesColumnFile.meducation] as String,
      mmemberno: map[TablesColumnFile.mmemberno] as int,
      designation: map[TablesColumnFile.designation] as String,
      orgName: map[TablesColumnFile.orgName] as String,
      yearsInOrg: map[TablesColumnFile.yearsInOrg] as String,
=======
      meducation: map[TablesColumnFile.meducation] as String,
      mmemberno: map[TablesColumnFile.mmemberno] as int,
      designation: map[TablesColumnFile.designation] as String,
      orgName: map[TablesColumnFile.orgName] as String,
      yearsInOrg: map[TablesColumnFile.yearsInOrg] as String,
>>>>>>> .r1143
    );}

  @override
  String toString() {
    return 'CustomerListBean{trefno: $trefno, mrefno: $mrefno, mcustno: $mcustno, mlbrcode: $mlbrcode, mcenterid: $mcenterid, mgroupcd: $mgroupcd, mnametitle: $mnametitle, mlongname: $mlongname, mfathertitle: $mfathertitle, mfathername: $mfathername, mspousetitle: $mspousetitle, mhusbandname: $mhusbandname, mdob: $mdob, mage: $mage, mbankacno: $mbankacno, mbankacyn: $mbankacyn, mbankifsc: $mbankifsc, mbanknamelk: $mbanknamelk, mbankbranch: $mbankbranch, mcuststatus: $mcuststatus, mdropoutdate: $mdropoutdate, mmobno: $mmobno, mpanno: $mpanno, mpannodesc: $mpannodesc, mtdsyn: $mtdsyn, mtdsreasoncd: $mtdsreasoncd, mtdsfrm15subdt: $mtdsfrm15subdt, memailId: $memailId, mcustcategory: $mcustcategory, mtier: $mtier, mAdd1: $mAdd1, mAdd2: $mAdd2, mAdd3: $mAdd3, mArea: $mArea, mPinCode: $mPinCode, mCounCd: $mCounCd, mCityCd: $mCityCd, mfname: $mfname, mmname: $mmname, mlname: $mlname, mgender: $mgender, mrelegion: $mrelegion, mRuralUrban: $mRuralUrban, mcaste: $mcaste, mqualification: $mqualification, moccupation: $moccupation, mLandType: $mLandType, mLandMeasurement: $mLandMeasurement, mmaritialStatus: $mmaritialStatus, mTypeOfId: $mTypeOfId, mIdDesc: $mIdDesc, mInsuranceCovYN: $mInsuranceCovYN, mTypeofCoverage: $mTypeofCoverage, mcreateddt: $mcreateddt, mcreatedby: $mcreatedby, mlastupdatedt: $mlastupdatedt, mlastupdateby: $mlastupdateby, mgeolocation: $mgeolocation, mgeolatd: $mgeolatd, mgeologd: $mgeologd, missynctocoresys: $missynctocoresys, mlastsynsdate: $mlastsynsdate, familyDetailsList: $familyDetailsList, borrowingDetailsBean: $borrowingDetailsBean, addressDetails: $addressDetails, imageMaster: $imageMaster, customerBusinessDetailsBean: $customerBusinessDetailsBean, mcentername: $mcentername, mgroupname: $mgroupname, ifYesThen: $ifYesThen, mOccBuisness: $mOccBuisness, mShopName: $mShopName, mShpAdd: $mShpAdd, mYrsInBz: $mYrsInBz, mregNum: $mregNum, mHouse: $mHouse, mAgricultureType: $mAgricultureType, mIsMbrGrp: $mIsMbrGrp, mLoanAgreed: $mLoanAgreed, mGend: $mGend, mInsurance: $mInsurance, mConstruct: $mConstruct, mToilet: $mToilet, mhousBizSp: $mhousBizSp, mBzRegs: $mBzRegs, mBzTrnd: $mBzTrnd, misCbCheckDone: $misCbCheckDone, errorMessage: $merrormessage, mexpsramt: $mexpsramt, mcbcheckrprtdt: $mcbcheckrprtdt, motpvrfdno: $motpvrfdno, businessExpendDetailsList: $businessExpendDetailsList, householdExpendDetailsList: $householdExpendDetailsList, assetDetailsList: $assetDetailsList, mprofileind: $mprofileind, mhusdob: $mhusdob, pPIMasterBean: $pPIMasterBean}';
  }


  factory CustomerListBean.fromMapMiddlewareDedup(Map<String, dynamic> map,bool isFromMiddleware) {
    return CustomerListBean(

      mfname: map[TablesColumnFile.mfname] as String,
      mmname: map[TablesColumnFile.mmname] as String,
      mlname: map[TablesColumnFile.mlname] as String,
      mlongname: map[TablesColumnFile.mlongname] as String,
      mrefno: map[TablesColumnFile.mrefno] as int,
      mcustno: map[TablesColumnFile.mcustno] as int,
      mcreatedby:map[TablesColumnFile.mcreatedby],
    );
  }


}
