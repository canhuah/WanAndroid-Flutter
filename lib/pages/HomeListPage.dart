import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanAndroid/constant/Constants.dart';
import 'package:wanAndroid/http/Api.dart';
import 'package:wanAndroid/http/HttpUtil.dart';
import 'package:wanAndroid/pages/LoginPage.dart';
import 'package:wanAndroid/util/DataUtils.dart';
import 'package:wanAndroid/widget/CommonEndLine.dart';
import 'package:wanAndroid/widget/SlideView.dart';

class HomeListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeListPageState();
  }
}

class HomeListPageState extends State<HomeListPage> {
  List listData = new List();
  var bannerData;
  var curPage = 0;
  var listTotalSize = 0;

  ScrollController _contraller = new ScrollController();
  TextStyle titleTextStyle = new TextStyle(fontSize: 15.0);
  TextStyle subtitleTextStyle =
      new TextStyle(color: Colors.blue, fontSize: 12.0);

  HomeListPageState() {
    _contraller.addListener(() {
      var maxScroll = _contraller.position.maxScrollExtent;
      var pixels = _contraller.position.pixels;

      if (maxScroll == pixels && listData.length < listTotalSize) {
        getHomeArticlelist();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getBanner();
    getHomeArticlelist();
  }

  Future<Null> _pullToRefresh() async {
    curPage = 0;
    getBanner();
    getHomeArticlelist();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (listData == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
        itemCount: listData.length * 2,
        itemBuilder: (context, i) => renderRow(i),
        controller: _contraller,
      );

      return new RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }

  void getBanner() {
    String bannerUrl = Api.BANNER;

    HttpUtil.get(bannerUrl, (data) {
      if (data != null) {
        bannerData = data;
      }
    });
  }

  void getHomeArticlelist() {
    String url = Api.ARTICLE_LIST;
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
    });
  }

  void _handleListItemClick(itemData) {
    DataUtils.isLogin().then((isLogin) {
      if (!isLogin) {
        // 未登录
        Navigator.of(context).pop();
        _login();
      } else {
        collect(itemData);
      }
    });
  }

  _login() async {
    final result = await Navigator
        .of(context)
        .push(new MaterialPageRoute(builder: (context) {
      return new LoginPage();
    }));
  }

  void collect(var itemData) {
    String url;
    if (itemData['collect']) {
      url = Api.UNCOLLECT_ORIGINID;
    } else {
      url = Api.COLLECT;
    }
    url = url + itemData['id'].toString() + "/json";
    HttpUtil.post(url, (data) {
      setState(() {
        itemData['collect'] = !itemData['collect'];
      });
    });
  }

  Widget renderRow(i) {
    if (i == 0) {
      return new Container(
        height: 180.0,
        child: new SlideView(bannerData),
      );
    }
    i -= 1;
    if (i.isOdd) {
      return new Divider(height: 1.0);
    }
    i = i ~/ 2;
    var itemData = listData[i];

    bool isCollect = itemData["collect"];

    if (itemData is String && itemData == Constants.END_LINE_TAG) {
      return new CommonEndLine();
    }

    Row row1 = new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Expanded(
            child: new Row(
          children: <Widget>[
            new Icon(
              Icons.account_circle,
              color: Colors.blue,
            ),
            new Text(itemData['author']),
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
      children: <Widget>[
        new Expanded(
          child: new Text(
            itemData['chapterName'],
            softWrap: true,
            style: new TextStyle(color: Colors.blue),
            textAlign: TextAlign.left,
          ),
        ),
        new GestureDetector(
          child: new Icon(
            isCollect ? Icons.favorite : Icons.favorite_border,
            color: isCollect ? Colors.red : null,
          ),
          onTap: () {
            _handleListItemClick(itemData);
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
          padding: EdgeInsets.all(10.0),
          child: title,
        ),
        new Padding(
          padding: EdgeInsets.all(10.0),
          child: chapterName,
        ),
      ],
    );

    return new Card(
      child: column,
      elevation: 4.0,
    );
  }
}
