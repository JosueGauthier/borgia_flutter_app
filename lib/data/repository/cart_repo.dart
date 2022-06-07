import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_product_model.dart';
import '../../utils/app_constants.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];

  List<String> cartHistory = [];

  //! convertit le contenu du panier en une chaine de caractère json
  //! convert objects to string because shared pref only accept string

  void addToCartList(List<CartModel> cartList) {
    cart = [];

    for (var element in cartList) {
      return cart.add(jsonEncode(element));
    }

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    print(sharedPreferences.getStringList(AppConstants.CART_LIST));
    getCartList();
  }

  //! convertit une string json en objet CartModel
  List<CartModel> getCartList() {
    List<String> carts = [];

    print(carts);

    print("here" + sharedPreferences.containsKey(AppConstants.CART_LIST).toString());

    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("inside cart" + carts.toString());
    }

    List<CartModel> cartList = [];

    //? les deux blocs realisent la meme chose.

    for (var element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }

    //*carts.forEach((element) => CartModel.fromJson(jsonDecode(element)));

    return cartList;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }

    removeCart();

    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    List<CartModel> cartListHistory = [];
    for (var element in cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartListHistory;
  }
}
