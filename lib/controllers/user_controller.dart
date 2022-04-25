import 'package:borgiaflutterapp/data/repository/shop_repo.dart';
import 'package:borgiaflutterapp/data/repository/user_repo.dart';
import 'package:borgiaflutterapp/models/shop_model.dart';
import 'package:borgiaflutterapp/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  List<dynamic> _userList = [];

  List<dynamic> get userList => _userList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getUserList(String username) async {
    Response response = await userRepo.getUserList(username);
    //print(response);

    print("User status code " + response.statusCode.toString());

    if (response.statusCode == 200) {
      _userList = [];

      //print("response : " + response.body.toString());

      List responseBody = response.body;

      //print("the length is " + a.length.toString());

      for (var i = 0; i < responseBody.length; i++) {
        _userList.add(UserModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;

      //inspect(_shopList);

      update();
    } else {}
  }
}
