import 'package:borgiaflutterapp/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  Color? color;
  String text;
  double? size = Dimensions.height30;
  final TextOverflow overFlow;
  String? fontTypo;

  BigText({Key? key, this.color = const Color(0xFF404040), required this.text, this.fontTypo = 'Nunito', this.size, this.overFlow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(color: color, fontFamily: fontTypo, fontSize: size, fontWeight: FontWeight.w400),
    );
  }
}
