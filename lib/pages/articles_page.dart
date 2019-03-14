import 'package:flutter/material.dart';
import 'package:wanAndroid/pages/article_list_page.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class ArticlesPage extends StatefulWidget {
  final data;

  ArticlesPage(this.data);

  @override
  State<StatefulWidget> createState() {
    return ArticlesPageState();
  }

//  ArticlesPage(this.data);
}

class ArticlesPageState extends State<ArticlesPage>
    with SingleTickerProviderStateMixin {
  TabController _tabContro;
  List<Tab> tabs = List();
  List<dynamic> list;

  @override
  void initState() {
    super.initState();

    list = widget.data['children'];

    for (var value in list) {
      tabs.add(Tab(text: value['name']));
    }

    _tabContro = TabController(length: list.length, vsync: this);
  }

  @override
  void dispose() {
    _tabContro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.data['name']),
        ),
        body: DefaultTabController(
          length: list.length,
          child: Scaffold(
              appBar: TabBar(
                isScrollable: true,
                controller: _tabContro,
                labelColor: Theme.of(context).accentColor,
                unselectedLabelColor: Colors.black,
                indicatorColor: Theme.of(context).accentColor,
                tabs: tabs,
              ),
              body: TabBarView(
                controller: _tabContro,
//            controller: _tabContro,
                children: list.map((dynamic itemData) {
                  return ArticleListPage(itemData['id'].toString());
                }).toList(),
              )),
        ));
  }
}
