import 'package:borgiaflutterapp/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../data/repository/product_repo.dart';

// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../data/repository/popular_product_repo.dart';
import '../models/Popular_product_model.dart';
import '../models/cart_product_model.dart';
import '../utils/colors.dart';
import 'cart_controller.dart';

class ProductController extends GetxController {
  final ProductRepo productRepo;

  ProductController({required this.productRepo});

  List<dynamic> _productList = [];

  List<dynamic> get productList => _productList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  //* var for cart control
  //! var for getPopularProductList

  //!
  late CartController _cartController;

  //! var for setQuantity

  int _quantity = 0;

  int get quantity => _quantity;

  int _incartItem = 0;

  int get inCartItem => _quantity;

  Future<void> getProductList(int shopId) async {
    Response response = await productRepo.getProductList(shopId);

    if (kDebugMode) {
      print("Product status code " + response.statusCode.toString());
    }

    if (response.statusCode == 200) {
      _productList = [];

      //print("response : " + response.body.toString());

      List responseBody = response.body;

      //print("the length is " + response_body.length.toString());
      //print("the shop number is " + response_body.length.toString());

      for (var i = 0; i < responseBody.length; i++) {
        _productList.add(ProductModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;

      //inspect(_productList);

      update();
    } else {}
  }

  Future<void> getOneProduct(String linkToTheProduct) async {
    Response response = await productRepo.getOneProduct(linkToTheProduct);
    //print(response);

    if (kDebugMode) {
      print("Product status code " + response.statusCode.toString());
    }

    if (response.statusCode == 200) {
      _productList = [];

      //print("response : " + response.body.toString());

      List responseBody = response.body;

      //print("the length is " + response_body.length.toString());
      //print("the shop number is " + response_body.length.toString());

      for (var i = 0; i < responseBody.length; i++) {
        _productList.add(ProductModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;

      //inspect(_productList);

      update();
    } else {}
  }
}
