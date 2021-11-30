import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:wanAndroid/http/app_urls.dart';
import 'package:wanAndroid/http/dio_new.dart';
import 'package:wanAndroid/model/article_model.dart';
import 'package:wanAndroid/model/bannel_model.dart';
import 'package:wanAndroid/model/friend_model.dart';
import 'package:wanAndroid/model/hot_key_model.dart';
import 'package:wanAndroid/model/tree_model.dart';

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class ApiManager {
  factory ApiManager() => _getInstance();

  static ApiManager get instance => _getInstance();

  static ApiManager? _instance;

  ApiManager._internal();

  static ApiManager _getInstance() {
    if (_instance == null) {
      _instance = ApiManager._internal();
    }
    return _instance!;
  }

  HttpClient? client;

  initClient() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    PersistCookieJar persistCookieJar = PersistCookieJar(
        ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));

    HttpConfig dioConfig = HttpConfig(
        baseUrl: AppUrls.BaseUrl,
        interceptors: [CookieManager(persistCookieJar)]);

    client = HttpClient(dioConfig: dioConfig);
  }

  HttpClient getClient() {
    if (client == null) {
      throw Exception("请在第一个网络请求之前先调用initClient()方法初始化clint");
    }
    return client!;
  }

  ///获取收藏文章列表
  getBanner({Function(List<BannerModel>)? successCallback}) async {
    HttpResponse httpResponse = await getClient().get(AppUrls.BANNER);

    if (httpResponse.ok) {
      List list = httpResponse.data;
      List<BannerModel> banners =
          list.map((e) => BannerModel.fromJson(e)).toList();

      successCallback?.call(banners);
    } else {
      handleErrorResponse(httpResponse);
    }
  }

  ///文章收藏 或者 取消收藏
  articleCollectOrUnCollect(ArticleModel articleModel,
      {Function? successCallback}) async {
    String url;
    if (articleModel.collect ?? false) {
      url = AppUrls.UNCOLLECT_ORIGINID;
    } else {
      url = AppUrls.COLLECT;
    }
    url += '${articleModel.id}/json';

    HttpResponse httpResponse = await getClient().post(url);

    if (httpResponse.ok) {
      successCallback?.call();
    } else {
      handleErrorResponse(httpResponse);
    }
  }

  ///获取收藏文章列表
  getCollectList(int curPage,
      {Function(ArticleListModel)? successCallback}) async {
    String url = "${AppUrls.COLLECT_LIST}$curPage/json";

    HttpResponse httpResponse = await getClient().get(url);

    if (httpResponse.ok) {
      ArticleListModel articleListModel =
          ArticleListModel.fromJson(httpResponse.data);

      successCallback?.call(articleListModel);
    } else {
      handleErrorResponse(httpResponse);
    }
  }

  ///收藏列表取消收藏
  unCollect(ArticleModel articleModel, {Function? successCallback}) async {
    String url = "${AppUrls.UNCOLLECT_LIST}${articleModel.id}/json";

    HttpResponse httpResponse =
        await getClient().post(url, data: {"originId": articleModel.originId});
    if (httpResponse.ok) {
      successCallback?.call();
    } else {
      handleErrorResponse(httpResponse);
    }
  }

  ///获取文章列表
  void getArticleList(int curPage,
      {String? cid, Function(ArticleListModel)? successCallback}) async {
    String url = "${AppUrls.ARTICLE_LIST}$curPage/json";

    HttpResponse httpResponse = await getClient()
        .get(url, queryParameters: cid == null ? {} : {"cid": cid});

    if (httpResponse.ok) {
      ArticleListModel articleListModel =
          ArticleListModel.fromJson(httpResponse.data);

      successCallback?.call(articleListModel);
    } else {
      handleErrorResponse(httpResponse);
    }
  }

  ///根据id查询文章列表
  void queryArticleList(int curPage, String id,
      {Function(ArticleListModel)? successCallback}) async {
    String url = "${AppUrls.ARTICLE_QUERY}$curPage/json";

    HttpResponse httpResponse = await getClient().post(url, data: {"k": id});

    if (httpResponse.ok) {
      ArticleListModel articleListModel =
          ArticleListModel.fromJson(httpResponse.data);

      successCallback?.call(articleListModel);
    } else {
      handleErrorResponse(httpResponse);
    }
  }

  ///获取常用网站
  getFriendList({Function(List<FriendModel>)? successCallback}) async {
    HttpResponse httpResponse = await getClient().get(AppUrls.FRIEND);

    if (httpResponse.ok) {
      List list = httpResponse.data;
      List<FriendModel> friends =
          list.map((e) => FriendModel.fromJson(e)).toList();

      successCallback?.call(friends);
    } else {
      handleErrorResponse(httpResponse);
    }
  }

  ///获取搜索热词
  getHotKeyList({Function(List<HotKeyModel>)? successCallback}) async {
    HttpResponse httpResponse = await getClient().get(AppUrls.HOTKEY);

    if (httpResponse.ok) {
      List list = httpResponse.data;
      List<HotKeyModel> hotKeys =
          list.map((e) => HotKeyModel.fromJson(e)).toList();

      successCallback?.call(hotKeys);
    } else {
      handleErrorResponse(httpResponse);
    }
  }

  ///
  getTreeList({Function(List<TreeModel>)? successCallback}) async {
    HttpResponse httpResponse = await getClient().get(AppUrls.TREE);

    if (httpResponse.ok) {
      List list = httpResponse.data;
      List<TreeModel> treeList =
          list.map((e) => TreeModel.fromJson(e)).toList();

      successCallback?.call(treeList);
    } else {
      handleErrorResponse(httpResponse);
    }
  }

  login(String username, String password, {Function? successCallback}) async {
    HttpResponse httpResponse = await getClient().post(AppUrls.LOGIN,
        data: {"username": username, "password": password});

    if (httpResponse.ok) {
      successCallback?.call();
    } else {
      handleErrorResponse(httpResponse);
    }
  }

  register(String username, String password,
      {Function? successCallback}) async {
    HttpResponse httpResponse = await getClient().post(AppUrls.REGISTER, data: {
      "username": username,
      "password": password,
      "repassword": password
    });

    if (httpResponse.ok) {
      successCallback?.call();
    } else {
      handleErrorResponse(httpResponse);
    }
  }

  handleErrorResponse(HttpResponse response) {
    print(response.error?.message);
  }
}
