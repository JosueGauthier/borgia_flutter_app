import 'package:borgiaflutterapp/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../widget/neon_widget.dart';

class NeonPage extends StatelessWidget {
  const NeonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: Colors.black,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/V2Khalvin.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: Dimensions.height100 * 0.8,
              left: Dimensions.width10,
              child: const FlickerText(
                color: Colors.purple,
                shouldFlicker: true,
                text: 'Made by Khalvin',
              ),
            ),
            Positioned(
              top: Dimensions.height100 * 1.3,
              left: Dimensions.width10 * 10 * 2.5,
              child: const FlickerText(
                color: Colors.purple,
                shouldFlicker: true,
                text: '73-16',
              ),
            ),
            Positioned(
              top: Dimensions.height100 * 1.8,
              left: Dimensions.width10 * 10 * 2,
              child: const FlickerText(
                color: Colors.purple,
                shouldFlicker: true,
                text: 'An 220',
              ),
            ),
            Positioned(
              top: Dimensions.height100 * 3.5,
              left: Dimensions.width10 * 2,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getInitial());
                },
                child: const FlickerText(
                  color: Colors.purple,
                  shouldFlicker: true,
                  text: '←',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
