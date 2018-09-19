
import 'package:flutter/material.dart';
import 'package:wanAndroid/constant/Constants.dart';
import 'package:wanAndroid/event/LoginEvent.dart';

import 'package:wanAndroid/pages/AboutUsPage.dart';
import 'package:wanAndroid/pages/CollectListPage.dart';
import 'package:wanAndroid/pages/LoginPage.dart';
import 'package:wanAndroid/util/DataUtils.dart';

class MyInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyInfoPageState();
  }
}

class MyInfoPageState extends State<MyInfoPage> with WidgetsBindingObserver {
  String userName;

  @override
  void initState() {
    super.initState();

    _getName();

    Constants.eventBus.on<LoginEvent>().listen((event) {
      _getName();
    });
  }

  void _getName() async {
    DataUtils.getUserName().then((username) {
      setState(() {
        userName = username;
        print('name:' + userName.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget image = new Image.asset(
      'images/ic_launcher_round.png',
      width: 100.0,
      height: 100.0,
    );

    Widget raisedButton = new RaisedButton(
      child: new Text(
        userName == null ? "请登录" : userName,
        style: new TextStyle(color: Colors.white),
      ),
      color: Theme.of(context).accentColor,
      onPressed: () async {
        //登录

        await DataUtils.isLogin().then((isLogin) {
          if (!isLogin) {
            Navigator
                .of(context)
                .push(new MaterialPageRoute(builder: (context) {
              return new LoginPage();
            }));
          } else {
            print('已登录!');
          }
        });
      },
    );

    Widget listLike = new ListTile(
        leading: const Icon(Icons.favorite),
        title: const Text('喜欢的文章'),
        trailing:  Icon(Icons.chevron_right, color: Theme.of(context).accentColor),
        onTap: () async {
          await DataUtils.isLogin().then((isLogin) {
            if (isLogin) {
              Navigator
                  .of(context)
                  .push(new MaterialPageRoute(builder: (context) {
                return new CollectPage();
              }));
            } else {
              print('已登录!');
              Navigator
                  .of(context)
                  .push(new MaterialPageRoute(builder: (context) {
                return new LoginPage();
              }));
            }
          });
        });

    Widget listAbout = new ListTile(
        leading: const Icon(Icons.info),
        title: const Text('关于我们'),
        trailing:  Icon(Icons.chevron_right, color: Theme.of(context).accentColor),
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new AboutUsPage();
          }));
        });

    Widget listLogout = new ListTile(
        leading: const Icon(Icons.info),
        title: const Text('退出登录'),
        trailing:  Icon(Icons.chevron_right, color: Theme.of(context).accentColor),
        onTap: () async {
          DataUtils.clearLoginInfo();
          setState(() {
            userName = null;
          });
        });

    return new ListView(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      children: <Widget>[
        image,
        raisedButton,
        listLike,
        listAbout,
        listLogout,
      ],
    );
  }
}
