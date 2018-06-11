class Api {

  static const String BaseUrl = "http://www.wanandroid.com/";

  //首页banner
  static const   String BANNER = "banner/json";
  //首页文章列表 http://www.wanandroid.com/article/list/0/json
  // 知识体系下的文章http://www.wanandroid.com/article/list/0/json?cid=60
  static const   String ARTICLE_LIST = "article/list/";

  //收藏文章列表
  static const   String COLLECT_LIST = "lg/collect/list/";

  //搜索
  static const   String ARTICLE_QUERY = "article/query/";

  //收藏,取消收藏
  static const   String COLLECT = "lg/collect/";
  static const   String UNCOLLECT_ORIGINID = "lg/uncollect_originId/";
  //我的收藏列表中取消收藏
  static const   String UNCOLLECT_LIST = "lg/uncollect/";

  //登录,注册
  static const   String LOGIN = "user/login";
  static const   String REGISTER = "user/register";

  //知识体系
  static const   String TREE = "tree/json";

  //常用网站
  static const   String FRIEND = "friend/json";
  //搜索热词
  static const   String HOTKEY = "hotkey/json";



}
