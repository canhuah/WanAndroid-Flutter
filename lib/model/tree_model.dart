import 'as_t.dart';

class TreeModel {
  List<TreeModel>? children;
  int? courseId;
  int? id;
  String? name;
  int? order;
  int? parentChapterId;
  bool? userControlSetTop;
  int? visible;

  TreeModel(
      {this.children,
      this.courseId,
      this.id,
      this.name,
      this.order,
      this.parentChapterId,
      this.userControlSetTop,
      this.visible});

  TreeModel.fromJson(Map<String, dynamic> json) {
    if (json['children'] != null) {
      children = [];
      json['children'].forEach((v) {
        children!.add(TreeModel.fromJson(v));
      });
    }
    courseId = asT<int?>(json['courseId']);
    id = asT<int?>(json['id']);
    name = asT<String?>(json['name']);
    order = asT<int?>(json['order']);
    parentChapterId = asT<int?>(json['parentChapterId']);
    userControlSetTop = asT<bool?>(json['userControlSetTop']);
    visible = asT<int?>(json['visible']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    data['courseId'] = this.courseId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['order'] = this.order;
    data['parentChapterId'] = this.parentChapterId;
    data['userControlSetTop'] = this.userControlSetTop;
    data['visible'] = this.visible;
    return data;
  }
}
