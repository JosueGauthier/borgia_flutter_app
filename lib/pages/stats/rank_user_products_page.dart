import 'dart:developer';

import 'package:borgiaflutterapp/controllers/rank_user_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/rank_user_product_model.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';

class RankUserProductPage extends StatefulWidget {
  final int shopId;
  const RankUserProductPage({Key? key, required this.shopId}) : super(key: key);

  @override
  State<RankUserProductPage> createState() => _RankUserProductPageState();
}

class _RankUserProductPageState extends State<RankUserProductPage> {
  @override
  Widget build(BuildContext context) {
    Get.find<RankUserProductController>().getRankUserList(widget.shopId);

    return GetBuilder<RankUserProductController>(builder: (rankUserProductController) {
      if (rankUserProductController.isLoaded) {
        List<ListOfProd>? listOfProd = rankUserProductController.productStatList[0].listOfProd;

        inspect(rankUserProductController.productStatList[0]);

        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              //! Podium
              Container(
                height: Dimensions.height45 * 2.7,
                decoration: BoxDecoration(
                    //color: Colors.green,
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.height20),
                  bottomRight: Radius.circular(Dimensions.height20),
                )),
                margin: EdgeInsets.only(bottom: Dimensions.height10),
                padding: EdgeInsets.only(bottom: Dimensions.height10 / 2, top: Dimensions.height30 * 1.3, left: Dimensions.width20, right: Dimensions.width20),
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
                        text: "Classement ${(rankUserProductController.productStatList[0].name).toString().capitalize!}",
                        size: Dimensions.height10 * 3,
                        color: AppColors.titleColor,
                      ),
                    ),
                  ],
                ),
              ),

              ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listOfProd?.length,
                  itemBuilder: (context, indexProduct) {
                    List<UserTopTenProduct>? userTopTenListOfaProduct = listOfProd![indexProduct].userTopTen;

                    return Container(
                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                      //color: Colors.greenAccent,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: Dimensions.width20, bottom: Dimensions.height10),
                                height: Dimensions.height100 * 0.6,
                                width: Dimensions.height100 * 0.6,
                                decoration: BoxDecoration(
                                  //color: Colors.amber,
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(listOfProd[indexProduct].image!),
                                  ),
                                  //borderRadius: BorderRadius.circular(Dimensions.width20)
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height100 * 0.6,
                                //color: Colors.redAccent,
                                child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                  //! text section

                                  //? expanded widget force container to take all the available space
                                  Container(
                                    //color: Colors.blueAccent,
                                    padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                    child: BigText(
                                      size: Dimensions.height25 * 1.1,
                                      fontTypo: 'Montserrat-Bold',
                                      text: (listOfProd[indexProduct].name)!.capitalize!,
                                      color: AppColors.titleColor,
                                    ),
                                  ),
                                ]),
                              ),
                              SizedBox(
                                width: Dimensions.height100 * 0.6,
                                height: Dimensions.height100 * 0.6,
                                //color: Colors.redAccent,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.height100 * 2,
                            //color: Colors.amber,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  height: Dimensions.height100 * 1.3,
                                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                                  child: Image.asset(
                                    "assets/image/podium_medals.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Positioned(
                                  top: Dimensions.height10 * 5,
                                  left: Dimensions.width10 * 2,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        //color: Colors.greenAccent,
                                        height: Dimensions.height10 * 6,
                                        width: Dimensions.width10 * 7.2,
                                        child: Center(
                                          child: Column(
                                            children: [
                                              BigText(
                                                fontTypo: 'Helvetica-Bold',
                                                text: (userTopTenListOfaProduct![1].surname)!.capitalize!,
                                                size: ((Dimensions.height10 *
                                                            ((Dimensions.width10 * 7.2) / (userTopTenListOfaProduct[1].surname!.length)) *
                                                            0.14) >=
                                                        Dimensions.height10)
                                                    ? Dimensions.height10 * 1.7
                                                    : Dimensions.height10 * ((Dimensions.width10 * 7.2) / (userTopTenListOfaProduct[1].surname!.length)) * 0.14,
                                                color: AppColors.titleColor,
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10 / 2,
                                              ),
                                              BigText(
                                                fontTypo: 'Helvetica-Bold',
                                                text:
                                                    ("${userTopTenListOfaProduct[1].family!} ${userTopTenListOfaProduct[1].campus!.toLowerCase().capitalize!}${userTopTenListOfaProduct[1].promotion! - 1800}")
                                                        .capitalize!,
                                                size: Dimensions.height10 * 1.3,
                                                color: AppColors.titleColor,
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10 / 2,
                                              ),
                                              BigText(
                                                fontTypo: 'Helvetica-Bold',
                                                text: "${userTopTenListOfaProduct[1].montantAchatsParProduit}€",
                                                size: Dimensions.height10 * 1.5,
                                                color: AppColors.silverGrey, //Color.fromRGBO(105, 105, 105, 0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: Dimensions.height10, //Dimensions.height10 * 2,
                                  left: Dimensions.width10 * 9.5,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        //color: Colors.greenAccent,
                                        height: Dimensions.height10 * 6,
                                        width: Dimensions.width10 * 7.2,
                                        child: Center(
                                          child: Column(
                                            children: [
                                              BigText(
                                                fontTypo: 'Helvetica-Bold',
                                                text: (userTopTenListOfaProduct[0].surname)!.capitalize!,
                                                size: ((Dimensions.height10 *
                                                            ((Dimensions.width10 * 7.2) / (userTopTenListOfaProduct[0].surname!.length)) *
                                                            0.14) >=
                                                        Dimensions.height10)
                                                    ? Dimensions.height10 * 1.7
                                                    : Dimensions.height10 * ((Dimensions.width10 * 7.2) / (userTopTenListOfaProduct[0].surname!.length)) * 0.14,
                                                color: AppColors.titleColor,
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10 / 2,
                                              ),
                                              BigText(
                                                fontTypo: 'Helvetica-Bold',
                                                text:
                                                    ("${userTopTenListOfaProduct[0].family!} ${userTopTenListOfaProduct[0].campus!.toLowerCase().capitalize!}${userTopTenListOfaProduct[0].promotion! - 1800}")
                                                        .capitalize!,
                                                size: Dimensions.height10 * 1.3,
                                                color: AppColors.titleColor,
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10 / 2,
                                              ),
                                              BigText(
                                                fontTypo: 'Helvetica-Bold',
                                                text: "${userTopTenListOfaProduct[0].montantAchatsParProduit}€",
                                                size: Dimensions.height10 * 1.5,
                                                color: AppColors.silverGrey,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: Dimensions.height10 * 8.5,
                                  left: Dimensions.width10 * 17,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        //color: Colors.greenAccent,
                                        height: Dimensions.height10 * 6,
                                        width: Dimensions.width10 * 7.2,
                                        child: Center(
                                          child: Column(
                                            children: [
                                              BigText(
                                                fontTypo: 'Helvetica-Bold',
                                                text: (userTopTenListOfaProduct[2].surname)!.capitalize!,
                                                size: ((Dimensions.height10 *
                                                            ((Dimensions.width10 * 7.2) / (userTopTenListOfaProduct[2].surname!.length)) *
                                                            0.14) >=
                                                        Dimensions.height10)
                                                    ? Dimensions.height10 * 1.7
                                                    : Dimensions.height10 * ((Dimensions.width10 * 7.2) / (userTopTenListOfaProduct[2].surname!.length)) * 0.14,
                                                color: AppColors.titleColor,
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10 / 2,
                                              ),
                                              BigText(
                                                fontTypo: 'Helvetica-Bold',
                                                text:
                                                    ("${userTopTenListOfaProduct[2].family!} ${userTopTenListOfaProduct[2].campus!.toLowerCase().capitalize!}${userTopTenListOfaProduct[2].promotion! - 1800}")
                                                        .capitalize!,
                                                size: Dimensions.height10 * 1.3,
                                                color: AppColors.titleColor,
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10 / 2,
                                              ),
                                              BigText(
                                                fontTypo: 'Helvetica-Bold',
                                                text: "${userTopTenListOfaProduct[2].montantAchatsParProduit}€",
                                                size: Dimensions.height10 * 1.5,
                                                color: AppColors.silverGrey,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                        ],
                      ),
                    );
                  }),

              SizedBox(
                height: Dimensions.height10 * 5,
              )
            ]),
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 4,
            color: AppColors.mainColor,
          ),
        );
      }
    });
  }
}
