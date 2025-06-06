import 'package:flutter/foundation.dart' show kIsWeb;
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
  double _loadingProgress = 0.0;

  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      _controller = WebViewController()
        ..setBackgroundColor(const Color(0x00000000))
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              setState(() {
                _loadingProgress = progress / 100.0;
              });
            },
            onPageStarted: (String url) {
              setState(() => _loadingProgress = 0.0);
            },
            onPageFinished: (String url) {
              setState(() => _loadingProgress = 1.0);
            },
            onWebResourceError: (WebResourceError error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error loading page: ${error.description}'),
                ),
              );
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.articleUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.articleTitle ?? 'Article'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: !kIsWeb
          ? FloatingActionButton(
              onPressed: () => _controller.reload(),
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              child: const Icon(Icons.refresh),
            )
          : null,
      body: kIsWeb
          ? const Center(
              child: Text(
                'WebView is not supported on Web.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Stack(
              children: [
                WebViewWidget(controller: _controller),
                if (_loadingProgress < 1.0)
                  LinearProgressIndicator(
                    value: _loadingProgress,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.teal),
                  ),
              ],
            ),
    );
  }
}
