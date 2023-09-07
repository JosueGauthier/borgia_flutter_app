import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class SearchRepo extends GetxService {
  final ApiClient apiClient;

  SearchRepo({required this.apiClient});

  Future<Response> getSearchListProduct(String keyword) async {
    String productUrl = AppConstants.PRODUCT_URI_NAME + keyword;
    return await apiClient.getData(productUrl);
  }

  Future<Response> getSearchListCategory(String keyword) async {
    String catUrl = AppConstants.SEARCH_CATEGORY_URI + keyword;
    return await apiClient.getData(catUrl);
  }

  // Future<Response> getSearchListUser(String keyword) async {
  //   String userUrl = AppConstants.SEARCH_USER_URI + keyword;
  //   return await apiClient.getData(userUrl);
  // }

  Future<Response> getSearchListShop(String keyword) async {
    String shopUrl = AppConstants.SEARCH_SHOP_URI + keyword;
    return await apiClient.getData(shopUrl);
  }
}
