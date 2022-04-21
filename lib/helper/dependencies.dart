import 'package:borgiaflutterapp/controllers/product_controller.dart';
import 'package:borgiaflutterapp/controllers/shop_controller.dart';
import 'package:borgiaflutterapp/data/repository/product_repo.dart';
import 'package:borgiaflutterapp/data/repository/shop_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/cart_controller.dart';
import '../controllers/popular_product_controller.dart';
import '../controllers/recommended_product_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/cart_repo.dart';
import '../data/repository/popular_product_repo.dart';
import '../data/repository/recommended_repo.dart';
import '../utils/app_constants.dart';

Future<void> init() async {
  //! load shared_preferencies

  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  //! api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //! repos
  Get.lazyPut(() => ShopRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  //!controllers
  Get.lazyPut(() => ShopController(shopRepo: Get.find()));
  Get.lazyPut(() => ProductController(productRepo: Get.find()));

  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
