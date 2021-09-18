import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthWebViewScreen extends StatefulWidget {
  const AuthWebViewScreen({Key? key}) : super(key: key);

  @override
  _AuthWebViewScreenState createState() => _AuthWebViewScreenState();
}

class _AuthWebViewScreenState extends State<AuthWebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://app.sievesapp.com',
      javascriptMode: JavascriptMode.unrestricted,
      gestureRecognizers: Set()
        ..add(Factory<VerticalDragGestureRecognizer>(
            () => VerticalDragGestureRecognizer())),
    );
  }
}

