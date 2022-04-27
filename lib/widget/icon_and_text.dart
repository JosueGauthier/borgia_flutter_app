import 'package:borgiaflutterapp/widget/small_text.dart';
import 'package:flutter/cupertino.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconcolor;
  const IconAndTextWidget({Key? key, required this.icon, required this.text, required this.iconcolor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconcolor,
        ),
        const SizedBox(
          width: 5,
        ),
        SmallText(
          text: text,
        )
      ],
    );
  }
}
