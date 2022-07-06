import 'package:borgiaflutterapp/admin/pages/admin_page.dart';
import 'package:borgiaflutterapp/pages/auth/login_page.dart';
import 'package:borgiaflutterapp/pages/content/neon.dart';
import 'package:borgiaflutterapp/pages/money/rechargement_lydia_page.dart';
import 'package:borgiaflutterapp/pages/profile/profile_page.dart';
import 'package:borgiaflutterapp/pages/stats/rank_user_products_page.dart';
import 'package:borgiaflutterapp/pages/user/user_page.dart';
import 'package:get/get.dart';

import '../admin/pages/admin_search_page.dart';
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

  static String getProductList(int categoryId, int categoryModuleId, int shopId, String pagefrom) =>
      '$productListFromCategory?categoryId=$categoryId&categoryModuleId=$categoryModuleId&shopId=$shopId&page=$pagefrom';

  static String getProductRankUserPage(int shopId) => '$productRankUserPage?shopId=$shopId';

  static String getAdminPage() => adminPage;

  static String getAdminSearchPage(int shopId) => '$adminSearchPage?shopId=$shopId';

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
          var categoryModuleId = Get.parameters['categoryModuleId'];
          var shopId = Get.parameters['shopId'];
          var pagefrom = Get.parameters['page'];
          return ProductListPage(
            categoryId: int.parse(categoryId!),
            categoryModuleId: int.parse(categoryModuleId!),
            shopId: int.parse(shopId!),
            pagefrom: pagefrom!,
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
        return AdminSearchPage(
          shopId: int.parse(shopId!),
        );
      },
    ),
  ];
}
