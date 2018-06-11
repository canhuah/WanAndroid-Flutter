import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class DataUtils {
  static final String IS_LOGIN = "isLogin";
  static final String USERNAME = "userName";

  // 保存用户登录信息，data中包含了userName
  static Future saveLoginInfo(String userName) async {
    print('isLogin');
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(USERNAME, userName);
    await sp.setBool(IS_LOGIN, true);

  }

  static Future clearLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    print('clean');
    return sp.clear();
  }


  static Future<String> getUserName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(USERNAME);
  }


  static Future<bool> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool b = sp.getBool(IS_LOGIN);
    return true == b;
  }
}
