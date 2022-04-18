import 'package:borgiaflutterapp/models/shop_model.dart';

class Shop {
  late List<ShopModel> _shops;

  List<ShopModel> get shops => _shops;

  Shop({required shops}) {
    this._shops = shops;
  }

  Shop.fromJson(Map<String, dynamic> json) {
    if (json['shops'] != null) {
      _shops = <ShopModel>[];
      json['shop'].forEach((v) {
        _shops.add(ShopModel.fromJson(v));
      });
    }
  }
}
