import 'package:ammanauto/app_config.dart';
import 'package:ammanauto/helpers/shared_value_helper.dart';
import 'package:ammanauto/my_theme.dart';
import 'package:ammanauto/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ConfirmPayment extends StatefulWidget {
  final String url;

  ConfirmPayment({required this.url});

  @override
  _ConfirmPaymentState createState() => _ConfirmPaymentState();
}

class _ConfirmPaymentState extends State<ConfirmPayment> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleUrlChanged(String url) {
    String currentUrl;
    _controller.currentUrl().then((url) {
      currentUrl = url!;
      debugPrint('${currentUrl} ${AppConfig.RAW_BASE_URL}');
      if (currentUrl.startsWith(AppConfig.RAW_BASE_URL)) {
        // Perform actions when the URL starts with the base URL
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Payment'),
        backgroundColor: MyTheme.accent_color,
      ),
      body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            _handleUrlChanged(request.url);
            return NavigationDecision.navigate;
          },
          onWebViewCreated: (WebViewController controller) {
            _controller = controller;
          },
          onPageFinished: (String url) {
            _controller.currentUrl().then((currentUrl) {
              debugPrint('$currentUrl');
              if (currentUrl!.startsWith(AppConfig.RAW_BASE_URL)) {
                  has_subscription.$=true;
                  has_subscription.save();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Main();
                }));
                debugPrint('${currentUrl} ${AppConfig.RAW_BASE_URL}');
              }
            });
          }),
    );
  }
}
