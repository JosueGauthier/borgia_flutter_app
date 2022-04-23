import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialStatePropertysmall_text extends StatelessWidget {
  MaterialStateProperty<Color> color;
  final String text;
  double size;
  double height;
  TextOverflow? overFlow;
  var maxLines;
  bool allowOverFlow;

  MaterialStatePropertysmall_text({
    Key? key,
    required this.color,
    required this.text,
    this.size = 12,
    this.height = 1.2,
    this.overFlow = TextOverflow.ellipsis,
    this.maxLines = null,
    this.allowOverFlow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: allowOverFlow == false ? null : maxLines,
      overflow: allowOverFlow == false ? null : overFlow,
      style: TextStyle(
        color: Colors.grey,
        fontFamily: 'Roboto',
        fontSize: size,
        height: height,
      ),
    );
  }
}
