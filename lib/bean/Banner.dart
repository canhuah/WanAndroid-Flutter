class BannerBean{

 String desc;
 String id;
 String imagePath;
 int isVisible;
 String order;
 String title;
 String type;
 String url;


 @override
 String toString() {
  return 'BannerBean{desc: $desc, id: $id, imagePath: $imagePath, isVisible: $isVisible, order: $order, title: $title, type: $type, url: $url}';
 }

}