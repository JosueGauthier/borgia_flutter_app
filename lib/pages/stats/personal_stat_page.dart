import 'dart:developer';

import 'package:borgiaflutterapp/controllers/user_shop_stat_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/sale_list_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

import 'dart:math' as math;

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
              inspect(userShopStatController.userShopStatList);

              if (userShopStatController.isLoaded) {
                return Column(
                  children: [
                    Container(
                      //color: Colors.greenAccent,
                      height: Dimensions.height30 * 10,
                      width: double.maxFinite,
                      child: PieChart(
                        PieChartData(
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 0,
                            sections: showingSectionsNumberSale(userShopStatController.userShopStatList)),
                      ),
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

List<PieChartSectionData> showingSectionsNumberSale(List userShopStatList) {
  List montantMagasins = userShopStatList[0].montantMagasins;

  //inspect(montantMagasins);

  return List.generate(montantMagasins.length, (i) {
    return PieChartSectionData(

      color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
      value: montantMagasins[i].qteUserAchats.toDouble(), //userShopStatList[i].totalSaleOfShop.toDouble(),
      title: montantMagasins[i].shopName, //userShopStatList[i].name + "\n" + userShopStatList[i].totalSaleOfShop.toString(),
      radius: 100,
      titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
      /* badgeWidget: _Badge(
              'assets/ophthalmology-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xff0293ee),
            ), */
      //badgePositionPercentageOffset: .98,
    );
  });
}
