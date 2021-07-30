import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanAndroid/http/api.dart';
import 'package:wanAndroid/http/http_util_with_cookie.dart';
import 'package:wanAndroid/item/article_item.dart';
import 'package:wanAndroid/model/article_model.dart';
import 'package:wanAndroid/pages/login_page.dart';
import 'package:wanAndroid/util/DataUtils.dart';

//收藏文章界面
class CollectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('喜欢的文章'),
      ),
      body: CollectListPage(),
    );
  }
}

class CollectListPage extends StatefulWidget {
  CollectListPage();

  @override
  State<StatefulWidget> createState() {
    return CollectListPageState();
  }
}

class CollectListPageState extends State<CollectListPage> {
  int curPage = 0;

  Map<String, String> map = Map();
  List<ArticleModel> listData = List();
  int listTotalSize = 0;
  ScrollController _control = ScrollController();

  CollectListPageState();

  @override
  void initState() {
    super.initState();

    _getCollectList();

    _control.addListener(() {
      double maxScroll = _control.position.maxScrollExtent;
      double pixels = _control.position.pixels;

      if (maxScroll == pixels && listData.length < listTotalSize) {
        _getCollectList();
      }
    });
  }

  @override
  void dispose() {
    _control.dispose();
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
        //
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: listData.length,
        itemBuilder: (context, i) => ArticleCell(
          articleModel: listData[i],
          isFromCollect: true,
          onClickCollect: () {
            _handleListItemCollect(listData[i]);
          },
        ),
        controller: _control,
      );

      return RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }

  void _getCollectList() {
    String url = Api.COLLECT_LIST;
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
    }, params: map);
  }

  Future<Null> _pullToRefresh() async {
    curPage = 0;
    _getCollectList();
    return null;
  }

  void _handleListItemCollect(itemData) {
    DataUtils.isLogin().then((isLogin) {
      if (!isLogin) {
        // 未登录
        _login();
      } else {
        _itemUnCollect(itemData);
      }
    });
  }

  _login() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }

  //取消收藏
  void _itemUnCollect(ArticleModel articleModel) {
    String url;

    url = Api.UNCOLLECT_LIST;

    Map<String, String> map = Map();
    map['originId'] = articleModel.originId.toString();
    url = url + articleModel.id.toString() + "/json";
    HttpUtil.post(url, (data) {
      setState(() {
        listData.remove(articleModel);
      });
    }, params: map);
  }
}
