import 'package:borgiaflutterapp/data/api/api_client.dart';
import 'package:borgiaflutterapp/models/sales_model.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalesRepo {
  final ApiClient apiClient;

  final SharedPreferences sharedPreferences;

  SalesRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> order(SalesModel salesModel) async {
    //print(salesModel.toJson());

    return await apiClient.postData(AppConstants.SALES_URI, salesModel.toJson());
  }
}
