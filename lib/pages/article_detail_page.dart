import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

//文章详情界面
class ArticleDetailPage extends StatefulWidget {
  final String title;
  final String url;

  ArticleDetailPage({
    Key key,
    @required this.title,
    @required this.url,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ArticleDetailPageState();
  }
}

class ArticleDetailPageState extends State<ArticleDetailPage> {
//  bool isLoad = true;
//
//  final flutterWebViewPlugin = FlutterWebviewPlugin();
//
//  @override
//  void initState() {
//    super.initState();
//    flutterWebViewPlugin.onStateChanged.listen((state) {
//      debugPrint('state:_' + state.type.toString());
//      if (state.type == WebViewState.finishLoad) {
//        // 加载完成
//        setState(() {
//
//        });
//      } else if (state.type == WebViewState.startLoad) {
//        setState(() {
//
//        });
//      }
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}
