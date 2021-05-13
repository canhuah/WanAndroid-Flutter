import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanAndroid/constant/constants.dart';
import 'package:wanAndroid/http/api.dart';
import 'package:wanAndroid/http/http_util_with_cookie.dart';
import 'package:wanAndroid/pages/article_detail_page.dart';
import 'package:wanAndroid/pages/login_page.dart';
import 'package:wanAndroid/util/DataUtils.dart';
import 'package:wanAndroid/widget/end_line.dart';

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
  List listData = List();
  int listTotalSize = 0;
  ScrollController _control = ScrollController();

  CollectListPageState();

  @override
  void initState() {
    super.initState();

    _getCollectList();

    _control.addListener(() {
      var maxScroll = _control.position.maxScrollExtent;
      var pixels = _control.position.pixels;

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
        itemBuilder: (context, i) => buildItem(i),
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

  Future<Null> _pullToRefresh() async {
    curPage = 0;
    _getCollectList();
    return null;
  }

  //还是建议把Item单独抽出来,可以复用.参考 lib/item/article_item.dart
  Widget buildItem(int i) {
    var itemData = listData[i];

    if (i == listData.length - 1 &&
        itemData.toString() == Constants.END_LINE_TAG) {
      return EndLine();
    }

    Row row1 = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Row(
          children: <Widget>[
            Text('作者:  '),
            Text(
              itemData['author'],
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
          ],
        )),
        Text(itemData['niceDate'])
      ],
    );

    Row title = Row(
      children: <Widget>[
        Expanded(
          child: Text(
            itemData['title'],
            softWrap: true,
            style: TextStyle(fontSize: 16.0, color: Colors.black),
            textAlign: TextAlign.left,
          ),
        )
      ],
    );

    Row chapterName = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          child: Icon(
//            isCollect ? Icons.favorite : Icons.favorite_border,
//            color: isCollect ? Colors.red : null,
            Icons.favorite, color: Colors.red,
          ),
          onTap: () {
            _handleListItemCollect(itemData);
          },
        )
      ],
    );

    Column column = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: row1,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: title,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
          child: chapterName,
        ),
      ],
    );

    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          _itemClick(itemData);
        },
        child: column,
      ),
    );
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

  void _itemClick(var itemData) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ArticleDetailPage(title: itemData['title'], url: itemData['link']);
    }));
  }

  //取消收藏
  void _itemUnCollect(var itemData) {
    String url;

    url = Api.UNCOLLECT_LIST;

    Map<String, String> map = Map();
    map['originId'] = itemData['originId'].toString();
    url = url + itemData['id'].toString() + "/json";
    HttpUtil.post(url, (data) {
      setState(() {
        listData.remove(itemData);
      });
    }, params: map);
  }
}
