import 'package:borgiaflutterapp/admin/pages/admin_page.dart';
import 'package:borgiaflutterapp/pages/auth/login_page.dart';
import 'package:borgiaflutterapp/pages/content/neon.dart';
import 'package:borgiaflutterapp/pages/money/rechargement_lydia_page.dart';
import 'package:borgiaflutterapp/pages/profile/profile_page.dart';
import 'package:borgiaflutterapp/pages/stats/rank_user_products_page.dart';
import 'package:borgiaflutterapp/pages/user/user_page.dart';
import 'package:get/get.dart';

import '../admin/pages/operator_sale_page.dart';
import '../admin/pages/category/create_category_page.dart';
import '../admin/pages/category/delete_category_page.dart';
import '../admin/pages/category/update_category_page.dart';
import '../admin/pages/management/management_shop_page.dart';
import '../admin/pages/product/create_product_page.dart';
import '../admin/pages/product/delete_product_page.dart';
import '../admin/pages/product/update_product_page.dart';
import '../pages/cart/last_purchase_page.dart';
import '../pages/credits/credits_page.dart';
import '../pages/home/home_page.dart';
import '../pages/shop/category_shop_page.dart';
import '../pages/shop/product_list_page.dart';
import '../pages/splash/splash_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String loginPage = "/login-page";

  static const String initial = "/";

  static const String categoryListPage = "/category-list-page";

  static const String cartPage = "/cart-page";

  static const String refillLydia = "/lydia-page";
  static const String profilePage = "/profile-page";

  static const String userPage = "/user-page";

  static const String productListFromCategory = "/product";

  static const String neonPage = "/madeby";
  static const String creditsPage = "/credits";

  static const String productRankUserPage = "/product-rank-user-page";

  static const String adminPage = "/admin-page";

  static const String adminSearchPage = "/admin-search-page";

  static const String managementShopPage = "/admin-management-shop-page";

  static const String createProductPage = "/admin-create-product-page";
  static const String updateProductPage = "/admin-update-product-page";
  static const String deleteProductPage = "/admin-delete-product-page";

  static const String createCategoryPage = "/admin-create-category-page";
  static const String updateCategoryPage = "/admin-update-category-page";
  static const String deleteCategoryPage = "/admin-delete-category-page";

  //? formalisme pour passer des paramètres

  static String getSplashPage() => splashPage;
  static String getLydiaPage() => refillLydia;
  static String getNeonPage() => neonPage;
  static String getCreditsPage() => creditsPage;
  static String getProfilepage() => profilePage;
  static String getLoginPage() => loginPage;
  static String getInitial() => initial;

  static String getCartPage() => cartPage;

  static String getUserPage(String username, String pagefrom) => '$userPage?username=$username&page=$pagefrom';

  static String getCategoryListPage(int shopId, String pagefrom) => '$categoryListPage?shopId=$shopId&page=$pagefrom';

  static String getProductList(int categoryId, String contentType) => '$productListFromCategory?categoryId=$categoryId&contentType=$contentType';

  static String getProductRankUserPage(int shopId) => '$productRankUserPage?shopId=$shopId';

  static String getAdminPage() => adminPage;
  static String getAdminSearchPage(int shopId) => '$adminSearchPage?shopId=$shopId';
  static String getManagementShopPage(int shopId) => '$managementShopPage?shopId=$shopId';

  static String getCreateProductPage(int shopId) => '$createProductPage?shopId=$shopId';
  static String getUpdateProductPage(int shopId) => '$updateProductPage?shopId=$shopId';
  static String getDeleteProductPage(int shopId) => '$deleteProductPage?shopId=$shopId';

  static String getCreateCategoryPage(int shopId) => '$createCategoryPage?shopId=$shopId';
  static String getUpdateCategoryPage(int shopId) => '$updateCategoryPage?shopId=$shopId';
  static String getDeleteCategoryPage(int shopId) => '$deleteCategoryPage?shopId=$shopId';

  static List<GetPage> routes = [
    GetPage(
      name: splashPage,
      page: () {
        return const SplashScreen();
      },
    ),
    GetPage(
      name: loginPage,
      page: () {
        return const LoginPage();
      },
    ),
    GetPage(
      name: initial,
      page: () {
        return const HomePage();
      },
      //transition: Transition.fadeIn
    ),
    GetPage(
      name: cartPage,
      page: () {
        return const LastPurchases();
      },
      //transition: Transition.fadeIn
    ),
    GetPage(
      name: categoryListPage,
      page: () {
        var shopId = Get.parameters['shopId'];
        var pagefrom = Get.parameters['page'];
        return CategoryShopPage(
          shopId: int.parse(shopId!),
          pagefrom: pagefrom!,
        );
      },
      //transition: Transition.fadeIn
    ),
    GetPage(
        name: productListFromCategory,
        page: () {
          var categoryId = Get.parameters['categoryId'];
          var contentType = Get.parameters['contentType'];
          return ProductListPage(
            categoryId: int.parse(categoryId!),
            contentType: contentType!,
          );
        },
        transition: Transition.fadeIn),
    GetPage(
      name: refillLydia,
      page: () {
        return const RefillLydiaPage();
      },
      //transition: Transition.fadeIn
    ),
    GetPage(
      name: profilePage,
      page: () {
        return const ProfilePage();
      },
      //transition: Transition.fadeIn
    ),
    GetPage(
      name: userPage,
      page: () {
        var username = Get.parameters['username'];
        var pagefrom = Get.parameters['page'];
        return UserPage(
          userUsername: username!,
          pagefrom: pagefrom!,
        );
      },
      //transition: Transition.fadeIn
    ),
    GetPage(
      name: neonPage,
      page: () {
        return const NeonPage();
      },
    ),
    GetPage(
      name: creditsPage,
      page: () {
        return const CreditsPage();
      },
    ),
    GetPage(
      name: productRankUserPage,
      page: () {
        var shopId = Get.parameters['shopId'];
        return RankUserProductPage(
          shopId: int.parse(shopId!),
        );
      },
      //transition: Transition.fadeIn
    ),
    GetPage(
      name: adminPage,
      page: () {
        return const AdminPage();
      },
    ),
    GetPage(
      name: adminSearchPage,
      page: () {
        var shopId = Get.parameters['shopId'];
        return OpearatorSalePage(
          shopId: int.parse(shopId!),
        );
      },
    ),
    GetPage(
      name: managementShopPage,
      page: () {
        var shopId = Get.parameters['shopId'];
        return ManagementShopPage(
          shopId: int.parse(shopId!),
        );
      },
    ),
    GetPage(
      name: createProductPage,
      page: () {
        var shopId = Get.parameters['shopId'];
        return CreateProductPage(
          shopId: int.parse(shopId!),
        );
      },
    ),
    GetPage(
      name: updateProductPage,
      page: () {
        var shopId = Get.parameters['shopId'];

        return UpdateProductPage(
          shopId: int.parse(shopId!),
        );
      },
    ),
    GetPage(
      name: deleteProductPage,
      page: () {
        var shopId = Get.parameters['shopId'];
        return DeleteProductPage(
          shopId: int.parse(shopId!),
        );
      },
    ),
    GetPage(
      name: createCategoryPage,
      page: () {
        var shopId = Get.parameters['shopId'];
        return CreateCategoryPage(
          shopId: int.parse(shopId!),
        );
      },
    ),
    GetPage(
      name: updateCategoryPage,
      page: () {
        var shopId = Get.parameters['shopId'];
        return UpdateCategoryPage(
          shopId: int.parse(shopId!),
        );
      },
    ),
    GetPage(
      name: deleteCategoryPage,
      page: () {
        var shopId = Get.parameters['shopId'];
        return DeleteCategoryPage(
          shopId: int.parse(shopId!),
        );
      },
    ),
  ];
}
