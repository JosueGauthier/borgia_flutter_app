import 'package:flutter/material.dart';

import '../../controllers/cart_controller.dart';
import '../../models/Popular_product_model.dart';
import '../../widget/app_icon.dart';
import '../../widget/expandable_text_widget.dart';

import '../../controllers/popular_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/app_column.dart';
import '../../widget/big_text.dart';

import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String pagefrom;

  const PopularFoodDetail({Key? key, required this.pageId, required this.pagefrom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OldProductModel product = Get.find<PopularProductController>().popularProductList[pageId];

    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());

    //print("pageid is " + pageId.toString());

    //print("productname is " + product.name.toString());

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          //!background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!))),
              )),

          //! icon widget
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      if (pagefrom == "cartpage") {
                        Get.toNamed(RouteHelper.getCartPage(pageId, "popular_page"));
                      } else {
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: const AppIcon(iconData: Icons.arrow_back)),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.totalItems >= 1) {
                        Get.toNamed(RouteHelper.getCartPage(pageId, "popular_page"));
                      }
                    },
                    child: Stack(
                      children: [
                        const AppIcon(iconData: Icons.shopping_bag),
                        controller.totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    const AppIcon(
                                      iconData: Icons.circle,
                                      size: 20,
                                      backgroundColor: AppColors.mainColor,
                                      iconColor: Colors.transparent,
                                    ),
                                    Center(
                                        child: BigText(
                                      text: Get.find<PopularProductController>().totalItems.toString(),
                                      color: Colors.white,
                                      size: 12,
                                    ))
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  );
                })
              ],
            ),
          ),

          //!introduction of food
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize - 30,
              child: Container(
                  padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius20), topRight: Radius.circular(Dimensions.radius20)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(
                        titletext: product.name!,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      BigText(text: "Introduce"),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        child: ExpandableTextWidget(text: product.description!),
                      ))
                    ],
                  ))),

          //!Expandable text widget
        ]),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularProductController) {
            return Container(
              height: Dimensions.bottomheightbar,
              padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 221, 220, 217),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                  )),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(Dimensions.radius20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          popularProductController.setQuantity(false);
                        },
                        child: const Icon(
                          Icons.remove,
                          color: AppColors.darkGreyColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      BigText(size: Dimensions.height25, text: popularProductController.inCartItem.toString()),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      GestureDetector(
                        onTap: () {
                          popularProductController.setQuantity(true);
                        },
                        child: const Icon(
                          Icons.add,
                          color: AppColors.darkGreyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProductController.popular_addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(Dimensions.radius20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          size: Dimensions.height25,
                          text: "\$ ${product.price! * popularProductController.inCartItem} | Add to cart",
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            );
          },
        ));
  }
}
