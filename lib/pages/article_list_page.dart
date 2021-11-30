import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanAndroid/http/api_manager.dart';
import 'package:wanAndroid/item/article_item.dart';

class ArticleListPage extends StatefulWidget {
  final String id;

  ArticleListPage(this.id);

  @override
  State<StatefulWidget> createState() {
    return _ArticleListPageState();
  }
}

class _ArticleListPageState extends State<ArticleListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int curPage = 0;

  Map<String, String> map = Map();
  List listData = [];
  int listTotalSize = 0;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _getArticleList();

    _controller.addListener(() {
      double maxScroll = _controller.position.maxScrollExtent;
      double pixels = _controller.position.pixels;

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
    if (listData.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      Widget listView = ListView.builder(
        key: ValueKey(widget.id),
        itemCount: listData.length,
        itemBuilder: (context, i) => ArticleItem(articleModel: listData[i]),
        controller: _controller,
      );

      return RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }

  void _getArticleList() async {
    ApiManager.instance.getArticleList(curPage,cid: widget.id,
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

  Future<void> _pullToRefresh() async {
    curPage = 0;
    _getArticleList();
  }
}
