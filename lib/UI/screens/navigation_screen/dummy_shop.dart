import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailsViewScreen extends StatefulWidget {

  const DetailsViewScreen({super.key, required this.url, required this.title});
  final String url;
  final String title;

  @override
  State<DetailsViewScreen> createState() => _DetailsViewScreenState();
}

class _DetailsViewScreenState extends State<DetailsViewScreen> {
  late WebViewController webViewController;

  @override
  void initState() {
    super.initState();

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.title,
          style: PreMedTextTheme().body1.copyWith(
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: WebViewWidget(controller: webViewController),
    );
  }
}
