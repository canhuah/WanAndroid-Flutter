import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanAndroid/http/http_manager.dart';
import 'package:wanAndroid/item/article_item.dart';
import 'package:wanAndroid/model/article_model.dart';

class ArticleListPage extends StatefulWidget {
  final String id;

  ArticleListPage(this.id);

  @override
  State<StatefulWidget> createState() {
    return ArticleListPageState();
  }
}

class ArticleListPageState extends State<ArticleListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  //  若当前tab切到任意非相邻tab(如:第一个tab切换到第三个)，会报错，请升级flutter版本
  int curPage = 0;

  Map<String, String> map = Map();
  List listData = List();
  int listTotalSize = 0;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _getArticleList();

    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;

      if (maxScroll == pixels && listData.length < listTotalSize) {
        _getArticleList();
      }
    });
  }

//  bool isDisposed = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (listData == null || listData.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      Widget listView = ListView.builder(
        key: ValueKey(widget.id),
        itemCount: listData.length,
        itemBuilder: (context, i) => ArticleCell(articleModel: listData[i]),
        controller: _controller,
      );

      return RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }

  void _getArticleList() async {
    String param = "$curPage/json";

    dynamic data = await HttpManager.getArticleList(param, {"cid": widget.id});

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
  }

  Future<Null> _pullToRefresh() async {
    curPage = 0;
    _getArticleList();
    return null;
  }
}
