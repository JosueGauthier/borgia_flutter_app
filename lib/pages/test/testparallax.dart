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
              children: const <Widget>[
                SizedBox(height: 8),
                Header(),
                SizedBox(height: 40),
                //Tabs(),
                SizedBox(height: 8),
                //SlidingCardsView(),
              ],
            ),
          ),
          const ExhibitionBottomSheet(), //use this or ScrollableExhibitionSheet
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
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
