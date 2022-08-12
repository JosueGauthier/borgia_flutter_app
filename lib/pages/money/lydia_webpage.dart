import 'package:borgiaflutterapp/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dart:io';

class LydiaWebPage extends StatefulWidget {
  final String lydiaUrl;

  const LydiaWebPage({Key? key, required this.lydiaUrl}) : super(key: key);

  @override
  State<LydiaWebPage> createState() => _LydiaWebPageState();
}

class _LydiaWebPageState extends State<LydiaWebPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: Dimensions.height20 * 2,
          ),
          Expanded(
              child: WebView(
            initialUrl: widget.lydiaUrl,
            //javascriptMode: JavascriptMode.unrestricted,

            javascriptMode: JavascriptMode.unrestricted,
          )),
        ],
      ),
    );
  }
}
