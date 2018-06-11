import 'package:flutter/material.dart';
import 'package:wanAndroid/pages/ArticleListPage.dart';


class ArticlesPage extends StatefulWidget{
  var data;
  @override
  State<StatefulWidget> createState() {
    return new ArticlesPageState();
  }

  ArticlesPage(this.data);

}

class ArticlesPageState extends State<ArticlesPage> with SingleTickerProviderStateMixin{

  TabController _tabContro;
  List<Tab> tabs = new List();
  List<dynamic>  list;


  @override
  void initState() {
    super.initState();

    list = widget.data['children'];

    for (var value in list) {
      tabs.add(new Tab(text: value['name']));
    }

    _tabContro = new TabController(length: list.length, vsync: this);

  }
  @override
  void dispose() {
    _tabContro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.data['name']),
      ),

      body:  new DefaultTabController(
      length: list.length,
      child: new Scaffold(
          appBar: new TabBar(

            isScrollable: true,
            controller: _tabContro,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.blue,
            tabs: tabs,
          ),
          body: new TabBarView(
            controller: _tabContro,
//            controller: _tabContro,
            children: list.map((dynamic itemData){
              return new ArticleListPage(itemData['id'].toString());
            }).toList(),
          )),
    )
    );
  }
}