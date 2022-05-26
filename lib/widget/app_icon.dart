import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData iconData;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;

  const AppIcon({
    Key? key,
    required this.iconData,
    this.backgroundColor = const Color(0xFFf7f6f4),
    this.iconColor = const Color(0xFFa9a29f),
    this.size = 40,
    this.iconSize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: iconSize * 1.8,
      height: iconSize * 1.8,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(size), color: backgroundColor),
      child: Icon(
        iconData,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
