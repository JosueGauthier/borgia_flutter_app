import 'package:borgiaflutterapp/data/api/api_client.dart';
import 'package:borgiaflutterapp/models/signup_body_model.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;

  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> registration(SignUpBodyModel signUpBodyModel) async {
    return await apiClient.postData(AppConstants.REGISTRATION_URI, signUpBodyModel.toJson());
  }

  Future<Response> login(String username, String password) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, {"username": username, "password": password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);

    AppConstants.TOKEN = token;

    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  saveUserHeaders(Map<String, String>? token) async {
    AppConstants.HEADERS = token;
  }

  Future<void> saveUsernameAndPassword(String username, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USERNAME, username);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }
}
