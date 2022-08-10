import 'dart:developer';

import 'package:borgiaflutterapp/data/repository/lydia_repo.dart';
import 'package:borgiaflutterapp/models/lydia_model.dart';
import 'package:borgiaflutterapp/models/response_model.dart';
import 'package:get/get.dart';

class LydiaController extends GetxController implements GetxService {
  final LydiaRepo lydiaRepo;

  LydiaController({required this.lydiaRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> lydiaAPIDoRequest(LydiaModel lydiaModel) async {
    _isLoading = true;

    update();

    Response response = await lydiaRepo.lydiaAPIDoRequest(lydiaModel);
    late ResponseModel responseModel;

    inspect(response);

    if (response.statusCode == 202) {
      responseModel = ResponseModel(true, "Succes");
      print(responseModel);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;

    update();

    return responseModel;
  }
}