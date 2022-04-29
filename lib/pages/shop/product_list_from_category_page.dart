import 'dart:async';

import 'package:borgiaflutterapp/models/product_model.dart';
import 'package:borgiaflutterapp/models/sales_model.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
            height: Dimensions.height45 * 2.5,
            decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.height20),
                  bottomRight: Radius.circular(Dimensions.height20),
                )),
            margin: EdgeInsets.only(bottom: Dimensions.height15),
            padding: EdgeInsets.only(bottom: Dimensions.height15, top: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Liste des produits", //todo add name of the shop
                  size: Dimensions.height30,
                  color: Colors.white,
                ),
                const AppIcon(iconData: Icons.shopping_bag, iconColor: AppColors.mainColor, backgroundColor: Colors.white),
              ],
            ),
          ),
          //! Scroll list des produits de la categorie asociée
          Expanded(child: SingleChildScrollView(child: GetBuilder<ProductFromCategoryController>(builder: (productListController) {
            //print("the list is: " + productListController.productList.toString());
            //print("the link list is: " + productListController.productLinkList.toString());
            return productListController.isLoaded
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: productListController.productList.length,
                    itemBuilder: (context, index) {
                      ProductModel productModel = productListController.productList[index];
                      //print(productModel.productImage!);
                      return GestureDetector(
                        onTap: () {
                          //Get.toNamed(RouteHelper.getRecommendedFood(index, "home"));
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10, bottom: Dimensions.height15),
                          child: Row(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //! image section

                                Stack(
                                  children: [
                                    Container(
                                      height: Dimensions.height100,
                                      width: Dimensions.height100,
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
                                    height: Dimensions.listviewTextHeigth + 10,
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
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(size: Dimensions.height30, text: productModel.manualPrice.toString() + " €"),
                                              Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.end, children: [
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: ElevatedButton(
                                                      child: SmallText(
                                                        text: "Bucque moi !",
                                                        size: Dimensions.height20,
                                                        color: pressed ? AppColors.secondColor : Colors.white,
                                                      ),
                                                      onPressed: () {
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
                                                            left: Dimensions.width20,
                                                            right: Dimensions.width20,
                                                            top: Dimensions.height10,
                                                            bottom: Dimensions.height10)),
                                                        backgroundColor: pressed
                                                            ? MaterialStateProperty.all<Color>(AppColors.whiteGreyColor)
                                                            : MaterialStateProperty.all<Color>(AppColors.secondColor),
                                                      )),
                                                )
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
                      );
                    })
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                //color: Colors.amber,
                width: Dimensions.width45 * 6,
                padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height10, bottom: Dimensions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.productListController.setQuantity(false);
                          if (widget.productListController.quantity <= 0) {
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
                        iconSize: 30,
                      ),
                    ),
                    BigText(
                      text: widget.productModel.manualPrice.toString() + "€" + " x " + widget.productListController.inCartItem.toString(),
                      color: AppColors.darkGreyColor,
                      size: Dimensions.height30,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.productListController.setQuantity(true);
                        });
                      },
                      child: const AppIcon(
                        iconData: Icons.add,
                        backgroundColor: AppColors.secondColor,
                        iconColor: Colors.white,
                        iconSize: 30,
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
                    //produitchoisis = widget.productModel.id!;
                    //print("le main id est " + widget.productModel.mainid.toString());
                    _order(salesController);
                    setState(() {
                      txtbuttonpressed = !txtbuttonpressed;
                    });

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
          ),
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
