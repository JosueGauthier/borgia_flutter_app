class UpdateCategoryModel {
  String username;
  String password;
  int categoryId;
  String nameCategory;
  String categoryImage;
  List<ProductList> productList;

  UpdateCategoryModel(
      {required this.username,
      required this.password,
      required this.categoryId,
      required this.nameCategory,
      required this.categoryImage,
      required this.productList});

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "category_id": categoryId,
      "name_category": nameCategory,
      "category_image": categoryImage,
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
