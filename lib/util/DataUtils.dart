import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class DataUtils {

  static final String SP_IS_LOGIN = "isLogin";

  // 保存用户登录信息，data中包含了token等信息
  static saveLoginInfo() async {

    print('isLogin');
      SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setBool(SP_IS_LOGIN, true);

  }

  static Future<bool> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool b = sp.getBool(SP_IS_LOGIN);
    return true == b;
  }
}
