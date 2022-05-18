import 'dart:async';
import 'dart:developer';

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
import '../../widget/small_text.dart';
import '../models/sales_model.dart';

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

                      //print(widget.productListController.inCartItem);

                      widget.productListController.sale_addItem(widget.productModel);

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
