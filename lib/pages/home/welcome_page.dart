import 'package:borgiaflutterapp/controllers/shop_controller.dart';
import 'package:borgiaflutterapp/models/shop_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';

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
        SizedBox(
          height: Dimensions.height10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: Dimensions.width20 * 1.5),
          child: Text(
            "Liste des magasins",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),

        //! List of shops scroll view

        GetBuilder<ShopController>(builder: (shopController) {
          return shopController.isLoaded
              ? Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20 * 1.5, top: Dimensions.height10),
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: shopController.shopList.length,
                      itemBuilder: (context, index) {
                        ShopModel shopModel = shopController.shopList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getCategoryListPage(shopModel.id!, "home"));
                          },
                          child: Row(children: [
                            //! image section

                            Container(
                              margin: EdgeInsets.only(bottom: Dimensions.height10),
                              height: Dimensions.height100 * 0.6,
                              width: Dimensions.height100 * 0.6,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(shopModel.image!),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: Dimensions.width20 * 3,
                            ),

                            //! text section

                            Expanded(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                                  child: Text(
                                    (shopModel.name)!.capitalize!,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  )),
                            ),
                          ]),
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
