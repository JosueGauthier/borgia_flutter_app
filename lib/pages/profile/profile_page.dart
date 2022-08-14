import 'package:borgiaflutterapp/widget/custom_header.dart';
import 'package:borgiaflutterapp/widget/profile_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/user_controller.dart';
import '../../models/user_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isExpand = false;

  clearIdentifSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(AppConstants.IDENTIFIERS_LIST, ["None", "None"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<UserController>(builder: (userController) {
      UserModel userModel = userController.userList[0];
      if (userController.isLoaded) {
        return SingleChildScrollView(
          child: Column(children: [
            const CustomHeader(text: "Mon profil"),
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
                          border: Border.all(width: 3, color: Theme.of(context).colorScheme.onPrimary),
                          //color: Theme.of(context).colorScheme.onPrimary,
                          shape: BoxShape.circle,
                          image: const DecorationImage(fit: BoxFit.contain, image: AssetImage("assets/image/logoAMAngers.jpg")))),
                ],
              ),
            ),
            SizedBox(height: Dimensions.height20 //,Dimensions.height10,
                ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              decoration: BoxDecoration(
                  //color: AppColors.mainColor.withOpacity(1),
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.width20)),
                  border: Border.all(color: AppColors.borderDarkColor)
                  /* boxShadow: [
                                                  BoxShadow(
                                                    color: AppColors.mainColor.withOpacity(0.2),
                                                    spreadRadius: 5,
                                                    blurRadius: 5,
                                                    blurStyle: BlurStyle.normal,
                                                    offset: const Offset(0, 0), // changes position of shadow
                                                  ),
                                                ], */
                  ),
              //padding: EdgeInsets.all(Dimensions.height10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileBox(
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    backgroundcolor: Theme.of(context).colorScheme.background,
                    iconcolor: Theme.of(context).colorScheme.onPrimary,
                    icon: Icons.person,
                    text: "Bucque : ${userModel.surname}",
                    isEditable: false,

                    radius: 0, //Dimensions.width20,
                  ),
                  ProfileBox(
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    backgroundcolor: Theme.of(context).colorScheme.background,
                    icon: Icons.group,
                    text: "Fam'ss : ${userModel.family}",
                    iconcolor: Theme.of(context).colorScheme.onPrimary,
                    radius: 0, //Dimensions.width20,
                    isEditable: false,
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  ProfileBox(
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    backgroundcolor: Theme.of(context).colorScheme.background,
                    icon: Icons.group_work,
                    text: "Prom'ss : ${(userModel.campus!).toLowerCase().capitalize} ${userModel.year! - 1800}",
                    iconcolor: Theme.of(context).colorScheme.onPrimary,
                    radius: 0,
                    isEditable: false,
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  /* ProfileBox(
                            textColor: AppColors.titleColor,
                            backgroundcolor: AppTheme.of(context).colorScheme.surfaceGreyColor,
                            icon: Icons.email,
                            text: userModel.email.toString(),
                            iconcolor: AppColors.titleColor,
                            radius: 0,
                            isEditable: false,
                          ),
                          SizedBox(
                            height: 0,
                          ), */
                  ProfileBox(
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    backgroundcolor: Theme.of(context).colorScheme.background,
                    icon: Icons.phone,
                    text: userModel.phone.toString(),
                    iconcolor: Theme.of(context).colorScheme.onPrimary,
                    radius: 0,
                    isEditable: false,
                  ),
                ],
              ),
            ),

            /* ProfileBox(
              textColor: Theme.of(context).colorScheme.surface,
              backgroundcolor: (userModel.theme.toString() == "dark") ? AppColors.titleColor : AppColors.mainColor,
              icon: (userModel.theme.toString() == "dark") ? Icons.dark_mode : Icons.light_mode,
              text: userModel.theme.toString().capitalize!,
              iconcolor: Theme.of(context).colorScheme.surface,
              isEditable: false,
            ), */
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
                                                color: AppTheme.of(context).colorScheme.surface,
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
                  textColor: Theme.of(context).colorScheme.surface,
                  backgroundcolor: AppColors.mainColor,
                  icon: Icons.notifications,
                  text: "Notifications",
                  iconcolor: Theme.of(context).colorScheme.surface,
                  isEditable: false,
                ),
                SizedBox(
                  height: Dimensions.height20,
                ), */
            GestureDetector(
              onTap: () async {
                String email = 'josue.gauthier@gmail.com';
                String subject = 'Problem/Request';
                String body = 'Entrez ci dessous votre problème/demande. \n \n N\'hésitez pas à ajouter des captures d\'écrans pour illustrer';

                Uri emailUrl = Uri.parse("mailto:$email?subject=$subject&body=$body");

                if (await canLaunchUrl(emailUrl)) {
                  await launchUrl(emailUrl);
                } else {
                  throw "Error occured sending an email";
                }
              },
              child: ProfileBox(
                textColor: Theme.of(context).colorScheme.surface,
                backgroundcolor: AppColors.mainColor,
                icon: Icons.help,
                text: "Send a problem or request",
                iconcolor: Theme.of(context).colorScheme.surface,
                isEditable: false,
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getCreditsPage());
              },
              child: ProfileBox(
                textColor: Theme.of(context).colorScheme.surface,
                backgroundcolor: AppColors.mainColor,
                icon: Icons.handyman_rounded,
                text: "Crédits",
                iconcolor: Theme.of(context).colorScheme.surface,
                isEditable: false,
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            GestureDetector(
              onTap: () async {
                clearIdentifSharedPref();
                Get.toNamed(RouteHelper.getSplashPage());
              },
              child: ProfileBox(
                textColor: Theme.of(context).colorScheme.surface,
                backgroundcolor: AppColors.mainColor,
                icon: Icons.logout,
                text: "Log out",
                iconcolor: Theme.of(context).colorScheme.surface,
                isEditable: false,
              ),
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
