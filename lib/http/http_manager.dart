import 'package:wanAndroid/http/api.dart';
import 'package:wanAndroid/http/http_util.dart';

class HttpManager {
  /// 获取所有地址列表
  static Future<dynamic> getArticleList(String param, params) async {
    return await HttpUtil.getInstance().get(Api.ARTICLE_LIST,param: param,params: params);
  }
}
