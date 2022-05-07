import 'dart:developer';

import 'package:borgiaflutterapp/controllers/search_controller.dart';
import 'package:borgiaflutterapp/data/repository/search_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/auth_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/category_controller.dart';
import '../controllers/popular_product_controller.dart';
import '../controllers/product_controller.dart';
import '../controllers/product_from_category_controller.dart';
import '../controllers/recommended_product_controller.dart';
import '../controllers/sales_controller.dart';
import '../controllers/shop_controller.dart';
import '../controllers/user_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/cart_repo.dart';
import '../data/repository/category_list_repo.dart';
import '../data/repository/popular_product_repo.dart';
import '../data/repository/product_list_from_category_repo.dart';
import '../data/repository/product_repo.dart';
import '../data/repository/recommended_repo.dart';
import '../data/repository/sales_repo.dart';
import '../data/repository/shop_repo.dart';
import '../data/repository/user_repo.dart';
import '../utils/app_constants.dart';

Future<void> init() async {
  //! load shared_preferencies

  final sharedPreferences = await SharedPreferences.getInstance();
  //print(sharedPreferences);
  //inspect(sharedPreferences);
  Get.lazyPut(() => sharedPreferences);

  //! api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //! repos

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  Get.lazyPut(() => ShopRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CategoryOfShopRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProductFromCategoryRepo(apiClient: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find())); // Get.find() permet de trouver automatiquement l'api client....
  Get.lazyPut(() => SalesRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(() => SearchRepo(apiClient: Get.find()));

  //!controllers

  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()), fenix: true);

  Get.lazyPut(() => ShopController(shopRepo: Get.find()));
  Get.lazyPut(() => ProductController(productRepo: Get.find()), fenix: true); //, fenix = true permet de ne pas supprimer le controller
  Get.lazyPut(() => CategoryOfShopController(categoryOfShopRepo: Get.find()), fenix: true);
  Get.lazyPut(() => ProductFromCategoryController(productFromCategoryRepo: Get.find(), productRepo: Get.find()), fenix: true);
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => SalesController(salesRepo: Get.find()));

  Get.lazyPut(() => SearchController(searchRepo: Get.find()), fenix: true);

  //Get.find<ProductFromCategoryController>().initProduct(widget.productModel, Get.find<CartController>());
}
