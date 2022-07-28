import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class ProductListRepo extends GetxService {
  final ApiClient apiClient;

  ProductListRepo({required this.apiClient});

  Future<Response> getProductList(int categoryId) async {
    String productListUrl = AppConstants.PRODUCT_LIST_URI + categoryId.toString();
    return await apiClient.getData(productListUrl);
  }

  Future<Response> getProductById(int id) async {
    String productUrl = AppConstants.PRODUCT_URI_NAME + id.toString();
    return await apiClient.getData(productUrl);
  }

  Future<Response> getShopProductList(int shopId) async {
    String productListUrl = AppConstants.PRODUCT_LIST_URI_FROM_SHOP + shopId.toString();
    return await apiClient.getData(productListUrl);
  }
}
