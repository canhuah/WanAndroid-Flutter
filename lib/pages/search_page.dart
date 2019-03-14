import 'package:flutter/material.dart';
import 'package:wanAndroid/pages/hot_page.dart';
import 'package:wanAndroid/pages/search_list_page.dart';

class SearchPage extends StatefulWidget {
  String searchStr;

  SearchPage(this.searchStr);

  @override
  State<StatefulWidget> createState() {
    return SearchPageState(searchStr);
  }
}

class SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  SearchListPage _searchListPage;
  String searchStr;

  SearchPageState(this.searchStr);

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController(text: searchStr);
    changeContent();
  }

  void changeContent() {
    setState(() {
      _searchListPage = SearchListPage(ValueKey(_searchController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    TextField searchField = TextField(
      autofocus: true,
      textInputAction: TextInputAction.search,
      onSubmitted: (string) {
        changeContent();
      },
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '搜索关键词',
          hintStyle: TextStyle(color: Colors.white)),
      controller: _searchController,
    );

    return Scaffold(
      appBar: AppBar(
        title: searchField,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                changeContent();
              }),
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _searchController.clear();
                });
              }),
        ],
      ),
      body: (_searchController.text == null || _searchController.text.isEmpty)
          ? Center(
              child: HotPage(),
            )
          : _searchListPage,
    );
  }
}
