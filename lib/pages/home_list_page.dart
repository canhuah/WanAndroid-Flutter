import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanAndroid/constant/constants.dart';
import 'package:wanAndroid/http/api.dart';
import 'package:wanAndroid/http/http_util_with_cookie.dart';
import 'package:wanAndroid/item/article_item.dart';
import 'package:wanAndroid/widget/end_line.dart';
import 'package:wanAndroid/widget/slide_view.dart';

class HomeListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeListPageState();
  }
}

class HomeListPageState extends State<HomeListPage> {
  List listData = List();
  var bannerData;
  var curPage = 0;
  var listTotalSize = 0;

  ScrollController _contraller = ScrollController();
  TextStyle titleTextStyle = TextStyle(fontSize: 15.0);
  TextStyle subtitleTextStyle = TextStyle(color: Colors.blue, fontSize: 12.0);

  HomeListPageState() {
    _contraller.addListener(() {
      var maxScroll = _contraller.position.maxScrollExtent;
      var pixels = _contraller.position.pixels;

      if (maxScroll == pixels && listData.length < listTotalSize) {
        getHomeArticlelist();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getBanner();
    getHomeArticlelist();
  }

  @override
  void dispose() {
    _contraller.dispose();
    super.dispose();
  }

  Future<Null> _pullToRefresh() async {
    curPage = 0;
    getBanner();
    getHomeArticlelist();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (listData == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      Widget listView = ListView.builder(
        itemCount: listData.length + 1,
        itemBuilder: (context, i) => buildItem(i),
        controller: _contraller,
      );

      return RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }

  SlideView _bannerView;

  void getBanner() {
    String bannerUrl = Api.BANNER;

    HttpUtil.get(bannerUrl, (data) {
      if (data != null) {
        setState(() {
          bannerData = data;
          _bannerView = SlideView(bannerData);
        });
      }
    });
  }

  void getHomeArticlelist() {
    String url = Api.ARTICLE_LIST;
    url += "$curPage/json";

    HttpUtil.get(url, (data) {
      if (data != null) {
        Map<String, dynamic> map = data;

        var _listData = map['datas'];

        listTotalSize = map["total"];

        setState(() {
          List list1 = List();
          if (curPage == 0) {
            listData.clear();
          }
          curPage++;

          list1.addAll(listData);
          list1.addAll(_listData);
          if (list1.length >= listTotalSize) {
            list1.add(Constants.END_LINE_TAG);
          }
          listData = list1;
        });
      }
    });
  }

  Widget buildItem(int i) {
    if (i == 0) {
      return Container(
        height: 180.0,
        child: _bannerView,
      );
    }
    i -= 1;

    var itemData = listData[i];

    if (itemData is String && itemData == Constants.END_LINE_TAG) {
      return EndLine();
    }

    return ArticleItem(itemData);
  }
}
