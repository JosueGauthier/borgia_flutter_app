import 'package:borgiaflutterapp/admin/controller/create_category_controller.dart';
import 'package:borgiaflutterapp/admin/controller/delete_category_controller.dart';
import 'package:borgiaflutterapp/admin/controller/update_category_controller.dart';
import 'package:borgiaflutterapp/admin/data/create_category_repo.dart';
import 'package:borgiaflutterapp/admin/data/create_product_repo.dart';
import 'package:borgiaflutterapp/admin/data/delete_category_repo.dart';
import 'package:borgiaflutterapp/admin/data/salemodule_repo.dart';
import 'package:borgiaflutterapp/admin/data/update_category_repo.dart';
import 'package:borgiaflutterapp/controllers/lydia_controller.dart';
import 'package:borgiaflutterapp/controllers/other_users_controller.dart';
import 'package:borgiaflutterapp/controllers/product_list_controller.dart';
import 'package:borgiaflutterapp/controllers/rank_user_controller.dart';
import 'package:borgiaflutterapp/controllers/rank_user_product_controller.dart';
import 'package:borgiaflutterapp/controllers/sale_list_controller.dart';
import 'package:borgiaflutterapp/controllers/search_controller.dart';
import 'package:borgiaflutterapp/controllers/shop_stat_controller.dart';
import 'package:borgiaflutterapp/controllers/user_shop_stat_controller.dart';
import 'package:borgiaflutterapp/data/repository/lydia_repo.dart';
import 'package:borgiaflutterapp/data/repository/other_user_repo.dart';
import 'package:borgiaflutterapp/data/repository/product_list_repo.dart';
import 'package:borgiaflutterapp/data/repository/rank_user_product_repo.dart';
import 'package:borgiaflutterapp/data/repository/rank_user_repo.dart';
import 'package:borgiaflutterapp/data/repository/sale_list_repo.dart';
import 'package:borgiaflutterapp/data/repository/search_repo.dart';
import 'package:borgiaflutterapp/data/repository/shop_stat_repo.dart';
import 'package:borgiaflutterapp/data/repository/user_shop_stat_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../admin/controller/create_product_controller.dart';
import '../admin/controller/delete_product_controller.dart';
import '../admin/controller/salemodule_controller.dart';
import '../admin/controller/update_product_controller.dart';
import '../admin/data/delete_product_repo.dart';
import '../admin/data/update_product_repo.dart';
import '../controllers/auth_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/category_controller.dart';
import '../controllers/sales_controller.dart';
import '../controllers/shop_controller.dart';
import '../controllers/user_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/cart_repo.dart';
import '../data/repository/category_list_repo.dart';
import '../data/repository/sales_repo.dart';
import '../data/repository/shop_repo.dart';
import '../data/repository/user_repo.dart';
import '../utils/app_constants.dart';

Future<void> init() async {
  //! load shared_preferencies

  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  //! api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //! repos

  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  Get.lazyPut(() => ShopRepo(apiClient: Get.find()));
  Get.lazyPut(() => SaleModuleRepo(apiClient: Get.find()));

  Get.lazyPut(() => CategoryOfShopRepo(apiClient: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find())); // Get.find() permet de trouver automatiquement l'api client....
  Get.lazyPut(() => SalesRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(() => LydiaDoRequestRepo(apiClient: Get.find()));

  Get.lazyPut(() => SearchRepo(apiClient: Get.find()));
  Get.lazyPut(() => OtherUserRepo(apiClient: Get.find()));

  Get.lazyPut(() => SaleListRepo(apiClient: Get.find()));

  Get.lazyPut(() => ShopStatRepo(apiClient: Get.find()));

  Get.lazyPut(() => UserShopStatRepo(apiClient: Get.find()));

  Get.lazyPut(() => RankUserStatRepo(apiClient: Get.find()));

  Get.lazyPut(() => RankUserProductRepo(apiClient: Get.find()));

  Get.lazyPut(() => ProductListRepo(apiClient: Get.find()));

  Get.lazyPut(() => CreateProductRepo(apiClient: Get.find()));

  Get.lazyPut(() => UpdateProductRepo(apiClient: Get.find()));

  Get.lazyPut(() => DeleteProductRepo(apiClient: Get.find()));

  Get.lazyPut(() => CreateCategoryRepo(apiClient: Get.find()));

  Get.lazyPut(() => UpdateCategoryRepo(apiClient: Get.find()));

  Get.lazyPut(() => DeleteCategoryRepo(apiClient: Get.find()));

  //!controllers

  Get.lazyPut(() => CartController(cartRepo: Get.find()), fenix: true);

  Get.lazyPut(() => ShopController(shopRepo: Get.find()), fenix: true);
  Get.lazyPut(() => SaleModuleController(saleModuleRepo: Get.find()), fenix: true);

  Get.lazyPut(() => CategoryOfShopController(categoryOfShopRepo: Get.find()), fenix: true);
  Get.lazyPut(() => UserController(userRepo: Get.find()), fenix: true);
  Get.lazyPut(() => AuthController(authRepo: Get.find()), fenix: true);
  Get.lazyPut(() => SalesController(salesRepo: Get.find()), fenix: true);

  Get.lazyPut(() => LydiaDoRequestController(lydiaDoRequestRepo: Get.find()), fenix: true);

  Get.lazyPut(() => SearchController(searchRepo: Get.find()), fenix: true);

  Get.lazyPut(() => OtherUserController(userRepo: Get.find()), fenix: true);

  Get.lazyPut(() => SaleListController(saleListRepo: Get.find()), fenix: true);

  Get.lazyPut(() => ShopStatController(shopStatRepo: Get.find()), fenix: true);

  Get.lazyPut(() => UserShopStatController(userShopStatRepo: Get.find()), fenix: true);

  Get.lazyPut(() => RankUserStatController(rankUserStatRepo: Get.find()), fenix: true);

  Get.lazyPut(() => RankUserProductController(rankUserProductRepo: Get.find()), fenix: true);

  Get.lazyPut(() => ProductListController(productListRepo: Get.find()), fenix: true);

  Get.lazyPut(() => CreateProductController(createProductRepo: Get.find()), fenix: true);
  Get.lazyPut(() => UpdateProductController(updateProductRepo: Get.find()), fenix: true);
  Get.lazyPut(() => DeleteProductController(deleteProductRepo: Get.find()), fenix: true);

  Get.lazyPut(() => CreateCategoryController(createCategoryRepo: Get.find()), fenix: true);
  Get.lazyPut(() => UpdateCategoryController(updateCategoryRepo: Get.find()), fenix: true);
  Get.lazyPut(() => DeleteCategoryController(deleteCategoryRepo: Get.find()), fenix: true);
}
