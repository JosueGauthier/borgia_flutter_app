import 'package:get/get.dart';

import '../../data/api/api_client.dart';
import '../../utils/app_constants.dart';

class SaleModuleRepo extends GetxService {
  final ApiClient apiClient;

  SaleModuleRepo({required this.apiClient});

  Future<Response> getOperatorsaleModuleList() async {
    return await apiClient.getData(AppConstants.OPERATOR_MODULE_URI);
  }

  Future<Response> getSelfsaleModuleList() async {
    return await apiClient.getData(AppConstants.SELFSALE_MODULE_URI);
  }
}
