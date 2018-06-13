import 'package:flutter/material.dart';
import 'package:wanAndroid/pages/ArticleDetailPage.dart';

//关于我们
class AboutUsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AboutUsPageState();
  }
}

class AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    Widget icon = new Image.asset(
      'images/ic_launcher_round.png',
      width: 100.0,
      height: 100.0,
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('关于'),
      ),
      body: new ListView(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        children: <Widget>[
          icon,
          new ListTile(
              title: const Text('关于项目'),
              subtitle: const Text(
                  '项目是自己在学习Flutter的时候写的demo,模仿WanAndroid客户端,实现了其大部分的功能效果(首页抽屉效果不习惯就直接搬出来了)嘿嘿``'),
              trailing:  Icon(Icons.chevron_right, color: Theme.of(context).accentColor),
              onTap: () {
                Navigator
                    .of(context)
                    .push(new MaterialPageRoute(builder: (context) {
                  return new ArticleDetailPage(
                    title: 'WanAndroid_Flutter版',
                    url: 'https://github.com/canhuah/WanAndroid',
                  );
                }));
              }),
          new ListTile(
              title: const Text('关于我'),
              subtitle: const Text('一个Android程序猿,初学Flutter,博客地址是..'),
              trailing:  Icon(Icons.chevron_right, color: Theme.of(context).accentColor),
              onTap: () {
                Navigator
                    .of(context)
                    .push(new MaterialPageRoute(builder: (context) {
                  return new ArticleDetailPage(
                    title: 'canhuah的博客',
                    url: 'http://www.canhuah.com',
                  );
                }));
              }),
        ],
      ),
    );
  }
}
