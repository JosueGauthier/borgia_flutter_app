/* class CreateCategoryModel {
  String username;
  String password;
  String productName;
  bool priceIsManual;
  double manualPrice;
  int shopId;
  bool isActive;
  double correctingFactor;
  String productImage;

  CreateCategoryModel({
    required this.username,
    required this.password,
    required this.productName,
    required this.priceIsManual,
    required this.manualPrice,
    required this.shopId,
    required this.isActive,
    required this.correctingFactor,
    required this.productImage,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "product_name": productName,
      "price_is_manual": priceIsManual,
      "manual_price": manualPrice,
      "shop_id": shopId,
      "is_active": isActive,
      "correcting_factor": correctingFactor,
      "product_image": productImage
    };
  }
} */

class CreateCategoryModel {
  String username;
  String password;
  String nameCategory;
  String categoryImage;
  int shopId;
  int contentTypeId;
  int moduleId;
  List<ProductList> productList;

  CreateCategoryModel(
      {required this.username,
      required this.password,
      required this.nameCategory,
      required this.categoryImage,
      required this.shopId,
      required this.contentTypeId,
      required this.moduleId,
      required this.productList});

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "name_category": nameCategory,
      "category_image": categoryImage,
      "manual_price": shopId,
      "shop_id": shopId,
      "content_type_id": contentTypeId,
      "module_id": moduleId,
      "product_list": productList.map((v) => v.toJson()).toList(),
    };
  }
}

class ProductList {
  int? quantity;
  int? productId;

  ProductList({this.quantity, this.productId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['product_id'] = productId;
    return data;
  }
}
