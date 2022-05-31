import 'package:borgiaflutterapp/models/user_shop_stat_model.dart';
import 'package:get/get.dart';

import '../data/repository/user_shop_stat_repo.dart';

class UserShopStatController extends GetxController {
  final UserShopStatRepo userShopStatRepo;

  UserShopStatController({required this.userShopStatRepo});

  List<dynamic> _userShopStatList = [];

  List<dynamic> get userShopStatList => _userShopStatList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getUserShopStatList() async {
    Response response = await userShopStatRepo.getUserShopStatList();

    if (response.statusCode == 200) {
      _userShopStatList = [];
      List responseBody = response.body;
      for (var i = 0; i < responseBody.length; i++) {
        _userShopStatList.add(UserShopStatModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;

      update();
    } else {}
  }
}
