import 'package:borgiaflutterapp/admin/models/update_product_model.dart';
import 'package:borgiaflutterapp/admin/models/update_shop_model.dart';
import 'package:borgiaflutterapp/data/api/api_client.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:get/get.dart';

class UpdateShopRepo {
  final ApiClient apiClient;

  UpdateShopRepo({
    required this.apiClient,
  });

  Future<Response> updateShop(UpdateShopModel updateShopModel) async {
    return await apiClient.postData(AppConstants.UPDATE_SHOP_URI, updateShopModel.toJson());
  }
}
