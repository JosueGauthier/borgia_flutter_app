import 'package:borgiaflutterapp/pages/auth/auth_page.dart';
import 'package:borgiaflutterapp/pages/auth/sign_in_page.dart';
import 'package:borgiaflutterapp/pages/content/neon.dart';
import 'package:borgiaflutterapp/pages/money/rechargement_lydia_page.dart';
import 'package:borgiaflutterapp/pages/profile/profile_page.dart';
import 'package:borgiaflutterapp/pages/user/user_page.dart';
import 'package:get/get.dart';

import '../pages/cart/last_purchase_page.dart';
import '../pages/home/home_page.dart';
import '../pages/shop/category_shop_page.dart';
import '../pages/shop/product_list_page.dart';
import '../pages/splash/splash_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String authPage = "/auth-page";
  static const String loginPage = "/login-page";

  static const String initial = "/";

  static const String popularFood = "/popular-food";

  static const String recommendedFood = "/reccommended-food";

  static const String shopDetail = "/shop-detail";

  static const String categoryListPage = "/category-list-page";

  static const String cartPage = "/cart-page";

  static const String refillLydia = "/lydia-page";
  static const String profilePage = "/profile-page";

  static const String userPage = "/user-page";

  static const String productListFromCategory = "/product";

  static const String neonPage = "/madeby";

  //? formalisme pour passer des paramètres

  static String getSplashPage() => splashPage;
  static String getLydiaPage() => refillLydia;
  static String getAuthPage() => authPage;
  static String getneonPage() => neonPage;
  static String getProfilepage() => profilePage;
  static String getLoginPage() => loginPage;
  static String getInitial() => initial;
  static String getPopularFood(int pageId, String pagefrom) => '$popularFood?pageId=$pageId&page=$pagefrom';
  static String getRecommendedFood(int pageId, String pagefrom) => '$recommendedFood?pageId=$pageId&page=$pagefrom';

  static String getCartPage() => cartPage;

  static String getShopDetail(int shopId, String pagefrom) => '$shopDetail?shopId=$shopId&page=$pagefrom';

  static String getUserPage(String username, String pagefrom) => '$userPage?username=$username&page=$pagefrom';

  static String getCategoryListPage(int shopId, String pagefrom) => '$categoryListPage?shopId=$shopId&page=$pagefrom';

  static String getProductList(int categoryId, int categoryModuleId, int shopId, String pagefrom) =>
      '$productListFromCategory?categoryId=$categoryId&categoryModuleId=$categoryModuleId&shopId=$shopId&page=$pagefrom';

  static List<GetPage> routes = [
    GetPage(
      name: splashPage,
      page: () {
        return const SplashScreen();
      },
      //transition: Transition.fadeIn
    ),
    GetPage(
      name: authPage,
      page: () {
        return const AuthPage();
      },
      //transition: Transition.fadeIn
    ),
    GetPage(
      name: loginPage,
      page: () {
        return const LoginPage();
      },
      //transition: Transition.fadeIn
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
      //transition: Transition.fadeIn
    ),
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
  ];
}
