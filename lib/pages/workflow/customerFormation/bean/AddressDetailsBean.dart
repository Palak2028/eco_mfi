import 'package:eco_mfi/db/TablesColumnFile.dart';

class AddressDetailsBean {

  int taddrefno;
  //numeric(8)
  int trefno;
  int maddressrefno;
  int mrefno;
  //numeric(8)
  int mcustno;
  //numeric(2)
  int maddrType;
  //NVarChar(50)
  String maddr1;
  //NVarChar(50)
  String maddr2;
  //NVarChar(30)
  String maddr3;
  //numeric(8)
  int mpinCd;
  //NVarChar(15)
  String mtel1;
  //NVarChar(15)
  String mtel2;
  //NVarChar(6)
  String mcityCd;
  //NVarChar(15)
  String mfax1;
  //NVarChar(15)
  String mfax2;
  //NVarChar(3)
  String mcountryCd;
  //numeric(9)
  int marea;
  //numeric(6)
  int mHouseType;
  double mRntLeasAmt;
  double mRntLeasDep;
  DateTime mContLeasExp;
  //numeric(6)
  int mRoofCond;
  //numeric(6)
  int mUtils;
  //numeric(6)
  int mAreaType;
  //NVarChar(80)
  String mLandmark;
  //NVarChar(3)
  String mState;
  //numeric(3)
  int mYearStay;
  //NVarChar(6)
  String mWardNo;
  //NVarChar(15)
  String mMobile;
  //NVarChar(35)
  String mEmail;
  //NVarChar(30)
  String mPattaName;
  //NVarChar(30)
  String mRelationship;
  //numeric(2)
  int mSourceOfDep;
  double mInstAmount;
  //NVarChar(1)
  String mToietYN;
  //numeric(6)
  int mNoOfRooms;
  //numeric(3)
  int mSpouseYearsStay;
  //numeric(6)
  int mDistCd;
  //numeric(6)
  int mvillage;
  //numeric(2)
  int mCookFuel;
  //NVarChar(15)
  String mSecMobile;
  String mThana;
  String mPost;
  String mcountryname;
  String mstatedesc;
  String mdistdesc;
  String mplacecd;
  String mplacedesc;
  String mareadesc;
  String mgeolatd;
  String mgeologd;

  AddressDetailsBean(
      {
        this.mrefno,
        this.trefno,
        this.taddrefno,
        this.maddressrefno,
        this.mcustno,
        this.maddrType,
        this.maddr1,
        this.maddr2,
        this.maddr3,
        this.mpinCd,
        this.mtel1,
        this.mtel2,
        this.mcityCd,
        this.mfax1,
        this.mfax2,
        this.mcountryCd,
        this.marea,
        this.mHouseType,
        this.mRntLeasAmt,
        this.mRntLeasDep,
        this.mContLeasExp,
        this.mRoofCond,
        this.mUtils,
        this.mAreaType,
        this.mLandmark,
        this.mState,
        this.mYearStay,
        this.mWardNo,
        this.mMobile,
        this.mEmail,
        this.mPattaName,
        this.mRelationship,
        this.mSourceOfDep,
        this.mInstAmount,
        this.mToietYN,
        this.mNoOfRooms,
        this.mSpouseYearsStay,
        this.mDistCd,
        this.mvillage,
        this.mCookFuel,
        this.mSecMobile,



        this.mThana,
        this.mPost,
        this.mplacecd,
        this.mgeolatd,
        this.mgeologd,
      });


