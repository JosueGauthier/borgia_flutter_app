import 'package:borgiaflutterapp/utils/dimensions.dart';
import 'package:flutter/material.dart';

import 'big_text.dart';

class CheckBoxWidget extends StatefulWidget {
  final Color backgroundcolor;
  final String text;
  final Color iconcolor;
  final Color textColor;
  final double radius;
  bool isChecked;

  CheckBoxWidget(
      {Key? key,
      required this.textColor,
      required this.backgroundcolor,
      required this.text,
      required this.iconcolor,
      this.radius = 50,
      required this.isChecked})
      : super(key: key);

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool _isCheckBoxChecked = true;
  bool get isCheckBoxChecked => _isCheckBoxChecked;

  @override
  void initState() {
    _isCheckBoxChecked = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _isCheckBoxChecked = widget.isChecked;
    return Container(
      padding: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
      margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
      height: Dimensions.height45 * 1.7,
      width: double.maxFinite,
      decoration: BoxDecoration(color: widget.backgroundcolor, borderRadius: BorderRadius.all(Radius.circular(widget.radius))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                checkColor: Colors.white,
                //fillColor: MaterialStateProperty.resolveWith(getColor),
                value: _isCheckBoxChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isCheckBoxChecked = value!;
                  });
                  print(value);
                },
              ),
              SizedBox(
                width: Dimensions.width20,
              ),
              BigText(
                fontTypo: 'Helvetica-Bold',
                text: widget.text,
                size: Dimensions.height25 * 0.8,
                color: widget.textColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
