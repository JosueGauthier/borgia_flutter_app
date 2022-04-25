import 'dart:developer';

import 'package:borgiaflutterapp/controllers/auth_controller.dart';
import 'package:borgiaflutterapp/models/signup_body_model.dart';
import 'package:borgiaflutterapp/models/user_model.dart';
import 'package:borgiaflutterapp/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/new_user_controller.dart';
import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _registration() {
    var authController = Get.find<AuthController>();
    String name = nameController.text.trim();
    String password = passwordController.text.trim();

    if (name.isEmpty) {
      Get.snackbar("Username error", "Enter a valid username");
    } else if (password.isEmpty) {
      Get.snackbar("Password error", "Enter a valid password");
    } else {
      SignUpBodyModel signUpBodyModel = SignUpBodyModel(name: name, email: "jose@gmail.com", password: password, phone: "0123654789");
      print(signUpBodyModel.toString());
      authController.registration(signUpBodyModel).then((status) {
        if (status.isSuccess) {
          print("Sucess registration");
        } else {
          Get.snackbar("Error", status.message);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Padding(
        padding: EdgeInsets.all(0),
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
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: new DecorationImage(fit: BoxFit.contain, image: AssetImage("assets/image/logoborgia.png")))),
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
                    controller: nameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      prefixIcon: Icon(Icons.person, color: AppColors.darkgrey),
                      hintText: "Enter your username",
                      //labelText: 'Name',
                      hintStyle: TextStyle(color: AppColors.darkgrey),
                      filled: true,
                      fillColor: AppColors.greyColor,
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
                    controller: passwordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      prefixIcon: Icon(Icons.person, color: AppColors.darkgrey),
                      hintText: "Enter your password",
                      //labelText: 'Name',
                      hintStyle: TextStyle(color: AppColors.darkgrey),
                      filled: true,
                      fillColor: AppColors.greyColor,
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
                  color: AppColors.darkgrey,
                ),
                onPressed: () {
                  _registration();
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.only(left: Dimensions.width45, right: Dimensions.width45, top: Dimensions.height10, bottom: Dimensions.height10)),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) return AppColors.secondColor;
                      return AppColors.greyColor;
                    })))
          ],
        ),
      )
    ]));
  }
}
