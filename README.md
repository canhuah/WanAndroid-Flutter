# WanAndroid客户端Flutter版本


## 前言
被张鸿洋微信公众号推荐为优质Flutter开源项目啦   

[推荐几个优质Flutter 开源项目](https://mp.weixin.qq.com/s/1pIPymEHbRY0qktBuCJALA)


可以扫码(使用浏览器扫码,不要使用qq或者微信)直接下载Release版本APK文件体验一下流畅度


![二维码](https://www.pgyer.com/app/qrcode/wanandroid)

<!--more-->
##  项目截图


<div>
    <img src='http://ohwdtc40j.bkt.clouddn.com/canhuah_flutter_wanandriod_home.webp' width=320>
    <img src='http://ohwdtc40j.bkt.clouddn.com/canhuah_flutter_wanandriod_find.webp' width=320>
</div>
<div>
    <img src='http://ohwdtc40j.bkt.clouddn.com/canhuah_flutter_wanandriod_tree.webp' width=320>
    <img src='http://ohwdtc40j.bkt.clouddn.com/canhuah_flutter_wanandriod_webdetail.webp' width=320>
</div>
<div>
    <img src='http://ohwdtc40j.bkt.clouddn.com/canhuah_flutter_wanandriod_hot.webp' width=320>
    <img src='http://ohwdtc40j.bkt.clouddn.com/canhuah_flutter_wanandriod_search.webp' width=320>
</div>
<div>
    <img src='http://ohwdtc40j.bkt.clouddn.com/canhuah_flutter_wanandriod_collect.webp' width=320>
    <img src='http://ohwdtc40j.bkt.clouddn.com/canhuah_flutter_wanandriod_about.webp' width=320>
</div>



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
  - [Flutter网络请求之简单封装](http://www.canhuah.com/Flutter%E7%BD%91%E7%BB%9C%E8%AF%B7%E6%B1%82%E4%B9%8B%E7%AE%80%E5%8D%95%E5%B0%81%E8%A3%85.html)及cookie的添加



可以看到整个项目相对还是非常简单的，希望能帮到更多的人

##  项目中碰到并解决的问题

- 这个问题比较多，单独写了一篇博客

  [Flutter实战之WanAndroid项目中碰到的问题](http://www.canhuah.com/Flutter%E5%AE%9E%E6%88%98%E4%B9%8BWanAndroid%E9%A1%B9%E7%9B%AE%E4%B8%AD%E7%A2%B0%E5%88%B0%E7%9A%84%E9%97%AE%E9%A2%98.html)


## 待解决的问题

- 键盘遮挡
- 下拉刷新，上拉加载更多的统一封装
- 加载中、空数据、错误数据的界面的统一处理
- 简单动画的使用(正在学习..)

## 学习资料
- 官方的 [Flutter官方地址](https://flutter.io/get-started/install/)
- 国内翻译版本 [Flutter中文网](https://flutterchina.club/)
- 阿里闲鱼技术微信公众号(搜索 '闲鱼技术')

官方的Demo及各个Widget的效果在安装了Flutter SDK之后在  Flutter SDK安装目录/flutter/examples下，可以自己一一尝试。

我的博客 [canhuah的博客](http://www.canhuah.com)
