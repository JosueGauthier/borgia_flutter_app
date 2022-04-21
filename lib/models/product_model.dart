class ProductModel {
  int? id;
  String? name;
  String? unit;
  String? shop;
  bool? isManual;
  String? manualPrice;
  String? correctingFactor;
  bool? isActive;
  bool? isRemoved;
  String? productImage;

  ProductModel(
      {this.id, this.name, this.unit, this.shop, this.isManual, this.manualPrice, this.correctingFactor, this.isActive, this.isRemoved, this.productImage});

  ProductModel.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['unit'] = this.unit;
    data['shop'] = this.shop;
    data['is_manual'] = this.isManual;
    data['manual_price'] = this.manualPrice;
    data['correcting_factor'] = this.correctingFactor;
    data['is_active'] = this.isActive;
    data['is_removed'] = this.isRemoved;
    data['product_image'] = this.productImage;
    return data;
  }
}
