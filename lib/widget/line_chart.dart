import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

class LineChartWidget extends StatelessWidget {
  LineChartWidget({Key? key}) : super(key: key);

  // Generate some dummy data for the cahrt
  // This will be used to draw the red line
  final List<FlSpot> dummyData1 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.maxFinite,
      height: 400,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            //bottomTitles: AxisTitles(axisNameSize: 200),
            topTitles: AxisTitles(),
            rightTitles: AxisTitles(),
            //show: false,
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          backgroundColor: Colors.white,
          lineBarsData: [
            // The red line
            LineChartBarData(
              spots: dummyData1,
              isCurved: true,
              barWidth: 3,
              color: Colors.purpleAccent,
            ),
          ],
        ),
      ),
    );
  }
}
