import 'dart:async';
import 'dart:developer';

import 'package:borgiaflutterapp/controllers/product_controller.dart';
import 'package:borgiaflutterapp/models/product_model.dart';
import 'package:borgiaflutterapp/models/sales_model.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/product_from_category_controller.dart';
import '../../controllers/sales_controller.dart';
import '../../routes/route_helper.dart';
import '../../widget/app_icon.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';

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
      body: Column(
        children: [
          //! header Text  + cart
          Container(
            height: Dimensions.height45 * 2.7,
            decoration: BoxDecoration(
                color: Colors.white,
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
                        child: Container(
                          width: Dimensions.width15 * 4,
                          height: Dimensions.width15 * 4,
                          child: Icon(
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
            //print("the list is: " + productListController.productList.toString());
            //print("the link list is: " + productListController.productLinkList.toString());
            return productListController.isLoaded
                ? Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: productListController.productList.length,
                        itemBuilder: (context, index) {
                          ProductModel productModel = productListController.productList[index];
                          //print(productModel.productImage!);
                          return GestureDetector(
                            onTap: () {
                              Get.find<ProductFromCategoryController>().initProduct(productModel, Get.find<CartController>());
                              setState(() {
                                pressed = !pressed;
                              });

                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return MyDialog(
                                      productModel: productModel,
                                      productListController: productListController,
                                      categoryModuleId: widget.categoryModuleId,
                                      shopId: widget.shopId,
                                    );
                                  });

                              Timer(
                                  const Duration(seconds: 3),
                                  (() => setState(() {
                                        pressed = !pressed;
                                      })));
                            },
                            child: Card(
                              elevation: 0,
                              shadowColor: AppColors.secondColor,
                              color: Colors.white,
                              child: Container(
                                height: Dimensions.height100 * 1.2,
                                margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10, bottom: Dimensions.height10),
                                child: Row(children: [
                                  //! image section

                                  Stack(
                                    children: [
                                      Container(
                                        height: Dimensions.height100 * 0.8,
                                        width: Dimensions.height100 * 0.8,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.width20)),
                                        child: (productModel.productImage == null)
                                            ? Container()
                                            : CachedNetworkImage(
                                                fit: BoxFit.contain,
                                                imageUrl: productModel.productImage!,
                                                placeholder: (context, url) => Center(
                                                  child: SizedBox(
                                                    height: Dimensions.height45,
                                                    width: Dimensions.height45,
                                                    child: const CircularProgressIndicator(
                                                      color: AppColors.secondColor,
                                                    ),
                                                  ),
                                                ),
                                                errorWidget: (context, url, error) => const Image(image: AssetImage("assets/image/errorimage.png")),
                                              ),
                                      ),
                                    ],
                                  ),

                                  //! text section

                                  Expanded(
                                    child: Container(
                                      height: Dimensions.listviewTextHeigth + 20,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(Dimensions.height20), bottomRight: Radius.circular(Dimensions.height20))),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: Dimensions.height10,
                                            ),
                                            BigText(
                                              text: (productModel.name)!.capitalize!,
                                              size: Dimensions.height25,
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                BigText(
                                                  size: Dimensions.height30 / 1.2,
                                                  text: productModel.manualPrice.toString() + " €",
                                                  color: AppColors.mainColor,
                                                ),
                                                Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.end, children: [
                                                  /* GestureDetector(
                                                    onTap: () {},
                                                    child: ElevatedButton(
                                                        child: SmallText(
                                                          text: "Bucque moi !",
                                                          size: Dimensions.height20 / 1.1,
                                                          color: pressed ? AppColors.secondColor : Colors.white,
                                                        ),
                                                        onPressed: () {
                                                          Get.find<ProductFromCategoryController>().initProduct(productModel, Get.find<CartController>());
                                                          setState(() {
                                                            pressed = !pressed;
                                                          });

                                                          showDialog(
                                                              context: context,
                                                              builder: (_) {
                                                                return MyDialog(
                                                                  productModel: productModel,
                                                                  productListController: productListController,
                                                                  categoryModuleId: widget.categoryModuleId,
                                                                  shopId: widget.shopId,
                                                                );
                                                              });

                                                          Timer(
                                                              const Duration(seconds: 3),
                                                              (() => setState(() {
                                                                    pressed = !pressed;
                                                                  })));
                                                        },
                                                        style: ButtonStyle(
                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(5.0), /* side: BorderSide(color: AppColors.greyColormedium) */
                                                          )),
                                                          padding: MaterialStateProperty.all(EdgeInsets.only(
                                                              left: Dimensions.width10 / 2,
                                                              right: Dimensions.width10 / 2,
                                                              top: Dimensions.height10,
                                                              bottom: Dimensions.height10)),
                                                          backgroundColor: pressed
                                                              ? MaterialStateProperty.all<Color>(AppColors.whiteGreyColor)
                                                              : MaterialStateProperty.all<Color>(AppColors.secondColor),
                                                        )),
                                                  ) */
                                                ])
                                              ],
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  //? expanded widget force container to take all the available space
                                ]),
                              ),
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
    );
  }
}

