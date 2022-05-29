// ignore_for_file: unused_import, unnecessary_this

import 'package:borgiaflutterapp/models/product_model.dart';
import 'package:get/get.dart';

class CartModel {
  int? id;
  String? name;
  String? price;
  String? img;
  int? quantity;
  //bool? isExist;
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
    //isExist = json['isexist'];
    time = json['time'];
    aProduct = ProductModel.fromJson(json['product']);
    categoryId = json['category_id'];
    categoryModuleId = json['category_module_id'];
    shopId = json['shop_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "price": this.price,
      "img": this.img,
      "quantity": this.quantity,
      //"isExist": this.isExist,
      "time": this.time,
      "product": this.aProduct!.toJson(),
      'category_id': this.categoryId,
      'category_module_id': this.categoryModuleId,
      'shop_id': this.shopId,
    };
  }
}
