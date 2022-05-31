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

  //* var for cart control
  //! var for getPopularProductList

  //!

  //! var for setQuantity

  final int _quantity = 0;

  int get quantity => _quantity;

  int get inCartItem => _quantity;

  Future<void> getProductList(int shopId) async {
    Response response = await productRepo.getProductList(shopId);

    if (kDebugMode) {
      print("Product status code " + response.statusCode.toString());
    }

    if (response.statusCode == 200) {
      _productList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        _productList.add(ProductModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;

      update();
    } else {}
  }

  Future<void> getOneProduct(String linkToTheProduct) async {
    Response response = await productRepo.getOneProduct(linkToTheProduct);

    if (kDebugMode) {
      print("Product status code " + response.statusCode.toString());
    }
    if (response.statusCode == 200) {
      _productList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        _productList.add(ProductModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;

      update();
    } else {}
  }
}
