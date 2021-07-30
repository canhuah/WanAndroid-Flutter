class FriendModel {
  String category;
  String icon;
  int id;
  String link;
  String name;
  int order;
  int visible;

  FriendModel(
      {this.category,
        this.icon,
        this.id,
        this.link,
        this.name,
        this.order,
        this.visible});

  FriendModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    icon = json['icon'];
    id = json['id'];
    link = json['link'];
    name = json['name'];
    order = json['order'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['link'] = this.link;
    data['name'] = this.name;
    data['order'] = this.order;
    data['visible'] = this.visible;
    return data;
  }
}
