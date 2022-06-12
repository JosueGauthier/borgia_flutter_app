import 'dart:developer';

import 'package:borgiaflutterapp/widget/stat_widget/piechart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/sale_list_controller.dart';
import '../../controllers/shop_stat_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/stat_widget/custom_button_stat.dart';
import '../../widget/stat_widget/custom_linechart.dart';

Map datetimeMap = {};

class GlobalStatPage extends StatefulWidget {
  const GlobalStatPage({Key? key}) : super(key: key);

  @override
  State<GlobalStatPage> createState() => _GlobalStatPageState();
}

bool qtyButton = true;
bool eurosButton = false;
bool percentButton = false;

changeGraphStateGlobal(int buttonId) {
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

class _GlobalStatPageState extends State<GlobalStatPage> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaleListController>(builder: (saleListController) {
      if (saleListController.isLoadedYearList && saleListController.isLoadedHourList) {
        bool deleteZeros = true;
        List<Map<String, Object>> listeDesVentes = [];

        for (var i = 0; i < saleListController.yearList.length; i++) {
          var priceSum = saleListController.yearList[i]['price_sum'];

          if (priceSum == null && deleteZeros == false) {
            priceSum = 0.0;

            listeDesVentes.add({"Date": saleListController.yearList[i]['format_day'], "Sale": priceSum});
          }

          if (priceSum != null) {
            deleteZeros = false;

            listeDesVentes.add({"Date": saleListController.yearList[i]['format_day'], "Sale": priceSum});
          }
        }

        List<Map<String, Object>> hourList = [];

        for (var i = 0; i < saleListController.hourList.length; i++) {
          var priceSum = saleListController.hourList[i]['price_sum'];

          if (priceSum == null) {
            priceSum = 0.0;

            hourList.add({"Date": saleListController.hourList[i]['time'], "Sale": priceSum});
          } else {
            hourList.add({"Date": saleListController.hourList[i]['time'], "Sale": priceSum});
          }
        }

        inspect(hourList);

        inspect(listeDesVentes);

        List colorTheme = ListStatColors.colors12list15;

        return SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            //! Line graph

            //* live charts of the 2 past hours
            SizedBox(
              height: Dimensions.height20,
            ),
            Container(
              //color: AppColors.titleColor,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: Dimensions.width20),
              child: BigText(
                color: AppColors.titleColor,
                text: "Live des ventes",
                size: Dimensions.height25 * 1.1,
                fontTypo: 'Montserrat-Bold',
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            CustomLineChartWidget(
              listeDesVentes: hourList,
              linecolor: colorTheme[8],
              areacolor: colorTheme[8],
            ),

            //* History chart of past year
            SizedBox(
              height: Dimensions.height20,
            ),
            Container(
              //color: AppColors.titleColor,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: Dimensions.width20),
              child: BigText(
                color: AppColors.titleColor,
                text: "Historique des ventes",
                size: Dimensions.height25 * 1.1,
                fontTypo: 'Montserrat-Bold',
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            CustomLineChartWidget(
              listeDesVentes: listeDesVentes,
              linecolor: colorTheme[0],
              areacolor: colorTheme[0],
            ),

            //!Pie chart

            GetBuilder<ShopStatController>(builder: (shopStatController) {
              if (shopStatController.isLoaded) {
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
                      SizedBox(
                        height: double.maxFinite,
                        width: Dimensions.width10 * 12,
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          CustomButtonStat(
                            notifyParent: refresh,
                            id: 1,
                            size: const Size(50, 30),
                            buttonColor: colorTheme[0],
                          ),
                          CustomButtonStat(
                            notifyParent: refresh,
                            id: 2,
                            iconData: Icons.euro,
                            size: const Size(50, 30),
                            buttonColor: colorTheme[6],
                          ),
                          CustomButtonStat(
                            notifyParent: refresh,
                            id: 3,
                            iconData: Icons.percent,
                            size: const Size(50, 30),
                            buttonColor: colorTheme[9],
                          ),
                        ]),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (qtyButton == true)
                                ? CustomPiechartWigdet(
                                    statList: shopStatController.shopStatList,
                                    colorList: colorTheme,
                                    isImagePresent: true,
                                    typeOfData: "quantity",
                                  )
                                : (eurosButton == true)
                                    ? CustomPiechartWigdet(
                                        statList: shopStatController.shopStatList,
                                        colorList: colorTheme,
                                        isImagePresent: true,
                                        typeOfData: "amount",
                                      )
                                    : CustomPiechartWigdet(
                                        statList: shopStatController.shopStatList,
                                        colorList: colorTheme,
                                        isImagePresent: true,
                                        typeOfData: "percent",
                                      ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ));
              }
            }),

            SizedBox(
              height: Dimensions.height45,
            )
          ]),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.mainColor,
          ),
        );
      }
    });
  }
}
