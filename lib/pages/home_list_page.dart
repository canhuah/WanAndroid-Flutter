import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanAndroid/http/api.dart';
import 'package:wanAndroid/http/http_util_with_cookie.dart';
import 'package:wanAndroid/item/article_item.dart';
import 'package:wanAndroid/model/article_model.dart';
import 'package:wanAndroid/model/bannel_model.dart';
import 'package:wanAndroid/widget/slide_view.dart';

class HomeListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeListPageState();
  }
}

class HomeListPageState extends State<HomeListPage> {
  List listData = List();

  int curPage = 0;
  int listTotalSize = 0;

  ScrollController _controller = ScrollController();
  TextStyle titleTextStyle = TextStyle(fontSize: 15.0);
  TextStyle subtitleTextStyle = TextStyle(color: Colors.blue, fontSize: 12.0);

  HomeListPageState() {
    _controller.addListener(() {
      double maxScroll = _controller.position.maxScrollExtent;
      double pixels = _controller.position.pixels;

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
    _controller.dispose();
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
        controller: _controller,
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
          List list = data;
          List<BannerModel> banners =
              list.map((e) => BannerModel.fromJson(e)).toList();
          _bannerView = SlideView(banners);
        });
      }
    });
  }

  void getHomeArticlelist() {
    String url = Api.ARTICLE_LIST;
    url += "$curPage/json";

    HttpUtil.get(url, (data) {
      if (data != null) {
        ArticleListModel articleListModel = ArticleListModel.fromJson(data);

        setState(() {
          if (curPage == 0) {
            listData.clear();
          }
          curPage++;

          listData.addAll(articleListModel.datas ?? []);
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

    return ArticleCell(
      articleModel: listData[i],
    );
  }
}
