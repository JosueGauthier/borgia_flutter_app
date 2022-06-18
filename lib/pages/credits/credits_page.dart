// ignore_for_file: unused_import

import 'package:borgiaflutterapp/widget/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const CustomHeader(text: "Crédits"),
          Container(
            //height: Dimensions.height100 * 1.2,
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
              BigText(
                color: AppColors.mainColor,
                text: "Création de l'application",
                size: Dimensions.height25 * 1.1,
                fontTypo: 'Montserrat-Bold',
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              BigText(
                color: Theme.of(context).colorScheme.onPrimary,
                text: "Khalvin 73-16 An220",
                size: Dimensions.height20 * 1.1,
                fontTypo: 'Montserrat-Bold',
              ),
              BigText(
                color: AppColors.greyColor,
                text: "Josué Gauthier",
                size: Dimensions.height20 * 1.1,
                fontTypo: 'Montserrat-Bold',
              ),
            ]),
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
          SizedBox(
            height: Dimensions.height10 / 8.5,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width20 * 2),
              color: AppColors.greyColor,
            ),
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
          Container(
            //height: Dimensions.height100 * 1.2,
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
              BigText(
                color: AppColors.mainColor,
                text: "Logo et graphismes",
                size: Dimensions.height25 * 1.1,
                fontTypo: 'Montserrat-Bold',
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              BigText(
                color: Theme.of(context).colorScheme.onPrimary,
                text: "[D]keur 148-22 An221",
                size: Dimensions.height20 * 1.1,
                fontTypo: 'Montserrat-Bold',
              ),
              BigText(
                color: AppColors.greyColor,
                text: "Maël Boureau",
                size: Dimensions.height20 * 1.1,
                fontTypo: 'Montserrat-Bold',
              ),
            ]),
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
          SizedBox(
            height: Dimensions.height10 / 8.5,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width20 * 2),
              color: AppColors.greyColor,
            ),
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            //height: Dimensions.height100 * 1.2,
            width: double.maxFinite,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
              BigText(
                color: AppColors.mainColor,
                text: "Création de Borgia",
                size: Dimensions.height25 * 1.1,
                fontTypo: 'Montserrat-Bold',
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              BigText(
                color: Theme.of(context).colorScheme.onPrimary,
                text: "Past'ys 101-99 Me 214",
                size: Dimensions.height20 * 1.1,
                fontTypo: 'Montserrat-Bold',
              ),
              BigText(
                color: AppColors.greyColor,
                text: "Alexandre Palo",
                size: Dimensions.height20 * 1.1,
                fontTypo: 'Montserrat-Bold',
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              BigText(
                color: Theme.of(context).colorScheme.onPrimary,
                text: "Eyap 53 Me 215",
                size: Dimensions.height20 * 1.1,
                fontTypo: 'Montserrat-Bold',
              ),
              BigText(
                color: AppColors.greyColor,
                text: "Maël Lacour",
                size: Dimensions.height20 * 1.1,
                fontTypo: 'Montserrat-Bold',
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              BigText(
                color: Theme.of(context).colorScheme.onPrimary,
                text: "Rowsky 144 Me 215",
                size: Dimensions.height20 * 1.1,
                fontTypo: 'Montserrat-Bold',
              ),
              BigText(
                color: AppColors.greyColor,
                text: "Wassim Belmezouar",
                size: Dimensions.height20 * 1.1,
                fontTypo: 'Montserrat-Bold',
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              BigText(
                color: Theme.of(context).colorScheme.onPrimary,
                text: "Leyphay's 87 Me 215 ",
                size: Dimensions.height20 * 1.1,
                fontTypo: 'Montserrat-Bold',
              ),
              BigText(
                color: AppColors.greyColor,
                text: "Vincent Keppens",
                size: Dimensions.height20 * 1.1,
                fontTypo: 'Montserrat-Bold',
              ),
            ]),
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
          SizedBox(
            height: Dimensions.height10 / 8.5,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width20 * 2),
              color: AppColors.greyColor,
            ),
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
        ]),
      ),
    );
  }
}
