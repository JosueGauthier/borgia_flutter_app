import 'package:borgiaflutterapp/admin/models/create_category_model.dart';
import 'package:borgiaflutterapp/data/api/api_client.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:get/get.dart';

class CreateCategoryRepo {
  final ApiClient apiClient;

  CreateCategoryRepo({
    required this.apiClient,
  });

  Future<Response> createCategory(CreateCategoryModel createCategoryModel) async {
    return await apiClient.postData(AppConstants.CREATE_CATEGORY_URI, createCategoryModel.toJson());
  }
}
