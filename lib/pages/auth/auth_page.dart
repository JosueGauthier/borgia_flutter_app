import 'dart:developer';

import 'package:borgiaflutterapp/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController nameController = TextEditingController();

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
                  print(nameController.text);

                  if (nameController.text == "josue") {
                    Get.offNamed(RouteHelper.getInitial());
                  } else {
                    Get.snackbar("Madeby Khalvin", "U can't test me");
                  }
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
