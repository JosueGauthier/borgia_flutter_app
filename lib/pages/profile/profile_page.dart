import 'package:borgiaflutterapp/widget/profile_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../models/user_model.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';

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
          if (userController.isLoaded) {
            return SingleChildScrollView(
              child: Column(children: [
                Container(
                  height: Dimensions.height45 * 2.7,
                  decoration: BoxDecoration(
                      //color: Colors.green,
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimensions.height20),
                    bottomRight: Radius.circular(Dimensions.height20),
                  )),
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
                                Get.back();
                              },
                              child: SizedBox(
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
                  height: Dimensions.height20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  decoration: BoxDecoration(color: AppColors.whiteGreyColor, borderRadius: BorderRadius.circular(Dimensions.width20)),
                  child: Column(
                    children: [
                      ProfileBox(
                        textColor: AppColors.darkGreyColor,
                        backgroundcolor: AppColors.whiteGreyColor,
                        icon: Icons.person,
                        text: "Bucque : ${userModel.surname}",
                        isEditable: false,
                        iconcolor: AppColors.darkGreyColor,
                        radius: 0, //Dimensions.width20,
                      ),
                      const SizedBox(height: 0 //,Dimensions.height10,
                          ),
                      ProfileBox(
                        textColor: AppColors.darkGreyColor,
                        backgroundcolor: const Color.fromARGB(255, 243, 243, 243),
                        icon: Icons.group,
                        text: "Fam'ss : ${userModel.family}",
                        iconcolor: AppColors.darkGreyColor,
                        radius: 0, //Dimensions.width20,
                        isEditable: false,
                      ),
                      const SizedBox(
                        height: 0,
                      ),
                      ProfileBox(
                        textColor: AppColors.darkGreyColor,
                        backgroundcolor: AppColors.whiteGreyColor,
                        icon: Icons.group_work,
                        text: "Prom'ss : ${(userModel.campus!).toLowerCase().capitalize} ${userModel.year! - 1800}",
                        iconcolor: AppColors.darkGreyColor,
                        radius: 0,
                        isEditable: false,
                      ),
                      const SizedBox(
                        height: 0,
                      ),
                      /* ProfileBox(
                            textColor: AppColors.darkGreyColor,
                            backgroundcolor: AppColors.whiteGreyColor,
                            icon: Icons.email,
                            text: userModel.email.toString(),
                            iconcolor: AppColors.darkGreyColor,
                            radius: 0,
                            isEditable: false,
                          ),
                          SizedBox(
                            height: 0,
                          ), */
                      ProfileBox(
                        textColor: AppColors.darkGreyColor,
                        backgroundcolor: AppColors.whiteGreyColor,
                        icon: Icons.phone,
                        text: userModel.phone.toString(),
                        iconcolor: AppColors.darkGreyColor,
                        radius: 0,
                        isEditable: false,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                ProfileBox(
                  textColor: Colors.white,
                  backgroundcolor: (userModel.theme.toString() == "dark") ? AppColors.titleColor : AppColors.mainColor,
                  icon: (userModel.theme.toString() == "dark") ? Icons.dark_mode : Icons.light_mode,
                  text: userModel.theme.toString().capitalize!,
                  iconcolor: Colors.white,
                  isEditable: false,
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                /* Container(
                  margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                  height: Dimensions.height45 * 1.7,
                  width: double.maxFinite,
                  decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.all(Radius.circular(Dimensions.height10 * 5))),
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
                                            children: [
                                              SizedBox(
                                                width: Dimensions.width10,
                                              ),
                                              CircleAvatar(
                                                foregroundImage: AssetImage(value),
                                              ),
                                              SizedBox(
                                                width: Dimensions.height10,
                                              ),
                                              BigText(
                                                fontTypo: 'Helvetica-Bold',
                                                text: text,
                                                size: Dimensions.height25 * 0.8,
                                                color: AppColors.white,
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
                  height: Dimensions.height20 * 1,
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
                ), */
                const ProfileBox(
                  textColor: Colors.white,
                  backgroundcolor: AppColors.mainColor,
                  icon: Icons.help,
                  text: "Send a problem or request",
                  iconcolor: Colors.white,
                  isEditable: false,
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                const ProfileBox(
                  textColor: Colors.white,
                  backgroundcolor: AppColors.mainColor,
                  icon: Icons.handyman_rounded,
                  text: "Crédits",
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
              ]),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: AppColors.mainColor,
              ),
            );
          }
        }));
  }
}
