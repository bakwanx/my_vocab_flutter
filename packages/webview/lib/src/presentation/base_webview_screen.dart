import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BaseWebViewScreen extends StatefulWidget {
  final String url;
  const BaseWebViewScreen({super.key, required this.url});

  @override
  State<BaseWebViewScreen> createState() => _BaseWebViewScreenState();
}

class _BaseWebViewScreenState extends State<BaseWebViewScreen> {
  late InAppWebViewController webView;
  InAppWebViewController? webViewController;
  final GlobalKey webViewKey = GlobalKey();

  final InAppWebViewGroupOptions _options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // WebViewController controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {},
    //       onWebResourceError: (WebResourceError error) {},
    //       onNavigationRequest: (NavigationRequest request) {
    //         // if (request.url.startsWith('https://www.youtube.com/')) {
    //         //   return NavigationDecision.prevent;
    //         // }
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   )
    //   ..loadRequest(Uri.parse(url));
    return SafeArea(child: InAppWebView(
      initialUrlRequest: URLRequest(
          url: Uri.parse(widget.url)),
      initialOptions: _options,
      pullToRefreshController: pullToRefreshController,
      onWebViewCreated: (controller) {
        webViewController = controller;
      },
      onLoadStart: (controller, url) {
        setState(() {
          this.url = url.toString();
          urlController.text = this.widget.url;
        });
      },
      androidOnPermissionRequest:
          (controller, origin, resources) async {
        return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT);
      },
      shouldOverrideUrlLoading:
          (controller, navigationAction) async {
        // var uri = navigationAction.request.url!;

        return NavigationActionPolicy.ALLOW;
      },
      onLoadStop: (controller, url) async {
        pullToRefreshController.endRefreshing();
        setState(() {
          this.url = url.toString();
          urlController.text = this.widget.url;
        });
      },
      onLoadError: (controller, url, code, message) {
        pullToRefreshController.endRefreshing();
      },
      onProgressChanged: (controller, progress) {
        if (progress == 100) {
          pullToRefreshController.endRefreshing();
        }
        setState(() {
          this.progress = progress / 100;
          urlController.text = this.widget.url;
        });
      },
      onUpdateVisitedHistory: (controller, url, androidIsReload) {
        setState(() {
          this.url = url.toString();
          urlController.text = this.widget.url;
        });
      },
      onConsoleMessage: (controller, consoleMessage) {
        print(consoleMessage);
      },
    ),);
  }
}
