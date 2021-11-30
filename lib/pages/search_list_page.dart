import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanAndroid/http/api_manager.dart';
import 'package:wanAndroid/item/article_item.dart';
import 'package:wanAndroid/model/article_model.dart';

class SearchListPage extends StatefulWidget {
  final String id;

  //这里为什么用含有key的这个构造,大家可以试一下不带key 直接SearchListPage(this.id) ,看看会有什么bug;

  SearchListPage(this.id) : super(key: ValueKey(id));

  @override
  State<StatefulWidget> createState() {
    return SearchListPageState();
  }
}

class SearchListPageState extends State<SearchListPage> {
  int curPage = 0;

  Map<String, String> map = Map();
  List<ArticleModel> listData = [];
  int listTotalSize = 0;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      double maxScroll = _controller.position.maxScrollExtent;
      double pixels = _controller.position.pixels;

      if (maxScroll == pixels && listData.length < listTotalSize) {
        _articleQuery();
      }
    });

    _articleQuery();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (listData.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      Widget listView = ListView.builder(
        itemCount: listData.length,
        itemBuilder: (context, i) => ArticleItem(
            articleModel: listData[i], id: widget.id, isSearch: true),
        controller: _controller,
      );

      return RefreshIndicator(child: listView, onRefresh: pullToRefresh);
    }
  }

  void _articleQuery() {
    ApiManager.instance.queryArticleList(curPage, widget.id,
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

  Future<void> pullToRefresh() async {
    curPage = 0;
    _articleQuery();
  }
}
