import 'package:borgiaflutterapp/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../data/repository/product_repo.dart';

class ProductController extends GetxController {
  final ProductRepo productRepo;

  ProductController({required this.productRepo});

  List<dynamic> _productList = [];

  List<dynamic> get productList => _productList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

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
