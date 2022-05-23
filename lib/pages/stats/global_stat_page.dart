import 'dart:developer';

import 'package:borgiaflutterapp/widget/stat_widget/piechart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphic/graphic.dart';

import '../../controllers/sale_list_controller.dart';
import '../../controllers/shop_stat_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/stat_widget/custom_button_stat.dart';

import 'data.dart';

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
  //print(buttonId);
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
      //print(saleListController.saleList);
      //inspect(saleListController.saleList[0]);

      print(saleListController.aList);

      if (saleListController.isLoaded) {
        bool deleteZeros = true;

        List<FlSpot>? listeDesVentes = [];

        for (var i = 0; i < saleListController.saleList.length; i++) {
          var priceSum = saleListController.saleList[i].priceSum;

          if (saleListController.saleList[i].priceSum == null && deleteZeros == false) {
            priceSum = 0.0;

            double a = DateTime.parse(saleListController.saleList[i].startDay).millisecondsSinceEpoch.toDouble();

            FlSpot flSpot = FlSpot(1, priceSum);

            listeDesVentes.add(flSpot);
          }

          if (saleListController.saleList[i].priceSum != null) {
            deleteZeros = false;

            double a = DateTime.parse(saleListController.saleList[i].startDay).millisecondsSinceEpoch.toDouble();

            FlSpot flSpot = FlSpot(1, priceSum);

            listeDesVentes.add(flSpot);
          }
        }

        return SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: Dimensions.height20,
            ),
            //! Line graph

            //!Pie chart

            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 350,
              height: 300,
              child: Chart(
                data: saleListController.aList,
                variables: {
                  'format_day': Variable(
                    accessor: (Map map) => map['format_day'] as String,
                    scale: OrdinalScale(tickCount: 5),
                  ),
                  'price_sum': Variable(
                    accessor: (Map map) => (map['price_sum'] ?? double.nan) as num,
                  ),
                },
                elements: [
                  AreaElement(
                    shape: ShapeAttr(value: BasicAreaShape(smooth: true)),
                    color: ColorAttr(value: Defaults.colors10.first.withAlpha(80)),
                  ),
                  LineElement(
                    shape: ShapeAttr(value: BasicLineShape(smooth: true)),
                    size: SizeAttr(value: 0.5),
                  ),
                ],
                axes: [
                  Defaults.horizontalAxis,
                  Defaults.verticalAxis,
                ],
                selections: {
                  'touchMove': PointSelection(
                    on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate},
                    dim: Dim.x,
                  )
                },
                tooltip: TooltipGuide(
                  followPointer: [false, true],
                  align: Alignment.topLeft,
                  offset: const Offset(-20, -20),
                ),
                crosshair: CrosshairGuide(followPointer: [false, true]),
              ),
            ),

            GetBuilder<ShopStatController>(builder: (shopStatController) {
              if (shopStatController.isLoaded) {
                //List montantMagasins = shopStatController.userShopStatList[0].montantMagasins;
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
                                      statList: shopStatController.shopStatList,
                                      colorList: ListStatColors.colors_12_list14,
                                      isImagePresent: true,
                                      typeOfData: "quantity",
                                    ),
                                  )
                                : (eurosButton == true)
                                    ? CustomPiechartWigdet(
                                        statList: shopStatController.shopStatList,
                                        colorList: ListStatColors.colorslist5,
                                        isImagePresent: true,
                                        typeOfData: "amount",
                                      )
                                    : CustomPiechartWigdet(
                                        statList: shopStatController.shopStatList,
                                        colorList: ListStatColors.colorslist10,
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

  Widget text = Text(value.toString(), style: style);

  return Padding(child: text, padding: const EdgeInsets.only(top: 0));

  /* Widget text = Text('', style: style);

  if (datetimeMap.containsKey(value)) {
    text = Text(datetimeMap[value], style: style);
  }

  return Padding(child: text, padding: const EdgeInsets.only(top: 8.0)); */
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff68737d),
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  Widget text = Text(value.toString(), style: style);

  return Padding(child: text, padding: const EdgeInsets.only(top: 0));
}
