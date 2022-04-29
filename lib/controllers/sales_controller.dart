// ignore_for_file: unused_import

import 'package:borgiaflutterapp/data/repository/auth_repo.dart';
import 'package:borgiaflutterapp/data/repository/sales_repo.dart';
import 'package:borgiaflutterapp/models/response_model.dart';
import 'package:borgiaflutterapp/models/sales_model.dart';
import 'package:borgiaflutterapp/models/signup_body_model.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalesController extends GetxController implements GetxService {
  final SalesRepo salesRepo;

  SalesController({required this.salesRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //String username, String pasword,int api_operator_pk, int api_module_pk, int api_shop_pk, int api_ordered_quantity, int api_category_product_id

  Future<ResponseModel> order(SalesModel salesModel) async {
    _isLoading = true;

    update();

    Response response = await salesRepo.order(salesModel);
    late ResponseModel responseModel; //late => before we use it we need to initialize it

    if (response.statusCode == 202) {
      //print(response.headers);

      //print("the header set cookie " + response.headers!["set-cookie"].toString());

      responseModel = ResponseModel(true, "Succes");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;

    update();

    return responseModel;
  }
}
