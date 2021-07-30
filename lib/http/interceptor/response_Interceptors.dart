import 'package:dio/dio.dart';
import 'package:wanAndroid/http/base_response.dart';

class ResponseInterceptors extends Interceptor {
  @override
  onResponse(Response response) async {
    RequestOptions option = response.request;

    var data = response.data["data"];
    int errorCode = response.data["errorCode"];
    String errorMsg = response.data["errorMsg"];

    try {
      if (errorCode == 0) {
        return new WResponseData(
            errorCode: errorCode, errorMsg: errorMsg, data: data);
      } else {
        return new DioError(
            request: option, response: response, error: Exception(errorMsg));
      }
    } catch (e) {
      return new DioError(request: option, response: response, error: e);
    }
  }
}
