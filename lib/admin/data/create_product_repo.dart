import 'package:borgiaflutterapp/admin/models/create_product_model.dart';
import 'package:borgiaflutterapp/data/api/api_client.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:get/get.dart';

class CreateProductRepo {
  final ApiClient apiClient;

  CreateProductRepo({
    required this.apiClient,
  });

  Future<Response> createProduct(CreateProductModel createProductModel) async {
    return await apiClient.postData(AppConstants.CREATE_PRODUCT_URI, createProductModel.toJson());
  }
}
