import 'dart:async';

import 'package:borgiaflutterapp/models/product_model.dart';
import 'package:borgiaflutterapp/widget/product_item_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/product_from_category_controller.dart';
import '../../routes/route_helper.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/pop_up_vente.dart';

/*

  Etapes
  On arrive sur la page depuis page list categorie du magasin

  On obtient la liste Product From Category List
  -> http://localhost:8000/api-links/category/category-products/?category=12

  On obtient un liste des liens des produits -> exemple de lien "http://localhost:8000/api-links/shops/products/1/",

  On parcourt la liste pour obtenir les productModel de chaque lien

  On affiche 
  
  */

class ProductListFromCategoryPage extends StatefulWidget {
  final String pagefrom;
  final int categoryId;
  final int categoryModuleId;
  final int shopId;
  const ProductListFromCategoryPage({Key? key, required this.categoryId, required this.pagefrom, required this.shopId, required this.categoryModuleId})
      : super(key: key);

  @override
  State<ProductListFromCategoryPage> createState() => _ProductListFromCategoryPageState();
}

class _ProductListFromCategoryPageState extends State<ProductListFromCategoryPage> {
  bool pressed = true;

  @override
  Widget build(BuildContext context) {
    Get.find<ProductFromCategoryController>().getProduct(widget.categoryId);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/image/amtradsred.png",
              scale: 14,
              //color: Colors.white.withOpacity(0.5),
              //fit: BoxFit.fitWidth,
              repeat: ImageRepeat.repeat,
            ),
          ),
          Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: Colors.white.withOpacity(0.95),
          ),
          Column(
            children: [
              //! header Text  + cart
              Container(
                height: Dimensions.height45 * 2.7,
                decoration: BoxDecoration(
                    //color: Colors.white,
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
                              Get.toNamed(RouteHelper.getCategoryListPage(widget.shopId, "home"));
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
                        text: "Liste des produits",
                        size: Dimensions.height10 * 3,
                        color: AppColors.titleColor,
                      ),
                    ),
                  ],
                ),
              ),
              //! Scroll list des produits de la categorie asociée
              Expanded(child: SingleChildScrollView(child: GetBuilder<ProductFromCategoryController>(builder: (productListController) {
                return productListController.isLoaded
                    ? Container(
                        //color: Colors.greenAccent,
                        width: double.maxFinite,
                        margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: productListController.productList.length,
                            itemBuilder: (context, index) {
                              ProductModel productModel = productListController.productList[index];
                              //print(productModel.image!);
                              return GestureDetector(
                                onTap: () {
                                  Get.find<ProductFromCategoryController>().initProduct(productModel, Get.find<CartController>());
                                  setState(() {
                                    pressed = !pressed;
                                  });

                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return DialogSalePage(
                                          productModel: productModel,
                                          productListController: productListController,
                                          categoryModuleId: widget.categoryModuleId,
                                          shopId: widget.shopId,
                                          categoryId: widget.categoryId,
                                        );
                                      });

                                  Timer(
                                      const Duration(seconds: 3),
                                      (() => setState(() {
                                            pressed = !pressed;
                                          })));
                                },
                                child: ProductItemWidget(
                                  titleText: (productModel.name)!.capitalize!,
                                  illustImage: NetworkImage(productModel.image!),
                                  priceProduct: productModel.manualPrice.toString(),
                                ),
                              );
                            }),
                      )
                    : const CircularProgressIndicator(
                        strokeWidth: 4,
                        color: AppColors.mainColor,
                      );
              }))),
            ],
          ),
        ],
      ),
    );
  }
}
