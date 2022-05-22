import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/sale_list_controller.dart';
import '../../controllers/shop_controller.dart';
import '../../controllers/shop_stat_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

import 'dart:math' as math;

Map datetimeMap = {};

class GlobalStatPage extends StatefulWidget {
  const GlobalStatPage({Key? key}) : super(key: key);

  @override
  State<GlobalStatPage> createState() => _GlobalStatPageState();
}

class _GlobalStatPageState extends State<GlobalStatPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaleListController>(builder: (saleListController) {
      if (saleListController.isLoaded) {
        List<_SalesData> saleListData = [];

        ShopController shopController = Get.find();

        bool deleteZeros = true;

        List<FlSpot>? listeDesVentes = [];

        List listeVentes = [];

        List linspace = [];

        for (var i = 0; i < saleListController.saleList.length; i++) {
          var priceSum = saleListController.saleList[i].priceSum;

          if (saleListController.saleList[i].priceSum == null && deleteZeros == false) {
            priceSum = 0.0;
            //saleListData.add(_SalesData(saleListController.saleList[i].startDay, priceSum));

            DateTime dt = DateTime.parse(saleListController.saleList[i].startDay);

            double timeSecond = dt.millisecondsSinceEpoch.toDouble();

            FlSpot flSpot = FlSpot(timeSecond / 100000, priceSum);

            listeDesVentes.add(flSpot);
            listeVentes.add(timeSecond / 100000);
          }

          if (saleListController.saleList[i].priceSum != null) {
            deleteZeros = false;
            //saleListData.add(_SalesData(saleListController.saleList[i].startDay, priceSum));

            DateTime dt = DateTime.parse(saleListController.saleList[i].startDay);

            double timeSecond = dt.millisecondsSinceEpoch.toDouble();

            FlSpot flSpot = FlSpot(timeSecond / 100000, priceSum);

            listeDesVentes.add(flSpot);
            listeVentes.add(timeSecond / 100000);
          }
        }

        double delta;

        int nombreLegende = 5;

        delta = (listeVentes[(listeVentes.length) - 1] - listeVentes[0]) / nombreLegende;

        linspace = List<double>.generate(nombreLegende, (i) => listeVentes[0] + delta * i);

        for (var i = 0; i < linspace.length; i++) {
          int lin = linspace[i].toInt();
          DateTime date = DateTime.fromMillisecondsSinceEpoch(lin * 100000);

          var format = DateFormat('dd-MM');
          var dateString = format.format(date);

          datetimeMap[linspace[i]] = dateString;
        }

        return SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            //! Line graph
            /* Container(
                    height: Dimensions.height100 * 3,
                    width: double.maxFinite,
                    margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                    child: LineChart(
                      LineChartData(
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              getTitlesWidget: bottomTitleWidgets,
                              interval: 1,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: leftTitleWidgets,
                              reservedSize: 42,
                              interval: 5,
                            ),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          horizontalInterval: 1,
                          verticalInterval: 1,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              //color: const Color(0xff37434d),
                              color: AppColors.whiteGreyColor,
                              strokeWidth: 1,
                            );
                          },
                          getDrawingVerticalLine: (value) {
                            return FlLine(
                              color: Colors.white,
                              strokeWidth: 1,
                            );
                          },
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.secondColor,
                                AppColors.mainColor,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),

                            spots: listeDesVentes,
                            isCurved: true,
                            //curveSmoothness: 0.5,
                            preventCurveOverShooting: true,
                            barWidth: 0,
                            dotData: FlDotData(
                              show: false,
                            ),
                            isStrokeCapRound: true,
                            isStrokeJoinRound: true,
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.secondColor.withOpacity(0.5),
                                  AppColors.mainColor,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )), */
            //!Pie chart

            GetBuilder<ShopStatController>(builder: (shopStatController) {
              if (shopStatController.isLoaded) {
                return Column(
                  children: [
                    Container(
                      height: Dimensions.height30 * 10,
                      width: double.maxFinite,
                      child: PieChart(
                        PieChartData(
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 0,
                            sections: showingSectionsNumberSale(shopStatController.shopStatList)),
                      ),
                    ),
                    Container(
                      height: Dimensions.height30 * 10,
                      width: double.maxFinite,
                      child: PieChart(
                        PieChartData(
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 0,
                            sections: showingSectionsAmountSale(shopStatController.shopStatList)),
                      ),
                    ),
                    Container(
                      height: Dimensions.height30 * 10,
                      width: double.maxFinite,
                      child: PieChart(
                        PieChartData(
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 0,
                            sections: showingSectionsAmountSale(shopStatController.shopStatList)),
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

class _SalesData {
  _SalesData(this.datetime, this.sales);

  final String datetime;
  final double sales;
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff68737d),
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  Widget text = Text('', style: style);

  if (datetimeMap.containsKey(value)) {
    text = Text(datetimeMap[value], style: style);
  }

  return Padding(child: text, padding: const EdgeInsets.only(top: 8.0));
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff68737d),
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  Widget text = Text(value.toString(), style: style);

  return Padding(child: text, padding: const EdgeInsets.only(top: 8.0));
}

List<PieChartSectionData> showingSectionsNumberSale(List shopStatList) {
  return List.generate(shopStatList.length, (i) {
    return PieChartSectionData(
      color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
      value: shopStatList[i].totalSaleOfShop.toDouble(),
      title: shopStatList[i].name + "\n" + shopStatList[i].totalSaleOfShop.toString(),
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

List<PieChartSectionData> showingSectionsAmountSale(List shopStatList) {
  return List.generate(shopStatList.length, (i) {
    return PieChartSectionData(
      color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
      value: (shopStatList[i].totalSaleAmountOfShop.priceSum == null) ? 0 : shopStatList[i].totalSaleAmountOfShop.priceSum.toDouble(),
      title: (shopStatList[i].totalSaleAmountOfShop.priceSum == null)
          ? shopStatList[i].name + "\n" + "0"
          : shopStatList[i].name + "\n" + shopStatList[i].totalSaleAmountOfShop.priceSum.toString(),
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
