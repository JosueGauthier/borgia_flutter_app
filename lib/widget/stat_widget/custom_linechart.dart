import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class CustomLineChartWidget extends StatelessWidget {
  final List<Map<String, Object>> listeDesVentes;
  final Color linecolor;
  final Color areacolor;
  final int numberXTickCount;

  const CustomLineChartWidget({
    Key? key,
    required this.listeDesVentes,
    this.linecolor = AppColors.mainColor,
    this.areacolor = AppColors.mainColor,
    this.numberXTickCount = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: Dimensions.height30 * 10,
      child: Chart(
        data: listeDesVentes,
        variables: {
          'Date': Variable(
            accessor: (Map map) => map['Date'] as String,
            scale: OrdinalScale(tickCount: numberXTickCount),
          ),
          'Sale': Variable(
            accessor: (Map map) => (map['Sale'] ?? double.nan) as num,
          ),
        },
        elements: [
          AreaElement(
            shape: ShapeAttr(value: BasicAreaShape(smooth: true)),
            color: ColorAttr(value: areacolor), //.withAlpha(80)
          ),
          LineElement(
            color: ColorAttr(value: linecolor),
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
    );
  }
}
