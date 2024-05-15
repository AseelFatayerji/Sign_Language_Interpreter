import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TranslationPage extends StatefulWidget {
  const TranslationPage({super.key});

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  final WebViewController _controller = WebViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: WebViewWidget(controller: _controller,)
      ),
    );
  }
}
