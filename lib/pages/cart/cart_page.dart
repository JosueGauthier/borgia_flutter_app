import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../base/no_data_page.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/app_icon.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';

class CartPage extends StatelessWidget {
  final String pagefrom;
  final int pageId;

  const CartPage({Key? key, required this.pageId, required this.pagefrom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20 * 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (pagefrom == "recommended_page") {
                          Get.toNamed(RouteHelper.getRecommendedFood(pageId, "cartpage"));
                        } else if (pagefrom == "popular_page") {
                          Get.toNamed(RouteHelper.getPopularFood(pageId, "cartpage"));
                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(
                        iconData: Icons.arrow_back,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        size: Dimensions.height45,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width45 * 1.3,
                    ),
                    GestureDetector(
                      onTap: () {
                        //print("tapped");
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(
                        iconData: Icons.home,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        size: Dimensions.height45,
                      ),
                    ),
                    AppIcon(
                      iconData: Icons.shopping_bag,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      size: Dimensions.height45,
                    ),
                  ],
                )),
            GetBuilder<CartController>(builder: (_cartController) {
              return _cartController.getItems.length > 0
                  ? Positioned(
                      top: Dimensions.height45 * 3,
                      right: Dimensions.width20,
                      left: Dimensions.width20,
                      bottom: 0,
                      child: Container(
                        //color: Colors.amber,
                        child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: GetBuilder<CartController>(
                              builder: (cartController) {
                                var _cartList = cartController.getItems;
                                return ListView.builder(
                                    itemCount: _cartList.length,
                                    itemBuilder: ((context, index) {
                                      return Container(
                                        width: double.maxFinite,
                                        height: Dimensions.height20 * 7,
                                        //color: Colors.greenAccent,
                                        margin: EdgeInsets.only(bottom: Dimensions.height20),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                int popularIndex = Get.find<PopularProductController>().popularProductList.indexOf(_cartList[index].aProduct);

                                                //print(popularIndex);

                                                if (popularIndex >= 0) {
                                                  Get.toNamed(RouteHelper.getPopularFood(popularIndex, "cartpage"));
                                                } else if (popularIndex == -1) {
                                                  if (_cartList[index].aProduct!.typeId == 2) {
                                                    var liste_des_produits_populaires = Get.find<PopularProductController>().popularProductList;

                                                    var id_PopularProduct_du_produit_de_la_carteliste = _cartList[index].id!;

                                                    for (var j = 0; j < liste_des_produits_populaires.length; j++) {
                                                      if (liste_des_produits_populaires[j].id == id_PopularProduct_du_produit_de_la_carteliste) {
                                                        var index_affichage = j;

                                                        Get.toNamed(RouteHelper.getPopularFood(index_affichage, "cartpage"));
                                                      }
                                                    }
                                                  } else if (_cartList[index].aProduct!.typeId == 3) {
                                                    var liste_des_produits_reco = Get.find<RecommendedProductController>().recommendedProductList;

                                                    var id_PopularProduct_du_produit_de_la_carteliste = _cartList[index].id!;

                                                    for (var j = 0; j < liste_des_produits_reco.length; j++) {
                                                      if (liste_des_produits_reco[j].id == id_PopularProduct_du_produit_de_la_carteliste) {
                                                        var index_affichage = j;

                                                        Get.toNamed(RouteHelper.getRecommendedFood(index_affichage, "cartpage"));
                                                      }
                                                    }
                                                  } else {
                                                    Get.snackbar("Item is not longer available", "You can't add one more, sorry",
                                                        backgroundColor: Colors.redAccent, colorText: Colors.white);
                                                  }
                                                } else {
                                                  int recommendedIndex =
                                                      Get.find<RecommendedProductController>().recommendedProductList.indexOf(_cartList[index].aProduct);

                                                  Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex, "cartpage"));
                                                }
                                              },
                                              child: Container(
                                                width: Dimensions.width20 * 5,
                                                height: Dimensions.width20 * 5,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            AppConstants.BASE_URL + AppConstants.UPLOAD_URL + cartController.getItems[index].img!)),
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(Dimensions.radius20)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Dimensions.width10,
                                            ),
                                            //? an expanded widget take all space of the parent
                                            Expanded(
                                                child: Container(
                                              //color: Colors.redAccent,
                                              height: double.maxFinite,
                                              child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    BigText(
                                                      text: _cartList[index].name!,
                                                      color: AppColors.mainBlackColor,
                                                      size: Dimensions.height30,
                                                    ),
                                                    SmallText(text: "Spicy"),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        BigText(
                                                          text: _cartList[index].price.toString(),
                                                          color: AppColors.mainColor,
                                                          size: Dimensions.height30,
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets.only(
                                                              top: Dimensions.height20,
                                                              bottom: Dimensions.height20,
                                                              left: Dimensions.width20,
                                                              right: Dimensions.width20),
                                                          decoration:
                                                              BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(Dimensions.radius20)),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  cartController.addItem(_cartList[index].aProduct!, -1);
                                                                },
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  color: AppColors.signColor,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: Dimensions.width10,
                                                              ),
                                                              BigText(size: Dimensions.height25, text: _cartList[index].quantity.toString()),
                                                              SizedBox(
                                                                width: Dimensions.width10,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  //print("beeing tapped");
                                                                  cartController.addItem(_cartList[index].aProduct!, 1);
                                                                },
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: AppColors.signColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ]),
                                            )),
                                          ],
                                        ),
                                      );
                                    }));
                              },
                            )),
                      ))
                  : NoDataPage(text: "Your cart is empty !");
            })
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartcontroller) {
            return Container(
              height: Dimensions.bottomheightbar,
              padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: cartcontroller.getItems.length > 0 ? Color.fromARGB(255, 221, 220, 217) : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                  )),
              child: cartcontroller.getItems.length > 0
                  ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Container(
                        padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(Dimensions.radius20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Dimensions.width10,
                            ),
                            BigText(size: Dimensions.height25, text: "Total : " + cartcontroller.totalAmount.toString() + " \$"),
                            SizedBox(
                              width: Dimensions.width10,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //popularProductController.popular_addItem(product);

                          // print("tapped");

                          cartcontroller.addToHistory();
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                          decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(Dimensions.radius20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BigText(
                                size: Dimensions.height25,
                                text: "Check out",
                                //"\$ ${product.price! * popularProductController.inCartItem} | Add to cart",
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      )
                    ])
                  : Container(),
            );
          },
        ));
  }
}
