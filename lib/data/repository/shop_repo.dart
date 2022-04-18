import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class ShopRepo extends GetxService {
  final ApiClient apiClient;

  ShopRepo({required this.apiClient});

  Future<Response> getShopList() async {
    return await apiClient.getData(AppConstants.SHOP_URI);
  }
}
