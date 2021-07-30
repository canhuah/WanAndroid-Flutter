import 'package:flutter/material.dart';
import 'package:wanAndroid/model/bannel_model.dart';
import 'package:wanAndroid/pages/article_detail_page.dart';

class SlideView extends StatefulWidget {
  final List<BannerModel> list;

  SlideView(this.list);

  @override
  State<StatefulWidget> createState() {
    return _SlideViewState();
  }
}

class _SlideViewState extends State<SlideView>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = new TabController(
        length: widget.list == null ? 0 : widget.list.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    if (widget.list != null && widget.list.length > 0) {
      for (var i = 0; i < widget.list.length; i++) {
        BannerModel item = widget.list[i];
        String imgUrl = item.imagePath;
        String title = item.title;
        items.add(GestureDetector(
            onTap: () {
              _handOnItemClick(item);
            },
            child: AspectRatio(
              aspectRatio: 2.0 / 1.0,
              child: new Stack(
                children: <Widget>[
                  new Image.network(
                    imgUrl,
                    fit: BoxFit.fill,
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
    return TabBarView(
      controller: tabController,
      children: items,
    );
  }

  void _handOnItemClick(BannerModel bannerModel) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return ArticleDetailPage(title: bannerModel.title, url: bannerModel.url);
    }));
  }
}
