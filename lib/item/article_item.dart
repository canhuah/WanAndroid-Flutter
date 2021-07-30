import 'package:flutter/material.dart';
import 'package:wanAndroid/constant/app_colors.dart';
import 'package:wanAndroid/http/api.dart';
import 'package:wanAndroid/http/http_util_with_cookie.dart';
import 'package:wanAndroid/model/article_model.dart';
import 'package:wanAndroid/pages/article_detail_page.dart';
import 'package:wanAndroid/pages/login_page.dart';
import 'package:wanAndroid/util/DataUtils.dart';
import 'package:wanAndroid/util/StringUtils.dart';

///个人感觉条目比较复杂的话可以单独拿出来,而且可以复用.可以对比CollectListPage.dart中的item哪个更合理
class ArticleCell extends StatefulWidget {
  final ArticleModel articleModel;

  //是否来自搜索列表
  final bool isSearch;

  final bool isFromCollect;

  final Function onClickCollect;

  //搜索列表的id
  final String id;

  ArticleCell(
      {this.articleModel,
      this.isSearch = false,
      this.id,
      this.isFromCollect = false,
      this.onClickCollect});

  @override
  State<StatefulWidget> createState() {
    return _ArticleCellState();
  }
}

class _ArticleCellState extends State<ArticleCell> {
  void _handleOnItemCollect(itemData) {
    DataUtils.isLogin().then((isLogin) {
      if (!isLogin) {
        _login();
      } else {
        _itemCollect(itemData);
      }
    });
  }

  _login() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }

  void _itemClick(ArticleModel articleModel) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ArticleDetailPage(
        title: articleModel.title,
        url: articleModel.link,
      );
    }));
  }

  //收藏/取消收藏
  void _itemCollect(ArticleModel articleModel) {
    String url;
    if (articleModel.collect) {
      url = Api.UNCOLLECT_ORIGINID;
    } else {
      url = Api.COLLECT;
    }
    url += '${articleModel.id}/json';
    HttpUtil.post(url, (data) {
      setState(() {
        articleModel.collect = !articleModel.collect;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isCollect = widget.isFromCollect || widget.articleModel.collect;

    String authorTitle;
    String author;

    if (widget.articleModel.author == null ||
        widget.articleModel.author.isEmpty) {
      authorTitle = "分享人: ";
      author = widget.articleModel.shareUser;
    } else {
      authorTitle = "作者: ";
      author = widget.articleModel.author;
    }

    Row row = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Text("$authorTitle$author",
                style:
                    TextStyle(color: AppColors.colorTextAuthor, fontSize: 13))),
        Text(
          widget.articleModel.niceDate,
          style: TextStyle(color: AppColors.colorTextAuthor, fontSize: 13),
        )
      ],
    );

    Row title = Row(
      children: <Widget>[
        Expanded(
          child: Text.rich(
            widget.isSearch
                ? StringUtils.getTextSpan(widget.articleModel.title, widget.id)
                : TextSpan(text: widget.articleModel.title),
            softWrap: true,
            style: TextStyle(fontSize: 16.0, color: AppColors.colorTextTitle),
            textAlign: TextAlign.left,
          ),
        )
      ],
    );

    Row chapterName = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 4, right: 4, top: 1, bottom: 2),
          decoration: BoxDecoration(
              color: AppColors.colorCBCBD4,
              borderRadius: BorderRadius.circular(2)),
          child: Text(
            widget.isSearch ? '' : widget.articleModel.chapterName,
            softWrap: true,
            style: TextStyle(color: AppColors.colorTextAuthor, fontSize: 12),
            textAlign: TextAlign.left,
          ),
        ),
        GestureDetector(
          child: Icon(
            isCollect ? Icons.favorite : Icons.favorite_border,
            color: isCollect ? Colors.red : null,
          ),
          onTap: () {
            if (widget.onClickCollect != null) {
              widget.onClickCollect.call();
              return;
            }
            _handleOnItemCollect(widget.articleModel);
          },
        )
      ],
    );

    Column column = Column(
      children: <Widget>[
        title,
        SizedBox(height: 5),
        row,
        SizedBox(height: 5),
        chapterName,
      ],
    );

    return InkWell(
      onTap: () {
        _itemClick(widget.articleModel);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        margin: EdgeInsets.all(4),
        child: column,
      ),
    );
  }
}
