import 'package:borgiaflutterapp/controllers/sale_list_controller.dart';
import 'package:borgiaflutterapp/controllers/shop_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../routes/route_helper.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';

Map datetimeMap = {};

class StatsPage extends StatefulWidget {
  StatsPage({Key? key}) : super(key: key);

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    Get.find<SaleListController>().getSaleList();

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<SaleListController>(builder: (saleListController) {
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
                //! header
                Container(
                  height: Dimensions.height45 * 2.7,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(Dimensions.height20),
                        bottomRight: Radius.circular(Dimensions.height20),
                      )),
                  margin: EdgeInsets.only(bottom: Dimensions.height10),
                  padding:
                      EdgeInsets.only(bottom: Dimensions.height10 / 2, top: Dimensions.height30 * 1.3, left: Dimensions.width20, right: Dimensions.width20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getInitial());
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.titleColor,
                          )),
                      BigText(
                        fontTypo: 'Montserrat-Bold',
                        text: "Statistiques",
                        size: Dimensions.height10 * 3,
                        color: AppColors.titleColor,
                      ),
                    ],
                  ),
                ),
                //! Line graph
                Container(
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
                              interval: 2,
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
                      //swapAnimationDuration: Duration(milliseconds: 1050), // Optional
                      //swapAnimationCurve: Curves.linear, // Optional
                    )),
                //!Pie chart

                Container(
                  //color: Colors.redAccent,
                  height: 400,
                  width: 400,
                  child: PieChart(
                    PieChartData(
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 0,
                        sections: showingSections()),
                  ),
                ),
              ]),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ),
            );
          }
        }));
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

List<PieChartSectionData> showingSections() {
  return List.generate(4, (i) {
    /* final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0; */

    switch (i) {
      case 0:
        return PieChartSectionData(
          color: const Color(0xff0293ee),
          value: 40,
          title: '40%',
          radius: 100,
          titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          /* badgeWidget: _Badge(
              'assets/ophthalmology-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xff0293ee),
            ), */
          badgePositionPercentageOffset: .98,
        );
      case 1:
        return PieChartSectionData(
          color: const Color(0xfff8b250),
          value: 30,
          title: '30%',
          radius: 100,
          titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          /* badgeWidget: _Badge(
              'assets/librarian-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xfff8b250),
            ), */
          badgePositionPercentageOffset: .98,
        );
      case 2:
        return PieChartSectionData(
          color: const Color(0xff845bef),
          value: 16,
          title: '16%',
          radius: 100,
          titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          /* badgeWidget: _Badge(
              'assets/fitness-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xff845bef),
            ), */
          badgePositionPercentageOffset: .98,
        );
      case 3:
        return PieChartSectionData(
          color: const Color(0xff13d38e),
          value: 15,
          title: '15%',
          radius: 100,
          titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          /* badgeWidget: _Badge(
              'assets/worker-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xff13d38e),
            ), */
          badgePositionPercentageOffset: .98,
        );
      default:
        throw 'Oh no';
    }
  });
}
