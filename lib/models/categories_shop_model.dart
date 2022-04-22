class CategoryOfShopModel {
  int? id;
  String? name;
  int? moduleId;
  List<String>? products;
  int? order;
  String? categoryImage;

  CategoryOfShopModel({this.id, this.name, this.moduleId, this.products, this.order, this.categoryImage});

  CategoryOfShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    moduleId = json['module_id'];
    products = json['products'].cast<String>();
    order = json['order'];
    categoryImage = json['category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['module_id'] = this.moduleId;
    data['products'] = this.products;
    data['order'] = this.order;
    data['category_image'] = this.categoryImage;
    return data;
  }
}