// ignore_for_file: unused_import

import 'package:borgiaflutterapp/widget/small_text.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text.dart';

class SliderBottomSectionWidget extends StatelessWidget {
  final String titletext;

  const SliderBottomSectionWidget({Key? key, required this.titletext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BigText(
          text: titletext,
          size: Dimensions.height30,
        ),
      ],
    );
  }
}
