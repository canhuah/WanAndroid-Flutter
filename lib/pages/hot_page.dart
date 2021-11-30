import 'package:flutter/material.dart';
import 'package:wanAndroid/http/api_manager.dart';
import 'package:wanAndroid/model/friend_model.dart';
import 'package:wanAndroid/model/hot_key_model.dart';
import 'package:wanAndroid/pages/article_detail_page.dart';
import 'package:wanAndroid/pages/search_page.dart';

class HotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HotPageState();
  }
}

class _HotPageState extends State<HotPage> {
  List<FriendModel> friends = [];
  List<HotKeyModel> hotKeys = [];

  @override
  void initState() {
    super.initState();
    _getFriendList();
    _getHotKeyList();
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
          children: hotKeys
              .map((hotKeyModel) => HotKeyCell(
                    text: hotKeyModel.name ?? "",
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return SearchPage(searchStr: hotKeyModel.name ?? "");
                      }));
                    },
                  ))
              .toList(),
        ),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('常用网站',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 16.0))),
        Wrap(
          spacing: 5.0,
          runSpacing: 1.0,
          children: friends
              .map((friendModel) => HotKeyCell(
                    text: friendModel.name ?? "",
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ArticleDetailPage(
                            title: friendModel.name ?? "",
                            url: friendModel.link ?? "");
                      }));
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }

  void _getFriendList() {
    ApiManager.instance.getFriendList(successCallback: (friendList) {
      setState(() {
        friends = friendList;
      });
    });
  }

  void _getHotKeyList() {
    ApiManager.instance.getHotKeyList(successCallback: (hotKeyList) {
      setState(() {
        hotKeys = hotKeyList;
      });
    });
  }
}

class HotKeyCell extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;

  const HotKeyCell({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
        backgroundColor: Theme.of(context).primaryColor,
        label: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        onPressed: onPressed);
  }
}
