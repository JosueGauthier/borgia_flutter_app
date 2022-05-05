import 'dart:developer';

import 'package:borgiaflutterapp/data/repository/product_list_from_category_repo.dart';
import 'package:borgiaflutterapp/models/product_list_from_category_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/product_repo.dart';
import '../models/cart_product_model.dart';
import '../models/product_model.dart';
import '../utils/colors.dart';
import 'cart_controller.dart';

class ProductFromCategoryController extends GetxController {
  final ProductFromCategoryRepo productFromCategoryRepo;
  final ProductRepo productRepo;

  ProductFromCategoryController({required this.productFromCategoryRepo, required this.productRepo});

  List<dynamic> _productLinkList = [];

  int _quantity = 0;

  int get inCartItem => _quantity;

  List<dynamic> get productLinkList => _productLinkList;

  List<dynamic> _productList = [];

  List<dynamic> get productList => _productList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  //* var for cart control
  //! var for getPopularProductList

  //!
  late CartController _cartController;

  CartController get theCartController => _cartController;

  //! var for setQuantity

  //int _quantity = 0;

  //int get quantity => _quantity;

  /* int _incartItem = 0; */

  //int get inCartItem => _quantity;

  //* var for cart control

  Future<void> getProduct(int categoryId) async {
    Response response = await productFromCategoryRepo.getProductList(categoryId);

    if (response.statusCode == 200) {
      _productLinkList = [];
      _productList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        _productLinkList.add(ProductListFromCategoryModel.fromJson(responseBody[i]));

        Response responseGetOneProduct = await productRepo.getOneProduct(_productLinkList[i].product);

        if (responseGetOneProduct.statusCode == 200) {
          var responseGetOneProductBody = responseGetOneProduct.body;
          _productList.add(ProductModel.fromJsonPlusMainId(responseGetOneProductBody, responseBody[i]["id"]));
        } else {}
      }

      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantityToZero() {
    _quantity = 0;

    update();
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

  //* below use for cart control

  void sale_addItem(ProductModel productModel) {
    print(_quantity);
    if ((_quantity) > 0) {
      _cartController.addItem(productModel, (_quantity));
      print(_cartController);
      _quantity = 0;
      _cartController.items.forEach((key, value) {
        //print("the id is " + value.id.toString() + " the quantity is " + value.quantity.toString());
      });
    } else {
      Get.snackbar("Item count", "You should at least add one item to the cart !", backgroundColor: AppColors.mainColor, colorText: Colors.white);
    }

    update();
  }

  //? not used
  void initProduct(ProductModel productModel, CartController cartController) {
    _quantity = 1;

    // get from storage
    _cartController = cartController;

    var exist = false;
  }

  int get totalItems {
    return _cartController.totalItems;
  }

  List<CartModel> get getItems {
    return _cartController.getItems;
  }
}
