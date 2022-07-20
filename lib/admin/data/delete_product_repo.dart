import 'package:borgiaflutterapp/admin/models/delete_product_model.dart';
import 'package:borgiaflutterapp/data/api/api_client.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:get/get.dart';

class DeleteProductRepo {
  final ApiClient apiClient;

  DeleteProductRepo({
    required this.apiClient,
  });

  Future<Response> deleteProduct(DeleteProductModel deleteProductModel) async {
    return await apiClient.postData(AppConstants.DELETE_PRODUCT_URI, deleteProductModel.toJson());
  }
}
