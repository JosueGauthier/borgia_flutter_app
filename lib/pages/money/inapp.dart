/* import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWebViewPage extends StatefulWidget {
  @override
  _InAppWebViewPageState createState() => new _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPage> {
  late InAppWebViewController webView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("InAppWebView")
        ),
        body: Container(
            child: Column(children: <Widget>[
              Expanded(
                child: Container(
                  child: InAppWebView(
                    initialUrl: "https://m.bilibili.com/video/av57346110.html",
                    initialHeaders: {},
                    initialOptions: InAppWebViewWidgetOptions(
                        inAppWebViewOptions: InAppWebViewOptions(
                          userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36",
                          debuggingEnabled: true,
                        ),
                      androidInAppWebViewOptions: AndroidInAppWebViewOptions(
                        initialScale: 100
                      )
                    ),
                    onWebViewCreated: (InAppWebViewController controller) {
                      webView = controller;
                    },
                    onLoadStart: (InAppWebViewController controller, String url) {

                    },
                    onLoadStop: (InAppWebViewController controller, String url) {

                    },
                  ),
                ),
              ),
            ]))
    );
  }
} */