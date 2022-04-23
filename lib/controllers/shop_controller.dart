import 'dart:convert';
import 'dart:developer';

import 'package:borgiaflutterapp/data/repository/shop_repo.dart';
import 'package:borgiaflutterapp/models/shop_model.dart';
import 'package:get/get.dart';

class ShopController extends GetxController {
  final ShopRepo shopRepo;

  ShopController({required this.shopRepo});

  List<dynamic> _shopList = [];

  List<dynamic> get shopList => _shopList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getShopList() async {
    Response response = await shopRepo.getShopList();
    //print(response);

    print("Shop status code " + response.statusCode.toString());

    if (response.statusCode == 200) {
      _shopList = [];

      //print("response : " + response.body.toString());

      List a = response.body;

      //print("the length is " + a.length.toString());

      for (var i = 0; i < a.length; i++) {
        _shopList.add(ShopModel.fromJson(a[i]));
      }
      _isLoaded = true;

      //inspect(_shopList);

      update();
    } else {}
  }
}
