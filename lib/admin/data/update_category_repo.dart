import 'package:borgiaflutterapp/data/api/api_client.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:get/get.dart';

import '../models/update_category_model.dart';

class UpdateCategoryRepo {
  final ApiClient apiClient;

  UpdateCategoryRepo({
    required this.apiClient,
  });

  Future<Response> updateCategory(UpdateCategoryModel updateCategoryModel) async {
    return await apiClient.postData(AppConstants.UPDATE_CATEGORY_URI, updateCategoryModel.toJson());
  }
}
