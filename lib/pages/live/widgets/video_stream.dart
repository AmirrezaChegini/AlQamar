import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoStream extends StatefulWidget {
  const VideoStream({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<VideoStream> createState() => _VideoStreamState();
}

class _VideoStreamState extends State<VideoStream> {
  late final WebViewController _webCtrl;

  @override
  void initState() {
    super.initState();

    _webCtrl = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(true)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: WebViewWidget(
        controller: _webCtrl,
      ),
    );
  }
}
