import 'dart:developer';

import 'package:borgiaflutterapp/data/repository/search_repo.dart';
import 'package:borgiaflutterapp/models/categories_shop_model.dart';
import 'package:borgiaflutterapp/models/product_model.dart';
import 'package:borgiaflutterapp/models/shop_model.dart';
import 'package:borgiaflutterapp/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final SearchRepo searchRepo;

  SearchController({required this.searchRepo});

  List<dynamic> _searchList = [];

  List<dynamic> get searchList => _searchList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getSearchList(String keyword) async {
    Response responseProduct = await searchRepo.getSearchListProduct(keyword);
    Response responseCategory = await searchRepo.getSearchListCategory(keyword);
    Response responseShop = await searchRepo.getSearchListShop(keyword);
    Response responseUser = await searchRepo.getSearchListUser(keyword);

    /* if (kDebugMode) {
      print("Search status code " + response.statusCode.toString());
    }
    */

    _searchList = [];

    if (responseProduct.statusCode == 200) {
      List responseBody = responseProduct.body;

      for (var i = 0; i < responseBody.length; i++) {
        _searchList.add(ProductModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;

      //update();
    } else {}

    if (responseCategory.statusCode == 200) {
      List responseBody = responseCategory.body;

      for (var i = 0; i < responseBody.length; i++) {
        _searchList.add(CategoryOfShopModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;

      //update();
    } else {}

    if (responseShop.statusCode == 200) {
      List responseBody = responseShop.body;

      for (var i = 0; i < responseBody.length; i++) {
        _searchList.add(ShopModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;

      //inspect(_productList);

      //update();
    } else {}

    if (responseUser.statusCode == 200) {
      List responseBody = responseUser.body;

      for (var i = 0; i < responseBody.length; i++) {
        _searchList.add(UserModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;

      //inspect(_productList);

    } else {}

    print("the search list is : " + _searchList.toString());
    inspect(_searchList);
    update();
  }

/*   Future<void> getOneProduct(String linkToTheProduct) async {
    Response response = await searchRepo.getOneProduct(linkToTheProduct);
    //print(response);

    if (kDebugMode) {
      print("Product status code " + response.statusCode.toString());
    }

    if (response.statusCode == 200) {
      _searchList = [];

      //print("response : " + response.body.toString());

      List responseBody = response.body;

      //print("the length is " + response_body.length.toString());
      //print("the shop number is " + response_body.length.toString());

      for (var i = 0; i < responseBody.length; i++) {
        _searchList.add(ProductModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;

      //inspect(_productList);

      update();
    } else {}
  } */
}
