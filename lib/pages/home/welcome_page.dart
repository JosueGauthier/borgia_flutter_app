import 'package:borgiaflutterapp/controllers/shop_controller.dart';
import 'package:borgiaflutterapp/models/shop_model.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
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
  PageController pageController = PageController(viewportFraction: 0.9);

  List<List<dynamic>> listItemsSlider = [
    ['Solde actuel', null],
    ['Rechargement', "lydia-logo.jpeg"],
    ['Statistiques', "stat.png"]
  ];

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //!Liste de magasins items
        SizedBox(
          height: Dimensions.height10,
        ),
        Container(
          //color: AppColors.titleColor,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: Dimensions.width20 * 1.5),
          child: BigText(
            color: AppColors.titleColor,
            text: "Liste des magasins",
            size: Dimensions.height25 * 1.1,
            fontTypo: 'Montserrat-Bold',
          ),
        ),

        //! List of shops scroll view

        GetBuilder<ShopController>(builder: (shopController) {
          return shopController.isLoaded
              ? Container(
                  //color: Colors.greenAccent,
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
                            AppConstants.SHOP_ID = shopModel.id!;
                            Get.toNamed(RouteHelper.getCategoryListPage(shopModel.id!, "home"));
                          },
                          child: Row(children: [
                            //! image section

                            Container(
                              margin: EdgeInsets.only(bottom: Dimensions.height10),
                              height: Dimensions.height100 * 0.6,
                              width: Dimensions.height100 * 0.6,
                              decoration: BoxDecoration(
                                //color: Colors.amber,
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(shopModel.image!),
                                ),
                                //borderRadius: BorderRadius.circular(Dimensions.width20)
                              ),
                            ),

                            SizedBox(
                              width: Dimensions.width20 * 3,
                            ),

                            //! text section

                            //? expanded widget force container to take all the available space
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                child: BigText(
                                  fontTypo: 'Helvetica-Bold',
                                  text: (shopModel.name)!.capitalize!,
                                  size: Dimensions.height25 * 0.8,
                                  color: AppColors.titleColor,
                                ),
                              ),
                            ),
                          ]),
                        );
                      }),
                )
              : Center(
                  child: const CircularProgressIndicator(
                    strokeWidth: 4,
                    color: AppColors.mainColor,
                  ),
                );
        })
      ],
    );
  }
}
