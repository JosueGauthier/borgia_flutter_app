// ignore_for_file: unnecessary_new

class ProductModel {
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
  //int? categoryId;
  //int? categoryModuleId;
  //int? shopId;

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
    //this.categoryId,
    //this.categoryModuleId,
    //this.shopId,
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
    //categoryId = json['category_id'];
    //categoryModuleId = json['category_module_id'];
    //shopId = json['shop_id'];
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
