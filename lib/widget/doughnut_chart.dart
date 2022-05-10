import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:borgiaflutterapp/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';

class DonutChart extends StatelessWidget {
  List<_ChartData> data = [_ChartData('CHN', 12), _ChartData('GER', 15), _ChartData('RUS', 30), _ChartData('BRZ', 6.4), _ChartData('IND', 14)];

  final List<ChartData> chartData = [
    ChartData('David', 25, Color.fromRGBO(9, 0, 136, 1)),
    ChartData('Steve', 38, Color.fromRGBO(147, 0, 119, 1)),
    ChartData('Jack', 34, Color.fromRGBO(228, 0, 124, 1)),
    ChartData('Others', 52, Color.fromRGBO(255, 189, 57, 1))
  ];

  TooltipBehavior _tooltip = TooltipBehavior(enable: true);

  DonutChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Container(
      child: SfCircularChart(legend: Legend(isVisible: true), series: <CircularSeries>[
        // Renders doughnut chart
        DoughnutSeries<ChartData, String>(
            onPointTap: (pointInteractionDetails) {
              print(pointInteractionDetails);
              inspect(pointInteractionDetails);
            },
            dataSource: chartData,
            pointColorMapper: (ChartData data, _) => data.color,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            explode: true,
            dataLabelSettings: DataLabelSettings(
                // Renders the data label
                isVisible: true))
      ]),
    )));
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
