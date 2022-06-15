import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/dimensions.dart';

class CustomHeader extends StatelessWidget {
  final String text;
  const CustomHeader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height45 * 2.7,
      margin: EdgeInsets.only(bottom: Dimensions.height10),
      padding: EdgeInsets.only(bottom: Dimensions.height10 / 2, top: Dimensions.height30 * 1.3, left: Dimensions.width20, right: Dimensions.width20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SizedBox(
                    width: Dimensions.width15 * 4,
                    height: Dimensions.width15 * 4,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )),
            ],
          ),
          Container(
            padding: EdgeInsets.only(right: Dimensions.width20),
            child: Text(text, style: Theme.of(context).textTheme.headlineMedium),
          ),
        ],
      ),
    );
  }
}
