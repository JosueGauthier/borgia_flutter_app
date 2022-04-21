import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../data/repository/popular_product_repo.dart';
import '../models/Popular_product_model.dart';
import '../models/cart_product_model.dart';
import '../utils/colors.dart';
import 'cart_controller.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  //! var for getPopularProductList

  List<dynamic> _popularProductList = [];

  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  //!
  late CartController _cartController;

  //! var for setQuantity

  int _quantity = 0;

  int _totalquantity = 0;

  int get quantity => _quantity;

  int _incartItem = 0;

  int get inCartItem => _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();

    print("Popular status code " + response.statusCode.toString());

    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      //print(popularProductList);
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

  void initProduct(oldProductModel aProduct, CartController cartController) {
    _quantity = 0;

    _incartItem = 0;
    // get from storage
    _cartController = cartController;

    var exist = false;
    exist = _cartController.existinCart(aProduct);

    //print("does it exist ? " + exist.toString());

    if (exist) {
      _quantity = _quantity + _incartItem;
      _incartItem = _cartController.getQuantity(aProduct);
    }
    //print("the quantity in the item cart is " + _incartItem.toString());
  }

  void popular_addItem(oldProductModel oldProductModel) {
    if ((_quantity) > 0) {
      _cartController.addItem(oldProductModel, (_quantity));
      _quantity = 0;
      _cartController.items.forEach((key, value) {
        //print("the id is " + value.id.toString() + " the quantity is " + value.quantity.toString());
      });
    } else {
      Get.snackbar("Item count", "You should at least add one item to the cart !", backgroundColor: AppColors.mainColor, colorText: Colors.white);
    }

    update();
  }

  int get totalItems {
    return _cartController.totalItems;
  }

  List<CartModel> get getItems {
    return _cartController.getItems;
  }
}
