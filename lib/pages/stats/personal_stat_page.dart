import 'package:borgiaflutterapp/controllers/user_shop_stat_controller.dart';
import 'package:borgiaflutterapp/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/sale_list_controller.dart';
import '../../utils/colors.dart';

import '../../widget/stat_widget/custom_button_stat.dart';
import '../../widget/stat_widget/piechart.dart';

Map datetimeMap = {};

class MyStatPage extends StatefulWidget {
  const MyStatPage({Key? key}) : super(key: key);

  @override
  State<MyStatPage> createState() => _MyStatPageState();
}

bool qtyButton = true;
bool eurosButton = false;
bool percentButton = false;

changeGraphState(int buttonId) {
  if (buttonId == 1) {
    qtyButton = true;
    eurosButton = false;
    percentButton = false;
  } else if (buttonId == 2) {
    qtyButton = false;
    eurosButton = true;
    percentButton = false;
  } else if (buttonId == 3) {
    qtyButton = false;
    eurosButton = false;
    percentButton = true;
  }
}

class _MyStatPageState extends State<MyStatPage> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaleListController>(builder: (saleListController) {
      if (saleListController.isLoaded) {
        return SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            //! Line graph

            //!Pie chart
            GetBuilder<UserShopStatController>(builder: (userShopStatController) {
              if (userShopStatController.isLoaded) {
                List montantMagasins = userShopStatController.userShopStatList[0].montantMagasins;
                return Container(
                  margin: EdgeInsets.only(
                    right: Dimensions.width10,
                    left: Dimensions.width10,
                  ),
                  height: Dimensions.height100 * 3.1,
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: double.maxFinite,
                        width: Dimensions.width10 * 12,
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          CustomButtonStat(
                            notifyParent: refresh,
                            id: 1,
                            size: Size(50, 30),
                            buttonColor: ListStatColors.colorslist1[0],
                          ),
                          CustomButtonStat(
                            notifyParent: refresh,
                            id: 2,
                            iconData: Icons.euro,
                            size: Size(50, 30),
                            buttonColor: ListStatColors.colorslist1[12],
                          ),
                          CustomButtonStat(
                            notifyParent: refresh,
                            id: 3,
                            iconData: Icons.percent,
                            size: Size(50, 30),
                            buttonColor: ListStatColors.colorslist1[20],
                          ),
                        ]),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (qtyButton == true)
                                ? Container(
                                    //color: Colors.blueAccent,
                                    child: CustomPiechartWigdet(
                                      statList: montantMagasins,
                                      colorList: ListStatColors.colorslist1,
                                      isImagePresent: true,
                                      typeOfData: "quantity",
                                    ),
                                  )
                                : (eurosButton == true)
                                    ? CustomPiechartWigdet(
                                        statList: montantMagasins,
                                        colorList: ListStatColors.colorslist1,
                                        isImagePresent: true,
                                        typeOfData: "amount",
                                      )
                                    : CustomPiechartWigdet(
                                        statList: montantMagasins,
                                        colorList: ListStatColors.colorslist1,
                                        isImagePresent: true,
                                        typeOfData: "percentage",
                                      ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ));
              }
            }),
          ]),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.mainColor,
          ),
        );
      }
    });
  }
}
