import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanAndroid/http/api_manager.dart';
import 'package:wanAndroid/item/article_item.dart';
import 'package:wanAndroid/model/article_model.dart';
import 'package:wanAndroid/pages/login_page.dart';
import 'package:wanAndroid/util/data_utils.dart';

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

  List<ArticleModel> listData = [];
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
        itemBuilder: (context, i) => ArticleItem(
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
    ApiManager.instance.getCollectList(curPage,
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
    _getCollectList();
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
    ApiManager.instance.unCollect(articleModel, successCallback: () {
      setState(() {
        listData.remove(articleModel);
      });
    });
  }
}
