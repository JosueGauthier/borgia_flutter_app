import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class OtherUserRepo extends GetxService {
  final ApiClient apiClient;

  OtherUserRepo({required this.apiClient});

  Future<Response> getUserList(String username) async {
    return await apiClient.getData(AppConstants.USER_URI + username);
  }

  Future<Response> getOtherUserList(String username) async {
    return await apiClient.getData(AppConstants.SEARCH_USER_URI + username);
  }
}
