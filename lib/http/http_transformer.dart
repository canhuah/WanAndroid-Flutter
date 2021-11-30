import 'package:dio/dio.dart';

import 'dio_new.dart';


/// Response 解析
abstract class HttpTransformer {
  HttpResponse parse(Response response);
}





