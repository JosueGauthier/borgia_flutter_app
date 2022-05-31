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
      setState(() {
        //print(_currentPagevalue.toString());
      });
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
        //! sliderSection

        /*  GetBuilder<UserController>(builder: (userController) {
          return userController.isLoaded
              ? Container(
                  //color: Colors.blue,
                  height: Dimensions.height100 * 2.2,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: _nbItemSliderSection, //popularProductsController.popularProductList.length,
                      itemBuilder: (context, position) {
                        UserModel userModel = userController.userList[0];
                        //print("userbalance is " + userModel.balance.toString());

                        //CategoryOfShopModel categoryModel = categoryOfShopController.categoryOfShopList[index];

                        return _buildPageItem(position, userModel);
                      }),
                )
              : Container();
        }),

        //!Dots section

        SizedBox(
          height: Dimensions.height10,
        ),

        DotsIndicator(
          dotsCount: _nbItemSliderSection <= 0 ? 1 : _nbItemSliderSection,
          position: _currentPagevalue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            color: AppColors.lightGreyColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ), */

        //!Liste de magasins items
        SizedBox(
          height: Dimensions.height10,
        ),
        Container(
          //color: AppColors.titleColor,
          margin: EdgeInsets.only(left: Dimensions.width20 * 1.5),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            BigText(
              color: AppColors.titleColor,
              text: "Liste des magasins",
              size: Dimensions.height25 * 1.1,
              fontTypo: 'Montserrat-Bold',
            )
          ]),
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
              : const CircularProgressIndicator(
                  strokeWidth: 4,
                  color: AppColors.mainColor,
                );
        })
      ],
    );
  }
}
