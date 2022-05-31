class CategoryOfShopModel {
  int? id;
  String? name;
  int? moduleId;
  List<String>? products;
  int? order;
  String? image;
  int? shopId;

  CategoryOfShopModel({
    this.id,
    this.name,
    this.moduleId,
    this.products,
    this.order,
    this.image,
    this.shopId,
  });

  CategoryOfShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    moduleId = json['module_id'];
    products = json['products'].cast<String>();
    order = json['order'];
    image = json['category_image'];
    shopId = json['shop_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['module_id'] = moduleId;
    data['products'] = products;
    data['order'] = order;
    data['category_image'] = image;
    data['shop_id'] = shopId;
    return data;
  }
}
