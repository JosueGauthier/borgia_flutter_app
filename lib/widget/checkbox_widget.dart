import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:borgiaflutterapp/utils/dimensions.dart';
import 'package:flutter/material.dart';

import 'big_text.dart';

class CheckBoxWidget extends StatefulWidget {
  final Color backgroundcolor;
  final String text;
  final Color iconcolor;
  final Color textColor;
  final bool isEditable;
  final double radius;
  bool isChecked;

  CheckBoxWidget(
      {Key? key,
      required this.textColor,
      required this.backgroundcolor,
      required this.text,
      required this.iconcolor,
      this.isEditable = true,
      this.radius = 50,
      required this.isChecked})
      : super(key: key);

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
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
              Container(
                child: Checkbox(
                  checkColor: Colors.white,
                  //fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: widget.isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      widget.isChecked = value!;
                    });
                  },
                ),
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
          widget.isEditable == true
              ? const Icon(
                  Icons.edit,
                  color: AppColors.titleColor,
                )
              : Container(),
        ],
      ),
    );
  }
}
