import 'package:borgiaflutterapp/models/product_model.dart';

class CartModel {
  int? id;
  String? name;
  String? price;
  String? img;
  int? quantity;
  String? time;
  ProductModel? aProduct;
  int? categoryId;
  int? categoryModuleId;
  int? shopId;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    this.time,
    this.aProduct,
    this.categoryId,
    this.categoryModuleId,
    this.shopId,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    time = json['time'];
    aProduct = ProductModel.fromJson(json['product']);
    categoryId = json['category_id'];
    categoryModuleId = json['category_module_id'];
    shopId = json['shop_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "img": img,
      "quantity": quantity,
      "time": time,
      "product": aProduct!.toJson(),
      'category_id': categoryId,
      'category_module_id': categoryModuleId,
      'shop_id': shopId,
    };
  }
}
