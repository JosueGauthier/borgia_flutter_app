class CreateProductModel {
  String username;
  String password;
  String productName;
  bool priceIsManual;
  double manualPrice;
  int shopId;
  bool isActive;
  double correctingFactor;
  String productImage;

  CreateProductModel({
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
}
