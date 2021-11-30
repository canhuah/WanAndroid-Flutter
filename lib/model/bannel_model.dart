//JsonToDart 生成
import 'as_t.dart';

class BannerModel {
  String? desc;
  int? id;
  String? imagePath;
  int? isVisible;
  int? order;
  String? title;
  int? type;
  String? url;

  BannerModel(
      {this.desc,
        this.id,
        this.imagePath,
        this.isVisible,
        this.order,
        this.title,
        this.type,
        this.url});

  BannerModel.fromJson(Map<String, dynamic> json) {
    desc = asT<String?>(json['desc']);
    id = asT<int?>(json['id']);
    imagePath = asT<String?>(json['imagePath']);
    isVisible = asT<int?>(json['isVisible']);
    order = asT<int?>(json['order']);
    title = asT<String?>(json['title']);
    type = asT<int?>(json['type']);
    url = asT<String?>(json['url']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this.desc;
    data['id'] = this.id;
    data['imagePath'] = this.imagePath;
    data['isVisible'] = this.isVisible;
    data['order'] = this.order;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}
