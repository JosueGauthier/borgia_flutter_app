class ProductListFromCategoryModel {
  int? id;
  String? category;
  String? product;
  int? quantity;

  ProductListFromCategoryModel({this.id, this.category, this.product, this.quantity});

  ProductListFromCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category']; // lien http
    product = json['product']; // lien http
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['product'] = this.product;
    data['quantity'] = this.quantity;
    return data;
  }
}
