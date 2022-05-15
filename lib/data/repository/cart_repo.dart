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

  void addToCartList(List<CartModel> cartList) {
    cart = [];

    var time = DateTime.now();

    /*
    ?convert objects to string because shared pref only accept string*/

    for (var element in cartList) {
      element.time = time.toString();
      return cart.add(jsonEncode(element));
    }

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    //print(sharedPreferences.getStringList(AppConstats.CART_LIST));
    getCartList();
  }

  //! convertit une string json en objet CartModel
  List<CartModel> getCartList() {
    //print("aaaa");
    List<String> carts = [];

    print(sharedPreferences.containsKey(AppConstants.CART_LIST).toString());

    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("inside getCartList" + carts.toString());
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
      //print("history list" + cart[i]);
      cartHistory.add(cart[i]);
    }

    removeCart();

    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
    //print("The length of history is " + getCartHistoryList().length.toString());
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      //cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    List<CartModel> cartListHistory = [];
    for (var element in cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartListHistory;
  }
}
