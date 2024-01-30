import 'package:fastposapplication/view/fastpos_web_view.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // Cihaz temasına göre otomatik ayarla
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light, // Varsayılan tema ayarları
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white24, // Varsayılan app bar rengi
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark, // Koyu tema ayarları
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900, // Koyu tema app bar rengi
        ),
      ),
      title: 'Material App',
      home: WebViewApp(),
    );
  }
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse("https://fastpos.ai"),
      );
  }

  @override
  Widget build(BuildContext context) {
    // Brightness currentBrightness = Theme.of(context).brightness;  bu kodu app bar için yaptım eğer istenirse kullanılabilir.

    return Scaffold(
      //APP BAR KODLARI DİREKT BURAYA GELECEK (İSTEĞE BAĞLI)
      body: SafeArea(
        child: FastPosWebView(controller: controller),
      ),
    );
  }
}
