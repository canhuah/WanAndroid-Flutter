import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:wanAndroid/http/api.dart';
import 'package:wanAndroid/http/base_response.dart';

import 'interceptor/response_Interceptors.dart';

class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();
  Dio _dio;

  static const CONNECT_TIMEOUT = 30000;

  static CancelToken cancelToken = new CancelToken();

  factory HttpUtil() => _instance;

  //通用全局单例
  HttpUtil._internal() {
    if (null == _dio) {
      _dio = new Dio(new BaseOptions(
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: CONNECT_TIMEOUT,
      ));

      _dio.options.baseUrl = Api.BaseUrl;

      _dio.interceptors.add(LogInterceptor(responseBody: true,)); //开启请求日志
      _dio.interceptors.add(ResponseInterceptors()); //开启请求日志

      CookieJar cookieJar = CookieJar();
      _dio.interceptors.add(CookieManager(cookieJar));
    }
  }

  static HttpUtil getInstance() {
    return _instance;
  }

  //通GET请求
  Future<dynamic> get(String path, {String param, params}) async {
    // 拼接路径
    if (param != null && param.isNotEmpty) {
      path = path + "/" + param;
    }

    Response response;

    try {
      response = await _dio.get(
        path,
        queryParameters: params,
        cancelToken: cancelToken,
      );

      WResponseData result = response.data as WResponseData;

      if (result.isSuccess) {
        return result.data;
      } else {
        Exception exception = Exception(result.errorMsg);
        handleError(exception);
        // throw Exception(result.errorMsg);
      }
    } on DioError catch (e) {
      handleError(e);
      // throw e;
    }
  }

  //POST请求
  Future<WResponseData> post(path,
      {String param, params, Map<String, dynamic> queryParameters}) async {
    // 拼接路径
    if (param != null && param.isNotEmpty) {
      path = path + "/" + param;
    }

    Response response;
    try {
      response = await _dio.post(path,
          data: params,
          queryParameters: queryParameters,
          options: Options(
              contentType: queryParameters != null
                  ? "multipart/form-data"
                  : "application/json"),
          cancelToken: cancelToken);

      WResponseData result = response.data as WResponseData;

      if (result.isSuccess) {
        return result.data;
      } else {
        Exception exception = Exception(result.errorMsg);
        handleError(exception);
        throw Exception(result.errorMsg);
      }
    } on DioError catch (e) {
      handleError(e);
      throw e;
    }
  }

  //取消当前请求
  static void cancelRequests({CancelToken token}) {
    if (token == null) {
      token = cancelToken;
    }
    token.cancel("cancelled");
  }

  static void handleError(Exception exception) {
    print("exception.toString()");
    print(exception.toString());


  }
}
