import 'package:flutter/material.dart';
import 'package:wanAndroid/pages/hot_page.dart';
import 'package:wanAndroid/pages/search_list_page.dart';

class SearchPage extends StatefulWidget {
  final String searchStr;

  const SearchPage({Key? key, required this.searchStr}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController(text: widget.searchStr);
  }

  void changeContent() {
    setState(() {});
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
      body: (_searchController.text.isEmpty)
          ? Center(
              child: HotPage(),
            )
          : SearchListPage(_searchController.text),
    );
  }
}
