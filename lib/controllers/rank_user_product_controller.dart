import 'dart:developer';

import 'package:get/get.dart';

import '../data/repository/rank_user_product_repo.dart';
import '../models/rank_user_product_model.dart';

class RankUserProductController extends GetxController {
  final RankUserProductRepo rankUserProductRepo;

  RankUserProductController({required this.rankUserProductRepo});

  List<dynamic> _productStatList = [];

  List<dynamic> get productStatList => _productStatList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRankUserList(int shopId) async {
    Response response = await rankUserProductRepo.getRankUserProductList(shopId);

    if (response.statusCode == 200) {
      _productStatList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        _productStatList.add(RankUserProductModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;

      update();
    } else {}
  }
}
