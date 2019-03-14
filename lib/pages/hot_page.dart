import 'package:flutter/material.dart';
import 'package:wanAndroid/http/api.dart';
import 'package:wanAndroid/http/http_util_with_cookie.dart';
import 'package:wanAndroid/pages/article_detail_page.dart';
import 'package:wanAndroid/pages/search_page.dart';

class HotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return  HotPageState();
  }
}

class HotPageState extends State<HotPage> {
  List<Widget> hotKeyWidgets =  List();
  List<Widget> friendWidgets =  List();

  @override
  void initState() {
    super.initState();
    _getFriend();
    _getHotKey();
  }

  @override
  Widget build(BuildContext context) {
    return  ListView(
      children: <Widget>[
         Padding(
            padding: EdgeInsets.all(10.0),
            child:  Text('大家都在搜',
                style:  TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 20.0))),
         Wrap(
          spacing: 5.0,
          runSpacing: 5.0,
          children: hotKeyWidgets,
        ),
         Padding(
            padding: EdgeInsets.all(10.0),
            child:  Text('常用网站',
                style:  TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 20.0))),
         Wrap(
          spacing: 5.0,
          runSpacing: 5.0,
          children: friendWidgets,
        ),
      ],
    );
  }

  void _getFriend() {
    HttpUtil.get(Api.FRIEND, (data) {
      setState(() {
        List datas = data;
        friendWidgets.clear();
        for (var itemData in datas) {
          Widget actionChip =  ActionChip(
              backgroundColor: Theme.of(context).accentColor,
              label:  Text(
                itemData['name'],
                style:  TextStyle(color: Colors.white),
              ),
              onPressed: () {
                itemData['title'] = itemData['name'];
                Navigator
                    .of(context)
                    .push( MaterialPageRoute(builder: (context) {
                  return  ArticleDetailPage(
                      title: itemData['title'], url: itemData['link']);
                }));
              });

          friendWidgets.add(actionChip);
        }
      });
    });
  }

  void _getHotKey() {
    HttpUtil.get(Api.HOTKEY, (data) {
      setState(() {
        List datas = data;
        hotKeyWidgets.clear();
        for (var value in datas) {
          Widget actionChip =  ActionChip(
              backgroundColor: Theme.of(context).accentColor,
              label:  Text(
                value['name'],
                style:  TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator
                    .of(context)
                    .pushReplacement( MaterialPageRoute(builder: (context) {
                  return  SearchPage(value['name']);
                }));
              });

          hotKeyWidgets.add(actionChip);
        }
      });
    });
  }
}