  @override
  String toString() {
    return 'AddressDetailsBean{taddrefno: $taddrefno, trefno: $trefno, maddressrefno: $maddressrefno, mrefno: $mrefno, mcustno: $mcustno, maddrType: $maddrType, maddr1: $maddr1, maddr2: $maddr2, maddr3: $maddr3, mpinCd: $mpinCd, mtel1: $mtel1, mtel2: $mtel2, mcityCd: $mcityCd, mfax1: $mfax1, mfax2: $mfax2, mcountryCd: $mcountryCd, marea: $marea, mHouseType: $mHouseType, mRntLeasAmt: $mRntLeasAmt, mRntLeasDep: $mRntLeasDep, mContLeasExp: $mContLeasExp, mRoofCond: $mRoofCond, mUtils: $mUtils, mAreaType: $mAreaType, mLandmark: $mLandmark, mState: $mState, mYearStay: $mYearStay, mWardNo: $mWardNo, mMobile: $mMobile, mEmail: $mEmail, mPattaName: $mPattaName, mRelationship: $mRelationship, mSourceOfDep: $mSourceOfDep, mInstAmount: $mInstAmount, mToietYN: $mToietYN, mNoOfRooms: $mNoOfRooms, mSpouseYearsStay: $mSpouseYearsStay, mDistCd: $mDistCd, mvillage: $mvillage, mCookFuel: $mCookFuel, mSecMobile: $mSecMobile, mThana: $mThana, mPost: $mPost,mplacecd: $mplacecd}';
  }

  factory AddressDetailsBean.fromMap(Map<String, dynamic> map) {
    return AddressDetailsBean(
      mrefno : map[TablesColumnFile.mrefno] as int,
      trefno : map[TablesColumnFile.trefno] as int,
      taddrefno : map[TablesColumnFile.taddrefno] as int,
      maddressrefno:map[TablesColumnFile.maddressrefno] as int,
      mcustno: map[TablesColumnFile.mcustno]as int,
      maddrType: map[TablesColumnFile.maddrType]as int,
      maddr1: map[TablesColumnFile.maddr1]as String,
      maddr2: map[TablesColumnFile.maddr2]as String,
      maddr3: map[TablesColumnFile.maddr3]as String,
      mpinCd: map[TablesColumnFile.mpinCd]as int,
      mtel1: map[TablesColumnFile.mtel1]as String,
      mtel2: map[TablesColumnFile.mtel2]as String,
      mcityCd: map[TablesColumnFile.mcityCd]as String,
      mfax1: map[TablesColumnFile.mfax1]as String,
      mfax2: map[TablesColumnFile.mfax2]as String,
      mcountryCd: map[TablesColumnFile.mcountryCd]as String,
      marea: map[TablesColumnFile.marea]as int,
      mHouseType: map[TablesColumnFile.mHouseType]as int,
      mRntLeasAmt: map[TablesColumnFile.mRntLeasAmt]as double,
      mRntLeasDep: map[TablesColumnFile.mRntLeasDep]as double,
      mContLeasExp:(map[TablesColumnFile.mContLeasExp]=="null"||map[TablesColumnFile.mContLeasExp]==null)?null:DateTime.parse(map[TablesColumnFile.mContLeasExp]) as DateTime,
      mRoofCond: map[TablesColumnFile.mRoofCond]as int,
      mUtils: map[TablesColumnFile.mUtils]as int,
      mAreaType: map[TablesColumnFile.mAreaType]as int,
      mLandmark: map[TablesColumnFile.mLandmark]as String,
      mState: map[TablesColumnFile.mstate]as String,
      mYearStay: map[TablesColumnFile.mYearStay]as int,
      mWardNo: map[TablesColumnFile.mWardNo]as String,
      mMobile: map[TablesColumnFile.mMobile]as String,
      mEmail: map[TablesColumnFile.mEmail]as String,
      mPattaName: map[TablesColumnFile.mPattaName]as String,
      mRelationship: map[TablesColumnFile.mRelationship]as String,
      mSourceOfDep: map[TablesColumnFile.mSourceOfDep]as int,
      mInstAmount: map[TablesColumnFile.mInstAmount]as double,
      mToietYN: map[TablesColumnFile.mToietYN]as String,
      mNoOfRooms: map[TablesColumnFile.mNoOfRooms]as int,
      mSpouseYearsStay: map[TablesColumnFile.mSpouseYearsStay]as int,
      mDistCd: map[TablesColumnFile.mDistCd]as int,
      mvillage: map[TablesColumnFile.mvillage]as int,
      mCookFuel: map[TablesColumnFile.mCookFuel]as int,
      mSecMobile: map[TablesColumnFile.mSecMobile]as String,
      mThana :map[TablesColumnFile.mThana]as String,
      mPost :map[TablesColumnFile.mPost]as String,
      mplacecd :map[TablesColumnFile.mplacecd]as String,
      mgeolatd:map[TablesColumnFile.mgeolatd],
      mgeologd:map[TablesColumnFile.mgeologd],

    );
  }

