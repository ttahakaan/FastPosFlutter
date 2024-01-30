import 'package:fastposapplication/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Ekrann yatay durma ile sabitli. sağ ve sol yatayda kullanıma izin verilmesi komutu. Emulatorum küçük olduğundan kapattım şuan.
    /// ////////////////////////////
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);
    /////////////////////////////////////
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white24,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
        ),
      ),
      home: SplashScreen(), // SplashScreen'ı başlangıç ekranı olarak belirle
    );
  }
}

class FastPosWebView extends StatefulWidget {
  const FastPosWebView({Key? key, required this.controller}) : super(key: key);

  final WebViewController controller;

  @override
  State<FastPosWebView> createState() => _FastPosWebViewState();
}

class _FastPosWebViewState extends State<FastPosWebView> {
  var loadingPercentage = 0;
  bool isWakelockEnabled = true;

  @override
  void initState() {
    super.initState();
    widget.controller
      ..setNavigationDelegate(NavigationDelegate(onPageStarted: (url) {
        setState(() {
          loadingPercentage = 0;
        });
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
            value: loadingPercentage / 100.0,
          ),
        // Eklenen Footer Bar
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Color(
                0xFF5271FF), // İstediğiniz arkaplan rengini ayarlayabilirsiniz
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () async {
                          final messenger = ScaffoldMessenger.of(context);
                          if (await widget.controller.canGoBack()) {
                            await widget.controller.goBack();
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("FastPos"),
                                  content: Text(
                                      "Are you sure you want to exit the FastPos App?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text("No"),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: Text("Yes"),
                                    ),
                                  ],
                                );
                              },
                            ).then((exit) {
                              if (exit != null && exit) {
                                SystemNavigator.pop();
                              } else {
                                messenger.showSnackBar(
                                  SnackBar(
                                      content: Text("No Back History Found")),
                                );
                              }
                            });
                          }
                        },
                        color: Colors.white,
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () async {
                          final messenger = ScaffoldMessenger.of(context);
                          if (await widget.controller.canGoForward()) {
                            await widget.controller.goForward();
                          } else {
                            messenger.showSnackBar(
                              SnackBar(
                                  content: Text("No Forward History Found")),
                            );
                            return;
                          }
                        },
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.controller.reload();
                      },
                      icon: Icon(Icons.replay),
                      color: Colors.white,
                    ),
                    IconButton(
                      onPressed: () {
                        _showWakelockSettings(context);
                      },
                      icon: Icon(Icons.settings),
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showWakelockSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Wakelock',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Checkbox(
                        value: isWakelockEnabled,
                        onChanged: (value) {
                          setState(() {
                            isWakelockEnabled = value ?? false;
                            if (value!) {
                              Wakelock.enable();
                            } else {
                              Wakelock.disable();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
