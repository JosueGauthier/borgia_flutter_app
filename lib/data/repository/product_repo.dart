import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class ProductRepo extends GetxService {
  final ApiClient apiClient;

  ProductRepo({required this.apiClient});

  Future<Response> getProductList(int shopId) async {
    String productUrl = AppConstants.PRODUCT_URI + shopId.toString();
    return await apiClient.getData(productUrl);
  }

  Future<Response> getOneProduct(String linkToTheProduct) async {
    String productUrl = linkToTheProduct;
    return await apiClient.getDataWithoutBaseUrl(productUrl);
  }
}
