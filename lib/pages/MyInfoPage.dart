import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wanAndroid/bean/Banner.dart';

import 'package:wanAndroid/http/Api.dart';
import 'package:wanAndroid/http/HttpUtil.dart';
import 'package:dio/dio.dart';
class MyInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyInfoPageState();
  }
}

class MyInfoPageState extends State<MyInfoPage> {
  var userName;

  getBanner() async {
//   Response res = await HttpUtil.get(Api.BANNER);
   HttpUtil.get(Api.BANNER, (data){
     List banners = data;

     for(var i=0;i<banners.length;i++){

       print(banners[i]);
     }

   });



  }

  @override
  void initState() {
    super.initState();
//    getBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new MaterialButton(
          child: new Text(userName == null ? "a" : userName),
//          onPressed: getBanner
      ),
    );
  }
}

