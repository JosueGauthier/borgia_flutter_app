import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../big_text.dart';

class CustomCircularIndicator extends StatelessWidget {
  final String text;
  final Color progressColor;
  final double percent;

  const CustomCircularIndicator({
    Key? key,
    required this.text,
    required this.progressColor,
    required this.percent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: Dimensions.height20 * 3,
      lineWidth: Dimensions.width5 * 2,
      backgroundColor: AppColors.whiteGreyColor,
      animation: true,
      animationDuration: 1200,
      circularStrokeCap: CircularStrokeCap.round,
      percent: percent,
      center: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      progressColor: progressColor,
      //linearGradient: LinearGradient(colors: [ListStatColors.colorslist1[0], ListStatColors.colorslist1[20]]),
      //rotateLinearGradient: true,
    );
  }
}
