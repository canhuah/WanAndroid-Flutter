//https://jsontodart.com 生成
class HotKeyModel {
  int id;
  String link;
  String name;
  int order;
  int visible;

  HotKeyModel({this.id, this.link, this.name, this.order, this.visible});

  HotKeyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    name = json['name'];
    order = json['order'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['link'] = this.link;
    data['name'] = this.name;
    data['order'] = this.order;
    data['visible'] = this.visible;
    return data;
  }
}
