# WanAndroid客户端Flutter版本

## 前言

谷歌在今年的I/O大会提了Flutter，觉得有可能是一个趋势。 在学习了基本的Dart语法以及Flutter常用Widget的基本使用之后就开始慢慢按捺不住了，决定模仿[Flutter版的开源中国](https://github.com/yubo725/FlutterOSC)写一个WanAndroid客户端。


## 项目地址

[**github地址** ](https://github.com/canhuah/WanAndroid)

喜欢的话可以给个星鼓励一下，也可以进 项目/android/apk-release.apk直接下载Release版本体验一下流畅度

<!--more-->
##  项目截图


![首页](http://ohwdtc40j.bkt.clouddn.com/canhuah_flutter_wanandriod_home.webp)



![发行](http://ohwdtc40j.bkt.clouddn.com/canhuah_flutter_wanandriod_find.webp)

![体系](http://ohwdtc40j.bkt.clouddn.com/canhuah_flutter_wanandriod_tree.webp)

![详情](http://ohwdtc40j.bkt.clouddn.com/canhuah_flutter_wanandriod_webdetail.webp)

![热门](http://ohwdtc40j.bkt.clouddn.com/canhuah_flutter_wanandriod_hot.webp)

![搜索](http://ohwdtc40j.bkt.clouddn.com/canhuah_flutter_wanandriod_search.webp)

![收藏](http://ohwdtc40j.bkt.clouddn.com/canhuah_flutter_wanandriod_collect.webp)

![关于](http://ohwdtc40j.bkt.clouddn.com/canhuah_flutter_wanandriod_about.webp)


## 项目地址

[**github地址** ](https://github.com/canhuah/WanAndroid)

喜欢的话可以给个星鼓励一下，也可以进 项目/android/apk-release.apk直接下载Release版本体验一下流畅度

## 知识点

- WanAndroidPage.dart
  -  BottomNavigationBar的基本使用
  -  Navigator的简单使用
- HomePageList.dart
  - 上拉加载更多
  - 添加头布局(SlideView)
- HotePage.dart
  - 热门和搜索列表的切换
- ArticlePage.dart
  - TabBarView的基本使用
- ArticleDetailPage.dart
  - 插件flutter_webview_plugin的使用
- SearchPage.dart
  - Widget构造函数中key的意义
- ArticleItem.dart
  - Dart的普通构造及命名构造函数
- HttpUtil.dart
  - [Flutter网络请求之简单封](http://www.canhuah.com/Flutter%E7%BD%91%E7%BB%9C%E8%AF%B7%E6%B1%82%E4%B9%8B%E7%AE%80%E5%8D%95%E5%B0%81%E8%A3%85.html)及cookie的添加



可以看到整个项目相对还是非常简单的

##  项目中碰到并解决的问题

- 这个问题比较多，会在下一篇博客中一一说明

## 待解决的问题

- 键盘遮挡
- 下拉刷新，上拉加载更多的统一封装
- 加载中、空数据、错误数据的界面的统一处理


##  学习资料
- 官方的 [Flutter官方地址](https://flutter.io/get-started/install/)
- 国内翻译版本 [Flutter中文网](https://flutter.io/get-started/install/)
- 阿里闲鱼技术微信公众号(搜索 '闲鱼技术')

官方的Demo及各个Widget的效果在安装了Flutter SDK之后在  Flutter SDK安装目录/flutter/examples下，可以自己一一尝试。