import 'package:eco_mfi/db/TablesColumnFile.dart';

class CenterDetailsBean {
  int id;
  String effectiveDate;
  int lbrCode;
  String centerName;
  int BrnCenterId;
  int maxGroup;
  int currNoOfGroup;
  int maxGroupMember;
  String add1;
  String add2;
  int area;
  String landmark;
  String cityCode;
  String stateCd;
  String countryCd;
  String pinCd;
  String phone1;
  String fax;
  String formatdt;
  String meetingFreq;
  String usrCode;
  String meetingloc;
  int centerlead;
  String village;
  String market;
  int meetingDay;
  String centerMeetingTime;
  String centerMeetingHrsMin;
  int centerMeetingAmPm;
  String firstMeetinDt;
  String nextMeetingDt;
  String adhocNextMeetingDt;
  String lastMeetingDt;
  double latitude;
  double logitude;
  int groupNoCnt;
  String meetingSchedule;
  int repayFrom;
  int repayTo;
  int areaType;
  String wardNo;
  int noOfMeetingHelds;
  String CRSEffcetiveDt;
  String CRS;
  double feesAmount;
  String feesCrAcctId;
  String clusterName;
  String blockName;
  double distFrmHomeBranch;
  String sexCode;
  int samityChairman;
  int maxCenterMembers;
  int currnoOfMembers;
  int villageAdd;
  int distCd;
  int centerStatus;
  String dropOutDt;
  int dbtrAddMk;
  int dbtrAddMb;
  int dbtrAddMs;
  String dbtrAddMd;
  String dbtrAddMt;
  int dbtrAddck;
  int dbtrAddCb;
  int dbtrAddCs;
  String dbtrAddCd;
  String dbtrAddCt;
  int dbtrLupdMk;
  int dbtrLupdMb;
  int dbtrLupdMs;
  String dbtrLupdMd;
  String dbtrLupdMt;
  int dbtrLupdck;
  int dbtrLupdCb;
  int dbtrLupdCs;
  String dbtrLupdCd;
  String dbtrLupdCt;
  int dbtrTAuthDone;
  int dbtrRecStat;
  int dbtrAuthDone;
  int dbtrAuthNeeded;
  int dbtrUpdChekId;
  int dbtrlhistmNo;
  int weekNo;
  String addinfo1;
  String addinfo2;
  String changedManual;
  double distfromSubOffice;
  String postofficeCd;
  String subOfficeCd;
  String lastmonitringDate;
  String lastMonitoringAmPm;
  int lastMonitiringHHMM;
  String nextmonitringDate;
  String nextMonitoringAmPm;
  int nextMonitiringHHMM;
  int counter;
  String refrence;
  String agentUserName;
  int isDataSynced;

  CenterDetailsBean(
      {this.id,
      this.effectiveDate,
      this.lbrCode,
      this.centerName,
      this.BrnCenterId,
      this.maxGroup,
      this.currNoOfGroup,
      this.maxGroupMember,
      this.add1,
      this.add2,
      this.area,
      this.landmark,
      this.cityCode,
      this.stateCd,
      this.countryCd,
      this.pinCd,
      this.phone1,
      this.fax,
      this.formatdt,
      this.meetingFreq,
      this.usrCode,
      this.meetingloc,
      this.centerlead,
      this.village,
      this.market,
      this.meetingDay,
      this.centerMeetingTime,
      this.centerMeetingHrsMin,
      this.centerMeetingAmPm,
      this.firstMeetinDt,
      this.nextMeetingDt,
      this.adhocNextMeetingDt,
      this.lastMeetingDt,
      this.latitude,
      this.logitude,
      this.groupNoCnt,
      this.meetingSchedule,
      this.repayFrom,
      this.repayTo,
      this.areaType,
      this.wardNo,
      this.noOfMeetingHelds,
      this.CRSEffcetiveDt,
      this.CRS,
      this.feesAmount,
      this.feesCrAcctId,
      this.clusterName,
      this.blockName,
      this.distFrmHomeBranch,
      this.sexCode,
      this.samityChairman,
      this.maxCenterMembers,
      this.currnoOfMembers,
      this.villageAdd,
      this.distCd,
      this.centerStatus,
      this.dropOutDt,
      this.dbtrAddMk,
      this.dbtrAddMb,
      this.dbtrAddMs,
      this.dbtrAddMd,
      this.dbtrAddMt,
      this.dbtrAddck,
      this.dbtrAddCb,
      this.dbtrAddCs,
      this.dbtrAddCd,
      this.dbtrAddCt,
      this.dbtrLupdMk,
      this.dbtrLupdMb,
      this.dbtrLupdMs,
      this.dbtrLupdMd,
      this.dbtrLupdMt,
      this.dbtrLupdck,
      this.dbtrLupdCb,
      this.dbtrLupdCs,
      this.dbtrLupdCd,
      this.dbtrLupdCt,
      this.dbtrTAuthDone,
      this.dbtrRecStat,
      this.dbtrAuthDone,
      this.dbtrAuthNeeded,
      this.dbtrUpdChekId,
      this.dbtrlhistmNo,
      this.weekNo,
      this.addinfo1,
      this.addinfo2,
      this.changedManual,
      this.distfromSubOffice,
      this.postofficeCd,
      this.subOfficeCd,
      this.lastmonitringDate,
      this.lastMonitoringAmPm,
      this.lastMonitiringHHMM,
      this.nextmonitringDate,
      this.nextMonitoringAmPm,
      this.nextMonitiringHHMM,
      this.counter,
      this.refrence,
      this.agentUserName,
      this.isDataSynced});

