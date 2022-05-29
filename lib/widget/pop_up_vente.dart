import 'dart:async';

import 'package:borgiaflutterapp/controllers/product_controller.dart';
import 'package:borgiaflutterapp/models/product_model.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/product_from_category_controller.dart';
import '../../controllers/sales_controller.dart';
import '../../routes/route_helper.dart';
import '../../widget/app_icon.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';
import '../models/sales_model.dart';

class MyDialog extends StatefulWidget {
  final ProductModel productModel;
  final ProductFromCategoryController productListController;
  final int categoryModuleId;
  final int shopId;
  final int categoryId;

  const MyDialog(
      {Key? key,
      required this.productListController,
      required this.productModel,
      required this.categoryModuleId,
      required this.shopId,
      required this.categoryId})
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
      Get.snackbar("Quantité", "Entrer une quantité supérieure à 0");
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
          title: BigText(
            text: widget.productModel.name.toString(),
            fontTypo: 'Montserrat-Bold',
            size: Dimensions.height10 * 3,
            color: AppColors.titleColor,
          ),
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
                          iconSize: Dimensions.height30 * 1,
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

                            _quantityColor = AppColors.greenEmerald;

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
                    child: BigText(
                      text: "Je me bucque !",
                      size: Dimensions.height20 * 1,
                      color: Colors.white,
                      fontTypo: 'Montserrat-Bold',
                    ),
                    onPressed: () {
                      _order(salesController);

                      widget.productListController.sale_addItem(widget.productModel, widget.categoryId, widget.categoryModuleId, widget.shopId);

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
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50), side: BorderSide(color: AppColors.whiteGreyColor))),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.only(left: Dimensions.width45, right: Dimensions.width45, top: Dimensions.height10, bottom: Dimensions.height10)),
                        backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          return AppColors.greenEmerald;
                        }))),
              ],
            );
          }),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: Dimensions.height10 * 2),
              child: ElevatedButton(
                  child: BigText(
                    text: "Retour",
                    size: Dimensions.height20,
                    color: Colors.white,
                    fontTypo: 'Montserrat-Bold',
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50), side: BorderSide(color: AppColors.whiteGreyColor))),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.only(left: Dimensions.width45, right: Dimensions.width45, top: Dimensions.height10, bottom: Dimensions.height10)),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        return AppColors.greyColor;
                      }))),
            ),
          ]);
    });
  }
}
