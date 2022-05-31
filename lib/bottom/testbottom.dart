/* import 'dart:math' as math;
import 'dart:ui';

import 'package:borgiaflutterapp/utils/dimensions.dart';
import 'package:flutter/material.dart';

double minHeight = Dimensions.height10 * 8;
double iconStartSize = Dimensions.height10 * 4.4;
double iconEndSize = Dimensions.height10 * 12;
double iconStartMarginTop = Dimensions.height10 * 3.6;
double iconEndMarginTop = Dimensions.height10 * 8;
double iconsVerticalSpacing = Dimensions.height10 * 2.4;
double iconsHorizontalSpacing = Dimensions.height10 * 1.6;

class TestBottomSheet extends StatefulWidget {
  @override
  _TestBottomSheetState createState() => _TestBottomSheetState();
}

class _TestBottomSheetState extends State<TestBottomSheet> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double get maxHeight => MediaQuery.of(context).size.height;

  double? get headerTopMargin => lerp(0, 10 + MediaQuery.of(context).padding.top);

  double? get headerFontSize => lerp(14, 24);

  double? get itemBorderRadius => lerp(8, 24);

  double? get iconLeftBorderRadius => itemBorderRadius;

  double? get iconRightBorderRadius => lerp(8, 0);

  double? get iconSize => lerp(iconStartSize, iconEndSize);

  double iconTopMargin(int index) => lerp(iconStartMarginTop, iconEndMarginTop + index * (iconsVerticalSpacing + iconEndSize))! + headerTopMargin!;

  double? iconLeftMargin(int index) => lerp(index * (iconsHorizontalSpacing + iconStartSize), 0);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
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
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: _toggle,
                      onVerticalDragUpdate: _handleDragUpdate,
                      onVerticalDragEnd: _handleDragEnd,
                      child: Positioned(
                        right: 0,
                        bottom: 240,
                        child: Icon(
                          Icons.menu,
                          color: Colors.black,
                          size: 28,
                        ),
                      ),
                    ),
                    for (Event event in events) _buildFullItem(event),
                    for (Event event in events) _buildIcon(event),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildIcon(Event event) {
    int index = events.indexOf(event);
    return Positioned(
      height: iconSize,
      width: iconSize,
      top: iconTopMargin(index),
      left: iconLeftMargin(index),
      child: ClipRRect(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(iconLeftBorderRadius!),
          right: Radius.circular(iconRightBorderRadius!),
        ),
        child: Image.asset(
          event.assetName,
          fit: BoxFit.cover,
          alignment: Alignment(lerp(1, 0)!, 0),
        ),
      ),
    );
  }

  Widget _buildFullItem(Event event) {
    int index = events.indexOf(event);
    return ExpandedEventItem(
      topMargin: iconTopMargin(index),
      leftMargin: iconLeftMargin(index)!,
      height: iconSize!,
      isVisible: _controller.status == AnimationStatus.completed,
      borderRadius: itemBorderRadius!,
      title: event.title,
      date: event.date,
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
    if (flingVelocity < 0.0)
      _controller.fling(velocity: math.max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: math.min(-2.0, -flingVelocity));
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
  }
}

class ExpandedEventItem extends StatelessWidget {
  final double topMargin;
  final double leftMargin;
  final double height;
  final bool isVisible;
  final double borderRadius;
  final String title;
  final String date;

  const ExpandedEventItem(
      {Key? key,
      required this.topMargin,
      required this.height,
      required this.isVisible,
      required this.borderRadius,
      required this.title,
      required this.date,
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
        duration: Duration(milliseconds: 200),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white,
          ),
          padding: EdgeInsets.only(left: height).add(EdgeInsets.all(8)),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: <Widget>[
        Text(title, style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        Row(
          children: <Widget>[
            Text(
              '1 ticket',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(width: 8),
            Text(
              date,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Spacer(),
        Row(
          children: <Widget>[
            Icon(Icons.place, color: Colors.grey.shade400, size: 16),
            Text(
              'Science Park 10 25A',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            )
          ],
        )s
      ],
    );
  }
}

final List<Event> events = [
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
 */