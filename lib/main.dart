import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('YouTub Website'),
          ),
          body: WebView(
            initialUrl: "https://www.youtube.com/",
            onWebViewCreated: (controller) => _controller.complete(controller),
          ),
          bottomNavigationBar: Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20),
              child: ButtonBar(
                children: [
                  navigationButton(
                      Icons.chevron_left, (controller) => _goBack(controller)),
                  navigationButton(Icons.chevron_right,
                          (controller) => _goForward(controller))
                ],
              ),
            ),
          )),
    );
  }

  Widget navigationButton(
      IconData icon, Function(WebViewController) onPressed) {
    return FutureBuilder(
        future: _controller.future,
        builder: (context, AsyncSnapshot<WebViewController> snapshot) {
          if (snapshot.hasData) {
            return IconButton(
                icon: Icon(
                  icon,
                  color: Colors.white,
                ),
                onPressed: () => onPressed(snapshot.data));
          } else {
            return Container();
          }
        });
  }

  void _goBack(WebViewController controller) async {
    final canGoBack = await controller.canGoBack();

    if (canGoBack) {
      controller.goBack();
    }
  }

  void _goForward(WebViewController controller) async {
    final canGoForward = await controller.canGoForward();

    if (canGoForward) {
      controller.goForward();
    }
  }
}