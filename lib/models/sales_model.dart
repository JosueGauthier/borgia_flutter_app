class SalesModel {
  int apiModulePk;
  int apiShopPk;
  int apiOrderedQuantity;
  int apiCategoryProductId;
  String username;
  String password;

  SalesModel(
      {required this.apiModulePk,
      required this.apiShopPk,
      required this.apiOrderedQuantity,
      required this.apiCategoryProductId,
      required this.username,
      required this.password});

  Map<String, dynamic> toJson() {
    //final Map<String, dynamic> data = <String, dynamic>{};

    //print(apiModulePk);

    return {
      "username": username,
      "password": password,
      "api_module_pk": apiModulePk,
      "api_shop_pk": apiShopPk,
      "api_ordered_quantity": apiOrderedQuantity,
      "api_category_product_id": apiCategoryProductId
    };

/*      {
      "username": "josue",
      "password": "josue",
      "api_module_pk": api_module_pk,
      "api_shop_pk": api_shop_pk,
      "api_ordered_quantity": api_ordered_quantity,
      "api_category_product_id": api_category_product_id
    }; */

    /* 
        data["username"] = username;
    data["password"] = password;
    data["api_module_pk"] = api_module_pk;
    data["api_shop_pk"] = api_shop_pk;
    data["api_ordered_quantity"] = api_ordered_quantity;
    data["api_category_product_id"] = api_category_product_id; */

    //return data;
  }
}
