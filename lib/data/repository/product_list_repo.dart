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
}
