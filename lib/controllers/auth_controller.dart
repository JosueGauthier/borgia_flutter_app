import 'package:borgiaflutterapp/data/repository/auth_repo.dart';
import 'package:borgiaflutterapp/models/response_model.dart';
import 'package:borgiaflutterapp/models/signup_body_model.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBodyModel signUpBodyModel) async {
    _isLoading = true;

    Response response = await authRepo.registration(signUpBodyModel);
    late ResponseModel responseModel; //late => before we use it we need to initialize it

    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;

    update();

    return responseModel;
  }

  Future<ResponseModel> login(String username, String password) async {
    _isLoading = true;

    update();

    Response response = await authRepo.login(username, password);
    late ResponseModel responseModel;

    if (response.statusCode == 202) {
      String setcookie = response.headers!["set-cookie"].toString();

      List<String> listSetcookie = setcookie.split(';');

      var listListSetcookie = [];

      for (var i = 0; i < listSetcookie.length; i++) {
        List<String> a = listSetcookie[i].split(',');

        listListSetcookie.add(a);
      }

      var csrftoken = "";
      var sessionid = "";

      sessionid = listListSetcookie[4][1];
      csrftoken = listListSetcookie[0][0];

      var cookie = "";

      cookie = csrftoken + ";" + sessionid;

      AppConstants.COOKIE = cookie;

      authRepo.saveUserToken(response.headers!["set-cookie"].toString());
      authRepo.saveUserHeaders(response.headers);

      responseModel = ResponseModel(true, response.headers!["set-cookie"].toString());
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;

    update();

    return responseModel;
  }

  saveUsernameAndPassword(String username, String password) {
    authRepo.saveUsernameAndPassword(username, password);
  }
}
