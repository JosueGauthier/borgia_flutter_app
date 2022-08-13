import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height100,
      width: Dimensions.width10 * 10,
      child: const LoadingIndicator(
          indicatorType: Indicator.pacman,

          /// Required, The loading type of the widget
          colors: [
            AppColors.mainColor,
            Colors.yellow,
            Colors.yellow,
          ],

          /// Optional, The color collections
          strokeWidth: 2,

          /// Optional, The stroke of the line, only applicable to widget which contains line
          backgroundColor: Colors.transparent,

          /// Optional, Background of the widget
          pathBackgroundColor: Colors.black

          /// Optional, the stroke backgroundColor
          ),
    );
  }
}
