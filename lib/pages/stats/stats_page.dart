import 'dart:developer';

import 'package:borgiaflutterapp/controllers/sale_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../routes/route_helper.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/doughnut_chart.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  //List<_SalesData> data = [_SalesData('Jan', 35), _SalesData('Feb', 28), _SalesData('Mar', 34), _SalesData('Apr', 32), _SalesData('May', 40)];

  @override
  Widget build(BuildContext context) {
    Get.find<SaleListController>().getSaleList();

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<SaleListController>(builder: (saleListController) {
          //List<SaleListModel> saleListData = [];

          List<_SalesData> saleListData = [];

          inspect(saleListController.saleList);

          print(saleListController.saleList[0].datetime);
          print(saleListController.saleList[0].products.first);

          for (var i = 0; i < saleListController.saleList.length; i++) {
            saleListData.add(_SalesData(saleListController.saleList[i].datetime, saleListController.saleList[i].products.first));

            //_saleList.add(SaleListModel.fromJson(responseBody[i]));
          }

          print(saleListData);

          return saleListController.isLoaded
              ? Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                  //Initialize the chart widget
                  Container(
                    height: Dimensions.height20 * 15,
                    child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        // Chart title
                        title: ChartTitle(text: 'Half yearly sales analysis'),
                        // Enable legend
                        legend: Legend(isVisible: true),
                        // Enable tooltip
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries<_SalesData, String>>[
                          LineSeries<_SalesData, String>(
                              dataSource: saleListData,
                              xValueMapper: (_SalesData sales, _) => sales.datetime,
                              yValueMapper: (_SalesData sales, _) => sales.sales,
                              name: 'Sales',
                              // Enable data label
                              dataLabelSettings: DataLabelSettings(isVisible: true))
                        ]),
                  ),

                  Container(child: DonutChart()),
                ])
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }));
  }
}

class _SalesData {
  _SalesData(this.datetime, this.sales);

  final String datetime;
  final int sales;
}
