import 'package:eco_mfi/LoginBean.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:device_info/device_info.dart';

class LoginServices {

  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();




  Future<LoginBean> login(LoginBean login) async {
    LoginBean loginBean = new LoginBean();
   // try {
      String json =  await _toJson(login);
      print(json);
      final bodyValue = await NetworkUtil.callPostService(json,Constant.apiURL+"userDetailsMaster/loginValidation",_headers);
      print(bodyValue);
      if(bodyValue == 'error'){
        return null;
      }
      loginBean = await _fromLoginJson(bodyValue);
      print("onvalue "+loginBean.merrormessage );
      print("onvalue "+loginBean.merror.toString() );
      return loginBean;
      /* } catch (e) {
      print('Server Exception!!!');
      if (loginBean.errorMessage == null) {
        loginBean.error = 1002;
        loginBean.errorMessage =
            'Error in Connectivity with middleware found?or some system issue found';
      } else {}

      return loginBean;
    }*/
  }

  Future<String> _toJson(LoginBean loginBean) async{
    var mapData = new Map();
    mapData[TablesColumnFile.musrcode] = loginBean.musrcode;
    mapData[TablesColumnFile.musrpass] = loginBean.musrpass;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    mapData[TablesColumnFile.mregdevicemacid] = androidInfo.androidId;
    String json = JSON.encode(mapData);
    return json;
  }

  Future<LoginBean> _fromLoginJson(String json) async{
    Map<String, dynamic> map = JSON.decode(json);
    print(json + " form jso obj response" + "here is" + map.toString());
    var bean = LoginBean.fromMap(map);
    return bean;
  }
}
