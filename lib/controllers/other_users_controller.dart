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

  late UserModel userModel;

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

      userModel = userList[0];

      _isLoaded = true;
      update();
    } else {}
  }

  List<dynamic> _otherUserList = [];

  List<dynamic> get otherUserList => _otherUserList;

  bool _otherUserListIsLoaded = false;
  bool get otherUserListIsLoaded => _otherUserListIsLoaded;

  Future<void> getOtherUserList(String username) async {
    Response response = await userRepo.getOtherUserList(username);

    if (response.statusCode == 200) {
      _otherUserList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        _otherUserList.add(UserModel.fromJson(responseBody[i]));
      }

      _otherUserListIsLoaded = true;
      update();
    } else {}
  }
}
