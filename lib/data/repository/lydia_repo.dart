import 'package:borgiaflutterapp/data/api/api_client.dart';
import 'package:borgiaflutterapp/models/lydia_model.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:get/get.dart';

class LydiaDoRequestRepo {
  final ApiClient apiClient;

  LydiaDoRequestRepo({
    required this.apiClient,
  });

  Future<Response> lydiaAPIDoRequest(LydiaModelDoRequestModel lydiaDoModel) async {
    return await apiClient.postData(AppConstants.LYDIA_DO_REQUEST_URI, lydiaDoModel.toJson());
  }
}

class LydiaStateRequestRepo {
  final ApiClient apiClient;

  LydiaStateRequestRepo({
    required this.apiClient,
  });

  Future<Response> lydiaAPIStateRequest(LydiaModelStateRequestModel lydiaStateModel) async {
    return await apiClient.postData(AppConstants.LYDIA_STATE_REQUEST_URI, lydiaStateModel.toJson());
  }
}
