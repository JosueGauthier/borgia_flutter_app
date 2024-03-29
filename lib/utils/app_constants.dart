// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:cloudinary_public/cloudinary_public.dart';

class AppConstants {
  //* Base Uri
  static const String SHOP_URI = "/api-links/shops/shops/?format=json";

  static const String SELFSALE_MODULE_URI = "/api-links/shops/selfsale-modules/";
  static const String OPERATOR_MODULE_URI = "/api-links/shops/operatorsale-modules/";

  static const String USER_URI = "/api-links/users/users/?username=";
  static const String CATEGORY_URI = "/api-links/category/category/?shop_id=";

  static const String SEARCH_SHOP_URI = "/api-links/searchshop/?search=";
  static const String SEARCH_CATEGORY_URI = "/api-links/searchcategory/?search=";
  static const String SEARCH_USER_URI = "/api-links/searchuser/?search=";

  static const String PRODUCT_LIST_URI = "/api-links/category/categoryv2/?id=";
  static const String PRODUCT_URI_NAME = "/api-links/shops/productsv2/?name="; //via name
  static const String PRODUCT_URI_ID = "/api-links/shops/productsv2/?id="; //via id

  //* Lydia uri
  static const String LYDIA_DO_REQUEST_URI = "/api-links/lydia/";
  static const String LYDIA_STATE_REQUEST_URI = "/api-links/lydia-state-request/";

  //* Stat uri
  static const String YEAR_SALELIST_URI = "/api-links/history/";
  static const String HOUR_SALELIST_URI = "/api-links/live-sales/";
  static const String USER_SALELIST_URI = "/api-links/sale/user-history-allsale/?username=";

  static const String SHOP_STAT_URI = "/api-links/shops/shop-stat/";
  static const String USER_SHOP_STAT_URI = "/api-links/sale/stat-user/?username=";
  static const String RANK_USER_SHOP_STAT_URI = "/api-links/sale/rank-user-shop/";
  static const String RANK_USER_URI = "/api-links/sale/rank-user/";
  static const String RANK_USER_PRODUCT_STAT_URI = "/api-links/sale/rank-user-product/?id=";

  //* for end rotation of name on WelcomePageWithHeader
  static bool bienvenueUsernameisfinishedRotate = false;

  //* auth endpoints
  static const String REGISTRATION_URI = "/api-links/auth/";
  static const String LOGIN_URI = "/api-links/login/";

  //* self-sale endpoint
  static const String SELF_SALES_URI = "/api-links/self-sale/";
  static const String OPERATOR_SALES_URI = "/api-links/operator-sale/";

  //* save user info
  static String TOKEN = "DBToken";
  static String COOKIE = "";

  //* create product endpoint
  static const String CREATE_PRODUCT_URI = "/api-links/create-product/";

  //* update product endpoint
  static const String UPDATE_PRODUCT_URI = "/api-links/update-product/";

  //* delete product endpoint
  static const String DELETE_PRODUCT_URI = "/api-links/delete-product/";

  //* create product endpoint
  static const String CREATE_CATEGORY_URI = "/api-links/create-category/";

  //* update product endpoint
  static const String UPDATE_CATEGORY_URI = "/api-links/update-category/";

  //* delete product endpoint
  static const String DELETE_CATEGORY_URI = "/api-links/delete-category/";

  static const String PRODUCT_LIST_URI_FROM_SHOP = "/api-links/shops/products/?shop=";

  //* update shop endpoint
  static const String UPDATE_SHOP_URI = "/api-links/update-shop/";

  static Map<String, String>? HEADERS = {};

  static String USERNAME = "";
  static String PASSWORD = "";

  static CloudinaryPublic CLOUDINARY_PUBLIC_VAR = CloudinaryPublic('dxsy9rszs', 'borgia', cache: false);

  static const String APP_NAME = "BorgiaApp";
  static const int APP_VERSION = 1;
  static const String BASE_URL = "https://borgia.josue.to";
  static const String CART_LIST = "Cart-list";
  static const String IDENTIFIERS_LIST = "Identifiers-list";
}
