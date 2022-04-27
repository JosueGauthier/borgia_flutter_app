// ignore_for_file: unnecessary_import

import 'package:borgiaflutterapp/controllers/auth_controller.dart';
import 'package:borgiaflutterapp/routes/route_helper.dart';
import 'package:borgiaflutterapp/widget/small_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (authcontroller) {
            return Column(children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: Dimensions.height20 * 4,
                    ),
                    Container(
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
                                borderSide: const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(5.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(5.5),
                              ),
                              prefixIcon: const Icon(Icons.person, color: AppColors.greyColor),
                              hintText: "Enter your username",
                              //labelText: 'Name',
                              hintStyle: const TextStyle(color: AppColors.greyColor),
                              filled: true,
                              fillColor: AppColors.whiteGreyColor,
                            ),
                          ),
                        ])),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: Dimensions.width20 * 2, right: Dimensions.width20 * 2),
                        child: Column(children: <Widget>[
                          TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(5.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(5.5),
                              ),
                              prefixIcon: const Icon(Icons.person, color: AppColors.greyColor),
                              hintText: "Enter your password",
                              //labelText: 'Name',
                              hintStyle: const TextStyle(color: AppColors.greyColor),
                              filled: true,
                              fillColor: AppColors.whiteGreyColor,
                            ),
                          ),
                        ])),
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
                    ElevatedButton(
                        child: SmallText(
                          text: "Login",
                          size: Dimensions.height20,
                          color: AppColors.greyColor,
                        ),
                        onPressed: () {
                          _login(authcontroller);
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.only(left: Dimensions.width45, right: Dimensions.width45, top: Dimensions.height10, bottom: Dimensions.height10)),
                            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) return AppColors.secondColor;
                              return AppColors.whiteGreyColor;
                            })))
                  ],
                ),
              )
            ]);
          },
        ));
  }
}
