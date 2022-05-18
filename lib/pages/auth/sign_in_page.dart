// ignore_for_file: unnecessary_import

import 'package:borgiaflutterapp/controllers/auth_controller.dart';
import 'package:borgiaflutterapp/routes/route_helper.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:borgiaflutterapp/widget/big_text.dart';
import 'package:borgiaflutterapp/widget/small_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class LoginPage extends StatefulWidget {
  //10h09
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _login(AuthController authController) {
    //var authController = Get.find<AuthController>();
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    //print(username);

    //print(password);

    if (username.isEmpty) {
      Get.snackbar("Username empty", "Enter a valid username");
    } else if (password.isEmpty) {
      Get.snackbar("Password empty", "Enter a valid password");
    } else {
      authController.login(username, password).then((status) {
        if (status.isSuccess) {
          //print("Sucess login");
          AppConstants.USERNAME = username;
          AppConstants.PASSWORD = password;
          AppConstants.isfinishedRotate = false;
          Get.find<UserController>().getUserList(AppConstants.USERNAME);

          Get.toNamed(RouteHelper.getInitial());
        } else {
          Get.snackbar("Error", status.message);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: GetBuilder<AuthController>(
            builder: (authcontroller) {
              return Column(children: [
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: Dimensions.height20 * 4,
                      ),
                      Container(
                        //color: Colors.amber,
                        height: Dimensions.height100 * 2.5,
                        width: double.maxFinite,
                        padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height10),
                        //color: AppColors.mainColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                width: Dimensions.height100 * 2.5,
                                height: Dimensions.height100 * 2.5,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(fit: BoxFit.contain, image: AssetImage("assets/image/logoborgia.png")))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: Dimensions.width20 * 2, right: Dimensions.width20 * 2),
                          child: Column(children: <Widget>[
                            TextFormField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: AppColors.titleColor),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: AppColors.mainColor),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: AppColors.titleColor,
                                ),
                                hintText: "Enter your username",
                                labelText: "Enter your username",
                                labelStyle: TextStyle(
                                  color: AppColors.titleColor,
                                  fontSize: Dimensions.height20,
                                ),
                                hintStyle: const TextStyle(color: AppColors.titleColor),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ])),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Container(
                        height: Dimensions.height20 * 3.4,
                        width: Dimensions.width20 * 25,
                        child: Padding(
                            padding: EdgeInsets.only(
                              left: Dimensions.width20 * 2,
                              right: Dimensions.width20 * 2,
                            ),
                            child: Column(children: <Widget>[
                              TextFormField(
                                //style: TextStyle(),
                                obscureText: true,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: AppColors.titleColor),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: AppColors.mainColor),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  prefixIcon: const Icon(Icons.password, color: AppColors.titleColor),
                                  //hintText: "Enter your password",
                                  labelText: 'Enter your password',
                                  //hintStyle: const TextStyle(color: AppColors.titleColor),

                                  labelStyle: TextStyle(
                                    color: AppColors.titleColor,
                                    fontSize: Dimensions.height20,
                                  ),

                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ])),
                      ),
                      SizedBox(
                        height: Dimensions.height15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: Dimensions.width20 * 2),
                            child: InkWell(
                              onTap: () {},
                              child: SmallText(
                                text: "Mot de passe oublié ?",
                                color: AppColors.mainColor,
                                size: Dimensions.height15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Container(
                        height: Dimensions.height20 * 3.3,
                        width: double.maxFinite,
                        padding: EdgeInsets.only(
                          left: Dimensions.width20 * 2,
                          right: Dimensions.width20 * 2,
                        ),
                        child: ElevatedButton(
                            child: BigText(
                              text: "Login",
                              size: Dimensions.height20,
                              color: Colors.white,
                              fontTypo: 'Montserrat-Bold',
                            ),
                            onPressed: () {
                              _login(authcontroller);
                            },
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(50), side: BorderSide(color: AppColors.whiteGreyColor))),
                                padding: MaterialStateProperty.all(EdgeInsets.only(
                                    left: Dimensions.width45, right: Dimensions.width45, top: Dimensions.height10, bottom: Dimensions.height10)),
                                backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                  return AppColors.mainColor;
                                }))),
                      )
                    ],
                  ),
                )
              ]);
            },
          ),
        ));
  }
}
