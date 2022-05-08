import 'package:get/get.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class CategoryFromProductRepo extends GetxService {
  final ApiClient apiClient;

  CategoryFromProductRepo({required this.apiClient});

  Future<Response> getCatList(int productId) async {
    String categoryListUrl = AppConstants.PROD_CAT_URI + productId.toString();
    return await apiClient.getData(categoryListUrl);
  }
}
