import 'package:flutter/material.dart';
import 'package:wanAndroid/http/Api.dart';
import 'package:wanAndroid/http/HttpUtilWithCookie.dart';
import 'package:wanAndroid/pages/ArticleDetailPage.dart';
import 'package:wanAndroid/pages/SearchPage.dart';

class HotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HotPageState();
  }
}

class HotPageState extends State<HotPage> {
  List<Widget> hotkeyWidgets = new List();
  List<Widget> friendWidgets = new List();

  @override
  void initState() {
    super.initState();
    _getFriend();
    _getHotKey();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new Padding(
            padding: EdgeInsets.all(10.0),
            child: new Text('大家都在搜',
                style: new TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 20.0))),
        new Wrap(
          spacing: 5.0,
          runSpacing: 5.0,
          children: hotkeyWidgets,
        ),
        new Padding(
            padding: EdgeInsets.all(10.0),
            child: new Text('常用网站',
                style: new TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 20.0))),
        new Wrap(
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
          Widget actionChip = new ActionChip(
              backgroundColor: Theme.of(context).accentColor,
              label: new Text(
                itemData['name'],
                style: new TextStyle(color: Colors.white),
              ),
              onPressed: () {
                itemData['title'] = itemData['name'];
                Navigator
                    .of(context)
                    .push(new MaterialPageRoute(builder: (context) {
                  return new ArticleDetailPage(
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
        hotkeyWidgets.clear();
        for (var value in datas) {
          Widget actionChip = new ActionChip(
              backgroundColor: Theme.of(context).accentColor,
              label: new Text(
                value['name'],
                style: new TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator
                    .of(context)
                    .pushReplacement(new MaterialPageRoute(builder: (context) {
                  return new SearchPage(value['name']);
                }));
              });

          hotkeyWidgets.add(actionChip);
        }
      });
    });
  }
}
