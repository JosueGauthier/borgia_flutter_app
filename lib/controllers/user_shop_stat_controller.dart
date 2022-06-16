import 'dart:developer';

import 'package:borgiaflutterapp/models/user_shop_stat_model.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:get/get.dart';

import '../data/repository/user_shop_stat_repo.dart';
import '../models/user_rank_models.dart';

class UserShopStatController extends GetxController {
  final UserShopStatRepo userShopStatRepo;

  UserShopStatController({required this.userShopStatRepo});

  List<dynamic> _userShopStatList = [];

  List<dynamic> get userShopStatList => _userShopStatList;

  List<dynamic> _userRank = [];

  List<dynamic> get userRank => _userRank;

  int _numberOfUsers = 0;

  int get numberOfUsers => _numberOfUsers;

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

  Future<void> getUserRank() async {
    Response response = await userShopStatRepo.getUserRank();

    if (response.statusCode == 200) {
      _userRank = [];

      List responseBody = response.body;
      _numberOfUsers = responseBody.length;

      final user = responseBody.firstWhere((e) => e['username'] == AppConstants.USERNAME);

      _userRank.add(RankUserModel.fromJson(user));

      update();
    } else {}
  }
}
