import 'dart:developer';

import 'package:borgiaflutterapp/controllers/sale_list_controller.dart';
import 'package:borgiaflutterapp/controllers/shop_controller.dart';
import 'package:borgiaflutterapp/widget/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/year_salelist_model.dart';
import '../../routes/route_helper.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/line_chart_2.dart';

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
          List<_SalesData> saleListData = [];

          ShopController shopController = Get.find();

          List shopList = shopController.shopList;

          //inspect(shopList);

          Map shopIdNameMap = {for (var v in shopList) v.id: v.name};

          bool deleteZeros = true;

          for (var i = 0; i < saleListController.saleList.length; i++) {
            var priceSum = saleListController.saleList[i].priceSum;

            if (saleListController.saleList[i].priceSum == null && deleteZeros == false) {
              priceSum = 0.0;
              saleListData.add(_SalesData(saleListController.saleList[i].startDay, priceSum));
            }

            if (saleListController.saleList[i].priceSum != null) {
              deleteZeros = false;
              saleListData.add(_SalesData(saleListController.saleList[i].startDay, priceSum));
            }
          }

          //inspect(saleListController.saleList);

          List listeDesVentes = [];

          for (var i = 0; i < saleListController.saleList.length; i++) {
            YearChartModel saleListModel = saleListController.saleList[i];

            listeDesVentes.add(saleListModel);
          }

          inspect(listeDesVentes);

          List nbOccurVenteShop = [];

          for (var i = 0; i < listeDesVentes.length; i++) {
            //nbOccurVenteShop.add(shop_id_name_map[listeDesVentes[i].shop]);
          }

          Map mapOccurenceVenteShop = {};

          /*  for (var shopId in nbOccurVenteShop) {
            if (!mapOccurenceVenteShop.containsKey(shopId)) {
              mapOccurenceVenteShop[shopId] = 1;
            } else {
              mapOccurenceVenteShop[shopId] += 1;
            }
          } */

          return saleListController.isLoaded
              ? SingleChildScrollView(
                  child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                              child: const Icon(
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
                    SizedBox(
                      height: Dimensions.height20 * 15,
                      child: LineChartWidget(),
                    ),

                    Container(child: LineChartSample2()),
                  ]),
                )
              : const CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }));
  }
}

class _SalesData {
  _SalesData(this.datetime, this.sales);

  final String datetime;
  final double sales;
}
