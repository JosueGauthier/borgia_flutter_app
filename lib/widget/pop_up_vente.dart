import 'dart:async';

import 'package:borgiaflutterapp/controllers/product_list_controller.dart';
import 'package:borgiaflutterapp/models/product_model.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sales_controller.dart';
import '../../routes/route_helper.dart';
import '../../widget/app_icon.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../models/operator_sales_model.dart';
import '../models/self_sales_model.dart';
import '../models/user_model.dart';

class DialogSalePage extends StatefulWidget {
  final ProductModel productModel;
  final ProductListController productListController;
  final UserModel? buyer;

  const DialogSalePage(
      {Key? key,
      required this.productListController,
      required this.productModel,
      this.buyer})
      : super(key: key);

  @override
  DialogSalePageState createState() => DialogSalePageState();
}

class DialogSalePageState extends State<DialogSalePage> {
  int qty = 0;
  bool txtbuttonpressed = true;

  void _order(
    SalesController salesController,
  ) {
    if (widget.productModel.contentTypeParentCategory == 'selfsalemodule') {
      String username = AppConstants.USERNAME;
      String password = AppConstants.PASSWORD;
      int apiModulePk = widget.productModel.moduleIdParentCategory!;
      int apiShopPk = widget.productModel.shop!;
      int apiOrderedQuantity = widget.productListController.inCartItem;
      int apiCategoryProductId = widget.productModel.idCategoryproductTable!;

      SelfSalesModel salesModel = SelfSalesModel(
          apiModulePk: apiModulePk,
          apiShopPk: apiShopPk,
          apiOrderedQuantity: apiOrderedQuantity,
          apiCategoryProductId: apiCategoryProductId,
          username: username,
          password: password);

      if (apiOrderedQuantity == 0) {
        Get.snackbar("Quantité", "Entrer une quantité supérieure à 0");
      } else {
        salesController.selfOrder(salesModel).then((status) {
          if (status.isSuccess) {
            widget.productListController.saleAddItem(widget.productModel);
            Get.toNamed(RouteHelper.getInitial());
          } else {
            Get.snackbar(
                "Error", "Vente non effectuée. Vous n'avez pas été débité.",
                backgroundColor: Colors.redAccent);
          }
        });
      }
    }
    if (widget.productModel.contentTypeParentCategory == 'operatorsalemodule') {
      String username = AppConstants.USERNAME;
      String password = AppConstants.PASSWORD;
      int apiBuyerPk = widget.buyer!.id!;
      int apiModulePk = widget.productModel.moduleIdParentCategory!;
      int apiShopPk = widget.productModel.shop!;
      int apiOrderedQuantity = widget.productListController.inCartItem;
      int apiCategoryProductId = widget.productModel.idCategoryproductTable!;

      OperatorSalesModel salesModel = OperatorSalesModel(
          apiModulePk: apiModulePk,
          apiShopPk: apiShopPk,
          apiOrderedQuantity: apiOrderedQuantity,
          apiCategoryProductId: apiCategoryProductId,
          buyer: apiBuyerPk,
          username: username,
          password: password);

      if (apiOrderedQuantity == 0) {
        Get.snackbar("Quantité", "Entrer une quantité supérieure à 0");
      } else {
        salesController.operatorOrder(salesModel).then((status) {
          if (status.isSuccess) {
            widget.productListController.quantity = 0;

            //! changer below
            Get.back();

            Get.back();

            //Get.toNamed(RouteHelper.getAdminSearchPage(apiShopPk));
          } else {
            Get.snackbar(
                "Error", "Vente non effectuée. L'acheteur n'a pas été débité.",
                backgroundColor: Colors.redAccent);
          }
        });
      }
    } else {}
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color addRemoveColor = AppColors.secondColor;
    Color quantityColor = Theme.of(context).colorScheme.onPrimary;
    return GetBuilder<SalesController>(builder: (salesController) {
      return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.height45)),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                //margin: EdgeInsets.only(bottom: Dimensions.height10 * 2),
                height: Dimensions.height100 * 0.9,
                width: Dimensions.height100 * 0.9,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                child: SizedBox(
                  height: Dimensions.height100 * 0.6,
                  width: Dimensions.height100 * 0.6,
                  child: (widget.productModel.image != null)
                      ? CachedNetworkImage(
                          imageUrl: widget.productModel.image!,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error, color: Colors.black),
                        )
                      : const Icon(Icons.image_not_supported,
                          color: Colors.black),
                ),
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              Text(widget.productModel.name.toString(),
                  style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Dimensions.width45 * 6,
                //padding: const EdgeInsets.only(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.productListController.setQuantity(false);

                          quantityColor = AppColors.mainColor;

                          Timer(
                              const Duration(milliseconds: 200),
                              (() => setState(() {
                                    quantityColor = AppColors.secondColor;
                                  })));
                          if (widget.productListController.inCartItem <= 0) {
                            setState(() {
                              addRemoveColor = AppColors.mainColor;
                            });

                            Timer(
                                const Duration(milliseconds: 500),
                                (() => setState(() {
                                      addRemoveColor = AppColors.secondColor;
                                    })));
                          }
                        });
                      },
                      child: AppIcon(
                        iconData: Icons.remove,
                        backgroundColor: addRemoveColor,
                        iconColor: Theme.of(context).colorScheme.surface,
                        iconSize: Dimensions.height30 * 1,
                      ),
                    ),
                    Row(
                      children: [
                        Text("${widget.productModel.manualPrice}€ x ",
                            style: Theme.of(context).textTheme.labelSmall),
                        Text(widget.productListController.inCartItem.toString(),
                            style: TextStyle(
                                color: quantityColor,
                                fontFamily: 'Montserrat-Bold',
                                fontSize: 20,
                                overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.productListController.setQuantity(true);

                          quantityColor = AppColors.greenEmerald;

                          Timer(
                              const Duration(milliseconds: 200),
                              (() => setState(() {
                                    quantityColor = AppColors.secondColor;
                                  })));
                        });
                      },
                      child: AppIcon(
                        iconData: Icons.add,
                        backgroundColor: AppColors.secondColor,
                        iconColor: Theme.of(context).colorScheme.surface,
                        iconSize: Dimensions.height30,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
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
                      padding: MaterialStateProperty.all(
                          EdgeInsets.all(Dimensions.height10 * 2)),
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return AppColors.greenEmerald;
                      })),
                  child: Text(
                    "Valider",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontFamily: 'Montserrat-Bold',
                        fontSize: 16,
                        letterSpacing: 1,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.cancel_rounded,
                    color: AppColors.mainColor,
                    size: Dimensions.height20 * 3,
                  ),
                )
              ],
            )
          ]);
    });
  }
}
