class ProductModel {
  int? id;
  String? name;
  String? unit;
  int? shop;
  bool? isManual;
  double? manualPrice;
  double? correctingFactor;
  bool? isActive;
  bool? isRemoved;
  String? image;
  int? idParentCategory;
  int? moduleIdParentCategory;
  int? idCategoryproductTable;

  ProductModel(
      {this.id,
      this.name,
      this.unit,
      this.shop,
      this.isManual,
      this.manualPrice,
      this.correctingFactor,
      this.isActive,
      this.isRemoved,
      this.image,
      this.idParentCategory,
      this.moduleIdParentCategory,
      this.idCategoryproductTable});

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
    image = json['product_image'];
    idParentCategory = json['id_parent_category'];
    moduleIdParentCategory = json['module_id_parent_category'];
    idCategoryproductTable = json['id_categoryproduct_table'];
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
    data['product_image'] = image;
    data['id_parent_category'] = this.idParentCategory;
    data['module_id_parent_category'] = this.moduleIdParentCategory;
    data['id_categoryproduct_table'] = this.idCategoryproductTable;
    return data;
  }
}
