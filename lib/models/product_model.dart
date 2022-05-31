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
  int? categoryWhereProductIs;
  int? moduleIdWhereProductIs;
  int? catProdId;

  ProductModel({
    this.id,
    this.name,
    this.unit,
    this.shop,
    this.isManual,
    this.manualPrice,
    this.correctingFactor,
    this.isActive,
    this.isRemoved,
    this.image,
    this.categoryWhereProductIs,
    this.moduleIdWhereProductIs,
    this.catProdId,
  });

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
    categoryWhereProductIs = json['category_where_product_is'];
    moduleIdWhereProductIs = json['module_id_where_product_is'];
    catProdId = json['cat_prod_id'];
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
    data['category_where_product_is'] = categoryWhereProductIs;
    data['module_id_where_product_is'] = moduleIdWhereProductIs;
    data['cat_prod_id'] = catProdId;
    return data;
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









/* class ProductModel {
  int? id;
  String? name;
  String? unit;
  int? shop;
  bool? isManual;
  String? manualPrice;
  String? correctingFactor;
  bool? isActive;
  bool? isRemoved;
  String? image;
  int? mainid;

  ProductModel({
    this.id,
    this.name,
    this.unit,
    this.shop,
    this.isManual,
    this.manualPrice,
    this.correctingFactor,
    this.isActive,
    this.isRemoved,
    this.image,
    this.mainid,
  });

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
  }

  ProductModel.fromJsonPlusMainId(Map<String, dynamic> json, int mainId) {
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
    mainid = mainId;
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
    return data;
  }
}
 */