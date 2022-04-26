import 'package:borgiaflutterapp/pages/auth/auth_page.dart';
import 'package:borgiaflutterapp/pages/auth/sign_in_page.dart';
import 'package:get/get.dart';

import '../pages/cart/cart_page.dart';
import '../pages/food/popularfooddetail.dart';
import '../pages/food/recommended_food_detail.dart';
import '../pages/home/home_page.dart';
import '../pages/shop/category_list_shop_page.dart';
import '../pages/shop/product_list_from_category_page.dart';
import '../pages/shop/shop_page_detail_page.dart';
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

  static const String productListFromCategory = "/product";

  //? formalisme pour passer des paramètres

  static String getSplashPage() => '$splashPage';
  static String getAuthPage() => '$authPage';
  static String getLoginPage() => '$loginPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String pagefrom) => '$popularFood?pageId=$pageId&page=$pagefrom';
  static String getRecommendedFood(int pageId, String pagefrom) => '$recommendedFood?pageId=$pageId&page=$pagefrom';

  static String getCartPage(int pageId, String pagefrom) => '$cartPage?pageId=$pageId&page=$pagefrom';

  static String getShopDetail(int shopId, String pagefrom) => '$shopDetail?shopId=$shopId&page=$pagefrom';

  static String getCategoryListPage(int shopId, String pagefrom) => '$categoryListPage?shopId=$shopId&page=$pagefrom';

  static String getProductList(int categoryId, String pagefrom) => '$productListFromCategory?categoryId=$categoryId&page=$pagefrom';

  static List<GetPage> routes = [
    GetPage(
      name: splashPage,
      page: () {
        return SplashScreen();
      },
      //transition: Transition.fadeIn
    ),
    GetPage(
      name: authPage,
      page: () {
        return AuthPage();
      },
      //transition: Transition.fadeIn
    ),
    GetPage(
      name: loginPage,
      page: () {
        return LoginPage();
      },
      //transition: Transition.fadeIn
    ),
    GetPage(
      name: initial,
      page: () {
        return HomePage();
      },
      //transition: Transition.fadeIn
    ),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var pagefrom = Get.parameters['page'];

        return PopularFoodDetail(
          pageId: int.parse(pageId!),
          pagefrom: pagefrom!,
        );
      },
      //transition: Transition.fadeIn
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var pagefrom = Get.parameters['page'];
        return RecommendedFoodDetail(
          pageId: int.parse(pageId!),
          pagefrom: pagefrom!,
        );
      },
      //transition: Transition.fadeIn
    ),
    GetPage(
      name: cartPage,
      page: () {
        var pageId = Get.parameters['pageId'];
        var pagefrom = Get.parameters['page'];
        return CartPage(
          pageId: int.parse(pageId!),
          pagefrom: pagefrom!,
        );
      },
      //transition: Transition.fadeIn
    ),
    GetPage(
      name: shopDetail,
      page: () {
        var shopId = Get.parameters['shopId'];
        var pagefrom = Get.parameters['page'];
        return ShopPageDetail(
          shopId: int.parse(shopId!),
          pagefrom: pagefrom!,
        );
      },
      //transition: Transition.fadeIn
    ),
    GetPage(
      name: categoryListPage,
      page: () {
        var shopId = Get.parameters['shopId'];
        var pagefrom = Get.parameters['page'];
        return CategoryShop(
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
        var pagefrom = Get.parameters['page'];
        return ProductListFromCategoryPage(
          categoryId: int.parse(categoryId!),
          pagefrom: pagefrom!,
        );
      },
      //transition: Transition.fadeIn
    ),
  ];
}
