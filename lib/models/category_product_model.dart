class CategoryProductModel {
  int? id;
  int? category;
  int? product;
  int? quantity;

  CategoryProductModel({this.id, this.category, this.product, this.quantity});

  CategoryProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    product = json['product'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['category'] = category;
    data['product'] = product;
    data['quantity'] = quantity;
    return data;
  }
}
