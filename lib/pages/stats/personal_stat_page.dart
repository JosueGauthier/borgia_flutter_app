import 'package:borgiaflutterapp/controllers/user_shop_stat_controller.dart';
import 'package:borgiaflutterapp/utils/dimensions.dart';
import 'package:borgiaflutterapp/widget/stat_widget/circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/sale_list_controller.dart';
import '../../utils/colors.dart';

import '../../widget/big_text.dart';
import '../../widget/stat_widget/custom_button_stat.dart';
import '../../widget/stat_widget/custom_linechart.dart';
import '../../widget/stat_widget/piechart.dart';

import 'package:percent_indicator/percent_indicator.dart';

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

double calculatePercent(var number) {
  int intNumber = number.toInt();

  String stringNumber = intNumber.toString();
  if (stringNumber.length > 1) {
    String newString = stringNumber.substring(stringNumber.length - 2);
    int numberTransformed = int.parse(newString);
    double percent = numberTransformed / 100;
    return percent;
  } else {
    String newString = stringNumber;
    int numberTransformed = int.parse(newString);
    double percent = numberTransformed / 100;
    return percent;
  }
}

int countHundredStep(var number) {
  int intNumber = number.toInt();

  String stringNumber = intNumber.toString();
  if (stringNumber.length > 2) {
    String newString = stringNumber.substring(0, stringNumber.length - 2);
    int numberTransformed = int.parse(newString);
    return numberTransformed;
  } else if (stringNumber.length > 19) {
    return 19;
  } else {
    return 0;
  }
}

String emojiTrailling(int nbRefAchetee, int nbRefTotale) {
  double ratio = nbRefAchetee / nbRefTotale;

  if (ratio >= 0.9) {
    return "👑";
  } else if (ratio >= 0.7 && ratio < 0.9) {
    return "🚀";
  } else if (ratio >= 0.3 && ratio < 0.7) {
    return "🤩";
  } else if (ratio >= 0.1 && ratio < 0.3) {
    return "👏";
  } else if (ratio < 0.1) {
    return "💪";
  } else {
    return "🦑";
  }
}

class _MyStatPageState extends State<MyStatPage> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaleListController>(builder: (saleListController) {
      if (saleListController.isLoadedUser) {
        List<Map<String, Object>> listeDesVentes = [];

        for (var i = 0; i < saleListController.aListUser.length; i++) {
          var priceSum = saleListController.aListUser[i]['tot_amount_per_sale'];

          if (priceSum != null && priceSum != 0.0) {
            listeDesVentes.add({"Date": saleListController.aListUser[i]['format_datetime'], "Sale": priceSum});
          }
        }

        return GetBuilder<UserShopStatController>(builder: (userShopStatController) {
          if (userShopStatController.isLoaded) {
            List montantMagasins = userShopStatController.userShopStatList[0].montantMagasins;

            double montantAchats = userShopStatController.userShopStatList[0].montantAchats;
            double montantAchatsPercent = calculatePercent(montantAchats);
            int numberofHundredsmontantAchats = countHundredStep(montantAchats);

            int qtyAchats = userShopStatController.userShopStatList[0].quantiteAchatsTotal;
            double qtyAchatsPercent = calculatePercent(qtyAchats);
            int numberofHundredsqtyAchats = countHundredStep(qtyAchats);
            return SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  //color: Colors.greenAccent,
                  height: Dimensions.height100 * 2.8,
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomCircularIndicator(
                              text: "$montantAchats€", progressColor: ListStatColors.colorslist1[numberofHundredsmontantAchats], percent: montantAchatsPercent),
                          CustomCircularIndicator(
                              text: "$qtyAchats prod.", progressColor: ListStatColors.colorslist1[numberofHundredsqtyAchats], percent: qtyAchatsPercent)
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: Dimensions.height20 * 4,
                            width: Dimensions.width20 * 8,
                            decoration: BoxDecoration(color: ListStatColors.colorslist1[0], borderRadius: BorderRadius.circular(Dimensions.width20)),
                            child: Center(
                              child: BigText(
                                fontTypo: 'Helvetica-Bold',
                                text: "# 12 / 250 ",
                                size: Dimensions.height25 * 1,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width20,
                          ),
                          Column(
                            children: [
                              BigText(
                                fontTypo: 'Helvetica-Bold',
                                text:
                                    "${userShopStatController.userShopStatList[0].nbRefAchetee} / ${userShopStatController.userShopStatList[0].nbRefTotale} refs",
                                size: Dimensions.height25 * 0.8,
                                color: AppColors.titleColor,
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              LinearPercentIndicator(
                                width: Dimensions.width20 * 8,
                                animation: true,
                                lineHeight: 20.0,
                                trailing: Text(emojiTrailling(
                                    userShopStatController.userShopStatList[0].nbRefAchetee, userShopStatController.userShopStatList[0].nbRefTotale)),
                                animationDuration: 2000,
                                percent: userShopStatController.userShopStatList[0].nbRefAchetee / userShopStatController.userShopStatList[0].nbRefTotale,
                                barRadius: const Radius.circular(50),
                                backgroundColor: AppColors.whiteGreyColor,
                                progressColor: ListStatColors.colorslist2[0],
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                //! Line graph

                Container(
                  //color: AppColors.titleColor,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(
                    color: AppColors.titleColor,
                    text: "Mon historique",
                    size: Dimensions.height25 * 1.1,
                    fontTypo: 'Montserrat-Bold',
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),

                CustomLineChartWidget(
                  listeDesVentes: listeDesVentes,
                  linecolor: ListStatColors.colorslist1[20],
                  areacolor: ListStatColors.colorslist1[20],
                  numberXTickCount: 3,
                ),

                //!Pie chart
                SizedBox(
                  height: Dimensions.height20 * 2,
                ),

                Container(
                  //color: AppColors.titleColor,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(
                    color: AppColors.titleColor,
                    text: "Mes achats",
                    size: Dimensions.height25 * 1.1,
                    fontTypo: 'Montserrat-Bold',
                  ),
                ),

                Container(
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
                            buttonColor: ListStatColors.colorslist1[0],
                          ),
                          CustomButtonStat(
                            notifyParent: refresh,
                            id: 2,
                            iconData: Icons.euro,
                            size: const Size(50, 30),
                            buttonColor: ListStatColors.colorslist1[12],
                          ),
                          CustomButtonStat(
                            notifyParent: refresh,
                            id: 3,
                            iconData: Icons.percent,
                            size: const Size(50, 30),
                            buttonColor: ListStatColors.colorslist1[20],
                          ),
                        ]),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (qtyButton == true)
                                ? CustomPiechartWigdet(
                                    statList: montantMagasins,
                                    colorList: ListStatColors.colorslist1,
                                    isImagePresent: true,
                                    typeOfData: "quantity",
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
                ),

                SizedBox(
                  height: Dimensions.width20 * 2,
                ),
              ]),
            );
          } else {
            return const Center(
                child: const CircularProgressIndicator(
              strokeWidth: 4,
              color: AppColors.mainColor,
            ));
          }
        });
      } else {
        return const Center(
          child: const CircularProgressIndicator(
            strokeWidth: 4,
            color: AppColors.mainColor,
          ),
        );
      }
    });
  }
}
