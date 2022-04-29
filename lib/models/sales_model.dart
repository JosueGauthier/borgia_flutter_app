class SalesModel {
  int api_module_pk;
  int api_shop_pk;
  int api_ordered_quantity;
  int api_category_product_id;
  String username;
  String password;

  SalesModel(
      {required this.api_module_pk,
      required this.api_shop_pk,
      required this.api_ordered_quantity,
      required this.api_category_product_id,
      required this.username,
      required this.password});

  Map<String, dynamic> toJson() {
    //final Map<String, dynamic> data = <String, dynamic>{};

    print(api_module_pk);

    return {
      "username": username,
      "password": password,
      "api_module_pk": api_module_pk,
      "api_shop_pk": api_shop_pk,
      "api_ordered_quantity": api_ordered_quantity,
      "api_category_product_id": api_category_product_id
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
