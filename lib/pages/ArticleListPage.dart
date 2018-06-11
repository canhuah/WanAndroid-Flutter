import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanAndroid/constant/Constants.dart';
import 'package:wanAndroid/http/Api.dart';
import 'package:wanAndroid/http/HttpUtilWithCookie.dart';
import 'package:wanAndroid/item/ArticleItem.dart';
import 'package:wanAndroid/widget/EndLine.dart';

class ArticleListPage extends StatefulWidget {
  String id;
  ArticleListPage(this.id);

  @override
  State<StatefulWidget> createState() {
    return new ArticleListPageState();
  }
}

class ArticleListPageState extends State<ArticleListPage> {
  int curPage = 0;

  Map<String, String> map = new Map();
  List listData = new List();
  int listTotalSize = 0;
  ScrollController _contraller = new ScrollController();


  @override
  void initState() {
    super.initState();

    _getArticleList();

    _contraller.addListener(() {
      var maxScroll = _contraller.position.maxScrollExtent;
      var pixels = _contraller.position.pixels;

      if (maxScroll == pixels && listData.length < listTotalSize) {
        _getArticleList();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    if (listData == null || listData.isEmpty) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
        itemCount: listData.length ,
        itemBuilder: (context, i) => buildItem(i),
        controller: _contraller,
      );

      return new RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }

  void _getArticleList() {
    String url = Api.ARTICLE_LIST;
    url += "$curPage/json";
    map['cid'] = widget.id;
    HttpUtil.get(url, (data) {
      if (data != null) {
        Map<String, dynamic> map = data;

        var _listData = map['datas'];

        listTotalSize = map["total"];

        setState(() {
          List list1 = new List();
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



  Future<Null> _pullToRefresh() async {
    curPage = 0;
    _getArticleList();
    return null;
  }


  Widget buildItem(int i) {

    var itemData = listData[i];

    if (i == listData.length-1 && itemData.toString() == Constants.END_LINE_TAG) {
      return new EndLine();
    }

    return new ArticleItem(itemData);
  }

}
