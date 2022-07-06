import 'dart:developer';

import 'package:borgiaflutterapp/data/repository/search_repo.dart';
import 'package:borgiaflutterapp/models/categories_shop_model.dart';
import 'package:borgiaflutterapp/models/product_model.dart';
import 'package:borgiaflutterapp/models/shop_model.dart';
import 'package:borgiaflutterapp/models/user_model.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final SearchRepo searchRepo;

  SearchController({required this.searchRepo});

  List<dynamic> _searchList = [];

  List<dynamic> get searchList => _searchList;

  List<dynamic> _adminSearchList = [];

  List<dynamic> get adminSearchList => _adminSearchList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getSearchList(String keyword) async {
    Response responseProduct = await searchRepo.getSearchListProduct(keyword);
    Response responseCategory = await searchRepo.getSearchListCategory(keyword);
    Response responseShop = await searchRepo.getSearchListShop(keyword);
    Response responseUsername = await searchRepo.getSearchListUser(keyword);
    _searchList = [];

    if (responseProduct.statusCode == 200) {
      List responseBody = responseProduct.body;

      for (var i = 0; i < responseBody.length; i++) {
        _searchList.add(ProductModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;
    } else {}

    if (responseCategory.statusCode == 200) {
      List responseBody = responseCategory.body;

      for (var i = 0; i < responseBody.length; i++) {
        _searchList.add(CategoryOfShopModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;
    } else {}

    if (responseShop.statusCode == 200) {
      List responseBody = responseShop.body;

      for (var i = 0; i < responseBody.length; i++) {
        _searchList.add(ShopModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;
    } else {}

    if (responseUsername.statusCode == 200) {
      List responseBody = responseUsername.body;

      for (var i = 0; i < responseBody.length; i++) {
        _searchList.add(UserModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;
    } else {}

    update();
  }

  Future<void> getAdminUserSearchList(String keyword) async {
    Response responseUsername = await searchRepo.getSearchListUser(keyword);
    _adminSearchList = [];
    if (responseUsername.statusCode == 200) {
      List responseBody = responseUsername.body;

      for (var i = 0; i < responseBody.length; i++) {
        _adminSearchList.add(UserModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;
    } else {}

    update();
  }
}
