import 'package:borgiaflutterapp/admin/models/delete_category_model.dart';

import 'package:borgiaflutterapp/data/api/api_client.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:get/get.dart';

class DeleteCategoryRepo {
  final ApiClient apiClient;

  DeleteCategoryRepo({
    required this.apiClient,
  });

  Future<Response> deleteCategory(DeleteCategoryModel deleteCategoryModel) async {
    return await apiClient.postData(AppConstants.DELETE_CATEGORY_URI, deleteCategoryModel.toJson());
  }
}
