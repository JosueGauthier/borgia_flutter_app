import 'package:borgiaflutterapp/controllers/rank_user_controller.dart';
import 'package:borgiaflutterapp/models/rank_user_shop_model.dart';
import 'package:borgiaflutterapp/routes/route_helper.dart';
import 'package:borgiaflutterapp/utils/dimensions.dart';
import 'package:borgiaflutterapp/widget/big_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

class RankUserPage extends StatefulWidget {
  const RankUserPage({Key? key}) : super(key: key);

  @override
  State<RankUserPage> createState() => _RankUserPageState();
}

class _RankUserPageState extends State<RankUserPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RankUserStatController>(builder: (rankUserStatController) {
      if (rankUserStatController.isLoaded) {
        return SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            //! Podium

            //! List

            SizedBox(
              height: Dimensions.height20,
            ),

            ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rankUserStatController.statList.length,
                itemBuilder: (context, indexShop) {
                  RankUserShopModel rankUserShopModel = rankUserStatController.statList[indexShop];
                  List<UserTopTen>? userTopTenList = rankUserShopModel.userTopTen;
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getProductRankUserPage(indexShop + 1));
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: Dimensions.width20, bottom: Dimensions.height10),
                              height: Dimensions.height100 * 0.6,
                              width: Dimensions.height100 * 0.6,
                              child: CachedNetworkImage(
                                imageUrl: rankUserShopModel.image!,
                                progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                                errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.black),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                child: Text(
                                  (rankUserShopModel.name)!.capitalize!,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.height100 * 0.6,
                              height: Dimensions.height100 * 0.6,
                              //color: Colors.redAccent,
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
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
                                                text: (userTopTenList![1].surname)!.capitalize!,
                                                size: ((Dimensions.height10 * ((Dimensions.width10 * 7.2) / (userTopTenList[1].surname!.length)) * 0.14) >=
                                                        Dimensions.height10)
                                                    ? Dimensions.height10 * 1.7
                                                    : Dimensions.height10 * ((Dimensions.width10 * 7.2) / (userTopTenList[1].surname!.length)) * 0.14,
                                                color: Theme.of(context).colorScheme.onPrimary),
                                            SizedBox(
                                              height: Dimensions.height10 / 2,
                                            ),
                                            BigText(
                                              fontTypo: 'Helvetica-Bold',
                                              text:
                                                  ("${userTopTenList[1].family!} ${userTopTenList[1].campus!.toLowerCase().capitalize!}${userTopTenList[1].promotion! - 1800}")
                                                      .capitalize!,
                                              size: Dimensions.height10 * 1.3,
                                              color: AppColors.greyColor,
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10 / 2,
                                            ),
                                            BigText(
                                              fontTypo: 'Helvetica-Bold',
                                              text: "${userTopTenList[1].montantAchatsParShop}€",
                                              size: Dimensions.height10 * 1.5,
                                              color: Theme.of(context).colorScheme.onPrimary, //Color.fromRGBO(105, 105, 105, 0),
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
                                              text: (userTopTenList[0].surname)!.capitalize!,
                                              size: ((Dimensions.height10 * ((Dimensions.width10 * 7.2) / (userTopTenList[0].surname!.length)) * 0.14) >=
                                                      Dimensions.height10)
                                                  ? Dimensions.height10 * 1.7
                                                  : Dimensions.height10 * ((Dimensions.width10 * 7.2) / (userTopTenList[0].surname!.length)) * 0.14,
                                              color: Theme.of(context).colorScheme.onPrimary,
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10 / 2,
                                            ),
                                            BigText(
                                              fontTypo: 'Helvetica-Bold',
                                              text:
                                                  ("${userTopTenList[0].family!} ${userTopTenList[0].campus!.toLowerCase().capitalize!}${userTopTenList[0].promotion! - 1800}")
                                                      .capitalize!,
                                              size: Dimensions.height10 * 1.3,
                                              color: AppColors.greyColor,
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10 / 2,
                                            ),
                                            BigText(
                                              fontTypo: 'Helvetica-Bold',
                                              text: "${userTopTenList[0].montantAchatsParShop}€",
                                              size: Dimensions.height10 * 1.5,
                                              color: Theme.of(context).colorScheme.onPrimary,
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
                                              text: (userTopTenList[2].surname)!.capitalize!,
                                              size: ((Dimensions.height10 * ((Dimensions.width10 * 7.2) / (userTopTenList[2].surname!.length)) * 0.14) >=
                                                      Dimensions.height10)
                                                  ? Dimensions.height10 * 1.7
                                                  : Dimensions.height10 * ((Dimensions.width10 * 7.2) / (userTopTenList[2].surname!.length)) * 0.14,
                                              color: Theme.of(context).colorScheme.onPrimary,
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10 / 2,
                                            ),
                                            BigText(
                                              fontTypo: 'Helvetica-Bold',
                                              text:
                                                  ("${userTopTenList[2].family!} ${userTopTenList[2].campus!.toLowerCase().capitalize!}${userTopTenList[2].promotion! - 1800}")
                                                      .capitalize!,
                                              size: Dimensions.height10 * 1.3,
                                              color: AppColors.greyColor,
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10 / 2,
                                            ),
                                            BigText(
                                              fontTypo: 'Helvetica-Bold',
                                              text: "${userTopTenList[2].montantAchatsParShop}€",
                                              size: Dimensions.height10 * 1.5,
                                              color: Theme.of(context).colorScheme.onPrimary,
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
