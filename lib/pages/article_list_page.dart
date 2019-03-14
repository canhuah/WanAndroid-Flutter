import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanAndroid/constant/constants.dart';
import 'package:wanAndroid/http/api.dart';
import 'package:wanAndroid/http/http_util_with_cookie.dart';
import 'package:wanAndroid/item/article_item.dart';
import 'package:wanAndroid/widget/end_line.dart';

class ArticleListPage extends StatefulWidget {
  final String id;

  ArticleListPage(this.id);

  @override
  State<StatefulWidget> createState() {
    return  ArticleListPageState();
  }
}

class ArticleListPageState extends State<ArticleListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  //  若当前tab切到任意非相邻tab(如:第一个tab切换到第三个)，会报错，请升级flutter版本
  int curPage = 0;

  Map<String, String> map =  Map();
  List listData =  List();
  int listTotalSize = 0;
  ScrollController _controller =  ScrollController();

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
    if (listData == null || listData.isEmpty) {
      return  Center(
        child:  CircularProgressIndicator(),
      );
    } else {
      Widget listView =  ListView.builder(
        key:  PageStorageKey(widget.id),
        itemCount: listData.length,
        itemBuilder: (context, i) => buildItem(i),
        controller: _controller,
      );

      return  RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
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

//        if(!this.mounted){
//          return;
//        }
//
        setState(() {
          List list1 =  List();
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

    if (i == listData.length - 1 &&
        itemData.toString() == Constants.END_LINE_TAG) {
      return  EndLine();
    }

    return  ArticleItem(itemData);
  }
}
