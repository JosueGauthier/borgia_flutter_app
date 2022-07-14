import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/product_list_repo.dart';
import '../models/cart_product_model.dart';
import '../models/product_model.dart';
import '../utils/colors.dart';
import 'cart_controller.dart';

class ProductListController extends GetxController {
  final ProductListRepo productListRepo;

  ProductListController({required this.productListRepo});

  int quantity = 0;

  int get inCartItem => quantity;

  List<dynamic> _productList = [];

  List<dynamic> get productList => _productList;

  List<dynamic> _shopProductList = [];

  List<dynamic> get shopProductList => _shopProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _shopProductIsLoaded = false;
  bool get shopProductIsLoaded => _shopProductIsLoaded;

  //* var for cart control
  late CartController _cartController;

  CartController get theCartController => _cartController;

  Future<void> getProduct(int categoryId) async {
    Response response = await productListRepo.getProductList(categoryId);

    if (response.statusCode == 200) {
      _productList = [];

      List responseBody = response.body;

      List listofProd = responseBody[0]["products"];

      for (var i = 0; i < listofProd.length; i++) {
        _productList.add(ProductModel.fromJson(listofProd[i]));
        _productList[i].contentTypeParentCategory = responseBody[0]["content_type"];
      }
      _isLoaded = true;

      update();
    } else {}
  }

  void setQuantityToZero() {
    quantity = 0;

    update();
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      quantity = checkQuantity(quantity + 1);
    } else if (isIncrement == false && (quantity) > 0) {
      quantity = checkQuantity(quantity - 1);
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

  void saleAddItem(
    ProductModel productModel,
  ) {
    if ((quantity) > 0) {
      _cartController.addItem(productModel, quantity, productModel.shop!);

      quantity = 0;
    } else {}

    update();
  }

  //? not used
  void initProduct(ProductModel productModel, CartController cartController) {
    quantity = 1;

    // get from storage
    _cartController = cartController;
  }

  int get totalItems {
    return _cartController.totalItems;
  }

  List<CartModel> get getItems {
    return _cartController.getItems;
  }

  Future<void> getShopProduct(int shopId) async {
    Response response = await productListRepo.getShopProductList(shopId);

    if (response.statusCode == 200) {
      _shopProductList = [];

      List responseBody = response.body;

      List listofProd = responseBody;

      for (var i = 0; i < listofProd.length; i++) {
        _shopProductList.add(ProductModel.fromJson(listofProd[i]));
        _shopProductList[i].contentTypeParentCategory = responseBody[0]["content_type"];
      }
      _shopProductIsLoaded = true;
      update();
    } else {}
  }
}
