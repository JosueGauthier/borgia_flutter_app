import 'dart:developer';

import 'package:borgiaflutterapp/data/repository/category_list_repo.dart';
import 'package:borgiaflutterapp/models/categories_shop_model.dart';
import 'package:borgiaflutterapp/models/product_model.dart';
import 'package:borgiaflutterapp/models/shop_model.dart';
import 'package:get/get.dart';

import '../data/repository/product_repo.dart';

class CategoryOfShopController extends GetxController {
  final CategoryOfShopRepo categoryOfShopRepo;

  CategoryOfShopController({required this.categoryOfShopRepo});

  List<dynamic> _categoryOfShopList = [];

  List<dynamic> get categoryOfShopList => _categoryOfShopList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getCategoryList(int shop_id) async {
    Response response = await categoryOfShopRepo.getProductList(shop_id);
    //print(response);

    print("Category from shop status code " + response.statusCode.toString());

    if (response.statusCode == 200) {
      _categoryOfShopList = [];

      //print("response : " + response.body.toString());

      List response_body = response.body;

      print("the length is " + response_body.length.toString());
      //print("the shop number is " + response_body.length.toString());

      for (var i = 0; i < response_body.length; i++) {
        _categoryOfShopList.add(CategoryOfShopModel.fromJson(response_body[i]));
      }
      _isLoaded = true;

      //inspect(_productList);

      update();
    } else {}
  }
}
