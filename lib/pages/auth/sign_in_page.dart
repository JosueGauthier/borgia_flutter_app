import 'package:borgiaflutterapp/controllers/auth_controller.dart';
import 'package:borgiaflutterapp/routes/route_helper.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:borgiaflutterapp/widget/big_text.dart';
import 'package:borgiaflutterapp/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sa3_liquid/liquid/plasma/plasma.dart';

import '../../controllers/user_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class LoginPage extends StatefulWidget {
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: GetBuilder<AuthController>(
          builder: (authcontroller) {
            return Column(children: [
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Dimensions.height100 * 1.6,
                      width: double.maxFinite,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(Dimensions.height100 * 4)),
                              color: AppColors.secondColor,
                              backgroundBlendMode: BlendMode.srcOver,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(Dimensions.height100 * 4)),
                              child: const PlasmaRenderer(
                                type: PlasmaType.infinity,
                                particles: 6,
                                color: AppColors.mainColor,
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
                            margin: EdgeInsets.only(left: Dimensions.width20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                Row(
                                  children: [
                                    BigText(
                                      fontTypo: 'OpenSansExtraBold',
                                      text: "Bienvenue, ",
                                      color: Colors.white,
                                      size: Dimensions.height30 * 1.2,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height20 * 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: Dimensions.height100 * 2,
                          width: Dimensions.screenWidth - Dimensions.width20 * 4,
                          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/image/logoImageText.png"))),
                        )
                      ],
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
                    SizedBox(
                      height: Dimensions.height20 * 3.4,
                      width: Dimensions.width20 * 25,
                      child: Padding(
                          padding: EdgeInsets.only(
                            left: Dimensions.width20 * 2,
                            right: Dimensions.width20 * 2,
                          ),
                          child: Column(children: <Widget>[
                            TextFormField(
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
                                labelText: 'Enter your password',
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
                          onPressed: () {
                            _login(authcontroller);
                          },
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(50), side: const BorderSide(color: AppColors.whiteGreyColor))),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.only(left: Dimensions.width45, right: Dimensions.width45, top: Dimensions.height10, bottom: Dimensions.height10)),
                              backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                return AppColors.mainColor;
                              })),
                          child: BigText(
                            text: "Login",
                            size: Dimensions.height20,
                            color: Colors.white,
                            fontTypo: 'Montserrat-Bold',
                          )),
                    ),
                  ],
                ),
              )
            ]);
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        //  color: Colors.greenAccent,
        height: Dimensions.height20 * 3,
        child: CustomPaint(
          painter: CurvedPainter(),
        ),
      ),
    );
  }
}

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppColors.secondColor
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.9, size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.1, size.width * 1.0, size.height * .2);

    //path.quadraticBezierTo(size.width * 0.25, size.height * 0.1, size.width * 0.5, size.height * 0.5);
    //path.quadraticBezierTo(size.width * 0.75, size.height * 0.9, size.width * 1.0, size.height * 0.4);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
