import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class UserShopStatRepo extends GetxService {
  final ApiClient apiClient;

  UserShopStatRepo({required this.apiClient});

  Future<Response> getUserShopStatList() async {
    return await apiClient.getData(AppConstants.USER_SHOP_STAT_URI + AppConstants.USERNAME);
  }

  Future<Response> getUserRank() async {
    return await apiClient.getData(AppConstants.RANK_USER_URI);
  }
}
