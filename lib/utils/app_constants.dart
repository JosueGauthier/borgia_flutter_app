// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class AppConstants {
  static const String SHOP_URI = "/api-links/shops/shops/?format=json";
  static const String PRODUCT_URI = "/api-links/shops/products/?shop=";

  static const String USER_URI = "/api-links/users/users/?username=";

  static const String CATEGORY_URI = "/api-links/category/category/?shop_id=";
  static const String PRODUCT_FROM_CATEGORY_URI = "/api-links/category/category-products/?category=";
  static const String ONE_PRODUCT_URI = "/api-links/shops/products/";

  static const String SHOP_URI_NAME = "/api-links/searchshop/?search=";

  static const String PRODUCT_URI_NAME = "/api-links/searchprod/?search=";

  static const String CATEGORY_URI_NAME = "/api-links/searchcategory/?search=";

  static const String USER_URI_NAME = "/api-links/searchuser/?search=";

  static const String PROD_CAT_URI = "/api-links/category/category-products-model/?product=";

  static const String ALL_SALELIST_URI = "/api-links/sale/sale/";

  static const String YEAR_SALELIST_URI = "/api-links/history/";

  static const String USER_SALELIST_URI = "/api-links/sale/user-history-allsale/?sender=";

  static const String SHOP_STAT_URI = "/api-links/shops/shop-stat/";

  static const String USER_SHOP_STAT_URI = "/api-links/sale/stat-user/?username=";

  static bool isfinishedRotate = false;

  //! auth end points

  static const String REGISTRATION_URI = "/api-links/auth/";
  static const String LOGIN_URI = "/api-links/login/";
  static const String SALES_URI = "/api-links/self-sale/";

  //! save user info

  static String TOKEN = "DBToken";
  static String COOKIE = "";
  static Map<String, String>? HEADERS = {};
  static String USERNAME = "";

  static String PASSWORD = "";

  static const String APP_NAME = "BorgiaApp";
  static const int APP_VERSION = 1;

  static const String BASE_URL = "https://borgia.josue.to";

  static const String UPLOAD_URL = "/uploads/";

  static const String CART_LIST = "Cart-list";

  static const String CART_HISTORY_LIST = "Cart-history-list";

  static int CAT_MODULE_ID = 1;

  static int SHOP_ID = 1;

  static List CAT_LIST = [];

  static List CAT_LIST_MODULE = [];
}
