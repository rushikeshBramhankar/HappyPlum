import 'package:flutter/material.dart';
import 'package:happy_plum/splash.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()));

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // Set up WebView parameters
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.happy-plum.com/'))
          .then((value) async {
        await controller.enableZoom(false);
      });

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;

    // Check login status when app starts
    _checkLoginStatus();
  }

  // Method to check if the user is logged in
  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('login_token');

    if (token != null) {
      // User is logged in, load the dashboard or home page
      _controller
          .loadRequest(Uri.parse('https://www.happy-plum.com/dashboard'));
    } else {
      // User is not logged in, load the login page
      _controller.loadRequest(Uri.parse('https://www.happy-plum.com/login'));
    }
  }

  // Method to save the login token (you will call this from JavaScript or after a successful login in your WebView)
  Future<void> _saveLoginToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('login_token', token);
  }

  // Method to clear the login token when the user logs out
  Future<void> _clearLoginToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('login_token');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: WebViewWidget(controller: _controller),
            );
          },
        ),
      ),
    );
  }
}
