
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanAndroid/http/Api.dart';
import 'dart:convert';

/*数据接口类型
{
"data": ...,
"errorCode": 0,
"errorMsg": ""
}
*/

class HttpUtil {

  static void post(String url, Function callback,
      {Map<String, String> params, Function errorCallback}) async {
    print(url);
    if (!url.startsWith("http")) {
      url = Api.BaseUrl + url;
    }
    try {

      SharedPreferences sp = await SharedPreferences.getInstance();
      String cookie = sp.get("cookie");
      Map<String,String> headers = new Map();
      if(cookie==null || cookie.length==0){

      }else{
        headers['Cookie'] = cookie;
//        headers['Content-Type'] = "application/json;charset=UTF-8";
      }

      http.Response res = await http.post(url, headers:headers,body: params);

      Map<String, dynamic> map = json.decode(res.body);

      int errorCode = map['errorCode'];
      String errorMsg = map['errorMsg'];
      var data = map['data'];

      print(map.toString());
      if(url.contains(Api.LOGIN)){
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString("cookie", res.headers['set-cookie']);

      }

      if (callback != null) {
        if (errorCode >= 0) {
          callback(data);
        } else {
          if (errorCallback != null) {
            errorCallback(errorMsg);
          }
        }
      }
    } catch (exception) {
      if (errorCallback != null) {
        errorCallback(exception.toString());
      }
      print(exception.toString());
    }
  }

  static void get(String url, Function callback,
      {Map<String, String> params, Function errorCallback}) async {
    if (!url.startsWith("http")) {
      url = Api.BaseUrl + url;
    }

    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
//    print("$url");
    try {
      Map<String,String> headers = new Map();

      http.Response res = await http.get(url,headers: headers);

      Map<String, dynamic> map = json.decode(res.body);
      int errorCode = map['errorCode'];
      String errorMsg = map['errorMsg'];
      var data = map['data'];
    print("data:"+data.toString());
      if (callback != null) {
        if (errorCode >= 0) {
          callback(data);
        } else {
          if (errorCallback != null) {
            errorCallback(errorMsg);
          }
        }
      }
    } catch (exception) {
      if (errorCallback != null) {
        errorCallback(exception.toString());
      }
      print(exception.toString());
    }
  }
}
