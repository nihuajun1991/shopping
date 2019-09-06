import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shopping/view/loading_dialog.dart';
//import 'package:webview_flutter/webview_flutter.dart';

class WebViewPager extends StatefulWidget {
  final String url;

  const WebViewPager({Key key, this.url}) : super(key: key);

  @override
  _WebViewPagerState createState() => _WebViewPagerState();
}

class _WebViewPagerState extends State<WebViewPager>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  bool _loading = true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FlutterStatusbarcolor.setStatusBarColor(Colors.white);
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }

    print("status:{$state}");
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    super.initState();
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    WidgetsBinding.instance.addObserver(this);
    //changeStatusColor(Colors.transparent);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget _showWebView(BuildContext context) {
    if (_loading) {
      return LoadDialog(
        text: '加载中',
      );
    } else {
      return Text('111');
      // return WebView(
      //   initialUrl: widget.url,

      //   ///初始化url
      //   javascriptMode: JavascriptMode.unrestricted,

      //   ///JS执行模式
      //   onWebViewCreated: (WebViewController webViewController) {
      //     ///在WebView创建完成后调用，只会被调用一次
      //   },

      //   onPageFinished: (String url) {
      //     ///页面加载完成回调
      //     setState(() {
      //       _loading = false;
      //     });
      //     print('Page finished loading: $url');
      //   },
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: _showWebView(context),
    );
  }
}
