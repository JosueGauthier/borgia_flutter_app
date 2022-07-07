class SelfSalesModel {
  int apiModulePk;
  int apiShopPk;
  int apiOrderedQuantity;
  int apiCategoryProductId;
  String username;
  String password;

  SelfSalesModel(
      {required this.apiModulePk,
      required this.apiShopPk,
      required this.apiOrderedQuantity,
      required this.apiCategoryProductId,
      required this.username,
      required this.password});

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "api_module_pk": apiModulePk,
      "api_shop_pk": apiShopPk,
      "api_ordered_quantity": apiOrderedQuantity,
      "api_category_product_id": apiCategoryProductId
    };
  }
}
