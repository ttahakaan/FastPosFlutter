import 'package:fastposapplication/view/second_web_view.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FastPosWebView extends StatefulWidget {
  const FastPosWebView({super.key, required this.controller});

  final WebViewController controller;
  @override
  State<FastPosWebView> createState() => _FastPosWebViewState();
}

class _FastPosWebViewState extends State<FastPosWebView> {
  var loadingPercentage = 0;
  @override
  void initState() {
    super.initState();
    widget.controller
      ..setNavigationDelegate(NavigationDelegate(onPageStarted: (url) {
        setState(() {
          loadingPercentage = 0;
        });
        if (url.startsWith("quickprinter://")) {
          launchUrl(Uri.parse(url)); // Opens the URL in the default browser
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondWebView()),
          );
        }
      }, onProgress: (progress) {
        setState(() {
          loadingPercentage = progress;
        });
      }, onPageFinished: (url) {
        setState(() {
          loadingPercentage = 100;
        });
      }))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel("Snackbar", onMessageReceived: (message) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message.message)));
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: widget.controller),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            color: Color(0xFF5271FF),
            value: loadingPercentage / 100.0,
          )
      ],
    );
  }
}
