import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanAndroid/constant/Constants.dart';
import 'package:wanAndroid/http/Api.dart';
import 'package:wanAndroid/http/HttpUtilWithCookie.dart';
import 'package:wanAndroid/pages/ArticleDetailPage.dart';
import 'package:wanAndroid/pages/LoginPage.dart';
import 'package:wanAndroid/util/DataUtils.dart';
import 'package:wanAndroid/widget/EndLine.dart';

//收藏文章界面
class CollectPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('喜欢的文章'),
      ),
      body: new CollectListPage(),
    );
  }
}


class CollectListPage extends StatefulWidget {
  CollectListPage();

  @override
  State<StatefulWidget> createState() {
    return new CollectListPageState();
  }
}

class CollectListPageState extends State<CollectListPage> {
  int curPage = 0;

  Map<String, String> map = new Map();
  List listData = new List();
  int listTotalSize = 0;
  ScrollController _contraller = new ScrollController();

  CollectListPageState();

  @override
  void initState() {
    super.initState();

    _getCollectList();

    _contraller.addListener(() {
      var maxScroll = _contraller.position.maxScrollExtent;
      var pixels = _contraller.position.pixels;

      if (maxScroll == pixels && listData.length < listTotalSize) {
        _getCollectList();
      }
    });
  }

  @override
  void dispose() {
    _contraller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (listData == null || listData.isEmpty) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
        //
        physics: new AlwaysScrollableScrollPhysics(),
        itemCount: listData.length,
        itemBuilder: (context, i) => buildItem(i),
        controller: _contraller,
      );

      return new RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
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
    _getCollectList();
    return null;
  }

  //还是建议把Item单独抽出来,可以复用.参考 lib/item/ArticleItem.dart
  Widget buildItem(int i) {
    var itemData = listData[i];

    if (i == listData.length - 1 &&
        itemData.toString() == Constants.END_LINE_TAG) {
      return new EndLine();
    }

    Row row1 = new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Expanded(
            child: new Row(
          children: <Widget>[
            new Text('作者:  '),
            new Text(
              itemData['author'],
              style: new TextStyle(color: Theme.of(context).accentColor),
            ),
          ],
        )),
        new Text(itemData['niceDate'])
      ],
    );

    Row title = new Row(
      children: <Widget>[
        new Expanded(
          child: new Text(
            itemData['title'],
            softWrap: true,
            style: new TextStyle(fontSize: 16.0, color: Colors.black),
            textAlign: TextAlign.left,
          ),
        )
      ],
    );

    Row chapterName = new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new GestureDetector(
          child: new Icon(
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

    Column column = new Column(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.all(10.0),
          child: row1,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: title,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
          child: chapterName,
        ),
      ],
    );

    return new Card(
      elevation: 4.0,
      child: new InkWell(
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
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new LoginPage();
    }));
  }

  void _itemClick(var itemData) async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new ArticleDetailPage(
          title: itemData['title'], url: itemData['link']);
    }));
  }


  //取消收藏
  void _itemUnCollect(var itemData) {
    String url;

    url = Api.UNCOLLECT_LIST;

    Map<String, String> map = new Map();
    map['originId'] = itemData['originId'].toString();
    url = url + itemData['id'].toString() + "/json";
    HttpUtil.post(url, (data) {
      setState(() {
        listData.remove(itemData);
      });
    }, params: map);
  }
}
