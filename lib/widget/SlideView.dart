import 'package:flutter/material.dart';

class SlideView extends StatefulWidget {
  var data;

  SlideView(data) {
    this.data = data;
  }

  @override
  State<StatefulWidget> createState() {
    return new SlideViewState(data);
  }
}

class SlideViewState extends State<SlideView>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  List slideData;

  SlideViewState(data) {
    slideData = data;
  }

  @override
  void initState() {
    super.initState();
    tabController = new TabController(
        length: slideData == null ? 0 : slideData.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    if (slideData != null && slideData.length > 0) {
      for (var i = 0; i < slideData.length; i++) {
        var item = slideData[i];
        var imgUrl = item['imagePath'];
        var title = item['title'];
        var detailUrl = item['url'];
        items.add(new GestureDetector(
            onTap: () {
              // 点击跳转到详情
              //todo
//            Navigator.of(context).push(new MaterialPageRoute(
//                builder: (ctx) => new NewsDetailPage(id: detailUrl)
//            ));
            },
            child: AspectRatio(
              aspectRatio: 3.0 / 1.5,
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
}
