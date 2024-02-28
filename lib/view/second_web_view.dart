import 'package:fastposapplication/main.dart';
import 'package:fastposapplication/view/fastpos_web_view.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondWebView extends StatefulWidget {
  const SecondWebView({Key? key}) : super(key: key);

  @override
  State<SecondWebView> createState() => _SecondWebViewState();
}

class _SecondWebViewState extends State<SecondWebView> {
  late final WebViewController _controller;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _loadWebView();
  }

  Future<void> _loadWebView() async {
    await Future.delayed(Duration(
        seconds:
            1)); // zaten bir sonraki adımda yüklenme durum kontrolü yapıldığı için burada 2 saniye isim görünülürlüğü açısından bekletiyorum.

    setState(() {
      _isLoading = false;
    });

    _controller.loadRequest(Uri.parse("https://fastpos.vercel.app"));
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            backgroundColor: Color.fromARGB(255, 255, 255,
                255), // arkaplan rengini logonun rengiyle aynı yaptım.
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  TweenAnimationBuilder(
                    duration: Duration(seconds: 1),
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: child,
                      );
                    },
                    child: Text(
                      "Printing",
                      style: GoogleFonts.libreFranklin(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: FastPosWebView(controller: _controller),
            ),
          );
  }
}
