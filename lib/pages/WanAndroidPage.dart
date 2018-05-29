import 'package:flutter/material.dart';
import 'package:wanAndroid/constant/colors.dart';
import 'package:wanAndroid/pages/AboutUs.dart';
import 'package:wanAndroid/pages/HomeListPage.dart';
import 'package:wanAndroid/pages/LoginPage.dart';


class WanAndroidDemo extends StatefulWidget {
  @override
  _WanAndroidDemoState createState() => new _WanAndroidDemoState();
}

class _WanAndroidDemoState extends State<WanAndroidDemo>
    with TickerProviderStateMixin {
  int _tabIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.fixed;
  List<BottomNavigationBarItem> _navigationViews;

  var appBarTitles = ['首页', '发现', '我的'];

  PageController pageController;

  var _body;

  initData() {
    _body = new IndexedStack(
      children: <Widget>[
        new HomeListPage(),
        new LoginPage(),
        new AboutUsPage()
      ],
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

  @override
  Widget build(BuildContext context) {
    initData();
    return new MaterialApp(
      theme: new ThemeData(primaryColor: AppColors.colorPrimary),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(
            appBarTitles[_tabIndex],
            style: new TextStyle(color: Colors.white),
          ),
        ),
        body: _body,
        bottomNavigationBar: new BottomNavigationBar(
          items: _navigationViews
              .map((BottomNavigationBarItem navigationView) => navigationView)
              .toList(),
          currentIndex: _tabIndex,
          type: _type,
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
