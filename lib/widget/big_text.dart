import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overFlow;

  const BigText({Key? key, this.color = const Color(0xFF5c524f), required this.text, this.size = 28, this.overFlow = TextOverflow.ellipsis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(color: color, fontFamily: 'Roboto', fontSize: size, fontWeight: FontWeight.w400),
    );
  }
}
