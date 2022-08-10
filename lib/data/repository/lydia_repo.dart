import 'package:borgiaflutterapp/admin/models/create_product_model.dart';
import 'package:borgiaflutterapp/data/api/api_client.dart';
import 'package:borgiaflutterapp/models/lydia_model.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:get/get.dart';

class LydiaRepo {
  final ApiClient apiClient;

  LydiaRepo({
    required this.apiClient,
  });

  Future<Response> lydiaAPIDoRequest(LydiaModel lydiaModel) async {
    print(lydiaModel.toJson());
    return await apiClient.postData(AppConstants.LYDIA_DO_REQUEST_URI, lydiaModel.toJson());
  }
}
