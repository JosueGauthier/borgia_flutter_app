import 'dart:developer';

import 'package:borgiaflutterapp/data/repository/other_user_repo.dart';
import 'package:borgiaflutterapp/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class OtherUserController extends GetxController {
  final OtherUserRepo userRepo;

  OtherUserController({
    required this.userRepo,
  });

  List<dynamic> _userList = [];

  late UserModel welcomeUserModel;

  List<dynamic> get userList => _userList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getUserList(String username) async {
    Response response = await userRepo.getUserList(username);

    if (kDebugMode) {
      print("User status code ${response.statusCode}");
    }

    if (response.statusCode == 200) {
      _userList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        _userList.add(UserModel.fromJson(responseBody[i]));
      }

      welcomeUserModel = userList[0];

      _isLoaded = true;
      update();
    } else {}
  }
}
