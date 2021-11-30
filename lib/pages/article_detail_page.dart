
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
//文章详情界面
class ArticleDetailPage extends StatefulWidget {
  final String title;
  final String url;

  ArticleDetailPage({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ArticleDetailPageState();
  }
}

class ArticleDetailPageState extends State<ArticleDetailPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    body: Container(
      color: Colors.white,
      child: WebView(
        initialUrl: widget.url,
        //JS执行模式 是否允许JS执行
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (String url) {

        },
        onPageFinished: (String url) {

        },
        onWebResourceError: (error) {

        },

        navigationDelegate: (NavigationRequest request) {
          ///拦截了简书文章里乱七八糟的跳转
          if (request.url.startsWith('http:') ||
              request.url.startsWith('https:')) {

            return NavigationDecision.navigate;
          }
          return NavigationDecision.prevent;
        },

        gestureNavigationEnabled: true,
      ),
    ),
    );
  }
}
