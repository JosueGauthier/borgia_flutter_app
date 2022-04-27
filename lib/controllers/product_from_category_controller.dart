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

  Future<void> getProduct(int categoryId) async {
    Response response = await productFromCategoryRepo.getProductList(categoryId);

    if (response.statusCode == 200) {
      _productLinkList = [];
      _productList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        _productLinkList.add(ProductListFromCategoryModel.fromJson(responseBody[i]));

        //print(_productLinkList[i].product);

        Response responseGetOneProduct = await productRepo.getOneProduct(_productLinkList[i].product);
        //print(responseGetOneProduct.body);
        //print("the status code is" + responseGetOneProduct.statusCode.toString());
        if (responseGetOneProduct.statusCode == 200) {
          var responseGetOneProductBody = responseGetOneProduct.body;
          _productList.add(ProductModel.fromJson(responseGetOneProductBody));
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
