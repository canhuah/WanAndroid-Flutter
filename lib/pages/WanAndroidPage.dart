import 'package:flutter/material.dart';
import 'package:wanAndroid/constant/colors.dart';
import 'package:wanAndroid/pages/HomeListPage.dart';
import 'package:wanAndroid/pages/MyInfoPage.dart';
import 'package:wanAndroid/pages/SearchPage.dart';
import 'package:wanAndroid/pages/TreePage.dart';

//主页
class WanAndroidApp extends StatefulWidget {
  @override
  _WanAndroidAppState createState() => new _WanAndroidAppState();
}

class _WanAndroidAppState extends State<WanAndroidApp>
    with TickerProviderStateMixin {
  int _tabIndex = 0;

  List<BottomNavigationBarItem> _navigationViews;

  var appBarTitles = ['首页', '发现', '我的'];


  var _body;

  initData() {
    _body = new IndexedStack(
      children: <Widget>[new HomeListPage(), new TreePage(), new MyInfoPage()],
      index: _tabIndex,
    );
  }

  @override
  void initState() {
    super.initState();

    _navigationViews = <BottomNavigationBarItem>[
      new BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        title: new Text(appBarTitles[0]),
        backgroundColor: Colors.blue,
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.widgets),
        title: new Text(appBarTitles[1]),
        backgroundColor: Colors.blue,
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        title: new Text(appBarTitles[2]),
        backgroundColor: Colors.blue,
      ),
    ];
  }

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    initData();

    return new MaterialApp(
      navigatorKey: navigatorKey,
      theme: new ThemeData(
          primaryColor: AppColors.colorPrimary,
          accentColor: Colors.blue
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(
            appBarTitles[_tabIndex],
            style: new TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.search),
                onPressed: () {
//                为什么不直接Navigator.push(context,
//                  new MaterialPageRoute(
//                      builder: (context) => new SearchPage()))
//                  https://stackoverflow.com/questions/50124355/flutter-navigator-not-working

                  navigatorKey.currentState
                      .push(new MaterialPageRoute(builder: (context) {
                    return new SearchPage(null);
                  }));
                })
          ],
        ),
        body: _body,
        bottomNavigationBar: new BottomNavigationBar(
          items: _navigationViews
              .map((BottomNavigationBarItem navigationView) => navigationView)
              .toList(),
          currentIndex: _tabIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ),
      ),
    );
  }
}
