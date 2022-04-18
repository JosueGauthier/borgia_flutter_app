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
      _shopList.addAll(Shop.fromJson(response.body).shops);
      print(shopList);
      _isLoaded = true;

      update();
    } else {}
  }
}
