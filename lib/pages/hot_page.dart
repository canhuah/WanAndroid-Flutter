import 'package:flutter/material.dart';
import 'package:wanAndroid/http/api.dart';
import 'package:wanAndroid/http/http_util_with_cookie.dart';
import 'package:wanAndroid/model/friend_model.dart';
import 'package:wanAndroid/model/hot_key_model.dart';
import 'package:wanAndroid/pages/article_detail_page.dart';
import 'package:wanAndroid/pages/search_page.dart';

class HotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HotPageState();
  }
}

class HotPageState extends State<HotPage> {
  List<Widget> hotKeyWidgets = List();
  List<Widget> friendWidgets = List();

  @override
  void initState() {
    super.initState();
    _getFriend();
    _getHotKey();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('大家都在搜',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 16.0))),
        Wrap(
          spacing: 5.0,
          runSpacing: 1.0,
          children: hotKeyWidgets,
        ),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('常用网站',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 16.0))),
        Wrap(
          spacing: 5.0,
          runSpacing: 1.0,
          children: friendWidgets,
        ),
      ],
    );
  }

  void _getFriend() {
    HttpUtil.get(Api.FRIEND, (data) {
      setState(() {
        List list = data;

        List<FriendModel> friends =
            list.map((e) => FriendModel.fromJson(e)).toList();

        hotKeyWidgets.clear();
        for (FriendModel friendModel in friends) {
          Widget actionChip = HotKeyCell(
            text: friendModel.name,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ArticleDetailPage(
                    title: friendModel.name, url: friendModel.link);
              }));
            },
          );

          hotKeyWidgets.add(actionChip);
        }
      });
    });
  }

  void _getHotKey() {
    HttpUtil.get(Api.HOTKEY, (data) {
      setState(() {
        List list = data;

        List<HotKeyModel> hotKeys =
            list.map((e) => HotKeyModel.fromJson(e)).toList();

        hotKeyWidgets.clear();
        for (HotKeyModel hotKeyModel in hotKeys) {
          Widget actionChip = HotKeyCell(
            text: hotKeyModel.name,
            onPressed: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return SearchPage(hotKeyModel.name);
              }));
            },
          );

          hotKeyWidgets.add(actionChip);
        }
      });
    });
  }
}

class HotKeyCell extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;

  const HotKeyCell({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
        backgroundColor: Theme.of(context).primaryColor,
        label: Text(
          text ?? "",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        onPressed: onPressed);
  }
}
