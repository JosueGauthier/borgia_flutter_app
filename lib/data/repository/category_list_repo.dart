import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class CategoryOfShopRepo extends GetxService {
  final ApiClient apiClient;

  CategoryOfShopRepo({required this.apiClient});

  Future<Response> getProductList(int shop_id) async {
    String category_url = AppConstants.CATEGORY_URI + shop_id.toString();
    return await apiClient.getData(category_url);
  }
}
