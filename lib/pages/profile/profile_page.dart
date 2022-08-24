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
                  border: Border.all(color: AppColors.borderDarkColor)),
              //padding: EdgeInsets.all(Dimensions.height10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileBox(
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    backgroundcolor: Theme.of(context).appBarTheme.backgroundColor!,
                    iconcolor: Theme.of(context).colorScheme.onPrimary,
                    icon: Icons.person,
                    text: "Bucque : ${userModel.surname}",
                    isEditable: false,

                    radius: 0, //Dimensions.width20,
                  ),
                  ProfileBox(
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    backgroundcolor: Theme.of(context).appBarTheme.backgroundColor!,
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
                    backgroundcolor: Theme.of(context).appBarTheme.backgroundColor!,
                    icon: Icons.group_work,
                    text: "Prom'ss : ${(userModel.campus!).toLowerCase().capitalize} ${userModel.year! - 1800}",
                    iconcolor: Theme.of(context).colorScheme.onPrimary,
                    radius: 0,
                    isEditable: false,
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  ProfileBox(
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    backgroundcolor: Theme.of(context).appBarTheme.backgroundColor!,
                    icon: Icons.phone,
                    text: userModel.phone.toString(),
                    iconcolor: Theme.of(context).colorScheme.onPrimary,
                    radius: 0,
                    isEditable: false,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            GestureDetector(
              onTap: () async {
                String email = 'josue.gauthier@gmail.com';
                String subject = 'Problème/demande';
                String body = 'Entrez ci dessous votre problème/demande. \n \n N\'hésitez pas à ajouter des captures d\'écrans pour illustrer';

                Uri emailUrl = Uri.parse("mailto:$email?subject=$subject&body=$body");

                if (await canLaunchUrl(emailUrl)) {
                  await launchUrl(emailUrl);
                } else {
                  throw "Une erreur s'est produite lors de l'envoi d'un courriel";
                }
              },
              child: ProfileBox(
                textColor: Theme.of(context).colorScheme.surface,
                backgroundcolor: AppColors.mainColor,
                icon: Icons.help,
                text: "Envoyer un problème ou une demande",
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
                text: "Se déconnecter",
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
