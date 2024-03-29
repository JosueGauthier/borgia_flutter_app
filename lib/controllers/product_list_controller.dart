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

  bool _shopProductListIsLoaded = false;
  bool get shopProductListIsLoaded => _shopProductListIsLoaded;

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
        ProductModel produit = ProductModel.fromJson(listofProd[i]);

        if (produit.isActive == true && produit.isRemoved == false) {
          _productList.add(produit);
          int index = _productList.indexWhere((element) => element == produit);
          _productList[index].contentTypeParentCategory = responseBody[0]["content_type"];
        }
      }
      _isLoaded = true;

      update();
    } else {}
  }

  List<dynamic> _productByIdList = [];

  List<dynamic> get productByIdList => _productByIdList;

  bool _isLoadedProductId = false;
  bool get isLoadedProductId => _isLoadedProductId;

  Future<void> getProductById(int id) async {
    Response response = await productListRepo.getProductById(id);

    if (response.statusCode == 200) {
      _productByIdList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        ProductModel produit = ProductModel.fromJson(responseBody[i]);

        _productByIdList.add(produit);
        int index = _productByIdList.indexWhere((element) => element == produit);
        _productByIdList[index].contentTypeParentCategory = responseBody[0]["content_type"];
      }
      _isLoadedProductId = true;

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
        ProductModel produit = ProductModel.fromJson(listofProd[i]);

        if (produit.isRemoved == false) {
          _shopProductList.add(produit);

          int index = _shopProductList.indexWhere((element) => element == produit);
          _shopProductList[index].contentTypeParentCategory = responseBody[0]["content_type"];
        }
      }
      _shopProductListIsLoaded = true;
      update();
    } else {}
  }
}
