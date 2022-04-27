// ignore_for_file: file_names

/* 


import 'package:flutter/material.dart';

class MaterialStatePropertysmall_text extends StatelessWidget {
  MaterialStateProperty<Color> color;
  final String text;
  double size;
  double height;
  TextOverflow? overFlow;
  int maxLines;
  bool allowOverFlow;

  MaterialStatePropertysmall_text({
    Key? key,
    required this.color,
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
        color: Colors.grey,
        fontFamily: 'Roboto',
        fontSize: size,
        height: height,
      ),
    );
  }
}
 */