import 'package:get/get.dart';

import '../pages/cart/cart_page.dart';
import '../pages/food/popularfooddetail.dart';
import '../pages/food/recommended_food_detail.dart';
import '../pages/home/home_page.dart';
import '../pages/shop/shop_page_detail.dart';
import '../pages/splash/splash_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";

  static const String popularFood = "/popular-food";

  static const String recommendedFood = "/reccommended-food";

  static const String shopDetail = "/shop-detail";

  static const String cartPage = "/cart-page";

  //? formalisme pour passer des paramètres

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String pagefrom) => '$popularFood?pageId=$pageId&page=$pagefrom';
  static String getRecommendedFood(int pageId, String pagefrom) => '$recommendedFood?pageId=$pageId&page=$pagefrom';

  static String getShopDetail(int shopId, String pagefrom) => '$shopDetail?shopId=$shopId&page=$pagefrom';

  static String getCartPage(int pageId, String pagefrom) => '$cartPage?pageId=$pageId&page=$pagefrom';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initial, page: () => HomePage()),
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
        transition: Transition.fadeIn),
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
        transition: Transition.fadeIn),
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
        transition: Transition.fadeIn),
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
        transition: Transition.fadeIn),
  ];
}
