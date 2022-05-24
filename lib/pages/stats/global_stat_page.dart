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
      if (saleListController.isLoaded) {
        bool deleteZeros = true;
        List<Map<String, Object>> listeDesVentes = [];

        for (var i = 0; i < saleListController.aList.length; i++) {
          var priceSum = saleListController.aList[i]['price_sum'];

          if (priceSum == null && deleteZeros == false) {
            priceSum = 0.0;

            listeDesVentes.add({"Date": saleListController.aList[i]['format_day'], "Sale": priceSum});
          }

          if (priceSum != null) {
            deleteZeros = false;

            listeDesVentes.add({"Date": saleListController.aList[i]['format_day'], "Sale": priceSum});
          }
        }

        return SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            //! Line graph

            CustomLineChartWidget(
              listeDesVentes: listeDesVentes,
              linecolor: Colors.blueAccent,
              areacolor: Colors.blueAccent,
            ),

            Container(
              margin: const EdgeInsets.only(top: 10),
              width: double.maxFinite,
              height: Dimensions.height30 * 10,
              child: Chart(
                data: listeDesVentes,
                variables: {
                  'Date': Variable(
                    accessor: (Map map) => map['Date'] as String,
                    scale: OrdinalScale(tickCount: 5),
                  ),
                  'Sale': Variable(
                    accessor: (Map map) => (map['Sale'] ?? double.nan) as num,
                  ),
                },
                elements: [
                  AreaElement(
                    shape: ShapeAttr(value: BasicAreaShape(smooth: true)),
                    color: ColorAttr(value: AppColors.mainColor), //.withAlpha(80)
                  ),
                  LineElement(
                    color: ColorAttr(value: AppColors.mainColor),
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
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.mainColor,
          ),
        );
      }
    });
  }
}
