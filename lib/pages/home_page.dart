import 'package:flutter/material.dart';
import 'package:wanAndroid/constant/app_colors.dart';
import 'package:wanAndroid/pages/home_list_page.dart';
import 'package:wanAndroid/pages/myInfo_page.dart';
import 'package:wanAndroid/pages/search_page.dart';
import 'package:wanAndroid/pages/tree_page.dart';

//主页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  int _tabIndex = 0;

  late List<BottomNavigationBarItem> _navigationViews;

  List<String> appBarTitles = ['首页', '发现', '我的'];

  Widget? _body;

  @override
  void initState() {
    super.initState();

    _navigationViews = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        label: appBarTitles[0],
        backgroundColor: AppColors.colorPrimary,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.widgets),
        label: appBarTitles[1],
        backgroundColor: AppColors.colorPrimary,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        label: appBarTitles[2],
        backgroundColor: AppColors.colorPrimary,
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    _body = IndexedStack(
      children: <Widget>[HomeListPage(), TreePage(), MyInfoPage()],
      index: _tabIndex,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitles[_tabIndex],
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {

                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return SearchPage(searchStr: "");
                }));

              })
        ],
      ),
      body: _body,
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationViews
            .map((BottomNavigationBarItem navigationView) => navigationView)
            .toList(),
        currentIndex: _tabIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }
}
