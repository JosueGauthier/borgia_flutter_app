import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/sales_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/small_text.dart';

class SalePage extends StatefulWidget {
/*   int apiOperatorPk;
  int apiModulePk;
  int apiShopPk;
  int apiOrderedQuantity;
  int apiCategoryProductId;
 */
  const SalePage({
    Key? key,
    /* required this.apiOperatorPk,
    required this.apiModulePk,
    required this.apiShopPk,
    required this.apiOrderedQuantity,
    required this.apiCategoryProductId, */
  }) : super(key: key);

  @override
  _SalePageState createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  int qty = 0;
  bool txtbuttonpressed = true;
/* 
  void _order(SalesController salesController) {
    /* int apiOperatorPk = widget.apiOperatorPk;
    int apiModulePk = widget.apiModulePk;
    int apiShopPk = widget.apiShopPk;
    int apiOrderedQuantity = widget.apiOrderedQuantity;
    int apiCategoryProductId = widget.apiCategoryProductId; */

    int apiOperatorPk = 7;
    int apiModulePk = 7;
    int apiShopPk = 7;
    int apiOrderedQuantity = 7;
    int apiCategoryProductId = 7;

    if (apiOrderedQuantity == 0) {
      Get.snackbar("Username empty", "Enter a valid username");
    } else {
      salesController.order(apiOperatorPk, apiModulePk, apiShopPk, apiOrderedQuantity, apiCategoryProductId).then((status) {
        if (status.isSuccess) {
          //print("Sucess login");
          Get.toNamed(RouteHelper.getInitial());
        } else {
          Get.snackbar("Error", status.message);
        }
      });
    }
  }
 */

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalesController>(builder: (salesController) {
      return Scaffold(
          body: ElevatedButton(
              child: SmallText(
                text: "Order",
                size: Dimensions.height20,
                color: AppColors.greyColor,
              ),
              onPressed: () {
                //_order(salesController);
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.only(left: Dimensions.width45, right: Dimensions.width45, top: Dimensions.height10, bottom: Dimensions.height10)),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) return AppColors.secondColor;
                    return AppColors.whiteGreyColor;
                  }))));
    });
  }
}



/*   @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: ElevatedButton(
          child: SmallText(
            text: "Order",
            size: Dimensions.height20,
            color: AppColors.greyColor,
          ),
          onPressed: () {
            //_order(salesController);
          },
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  EdgeInsets.only(left: Dimensions.width45, right: Dimensions.width45, top: Dimensions.height10, bottom: Dimensions.height10)),
              backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) return AppColors.secondColor;
                return AppColors.whiteGreyColor;
              }))),
    ));
  }
}
 */