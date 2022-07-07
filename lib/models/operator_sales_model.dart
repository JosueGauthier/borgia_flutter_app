class OperatorSalesModel {
  int apiModulePk;
  int apiShopPk;
  int apiOrderedQuantity;
  int apiCategoryProductId;
  int buyer;
  String username;
  String password;

  OperatorSalesModel(
      {required this.apiModulePk,
      required this.apiShopPk,
      required this.apiOrderedQuantity,
      required this.apiCategoryProductId,
      required this.buyer,
      required this.username,
      required this.password});

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "api_buyer_pk": buyer,
      "api_module_pk": apiModulePk,
      "api_shop_pk": apiShopPk,
      "api_ordered_quantity": apiOrderedQuantity,
      "api_category_product_id": apiCategoryProductId
    };
  }
}
