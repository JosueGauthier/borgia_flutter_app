import 'dart:developer';
import 'package:borgiaflutterapp/models/product_model.dart';
import 'package:get/get.dart';
import '../data/repository/cart_repo.dart';
import '../models/cart_product_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

  //! only for storage and sharedpreferences
  List<CartModel> storageItems = [];

  void addItem(ProductModel productModel, int quantity, int shopId) {
    if (_items.containsKey(productModel.id!)) {
      _items.update(productModel.id!, (value) {
        return CartModel(
          id: value.id,
          name: value.name,
          quantity: value.quantity! + quantity,
          time: DateTime.now().toString(),
          aProduct: productModel,
        );
      });
    } else {
      //?ajoute si l'item n'existe pas encore
      _items.putIfAbsent(productModel.id!, () {
        return CartModel(
          id: productModel.id,
          name: productModel.name,
          quantity: quantity,
          time: DateTime.now().toString(),
          aProduct: productModel,
        );
      });
    }
    /* if (_items[productModel.id]?.quantity! == 0) {
      print("je suis la");
      _items.remove(productModel.id!);
    } */
    cartRepo.addToCartList(getItems);
    update();
  }
  //!

  int get totalItems {
    int totalQuantity = 0;

    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });

    return totalQuantity;
  }

  List<CartModel> get getItems {
    //? e est un item de cartModel avec int, CartModel
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  //! set fonction quand elle est appellé alloue une valeur a une variable
  set setCart(List<CartModel> items) {
    storageItems = items;

    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].aProduct!.id!, () => storageItems[i]);
    }
  }

  void clear() {
    _items = {};
    update();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }
}
