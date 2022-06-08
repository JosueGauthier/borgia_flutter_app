import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double? size;
  final TextOverflow overFlow;
  final String? fontTypo;

  const BigText(
      {Key? key,
      this.color = const Color(0xFF404040),
      required this.text,
      this.fontTypo = 'Nunito-SemiBold',
      this.size = 30,
      this.overFlow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(color: color, fontFamily: fontTypo, fontSize: size),
    );
  }
}
