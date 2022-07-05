import 'package:borgiaflutterapp/data/repository/user_repo.dart';
import 'package:borgiaflutterapp/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  List<dynamic> _userList = [];

  late UserModel userModelController;

  List<dynamic> get userList => _userList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getUserList(String username) async {
    Response response = await userRepo.getUserList(username);

    if (response.statusCode == 200) {
      _userList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        _userList.add(UserModel.fromJson(responseBody[i]));
      }

      userModelController = userList[0];
      _isLoaded = true;

      update();
    } else {}
  }
}
