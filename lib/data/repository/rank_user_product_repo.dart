import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class RankUserProductRepo extends GetxService {
  final ApiClient apiClient;

  RankUserProductRepo({required this.apiClient});

  Future<Response> getRankUserProductList(int shopId) async {
    return await apiClient.getData(AppConstants.RANK_USER_PRODUCT_STAT_URI + shopId.toString());
  }
}
