import 'dart:io';
import 'package:borgiaflutterapp/utils/dimensions.dart';
import 'package:flutter/material.dart';

class FlickerText extends StatefulWidget {
  final Color color;
  final String text;
  final bool shouldFlicker;
  const FlickerText({Key? key, required this.color, required this.text, required this.shouldFlicker}) : super(key: key);
  @override
  _FlickerTextState createState() => _FlickerTextState();
}

class _FlickerTextState extends State<FlickerText> with TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _fadeInFadeOut = Tween<double>(begin: 1.0, end: 0.2).animate(animation);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        sleep(Duration(milliseconds: 500));
        animation.forward();
      }
    });
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle strokeStyle = TextStyle(
      letterSpacing: 5,
      fontSize: Dimensions.height20 * 3,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = widget.color,
      fontFamily: "RetroSignature",
    );
    TextStyle glowStyle = TextStyle(
      letterSpacing: 5,
      fontSize: Dimensions.height20 * 3,
      shadows: [
        BoxShadow(
          color: widget.color,
          blurRadius: 1.0,
          spreadRadius: 1.0,
        ),
        BoxShadow(
          color: widget.color,
          blurRadius: 30.0,
          spreadRadius: 30.0,
        ),
        BoxShadow(
          color: widget.color,
          blurRadius: 30.0,
          spreadRadius: 2.0,
        ),
        BoxShadow(
          color: widget.color,
          blurRadius: 200.0,
          spreadRadius: 200.0,
        ),
      ],
      color: Colors.white,
      fontFamily: "RetroSignature",
    );
    return widget.shouldFlicker
        ? FadeTransition(
            opacity: _fadeInFadeOut,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(widget.text, textAlign: TextAlign.center, style: strokeStyle),
                Text(widget.text, textAlign: TextAlign.center, style: glowStyle),
              ],
            ),
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              Text(widget.text, textAlign: TextAlign.center, style: strokeStyle),
              Text(widget.text, textAlign: TextAlign.center, style: glowStyle),
            ],
          );
  }
}