class MyDialog extends StatefulWidget {
  final ProductModel productModel;
  final ProductFromCategoryController productListController;
  final int categoryModuleId;
  final int shopId;

  const MyDialog({Key? key, required this.productListController, required this.productModel, required this.categoryModuleId, required this.shopId})
      : super(key: key);

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  Color _addRemoveColor = AppColors.secondColor;
  Color _quantityColor = AppColors.secondColor;
  int qty = 0;
  bool txtbuttonpressed = true;

  void _order(
    SalesController salesController,
  ) {
    String username = AppConstants.USERNAME;
    String password = AppConstants.PASSWORD;
    int apiModulePk = widget.categoryModuleId;
    int apiShopPk = widget.shopId;
    int apiOrderedQuantity = widget.productListController.inCartItem;
    int apiCategoryProductId = widget.productModel.mainid!;

    SalesModel _salesModel = SalesModel(
        apiModulePk: apiModulePk,
        apiShopPk: apiShopPk,
        apiOrderedQuantity: apiOrderedQuantity,
        apiCategoryProductId: apiCategoryProductId,
        username: username,
        password: password);

    if (apiOrderedQuantity == 0) {
      Get.snackbar("Username empty", "Enter a valid username");
    } else {
      salesController.order(_salesModel).then((status) {
        if (status.isSuccess) {
          //print("Sucess login");
          Get.toNamed(RouteHelper.getInitial());
        } else {
          Get.snackbar("Error", status.message);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalesController>(builder: (salesController) {
      return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.height20)),
          title: BigText(text: widget.productModel.name.toString(), size: Dimensions.height30),
          content: GetBuilder<ProductController>(builder: (productcontroller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  //color: Colors.amber,
                  width: Dimensions.width45 * 6,
                  padding: EdgeInsets.only(/* left: Dimensions.width10, right: Dimensions.width20, */ top: Dimensions.height10, bottom: Dimensions.height10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //productcontroller.setQuantity(false);
                          setState(() {
                            widget.productListController.setQuantity(false);

                            _quantityColor = AppColors.mainColor;

                            Timer(
                                const Duration(milliseconds: 200),
                                (() => setState(() {
                                      _quantityColor = AppColors.secondColor;
                                    })));
                            if (widget.productListController.inCartItem <= 0) {
                              setState(() {
                                _addRemoveColor = AppColors.mainColor;
                              });

                              Timer(
                                  const Duration(milliseconds: 500),
                                  (() => setState(() {
                                        _addRemoveColor = AppColors.secondColor;
                                      })));
                            }
                          });
                        },
                        child: AppIcon(
                          iconData: Icons.remove,
                          backgroundColor: _addRemoveColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height30,
                        ),
                      ),
                      Row(
                        children: [
                          BigText(
                            text: widget.productModel.manualPrice.toString() + "€" + " x ",
                            color: AppColors.darkGreyColor,
                            size: Dimensions.height30,
                            fontTypo: 'OpenSansExtraBold',
                          ),
                          BigText(
                            text: widget.productListController.inCartItem.toString(),
                            color: _quantityColor,
                            size: Dimensions.height30,
                            fontTypo: 'OpenSansExtraBold',
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            //productcontroller.setQuantity(true);
                            widget.productListController.setQuantity(true);

                            _quantityColor = AppColors.mainColor;

                            Timer(
                                const Duration(milliseconds: 200),
                                (() => setState(() {
                                      _quantityColor = AppColors.secondColor;
                                    })));
                          });
                        },
                        child: AppIcon(
                          iconData: Icons.add,
                          backgroundColor: AppColors.secondColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height30,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                ElevatedButton(
                    child: SmallText(
                      text: " Je me bucque !",
                      size: Dimensions.height30,
                      color: txtbuttonpressed ? AppColors.titleColor : Colors.white,
                    ),
                    onPressed: () {
                      //! to put below _order !

                      _order(salesController);

                      print(widget.productListController.inCartItem);

                      widget.productListController.sale_addItem(widget.productModel);

                      inspect(widget.productListController.theCartController);

                      setState(() {
                        txtbuttonpressed = !txtbuttonpressed;
                      });

                      //widget.productListController.setQuantityToZero();

                      Timer(
                          const Duration(seconds: 3),
                          (() => setState(() {
                                txtbuttonpressed = !txtbuttonpressed;
                              })));
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0), /* side: BorderSide(color: AppColors.greyColormedium) */
                      )),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height10, bottom: Dimensions.height10)),
                      backgroundColor:
                          txtbuttonpressed ? MaterialStateProperty.all<Color>(AppColors.whiteGreyColor) : MaterialStateProperty.all<Color>(AppColors.mainColor),
                    )),
              ],
            );
          }),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: Dimensions.height10),
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(AppColors.whiteGreyColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: SmallText(
                  text: 'Retour',
                  size: Dimensions.height20,
                  color: AppColors.mainColor,
                ),
              ),
            ),
          ]);
    });
  }
}
