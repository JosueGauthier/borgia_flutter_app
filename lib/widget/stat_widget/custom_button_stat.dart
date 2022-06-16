import 'package:borgiaflutterapp/pages/stats/global_stat_page.dart';
import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../pages/stats/personal_stat_page.dart';

class CustomButtonStat extends StatefulWidget {
  final Function() notifyParent;
  final Color foregroundColor;
  final Color buttonColor;
  final String text;
  final IconData? iconData;
  final Size size;
  final int id;

  const CustomButtonStat({
    Key? key,
    required this.notifyParent,
    this.foregroundColor = Colors.white,
    this.text = "qty",
    this.iconData,
    required this.size,
    this.buttonColor = AppColors.mainColor,
    required this.id,
  }) : super(key: key);

  @override
  State<CustomButtonStat> createState() => _CustomButtonStatState();
}

class _CustomButtonStatState extends State<CustomButtonStat> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(widget.buttonColor),
        foregroundColor: MaterialStateProperty.all<Color>(widget.foregroundColor),
        fixedSize: MaterialStateProperty.all<Size>(widget.size),
      ),
      onPressed: () {
        setState(() {
          widget.notifyParent();
          changeGraphState(widget.id);
          changeGraphStateGlobal(widget.id);
        });
      },
      child: (widget.iconData == null)
          ? Text(
              "qty",
              style: TextStyle(color: Theme.of(context).colorScheme.surface, fontFamily: 'Montserrat-Bold', fontSize: 18),
            )
          : Icon(
              widget.iconData,
              color: widget.foregroundColor,
              size: widget.size.height / 1.5,
            ),
    );
  }
}
