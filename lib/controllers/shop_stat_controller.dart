import 'package:borgiaflutterapp/models/shop_stat_model.dart';
import 'package:get/get.dart';

import '../data/repository/shop_stat_repo.dart';

class ShopStatController extends GetxController {
  final ShopStatRepo shopStatRepo;

  ShopStatController({required this.shopStatRepo});

  List<dynamic> _shopStatList = [];

  List<dynamic> get shopStatList => _shopStatList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getShopStatList() async {
    Response response = await shopStatRepo.getShopStatList();

    if (response.statusCode == 200) {
      _shopStatList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        _shopStatList.add(ShopStatModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;

      update();
    } else {}
  }
}
