import 'package:borgiaflutterapp/controllers/rank_user_product_controller.dart';
import 'package:borgiaflutterapp/widget/custom_header.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              //! Podium
              CustomHeader(text: (rankUserProductController.productStatList[0].name).toString().capitalize!),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listOfProd?.length,
                  itemBuilder: (context, indexProduct) {
                    List<UserTopTenProduct>? userTopTenListOfaProduct = listOfProd![indexProduct].userTopTen;

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: Dimensions.width20, bottom: Dimensions.height10),
                              height: Dimensions.height100 * 0.6,
                              width: Dimensions.height100 * 0.6,
                              child: CachedNetworkImage(
                                imageUrl: listOfProd[indexProduct].image!,
                                progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                            //! text section
                            Flexible(
                              child: Container(
                                margin: EdgeInsets.only(left: Dimensions.width20 * 1.5, right: Dimensions.width10),
                                child: Text(
                                  (listOfProd[indexProduct].name)!.capitalize!,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height100 * 2,
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
                                              color: Theme.of(context).colorScheme.onPrimary,
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
                                              color: AppColors.greyColor,
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10 / 2,
                                            ),
                                            BigText(
                                              fontTypo: 'Helvetica-Bold',
                                              text: "${userTopTenListOfaProduct[1].montantAchatsParProduit}€",
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
                                top: Dimensions.height10,
                                left: Dimensions.width10 * 9.5,
                                child: Column(
                                  children: [
                                    SizedBox(
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
                                              color: Theme.of(context).colorScheme.onPrimary,
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
                                              color: AppColors.greyColor,
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10 / 2,
                                            ),
                                            BigText(
                                              fontTypo: 'Helvetica-Bold',
                                              text: "${userTopTenListOfaProduct[0].montantAchatsParProduit}€",
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
                                              color: Theme.of(context).colorScheme.onPrimary,
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
                                              color: AppColors.greyColor,
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10 / 2,
                                            ),
                                            BigText(
                                              fontTypo: 'Helvetica-Bold',
                                              text: "${userTopTenListOfaProduct[2].montantAchatsParProduit}€",
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
