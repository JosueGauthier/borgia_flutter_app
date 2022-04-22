import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class ProductRepo extends GetxService {
  final ApiClient apiClient;

  ProductRepo({required this.apiClient});

  Future<Response> getProductList(int shop_id) async {
    String product_url = AppConstants.PRODUCT_URI + shop_id.toString();
    return await apiClient.getData(product_url);
  }

  Future<Response> getOneProduct(String link_to_the_product) async {
    String product_url = link_to_the_product;
    return await apiClient.getDataWithoutBaseUrl(product_url);
  }
}
