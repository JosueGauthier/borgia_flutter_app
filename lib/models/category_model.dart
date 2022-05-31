import 'package:borgiaflutterapp/models/product_model.dart';

class CategoryModel {
  int? id;
  String? name;
  int? moduleId;
  String? categoryImage;
  int? shopId;
  List<ProductModel>? products;

  CategoryModel({this.id, this.name, this.moduleId, this.categoryImage, this.shopId, this.products});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    moduleId = json['module_id'];
    categoryImage = json['category_image'];
    shopId = json['shop_id'];
    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((v) {
        products!.add(ProductModel.fromJson(v));
      });
    }
  }
}
/* 
class ProductsModel {
  int? id;
  String? name;
  String? unit;
  int? shop;
  bool? isManual;
  double? manualPrice;
  int? correctingFactor;
  bool? isActive;
  bool? isRemoved;
  String? productImage;
  int? categoryWhereProductIs;
  int? moduleIdWhereProductIs;

  ProductsModel(
      {this.id,
      this.name,
      this.unit,
      this.shop,
      this.isManual,
      this.manualPrice,
      this.correctingFactor,
      this.isActive,
      this.isRemoved,
      this.productImage,
      this.categoryWhereProductIs,
      this.moduleIdWhereProductIs});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    unit = json['unit'];
    shop = json['shop'];
    isManual = json['is_manual'];
    manualPrice = json['manual_price'];
    correctingFactor = json['correcting_factor'];
    isActive = json['is_active'];
    isRemoved = json['is_removed'];
    productImage = json['product_image'];
    categoryWhereProductIs = json['category_where_product_is'];
    moduleIdWhereProductIs = json['module_id_where_product_is'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['unit'] = unit;
    data['shop'] = shop;
    data['is_manual'] = isManual;
    data['manual_price'] = manualPrice;
    data['correcting_factor'] = correctingFactor;
    data['is_active'] = isActive;
    data['is_removed'] = isRemoved;
    data['product_image'] = productImage;
    data['category_where_product_is'] = categoryWhereProductIs;
    data['module_id_where_product_is'] = moduleIdWhereProductIs;
    return data;
  }
}
 */