  factory CenterDetailsBean.fromMap(Map<String, dynamic> map) {
    print("inside map");
    return CenterDetailsBean(
      id: map[TablesColumnFile.id] as int,
      effectiveDate: map[TablesColumnFile.effectiveDate] as String,
      lbrCode: map[TablesColumnFile.lbrCode] as int,
      centerName: map[TablesColumnFile.centerName] as String,
      BrnCenterId: map[TablesColumnFile.BrnCenterId] as int,
      maxGroup: map[TablesColumnFile.maxGroup] as int,
      currNoOfGroup: map[TablesColumnFile.currNoOfGroup] as int,
      maxGroupMember: map[TablesColumnFile.maxGroupMember] as int,
      add1: map[TablesColumnFile.add1] as String,
      add2: map[TablesColumnFile.add2] as String,
      area: map[TablesColumnFile.area] as int,
      landmark: map[TablesColumnFile.landmark] as String,
      cityCode: map[TablesColumnFile.cityCode] as String,
      stateCd: map[TablesColumnFile.stateCd] as String,
      countryCd: map[TablesColumnFile.countryCd] as String,
      pinCd: map[TablesColumnFile.pinCd] as String,
      phone1: map[TablesColumnFile.phone1] as String,
      fax: map[TablesColumnFile.fax] as String,
      formatdt: map[TablesColumnFile.formatdt] as String,
      meetingFreq: map[TablesColumnFile.meetingFreq] as String,
      usrCode: map[TablesColumnFile.usrCode] as String,
      meetingloc: map[TablesColumnFile.meetingloc] as String,
      centerlead: map[TablesColumnFile.centerlead] as int,
      village: map[TablesColumnFile.village] as String,
      market: map[TablesColumnFile.market] as String,
      meetingDay: map[TablesColumnFile.meetingDay] as int,
      centerMeetingTime: map[TablesColumnFile.centerMeetingTime] as String,
      centerMeetingHrsMin: map[TablesColumnFile.centerMeetingHrsMin] as String,
      centerMeetingAmPm: map[TablesColumnFile.centerMeetingAmPm] as int,
      firstMeetinDt: map[TablesColumnFile.firstMeetinDt] as String,
      nextMeetingDt: map[TablesColumnFile.nextMeetingDt] as String,
      adhocNextMeetingDt: map[TablesColumnFile.adhocNextMeetingDt] as String,
      lastMeetingDt: map[TablesColumnFile.lastMeetingDt] as String,
      latitude: map[TablesColumnFile.geoLatitude] as double,
      logitude: map[TablesColumnFile.geoLongitude] as double,
      groupNoCnt: map[TablesColumnFile.groupNoCnt] as int,
      meetingSchedule: map[TablesColumnFile.meetingSchedule] as String,
      repayFrom: map[TablesColumnFile.repayFrom] as int,
      repayTo: map[TablesColumnFile.repayTo] as int,
      areaType: map[TablesColumnFile.areaType] as int,
      wardNo: map[TablesColumnFile.wardNo] as String,
      noOfMeetingHelds: map[TablesColumnFile.noOfMeetingHelds] as int,
      CRSEffcetiveDt: map[TablesColumnFile.CRSEffcetiveDt] as String,
      CRS: map[TablesColumnFile.CRS] as String,
      feesAmount: map[TablesColumnFile.feesAmount] as double,
      feesCrAcctId: map[TablesColumnFile.feesCrAcctId] as String,
      clusterName: map[TablesColumnFile.clusterName] as String,
      blockName: map[TablesColumnFile.blockName] as String,
      distFrmHomeBranch: map[TablesColumnFile.distFrmHomeBranch] as double,
      sexCode: map[TablesColumnFile.sexCode] as String,
      samityChairman: map[TablesColumnFile.samityChairman] as int,
      maxCenterMembers: map[TablesColumnFile.maxCenterMembers] as int,
      currnoOfMembers: map[TablesColumnFile.currnoOfMembers] as int,
      villageAdd: map[TablesColumnFile.villageAdd] as int,
      distCd: map[TablesColumnFile.distCd] as int,
      centerStatus: map[TablesColumnFile.centerStatus] as int,
      dropOutDt: map[TablesColumnFile.dropOutDt] as String,
      dbtrAddMk: map[TablesColumnFile.dbtrAddMk] as int,
      dbtrAddMb: map[TablesColumnFile.dbtrAddMb] as int,
      dbtrAddMs: map[TablesColumnFile.dbtrAddMs] as int,
      dbtrAddMd: map[TablesColumnFile.dbtrAddMd] as String,
      dbtrAddMt: map[TablesColumnFile.dbtrAddMt] as String,
      dbtrAddck: map[TablesColumnFile.dbtrAddck] as int,
      dbtrAddCb: map[TablesColumnFile.dbtrAddCb] as int,
      dbtrAddCs: map[TablesColumnFile.dbtrAddCs] as int,
      dbtrAddCd: map[TablesColumnFile.dbtrAddCd] as String,
      dbtrAddCt: map[TablesColumnFile.dbtrAddCt] as String,
      dbtrLupdMk: map[TablesColumnFile.dbtrLupdMk] as int,
      dbtrLupdMb: map[TablesColumnFile.dbtrLupdMb] as int,
      dbtrLupdMs: map[TablesColumnFile.dbtrLupdMs] as int,
      dbtrLupdMd: map[TablesColumnFile.dbtrLupdMd] as String,
      dbtrLupdMt: map[TablesColumnFile.dbtrLupdMt] as String,
      dbtrLupdck: map[TablesColumnFile.dbtrLupdck] as int,
      dbtrLupdCb: map[TablesColumnFile.dbtrLupdCb] as int,
      dbtrLupdCs: map[TablesColumnFile.dbtrLupdCs] as int,
      dbtrLupdCd: map[TablesColumnFile.dbtrLupdCd] as String,
      dbtrLupdCt: map[TablesColumnFile.dbtrLupdCt] as String,
      dbtrTAuthDone: map[TablesColumnFile.dbtrTAuthDone] as int,
      dbtrRecStat: map[TablesColumnFile.dbtrRecStat] as int,
      dbtrAuthDone: map[TablesColumnFile.dbtrAuthDone] as int,
      dbtrAuthNeeded: map[TablesColumnFile.dbtrAuthNeeded] as int,
      dbtrUpdChekId: map[TablesColumnFile.dbtrUpdChekId] as int,
      dbtrlhistmNo: map[TablesColumnFile.dbtrlhistmNo] as int,
      weekNo: map[TablesColumnFile.weekNo] as int,
      addinfo1: map[TablesColumnFile.addinfo1] as String,
      addinfo2: map[TablesColumnFile.addinfo2] as String,
      changedManual: map[TablesColumnFile.changedManual] as String,
      distfromSubOffice: map[TablesColumnFile.distfromSubOffice] as double,
      postofficeCd: map[TablesColumnFile.postofficeCd] as String,
      subOfficeCd: map[TablesColumnFile.subOfficeCd] as String,
      lastmonitringDate: map[TablesColumnFile.lastmonitringDate] as String,
      lastMonitoringAmPm: map[TablesColumnFile.lastMonitoringAmPm] as String,
      lastMonitiringHHMM: map[TablesColumnFile.lastMonitiringHHMM] as int,
      nextmonitringDate: map[TablesColumnFile.nextmonitringDate] as String,
      nextMonitoringAmPm: map[TablesColumnFile.nextMonitoringAmPm] as String,
      nextMonitiringHHMM: map[TablesColumnFile.nextMonitiringHHMM] as int,
      counter: map[TablesColumnFile.counter] as int,
      refrence: map[TablesColumnFile.refrence] as String,
      agentUserName: map[TablesColumnFile.agentUserName] as String,
      isDataSynced: map[TablesColumnFile.isDataSynced] as int,
    );
  }
}
