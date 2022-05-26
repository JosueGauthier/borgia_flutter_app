import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class RankUserStatRepo extends GetxService {
  final ApiClient apiClient;

  RankUserStatRepo({required this.apiClient});

  Future<Response> getRankUserList() async {
    return await apiClient.getData(AppConstants.RANK_USER_SHOP_STAT_URI);
  }

  /* Future<Response> getSaleUserList() async {
    return await apiClient.getData(AppConstants.USER_SALELIST_URI + AppConstants.USERNAME);
  } */
}
