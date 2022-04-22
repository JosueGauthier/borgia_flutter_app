class AppConstants {
  static const String SHOP_URI = "/api-links/shops/shops/?format=json";
  static const String PRODUCT_URI = "/api-links/shops/products/?shop=";
  static const String CATEGORY_URI = "/api-links/category/category/?module_id=";
  static const String PRODUCT_FROM_CATEGORY_URI = "/api-links/category/category-products/?category=";

  //http://localhost:8000/api-links/category/category-products/?category=13
  //http://localhost:8000/api-links/category/category/12/

  //http://localhost:8000/api-links/category/category/?module_id=3

  static const String APP_NAME = "BorgiaApp";
  static const int APP_VERSION = 1;

  //static const String BASE_URL = "http://mvs.bslmeiyu.com";

  static const String BASE_URL = "http://10.0.2.2:8000";

  //"https://api.jsonbin.io" "/b/625dc4f5c5284e31154ef250"

  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";

  //static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";

  static const String RECOMMENDED_PRODUCT_URI = "/ae4a7daedb41dd157811";

  static const String UPLOAD_URL = "/uploads/";

  static const String TOKEN = "DBToken";

  static const String CART_LIST = "Cart-list";

  static const String CART_HISTORY_LIST = "Cart-history-list";
}
