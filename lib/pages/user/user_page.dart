import 'package:borgiaflutterapp/controllers/other_users_controller.dart';
import 'package:borgiaflutterapp/widget/profile_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';

class UserPage extends StatefulWidget {
  final String userUsername;
  final String pagefrom;

  const UserPage({
    Key? key,
    required this.userUsername,
    required this.pagefrom,
  }) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool pressed = true;

  @override
  Widget build(BuildContext context) {
    //Get.find<OtherUserController>().getUserList(widget.userUsername);

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<OtherUserController>(builder: (userController) {
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
                                child: Container(
                                  //color: Colors.redAccent,
                                  width: Dimensions.width15 * 4,
                                  height: Dimensions.width15 * 4,
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: AppColors.titleColor,
                                  ),
                                )),
                          ],
                        ),
                        Container(
                            padding: EdgeInsets.only(right: Dimensions.width20),
                            child: (userModel.surname == null || userModel.family == null || userModel.campus == null || userModel.year == null)
                                ? BigText(
                                    fontTypo: 'Montserrat-Bold',
                                    text: "Profil",
                                    size: Dimensions.height10 * 3,
                                    color: AppColors.titleColor,
                                  )
                                : BigText(
                                    fontTypo: 'Montserrat-Bold',
                                    text: userModel.surname.toString().capitalize! + " " + userModel.family.toString(),
                                    size: Dimensions.height10 * 3,
                                    color: AppColors.titleColor,
                                  )),
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
                      (userModel.surname == null)
                          ? Container()
                          : ProfileBox(
                              textColor: Colors.white,
                              backgroundcolor: AppColors.mainColor,
                              icon: Icons.person,
                              text: "Transfert vers : " + userModel.surname.toString(),
                              isEditable: false,
                              iconcolor: Colors.white),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      (userModel.name == null)
                          ? Container()
                          : ProfileBox(
                              textColor: AppColors.darkGreyColor,
                              backgroundcolor: AppColors.whiteGreyColor,
                              icon: Icons.person,
                              text: "Identifiant : " + userModel.name.toString(),
                              isEditable: false,
                              iconcolor: AppColors.mainColor),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      (userModel.firstName == null || userModel.lastName == null)
                          ? Container()
                          : ProfileBox(
                              textColor: AppColors.darkGreyColor,
                              backgroundcolor: AppColors.whiteGreyColor,
                              icon: Icons.person,
                              text: "Nom : " + userModel.firstName.toString() + " " + userModel.lastName.toString(),
                              isEditable: false,
                              iconcolor: AppColors.mainColor),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      (userModel.surname == null)
                          ? Container()
                          : ProfileBox(
                              textColor: AppColors.darkGreyColor,
                              backgroundcolor: AppColors.whiteGreyColor,
                              icon: Icons.person,
                              text: "Bucque : " + userModel.surname.toString(),
                              isEditable: false,
                              iconcolor: AppColors.mainColor),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      (userModel.family == null)
                          ? Container()
                          : ProfileBox(
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
                      (userModel.campus == null || userModel.year == null)
                          ? Container()
                          : ProfileBox(
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
                    ]),
                  ),
                ])
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }));
  }
}
