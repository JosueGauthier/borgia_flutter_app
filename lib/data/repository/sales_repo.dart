import 'package:borgiaflutterapp/data/api/api_client.dart';
import 'package:borgiaflutterapp/models/operator_sales_model.dart';
import 'package:borgiaflutterapp/models/self_sales_model.dart';
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

  Future<Response> selfOrder(SelfSalesModel salesModel) async {
    return await apiClient.postData(AppConstants.SELF_SALES_URI, salesModel.toJson());
  }

  Future<Response> operatorOrder(OperatorSalesModel salesModel) async {
    return await apiClient.postData(AppConstants.OPERATOR_SALES_URI, salesModel.toJson());
  }
}
