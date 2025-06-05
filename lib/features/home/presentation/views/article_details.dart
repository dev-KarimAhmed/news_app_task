import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailsView extends StatefulWidget {
  const ArticleDetailsView({
    super.key,
    required this.articleUrl,
    this.articleTitle,
  });
  final String articleUrl;
  final String? articleTitle;

  @override
  State<ArticleDetailsView> createState() => _ArticleDetailsViewState();
}

class _ArticleDetailsViewState extends State<ArticleDetailsView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setBackgroundColor(const Color(0x00000000))
          ..loadRequest(Uri.parse(widget.articleUrl))
          ..setJavaScriptMode(
            JavaScriptMode.unrestricted,
          ); // Replace with the actual URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.articleTitle ?? 'Article'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _controller.reload(),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,

        child: const Icon(Icons.refresh),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
