import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class SaleListRepo extends GetxService {
  final ApiClient apiClient;

  SaleListRepo({required this.apiClient});

  Future<Response> getSaleList() async {
    return await apiClient.getData(AppConstants.ALL_SALELIST_URI);
  }
}
