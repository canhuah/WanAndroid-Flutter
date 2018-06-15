import 'package:flutter/material.dart';
import 'package:wanAndroid/http/Api.dart';
import 'package:wanAndroid/http/HttpUtilWithCookie.dart';
import 'package:wanAndroid/pages/ArticlesPage.dart';


//知识体系
class TreePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TreePageState();
  }
}

class TreePageState extends State<TreePage> {
  var listData;

  @override
  void initState() {
    super.initState();
    _getTree();
  }


  @override
  Widget build(BuildContext context) {
    if (listData == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
        itemCount: listData.length,
        itemBuilder: (context, i) => buildItem(i),
      );

      return listView;
    }
  }

  _getTree() async {
    HttpUtil.get(Api.TREE, (data) {
      setState(() {
        listData = data;
      });
    });
  }

  Widget buildItem(i) {
    var itemData = listData[i];

    Text name = new Text(
      itemData['name'],
      softWrap: true,
      style: new TextStyle(
          fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
      textAlign: TextAlign.left,
    );

    List list = itemData['children'];

    String strContent = '';

    for (var value in list) {
      strContent +='${value["name"]}   ';
    }

    Text content = new Text(
      strContent,
      softWrap: true,
      style: new TextStyle(color: Colors.black),
      textAlign: TextAlign.left,
    );



    return new Card(
      elevation: 4.0,
      child: new InkWell(
        onTap: () {
          _handOnItemClick(itemData);
        },

        child: new Container(
          padding: EdgeInsets.all(15.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: name,
                    ),
                    content,
                  ],
                ),
              ),
              new Icon(
                Icons.chevron_right,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handOnItemClick(itemData) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new ArticlesPage(itemData);
    }));
  }
}
