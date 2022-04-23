class CategoryOfShopModel {
  int? id;
  String? name;
  int? moduleId;
  List<String>? products;
  int? order;
  String? categoryImage;
  int? shopId;

  CategoryOfShopModel({this.id, this.name, this.moduleId, this.products, this.order, this.categoryImage, this.shopId});

  CategoryOfShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    moduleId = json['module_id'];
    products = json['products'].cast<String>();
    order = json['order'];
    categoryImage = json['category_image'];
    shopId = json['shop_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['module_id'] = this.moduleId;
    data['products'] = this.products;
    data['order'] = this.order;
    data['category_image'] = this.categoryImage;
    data['shop_id'] = this.shopId;
    return data;
  }
}
