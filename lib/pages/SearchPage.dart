import 'package:flutter/material.dart';
import 'package:wanAndroid/pages/HotPage.dart';
import 'package:wanAndroid/pages/SearchListPage.dart';

class SearchPage extends StatefulWidget {

  String searchStr;

  SearchPage(this.searchStr);

  @override
  State<StatefulWidget> createState() {
    return new SearchPageState(searchStr);
  }
}

class SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = new TextEditingController();

  SearchListPage _searchListPage;
  String searchStr ;
  SearchPageState(this.searchStr);

  @override
  void initState() {
    super.initState();

    _searchController = new TextEditingController(text: searchStr);
    changeContent();
  }



  void changeContent(){
    setState(() {
        _searchListPage = new SearchListPage(new ValueKey(_searchController.text));
    });
   }
  @override
  Widget build(BuildContext context) {
    TextField searchField = new TextField(
      autofocus: true,
      decoration: new InputDecoration(
        border: InputBorder.none,
        hintText: '搜索关键词',
      ),
      controller: _searchController,
    );




    return new Scaffold(
      appBar: new AppBar(
        title: searchField,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {
                changeContent();
              }),
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _searchController.clear();
                });

              }),
        ],
      ),
      body: (_searchController.text==null||_searchController.text.isEmpty)?new Center(
        child:new  HotPage(),
      ):_searchListPage,

    );
  }
}


