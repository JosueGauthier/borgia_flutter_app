import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class ProductFromCategoryRepo extends GetxService {
  final ApiClient apiClient;

  ProductFromCategoryRepo({required this.apiClient});

  Future<Response> getProductList(int categoryId) async {
    String productListUrl = AppConstants.PRODUCT_FROM_CATEGORY_URI + categoryId.toString();
    //print(productListUrl);
    return await apiClient.getData(productListUrl);
  }
}
