import 'dart:developer';

import 'package:borgiaflutterapp/controllers/product_controller.dart';
import 'package:borgiaflutterapp/data/repository/product_list_from_category_repo.dart';
import 'package:borgiaflutterapp/models/product_list_from_category_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/product_repo.dart';
import '../models/product_model.dart';
import '../utils/colors.dart';

class ProductFromCategoryController extends GetxController {
  final ProductFromCategoryRepo productFromCategoryRepo;
  final ProductRepo productRepo;

  ProductFromCategoryController({required this.productFromCategoryRepo, required this.productRepo});

  List<dynamic> _productLinkList = [];

  int _quantity = 0;

  int get inCartItem => _quantity;

  int get quantity => _quantity;

  List<dynamic> get productLinkList => _productLinkList;

  List<dynamic> _productList = [];

  List<dynamic> get productList => _productList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getProduct(int category_id) async {
    Response response = await productFromCategoryRepo.getProductList(category_id);

    if (response.statusCode == 200) {
      _productLinkList = [];
      _productList = [];

      List response_body = response.body;

      for (var i = 0; i < response_body.length; i++) {
        _productLinkList.add(ProductListFromCategoryModel.fromJson(response_body[i]));

        //print(_productLinkList[i].product);

        Response responseGetOneProduct = await productRepo.getOneProduct(_productLinkList[i].product);
        //print(responseGetOneProduct.body);
        //print("the status code is" + responseGetOneProduct.statusCode.toString());
        if (responseGetOneProduct.statusCode == 200) {
          var responseGetOneProduct_body = responseGetOneProduct.body;
          _productList.add(ProductModel.fromJson(responseGetOneProduct_body));
        } else {}
      }

      //print("the productlist is " + _productList.toString());

      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    //print(_quantity);

    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else if (isIncrement == false && (_quantity) > 0) {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int qquantity) {
    if ((qquantity) < 0) {
      Get.snackbar("Item count", "You can't reduce more !", backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 0;
    } else if ((qquantity) > 20) {
      Get.snackbar("Item count", "You can't add more ! ", backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return qquantity;
    }
  }
}
