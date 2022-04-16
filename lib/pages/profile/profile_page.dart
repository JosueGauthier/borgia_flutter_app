import 'package:borgiaflutterapp/widget/icon_and_text.dart';
import 'package:borgiaflutterapp/widget/profile_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/app_icon.dart';
import '../../widget/big_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.height100 * 1.1,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height10),
            color: AppColors.mainColorTranspa,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Profile",
                  size: Dimensions.height30,
                  color: Colors.white,
                ),
              ],
            ),
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
                        border: Border.all(width: 3, color: AppColors.greyColor),
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: new DecorationImage(fit: BoxFit.fill, image: AssetImage("assets/image/logoAMAngers.jpg")))),
              ],
            ),
          ),
          Container(
            height: 300,
            child: ListView(children: <Widget>[
              ProfileBox(
                  textColor: AppColors.darkgrey,
                  backgroundcolor: AppColors.greyColor,
                  icon: Icons.person,
                  text: "Bucque : Khalvin",
                  isEditable: false,
                  iconcolor: AppColors.mainColorTranspa),
              SizedBox(
                height: Dimensions.height20,
              ),
              ProfileBox(
                textColor: AppColors.darkgrey,
                backgroundcolor: AppColors.greyColor,
                icon: Icons.group,
                text: "Fam'ss : 73-16",
                iconcolor: AppColors.mainColorTranspa,
                isEditable: false,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              ProfileBox(
                textColor: AppColors.darkgrey,
                backgroundcolor: AppColors.greyColor,
                icon: Icons.group_work,
                text: "Prom'ss : An 220",
                iconcolor: AppColors.mainColorTranspa,
                isEditable: false,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              ProfileBox(
                textColor: Colors.white,
                backgroundcolor: AppColors.mainColorTranspa,
                icon: Icons.notifications,
                text: "Notifications",
                iconcolor: Colors.white,
                isEditable: false,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              ProfileBox(
                textColor: Colors.white,
                backgroundcolor: AppColors.mainColorTranspa,
                icon: Icons.logout,
                text: "Log out",
                iconcolor: Colors.white,
                isEditable: false,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              ProfileBox(
                textColor: Colors.white,
                backgroundcolor: AppColors.mainColorTranspa,
                icon: Icons.help,
                text: "Send a problem or demand",
                iconcolor: Colors.white,
                isEditable: false,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
