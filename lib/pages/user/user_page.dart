// ignore_for_file: unused_import

import 'package:borgiaflutterapp/controllers/other_users_controller.dart';
import 'package:borgiaflutterapp/widget/profile_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    Get.put(OtherUserController);
    Get.find<OtherUserController>().getUserList(widget.userUsername);

    return Scaffold(body: GetBuilder<OtherUserController>(builder: (userController) {
      return userController.isLoaded
          ? SingleChildScrollView(
              child: Column(children: [
                Container(
                  height: Dimensions.height45 * 2.7,
                  decoration: BoxDecoration(
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
                                Get.back();
                              },
                              child: SizedBox(
                                //color: Colors.redAccent,
                                width: Dimensions.width15 * 4,
                                height: Dimensions.width15 * 4,
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              )),
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.only(right: Dimensions.width20),
                          child: (userController.welcomeUserModel.surname == null ||
                                  userController.welcomeUserModel.family == null ||
                                  userController.welcomeUserModel.campus == null ||
                                  userController.welcomeUserModel.year == null)
                              ? Text("Profil", style: Theme.of(context).textTheme.headlineMedium)
                              : Text("${userController.welcomeUserModel.surname.toString().capitalize!} ${userController.welcomeUserModel.family}",
                                  style: Theme.of(context).textTheme.headlineMedium)),
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
                              color: Theme.of(context).colorScheme.surface,
                              shape: BoxShape.circle,
                              image: const DecorationImage(fit: BoxFit.contain, image: AssetImage("assets/image/logoAMAngers.jpg")))),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                (userController.welcomeUserModel.surname == null)
                    ? Container()
                    : ProfileBox(
                        textColor: Theme.of(context).colorScheme.surface,
                        backgroundcolor: AppColors.mainColor,
                        icon: Icons.attach_money,
                        text: "Transfert vers : ${(userController.welcomeUserModel.surname)?.capitalize!}",
                        isEditable: false,
                        iconcolor: Theme.of(context).colorScheme.surface),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.onPrimaryContainer, borderRadius: BorderRadius.circular(Dimensions.width20)),
                  child: Column(
                    children: [
                      (userController.welcomeUserModel.name == null)
                          ? Container()
                          : ProfileBox(
                              textColor: Theme.of(context).colorScheme.onPrimary,
                              backgroundcolor: Theme.of(context).colorScheme.onPrimaryContainer,
                              iconcolor: Theme.of(context).colorScheme.onPrimary,
                              icon: Icons.login,
                              text: "Identifiant : ${userController.welcomeUserModel.name}",
                              isEditable: false,
                            ),
                      const SizedBox(
                        height: 0,
                      ),
                      (userController.welcomeUserModel.firstName == null || userController.welcomeUserModel.lastName == null)
                          ? Container()
                          : ProfileBox(
                              textColor: Theme.of(context).colorScheme.onPrimary,
                              backgroundcolor: Theme.of(context).colorScheme.onPrimaryContainer,
                              iconcolor: Theme.of(context).colorScheme.onPrimary,
                              icon: Icons.person,
                              text: "Nom : ${(userController.welcomeUserModel.firstName)?.capitalize} ${userController.welcomeUserModel.lastName?.capitalize}",
                              isEditable: false,
                            ),
                      const SizedBox(
                        height: 0,
                      ),
                      (userController.welcomeUserModel.surname == null)
                          ? Container()
                          : ProfileBox(
                              textColor: Theme.of(context).colorScheme.onPrimary,
                              backgroundcolor: Theme.of(context).colorScheme.onPrimaryContainer,
                              iconcolor: Theme.of(context).colorScheme.onPrimary,
                              icon: Icons.person_pin,
                              text: "Bucque : ${userController.welcomeUserModel.surname?.capitalize}",
                              isEditable: false,
                            ),
                      const SizedBox(
                        height: 0,
                      ),
                      (userController.welcomeUserModel.family == null)
                          ? Container()
                          : ProfileBox(
                              textColor: Theme.of(context).colorScheme.onPrimary,
                              backgroundcolor: Theme.of(context).colorScheme.onPrimaryContainer,
                              iconcolor: Theme.of(context).colorScheme.onPrimary,
                              icon: Icons.group,
                              text: "Fam'ss : ${userController.welcomeUserModel.family}",
                              isEditable: false,
                            ),
                      const SizedBox(
                        height: 0,
                      ),
                      (userController.welcomeUserModel.campus == null || userController.welcomeUserModel.year == null)
                          ? Container()
                          : ProfileBox(
                              textColor: Theme.of(context).colorScheme.onPrimary,
                              backgroundcolor: Theme.of(context).colorScheme.onPrimaryContainer,
                              iconcolor: Theme.of(context).colorScheme.onPrimary,
                              icon: Icons.group_work,
                              text:
                                  "Prom'ss : ${userController.welcomeUserModel.campus!.toLowerCase().capitalize} ${userController.welcomeUserModel.year! - 1800}",
                              isEditable: false,
                            ),
                      const SizedBox(
                        height: 0,
                      ),
                    ],
                  ),
                ),
              ]),
            )
          : const Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: AppColors.mainColor,
              ),
            );
    }));
  }
}
