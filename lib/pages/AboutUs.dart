import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new AboutUsPageState();
  }
}

class AboutUsPageState extends State<AboutUsPage>{


  List<String> list = new List();


  @override
  void initState() {

    super.initState();

    list.add('本网站每天新增20~30篇优质文章，并加入到现有分类中');
    list.add('力求整理出一份优质而又详尽的知识体系，闲暇时间不妨上来学习下知识；');
    list.add('除此以外，并为大家提供平时开发过程中常用的工具以及常用的网址导航。');

    list.add('当然这只是我们目前的功能，未来我们将提供更多更加便捷的功能...');
    list.add('如果您有任何好的建议:');
    list.add('关于网站排版关于新增常用网址以及工具未来你希望增加的功能等');
    list.add('可以在https://github.com/hongyangAndroid/xueandroid项目中以issue的形式提出，我将及时跟进。');
    list.add('如果您希望长期关注本站，可以加入我们的QQ群：591683946');
  }

  @override
  Widget build(BuildContext context) {

  
    Icon icon = new Icon(Icons.android,
      color: Colors.blue,
      size: 60.0,
    );

    Widget renderRow(i) {
      if(i==0){
        return icon;
      }
      i-=1;

      return new Text(list[i],maxLines: 3,);

    }



    return new Scaffold(

      body:  new ListView.builder(
    itemCount: list.length +1,
      itemBuilder: (context, i) => renderRow(i),

      )
    );


  }
}