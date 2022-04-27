import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../data/repository/recommended_repo.dart';
import '../models/Popular_product_model.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedRepo;

  RecommendedProductController({required this.recommendedRepo});

  List<dynamic> _recommendedProductList = [];

  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecomendedProductList() async {
    Response response = await recommendedRepo.getRecommendedProductList();

    if (kDebugMode) {
      print("Recommended status code " + response.statusCode.toString());
    }

    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      //print(recommendedProductList);
      _isLoaded = true;

      update();
    } else {}
  }
}
