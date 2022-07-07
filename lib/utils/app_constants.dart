// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class AppConstants {
  static const String SHOP_URI = "/api-links/shops/shops/?format=json";
  static const String USER_URI = "/api-links/users/users/?username=";
  static const String CATEGORY_URI = "/api-links/category/category/?shop_id=";

  static const String SEARCH_SHOP_URI = "/api-links/searchshop/?search=";
  static const String SEARCH_CATEGORY_URI = "/api-links/searchcategory/?search=";
  static const String SEARCH_USER_URI = "/api-links/searchuser/?search=";

  static const String PRODUCT_LIST_URI = "/api-links/category/categoryv2/?id=";
  static const String PRODUCT_URI_NAME = "/api-links/shops/productsv2/?name="; //via name

  //* Stat uri
  static const String YEAR_SALELIST_URI = "/api-links/history/";
  static const String HOUR_SALELIST_URI = "/api-links/live-sales/";
  static const String USER_SALELIST_URI = "/api-links/sale/user-history-allsale/?sender=";
  static const String SHOP_STAT_URI = "/api-links/shops/shop-stat/";
  static const String USER_SHOP_STAT_URI = "/api-links/sale/stat-user/?username=";
  static const String RANK_USER_SHOP_STAT_URI = "/api-links/sale/rank-user-shop/";
  static const String RANK_USER_URI = "/api-links/sale/rank-user/";
  static const String RANK_USER_PRODUCT_STAT_URI = "/api-links/sale/rank-user-product/?id=";

  //* for end rotation of name on WelcomePageWithHeader
  static bool isfinishedRotate = false;

  //* auth endpoints
  static const String REGISTRATION_URI = "/api-links/auth/";
  static const String LOGIN_URI = "/api-links/login/";

  //* self-sale endpoint
  static const String SELF_SALES_URI = "/api-links/self-sale/";
  static const String OPERATOR_SALES_URI = "/api-links/operator-sale/";

  //* save user info
  static String TOKEN = "DBToken";
  static String COOKIE = "";

  static Map<String, String>? HEADERS = {};

  static String USERNAME = "";
  static String PASSWORD = "";

  static const String APP_NAME = "BorgiaApp";
  static const int APP_VERSION = 1;
  static const String BASE_URL = "https://borgia.josue.to";
  static const String CART_LIST = "Cart-list";
  static const String IDENTIFIERS_LIST = "Identifiers-list";
}
