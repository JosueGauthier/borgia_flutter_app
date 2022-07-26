class CategoryModel {
  int? id;
  String? name;
  int? moduleId;
  List<int>? products;
  int? order;
  String? image;
  int? shopId;
  ContentType? contentType;

  CategoryModel({this.id, this.name, this.moduleId, this.products, this.order, this.image, this.shopId, this.contentType});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    moduleId = json['module_id'];
    products = json['products'].cast<int>();
    order = json['order'];
    image = json['category_image'];
    shopId = json['shop_id'];
    contentType = json['content_type'] != null ? ContentType.fromJson(json['content_type']) : null;
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
    if (contentType != null) {
      data['content_type'] = contentType!.toJson();
    }
    return data;
  }
}

class ContentType {
  int? id;
  String? appLabel;
  String? model;

  ContentType({this.id, this.appLabel, this.model});

  ContentType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appLabel = json['app_label'];
    model = json['model'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['app_label'] = appLabel;
    data['model'] = model;
    return data;
  }
}
