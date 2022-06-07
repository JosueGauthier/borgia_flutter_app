import 'package:borgiaflutterapp/widget/profile_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../models/user_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String selectedTbk = "Boquette";
  Map<String, String> mapTbk = {
    "Boquette": "assets/image/logoAMAngers.jpg",
    "Kin": "assets/image/aixlogo.png",
    "Bordel'ss": "assets/image/bdxlogo.png",
    "Siber'ss": "assets/image/metzlogo.jpg"
  };

  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<UserController>(builder: (userController) {
          UserModel userModel = userController.userList[0];
          return userController.isLoaded
              ? Column(children: [
                  Container(
                    height: Dimensions.height45 * 2.7,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(Dimensions.height20),
                          bottomRight: Radius.circular(Dimensions.height20),
                        )),
                    margin: EdgeInsets.only(bottom: Dimensions.height10),
                    padding:
                        EdgeInsets.only(bottom: Dimensions.height10 / 2, top: Dimensions.height30 * 1.3, left: Dimensions.width20, right: Dimensions.width20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteHelper.getInitial());
                                },
                                child: SizedBox(
                                  //color: Colors.redAccent,
                                  width: Dimensions.width15 * 4,
                                  height: Dimensions.width15 * 4,
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: AppColors.titleColor,
                                  ),
                                )),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(right: Dimensions.width20),
                          child: BigText(
                            fontTypo: 'Montserrat-Bold',
                            text: "Mon profil",
                            size: Dimensions.height10 * 3,
                            color: AppColors.titleColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: Dimensions.height100 * 2,
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height10),
                    //color: AppColors.mainColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width: Dimensions.height100 * 2.5,
                            height: Dimensions.height100 * 2.5,
                            decoration: BoxDecoration(
                                border: Border.all(width: 3, color: AppColors.secondColor),
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: const DecorationImage(fit: BoxFit.contain, image: AssetImage("assets/image/logoAMAngers.jpg")))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Expanded(
                    child: ListView(children: <Widget>[
                      Container(
                        //padding: EdgeInsets.only(right: Dimensions.width30 / 2),
                        margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                        height: Dimensions.height45 * 1.7,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Stack(
                          children: [
                            SizedBox(
                              //color: Colors.redAccent,
                              height: double.maxFinite,
                              child: Center(
                                child: DropdownButton<String>(
                                  value: selectedTbk,
                                  dropdownColor: AppColors.mainColor,

                                  borderRadius: BorderRadius.circular(Dimensions.height10 * 2),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedTbk = newValue!;
                                    });
                                  },

                                  //disabledHint: Container(),

                                  // Hide the default underline
                                  underline: Container(),

                                  icon: Icon(
                                    Icons.arrow_drop_down_rounded,
                                    color: Colors.transparent,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  isExpanded: true,

                                  // The list of options
                                  items: mapTbk
                                      .map((text, value) {
                                        return MapEntry(
                                            text,
                                            DropdownMenuItem<String>(
                                                value: text,
                                                child: Row(
                                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                                  //mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: Dimensions.width10,
                                                    ),
                                                    CircleAvatar(
                                                      foregroundImage: AssetImage(value),
                                                    ),
                                                    SizedBox(
                                                      width: Dimensions.height20,
                                                    ),
                                                    SmallText(
                                                      text: text,
                                                      color: Colors.white,
                                                      size: Dimensions.height20,
                                                    ),
                                                  ],
                                                )));
                                      })
                                      .values
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      ProfileBox(
                          textColor: AppColors.darkGreyColor,
                          backgroundcolor: AppColors.whiteGreyColor,
                          icon: Icons.person,
                          text: "Bucque : " + userModel.surname.toString(),
                          isEditable: false,
                          iconcolor: AppColors.mainColor),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      ProfileBox(
                        textColor: AppColors.darkGreyColor,
                        backgroundcolor: AppColors.whiteGreyColor,
                        icon: Icons.group,
                        text: "Fam'ss : " + userModel.family.toString(),
                        iconcolor: AppColors.mainColor,
                        isEditable: false,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      ProfileBox(
                        textColor: AppColors.darkGreyColor,
                        backgroundcolor: AppColors.whiteGreyColor,
                        icon: Icons.group_work,
                        text: "Prom'ss : " + userModel.campus! + " " + (userModel.year! - 1800).toString(),
                        iconcolor: AppColors.mainColor,
                        isEditable: false,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      const ProfileBox(
                        textColor: Colors.white,
                        backgroundcolor: AppColors.mainColor,
                        icon: Icons.notifications,
                        text: "Notifications",
                        iconcolor: Colors.white,
                        isEditable: false,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      const ProfileBox(
                        textColor: Colors.white,
                        backgroundcolor: AppColors.mainColor,
                        icon: Icons.logout,
                        text: "Log out",
                        iconcolor: Colors.white,
                        isEditable: false,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      const ProfileBox(
                        textColor: Colors.white,
                        backgroundcolor: AppColors.mainColor,
                        icon: Icons.help,
                        text: "Send a problem or request",
                        iconcolor: Colors.white,
                        isEditable: false,
                      ),
                    ]),
                  ),
                ])
              : const CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }));
  }
}
