class UpdateCategoryModel {
  String username;
  String password;
  int productId;
  String productName;
  bool priceIsManual;
  double manualPrice;
  bool isActive;
  double correctingFactor;
  String productImage;

  UpdateCategoryModel({
    required this.username,
    required this.password,
    required this.productId,
    required this.productName,
    required this.priceIsManual,
    required this.manualPrice,
    required this.isActive,
    required this.correctingFactor,
    required this.productImage,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "product_id": productId,
      "product_name": productName,
      "price_is_manual": priceIsManual,
      "manual_price": manualPrice,
      "is_active": isActive,
      "correcting_factor": correctingFactor,
      "product_image": productImage
    };
  }
}
