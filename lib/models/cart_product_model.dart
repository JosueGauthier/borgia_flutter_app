import 'package:borgiaflutterapp/models/product_model.dart';

class CartModel {
  int? id;
  String? name;
  int? quantity;
  String? time;
  ProductModel? aProduct;

  CartModel({
    this.id,
    this.name,
    this.quantity,
    this.time,
    this.aProduct,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    time = json['time'];
    aProduct = ProductModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "quantity": quantity,
      "time": time,
      "product": aProduct!.toJson(),
    };
  }
}
