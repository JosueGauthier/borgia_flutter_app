import 'package:get/get.dart';

import '../data/repository/cart_repo.dart';
import '../models/Popular_product_model.dart';
import '../models/cart_product_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

  //! only for storage and sharedpreferences
  List<CartModel> storageItems = [];

  void addItem(oldProductModel oldProductModel, int quantity) {
    if (_items.containsKey(oldProductModel.id!)) {
      _items.update(oldProductModel.id!, (value) {
        if ((value.quantity! + quantity) > 0) {
          return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity! + quantity,
            isExist: true,
            time: DateTime.now().toString(),
            aProduct: oldProductModel,
          );
        } else {
          return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: 0,
            isExist: true,
            time: DateTime.now().toString(),
            aProduct: oldProductModel,
          );
        }
      });
    } else {
      // print("length of the item is " + _items.length.toString());
      //?ajoute si l'item n'existe pas encore
      _items.putIfAbsent(oldProductModel.id!, () {
        //print("add item to cart " + oldProductModel.id!.toString() + " quantity " + quantity.toString());

        _items.forEach(((key, value) {
          //print(value.name! + "quantity is " + value.quantity.toString());
        }));

        return CartModel(
          id: oldProductModel.id,
          name: oldProductModel.name,
          price: oldProductModel.price,
          img: oldProductModel.img,
          quantity: quantity,
          isExist: true,
          time: DateTime.now().toString(),
          aProduct: oldProductModel,
        );
      });
    }

    if (_items[oldProductModel.id]?.quantity! == 0) {
      _items.remove(oldProductModel.id!);
    }

    cartRepo.addToCartList(getItems);

    update();
  }

  void removeItem(oldProductModel oldProductModel) {
    if (_items.containsKey(oldProductModel.id!)) {
      _items.remove(oldProductModel.id!);
    }
  }

  bool existinCart(oldProductModel aProduct) {
    if (_items.containsKey(aProduct.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(oldProductModel aProduct) {
    var quantity = 0;

    if (_items.containsKey(aProduct.id)) {
      _items.forEach((key, value) {
        if (key == aProduct.id) {
          quantity = value.quantity!;
        }
      });
    }

    return quantity;
  }

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

  //! keyword get doit retourner qqch
  int get totalAmount {
    var total = 0;

    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });

    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();

    return storageItems;
  }

  //! set fonction quand elle est appellé alloue une valeur a une variable
  set setCart(List<CartModel> items) {
    storageItems = items;

    //print("Length of cart " + storageItems.length.toString());

    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].aProduct!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
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
