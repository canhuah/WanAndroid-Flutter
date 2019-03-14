import 'package:flutter/material.dart';
import 'package:wanAndroid/pages/article_detail_page.dart';

class SlideView extends StatefulWidget {
  var data;

  SlideView(this.data);

  @override
  State<StatefulWidget> createState() {
    return new SlideViewState(data);
  }
}

class SlideViewState extends State<SlideView>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  List data;

  SlideViewState(this.data);

  @override
  void initState() {
    super.initState();
    tabController =
        new TabController(length: data == null ? 0 : data.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    if (data != null && data.length > 0) {
      for (var i = 0; i < data.length; i++) {
        var item = data[i];
        var imgUrl = item['imagePath'];
        var title = item['title'];
        item['link'] = item['url'];
        items.add(new GestureDetector(
            onTap: () {
              _handOnItemClick(item);
            },
            child: AspectRatio(
              aspectRatio: 2.0 / 1.0,
              child: new Stack(
                children: <Widget>[
                  new Image.network(
                    imgUrl,
                    fit: BoxFit.cover,
                    width: 1000.0,
                  ),
                  new Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: new Container(
                      width: 1000.0,
                      color: const Color(0x50000000),
                      padding: const EdgeInsets.all(5.0),
                      child: new Text(title,
                          style: new TextStyle(
                              color: Colors.white, fontSize: 15.0)),
                    ),
                  ),
                ],
              ),
            )));
      }
    }
    return new TabBarView(
      controller: tabController,
      children: items,
    );
  }

  void _handOnItemClick(itemData) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new ArticleDetailPage(title:itemData['title'],url: itemData['link']);
    }));
  }
}
