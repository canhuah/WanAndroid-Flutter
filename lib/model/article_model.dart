import 'as_t.dart';

class ArticleListModel {
  int? curPage;
  List<ArticleModel>? datas;

  ArticleListModel({this.curPage, this.datas});

  ArticleListModel.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    if (json['datas'] != null) {
      datas = [];
      json['datas'].forEach((v) {
        datas!.add(ArticleModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curPage'] = this.curPage;
    if (this.datas != null) {
      data['datas'] = this.datas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ArticleModel {
  String? apkLink;
  int? audit;
  String? author;
  bool? canEdit;
  int? chapterId;
  String? chapterName;
  bool? collect;
  int? courseId;
  String? desc;
  String? descMd;
  String? envelopePic;
  bool? fresh;
  String? host;
  int? id;
  int? originId;
  String? link;
  String? niceDate;
  String? niceShareDate;
  String? origin;
  String? prefix;
  String? projectLink;
  int? publishTime;
  int? realSuperChapterId;
  int? selfVisible;
  int? shareDate;
  String? shareUser;
  int? superChapterId;
  String? superChapterName;

  String? title;
  int? type;
  int? userId;
  int? visible;
  int? zan;

  ArticleModel(
      {this.apkLink,
      this.audit,
      this.author,
      this.canEdit,
      this.chapterId,
      this.chapterName,
      this.collect,
      this.courseId,
      this.desc,
      this.descMd,
      this.envelopePic,
      this.fresh,
      this.host,
      this.id,
      this.originId,
      this.link,
      this.niceDate,
      this.niceShareDate,
      this.origin,
      this.prefix,
      this.projectLink,
      this.publishTime,
      this.realSuperChapterId,
      this.selfVisible,
      this.shareDate,
      this.shareUser,
      this.superChapterId,
      this.superChapterName,
      this.title,
      this.type,
      this.userId,
      this.visible,
      this.zan});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    apkLink = asT<String?>(json['apkLink']);
    audit = asT<int?>(json['audit']);
    author = asT<String?>(json['author']);
    canEdit = asT<bool?>(json['canEdit']);
    chapterId = asT<int?>(json['chapterId']);
    chapterName = asT<String?>(json['chapterName']);
    collect = asT<bool?>(json['collect']);
    courseId = asT<int?>(json['courseId']);
    desc = asT<String?>(json['desc']);
    descMd = asT<String?>(json['descMd']);
    envelopePic = asT<String?>(json['envelopePic']);
    fresh = asT<bool?>(json['fresh']);
    host = asT<String?>(json['host']);
    id = asT<int?>(json['id']);
    originId = asT<int?>(json['originId']);
    link = asT<String?>(json['link']);
    niceDate = asT<String?>(json['niceDate']);
    niceShareDate = asT<String?>(json['niceShareDate']);
    origin = asT<String?>(json['origin']);
    prefix = asT<String?>(json['prefix']);
    projectLink = asT<String?>(json['projectLink']);
    publishTime = asT<int?>(json['publishTime']);
    realSuperChapterId = asT<int?>(json['realSuperChapterId']);
    selfVisible = asT<int?>(json['selfVisible']);
    shareDate = asT<int>(json['shareDate']);
    shareUser = asT<String?>(json['shareUser']);
    superChapterId = asT<int?>(json['superChapterId']);
    superChapterName = asT<String?>(json['superChapterName']);

    title = asT<String?>(json['title']);
    type = asT<int?>(json['type']);
    userId = asT<int?>(json['userId']);
    visible = asT<int?>(json['visible']);
    zan = asT<int?>(json['zan']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['apkLink'] = this.apkLink;
    data['audit'] = this.audit;
    data['author'] = this.author;
    data['canEdit'] = this.canEdit;
    data['chapterId'] = this.chapterId;
    data['chapterName'] = this.chapterName;
    data['collect'] = this.collect;
    data['courseId'] = this.courseId;
    data['desc'] = this.desc;
    data['descMd'] = this.descMd;
    data['envelopePic'] = this.envelopePic;
    data['fresh'] = this.fresh;
    data['host'] = this.host;
    data['id'] = this.id;
    data['originId'] = this.originId;
    data['link'] = this.link;
    data['niceDate'] = this.niceDate;
    data['niceShareDate'] = this.niceShareDate;
    data['origin'] = this.origin;
    data['prefix'] = this.prefix;
    data['projectLink'] = this.projectLink;
    data['publishTime'] = this.publishTime;
    data['realSuperChapterId'] = this.realSuperChapterId;
    data['selfVisible'] = this.selfVisible;
    data['shareDate'] = this.shareDate;
    data['shareUser'] = this.shareUser;
    data['superChapterId'] = this.superChapterId;
    data['superChapterName'] = this.superChapterName;

    data['title'] = this.title;
    data['type'] = this.type;
    data['userId'] = this.userId;
    data['visible'] = this.visible;
    data['zan'] = this.zan;
    return data;
  }
}
