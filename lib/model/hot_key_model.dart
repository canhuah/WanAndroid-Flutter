
import 'as_t.dart';

class HotKeyModel {
  int? id;
  String? link;
  String? name;
  int? order;
  int? visible;

  HotKeyModel({this.id, this.link, this.name, this.order, this.visible});

  HotKeyModel.fromJson(Map<String, dynamic> json) {
    id = asT<int?>(json['id']);
    link = asT<String?>(json['link']);
    name = asT<String?>(json['name']);
    order = asT<int?>(json['order']);
    visible = asT<int?>(json['visible']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['link'] = this.link;
    data['name'] = this.name;
    data['order'] = this.order;
    data['visible'] = this.visible;
    return data;
  }
}
