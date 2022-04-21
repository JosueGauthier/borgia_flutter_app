import 'package:borgiaflutterapp/controllers/product_controller.dart';
import 'package:borgiaflutterapp/models/product_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../widget/app_icon.dart';

import '../../routes/route_helper.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';

class ShopPageDetail extends StatefulWidget {
  const ShopPageDetail({
    Key? key,
  }) : super(key: key);

  @override
  State<ShopPageDetail> createState() => _ShopPageDetailState();
}

class _ShopPageDetailState extends State<ShopPageDetail> {
  @override
  Widget build(BuildContext context) {
    //oldProductModel product = Get.find<RecommendedProductController>().recommendedProductList[pageId];

    //Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: Dimensions.height100 * 1,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height10),
            color: AppColors.mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Shop ...", //todo add name of the shop
                  size: Dimensions.height30,
                  color: Colors.white,
                ),
                AppIcon(iconData: Icons.shopping_bag, iconColor: AppColors.mainColor, backgroundColor: Colors.white),
              ],
            ),
          ),
          Expanded(child: SingleChildScrollView(child: GetBuilder<ProductController>(builder: (productController) {
            //print("reco1");
            return productController.isLoaded
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: productController.productList.length,
                    itemBuilder: (context, index) {
                      ProductModel productModel = productController.productList[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getRecommendedFood(index, "home"));
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height15),
                          child: Row(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //! image section

                                Stack(
                                  children: [
                                    Container(
                                      height: Dimensions.height100,
                                      width: Dimensions.listviewimgSize,
                                      decoration: BoxDecoration(
                                          //color: Colors.amber,
                                          image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: NetworkImage(productModel.productImage!),
                                          ),
                                          borderRadius: BorderRadius.circular(Dimensions.width20)),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        height: Dimensions.height20 * 2,
                                        width: Dimensions.height20 * 2,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            image: DecorationImage(
                                              //colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.dstATop),
                                              fit: BoxFit.contain,
                                              image: AssetImage("assets/image/pinte_png8_fondblanc.png"), //todo add item in function of the name of the product
                                            ),
                                            borderRadius: BorderRadius.circular(Dimensions.width20)),
                                      ),
                                    ),
                                  ],
                                ),

                                //! text section

                                //? expanded widget force container to take all the available space
                                Expanded(
                                  child: Container(
                                    height: Dimensions.listviewTextHeigth + 10,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(Dimensions.height20), bottomRight: Radius.circular(Dimensions.height20))),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: Dimensions.height10,
                                          ),
                                          BigText(
                                            text: productModel.name!,
                                            size: Dimensions.height25,
                                          ),
                                          SizedBox(
                                            height: Dimensions.height10,
                                          ),
                                          SmallText(allowOverFlow: true, maxLines: 2, text: productModel.manualPrice!),
                                          /* SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconAndTextWidget(icon: Icons.circle, text: "Normal", iconcolor: Colors.amber),
                                            SizedBox(
                                              width: 0,
                                            ),
                                            IconAndTextWidget(icon: Icons.location_pin, text: "1.7 km", iconcolor: AppColors.mainColor),
                                            SizedBox(
                                              width: 0,
                                            ),
                                            IconAndTextWidget(icon: Icons.lock_clock, text: "16 min", iconcolor: Colors.pink),
                                          ],
                                        ) */
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      );
                    })
                : CircularProgressIndicator(
                    strokeWidth: 4,
                    color: AppColors.mainColor,
                  );
          }))),
        ],
      ),
    );
  }
}


/* bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (controller) {
            return Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                padding:
                    EdgeInsets.only(left: Dimensions.width20 * 3.5, right: Dimensions.width20 * 3.5, top: Dimensions.height10, bottom: Dimensions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                        iconData: Icons.remove,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: 30,
                      ),
                    ),
                    BigText(
                      text: "\$ ${product.price} x " + controller.inCartItem.toString(),
                      color: AppColors.mainBlackColor,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(true);
                      },
                      child: AppIcon(
                        iconData: Icons.add,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: 30,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                child: Container(
                  margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Container(
                      margin: EdgeInsets.only(left: 0, right: 0),
                      padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                      decoration: BoxDecoration(color: Color.fromARGB(255, 230, 228, 228), borderRadius: BorderRadius.circular(Dimensions.radius20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite,
                            color: AppColors.mainColor,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.popular_addItem(product);
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                        decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(Dimensions.radius20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BigText(
                              size: 22,
                              text: "\$ ${product.price! * controller.inCartItem} | Add to cart",
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ]);
          },
        ) */