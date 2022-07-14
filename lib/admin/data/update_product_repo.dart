import 'package:borgiaflutterapp/admin/models/create_product_model.dart';
import 'package:borgiaflutterapp/admin/models/update_product_model.dart';
import 'package:borgiaflutterapp/data/api/api_client.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:get/get.dart';

class UpdateProductRepo {
  final ApiClient apiClient;

  UpdateProductRepo({
    required this.apiClient,
  });

  Future<Response> updateProduct(UpdateProductModel updateProductModel) async {
    print(updateProductModel.toJson());
    return await apiClient.postData(AppConstants.UPDATE_PRODUCT_URI, updateProductModel.toJson());
  }
}