  factory AddressDetailsBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware) {
    print("fromMap");
    return AddressDetailsBean(
      mrefno : map[TablesColumnFile.mrefno] as int,
      trefno : map[TablesColumnFile.trefno] as int,
      taddrefno : map[TablesColumnFile.taddrefno] as int,
      maddressrefno:map[TablesColumnFile.maddressrefno] as int,
      mcustno: map[TablesColumnFile.mcustno]as int,
      maddrType: map[TablesColumnFile.maddrType]as int,
      maddr1: map[TablesColumnFile.maddr1]as String,
      maddr2: map[TablesColumnFile.maddr2]as String,
      maddr3: map[TablesColumnFile.maddr3]as String,
      mpinCd: map[TablesColumnFile.mpinCd]as int,
      mtel1: map[TablesColumnFile.mtel1]as String,
      mtel2: map[TablesColumnFile.mtel2]as String,
      mcityCd: map[TablesColumnFile.mcityCd]as String,
      mfax1: map[TablesColumnFile.mfax1]as String,
      mfax2: map[TablesColumnFile.mfax2]as String,
      mcountryCd: map[TablesColumnFile.mcountryCd]as String,
      marea: map[TablesColumnFile.marea]as int,
      mHouseType: map[TablesColumnFile.mHouseType]as int,
      mRntLeasAmt: map[TablesColumnFile.mRntLeasAmt]as double,
      mRntLeasDep: map[TablesColumnFile.mRntLeasDep]as double,
      mContLeasExp:(map[TablesColumnFile.mContLeasExp]=="null"||map[TablesColumnFile.mContLeasExp]==null)?null:DateTime.parse(map[TablesColumnFile.mContLeasExp]) as DateTime,
      mRoofCond: map[TablesColumnFile.mRoofCond]as int,
      mUtils: map[TablesColumnFile.mUtils]as int,
      mAreaType: map[TablesColumnFile.mAreaType]as int,
      mLandmark: map[TablesColumnFile.mLandmark]as String,
      mState: map[TablesColumnFile.mstate]as String,
      mYearStay: map[TablesColumnFile.mYearStay]as int,
      mWardNo: map[TablesColumnFile.mWardNo]as String,
      mMobile: map[TablesColumnFile.mMobile]as String,
      mEmail: map[TablesColumnFile.mEmail]as String,
      mPattaName: map[TablesColumnFile.mPattaName]as String,
      mRelationship: map[TablesColumnFile.mRelationship]as String,
      mSourceOfDep: map[TablesColumnFile.mSourceOfDep]as int,
      mInstAmount: map[TablesColumnFile.mInstAmount]as double,
      mToietYN: map[TablesColumnFile.mToietYN]as String,
      mNoOfRooms: map[TablesColumnFile.mNoOfRooms]as int,
      mSpouseYearsStay: map[TablesColumnFile.mSpouseYearsStay]as int,
      mDistCd: map[TablesColumnFile.mDistCd]as int,
      mvillage: map[TablesColumnFile.mvillage]as int,
      mCookFuel: map[TablesColumnFile.mCookFuel]as int,
      mSecMobile: map[TablesColumnFile.mSecMobile]as String,
      mThana :map[TablesColumnFile.mThana]as String,
      mPost :map[TablesColumnFile.mPost]as String,
      mplacecd :map[TablesColumnFile.mplacecd]as String,
      mgeolatd:map[TablesColumnFile.mgeolatd],
      mgeologd:map[TablesColumnFile.mgeologd],
    );}
}
