// ignore_for_file: prefer_const_constructors

import 'package:borgiaflutterapp/controllers/shop_controller.dart';
import 'package:borgiaflutterapp/models/shop_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //!Liste des magasins

        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: Dimensions.width10),
          child: Text(
            "Liste des magasins",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),

        SizedBox(
          height: Dimensions.height10,
        ),

        //! List of shops scroll view

        GetBuilder<ShopController>(builder: (shopController) {
          return shopController.isLoaded
              ? Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(right: Dimensions.width10, left: Dimensions.width10, top: Dimensions.height10),
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: shopController.shopList.length,
                      itemBuilder: (context, index) {
                        ShopModel shopModel = shopController.shopList[index];
                        return GestureDetector(
                          onTap: () {
                            AppConstants.bienvenueUsernameisfinishedRotate = true;
                            Get.toNamed(RouteHelper.getCategoryListPage(shopModel.id!, "home"));
                          },
                          child: Stack(
                            //alignment: Alignment.,
                            children: [
                              Container(
                                //padding: EdgeInsets.all(Dimensions.height10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).appBarTheme.surfaceTintColor,
                                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.width20)),
                                  //border: Border.all(color: AppColors.borderDarkColor)
                                ),
                                margin: EdgeInsets.only(bottom: Dimensions.height15, left: Dimensions.width20),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                  //! text section

                                  Container(
                                    height: Dimensions.height100 * 0.7,
                                    margin: EdgeInsets.only(left: Dimensions.height10 * 6),
                                    alignment: Alignment.center,
                                    child: Text(
                                      (shopModel.name)!.capitalize!,
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                  /*  SizedBox(
                                    width: Dimensions.width20 * 3,
                                  ), */

                                  SizedBox(
                                    width: Dimensions.height100 * 0.7,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                  ),
                                ]),
                              ),

                              //! image section

                              Container(
                                //margin: EdgeInsets.only(bottom: Dimensions.height10 * 2),
                                height: Dimensions.height100 * 0.7,
                                width: Dimensions.height100 * 0.7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white, /* border: Border.all(color: AppColors.borderDarkColor) */
                                ),
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: Dimensions.height100 * 0.5,
                                  width: Dimensions.height100 * 0.5,
                                  child: CachedNetworkImage(
                                    imageUrl: shopModel.image!,
                                    progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                                    errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.black),
                                  ),
                                ),
                              ),
                              /*  SizedBox(
                                width: Dimensions.width20 * 3,
                              ),
                               */
                            ],
                          ),
                        );
                      }),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    color: AppColors.mainColor,
                  ),
                );
        })
      ],
    );
  }
}
