import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:flutter/cupertino.dart';

class DonutChart extends StatelessWidget {
  Map mapOccurenceVenteShop;

  late List<ChartData> listChartData = mapToListChart(mapOccurenceVenteShop);

  List<ChartData> mapToListChart(Map mapOccurenceVenteShop) {
    List<ChartData> listChartData = [];

    for (var i = 0; i < mapOccurenceVenteShop.length; i++) {
      listChartData.add(ChartData(mapOccurenceVenteShop.keys.elementAt(i).toString(), mapOccurenceVenteShop.values.elementAt(i)));

      //_saleList.add(SaleListModel.fromJson(responseBody[i]));
    }

    return listChartData;
  }

/*   ChartData('David', 25),
    ChartData(
      'Steve',
      38,
    ),
    ChartData(
      'Jack',
      34,
    ),
    ChartData(
      'Others',
      52,
    ) */

  TooltipBehavior _tooltip = TooltipBehavior(enable: true);

  DonutChart({Key? key, required this.mapOccurenceVenteShop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //List<ChartData> listChartData = mapToListChart(mapOccurenceVenteShop);

    return Container(
        child: Center(
            child: Container(
      child: SfCircularChart(legend: Legend(isVisible: true), series: <CircularSeries>[
        // Renders doughnut chart
        DoughnutSeries<ChartData, String>(
            //onPointTap: (pointInteractionDetails) {},
            dataSource: listChartData,
            //pointColorMapper: (ChartData data, _) => data.color,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            explode: true,
            dataLabelSettings: DataLabelSettings(isVisible: true))
      ]),
    )));
  }
}

class ChartData {
  ChartData(
    this.x,
    this.y,
    /* this.color */
  );
  final String x;
  final int y;
  //final Color color;
}
