import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:eco_mfi/LoginBean.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/models/Label.dart';
import 'package:eco_mfi/models/Project.dart';
import 'package:eco_mfi/models/TaskLabels.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:eco_mfi/models/Tasks.dart';

/// This is the singleton database class which handlers all database transactions
/// All the task raw queries is handle here and return a Future<T> with result
class CommonAppDataBase {
  static final CommonAppDataBase _commonAppDatabase =
      new CommonAppDataBase._internal();

  //private internal constructor to make it singleton
  CommonAppDataBase._internal();

  Database _database;

  static CommonAppDataBase get() {
    return _commonAppDatabase;
  }

  bool didInit = false;

  Future<Database> _getDb() async {
    if (!didInit) await _init();
    return _database;
  }

  static final userMasterTable = "User_Master";

  Future _init() async {
    // Get a location using path_provider
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "micro_finance.db");
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await _createUserMasterTable(db);
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      await db.execute("DROP TABLE ${userMasterTable}");
      await _createUserMasterTable(db);
    });
    didInit = true;
  }

  Future _createUserMasterTable(Database db) {
    String query = "CREATE TABLE ${userMasterTable} ("
        "${TablesColumnFile.usrCode} STRING  PRIMARY KEY,"
        "${TablesColumnFile.usrPass} TEXT,"
        "${TablesColumnFile.usrShortName} TEXT,"
        "${TablesColumnFile.usrName} TEXT,"
        "${TablesColumnFile.usrBrCode} INTEGER,"
        "${TablesColumnFile.regDeviceMacId} TEXT,"
        "${TablesColumnFile.grpCd} INTEGER,"
        "${TablesColumnFile.status} INTEGER,"
        "${TablesColumnFile.isCurrentlyLogedIn} INTEGER,"
        "${TablesColumnFile.usrDesignation} TEXT,"
        "${TablesColumnFile.autoLogoutYN} TEXT,"
        "${TablesColumnFile.autoLogoutAfterSecs} INTEGER,"
        "${TablesColumnFile.pwdChgForcedYN} TEXT,"
        "${TablesColumnFile.pwdChgPeriodDays} INTEGER,"
        "${TablesColumnFile.maxBadLiPerDay} INTEGER,"
        "${TablesColumnFile.maxBadLiPerInst} TEXT,"
        "${TablesColumnFile.lastPwdChgDt} TEXT,"
        "${TablesColumnFile.nextPwdChgDt} TEXT,"
        "${TablesColumnFile.nextSysLiDt} TEXT,"
        "${TablesColumnFile.badLoginsDt} TEXT,"
        "${TablesColumnFile.noOfBadLogins} INTEGER,"
        "${TablesColumnFile.activeInStn} TEXT,"
        "${TablesColumnFile.ExtnNo} INTEGER,"
        "${TablesColumnFile.IsActive} INTEGER,"
        "${TablesColumnFile.CustAccessLvl} TEXT,"
        "${TablesColumnFile.emailId} TEXT,"
        "${TablesColumnFile.mobile} INTEGER,"
        "${TablesColumnFile.error} INTEGER,"
        "${TablesColumnFile.merrormessage} TEXT);";
    print("table Query Here is : " + query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }
/*

  // Inserts or replaces the task.
  Future updateLoginColumn(LoginBean loginBean, String usrCode) async {
    String insertQuery = 'INSERT OR REPLACE INTO '
        '${userMasterTable}( ${TablesColumnFile.usrCode},${TablesColumnFile.usrPass},${TablesColumnFile.usrShortName},${TablesColumnFile.usrName} ,'
        ' ${TablesColumnFile.usrBrCode} , ${TablesColumnFile.regDeviceMacId} ,'
        '${TablesColumnFile.grpCd} ,${TablesColumnFile.status} ,${TablesColumnFile.isCurrentlyLogedIn} ,'
        '${TablesColumnFile.usrDesignation} , ${TablesColumnFile.autoLogoutYN} , ${TablesColumnFile.autoLogoutAfterSecs} ,'
        '${TablesColumnFile.pwdChgForcedYN} , ${TablesColumnFile.pwdChgPeriodDays} ,  ${TablesColumnFile.maxBadLiPerDay} ,'
        '${TablesColumnFile.maxBadLiPerInst} , ${TablesColumnFile.lastPwdChgDt} ,'
        '${TablesColumnFile.nextPwdChgDt} , ${TablesColumnFile.nextSysLiDt} , ${TablesColumnFile.badLoginsDt} ,'
        '${TablesColumnFile.noOfBadLogins} , ${TablesColumnFile.activeInStn} ,${TablesColumnFile.ExtnNo} ,'
        '${TablesColumnFile.IsActive} , ${TablesColumnFile.CustAccessLvl} , ${TablesColumnFile.emailId} , ${TablesColumnFile.mobile} ,'
        '${TablesColumnFile.error} , ${TablesColumnFile.errorMessage})'
        ' VALUES(${loginBean.usrCode},${loginBean.usrPass},${loginBean.usrShortName},${loginBean.usrName.trim()},${loginBean.usrBrCode},${loginBean.regDeviceMacId},${loginBean.grpCd}'
        ', ${loginBean.status},${loginBean.isCurrentlyLogedIn},${loginBean.usrDesignation},${loginBean.autoLogoutYN},${loginBean.autoLogoutAfterSecs},${loginBean.pwdChgForcedYN},'
        '${loginBean.pwdChgPeriodDays},${loginBean.maxBadLiPerDay},${loginBean.maxBadLiPerInst},${loginBean.lastPwdChgDt},${loginBean.nextPwdChgDt},${loginBean.nextSysLiDt},${loginBean.badLoginsDt}'
        ', ${loginBean.noOfBadLogins},${loginBean.activeInStn},${loginBean.extnNo},${loginBean.isActive},${loginBean.custAccessLvl},${loginBean.emailId},${loginBean.mobile},${loginBean.error}'
        ',${loginBean.errorMessage} )';
    insertQuery.replaceAll("\\s", "_");
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
    });
  }
*/
/*
  Future<LoginBean> getloginData(LoginBean loginBean) async {
    var db = await _getDb();
    var userPass = "${TablesColumnFile.usrPass} = '${loginBean.usrPass}'";
    var userCode = "${TablesColumnFile.usrCode} = '${loginBean.usrCode}'";

    print('query is here : ' +
        'SELECT *  FROM ${userMasterTable}  WHERE $userPass AND $userCode');
    var result = await db.rawQuery(
        'SELECT *  FROM ${userMasterTable}  WHERE $userPass AND $userCode');
    if (result[0] != null) {
      return bindData(result);
    }
  }

  LoginBean bindData(List<Map<String, dynamic>> result) {
    return LoginBean.fromMap(result[0]);
  }*/
}
