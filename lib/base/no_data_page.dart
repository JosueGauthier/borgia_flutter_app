import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String impgPath;
  const NoDataPage({Key? key, required this.text, this.impgPath = "assets/image/empty_cart.png"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(impgPath, height: MediaQuery.of(context).size.height * 0.22, width: MediaQuery.of(context).size.width * 0.22),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.03,
            color: Theme.of(context).disabledColor,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
