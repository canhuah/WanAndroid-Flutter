import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanAndroid/http/api_manager.dart';
import 'package:wanAndroid/item/article_item.dart';
import 'package:wanAndroid/model/bannel_model.dart';
import 'package:wanAndroid/widget/slide_view.dart';

class HomeListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeListPageState();
  }
}

class HomeListPageState extends State<HomeListPage> {
  List listData = [];

  int curPage = 0;
  int listTotalSize = 0;

  ScrollController _controller = ScrollController();
  TextStyle titleTextStyle = TextStyle(fontSize: 15.0);
  TextStyle subtitleTextStyle = TextStyle(color: Colors.blue, fontSize: 12.0);

  List<BannerModel> banners = [];

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      double maxScroll = _controller.position.maxScrollExtent;
      double pixels = _controller.position.pixels;

      if (maxScroll == pixels && listData.length < listTotalSize) {
        getHomeArticleList();
      }
    });


    getBanner();
    getHomeArticleList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pullToRefresh() async {
    curPage = 0;
    getBanner();
    getHomeArticleList();
  }

  @override
  Widget build(BuildContext context) {
    if (listData.isEmpty) {
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

  void getBanner() {
    ApiManager.instance.getBanner(successCallback: (banners) {
      setState(() {
        this.banners = banners;
      });
    });
  }

  void getHomeArticleList() {
    ApiManager.instance.getArticleList(curPage,
        successCallback: (articleListModel) {
      setState(() {
        if (curPage == 0) {
          listData.clear();
        }
        curPage++;

        listData.addAll(articleListModel.datas ?? []);
      });
    });
  }

  Widget buildItem(int i) {
    if (i == 0) {
      return Container(
        height: MediaQuery.of(context).size.width*5/9,
        child: SlideView(banners),
      );
    }

    return ArticleItem(
      articleModel: listData[i - 1],
    );
  }
}
