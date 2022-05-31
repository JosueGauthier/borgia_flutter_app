// ignore_for_file: unnecessary_import, sized_box_for_whitespace

import 'package:borgiaflutterapp/controllers/auth_controller.dart';
import 'package:borgiaflutterapp/routes/route_helper.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:borgiaflutterapp/widget/big_text.dart';
import 'package:borgiaflutterapp/widget/small_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sa3_liquid/liquid/plasma/plasma.dart';

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
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

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
        extendBody: true,
        //resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: GetBuilder<AuthController>(
            builder: (authcontroller) {
              return Column(children: [
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    children: <Widget>[
                      Container(
                        //color: Colors.amber,
                        height: Dimensions.height100 * 3.5,
                        width: double.maxFinite,
                        //padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height10),
                        //color: AppColors.mainColor,

                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                //borderRadius: BorderRadius.circular(30),
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(Dimensions.height100 * 4)),
                                color: AppColors.secondColor,
                                backgroundBlendMode: BlendMode.srcOver,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(Dimensions.height100 * 4)),
                                child: const PlasmaRenderer(
                                  type: PlasmaType.infinity,
                                  particles: 6,
                                  color: AppColors.mainColor, //Color(0x64d31418),
                                  blur: 0.9,
                                  size: 0.9,
                                  speed: 1,
                                  offset: 0,
                                  blendMode: BlendMode.srcOver,
                                  particleType: ParticleType.atlas,
                                  variation1: 0,
                                  variation2: 0,
                                  variation3: 0,
                                  rotation: 0,
                                ),
                              ),
                            ),
                            Container(
                              width: double.maxFinite,
                              //color: Colors.greenAccent,
                              margin: EdgeInsets.only(left: Dimensions.width20),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Dimensions.height100 * 0.8,
                                  ),
                                  Row(
                                    children: [
                                      BigText(
                                        fontTypo: 'OpenSansExtraBold',
                                        text: "Bienvenue sur ",
                                        color: Colors.white,
                                        size: Dimensions.height30 * 1.5,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      BigText(
                                        fontTypo: 'OpenSansExtraBold',
                                        text: "Borgia",
                                        color: Colors.white,
                                        size: Dimensions.height30 * 1.5,
                                      ),
                                      BigText(
                                        fontTypo: 'OpenSansExtraBold',
                                        text: ".",
                                        color: Colors.greenAccent,
                                        size: Dimensions.height30 * 1.5,
                                      ),
                                    ],
                                  ),
                                  /* Container(
                                    color: Colors.greenAccent,
                                    height: 200,
                                    child: ClipPath(
                                      clipper: MariasClipper(),
                                      child: Container(
                                        //height: 200,
                                        color: Colors.pink,
                                      ),
                                    ),
                                  ), */
                                ],
                              ),
                            )
                          ],
                        ),
                        /* child: Row(
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
                        ), */
                      ),
                      SizedBox(
                        height: Dimensions.height20 * 2,
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
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(50), side: const BorderSide(color: AppColors.whiteGreyColor))),
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

class MariasClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 100;
    final double _yScaling = size.height / 200;
    path.lineTo(67 * _xScaling, 20.7 * _yScaling);
    path.cubicTo(
      73.7 * _xScaling,
      24.5 * _yScaling,
      82.1 * _xScaling,
      25.6 * _yScaling,
      86.6 * _xScaling,
      30 * _yScaling,
    );
    path.cubicTo(
      91 * _xScaling,
      34.4 * _yScaling,
      91.5 * _xScaling,
      42.2 * _yScaling,
      89.6 * _xScaling,
      48.9 * _yScaling,
    );
    path.cubicTo(
      87.8 * _xScaling,
      55.6 * _yScaling,
      83.5 * _xScaling,
      61.3 * _yScaling,
      80.3 * _xScaling,
      67.7 * _yScaling,
    );
    path.cubicTo(
      77 * _xScaling,
      74.2 * _yScaling,
      74.7 * _xScaling,
      81.5 * _yScaling,
      69.8 * _xScaling,
      86.8 * _yScaling,
    );
    path.cubicTo(
      64.9 * _xScaling,
      92.1 * _yScaling,
      57.5 * _xScaling,
      95.4 * _yScaling,
      50.4 * _xScaling,
      94.7 * _yScaling,
    );
    path.cubicTo(
      43.4 * _xScaling,
      94 * _yScaling,
      36.8 * _xScaling,
      89.2 * _yScaling,
      31.9 * _xScaling,
      83.9 * _yScaling,
    );
    path.cubicTo(
      27 * _xScaling,
      78.6 * _yScaling,
      23.8 * _xScaling,
      72.8 * _yScaling,
      19.1 * _xScaling,
      67 * _yScaling,
    );
    path.cubicTo(
      14.299999999999997 * _xScaling,
      61.3 * _yScaling,
      8 * _xScaling,
      55.6 * _yScaling,
      6.399999999999999 * _xScaling,
      49.1 * _yScaling,
    );
    path.cubicTo(
      4.799999999999997 * _xScaling,
      42.5 * _yScaling,
      7.799999999999997 * _xScaling,
      35 * _yScaling,
      12.100000000000001 * _xScaling,
      28.3 * _yScaling,
    );
    path.cubicTo(
      16.299999999999997 * _xScaling,
      21.7 * _yScaling,
      21.7 * _xScaling,
      16 * _yScaling,
      28.2 * _xScaling,
      12.100000000000001 * _yScaling,
    );
    path.cubicTo(
      34.7 * _xScaling,
      8.200000000000003 * _yScaling,
      42.4 * _xScaling,
      6 * _yScaling,
      48.7 * _xScaling,
      8.200000000000003 * _yScaling,
    );
    path.cubicTo(
      55.1 * _xScaling,
      10.399999999999999 * _yScaling,
      60.2 * _xScaling,
      16.9 * _yScaling,
      67 * _xScaling,
      20.7 * _yScaling,
    );
    path.cubicTo(
      67 * _xScaling,
      20.7 * _yScaling,
      67 * _xScaling,
      20.7 * _yScaling,
      67 * _xScaling,
      20.7 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
