import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartSample2 extends StatefulWidget {
  final List<FlSpot>? listeDesVentes;
  const LineChartSample2({Key? key, required this.listeDesVentes}) : super(key: key);

  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: LineChart(
            mainData(widget.listeDesVentes),
          ),
        ),
      ],
    );
  }

  LineChartData mainData(List<FlSpot>? listeDesVentes) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),

      //borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      //minX: 0,
      //maxX: 11,
      //minY: 0,
      //maxY: 6,
      lineBarsData: [
        LineChartBarData(
          //spots: listeDesVentes,

          /*  spots: [
            FlSpot(1651356000000.0, 17.4),
            FlSpot(1651442400000.0, 7.5),
            FlSpot(1651528800000.0, 0.0),
          ], */

          /* spots: const [
            FlSpot(1356000000000.0, 17.4),
            FlSpot(1442400000000.0, 7.5),
            FlSpot(1528800000000.0, 0.0),
            FlSpot(1615200000000.0, 0.0),
            FlSpot(1701600000000.0, 0.0),
            FlSpot(1788000000000.0, 3.0),
            FlSpot(1874400000000.0, 0.0),
            FlSpot(1960800000000.0, 11.0),
            FlSpot(2047200000000.0, 0.0),
            FlSpot(2133600000000.0, 0.0),
            FlSpot(2220000000000.0, 1.0),
            FlSpot(2306400000000.0, 15.0),
            FlSpot(2392800000000.0, 0.0),
            FlSpot(2479200000000.0, 0.0),
            FlSpot(2565600000000.0, 0.0),
            FlSpot(2652000000000.0, 0.0),
          ], */

          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }
}
