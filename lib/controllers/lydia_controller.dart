import 'dart:developer';

import 'package:borgiaflutterapp/data/repository/lydia_repo.dart';
import 'package:borgiaflutterapp/models/lydia_model.dart';
import 'package:borgiaflutterapp/models/response_model.dart';
import 'package:get/get.dart';

class LydiaDoRequestController extends GetxController implements GetxService {
  final LydiaDoRequestRepo lydiaDoRequestRepo;

  LydiaDoRequestController({required this.lydiaDoRequestRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late String _collectPageLydiaUrl;
  String get collectPageLydiaUrl => _collectPageLydiaUrl;

  Future<ResponseModel> lydiaAPIDoRequest(LydiaModelDoRequestModel lydiaModelDoRequest) async {
    _isLoading = true;

    update();

    Response response = await lydiaDoRequestRepo.lydiaAPIDoRequest(lydiaModelDoRequest);
    late ResponseModel responseModel;

    inspect(response.body);

    if (response.statusCode == 202) {
      responseModel = ResponseModel(true, "Succes");

      _collectPageLydiaUrl = response.body;
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;

    update();

    return responseModel;
  }
}

class LydiaStateRequestController extends GetxController implements GetxService {
  final LydiaStateRequestRepo lydiaStateRequestRepo;

  LydiaStateRequestController({required this.lydiaStateRequestRepo});

  //! State Request

  bool _isLoadedStateRequest = false;
  bool get isLoadedStateRequest => _isLoadedStateRequest;

  late int _state;
  int get state => _state;

  Future<ResponseModel> lydiaAPIStateRequest(LydiaModelStateRequestModel lydiaModelStateRequestModel) async {
    update();

    Response response = await lydiaStateRequestRepo.lydiaAPIStateRequest(lydiaModelStateRequestModel);
    late ResponseModel responseModel;

    inspect(response.body);

    if (response.statusCode == 202) {
      responseModel = ResponseModel(true, "Succes");

      _state = response.body;
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoadedStateRequest = true;

    update();

    return responseModel;
  }
}
