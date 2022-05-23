import 'package:borgiaflutterapp/controllers/user_shop_stat_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/sale_list_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

import '../../widget/stat_widget/piechart.dart';

Map datetimeMap = {};

class MyStatPage extends StatefulWidget {
  const MyStatPage({Key? key}) : super(key: key);

  @override
  State<MyStatPage> createState() => _MyStatPageState();
}

class _MyStatPageState extends State<MyStatPage> {
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
                return Column(
                  children: [
                    CustomPiechartWigdet(
                      statList: montantMagasins,
                      colorList: ListStatColors.colorslist1,
                      isImagePresent: true,
                      typeOfData: "quantity",
                    ),
                    CustomPiechartWigdet(
                      statList: montantMagasins,
                      colorList: ListStatColors.colorslist1,
                      isImagePresent: true,
                      typeOfData: "amount",
                    ),
                  ],
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
