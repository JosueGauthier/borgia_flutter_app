import 'dart:developer';

import 'package:borgiaflutterapp/models/product_model.dart';
import 'package:borgiaflutterapp/models/shop_model.dart';
import 'package:get/get.dart';

import '../data/repository/product_repo.dart';

class ProductController extends GetxController {
  final ProductRepo productRepo;

  ProductController({required this.productRepo});

  List<dynamic> _productList = [];

  List<dynamic> get productList => _productList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getProductList(int shop_id) async {
    Response response = await productRepo.getProductList(shop_id);

    print("Product status code " + response.statusCode.toString());

    if (response.statusCode == 200) {
      _productList = [];

      //print("response : " + response.body.toString());

      List response_body = response.body;

      //print("the length is " + response_body.length.toString());
      //print("the shop number is " + response_body.length.toString());

      for (var i = 0; i < response_body.length; i++) {
        _productList.add(ProductModel.fromJson(response_body[i]));
      }
      _isLoaded = true;

      //inspect(_productList);

      update();
    } else {}
  }

  Future<void> getOneProduct(String link_to_the_product) async {
    Response response = await productRepo.getOneProduct(link_to_the_product);
    //print(response);

    print("Product status code " + response.statusCode.toString());

    if (response.statusCode == 200) {
      _productList = [];

      //print("response : " + response.body.toString());

      List response_body = response.body;

      print("the length is " + response_body.length.toString());
      //print("the shop number is " + response_body.length.toString());

      for (var i = 0; i < response_body.length; i++) {
        _productList.add(ProductModel.fromJson(response_body[i]));
      }
      _isLoaded = true;

      //inspect(_productList);

      update();
    } else {}
  }
}
