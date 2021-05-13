import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanAndroid/constant/constants.dart';
import 'package:wanAndroid/http/api.dart';
import 'package:wanAndroid/http/http_util_with_cookie.dart';
import 'package:wanAndroid/item/article_item.dart';
import 'package:wanAndroid/widget/end_line.dart';

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
  List listData = List();
  int listTotalSize = 0;
  ScrollController _contraller = ScrollController();

  @override
  void initState() {
    super.initState();

    _contraller.addListener(() {
      var maxScroll = _contraller.position.maxScrollExtent;
      var pixels = _contraller.position.pixels;

      if (maxScroll == pixels && listData.length < listTotalSize) {
        _articleQuery();
      }
    });

    _articleQuery();
  }

  @override
  void dispose() {
    _contraller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (listData == null || listData.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      Widget listView = ListView.builder(
        itemCount: listData.length,
        itemBuilder: (context, i) => buildItem(i),
        controller: _contraller,
      );

      return RefreshIndicator(child: listView, onRefresh: pullToRefresh);
    }
  }

  void _articleQuery() {
    String url = Api.ARTICLE_QUERY;
    url += "$curPage/json";
    map['k'] = widget.id;

    HttpUtil.post(url, (data) {
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
    }, params: map);
  }

  Future<Null> pullToRefresh() async {
    curPage = 0;
    _articleQuery();
    return null;
  }

  Widget buildItem(int i) {
    var itemData = listData[i];

    if (i == listData.length - 1 &&
        itemData.toString() == Constants.END_LINE_TAG) {
      return EndLine();
    }

    return ArticleItem.isFromSearch(itemData, widget.id);
  }
}
