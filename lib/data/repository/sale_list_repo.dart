import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class SaleListRepo extends GetxService {
  final ApiClient apiClient;

  SaleListRepo({required this.apiClient});

  Future<Response> getYearSaleList() async {
    return await apiClient.getData(AppConstants.YEAR_SALELIST_URI);
  }

  Future<Response> getHourSaleList() async {
    return await apiClient.getData(AppConstants.HOUR_SALELIST_URI);
  }

  Future<Response> getSaleUserList() async {
    return await apiClient.getData(AppConstants.USER_SALELIST_URI + AppConstants.USERNAME);
  }
}
