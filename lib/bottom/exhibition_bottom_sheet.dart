// ignore_for_file: sized_box_for_whitespace

import 'dart:math' as math;
import 'dart:ui';

import 'package:borgiaflutterapp/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double minHeight = Dimensions.height10;
double iconStartSize = Dimensions.height10 * 4.4;
double iconEndSize = Dimensions.height10 * 12;
double iconStartMarginTop = Dimensions.height10 * 3.6;
double iconEndMarginTop = Dimensions.height10 * 8;
double iconsVerticalSpacing = Dimensions.height10 * 2.4;
double iconsHorizontalSpacing = Dimensions.height10 * 1.6;

class ExhibitionBottomSheet extends StatefulWidget {
  const ExhibitionBottomSheet({Key? key}) : super(key: key);

  @override
  _ExhibitionBottomSheetState createState() => _ExhibitionBottomSheetState();
}

class _ExhibitionBottomSheetState extends State<ExhibitionBottomSheet> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double get maxHeight => MediaQuery.of(context).size.height - Dimensions.height20 * 10;

  double? get headerTopMargin => lerp(0, 10 + MediaQuery.of(context).padding.top);

  double? get headerFontSize => lerp(14, 24);

  double? get itemBorderRadius => lerp(8, 24);

  double? get iconLeftBorderRadius => itemBorderRadius;

  double? get iconRightBorderRadius => lerp(8, 0);

  double? get iconSize => lerp(iconStartSize, iconEndSize);

  double? iconTopMargin(int index) => lerp(index * (iconsHorizontalSpacing + iconStartSize), Dimensions.height10);

  double? iconLeftMargin(int index) => lerp(0, 0.6 * (index) * (iconsVerticalSpacing + iconEndSize))!;

  //lerp(iconStartMarginTop, iconEndMarginTop + index * (iconsVerticalSpacing + iconEndSize))! + headerTopMargin!

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double? lerp(double min, double max) => lerpDouble(min, max, _controller.value);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              height: lerp(minHeight, maxHeight),
              left: 0,
              right: 0,
              bottom: 100,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
                ),
                child: GestureDetector(
                  onTap: _toggle,
                  onVerticalDragUpdate: _handleDragUpdate,
                  onVerticalDragEnd: _handleDragEnd,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        right: 0,
                        bottom: 0,
                        //bottom: 24,
                        child: Container(
                          height: Dimensions.height20 * 3,
                          //color: Colors.greenAccent,
                          width: Dimensions.height20 * 3,
                          child: const Icon(
                            Icons.menu,
                            color: Colors.black,
                            size: 28,
                          ),
                        ),
                      ),
                      //for (BottomNavigationBarItem icon in iconList) _buildFullItem(icon),
                      for (BottomNavigationBarItem icon in iconList) _buildIcon(icon),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildIcon(BottomNavigationBarItem icon) {
    int index = iconList.indexOf(icon);
    return Stack(
      children: [
        Positioned(
          width: iconSize,
          top: iconTopMargin(index),
          left: iconLeftMargin(index),
          child: ClipRRect(
            child: iList[index],
          ),
        )
      ],
    );
  }

  void _toggle() {
    final bool isOpen = _controller.status == AnimationStatus.completed;
    _controller.fling(velocity: isOpen ? -2 : 2);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta! / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating || _controller.status == AnimationStatus.completed) return;

    final double flingVelocity = details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0.0) {
      _controller.fling(velocity: math.max(2.0, -flingVelocity));
    } else if (flingVelocity > 0.0) {
      _controller.fling(velocity: math.min(-2.0, -flingVelocity));
    } else {
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
    }
  }
}

class ExpandedEventItem extends StatelessWidget {
  final double topMargin;
  final double leftMargin;
  final double height;
  final bool isVisible;
  final double borderRadius;
  //final String title;
  //final String date;

  const ExpandedEventItem(
      {Key? key,
      required this.topMargin,
      required this.height,
      required this.isVisible,
      required this.borderRadius,
      //required this.title,
      //required this.date,
      required this.leftMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      left: leftMargin,
      right: 0,
      height: height,
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          padding: EdgeInsets.only(left: height).add(const EdgeInsets.all(8)),
          child: Container(),
        ),
      ),
    );
  }
}

final List<BottomNavigationBarItem> iconList = [
  const BottomNavigationBarItem(icon: Icon(CupertinoIcons.house_alt, size: 30), label: 'Home'),
  const BottomNavigationBarItem(icon: Icon(Icons.history, size: 30), label: 'History'),
  const BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart, size: 30), label: 'Cart'),
  const BottomNavigationBarItem(icon: Icon(Icons.perm_identity, size: 30), label: 'Me')
];

final List<Icon> iList = [
  const Icon(CupertinoIcons.house_alt, size: 30),
  const Icon(Icons.history, size: 30),
  const Icon(CupertinoIcons.heart, size: 30),
  const Icon(Icons.perm_identity, size: 30)
];

List<Event> events = [
  Event('assets/image/metzlogo.jpg', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event('assets/image/bdxlogo.png', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event('assets/image/aixlogo.png', 'Dawan District Guangdong Hong Kong', '4.28-31'),
];

class Event {
  final String assetName;
  final String title;
  final String date;

  Event(this.assetName, this.title, this.date);
}
