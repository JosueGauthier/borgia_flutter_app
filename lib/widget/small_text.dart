import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  final TextOverflow? overFlow;
  final int maxLines;
  final bool allowOverFlow;

  const SmallText({
    Key? key,
    this.color = const Color(0xFFccc7c5),
    required this.text,
    this.size = 12,
    this.height = 1.2,
    this.overFlow = TextOverflow.ellipsis,
    this.maxLines = 1,
    this.allowOverFlow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: allowOverFlow == false ? null : maxLines,
      overflow: allowOverFlow == false ? null : overFlow,
      style: TextStyle(
        color: color,
        fontFamily: 'Roboto',
        fontSize: size,
        height: height,
      ),
    );
  }
}
