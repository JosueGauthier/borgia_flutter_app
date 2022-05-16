import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class ShopStatRepo extends GetxService {
  final ApiClient apiClient;

  ShopStatRepo({required this.apiClient});

  Future<Response> getShopStatList() async {
    return await apiClient.getData(AppConstants.SHOP_STAT_URI);
  }
}
