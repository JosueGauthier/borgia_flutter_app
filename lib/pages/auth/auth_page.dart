import 'package:borgiaflutterapp/widget/icon_and_text.dart';
import 'package:borgiaflutterapp/widget/profile_box.dart';
import 'package:borgiaflutterapp/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/app_icon.dart';
import '../../widget/big_text.dart';
import '../../widget/textfieldform.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(onPrimary: Colors.black, primary: Colors.blue, textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
        body: Column(children: [
      Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: Dimensions.height20 * 5,
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
                      size: Dimensions.height20,
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
                  //size: 20,
                  color: AppColors.darkgrey,
                ),
                onPressed: () {},
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) return Colors.green;
                  return AppColors.greyColor;
                })))
          ],
        ),
      )
    ]));
  }
}
