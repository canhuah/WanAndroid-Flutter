import 'package:flutter/material.dart';
import 'package:wanAndroid/http/api.dart';
import 'package:wanAndroid/http/http_util_with_cookie.dart';
import 'package:wanAndroid/model/tree_model.dart';
import 'package:wanAndroid/pages/articles_page.dart';

//知识体系
class TreePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TreePageState();
  }
}

class TreePageState extends State<TreePage> {
  List<TreeModel> treeList;

  @override
  void initState() {
    super.initState();
    _getTree();
  }

  @override
  Widget build(BuildContext context) {
    if (treeList == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      Widget listView = ListView.builder(
        itemCount: treeList.length,
        itemBuilder: (context, i) => TreeCell(treeModel: treeList[i]),
      );

      return listView;
    }
  }

  _getTree() async {
    HttpUtil.get(Api.TREE, (data) {
      List list = data;

      treeList = list.map((element) {
        return TreeModel.fromJson(element);
      }).toList();

      setState(() {});
    });
  }
}

class TreeCell extends StatelessWidget {
  final TreeModel treeModel;

  const TreeCell({Key key, this.treeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Text name = Text(
      treeModel.name ?? "",
      softWrap: true,
      style: TextStyle(
          fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
      textAlign: TextAlign.left,
    );

    List<TreeModel> list = treeModel.children ?? [];

    String strContent = '';

    for (TreeModel value in list) {
      strContent += '${value.name}   ';
    }

    Text content = Text(
      strContent,
      softWrap: true,
      style: TextStyle(color: Colors.black),
      textAlign: TextAlign.left,
    );

    return InkWell(
      onTap: () {
        _handOnItemClick(context);
      },
      child: Container(
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: name,
                  ),
                  content,
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  void _handOnItemClick(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ArticlesPage(treeModel);
    }));
  }
}
