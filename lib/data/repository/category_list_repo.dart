import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class CategoryOfShopRepo extends GetxService {
  final ApiClient apiClient;

  CategoryOfShopRepo({required this.apiClient});

  Future<Response> getProductList(int shopId) async {
    String categoryUrl = AppConstants.CATEGORY_URI + shopId.toString();
    return await apiClient.getData(categoryUrl);
  }
}
