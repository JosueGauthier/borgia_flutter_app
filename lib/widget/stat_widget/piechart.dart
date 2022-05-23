import 'dart:developer';

import 'package:borgiaflutterapp/utils/dimensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CustomPiechartWigdet extends StatefulWidget {
  List statList;
  List colorList;
  bool isImagePresent;
  String typeOfData;
  CustomPiechartWigdet({Key? key, required this.statList, required this.colorList, required this.isImagePresent, required this.typeOfData}) : super(key: key);

  @override
  State<CustomPiechartWigdet> createState() => _CustomPiechartWigdetState();
}

class _CustomPiechartWigdetState extends State<CustomPiechartWigdet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: Dimensions.height30 * 10,
        width: double.maxFinite,
        child: PieChart(
          PieChartData(
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 0,
            sections: (widget.typeOfData == "quantity")
                ? showingSectionsQuantity(widget.statList, widget.colorList, widget.isImagePresent)
                : (widget.typeOfData == "quantity")
                    ? showingSectionsAmount(widget.statList, widget.colorList, widget.isImagePresent)
                    : showingSectionsPercentage(widget.statList, widget.colorList, widget.isImagePresent),
          ),
        ));
  }
}

List<PieChartSectionData> showingSectionsQuantity(List dataList, List colorList, bool isImagePresent) {
  return List.generate(dataList.length, (i) {
    return PieChartSectionData(
      color: ListStatColors.colorslist1[ListStatColors.colorslist1.length ~/ dataList.length * i],
      //colorList[(i.isEven) ? (colorList.length / dataList.length).toInt() * i : (colorList.length - (colorList.length / dataList.length).toInt() * i)],
      value: dataList[i].quantity.toDouble(),
      title: isImagePresent ? (dataList[i].quantity.toString()) : dataList[i].shopName + "\n" + dataList[i].quantity.toString(),
      radius: 100,
      titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
      badgeWidget: isImagePresent
          ? _Badge(
              dataList[i].shopImage,
              size: Dimensions.height45,
              borderColor: ListStatColors.colorslist1[ListStatColors.colorslist1.length ~/ dataList.length * i],
            )
          : Container(),
      badgePositionPercentageOffset: .98,
    );
  });
}

List<PieChartSectionData> showingSectionsAmount(List dataList, List colorList, bool isImagePresent) {
  return List.generate(dataList.length, (i) {
    return PieChartSectionData(
      color: ListStatColors.colorslist1[ListStatColors.colorslist1.length ~/ dataList.length * i],

      value: (dataList[i].montantAchats == null) ? 0 : dataList[i].montantAchats.toDouble(),
      //title: dataList[i].shopName + "\n" + dataList[i].quantity.toString(),
      radius: 100,
      titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
      badgeWidget: isImagePresent
          ? _Badge(
              dataList[i].shopImage,
              size: Dimensions.height45,
              borderColor: ListStatColors.colorslist1[ListStatColors.colorslist1.length ~/ dataList.length * i],
            )
          : Container(),
      badgePositionPercentageOffset: .98,
    );
  });
}

List<PieChartSectionData> showingSectionsPercentage(List dataList, List colorList, bool isImagePresent) {
  double sum = 0;
  for (var i = 0; i < dataList.length; i++) {
    sum += (dataList[i].montantAchats == null) ? 0 : dataList[i].montantAchats;
  }

  return List.generate(dataList.length, (i) {
    int valeur = (dataList[i].montantAchats == null) ? 0 : (((dataList[i].montantAchats.toDouble()) / sum) * 100).toInt();
    print(valeur);
    return PieChartSectionData(
      color: ListStatColors.colorslist1[ListStatColors.colorslist1.length ~/ dataList.length * i],
      value: valeur.toDouble(),
      title: valeur.toString() + "%",
      radius: 100,
      titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
      badgeWidget: isImagePresent
          ? _Badge(
              dataList[i].shopImage,
              size: Dimensions.height45,
              borderColor: ListStatColors.colorslist1[ListStatColors.colorslist1.length ~/ dataList.length * i],
            )
          : Container(),
      badgePositionPercentageOffset: .98,
    );
  });
}

class _Badge extends StatelessWidget {
  final String asset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.asset, {
    Key? key,
    required this.size,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(child: Image(image: NetworkImage(asset))),
    );
  }
}
