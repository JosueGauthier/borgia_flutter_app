import 'package:borgiaflutterapp/bottom/testbottom.dart';
import 'package:flutter/material.dart';

import '../../bottom/exhibition_bottom_sheet.dart';

class ParallaxPage extends StatelessWidget {
  const ParallaxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 8),
                Header(),
                SizedBox(height: 40),
                //Tabs(),
                SizedBox(height: 8),
                //SlidingCardsView(),
              ],
            ),
          ),
          ExhibitionBottomSheet(), //use this or ScrollableExhibitionSheet
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        'Shenzhen',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
