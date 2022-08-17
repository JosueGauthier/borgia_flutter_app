class UpdateShopModel {
  String username;
  String password;
  int shopId;
  String shopImage;
  bool correctingFactorActivated;

  UpdateShopModel({
    required this.username,
    required this.password,
    required this.shopId,
    required this.shopImage,
    required this.correctingFactorActivated,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "shop_id": shopId,
      "shop_image": shopImage,
      "correcting_factor_activated": correctingFactorActivated,
    };
  }
}


/* {
    "username": "73An220",
    "password": "",
    "shop_id":14,
    "shop_name":"theshop",
    "shop_description": "shop_description",
    "shop_image": "xlsllll"
} */