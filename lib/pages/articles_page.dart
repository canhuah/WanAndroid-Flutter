import 'package:flutter/material.dart';
import 'package:wanAndroid/model/tree_model.dart';
import 'package:wanAndroid/pages/article_list_page.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class ArticlesPage extends StatefulWidget {
  final TreeModel treeModel;

  ArticlesPage(this.treeModel);

  @override
  State<StatefulWidget> createState() {
    return _ArticlesPageState();
  }
}

class _ArticlesPageState extends State<ArticlesPage>
    with SingleTickerProviderStateMixin {
  TabController _tabControl;
  List<Tab> tabs = List();
  List<TreeModel> list;

  @override
  void initState() {
    super.initState();

    list = widget.treeModel.children;

    for (TreeModel value in list) {
      tabs.add(Tab(text: value.name));
    }

    _tabControl = TabController(length: list.length, vsync: this);
  }

  @override
  void dispose() {
    _tabControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.treeModel.name),
        ),
        body: DefaultTabController(
          length: list.length,
          child: Scaffold(
              appBar: TabBar(
                isScrollable: true,
                controller: _tabControl,
                labelColor: Theme.of(context).accentColor,
                unselectedLabelColor: Colors.black,
                indicatorColor: Theme.of(context).accentColor,
                tabs: tabs,
              ),
              body: TabBarView(
                controller: _tabControl,
                children: list.map((treeModel) {
                  return ArticleListPage(treeModel.id.toString());
                }).toList(),
              )),
        ));
  }
}
