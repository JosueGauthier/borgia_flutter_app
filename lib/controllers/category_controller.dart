import 'dart:developer';

import 'package:borgiaflutterapp/data/repository/category_list_repo.dart';
import 'package:borgiaflutterapp/models/categories_shop_model.dart';
import 'package:get/get.dart';

class CategoryOfShopController extends GetxController {
  final CategoryOfShopRepo categoryOfShopRepo;

  CategoryOfShopController({required this.categoryOfShopRepo});

  List<dynamic> _categoryOfShopList = [];

  List<dynamic> get categoryOfShopList => _categoryOfShopList;

  List<dynamic> _categoryAdminList = [];

  List<dynamic> get categoryAdminList => _categoryAdminList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getCategoryList(int shopId) async {
    Response response = await categoryOfShopRepo.getProductList(shopId);

    if (response.statusCode == 200) {
      _categoryOfShopList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        var categoryShopModel = CategoryOfShopModel.fromJson(responseBody[i]);

        if (categoryShopModel.contentType!.model == 'selfsalemodule') {
          _categoryOfShopList.add(categoryShopModel);
        }
      }
      _isLoaded = true;

      update();
    } else {}
  }

  Future<void> getAdminCategoryList(int shopId) async {
    Response response = await categoryOfShopRepo.getProductList(shopId);

    if (response.statusCode == 200) {
      _categoryAdminList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        var categoryShopModel = CategoryOfShopModel.fromJson(responseBody[i]);

        if (categoryShopModel.contentType!.model == 'operatorsalemodule') {
          _categoryAdminList.add(categoryShopModel);
        }
      }

      _isLoaded = true;

      update();
    } else {}
  }
}
