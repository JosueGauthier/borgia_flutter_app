import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class ProductFromCategoryRepo extends GetxService {
  final ApiClient apiClient;

  ProductFromCategoryRepo({required this.apiClient});

  Future<Response> getProductList(int category_id) async {
    String productList_url = AppConstants.PRODUCT_FROM_CATEGORY_URI + category_id.toString();
    return await apiClient.getData(productList_url);
  }
}
